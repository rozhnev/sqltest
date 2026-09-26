<?php
/**
 * Automatic monthly subscription through Lava.top (see SUBSCRIPTION_PLAN.md):
 * checkout, webhook handling, cancellation and the state shown on /subscribe.
 * The subscription itself is users.subscribed_till, extended by User::grantSubscription().
 */
class Subscription
{
    public const WEBHOOK_PROCESSED = 'processed';
    public const WEBHOOK_DUPLICATE = 'duplicate';
    public const WEBHOOK_IGNORED   = 'ignored';
    public const WEBHOOK_UNMATCHED = 'unmatched';

    private PDO $dbh;
    private array $env;
    private LavaClient $lava;
    /** @var callable(string $subject, string $text): void */
    private $notifyAdmin;

    /**
     * @param callable|null $notifyAdmin fn(string $subject, string $text), defaults to an email
     *                                   to SUBSCRIPTION_ADMIN_EMAIL
     */
    public function __construct(PDO $dbh, array $env, ?LavaClient $lava = null, ?callable $notifyAdmin = null)
    {
        $this->dbh = $dbh;
        $this->env = $env;
        $this->lava = $lava ?? new LavaClient(
            (string)($env['LAVA_API_KEY'] ?? ''),
            (string)($env['LAVA_API_URL'] ?? 'https://gate.lava.top')
        );
        $this->notifyAdmin = $notifyAdmin ?? function (string $subject, string $text): void {
            Mailer::sendText($this->env, (string)($this->env['SUBSCRIPTION_ADMIN_EMAIL'] ?? ''), $subject, $text);
        };
    }

    /**
     * Whether automatic checkout is configured (API key and offer id)
     */
    public function checkoutAvailable(): bool
    {
        return ($this->env['LAVA_API_KEY'] ?? '') !== '' && ($this->env['SUBSCRIPTION_LAVA_OFFER_ID'] ?? '') !== '';
    }

    /**
     * Webhook authentication: Lava sends the secret configured in its profile in X-Api-Key.
     * Fails closed when no secret is configured.
     */
    public static function isValidWebhookKey(string $secret, ?string $given): bool
    {
        return $secret !== '' && $given !== null && hash_equals($secret, $given);
    }

    // Checkout

    /**
     * Create a Lava invoice for a monthly subscription and remember it as pending.
     *
     * @param string $siteUrl Scheme and host for the return URLs, e.g. https://sqltest.online
     * @return string Lava payment page URL
     * @throws LavaApiException
     */
    public function startCheckout(User $user, string $email, string $lang, string $siteUrl): string
    {
        [$currency, $provider, $method] = $lang === 'ru'
            ? ['RUB', $this->env['SUBSCRIPTION_LAVA_PROVIDER_RUB'] ?? 'SMART_GLOCAL', $this->env['SUBSCRIPTION_LAVA_METHOD_RUB'] ?? '']
            : ['USD', $this->env['SUBSCRIPTION_LAVA_PROVIDER_USD'] ?? 'UNLIMINT', $this->env['SUBSCRIPTION_LAVA_METHOD_USD'] ?? 'CARD'];
        $returnUrl = rtrim($siteUrl, '/') . "/{$lang}/subscribe?payment=";

        $invoice = [
            'email'                 => $email,
            'offerId'               => (string)($this->env['SUBSCRIPTION_LAVA_OFFER_ID'] ?? ''),
            'currency'              => $currency,
            'periodicity'           => 'MONTHLY',
            'paymentProvider'       => $provider,
            'buyerLanguage'         => ['ru' => 'RU', 'es' => 'ES'][$lang] ?? 'EN',
            'successful_return_url' => $returnUrl . 'success',
            'failure_return_url'    => $returnUrl . 'failed',
            'cancel_return_url'     => $returnUrl . 'cancelled',
        ];
        if ($method !== '') {
            $invoice['paymentMethod'] = $method;
        }

        $contract = $this->lava->createInvoice($invoice);

        $stmt = $this->dbh->prepare("INSERT INTO subscriptions (contract_id, user_id, email, currency)
            VALUES (:contract_id, :user_id, :email, :currency)");
        $stmt->execute([
            ':contract_id' => $contract['id'],
            ':user_id'     => $user->getId(),
            ':email'       => $email,
            ':currency'    => $currency,
        ]);

        return $contract['paymentUrl'];
    }

    // Cancellation

    /**
     * Cancel the user's auto-renewing subscription in Lava. The paid period is kept.
     *
     * @return bool false if the user has no active subscription
     * @throws LavaApiException
     */
    public function cancel(User $user): bool
    {
        $stmt = $this->dbh->prepare("SELECT contract_id, email FROM subscriptions
            WHERE user_id = :user_id AND status = 'active' ORDER BY created_at DESC LIMIT 1");
        $stmt->execute([':user_id' => $user->getId()]);
        $subscription = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$subscription) {
            return false;
        }

        $this->lava->cancelSubscription((string)$subscription['contract_id'], (string)$subscription['email']);

        // Lava also sends subscription.cancelled; handling it again is a no-op
        $this->markCancelled((string)$subscription['contract_id']);
        return true;
    }

    // State for the subscribe page

    /**
     * @return array{status: string, renewal_failed: bool, renewal_error: ?string}
     *         status: none | pending | active | failed | cancelled (of the most relevant subscription)
     */
    public function state(User $user): array
    {
        // An active or cancelled subscription wins over newer abandoned checkouts
        $stmt = $this->dbh->prepare("SELECT status, renewal_failed_at, renewal_error FROM subscriptions
            WHERE user_id = :user_id
            ORDER BY (status IN ('active', 'cancelled')) DESC, created_at DESC
            LIMIT 1");
        $stmt->execute([':user_id' => $user->getId()]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$row) {
            return ['status' => 'none', 'renewal_failed' => false, 'renewal_error' => null];
        }
        return [
            'status'         => (string)$row['status'],
            'renewal_failed' => $row['status'] === 'active' && $row['renewal_failed_at'] !== null,
            'renewal_error'  => $row['renewal_error'],
        ];
    }

    // Webhooks

    /**
     * Log and process one webhook body. The log row is written outside the processing
     * transaction, so it survives a failure (and Lava's retry adds a new row).
     *
     * @return string One of the WEBHOOK_* results
     * @throws InvalidArgumentException On a body that isn't a JSON object
     * @throws Throwable On a processing error (the caller answers 5xx so Lava retries)
     */
    public function receiveWebhook(string $rawBody): string
    {
        $event = json_decode($rawBody, true);
        if (!is_array($event)) {
            throw new InvalidArgumentException('Webhook body is not a JSON object');
        }

        $stmt = $this->dbh->prepare("INSERT INTO lava_webhook_log (event_type, contract_id, body)
            VALUES (:event_type, :contract_id, :body) RETURNING id");
        $stmt->execute([
            ':event_type'  => substr((string)($event['eventType'] ?? $event['event_type'] ?? ''), 0, 64),
            ':contract_id' => self::uuidOrNull($event['contractId'] ?? null),
            ':body'        => $rawBody,
        ]);
        $logId = (int)$stmt->fetchColumn();

        $failure = null;
        try {
            $result = $this->handleWebhook($event);
        } catch (Throwable $error) {
            $failure = $error;
            $result = 'error';
        }

        $stmt = $this->dbh->prepare("UPDATE lava_webhook_log SET result = :result, error = :error WHERE id = :id");
        $stmt->execute([':result' => $result, ':error' => $failure === null ? null : $failure->getMessage(), ':id' => $logId]);

        if ($failure !== null) {
            throw $failure;
        }
        return $result;
    }

    /**
     * Apply one webhook event. Idempotent: Lava retries deliveries.
     *
     * @return string One of the WEBHOOK_* results
     */
    public function handleWebhook(array $event): string
    {
        // Refund and chargeback events have a different shape (snake_case, data.*)
        $eventType = (string)($event['eventType'] ?? $event['event_type'] ?? '');
        $productId = (string)($event['product']['id'] ?? $event['data']['product']['product_id'] ?? '');
        if ($productId !== (string)($this->env['SUBSCRIPTION_LAVA_PRODUCT_ID'] ?? '')) {
            return self::WEBHOOK_IGNORED;
        }

        $this->dbh->beginTransaction();
        try {
            switch ($eventType) {
                case 'payment.success':
                    $result = $this->handlePayment($event, (string)($event['contractId'] ?? ''), true);
                    break;
                case 'subscription.recurring.payment.success':
                    $result = $this->handlePayment($event, (string)($event['parentContractId'] ?? ''), false);
                    break;
                case 'payment.failed':
                    $result = $this->handleFirstPaymentFailed($event);
                    break;
                case 'subscription.recurring.payment.failed':
                    $result = $this->handleRenewalFailed($event);
                    break;
                case 'subscription.cancelled':
                    $result = $this->handleCancelled($event);
                    break;
                case 'refund.success':
                case 'chargeback.initiated':
                    $this->notifyMoneyReturned($eventType, $event);
                    $result = self::WEBHOOK_PROCESSED;
                    break;
                default:
                    $result = self::WEBHOOK_IGNORED;
            }
            $this->dbh->commit();
        } catch (Throwable $error) {
            if ($this->dbh->inTransaction()) {
                $this->dbh->rollBack();
            }
            throw $error;
        }
        return $result;
    }

    /**
     * First payment (looked up by its own contract id) or renewal (by parentContractId):
     * record the payment once and extend the subscription.
     */
    private function handlePayment(array $event, string $subscriptionContractId, bool $firstPayment): string
    {
        $subscription = $this->findSubscription($subscriptionContractId);
        if ($subscription === null) {
            ($this->notifyAdmin)(
                'Lava payment without a matching subscription',
                "A subscription payment arrived that the site didn't create (e.g. paid through a static link),\n"
                . "so nothing was granted. Grant it manually with scripts/grant_subscription.php if it's genuine.\n\n"
                . self::describeEvent($event)
            );
            return self::WEBHOOK_UNMATCHED;
        }

        $paidAt = new DateTimeImmutable((string)($event['timestamp'] ?? 'now'));
        $stmt = $this->dbh->prepare("INSERT INTO subscription_payments (contract_id, subscription_id, amount, currency, paid_at)
            VALUES (:contract_id, :subscription_id, :amount, :currency, :paid_at)
            ON CONFLICT (contract_id) DO NOTHING
            RETURNING contract_id");
        $stmt->execute([
            ':contract_id'     => (string)($event['contractId'] ?? ''),
            ':subscription_id' => $subscription['contract_id'],
            ':amount'          => (float)($event['amount'] ?? 0),
            ':currency'        => substr((string)($event['currency'] ?? $subscription['currency']), 0, 3),
            ':paid_at'         => $paidAt->format('Y-m-d H:i:s'),
        ]);
        if ($stmt->fetchColumn() === false) {
            return self::WEBHOOK_DUPLICATE;
        }

        if ($firstPayment) {
            $stmt = $this->dbh->prepare("UPDATE subscriptions SET status = 'active', activated_at = CURRENT_TIMESTAMP
                WHERE contract_id = :contract_id AND status IN ('pending', 'failed')");
        } else {
            $stmt = $this->dbh->prepare("UPDATE subscriptions SET renewal_failed_at = NULL, renewal_error = NULL
                WHERE contract_id = :contract_id");
        }
        $stmt->execute([':contract_id' => $subscription['contract_id']]);

        $user = new User($this->dbh, $this->env);
        $user->setId((string)$subscription['user_id']);
        $user->grantSubscription($paidAt);
        return self::WEBHOOK_PROCESSED;
    }

    private function handleFirstPaymentFailed(array $event): string
    {
        $subscription = $this->findSubscription((string)($event['contractId'] ?? ''));
        if ($subscription === null) {
            return self::WEBHOOK_UNMATCHED;
        }
        // Only a pending checkout fails; a late or repeated failure must not undo a later success
        $stmt = $this->dbh->prepare("UPDATE subscriptions SET status = 'failed'
            WHERE contract_id = :contract_id AND status = 'pending'
            RETURNING contract_id");
        $stmt->execute([':contract_id' => $subscription['contract_id']]);
        return $stmt->fetchColumn() === false ? self::WEBHOOK_DUPLICATE : self::WEBHOOK_PROCESSED;
    }

    private function handleRenewalFailed(array $event): string
    {
        $subscription = $this->findSubscription((string)($event['parentContractId'] ?? ''));
        if ($subscription === null) {
            return self::WEBHOOK_UNMATCHED;
        }
        // subscribed_till is untouched: the paid period runs out on its own
        $stmt = $this->dbh->prepare("UPDATE subscriptions SET renewal_failed_at = CURRENT_TIMESTAMP, renewal_error = :error
            WHERE contract_id = :contract_id");
        $stmt->execute([':error' => (string)($event['errorMessage'] ?? ''), ':contract_id' => $subscription['contract_id']]);
        return self::WEBHOOK_PROCESSED;
    }

    private function handleCancelled(array $event): string
    {
        // contractId here may be the parent contract or a later renewal contract, so fall back
        // to the payments and then to the buyer's active subscription
        $subscription = $this->findSubscription((string)($event['contractId'] ?? ''))
            ?? $this->findActiveByEmail((string)($event['buyer']['email'] ?? ''));
        if ($subscription === null) {
            return self::WEBHOOK_UNMATCHED;
        }
        return $this->markCancelled((string)$subscription['contract_id']) ? self::WEBHOOK_PROCESSED : self::WEBHOOK_DUPLICATE;
    }

    private function notifyMoneyReturned(string $eventType, array $event): void
    {
        $email = (string)($event['data']['customer_email'] ?? '');
        $stmt = $this->dbh->prepare("SELECT id, login FROM users WHERE LOWER(email) = LOWER(:email)");
        $stmt->execute([':email' => $email]);
        $users = array_map(static fn($u) => "{$u['id']} ({$u['login']})", $stmt->fetchAll(PDO::FETCH_ASSOC));

        ($this->notifyAdmin)(
            "Lava {$eventType}: {$email}",
            "Lava reported {$eventType}. The subscription was NOT changed automatically; revoke it manually if needed\n"
            . "(UPDATE users SET subscribed_till = CURRENT_DATE, llm_tokens = 0 WHERE id = ...).\n\n"
            . 'Users with this email: ' . ($users ? implode(', ', $users) : 'none') . "\n\n"
            . self::describeEvent($event)
        );
    }

    /**
     * @return bool false if it was already cancelled
     */
    private function markCancelled(string $contractId): bool
    {
        $stmt = $this->dbh->prepare("UPDATE subscriptions SET status = 'cancelled', cancelled_at = CURRENT_TIMESTAMP
            WHERE contract_id = :contract_id AND status <> 'cancelled'
            RETURNING contract_id");
        $stmt->execute([':contract_id' => $contractId]);
        return $stmt->fetchColumn() !== false;
    }

    /**
     * Subscription by its own (parent) contract id or by the contract id of one of its payments
     */
    private function findSubscription(string $contractId): ?array
    {
        $contractId = self::uuidOrNull($contractId);
        if ($contractId === null) {
            return null;
        }
        $stmt = $this->dbh->prepare("SELECT s.contract_id, s.user_id, s.currency FROM subscriptions s
            WHERE s.contract_id = :contract_id
               OR s.contract_id = (SELECT subscription_id FROM subscription_payments WHERE contract_id = :payment_contract_id)
            FOR UPDATE");
        $stmt->execute([':contract_id' => $contractId, ':payment_contract_id' => $contractId]);
        return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    private function findActiveByEmail(string $email): ?array
    {
        if ($email === '') {
            return null;
        }
        $stmt = $this->dbh->prepare("SELECT contract_id, user_id, currency FROM subscriptions
            WHERE LOWER(email) = LOWER(:email) AND status = 'active'
            ORDER BY created_at DESC LIMIT 1
            FOR UPDATE");
        $stmt->execute([':email' => $email]);
        return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    private static function uuidOrNull($value): ?string
    {
        $value = (string)$value;
        return preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $value) ? $value : null;
    }

    private static function describeEvent(array $event): string
    {
        return "Event:\n" . json_encode($event, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
}
