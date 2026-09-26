<?php

require_once __DIR__ . '/../_support/Helper/TestDatabase.php';

use Helper\TestDatabase;

/**
 * Lava.top subscription cycle (see SUBSCRIPTION_PLAN.md, Stage 7): checkout, webhooks,
 * cancellation. Webhook payloads follow the examples in Lava's OpenAPI spec. DB tests run
 * against tests/.env.testing and are skipped when it isn't configured.
 */
class SubscriptionUnitTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    private const PRODUCT_ID = '72d53efb-3696-469f-b856-f0d815748dd6';
    private const FIRST_CONTRACT = 'c5a0cacc-3453-44b0-9532-aa492f1ba191';
    private const RENEWAL_CONTRACT = 'd41db415-ad71-4f2a-8d8c-27eefee91e66';

    private const ENV = [
        'LLM_FREE_TOKENS'              => 50000,
        'LLM_SUBSCRIBER_CYCLE_TOKENS'  => 1000000,
        'LAVA_API_KEY'                 => 'test-key',
        'SUBSCRIPTION_LAVA_OFFER_ID'   => '836b9fc5-7ae9-4a27-9642-592bc44072b7',
        'SUBSCRIPTION_LAVA_PRODUCT_ID' => self::PRODUCT_ID,
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

    // Webhook authentication (no DB)

    public function testWebhookKeyFailsClosed()
    {
        $this->assertFalse(Subscription::isValidWebhookKey('', ''));
        $this->assertFalse(Subscription::isValidWebhookKey('', 'anything'));
        $this->assertFalse(Subscription::isValidWebhookKey('secret', null));
        $this->assertFalse(Subscription::isValidWebhookKey('secret', 'wrong'));
        $this->assertTrue(Subscription::isValidWebhookKey('secret', 'secret'));
    }

    // Checkout

    public function testCheckoutInRussianUsesRublesAndStoresPendingSubscription()
    {
        $userId = $this->createUser();

        $url = $this->subscription()->startCheckout($this->user($userId), 'buyer@example.com', 'ru', 'https://sqltest.online');

        $this->assertSame('https://pay.lava.top/fake', $url);
        $invoice = $this->lava->invoices[0];
        $this->assertSame('RUB', $invoice['currency']);
        $this->assertSame('SMART_GLOCAL', $invoice['paymentProvider']);
        $this->assertSame('MONTHLY', $invoice['periodicity']);
        $this->assertSame('RU', $invoice['buyerLanguage']);
        $this->assertSame('buyer@example.com', $invoice['email']);
        $this->assertSame('https://sqltest.online/ru/subscribe?payment=success', $invoice['successful_return_url']);
        $this->assertSame(['status' => 'pending', 'renewal_failed' => false, 'renewal_error' => null], $this->subscription()->state($this->user($userId)));
    }

    public function testCheckoutInOtherLanguagesUsesDollars()
    {
        $this->subscription()->startCheckout($this->user($this->createUser()), 'buyer@example.com', 'fr', 'https://sqltest.online');

        $invoice = $this->lava->invoices[0];
        $this->assertSame('USD', $invoice['currency']);
        $this->assertSame('UNLIMINT', $invoice['paymentProvider']);
        $this->assertSame('CARD', $invoice['paymentMethod']);
        $this->assertSame('EN', $invoice['buyerLanguage']);
    }

    // First payment

    public function testFirstPaymentActivatesAndGrantsOnce()
    {
        $userId = $this->checkedOutUser();

        $result = $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:44:32.42176Z'));

        $this->assertSame(Subscription::WEBHOOK_PROCESSED, $result);
        $this->assertSame('active', $this->subscription()->state($this->user($userId))['status']);
        $this->assertSame(['2026-10-24', 1000000], $this->userRow($userId));

        // Lava retries the same delivery: no second month, balance untouched
        $this->setBalance($userId, 5);
        $again = $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:44:32.42176Z'));

        $this->assertSame(Subscription::WEBHOOK_DUPLICATE, $again);
        $this->assertSame(['2026-10-24', 5], $this->userRow($userId));
        $this->assertSame(1, $this->rowCount('subscription_payments'));
    }

    public function testFirstPaymentFailureMarksCheckoutFailed()
    {
        $userId = $this->checkedOutUser();

        $result = $this->subscription()->handleWebhook($this->event('payment.failed', ['contractId' => self::FIRST_CONTRACT, 'status' => 'subscription-failed']));

        $this->assertSame(Subscription::WEBHOOK_PROCESSED, $result);
        $this->assertSame('failed', $this->subscription()->state($this->user($userId))['status']);
        $this->assertSame([null, 50000], $this->userRow($userId));
    }

    public function testLateFailureDoesNotUndoSuccess()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));

        $this->subscription()->handleWebhook($this->event('payment.failed', ['contractId' => self::FIRST_CONTRACT]));

        $this->assertSame('active', $this->subscription()->state($this->user($userId))['status']);
    }

    // Renewals

    public function testRenewalExtendsFromCurrentEndAndClearsFailure()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));
        $this->subscription()->handleWebhook($this->event('subscription.recurring.payment.failed', [
            'contractId' => '04f152b7-63ec-46ff-958e-8a6f5869acd6', 'parentContractId' => self::FIRST_CONTRACT, 'errorMessage' => 'Not sufficient funds',
        ]));
        $this->setBalance($userId, 100);

        // Paid a day early: extends from the current end, not from the payment date
        $result = $this->subscription()->handleWebhook($this->event('subscription.recurring.payment.success', [
            'contractId' => self::RENEWAL_CONTRACT, 'parentContractId' => self::FIRST_CONTRACT, 'timestamp' => '2026-10-23T08:00:00Z',
        ]));

        $this->assertSame(Subscription::WEBHOOK_PROCESSED, $result);
        $this->assertSame(['2026-11-24', 1000000], $this->userRow($userId));
        $this->assertFalse($this->subscription()->state($this->user($userId))['renewal_failed']);
    }

    public function testFailedRenewalKeepsPaidPeriodAndShowsBanner()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));

        $this->subscription()->handleWebhook($this->event('subscription.recurring.payment.failed', [
            'contractId' => '04f152b7-63ec-46ff-958e-8a6f5869acd6', 'parentContractId' => self::FIRST_CONTRACT, 'errorMessage' => 'Not sufficient funds',
        ]));

        $state = $this->subscription()->state($this->user($userId));
        $this->assertTrue($state['renewal_failed']);
        $this->assertSame('Not sufficient funds', $state['renewal_error']);
        $this->assertSame('2026-10-24', $this->userRow($userId)[0]);
    }

    // Cancellation

    public function testCancelledWebhookByRenewalContractKeepsPaidPeriod()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));
        $this->subscription()->handleWebhook($this->event('subscription.recurring.payment.success', [
            'contractId' => self::RENEWAL_CONTRACT, 'parentContractId' => self::FIRST_CONTRACT, 'timestamp' => '2026-10-24T08:00:00Z',
        ]));

        $result = $this->subscription()->handleWebhook($this->event('subscription.cancelled', [
            'contractId' => self::RENEWAL_CONTRACT, 'cancelledAt' => '2026-10-30T08:00:00Z', 'willExpireAt' => '2026-11-24T08:00:00Z',
        ]));

        $this->assertSame(Subscription::WEBHOOK_PROCESSED, $result);
        $this->assertSame('cancelled', $this->subscription()->state($this->user($userId))['status']);
        $this->assertSame('2026-11-24', $this->userRow($userId)[0]);
    }

    public function testCancelledWebhookFallsBackToBuyerEmail()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));

        // A contract id we have never seen (e.g. a failed renewal attempt)
        $result = $this->subscription()->handleWebhook($this->event('subscription.cancelled', ['contractId' => '04f152b7-63ec-46ff-958e-8a6f5869acd6']));

        $this->assertSame(Subscription::WEBHOOK_PROCESSED, $result);
        $this->assertSame('cancelled', $this->subscription()->state($this->user($userId))['status']);
    }

    public function testCancelCallsLavaWithParentContractAndEmail()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));

        $this->assertTrue($this->subscription()->cancel($this->user($userId)));

        $this->assertSame([[self::FIRST_CONTRACT, 'buyer@example.com']], $this->lava->cancelled);
        $this->assertSame('cancelled', $this->subscription()->state($this->user($userId))['status']);
        // The confirming webhook afterwards is a no-op
        $this->assertSame(Subscription::WEBHOOK_DUPLICATE, $this->subscription()->handleWebhook($this->event('subscription.cancelled', ['contractId' => self::FIRST_CONTRACT])));
    }

    public function testCancelWithoutActiveSubscriptionDoesNothing()
    {
        $userId = $this->checkedOutUser();

        $this->assertFalse($this->subscription()->cancel($this->user($userId)));
        $this->assertSame([], $this->lava->cancelled);
    }

    public function testFailedLavaCancelKeepsSubscriptionActive()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));
        $this->lava->failCancel = true;

        try {
            $this->subscription()->cancel($this->user($userId));
            $this->fail('LavaApiException expected');
        } catch (LavaApiException $expected) {
        }
        $this->assertSame('active', $this->subscription()->state($this->user($userId))['status']);
    }

    // Events we don't act on

    public function testOtherProductIsIgnored()
    {
        $userId = $this->checkedOutUser();

        $result = $this->subscription()->handleWebhook(['product' => ['id' => 'd31384b8-e412-4be5-a2ec-297ae6666c8f']] + $this->firstPayment('2026-09-24T08:00:00Z'));

        $this->assertSame(Subscription::WEBHOOK_IGNORED, $result);
        $this->assertSame([null, 50000], $this->userRow($userId));
    }

    public function testUnknownContractIsUnmatchedAndReportedToAdmin()
    {
        $this->db();

        $result = $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));

        $this->assertSame(Subscription::WEBHOOK_UNMATCHED, $result);
        $this->assertSame(0, $this->rowCount('subscription_payments'));
        $this->assertCount(1, $this->notifications);
    }

    public function testRefundNotifiesAdminWithoutChangingSubscription()
    {
        $userId = $this->checkedOutUser();
        $this->subscription()->handleWebhook($this->firstPayment('2026-09-24T08:00:00Z'));

        $result = $this->subscription()->handleWebhook([
            'event_id' => '7ea82675-4ded-4133-95a7-a6efbaf165cc',
            'event_type' => 'refund.success',
            'data' => ['customer_email' => 'buyer@example.com', 'amount' => 5, 'currency' => 'USD', 'product' => ['product_id' => self::PRODUCT_ID]],
        ]);

        $this->assertSame(Subscription::WEBHOOK_PROCESSED, $result);
        $this->assertSame(['2026-10-24', 1000000], $this->userRow($userId));
        $this->assertCount(1, $this->notifications);
        $this->assertStringContainsString($userId, $this->notifications[0][1]);
    }

    // Webhook log

    public function testReceiveWebhookLogsBodyAndResult()
    {
        $this->checkedOutUser();

        $result = $this->subscription()->receiveWebhook(json_encode($this->firstPayment('2026-09-24T08:00:00Z')));

        $log = $this->db()->query('SELECT event_type, contract_id, result FROM lava_webhook_log')->fetchAll(PDO::FETCH_ASSOC);
        $this->assertSame(Subscription::WEBHOOK_PROCESSED, $result);
        $this->assertSame([['event_type' => 'payment.success', 'contract_id' => self::FIRST_CONTRACT, 'result' => 'processed']], $log);
    }

    public function testReceiveWebhookRejectsNonJson()
    {
        $this->db();
        $this->expectException(InvalidArgumentException::class);

        $this->subscription()->receiveWebhook('not json');
    }

    // Helpers

    private function db(): PDO
    {
        if (!$this->db instanceof PDO) {
            $this->markTestSkipped($this->db);
        }
        return $this->db;
    }

    private function subscription(): Subscription
    {
        return new Subscription($this->db(), self::ENV, $this->lava, function (string $subject, string $text): void {
            $this->notifications[] = [$subject, $text];
        });
    }

    /**
     * A user who went through our checkout: pending subscription FIRST_CONTRACT
     */
    private function checkedOutUser(): string
    {
        $userId = $this->createUser();
        $this->lava->nextContractId = self::FIRST_CONTRACT;
        $this->subscription()->startCheckout($this->user($userId), 'buyer@example.com', 'en', 'https://sqltest.online');
        return $userId;
    }

    private function firstPayment(string $timestamp): array
    {
        return $this->event('payment.success', ['contractId' => self::FIRST_CONTRACT, 'timestamp' => $timestamp]);
    }

    private function event(string $type, array $fields): array
    {
        return $fields + [
            'eventType' => $type,
            'product'   => ['id' => self::PRODUCT_ID, 'title' => 'Subscription'],
            'buyer'     => ['email' => 'buyer@example.com'],
            'amount'    => 5,
            'currency'  => 'USD',
            'timestamp' => '2026-09-24T08:00:00Z',
            'status'    => 'subscription-active',
        ];
    }

    private function createUser(): string
    {
        $id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));
        $this->db()->prepare('INSERT INTO users (id, login, email, llm_tokens) VALUES (:id, :login, :email, 50000)')
            ->execute([':id' => $id, ':login' => "{$id}@test", ':email' => 'buyer@example.com']);
        return $id;
    }

    private function user(string $userId): User
    {
        $user = new User($this->db(), self::ENV);
        $user->setId($userId);
        return $user;
    }

    /**
     * @return array{0: ?string, 1: int} subscribed_till, llm_tokens
     */
    private function userRow(string $userId): array
    {
        $stmt = $this->db()->prepare('SELECT subscribed_till, llm_tokens FROM users WHERE id = :id');
        $stmt->execute([':id' => $userId]);
        $row = $stmt->fetch(PDO::FETCH_NUM);
        return [$row[0], (int)$row[1]];
    }

    private function setBalance(string $userId, int $balance): void
    {
        $this->db()->prepare('UPDATE users SET llm_tokens = :b WHERE id = :id')->execute([':b' => $balance, ':id' => $userId]);
    }

    private function rowCount(string $table): int
    {
        return (int)$this->db()->query("SELECT COUNT(*) FROM {$table}")->fetchColumn();
    }
}

/**
 * Records API calls instead of calling Lava
 */
class FakeLavaClient extends LavaClient
{
    public array $invoices = [];
    public array $cancelled = [];
    public string $nextContractId = '11111111-2222-3333-4444-555555555555';
    public bool $failCancel = false;

    public function __construct()
    {
        parent::__construct('fake');
    }

    public function createInvoice(array $invoice): array
    {
        $this->invoices[] = $invoice;
        return ['id' => $this->nextContractId, 'paymentUrl' => 'https://pay.lava.top/fake'];
    }

    public function cancelSubscription(string $contractId, string $email): void
    {
        if ($this->failCancel) {
            throw new LavaApiException('Lava API DELETE /api/v1/subscriptions returned 400: failed', 400);
        }
        $this->cancelled[] = [$contractId, $email];
    }
}
