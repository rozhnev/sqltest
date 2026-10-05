<?php
/**
 * One-time AI token purchases through Lava.top (see TOKEN_PURCHASE_PLAN.md):
 * checkout, webhook handling and the purchase history shown on /buy-tokens.
 * A paid purchase adds its pack to users.llm_tokens, which TokenQuota spends.
 */
class TokenPurchase
{
    public const WEBHOOK_PROCESSED = 'processed';
    public const WEBHOOK_DUPLICATE = 'duplicate';
    public const WEBHOOK_IGNORED   = 'ignored';
    public const WEBHOOK_UNMATCHED = 'unmatched';

    private PDO $dbh;
    private array $env;
    /** @var array Lava offers by offer id, from config.php ('lava_products') */
    private array $products;
    private LavaClient $lava;
    /** @var callable(string $subject, string $text): void */
    private $notifyAdmin;

    /**
     * @param array $products config.php 'lava_products': [offer id => ['prices' => [currency => amount],
     *                        'promo_codes' => [code => ['discount' => percent, 'expires' => 'Y-m-d',
     *                        'max_uses' => n, 'max_uses_per_user' => n (default 1)]]]]
     * @param callable|null $notifyAdmin fn(string $subject, string $text), defaults to an email
     *                                   to LAVA_ADMIN_EMAIL
     */
    public function __construct(PDO $dbh, array $env, array $products = [], ?LavaClient $lava = null, ?callable $notifyAdmin = null)
    {
        $this->dbh = $dbh;
        $this->env = $env;
        $this->products = $products;
        $this->lava = $lava ?? new LavaClient(
            (string)($env['LAVA_API_KEY'] ?? ''),
            (string)($env['LAVA_API_URL'] ?? 'https://gate.lava.top')
        );
        $this->notifyAdmin = $notifyAdmin ?? function (string $subject, string $text): void {
            Mailer::sendText($this->env, (string)($this->env['LAVA_ADMIN_EMAIL'] ?? ''), $subject, $text);
        };
    }

    /**
     * Whether automatic checkout is configured (API key and offer id)
     */
    public function checkoutAvailable(): bool
    {
        return ($this->env['LAVA_API_KEY'] ?? '') !== '' && ($this->env['TOKENS_LAVA_OFFER_ID'] ?? '') !== '';
    }

    /**
     * Tokens in one pack
     */
    public function packTokens(): int
    {
        return max(1, (int)($this->env['LLM_PACK_TOKENS'] ?? 1000000));
    }

    /**
     * Price of the offer in the given currency from config.php ('lava_products', keyed by
     * offer id), or null when not configured: then the offer's own price in Lava is used
     */
    public function packPrice(string $offerId, string $currency): ?float
    {
        $price = (float)($this->products[$offerId]['prices'][strtoupper($currency)] ?? 0);
        return $price > 0 ? $price : null;
    }

    /**
     * Checkout currency for the site language
     */
    public static function currencyForLang(string $lang): string
    {
        return ['ru' => 'RUB', 'es' => 'EUR', 'en' => 'USD'][$lang] ?? 'USD';
    }

    /**
     * Pack price in the checkout currency for the language, formatted for display
     * (e.g. "$5.99", "500 ₽"), or null when config.php has no price for it
     */
    public function packPriceText(string $lang): ?string
    {
        $currency = self::currencyForLang($lang);
        $price = $this->packPrice((string)($this->env['TOKENS_LAVA_OFFER_ID'] ?? ''), $currency);
        if ($price === null) {
            return null;
        }
        if (class_exists('NumberFormatter')) {
            $formatter = new NumberFormatter($lang, NumberFormatter::CURRENCY);
            if (floor($price) == $price) {
                $formatter->setAttribute(NumberFormatter::FRACTION_DIGITS, 0);
            }
            $text = $formatter->formatCurrency($price, $currency);
            if ($text !== false) {
                return $text;
            }
        }
        return number_format($price, floor($price) == $price ? 0 : 2) . ' ' . $currency;
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
     * Normalize a promo code typed by the user: upper case, 3-36 characters, A-Z, 0-9, "-" and "_"
     *
     * @return string|null|false null when empty, false when the format is invalid
     */
    public static function normalizePromoCode(string $raw): string|null|false
    {
        $code = strtoupper(trim($raw));
        if ($code === '') {
            return null;
        }
        return preg_match('/^[A-Z0-9_-]{3,36}$/', $code) ? $code : false;
    }

    /**
     * Discount in percent (1-100) that a promo code of the offer gives this user. Uses are
     * counted from paid purchases, so an abandoned checkout doesn't use up a code.
     *
     * @param string $code A code already passed through normalizePromoCode()
     * @throws InvalidPromoCodeException Unknown for this offer, expired or used up (in total or by this user)
     */
    public function promoDiscount(User $user, string $offerId, string $code): int
    {
        $codes = array_change_key_case((array)($this->products[$offerId]['promo_codes'] ?? []), CASE_UPPER);
        $promo = $codes[$code] ?? null;
        $discount = (int)($promo['discount'] ?? 0);
        if ($promo === null || $discount < 1 || $discount > 100) {
            throw new InvalidPromoCodeException("Unknown promo code {$code}");
        }
        // 'expires' is the last day the code works
        if (isset($promo['expires']) && date('Y-m-d') > (string)$promo['expires']) {
            throw new InvalidPromoCodeException("Promo code {$code} expired on {$promo['expires']}");
        }

        $maxUses = isset($promo['max_uses']) ? (int)$promo['max_uses'] : null;
        if ($maxUses !== null && $this->countPaidWithCode($code) >= $maxUses) {
            throw new InvalidPromoCodeException("Promo code {$code} is used up ({$maxUses} uses)");
        }
        $maxPerUser = array_key_exists('max_uses_per_user', $promo) ? $promo['max_uses_per_user'] : 1;
        if ($maxPerUser !== null && $this->countPaidWithCode($code, $user) >= (int)$maxPerUser) {
            throw new InvalidPromoCodeException("Promo code {$code} is used up for user {$user->getId()}");
        }
        return $discount;
    }

    private function countPaidWithCode(string $code, ?User $user = null): int
    {
        $sql = "SELECT COUNT(*) FROM tokens_purchases WHERE promo_code = :code AND status = 'paid'";
        $params = [':code' => $code];
        if ($user !== null) {
            $sql .= " AND user_id = :user_id";
            $params[':user_id'] = $user->getId();
        }
        $stmt = $this->dbh->prepare($sql);
        $stmt->execute($params);
        return (int)$stmt->fetchColumn();
    }

    /**
     * Create a one-time Lava invoice for one token pack and remember it as pending.
     * A promo code's discount is applied here, to the amount sent to Lava (Lava never sees
     * the code). A 100% discount skips Lava: the pack is credited right away.
     *
     * @param string $siteUrl Scheme and host for the return URLs, e.g. https://sqltest.online
     * @param string|null $promoCode A code already passed through normalizePromoCode()
     * @return string Lava payment page URL, or our success page for a free purchase
     * @throws InvalidPromoCodeException
     * @throws LavaApiException
     */
    public function startCheckout(User $user, string $email, string $lang, string $siteUrl, ?string $promoCode = null): string
    {
        $currency  = self::currencyForLang($lang);
        $returnUrl = rtrim($siteUrl, '/') . "/{$lang}/buy-tokens?payment=";

        // No periodicity: that is what makes it a one-time purchase
        $offerId = (string)($this->env['TOKENS_LAVA_OFFER_ID'] ?? '');
        $invoice = [
            'email'                 => $email,
            'offerId'               => $offerId,
            'currency'              => $currency,
            'buyerLanguage'         => ['ru' => 'RU', 'es' => 'ES'][$lang] ?? 'EN',
            'successful_return_url' => $returnUrl . 'success',
            'failure_return_url'    => $returnUrl . 'failed',
            'cancel_return_url'     => $returnUrl . 'cancelled',
        ];

        // A dynamic-price offer has no price of its own: Lava needs the amount in the invoice
        $price = $this->packPrice($offerId, $currency);
        if ($promoCode !== null) {
            $discount = $this->promoDiscount($user, $offerId, $promoCode);
            if ($price === null) {
                // A configuration error, not the buyer's: reported as a failed checkout
                throw new RuntimeException("No price in config.php 'lava_products' for offer {$offerId} in {$currency}: can't apply promo code {$promoCode}");
            }
            $price = round($price * (100 - $discount) / 100, 2);
            if ($price <= 0) {
                $this->grantFree($user, $email, $currency, $promoCode);
                return $returnUrl . 'success';
            }
        }
        if ($price !== null) {
            $invoice['amount'] = $price;
        }

        $contract = $this->lava->createInvoice($invoice);

        $stmt = $this->dbh->prepare("INSERT INTO tokens_purchases (contract_id, user_id, email, tokens, currency, promo_code)
            VALUES (:contract_id, :user_id, :email, :tokens, :currency, :promo_code)");
        $stmt->execute([
            ':contract_id' => $contract['id'],
            ':user_id'     => $user->getId(),
            ':email'       => $email,
            ':tokens'      => $this->packTokens(),
            ':currency'    => $currency,
            ':promo_code'  => $promoCode,
        ]);

        return $contract['paymentUrl'];
    }

    /**
     * A 100%-discount purchase: Lava can't invoice a zero amount, so it's recorded as paid
     * right away under a contract id of our own, and the pack is credited
     */
    private function grantFree(User $user, string $email, string $currency, string $promoCode): void
    {
        $this->dbh->beginTransaction();
        try {
            $stmt = $this->dbh->prepare("INSERT INTO tokens_purchases (contract_id, user_id, email, tokens, currency, promo_code, status, amount, paid_at)
                VALUES (:contract_id, :user_id, :email, :tokens, :currency, :promo_code, 'paid', 0, CURRENT_TIMESTAMP)");
            $stmt->execute([
                ':contract_id' => self::newUuid(),
                ':user_id'     => $user->getId(),
                ':email'       => $email,
                ':tokens'      => $this->packTokens(),
                ':currency'    => $currency,
                ':promo_code'  => $promoCode,
            ]);
            $this->creditTokens((string)$user->getId(), $this->packTokens());
            $this->dbh->commit();
        } catch (Throwable $error) {
            if ($this->dbh->inTransaction()) {
                $this->dbh->rollBack();
            }
            throw $error;
        }
    }

    /**
     * Add a pack to the balance. A balance left slightly negative by an overshooting
     * request doesn't eat into the pack.
     */
    private function creditTokens(string $userId, int $tokens): void
    {
        $stmt = $this->dbh->prepare("UPDATE users SET llm_tokens = GREATEST(llm_tokens, 0) + :tokens WHERE id = :user_id");
        $stmt->execute([':tokens' => $tokens, ':user_id' => $userId]);
    }

    private static function newUuid(): string
    {
        $bytes = random_bytes(16);
        $bytes[6] = chr((ord($bytes[6]) & 0x0f) | 0x40); // version 4
        $bytes[8] = chr((ord($bytes[8]) & 0x3f) | 0x80); // RFC 4122 variant
        return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($bytes), 4));
    }

    // Purchase history for the tokens page

    /**
     * @return array<array{paid_at: string, tokens: int, amount: string, currency: string}> Newest first
     */
    public function history(User $user, int $limit = 10): array
    {
        $stmt = $this->dbh->prepare("SELECT paid_at, tokens, amount, currency FROM tokens_purchases
            WHERE user_id = :user_id AND status = 'paid'
            ORDER BY paid_at DESC LIMIT :limit");
        $stmt->bindValue(':user_id', $user->getId());
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->execute();
        return array_map(static fn(array $row) => [
            'paid_at'  => (string)$row['paid_at'],
            'tokens'   => (int)$row['tokens'],
            'amount'   => (string)$row['amount'],
            'currency' => (string)$row['currency'],
        ], $stmt->fetchAll(PDO::FETCH_ASSOC));
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
        if ($productId !== (string)($this->env['TOKENS_LAVA_PRODUCT_ID'] ?? '')) {
            return self::WEBHOOK_IGNORED;
        }

        $this->dbh->beginTransaction();
        try {
            switch ($eventType) {
                case 'payment.success':
                    $result = $this->handlePaid($event);
                    break;
                case 'payment.failed':
                    $result = $this->handleFailed($event);
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
     * Mark the purchase paid and add its pack to the balance, once
     */
    private function handlePaid(array $event): string
    {
        $purchase = $this->findPurchase((string)($event['contractId'] ?? ''));
        if ($purchase === null) {
            ($this->notifyAdmin)(
                'Lava payment without a matching token purchase',
                "A token payment arrived that the site didn't create, so no tokens were added.\n"
                . "Add them manually with scripts/grant_tokens.php if it's genuine.\n\n"
                . self::describeEvent($event)
            );
            return self::WEBHOOK_UNMATCHED;
        }
        if ($purchase['status'] === 'paid') {
            return self::WEBHOOK_DUPLICATE;
        }

        // A late success after a failure still counts: the money did arrive
        $paidAt = new DateTimeImmutable((string)($event['timestamp'] ?? 'now'));
        $stmt = $this->dbh->prepare("UPDATE tokens_purchases SET status = 'paid', amount = :amount, paid_at = :paid_at, error = NULL
            WHERE contract_id = :contract_id");
        $stmt->execute([
            ':amount'      => (float)($event['amount'] ?? 0),
            ':paid_at'     => $paidAt->format('Y-m-d H:i:s'),
            ':contract_id' => $purchase['contract_id'],
        ]);

        $this->creditTokens((string)$purchase['user_id'], (int)$purchase['tokens']);
        return self::WEBHOOK_PROCESSED;
    }

    private function handleFailed(array $event): string
    {
        $purchase = $this->findPurchase((string)($event['contractId'] ?? ''));
        if ($purchase === null) {
            return self::WEBHOOK_UNMATCHED;
        }
        // Only a pending checkout fails; a late or repeated failure must not undo a success
        if ($purchase['status'] !== 'pending') {
            return self::WEBHOOK_DUPLICATE;
        }
        $stmt = $this->dbh->prepare("UPDATE tokens_purchases SET status = 'failed', error = :error WHERE contract_id = :contract_id");
        $stmt->execute([':error' => (string)($event['errorMessage'] ?? ''), ':contract_id' => $purchase['contract_id']]);
        return self::WEBHOOK_PROCESSED;
    }

    private function notifyMoneyReturned(string $eventType, array $event): void
    {
        $email = (string)($event['data']['customer_email'] ?? '');
        $stmt = $this->dbh->prepare("SELECT id, login, llm_tokens FROM users WHERE LOWER(email) = LOWER(:email)");
        $stmt->execute([':email' => $email]);
        $users = array_map(
            static fn($u) => "{$u['id']} ({$u['login']}, balance {$u['llm_tokens']})",
            $stmt->fetchAll(PDO::FETCH_ASSOC)
        );

        ($this->notifyAdmin)(
            "Lava {$eventType}: {$email}",
            "Lava reported {$eventType}. The token balance was NOT changed automatically; deduct the pack\n"
            . "manually if needed: php scripts/grant_tokens.php --user=<email|uuid> --tokens=-<pack size>\n\n"
            . 'Users with this email: ' . ($users ? implode(', ', $users) : 'none') . "\n\n"
            . self::describeEvent($event)
        );
    }

    /**
     * Purchase by its contract id, locked for the rest of the transaction
     */
    private function findPurchase(string $contractId): ?array
    {
        $contractId = self::uuidOrNull($contractId);
        if ($contractId === null) {
            return null;
        }
        $stmt = $this->dbh->prepare("SELECT contract_id, user_id, tokens, status FROM tokens_purchases
            WHERE contract_id = :contract_id FOR UPDATE");
        $stmt->execute([':contract_id' => $contractId]);
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

/**
 * A promo code the buyer entered can't be used: unknown, expired or used up
 */
class InvalidPromoCodeException extends RuntimeException
{
}
