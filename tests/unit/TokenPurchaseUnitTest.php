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

    private const OFFER_ID = '836b9fc5-7ae9-4a27-9642-592bc44072b7';
    private const PRICES = [self::OFFER_ID => ['prices' => ['RUB' => 490, 'USD' => 4.99]]];
    private const PROMO_CODES = [
        'TESTFREE' => ['discount' => 100, 'max_uses' => 10],
        'FIRST10'  => ['discount' => 90],
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
        $this->assertSame('SUMMER_2026-X', TokenPurchase::normalizePromoCode('summer_2026-x'));
        $this->assertFalse(TokenPurchase::normalizePromoCode('AB'));
        $this->assertFalse(TokenPurchase::normalizePromoCode(str_repeat('A', 37)));
        $this->assertFalse(TokenPurchase::normalizePromoCode('FIRST 10'));
        $this->assertFalse(TokenPurchase::normalizePromoCode('СКИДКА'));
    }

    public function testCheckoutNeedsApiKeyAndOffer()
    {
        $this->assertTrue((new TokenPurchase(new FakePdo(), self::ENV, [], $this->lava))->checkoutAvailable());
        $this->assertFalse((new TokenPurchase(new FakePdo(), ['TOKENS_LAVA_OFFER_ID' => ''] + self::ENV, [], $this->lava))->checkoutAvailable());
        $this->assertFalse((new TokenPurchase(new FakePdo(), ['LAVA_API_KEY' => ''] + self::ENV, [], $this->lava))->checkoutAvailable());
    }

    // Checkout

    public function testCheckoutInRussianUsesRublesAndStoresPendingPurchase()
    {
        $userId = $this->createUser();

        $url = $this->purchase()->startCheckout($this->user($userId), 'buyer@example.com', 'ru', 'https://sqltest.online');

        $this->assertSame('https://pay.lava.top/fake', $url);
        $invoice = $this->lava->invoices[0];
        $this->assertArrayNotHasKey('periodicity', $invoice, 'a one-time purchase has no periodicity');
        $this->assertArrayNotHasKey('promoCode', $invoice);
        $this->assertSame('RUB', $invoice['currency']);
        $this->assertArrayNotHasKey('paymentProvider', $invoice, 'Lava picks the provider');
        $this->assertSame('RU', $invoice['buyerLanguage']);
        $this->assertSame('buyer@example.com', $invoice['email']);
        $this->assertSame(self::ENV['TOKENS_LAVA_OFFER_ID'], $invoice['offerId']);
        $this->assertSame('https://sqltest.online/ru/buy-tokens?payment=success', $invoice['successful_return_url']);
        $this->assertSame(
            ['user_id' => $userId, 'tokens' => 1000000, 'currency' => 'RUB', 'promo_code' => null, 'status' => 'pending'],
            $this->purchaseRow(FakeLavaClient::DEFAULT_CONTRACT)
        );
    }

    public function testCheckoutCurrencyByLanguage()
    {
        foreach (['fr' => ['USD', 'EN'], 'en' => ['USD', 'EN'], 'es' => ['EUR', 'ES'], 'zh' => ['USD', 'EN']] as $lang => [$currency, $buyerLanguage]) {
            $this->lava->nextContractId = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));
            $this->purchase()->startCheckout($this->user($this->createUser()), 'buyer@example.com', $lang, 'https://sqltest.online');

            $invoice = end($this->lava->invoices);
            $this->assertSame($currency, $invoice['currency'], $lang);
            $this->assertSame($buyerLanguage, $invoice['buyerLanguage'], $lang);
            $this->assertArrayNotHasKey('paymentMethod', $invoice, $lang);
        }
    }

    public function testCheckoutSendsConfiguredPriceForTheCurrency()
    {
        $products = [self::ENV['TOKENS_LAVA_OFFER_ID'] => ['prices' => ['RUB' => 490, 'USD' => 4.99]]];
        $this->purchase(self::ENV, $products)->startCheckout($this->user($this->createUser()), 'buyer@example.com', 'ru', 'https://sqltest.online');
        $this->lava->nextContractId = self::CONTRACT;
        $this->purchase(self::ENV, $products)->startCheckout($this->user($this->createUser()), 'buyer@example.com', 'en', 'https://sqltest.online');

        $this->assertSame(490.0, $this->lava->invoices[0]['amount']);
        $this->assertSame(4.99, $this->lava->invoices[1]['amount']);
    }

    public function testCheckoutWithoutConfiguredPriceUsesTheOfferPrice()
    {
        // Prices for another offer, or none for this currency, don't apply
        $products = ['98a9b3b4-6b33-48d0-ab0a-a0bd7b68e9d9' => ['prices' => ['RUB' => 500]], self::ENV['TOKENS_LAVA_OFFER_ID'] => ['prices' => ['USD' => 4.99]]];
        $this->purchase(self::ENV, $products)->startCheckout($this->user($this->createUser()), 'buyer@example.com', 'ru', 'https://sqltest.online');

        $this->assertArrayNotHasKey('amount', $this->lava->invoices[0]);
    }

    // Promo codes

    public function testPromoDiscountIsAppliedToTheAmountAndNotSentToLava()
    {
        $userId = $this->createUser();

        $this->promoCheckout($userId, 'ru', 'FIRST10');

        $invoice = $this->lava->invoices[0];
        $this->assertSame(49.0, $invoice['amount']);
        $this->assertArrayNotHasKey('promoCode', $invoice);
        $this->assertSame('FIRST10', $this->purchaseRow(FakeLavaClient::DEFAULT_CONTRACT)['promo_code']);
    }

    public function testPromoCodeIsCaseInsensitiveInConfig()
    {
        $this->promoCheckout($this->createUser(), 'ru', 'FIRST10', ['first10' => ['discount' => 90]]);

        $this->assertSame(49.0, $this->lava->invoices[0]['amount']);
    }

    public function testDiscountedAmountIsRoundedToCents()
    {
        $this->promoCheckout($this->createUser(), 'en', 'FIRST10');

        // 4.99 * 10% = 0.499
        $this->assertSame(0.5, $this->lava->invoices[0]['amount']);
    }

    public function testUnknownPromoCodeIsRejectedBeforeLava()
    {
        $userId = $this->createUser();

        $this->assertPromoRejected(fn() => $this->promoCheckout($userId, 'ru', 'NOSUCHCODE'));
        $this->assertSame([], $this->lava->invoices);
        $this->assertSame(0, (int)$this->db()->query('SELECT COUNT(*) FROM tokens_purchases')->fetchColumn());
    }

    public function testExpiredPromoCodeIsRejectedAndTheLastDayStillWorks()
    {
        $yesterday = (new DateTimeImmutable('yesterday'))->format('Y-m-d');
        $today = (new DateTimeImmutable('today'))->format('Y-m-d');

        $this->assertPromoRejected(fn() => $this->promoCheckout($this->createUser(), 'ru', 'OLD', ['OLD' => ['discount' => 50, 'expires' => $yesterday]]));
        $this->promoCheckout($this->createUser(), 'ru', 'LASTDAY', ['LASTDAY' => ['discount' => 50, 'expires' => $today]]);

        $this->assertSame(245.0, $this->lava->invoices[0]['amount']);
    }

    public function testPromoCodeTotalUsesCountOnlyPaidPurchases()
    {
        $codes = ['ONCE' => ['discount' => 50, 'max_uses' => 1]];
        $this->lava->nextContractId = self::CONTRACT;
        $this->promoCheckout($this->createUser(), 'ru', 'ONCE', $codes);
        // An abandoned checkout doesn't use the code up
        $this->lava->nextContractId = self::SECOND_CONTRACT;
        $this->promoCheckout($this->createUser(), 'ru', 'ONCE', $codes);

        $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->assertPromoRejected(fn() => $this->promoCheckout($this->createUser(), 'ru', 'ONCE', $codes));
    }

    public function testPromoCodeWorksOncePerUserByDefault()
    {
        $userId = $this->createUser();
        $this->lava->nextContractId = self::CONTRACT;
        $this->promoCheckout($userId, 'ru', 'FIRST10');
        $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->assertPromoRejected(fn() => $this->promoCheckout($userId, 'ru', 'FIRST10'));
        // Another user still can
        $this->lava->nextContractId = self::SECOND_CONTRACT;
        $this->promoCheckout($this->createUser(), 'ru', 'FIRST10');
        $this->assertCount(2, $this->lava->invoices);
    }

    public function testPerUserLimitCanBeLifted()
    {
        $codes = ['FRIENDS' => ['discount' => 50, 'max_uses_per_user' => null]];
        $userId = $this->createUser();
        $this->lava->nextContractId = self::CONTRACT;
        $this->promoCheckout($userId, 'ru', 'FRIENDS', $codes);
        $this->purchase()->handleWebhook($this->paid(self::CONTRACT));

        $this->lava->nextContractId = self::SECOND_CONTRACT;
        $this->promoCheckout($userId, 'ru', 'FRIENDS', $codes);

        $this->assertCount(2, $this->lava->invoices);
    }

    public function testFullDiscountCreditsThePackWithoutLava()
    {
        $userId = $this->createUser(balance: 20000);

        $url = $this->promoCheckout($userId, 'ru', 'TESTFREE');

        $this->assertSame('https://sqltest.online/ru/buy-tokens?payment=success', $url);
        $this->assertSame([], $this->lava->invoices, 'Lava is not asked to invoice a zero amount');
        $this->assertSame(1020000, $this->balance($userId));
        $history = $this->purchase()->history($this->user($userId));
        $this->assertCount(1, $history);
        $this->assertSame(['tokens' => 1000000, 'amount' => '0.00', 'currency' => 'RUB'], array_diff_key($history[0], ['paid_at' => 1]));
        // It counts as a use of the code
        $this->assertPromoRejected(fn() => $this->promoCheckout($userId, 'ru', 'TESTFREE'));
        $this->assertSame(1020000, $this->balance($userId));
    }

    public function testPromoCodeOfAnotherOfferDoesNotApply()
    {
        $products = self::PRICES + ['98a9b3b4-6b33-48d0-ab0a-a0bd7b68e9d9' => ['promo_codes' => ['INTERVIEW50' => ['discount' => 50]]]];

        $this->assertPromoRejected(fn() => $this->purchase(self::ENV, $products)
            ->startCheckout($this->user($this->createUser()), 'buyer@example.com', 'ru', 'https://sqltest.online', 'INTERVIEW50'));
    }

    public function testPromoCodeWithoutConfiguredPriceFailsTheCheckout()
    {
        // A configuration problem, reported as a failed checkout rather than a bad code
        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('No price in config.php');

        $this->purchase(self::ENV, [self::OFFER_ID => ['promo_codes' => self::PROMO_CODES]])->startCheckout($this->user($this->createUser()), 'buyer@example.com', 'ru', 'https://sqltest.online', 'FIRST10');
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

        $row = $this->db()->query("SELECT amount, paid_at FROM tokens_purchases")->fetch(PDO::FETCH_ASSOC);
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
        // A 100% discount applied in Lava: the webhook reports amount 0
        $userId = $this->createUser(balance: 0);
        $this->checkedOut($userId, self::CONTRACT);

        $result = $this->purchase()->handleWebhook($this->paid(self::CONTRACT, amount: 0));

        $this->assertSame(TokenPurchase::WEBHOOK_PROCESSED, $result);
        $this->assertSame(1000000, $this->balance($userId));
        $this->assertSame('0.00', (string)$this->db()->query("SELECT amount FROM tokens_purchases")->fetchColumn());
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

    private function purchase(array $env = self::ENV, array $products = []): TokenPurchase
    {
        return new TokenPurchase($this->db(), $env, $products, $this->lava, function (string $subject, string $text): void {
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

    private function promoCheckout(string $userId, string $lang, string $code, array $promoCodes = self::PROMO_CODES): string
    {
        $products = [self::OFFER_ID => ['prices' => self::PRICES[self::OFFER_ID]['prices'], 'promo_codes' => $promoCodes]];
        return $this->purchase(self::ENV, $products)
            ->startCheckout($this->user($userId), 'buyer@example.com', $lang, 'https://sqltest.online', $code);
    }

    private function assertPromoRejected(callable $checkout): void
    {
        $invoices = count($this->lava->invoices);
        try {
            $checkout();
            $this->fail('InvalidPromoCodeException expected');
        } catch (InvalidPromoCodeException $expected) {
        }
        $this->assertCount($invoices, $this->lava->invoices, 'no invoice for a rejected code');
    }

    private function checkedOut(string $userId, string $contractId): void
    {
        $this->lava->nextContractId = $contractId;
        $this->purchase()->startCheckout($this->user($userId), 'buyer@example.com', 'en', 'https://sqltest.online');
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
        $stmt = $this->db()->prepare('SELECT user_id, tokens, currency, promo_code, status FROM tokens_purchases WHERE contract_id = :id');
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
