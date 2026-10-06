<?php

require_once __DIR__ . '/../_support/Helper/TestDatabase.php';

use Helper\TestDatabase;

/**
 * AI token budget: registration allowance, status, charging
 * (see LESSON_ASSISTANT_PLAN.md, Stage 8, and TOKEN_PURCHASE_PLAN.md). Runs against the test database from
 * tests/.env.testing and is skipped when it isn't configured.
 */
class TokenQuotaUnitTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    private const ENV = [
        'LLM_FREE_TOKENS'            => 30000,
        'LLM_MIN_TOKENS_PER_REQUEST' => 3000,
    ];

    private PDO $dbh;

    protected function _before()
    {
        $dbh = TestDatabase::connect();
        if (!$dbh instanceof PDO) {
            $this->markTestSkipped($dbh);
        }
        $this->dbh = $dbh;
        TestDatabase::resetSchema($this->dbh);
    }

    // Registration

    public function testRegisterStartsWithFreeAllowance()
    {
        $user = new User($this->dbh, self::ENV);
        $user->register('new@example.com', 'password123', 'New User');

        $this->assertSame(50000, $this->balance($user->getId()));
    }

    public function testOauthSignupStartsWithFreeAllowanceAndReturningLoginKeepsBalance()
    {
        $user = $this->oauthLogin('someone@github');
        $this->assertSame(50000, $this->balance($user->getId()));

        $this->setBalance($user->getId(), 1234);
        $returning = $this->oauthLogin('someone@github');

        $this->assertSame($user->getId(), $returning->getId());
        $this->assertSame(1234, $this->balance($user->getId()));
    }

    public function testLoginSessionWorksWithoutSubscriptionColumns()
    {
        $userId = $this->createUser();

        $this->assertSame($userId, $this->loggedIn($userId)->getId());
    }

    // Balance

    public function testBalanceNeverExpires()
    {
        $userId = $this->createUser(balance: 1400000);

        $this->assertSame(1400000, $this->quota($userId)->remaining());
        $this->assertSame(1400000, $this->balance($userId));
    }

    // Status for the UI

    public function testStatusShowsRemainingBalance()
    {
        $status = $this->quota($this->createUser(balance: 1234567))->status();

        $this->assertSame(['remaining' => 1234567, 'remaining_text' => "1\u{00A0}234\u{00A0}567", 'exhausted' => false, 'low' => false], $status);
    }

    public function testNegativeBalanceShowsAsZeroAndExhausted()
    {
        $status = $this->quota($this->createUser(balance: -500))->status();

        $this->assertSame(0, $status['remaining']);
        $this->assertSame('0', $status['remaining_text']);
        $this->assertTrue($status['exhausted']);
        $this->assertTrue($status['low']);
    }

    public function testFormatTokensGroupsThousands()
    {
        $this->assertSame('999', TokenQuota::formatTokens(999));
        $this->assertSame("50\u{00A0}000", TokenQuota::formatTokens(50000));
        $this->assertSame("1\u{00A0}000\u{00A0}000", TokenQuota::formatTokens(1000000));
    }

    // Spending

    public function testCanSpendThreshold()
    {
        $this->assertTrue($this->quota($this->createUser(balance: 3000))->canSpend());
        $this->assertFalse($this->quota($this->createUser(balance: 2999))->canSpend());
    }

    public function testChargeDecrementsBalanceAndLogsUsage()
    {
        $userId = $this->createUser(balance: 10000);

        $this->quota($userId)->charge('free_answer', 42, 'openai-gpt-4o-mini', ['prompt' => 700, 'completion' => 300, 'total' => 1000]);

        $this->assertSame(9000, $this->balance($userId));
        $log = $this->dbh->query('SELECT user_id, feature, ref_id, llm_profile, prompt_tokens, completion_tokens FROM tokens_usage_log')->fetchAll(PDO::FETCH_ASSOC);
        $this->assertSame([[
            'user_id' => $userId, 'feature' => 'free_answer', 'ref_id' => 42,
            'llm_profile' => 'openai-gpt-4o-mini', 'prompt_tokens' => 700, 'completion_tokens' => 300,
        ]], $log);
    }

    public function testChargeWithoutUsageChangesNothing()
    {
        $userId = $this->createUser(balance: 10000);

        $this->quota($userId)->charge('lesson_assistant', 1, 'openai-gpt-4o-mini', null);

        $this->assertSame(10000, $this->balance($userId));
        $this->assertSame(0, (int)$this->dbh->query('SELECT COUNT(*) FROM tokens_usage_log')->fetchColumn());
    }

    public function testConcurrentChargesBothDecrement()
    {
        $userId = $this->createUser(balance: 10000);
        // Both requests read the balance before either one charges
        $first = $this->quota($userId);
        $second = $this->quota($userId);
        $first->canSpend();
        $second->canSpend();

        $first->charge('lesson_assistant', 1, 'p', ['prompt' => 0, 'completion' => 0, 'total' => 4000]);
        $second->charge('free_answer', 2, 'p', ['prompt' => 0, 'completion' => 0, 'total' => 5000]);

        $this->assertSame(1000, $this->balance($userId));
    }

    public function testChargeMayOvershootIntoNegative()
    {
        $userId = $this->createUser(balance: 3000);
        $quota = $this->quota($userId);
        $this->assertTrue($quota->canSpend());

        $quota->charge('lesson_assistant', 1, 'p', ['prompt' => 0, 'completion' => 0, 'total' => 3500]);

        $this->assertSame(-500, $this->balance($userId));
        $this->assertSame(0, $quota->remaining());
    }

    // Usage for the profile

    public function testUsageGroupsByDayAndFeatureWithinThePeriod()
    {
        $userId = $this->createUser();
        $other = $this->createUser();
        $today = (new DateTimeImmutable('today'))->format('Y-m-d');
        $yesterday = (new DateTimeImmutable('yesterday'))->format('Y-m-d');
        $this->logUsage($userId, 'lesson_assistant', 1000, 500, "{$today} 10:00");
        $this->logUsage($userId, 'lesson_assistant', 2000, 500, "{$today} 11:00");
        $this->logUsage($userId, 'free_answer', 700, 300, "{$today} 12:00");
        $this->logUsage($userId, 'free_answer', 900, 100, "{$yesterday} 09:00");
        // 29 days ago is the first day of a 30-day period; 30 days ago is outside it
        $this->logUsage($userId, 'lesson_assistant', 100, 0, (new DateTimeImmutable('-29 days'))->format('Y-m-d') . ' 00:00');
        $this->logUsage($userId, 'lesson_assistant', 5000, 0, (new DateTimeImmutable('-30 days'))->format('Y-m-d') . ' 23:59');
        $this->logUsage($other, 'lesson_assistant', 9999, 0, "{$today} 10:00");

        $usage = $this->quota($userId)->usage(30);

        $this->assertSame([
            ['day' => $today, 'feature' => 'free_answer', 'requests' => 1, 'tokens' => 1000],
            ['day' => $today, 'feature' => 'lesson_assistant', 'requests' => 2, 'tokens' => 4000],
            ['day' => $yesterday, 'feature' => 'free_answer', 'requests' => 1, 'tokens' => 1000],
            ['day' => (new DateTimeImmutable('-29 days'))->format('Y-m-d'), 'feature' => 'lesson_assistant', 'requests' => 1, 'tokens' => 100],
        ], $usage['days']);
        $this->assertSame(6100, $usage['period_tokens']);
        $this->assertSame(11100, $usage['total_tokens']);
    }

    public function testUsageWithoutActivityIsEmpty()
    {
        $this->assertSame(['days' => [], 'period_tokens' => 0, 'total_tokens' => 0], $this->quota($this->createUser())->usage());
    }

    // Helpers

    private function logUsage(string $userId, string $feature, int $prompt, int $completion, string $at): void
    {
        $this->dbh->prepare("INSERT INTO tokens_usage_log (user_id, feature, ref_id, llm_profile, prompt_tokens, completion_tokens, created_at)
            VALUES (:user_id, :feature, 1, 'p', :prompt, :completion, :at)")
            ->execute([':user_id' => $userId, ':feature' => $feature, ':prompt' => $prompt, ':completion' => $completion, ':at' => $at]);
    }

    private function createUser(int $balance = 50000): string
    {
        $id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));
        $stmt = $this->dbh->prepare('INSERT INTO users (id, login, llm_tokens) VALUES (:id, :login, :tokens)');
        $stmt->execute([':id' => $id, ':login' => "{$id}@test", ':tokens' => $balance]);
        return $id;
    }

    private function user(string $userId): User
    {
        $user = new User($this->dbh, self::ENV);
        $user->setId($userId);
        return $user;
    }

    private function loggedIn(string $userId): User
    {
        $user = new User($this->dbh, self::ENV);
        $this->assertTrue($user->loginSession(['user_id' => $userId]));
        return $user;
    }

    private function quota(string $userId): TokenQuota
    {
        return new TokenQuota($this->dbh, $this->user($userId), self::ENV);
    }

    private function oauthLogin(string $login): User
    {
        $user = new User($this->dbh, self::ENV);
        $property = new ReflectionProperty(User::class, 'login');
        $property->setAccessible(true);
        $property->setValue($user, $login);
        $user->upsert();
        return $user;
    }

    private function balance(string $userId): int
    {
        $stmt = $this->dbh->prepare('SELECT llm_tokens FROM users WHERE id = :id');
        $stmt->execute([':id' => $userId]);
        return (int)$stmt->fetchColumn();
    }

    private function setBalance(string $userId, int $balance): void
    {
        $this->dbh->prepare('UPDATE users SET llm_tokens = :b WHERE id = :id')->execute([':b' => $balance, ':id' => $userId]);
    }
}
