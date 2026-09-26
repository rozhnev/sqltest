# Subscription Full Cycle (Lava.top): Implementation Plan

## Goal

Replace the manual subscription grant (`scripts/grant_subscription.php`) with a fully automatic cycle:
checkout → first payment → monthly renewals → cancellation, driven by the Lava.top API and webhooks.
The subscription itself stays what `LESSON_ASSISTANT_PLAN.md` defined: `users.subscribed_till`
(exclusive end) plus the AI balance reset in `User::grantSubscription()`.

## Decisions (agreed)

| Topic | Decision |
|---|---|
| Currency | By site language: `ru` → RUB, all other languages → USD |
| Refund / chargeback | Notify only: log the event and email the admin; no automatic revoke |
| Cancel button | Yes, on `/subscribe`, via the Lava API. The paid period is kept |
| Failed renewal | No early revoke: the subscription runs out at `subscribed_till`. The subscribe page shows a "payment failed" banner |
| Binding payment → user | By the contract id we get when *we* create the invoice (not by email matching) |
| Interview product | Out of scope; its webhooks are logged and ignored (can reuse this later) |

## Lava.top API (from `https://gate.lava.top/docs/documentation.yaml`)

- Auth: header `X-Api-Key: <API key>`.
- **Create invoice**: `POST /api/v3/invoice`, body:
  `email`, `offerId`, `currency` (`RUB|USD|EUR`), `periodicity: "MONTHLY"`, `paymentProvider`
  (`SMART_GLOCAL|UNLIMINT|PAYPAL|PAY2ME`), `paymentMethod` (`CARD|SBP|PAYPAL|PIX`), `buyerLanguage` (`EN|RU|ES`),
  `successful_return_url`, `failure_return_url`, `cancel_return_url`.
  Response `201`: `id` (contract id), `status`, `paymentUrl`.
  - Note: the spec's examples say `UNLIMIT`, the enum says `UNLIMINT`. Verify against the real API.
- **Cancel subscription**: `DELETE /api/v1/subscriptions?contractId=<first contract id>&email=<buyer email>` → `204`.
- **Webhook** (configured in the Lava profile, "Integration" tab): `POST` JSON to our URL, authenticated by
  `X-Api-Key` (or HTTP Basic) with a secret we choose. Non-2xx/3xx responses are retried 19 times
  (1s … 1h), so handling must be idempotent.

| `eventType` | Meaning | Key fields |
|---|---|---|
| `payment.success` (`status: subscription-active`) | First subscription payment | `contractId`, `buyer.email`, `product.id`, `amount`, `currency`, `timestamp` |
| `payment.failed` (`status: subscription-failed`) | First payment failed | `contractId`, `errorMessage` |
| `subscription.recurring.payment.success` | Renewal paid | new `contractId`, `parentContractId` = first contract |
| `subscription.recurring.payment.failed` | Renewal failed | `contractId`, `parentContractId`, `errorMessage` |
| `subscription.cancelled` | Cancelled (by us or the buyer) | `contractId`, `cancelledAt`, `willExpireAt` |
| `refund.success`, `chargeback.initiated` | Different shape: `event_type`, `data.customer_email`, `data.product.product_id`, no contract id | |

## Stage 1: Storage

New DDL `sql/subscription_ddl.sql`:

```sql
-- One row per subscription: the first (parent) Lava contract, created by our checkout
CREATE TABLE public.subscriptions (
    contract_id        uuid PRIMARY KEY,               -- Lava parent contract id
    user_id            uuid NOT NULL REFERENCES public.users(id),
    email              text NOT NULL,                  -- email sent to Lava (needed to cancel)
    currency           varchar(3) NOT NULL,
    status             varchar(16) NOT NULL DEFAULT 'pending', -- pending | active | failed | cancelled
    created_at         timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    activated_at       timestamp,
    cancelled_at       timestamp,
    renewal_failed_at  timestamp,                      -- last failed renewal, cleared by a successful one
    renewal_error      text
);
CREATE INDEX subscriptions_user_idx ON public.subscriptions (user_id, created_at);

-- One row per successful payment (first or renewal): the idempotency key for grants
CREATE TABLE public.subscription_payments (
    contract_id        uuid PRIMARY KEY,               -- Lava contract id of this payment
    subscription_id    uuid NOT NULL REFERENCES public.subscriptions(contract_id),
    amount             numeric(12,2) NOT NULL,
    currency           varchar(3) NOT NULL,
    paid_at            timestamp NOT NULL,
    created_at         timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Raw webhook log: debugging, refunds/chargebacks, events we couldn't match
CREATE TABLE public.lava_webhook_log (
    id                 bigserial PRIMARY KEY,
    event_type         varchar(64),
    contract_id        uuid,
    body               jsonb NOT NULL,
    received_at        timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    result             varchar(32) NOT NULL,           -- processed | duplicate | ignored | unmatched | error
    error              text
);
```

## Stage 2: `lib/LavaClient.php`

Thin HTTP client (curl, 15 s timeout, `X-Api-Key`), no business logic:
- `createSubscriptionInvoice(email, currency, provider, method, language, returnUrls): array{id, paymentUrl}`
- `cancelSubscription(contractId, email): bool`
- Throws `LavaApiException` with the status code and Lava's `error` text on non-2xx.
- Constructed from config; injected into `Subscription` so tests can pass a fake.

## Stage 3: `lib/Subscription.php` (domain logic)

- `startCheckout(User $user, string $lang): string` → payment URL.
  1. Requires the user's email (see Stage 5).
  2. Currency/provider by language: `ru` → `RUB` + `SMART_GLOCAL`; else `USD` + `UNLIMINT` + `CARD`.
  3. `buyerLanguage`: `ru` → `RU`, `es` → `ES`, else `EN`.
  4. Return URLs: `https://{host}/{lang}/subscribe?payment=success|failed|cancelled`.
  5. Insert `subscriptions` row (`pending`) with the returned contract id.
- `handleWebhook(array $event): string` (result for the log), in one DB transaction:
  - Ignore events whose product isn't `SUBSCRIPTION_LAVA_PRODUCT_ID` (`ignored`).
  - `payment.success`: find `subscriptions` by `contractId` (`unmatched` if none) → `INSERT subscription_payments ... ON CONFLICT DO NOTHING`; only if inserted: status `active`, `activated_at`, `User::grantSubscription(date(timestamp))`. Otherwise `duplicate`.
  - `subscription.recurring.payment.success`: same, looking the subscription up by `parentContractId`; also clears `renewal_failed_at`.
  - `payment.failed`: status `failed` (only from `pending`).
  - `subscription.recurring.payment.failed`: set `renewal_failed_at`, `renewal_error`. `subscribed_till` is untouched.
  - `subscription.cancelled`: status `cancelled`, `cancelled_at`. `subscribed_till` is untouched (the paid period is kept).
  - `refund.success`, `chargeback.initiated`: no state change; email the admin (`SUBSCRIPTION_ADMIN_EMAIL`, PHPMailer as in `User`) with the customer email, amount and a link to the user.
  - `unmatched` payments (e.g. paid through an old static link): email the admin too, so the grant can be done manually.
- `cancel(User $user): bool`: `LavaClient::cancelSubscription(contract_id, email)` for the user's `active` subscription; on success mark it `cancelled` right away (the webhook confirms later, idempotently).
- `state(User $user): array` for the page: `none | pending | active | cancelled | failed`, `renewal_failed`, `active_through`.

`grantSubscription()` already handles renewals correctly: `GREATEST(subscribed_till, paid_on) + 1 month`, and it resets the AI balance.

## Stage 4: Routes & controller

| Route | Method | Handler |
|---|---|---|
| `/lava/webhook` | POST | `Controller::lava_webhook()` |
| `/{lang}/subscribe/checkout` | POST | `Controller::subscribe_checkout()` → 303 to Lava `paymentUrl` |
| `/{lang}/subscribe/cancel` | POST | `Controller::subscribe_cancel()` → 303 back to `/subscribe` |

`lava_webhook()`:
1. `hash_equals(LAVA_WEBHOOK_SECRET, X-Api-Key)` else `401`. Fail closed if the secret isn't configured.
2. Decode JSON (`400` if invalid), log the raw body, call `handleWebhook()`, store the result.
3. `200` for processed/duplicate/ignored/unmatched; `500` on DB errors so Lava retries.
4. No session, no Smarty page render.

Checkout and cancel: POST only, logged in, same-origin check (`isSameOriginRequest()`).

## Stage 5: Subscribe page

- **No email on the account** (some OAuth users): an email field saved with `User::setEmail()` before checkout. Lava sends receipts and needs the email to cancel.
- **Not subscribed**: price note + "Subscribe" button (POST form to `/subscribe/checkout`).
- **`?payment=success`**: "Payment received, the subscription activates in a moment" (the webhook can lag behind the redirect); auto-refresh once after a few seconds.
- **`?payment=failed|cancelled`**: short message + the Subscribe button again.
- **Active**: active through `subscribed_till − 1`, AI budget meter, "auto-renews monthly", **Cancel** button (with a JS confirm).
- **Cancelled**: "active through X, won't renew" + "Subscribe again".
- **Renewal failed banner**: "We couldn't charge your card; the subscription ends on X. Update the payment method in Lava or subscribe again."
- Texts in `templates/{lang}/subscribe.tpl` for all languages; short errors in `translations/`.

## Stage 6: Config

`.env`:

| Key | Purpose |
|---|---|
| `LAVA_API_KEY` | API key from the Lava profile |
| `LAVA_API_URL` | `https://gate.lava.top` (default) |
| `LAVA_WEBHOOK_SECRET` | The value Lava sends in `X-Api-Key` to our webhook |
| `SUBSCRIPTION_LAVA_OFFER_ID` | Offer (price) id of the monthly subscription product |
| `SUBSCRIPTION_LAVA_PRODUCT_ID` | Product id, to filter webhooks |
| `SUBSCRIPTION_ADMIN_EMAIL` | Where refund/chargeback/unmatched notifications go |

`SUBSCRIPTION_LAVA_PAYMENT_URL` (static link) is no longer used by the page; keep `scripts/grant_subscription.php` for manual fixes.

## Stage 7: Tests

Against the test DB (`tests/.env.testing`), with a fake `LavaClient` and the spec's example payloads:
- first payment → active, `subscribed_till` +1 month, balance reset; the same webhook again → `duplicate`, no second grant
- renewal via `parentContractId` extends from the current end; clears `renewal_failed_at`
- failed renewal → banner flag, `subscribed_till` unchanged
- cancelled → status only, `subscribed_till` unchanged
- other product / unknown contract → `ignored` / `unmatched`, nothing granted
- webhook auth: missing/wrong key → 401, no DB changes
- checkout stores a `pending` row and returns Lava's `paymentUrl`; currency by language

## Rollout

1. Apply `sql/subscription_ddl.sql`.
2. In Lava: create the monthly subscription product with RUB and USD prices; note the offer and product ids.
3. Configure the webhook in Lava → `https://sqltest.online/lava/webhook`, auth "API key" = `LAVA_WEBHOOK_SECRET`.
4. Deploy; test with a real payment (or Lava's test mode, if available) and check `lava_webhook_log`.
5. Cancel the test subscription from the page; confirm the `subscription.cancelled` webhook arrives.

## Open Questions

- Does Lava.top have a sandbox/test mode for the API and webhooks? If not, the first end-to-end test is a real (refundable) payment.
- Which exact webhook auth Lava sends when "API key" is chosen: the spec says the header `X-Api-Key`. Verify on the first delivery (it's logged).
