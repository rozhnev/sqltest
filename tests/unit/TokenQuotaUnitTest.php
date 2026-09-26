<?php

require_once __DIR__ . '/../_support/Helper/TestDatabase.php';

use Helper\TestDatabase;

/**
 * AI token budget: registration allowance, subscription grants, expiry, charging
 * (see LESSON_ASSISTANT_PLAN.md, Stage 8). Runs against the test database from
 * tests/.env.testing and is skipped when it isn't configured.
 */
class TokenQuotaUnitTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    private const ENV = [
        'LLM_FREE_TOKENS'             => 50000,
        'LLM_SUBSCRIBER_CYCLE_TOKENS' => 1000000,
        'LLM_MIN_TOKENS_PER_REQUEST'  => 3000,
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

    // Subscription grant

    public function testGrantSetsCycleBalanceAndStartsFromPaymentDate()
    {
        $userId = $this->createUser(balance: 20000);

        $till = $this->user($userId)->grantSubscription(new DateTimeImmutable('2026-09-24'));

        $this->assertSame('2026-10-24', $till);
        // Set, not added: the free leftover doesn't carry over
        $this->assertSame(1000000, $this->balance($userId));
    }

    public function testEarlyRenewalExtendsFromCurrentEnd()
    {
        $userId = $this->createUser(subscribedTill: '2026-10-24', balance: 300000);

        $till = $this->user($userId)->grantSubscription(new DateTimeImmutable('2026-10-20'));

        $this->assertSame('2026-11-24', $till);
        $this->assertSame(1000000, $this->balance($userId));
    }

    public function testRenewalAfterExpiryStartsFromPaymentDate()
    {
        $userId = $this->createUser(subscribedTill: '2026-08-01');

        $till = $this->user($userId)->grantSubscription(new DateTimeImmutable('2026-09-10'));

        $this->assertSame('2026-10-10', $till);
    }

    // Subscription state

    public function testSubscribedTillIsExclusive()
    {
        $today = (new DateTimeImmutable('today'))->format('Y-m-d');
        $tomorrow = (new DateTimeImmutable('tomorrow'))->format('Y-m-d');

        $endsToday = $this->loggedIn($this->createUser(subscribedTill: $today));
        $this->assertFalse($endsToday->isSubscribed());
        $this->assertTrue($endsToday->showAd());

        $endsTomorrow = $this->loggedIn($this->createUser(subscribedTill: $tomorrow));
        $this->assertTrue($endsTomorrow->isSubscribed());
        $this->assertFalse($endsTomorrow->showAd());
        $this->assertSame($tomorrow, $endsTomorrow->getSubscribedTill());
    }

    public function testExpiredSubscriptionBalanceIsZeroedAndWrittenBack()
    {
        $userId = $this->createUser(subscribedTill: (new DateTimeImmutable('today'))->format('Y-m-d'), balance: 400000);

        $quota = $this->quota($userId);

        $this->assertSame(0, $quota->remaining());
        $this->assertFalse($quota->canSpend());
        $this->assertSame(0, $this->balance($userId));
    }

    public function testFreeUserBalanceIsNotZeroed()
    {
        $userId = $this->createUser(balance: 40000);

        $this->assertSame(40000, $this->quota($userId)->remaining());
        $this->assertSame(40000, $this->balance($userId));
    }

    // Status for the UI

    public function testPercentUsesFreePlanSize()
    {
        $status = $this->quota($this->createUser(balance: 12500))->status();

        $this->assertSame(75, $status['percent_used']);
        $this->assertFalse($status['subscribed']);
        $this->assertNull($status['resets_at']);
    }

    public function testPercentUsesSubscriberPlanSize()
    {
        $tomorrow = (new DateTimeImmutable('tomorrow'))->format('Y-m-d');
        $status = $this->quota($this->createUser(subscribedTill: $tomorrow, balance: 900000))->status();

        $this->assertSame(10, $status['percent_used']);
        $this->assertTrue($status['subscribed']);
        $this->assertSame($tomorrow, $status['resets_at']);
    }

    public function testStatusExposesNoRawTokenNumbers()
    {
        $status = $this->quota($this->createUser(balance: 12345))->status();

        $this->assertSame(['percent_used', 'subscribed', 'resets_at', 'exhausted'], array_keys($status));
        $this->assertNotContains(12345, $status, 'raw balance leaked');
    }

    public function testNegativeBalanceShowsAsFullyUsed()
    {
        $status = $this->quota($this->createUser(balance: -500))->status();

        $this->assertSame(100, $status['percent_used']);
        $this->assertTrue($status['exhausted']);
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
        $log = $this->dbh->query('SELECT user_id, feature, ref_id, llm_profile, prompt_tokens, completion_tokens FROM llm_usage_log')->fetchAll(PDO::FETCH_ASSOC);
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
        $this->assertSame(0, (int)$this->dbh->query('SELECT COUNT(*) FROM llm_usage_log')->fetchColumn());
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

    // Helpers

    private function createUser(?string $subscribedTill = null, int $balance = 50000): string
    {
        $id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));
        $stmt = $this->dbh->prepare('INSERT INTO users (id, login, subscribed_till, llm_tokens) VALUES (:id, :login, :till, :tokens)');
        $stmt->execute([':id' => $id, ':login' => "{$id}@test", ':till' => $subscribedTill, ':tokens' => $balance]);
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
