<?php

require_once __DIR__ . '/../_support/Helper/TestDatabase.php';

use Helper\TestDatabase;

/**
 * Lava.top token purchases (see TOKEN_PURCHASE_PLAN.md, Stage 8): checkout, webhooks,
 * history. Webhook payloads follow the one-time purchase examples in Lava's OpenAPI spec.
 * DB tests run against tests/.env.testing and are skipped when it isn't configured.
 */
class TokenPurchaseUnitTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    private const PRODUCT_ID = 'd31384b8-e412-4be5-a2ec-297ae6666c8f';
    private const CONTRACT = '7ea82675-4ded-4133-95a7-a6efbaf165cc';
    private const SECOND_CONTRACT = 'c5a0cacc-3453-44b0-9532-aa492f1ba191';

    private const ENV = [
        'LLM_FREE_TOKENS'        => 50000,
        'LLM_PACK_TOKENS'        => 1000000,
        'LAVA_API_KEY'           => 'test-key',
        'TOKENS_LAVA_OFFER_ID'   => '836b9fc5-7ae9-4a27-9642-592bc44072b7',
        'TOKENS_LAVA_PRODUCT_ID' => self::PRODUCT_ID,
    ];

    /** @var PDO|string */
    private $db;
    private FakeLavaClient $lava;
    private array $notifications = [];

    protected function _before()
    {
        $this->db = TestDatabase::connect();
        if ($this->db instanceof PDO) {
            TestDatabase::resetSchema($this->db);
        }
        $this->lava = new FakeLavaClient();
        $this->notifications = [];
    }

    // No DB

    public function testWebhookKeyFailsClosed()
    {
        $this->assertFalse(TokenPurchase::isValidWebhookKey('', ''));
        $this->assertFalse(TokenPurchase::isValidWebhookKey('', 'anything'));
        $this->assertFalse(TokenPurchase::isValidWebhookKey('secret', null));
        $this->assertFalse(TokenPurchase::isValidWebhookKey('secret', 'wrong'));
        $this->assertTrue(TokenPurchase::isValidWebhookKey('secret', 'secret'));
    }

    public function testPromoCodeIsNormalizedAndValidated()
    {
        $this->assertNull(TokenPurchase::normalizePromoCode(''));
        $this->assertNull(TokenPurchase::normalizePromoCode('   '));
        $this->assertSame('TESTFREE', TokenPurchase::normalizePromoCode(' testfree '));
        $this->assertSame('FIRST10', TokenPurchase::normalizePromoCode('first10'));
        $this->assertSame('SUMMER_2026-X', TokenPurchase::normalizePromoCode('summer_2026-x'));
        $this->assertFalse(TokenPurchase::normalizePromoCode('AB'));
        $this->assertFalse(TokenPurchase::normalizePromoCode(str_repeat('A', 37)));
        $this->assertFalse(TokenPurchase::normalizePromoCode('FIRST 10'));
        $this->assertFalse(TokenPurchase::normalizePromoCode('СКИДКА'));
    }

    public function testCheckoutNeedsApiKeyAndOffer()
    {
        $this->assertTrue((new TokenPurchase(new FakePdo(), self::ENV, $this->lava))->checkoutAvailable());
        $this->assertFalse((new TokenPurchase(new FakePdo(), ['TOKENS_LAVA_OFFER_ID' => ''] + self::ENV, $this->lava))->checkoutAvailable());
        $this->assertFalse((new TokenPurchase(new FakePdo(), ['LAVA_API_KEY' => ''] + self::ENV, $this->lava))->checkoutAvailable());
    }

    // Checkout

    public function testCheckoutInRussianUsesRublesAndStoresPendingPurchase()
    {
        $userId = $this->createUser();

        $url = $this->purchase()->startCheckout($this->user($userId), 'buyer@example.com', 'ru', 'https://sqltest.online');

        $this->assertSame('https://pay.lava.top/fake', $url);
        $invoice = $this->lava->invoices[0];
        $this->assertArrayNotHasKey('periodicity', $invoice, 'a one-time purchase has no periodicity');
        $this->assertSame('RUB', $invoice['currency']);
        $this->assertSame('SMART_GLOCAL', $invoice['paymentProvider']);
        $this->assertSame('RU', $invoice['buyerLanguage']);
        $this->assertSame('buyer@example.com', $invoice['email']);
        $this->assertSame(self::ENV['TOKENS_LAVA_OFFER_ID'], $invoice['offerId']);
        $this->assertSame('https://sqltest.online/ru/buy-tokens?payment=success', $invoice['successful_return_url']);
        $this->assertSame(
            ['user_id' => $userId, 'tokens' => 1000000, 'currency' => 'RUB', 'promo_code' => null, 'status' => 'pending'],
            $this->purchaseRow(FakeLavaClient::DEFAULT_CONTRACT)
        );
    }

    public function testCheckoutInOtherLanguagesUsesDollars()
    {
        $this->purchase()->startCheckout($this->user($this->createUser()), 'buyer@example.com', 'fr', 'https://sqltest.online');

        $invoice = $this->lava->invoices[0];
        $this->assertSame('USD', $invoice['currency']);
        $this->assertSame('UNLIMINT', $invoice['paymentProvider']);
        $this->assertSame('CARD', $invoice['paymentMethod']);
        $this->assertSame('EN', $invoice['buyerLanguage']);
    }

    public function testCheckoutPassesPromoCodeOnlyWhenGiven()
    {
        $this->checkedOut($this->createUser(), self::CONTRACT);
        $this->checkedOut($this->createUser(), self::SECOND_CONTRACT, 'FIRST10');

        $this->assertArrayNotHasKey('promoCode', $this->lava->invoices[0]);
        $this->assertSame('FIRST10', $this->lava->invoices[1]['promoCode']);
        $this->assertSame('FIRST10', $this->purchaseRow(self::SECOND_CONTRACT)['promo_code']);
    }

    // Payment

    public function testPaymentAddsPackOnce()
    {
        $userId = $this->createUser(balance: 30000);
        $this->checkedOut($userId, self::CONTRACT);

        $result = $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->assertSame(TokenPurchase::WEBHOOK_PROCESSED, $result);
        $this->assertSame(1030000, $this->balance($userId));
        $this->assertSame('paid', $this->purchaseRow(self::CONTRACT)['status']);

        // Lava retries the same delivery: no second pack
        $again = $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->assertSame(TokenPurchase::WEBHOOK_DUPLICATE, $again);
        $this->assertSame(1030000, $this->balance($userId));
    }

    public function testPaymentStoresAmountAndDate()
    {
        $this->checkedOut($this->createUser(), self::CONTRACT);

        $this->purchase()->handleWebhook($this->paid(self::CONTRACT, amount: 450.5, timestamp: '2026-09-24T08:44:32.42176Z'));

        $row = $this->db()->query("SELECT amount, paid_at FROM token_purchases")->fetch(PDO::FETCH_ASSOC);
        $this->assertSame(['amount' => '450.50', 'paid_at' => '2026-09-24 08:44:32'], $row);
    }

    public function testNegativeBalanceIsRaisedToZeroBeforeThePack()
    {
        $userId = $this->createUser(balance: -700);
        $this->checkedOut($userId, self::CONTRACT);

        $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->assertSame(1000000, $this->balance($userId));
    }

    public function testTwoPurchasesAddUp()
    {
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);
        $this->checkedOut($userId, self::SECOND_CONTRACT);

        $this->purchase()->handleWebhook($this->paid(self::CONTRACT));
        $this->purchase()->handleWebhook($this->paid(self::SECOND_CONTRACT));

        $this->assertSame(2000000, $this->balance($userId));
    }

    public function testFullDiscountPaymentStillCreditsTheFullPack()
    {
        // TESTFREE: 100% discount, Lava reports amount 0
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT, 'TESTFREE');

        $result = $this->purchase()->handleWebhook($this->paid(self::CONTRACT, amount: 0));

        $this->assertSame(TokenPurchase::WEBHOOK_PROCESSED, $result);
        $this->assertSame(1000000, $this->balance($userId));
        $this->assertSame('0.00', (string)$this->db()->query("SELECT amount FROM token_purchases")->fetchColumn());
    }

    public function testPackSizeIsFixedAtCheckout()
    {
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);

        // The pack size changes while the buyer is on the payment page
        $this->purchase(['LLM_PACK_TOKENS' => 2000000] + self::ENV)->handleWebhook($this->paid(self::CONTRACT));

        $this->assertSame(1000000, $this->balance($userId));
    }

    // Failure

    public function testFailedPaymentCreditsNothing()
    {
        $userId = $this->createUser(balance: 50000);
        $this->checkedOut($userId, self::CONTRACT);

        $result = $this->purchase()->handleWebhook($this->event('payment.failed', self::CONTRACT, ['status' => 'failed', 'errorMessage' => 'Payment window is opened but not completed']));

        $this->assertSame(TokenPurchase::WEBHOOK_PROCESSED, $result);
        $this->assertSame('failed', $this->purchaseRow(self::CONTRACT)['status']);
        $this->assertSame(50000, $this->balance($userId));
    }

    public function testLateSuccessAfterFailureStillCredits()
    {
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);
        $this->purchase()->handleWebhook($this->event('payment.failed', self::CONTRACT, ['status' => 'failed']));

        $result = $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->assertSame(TokenPurchase::WEBHOOK_PROCESSED, $result);
        $this->assertSame('paid', $this->purchaseRow(self::CONTRACT)['status']);
        $this->assertSame(1000000, $this->balance($userId));
    }

    public function testLateFailureDoesNotUndoSuccess()
    {
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);
        $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $result = $this->purchase()->handleWebhook($this->event('payment.failed', self::CONTRACT, ['status' => 'failed']));

        $this->assertSame(TokenPurchase::WEBHOOK_DUPLICATE, $result);
        $this->assertSame('paid', $this->purchaseRow(self::CONTRACT)['status']);
        $this->assertSame(1000000, $this->balance($userId));
    }

    // Events we don't act on

    public function testOtherProductIsIgnored()
    {
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);

        $result = $this->purchase()->handleWebhook(['product' => ['id' => '72d53efb-3696-469f-b856-f0d815748dd6']] + $this->paid(self::CONTRACT));

        $this->assertSame(TokenPurchase::WEBHOOK_IGNORED, $result);
        $this->assertSame(0, $this->balance($userId));
    }

    public function testSubscriptionEventIsIgnored()
    {
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);

        $result = $this->purchase()->handleWebhook($this->event('subscription.recurring.payment.success', self::SECOND_CONTRACT, ['parentContractId' => self::CONTRACT]));

        $this->assertSame(TokenPurchase::WEBHOOK_IGNORED, $result);
        $this->assertSame(0, $this->balance($userId));
    }

    public function testUnknownContractIsUnmatchedAndReportedToAdmin()
    {
        $this->db();

        $result = $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->assertSame(TokenPurchase::WEBHOOK_UNMATCHED, $result);
        $this->assertCount(1, $this->notifications);
        $this->assertStringContainsString('grant_tokens.php', $this->notifications[0][1]);
    }

    public function testRefundNotifiesAdminWithoutChangingBalance()
    {
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);
        $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $result = $this->purchase()->handleWebhook([
            'event_id'   => 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
            'event_type' => 'refund.success',
            'data'       => ['customer_email' => 'buyer@example.com', 'product' => ['product_id' => self::PRODUCT_ID, 'product_type' => 'DIGITAL_PRODUCT']],
        ]);

        $this->assertSame(TokenPurchase::WEBHOOK_PROCESSED, $result);
        $this->assertSame(1000000, $this->balance($userId));
        $this->assertCount(1, $this->notifications);
        $this->assertStringContainsString($userId, $this->notifications[0][1]);
    }

    // Webhook log

    public function testReceiveWebhookLogsBodyAndResult()
    {
        $this->checkedOut($this->createUser(), self::CONTRACT);

        $result = $this->purchase()->receiveWebhook(json_encode($this->paid(self::CONTRACT)));

        $log = $this->db()->query('SELECT event_type, contract_id, result FROM lava_webhook_log')->fetchAll(PDO::FETCH_ASSOC);
        $this->assertSame(TokenPurchase::WEBHOOK_PROCESSED, $result);
        $this->assertSame([['event_type' => 'payment.success', 'contract_id' => self::CONTRACT, 'result' => 'processed']], $log);
    }

    public function testReceiveWebhookRejectsNonJson()
    {
        $this->db();
        $this->expectException(InvalidArgumentException::class);

        $this->purchase()->receiveWebhook('not json');
    }

    // History

    public function testHistoryListsPaidPurchasesNewestFirst()
    {
        $userId = $this->createUser();
        $this->checkedOut($userId, self::CONTRACT);
        $this->checkedOut($userId, self::SECOND_CONTRACT);
        $this->checkedOut($userId, '11111111-2222-3333-4444-555555555555'); // never paid
        $this->purchase()->handleWebhook($this->paid(self::CONTRACT, amount: 5, timestamp: '2026-09-01T10:00:00Z'));
        $this->purchase()->handleWebhook($this->paid(self::SECOND_CONTRACT, amount: 0, timestamp: '2026-09-20T10:00:00Z'));

        $history = $this->purchase()->history($this->user($userId));

        $this->assertSame([
            ['paid_at' => '2026-09-20 10:00:00', 'tokens' => 1000000, 'amount' => '0.00', 'currency' => 'USD'],
            ['paid_at' => '2026-09-01 10:00:00', 'tokens' => 1000000, 'amount' => '5.00', 'currency' => 'USD'],
        ], $history);
        $this->assertSame([], $this->purchase()->history($this->user($this->createUser())));
    }

    // Helpers

    private function db(): PDO
    {
        if (!$this->db instanceof PDO) {
            $this->markTestSkipped($this->db);
        }
        return $this->db;
    }

    private function purchase(array $env = self::ENV): TokenPurchase
    {
        return new TokenPurchase($this->db(), $env, $this->lava, function (string $subject, string $text): void {
            $this->notifications[] = [$subject, $text];
        });
    }

    private function createUser(int $balance = 50000): string
    {
        $id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));
        $this->db()->prepare('INSERT INTO users (id, login, email, llm_tokens) VALUES (:id, :login, :email, :tokens)')
            ->execute([':id' => $id, ':login' => "{$id}@test", ':email' => 'buyer@example.com', ':tokens' => $balance]);
        return $id;
    }

    private function user(string $userId): User
    {
        $user = new User($this->db(), self::ENV);
        $user->setId($userId);
        return $user;
    }

    private function checkedOut(string $userId, string $contractId, ?string $promoCode = null): void
    {
        $this->lava->nextContractId = $contractId;
        $this->purchase()->startCheckout($this->user($userId), 'buyer@example.com', 'en', 'https://sqltest.online', $promoCode);
    }

    private function paid(string $contractId, float $amount = 5, string $timestamp = '2026-09-24T08:00:00Z'): array
    {
        return $this->event('payment.success', $contractId, ['amount' => $amount, 'timestamp' => $timestamp]);
    }

    private function event(string $type, string $contractId, array $fields = []): array
    {
        return $fields + [
            'eventType'    => $type,
            'product'      => ['id' => self::PRODUCT_ID, 'title' => 'AI tokens'],
            'buyer'        => ['email' => 'buyer@example.com'],
            'contractId'   => $contractId,
            'amount'       => 5,
            'currency'     => 'USD',
            'timestamp'    => '2026-09-24T08:00:00Z',
            'status'       => 'completed',
            'errorMessage' => '',
        ];
    }

    private function purchaseRow(string $contractId): array
    {
        $stmt = $this->db()->prepare('SELECT user_id, tokens, currency, promo_code, status FROM token_purchases WHERE contract_id = :id');
        $stmt->execute([':id' => $contractId]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    private function balance(string $userId): int
    {
        $stmt = $this->db()->prepare('SELECT llm_tokens FROM users WHERE id = :id');
        $stmt->execute([':id' => $userId]);
        return (int)$stmt->fetchColumn();
    }
}

class FakeLavaClient extends LavaClient
{
    public const DEFAULT_CONTRACT = '11111111-2222-3333-4444-555555555555';

    public array $invoices = [];
    public string $nextContractId = self::DEFAULT_CONTRACT;

    public function __construct()
    {
        parent::__construct('fake');
    }

    public function createInvoice(array $invoice): array
    {
        $this->invoices[] = $invoice;
        return ['id' => $this->nextContractId, 'paymentUrl' => 'https://pay.lava.top/fake'];
    }
}

/**
 * A PDO that never connects, for tests that don't touch the database
 */
class FakePdo extends PDO
{
    public function __construct()
    {
    }
}
