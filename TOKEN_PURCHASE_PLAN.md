# AI Token Purchase (Lava.top): Implementation Plan

## Goal

Sell AI tokens as a one-time purchase instead of a monthly subscription. A user buys a token pack
through Lava.top; the payment webhook adds the pack to their AI balance (`users.llm_tokens`), which the
lesson assistant and free-answer checks already spend (`LESSON_ASSISTANT_PLAN.md`).

This replaces the monthly subscription (checkout → renewals → cancellation) built on this branch.
The subscription never reached production (it exists only on `lesson_llm_integration` and the dev
database), so there are no subscribers to migrate.

## Decisions (agreed)

| Topic | Decision |
|---|---|
| What is sold | **One pack** of `LLM_PACK_TOKENS` = 1 000 000 tokens (the old monthly budget): one Lava one-time product with one offer (RUB and USD prices). Users buy it again when they run out |
| Balance | A purchase **adds** the pack to `users.llm_tokens` (a slightly negative balance is first raised to 0). The one-time free allowance for new accounts stays: `LLM_FREE_TOKENS` = 50 000 |
| Expiry | Purchased tokens **never expire** |
| Ads | **No ads for anyone.** Ads are no longer tied to payments; the `showAd()` / `subscribed` flag and the ad slots are removed |
| Donation widget | Shown to **everyone** (it isn't an ad) |
| Subscription | **Removed**: recurring checkout, renewals, cancellation, `subscribed_till` |
| Currency | By site language (unchanged): `ru` → RUB, all other languages → USD |
| Promo codes | Defined per offer in `config.php` → `lava_products[<offer id>]['promo_codes']` (percent `discount`, optional `expires`, `max_uses`, `max_uses_per_user` = 1 by default; uses counted from paid purchases). The discount is applied on our side to the price sent as `amount`; Lava never sees the code. A 100% code skips Lava (it can't invoice 0) and credits the pack right away |
| Refund / chargeback | Notify only (unchanged): log the event and email the admin; the admin deducts tokens manually with a script |
| Binding payment → user | By the contract id we get when *we* create the invoice (unchanged) |
| Quota display | The remaining balance as a number (e.g. "412K tokens left"). There is no plan size any more, so "% of plan used" no longer makes sense. Replaces the "no raw token numbers in the UI" rule of `LESSON_ASSISTANT_PLAN.md` |
| Pack price | The offer has a dynamic price in Lava, so the invoice carries `amount` from `config.php` → `lava_products[<TOKENS_LAVA_OFFER_ID>]['prices']` (per currency). Without them the offer's own price is used (for a fixed-price offer) |

## Lava.top API (from `https://gate.lava.top/docs/documentation.yaml`)

- Auth: header `X-Api-Key: <API key>`.
- **Create invoice**: `POST /api/v3/invoice`, body:
  `email`, `offerId`, `currency` (`RUB|USD|EUR`), `paymentProvider`, `paymentMethod`, `buyerLanguage` (`EN|RU|ES`),
  `amount` (for a dynamic-price offer), `successful_return_url`, `failure_return_url`, `cancel_return_url`.
  **No `periodicity`**: that is what makes it a one-time purchase.
  Response `201`: `id` (contract id), `status`, `paymentUrl`.
  - `buyerLanguage` only sets the language of Lava's emails, not of the payment page.
- **Webhook**: unchanged endpoint and auth. One-time purchases send:

| `eventType` | `status` | Meaning |
|---|---|---|
| `payment.success` | `completed` | Paid: credit the pack |
| `payment.failed` | `failed` | Not paid (`errorMessage`) |
| `refund.success`, `chargeback.initiated` | — | Different shape: `event_type`, `data.customer_email`, `data.product.product_id`, no contract id |

Subscription events (`subscription.*`, `status: subscription-*`) are no longer expected; if one arrives it is
logged as `ignored`.

## Stage 1: Storage

New DDL `sql/token_purchases_ddl.sql` (replaces `sql/subscription_ddl.sql`):

```sql
-- One row per checkout: the Lava contract created by our invoice
CREATE TABLE public.token_purchases (
    contract_id  uuid PRIMARY KEY,                    -- Lava contract id
    user_id      uuid NOT NULL REFERENCES public.users(id),
    email        text NOT NULL,                       -- email sent to Lava
    tokens       integer NOT NULL,                    -- pack size at checkout time
    currency     varchar(3) NOT NULL,
    status       varchar(16) NOT NULL DEFAULT 'pending', -- pending | paid | failed
    amount       numeric(12,2),                       -- charged amount from the webhook
    created_at   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    paid_at      timestamp,
    error        text                                 -- Lava's errorMessage for a failed payment
);
CREATE INDEX token_purchases_user_idx ON public.token_purchases (user_id, created_at);
```

- `tokens` is stored per purchase, so changing `LLM_PACK_TOKENS` doesn't affect checkouts already in progress.
- `lava_webhook_log` is kept as is.
- **Crediting is idempotent** through the status change, in one transaction:
  ```sql
  UPDATE token_purchases SET status = 'paid', amount = :amount, paid_at = :paid_at
      WHERE contract_id = :contract_id AND status <> 'paid'
      RETURNING user_id, tokens;
  -- only if a row came back:
  UPDATE users SET llm_tokens = GREATEST(llm_tokens, 0) + :tokens WHERE id = :user_id;
  ```
  A repeated `payment.success` updates nothing and credits nothing. A late success after a `failed` still credits.

Cleanup migration `sql/token_purchases_migration.sql`:
- Dev database only (the tables never existed on prod): `DROP TABLE subscription_payments, subscriptions`.
- Both databases, **after** the new code is deployed: `ALTER TABLE users DROP COLUMN subscribed_till`.

## Stage 2: `lib/LavaClient.php`

Keep `createInvoice()` and error handling. Remove `cancelSubscription()`.

## Stage 3: `lib/TokenPurchase.php` (replaces `lib/Subscription.php`)

- `checkoutAvailable()`, `isValidWebhookKey()`: moved over unchanged.
- `startCheckout(User $user, string $email, string $lang, string $siteUrl): string`
  → payment URL. Same as today minus `periodicity`; inserts a `pending` row with `tokens = LLM_PACK_TOKENS`.
  Return URLs: `https://{host}/{lang}/buy-tokens?payment=success|failed|cancelled`.
- `receiveWebhook(string $body)` / `handleWebhook(array $event)`: log first, then in one transaction:
  - product isn't `TOKENS_LAVA_PRODUCT_ID` → `ignored`
  - `payment.success` → credit as in Stage 1 → `processed` or `duplicate`; unknown contract → `unmatched` + admin email
  - `payment.failed` → `failed` (only from `pending`)
  - `refund.success`, `chargeback.initiated` → admin email, no state change
  - anything else → `ignored`
- `history(User $user, int $limit = 10): array` → the user's recent paid purchases for the page.

## Stage 4: Balance and ads

- **`User`**: remove `subscribed`, `subscribedTill`, `isSubscribed()`, `showAd()`, `grantSubscription()` and the
  `subscribed_till` columns in the login queries.
- **`TokenQuota`**: remove `planSize()`, the lazy "subscription expired → 0" rule and `resets_at`.
  `status()` returns the remaining balance (rounded for display) and `exhausted`.
- **Quota messages**: `ai_quota_exceeded_free` / `ai_quota_exceeded_subscriber` become one
  `ai_quota_exceeded` with a link to the tokens page.
- **Ads removed**:
  - `Controller`: the three referral-link blocks guarded by `showAd()` (after query / answer / free-answer checks),
    and the `Book` lookup for question pages.
  - The affiliate book cards (`referal-add-block`) in the database and theory pages of all languages, and the
    "Python for Beginners" partner promo on the Sakila page.
- **Donations stay, for everyone**: the donation widget (`lesson.tpl`, `playground.tpl`, theory and data engineer
  pages) and the Ko-fi button in the lesson menu (`menu_small_add_placeholder`) are no longer gated by `showAd()`.

## Stage 5: Routes & controller

| Route | Method | Handler |
|---|---|---|
| `/{lang}/buy-tokens` | GET | `Controller::buy_tokens()`: the purchase page |
| `/{lang}/buy-tokens/checkout` | POST | `Controller::buy_tokens_checkout()` → 303 to Lava `paymentUrl` |
| `/{lang}/buy-tokens/email` | POST | `Controller::buy_tokens_email()`: save the email Lava needs |
| `/lava/webhook` | POST | `Controller::lava_webhook()`, unchanged apart from the class it calls |
| `/{lang}/subscribe`, `/{lang}/tokens` | GET | 301 → `/{lang}/buy-tokens` |

Removed: `/{lang}/subscribe/cancel`, `/{lang}/subscribe/checkout`, `/{lang}/subscribe/email`.
Checkout and email stay POST only, logged in, same-origin check.

## Stage 6: Tokens page

Shared shell `templates/tokens.tpl`, text in `templates/{lang}/tokens.tpl` (all six languages, at least `en` and `ru`),
built from `subscribe.tpl`:
- **Not logged in**: login prompt.
- **No email on the account**: the email form (unchanged).
- **Balance**: remaining tokens, and what they're for (lesson assistant, free-answer checks).
- **Buy**: pack size, "one-time payment, tokens never expire", "Buy" button, no-refund note.
- **`?payment=success`**: "Payment received, the tokens appear in a moment"; auto-refresh once (the webhook can
  lag behind the redirect). **`failed|cancelled`**: short message + the Buy button.
- **History**: the last purchases (date, tokens, amount).
- Page text and short errors (`tokens_*`) in `translations/`.

Links to the page: the quota-exceeded message, the lesson assistant's balance line, the top menu if there was a
"Subscribe" item.

## Stage 7: Config

`.env`:

| Key | Purpose |
|---|---|
| `LAVA_API_KEY`, `LAVA_API_URL`, `LAVA_WEBHOOK_SECRET` | Unchanged |
| `LLM_PACK_TOKENS` | Tokens in one pack (default 1 000 000) |
| `TOKENS_LAVA_OFFER_ID` | Offer (price) id of the token pack product |
| `TOKENS_LAVA_PRODUCT_ID` | Product id, to filter webhooks |
| `LAVA_PROVIDER_RUB`, `LAVA_METHOD_RUB`, `LAVA_PROVIDER_USD`, `LAVA_METHOD_USD` | Renamed from `SUBSCRIPTION_LAVA_*` |
| `LAVA_ADMIN_EMAIL` | Renamed from `SUBSCRIPTION_ADMIN_EMAIL` |

Removed: `LLM_SUBSCRIBER_CYCLE_TOKENS`, `SUBSCRIPTION_LAVA_OFFER_ID`, `SUBSCRIPTION_LAVA_PRODUCT_ID`.

`scripts/grant_subscription.php` becomes `scripts/grant_tokens.php --user=<email|uuid> --tokens=<n>`, for manual
fixes; a negative `--tokens` deducts after a refund or chargeback.

## Stage 8: Tests

Replace `tests/unit/SubscriptionUnitTest.php` with `TokenPurchaseUnitTest.php` (test DB, fake `LavaClient`,
the spec's example payloads):
- checkout: pending row with the pack size, no `periodicity`, currency by language, `amount` from `lava_products`
- `payment.success` adds the pack; the same webhook again → `duplicate`, balance unchanged
- a negative balance is raised to 0 before the pack is added
- two purchases add up
- a 100%-discount payment (`amount: 0`) still credits the full pack
- `payment.failed` → `failed`, nothing credited; a late success after it still credits
- other product / unknown contract → `ignored` / `unmatched` (admin notified)
- refund / chargeback → admin notified, balance unchanged
- webhook auth: missing/wrong key → 401
- `TokenQuota` without subscriptions: remaining, exhausted, charging

## Deploy checklist

Tick the boxes as you go. Order matters where noted.

### Before deploy day

- [ ] **Rotate the Lava API key** (it was pasted in a chat): Lava profile → Integration → new key; update `LAVA_API_KEY` on dev.
- [ ] **Lava payouts**: confirm Lava.top can pay out to you as you are now (account/card, currency, required documents).
- [ ] **One real purchase on dev, end to end** (with `FIRST10`, 90% off):
  - [ ] the Lava payment page opens with the discounted price;
  - [ ] after paying, `SELECT id, event_type, result, error FROM lava_webhook_log ORDER BY id DESC LIMIT 5;` shows `payment.success` → `processed`;
  - [ ] `SELECT status, amount, promo_code, paid_at FROM token_purchases ORDER BY created_at DESC LIMIT 1;` shows `paid`;
  - [ ] the balance on `/ru/buy-tokens` and in the profile grew by the pack; the purchase is in the history.
- [ ] **A 100% code on dev** (`TESTFREE`): tokens are credited at once, without Lava.
- [ ] **Wrong webhook secret is refused**: `curl -s -o /dev/null -w '%{http_code}' -X POST https://dev.sqltest.online/lava/webhook -H 'X-Api-Key: wrong' -d '{}'` → `401`.
- [ ] **Phone check**: open `/ru/buy-tokens` on a phone; the cards stack, the buttons fit.

### Production database (before deploying the code)

- [ ] Back up the database.
- [ ] `users.llm_tokens` exists (phase 1 of `sql/subscribed_till_migration.sql`, already applied on prod): `\d users`.
- [ ] `llm_usage_log` exists; if not, apply `sql/llm_usage_log_ddl.sql`.
- [ ] Apply `sql/token_purchases_ddl.sql` (creates `token_purchases`; `lava_webhook_log` only if missing).

### Production configuration

- [ ] `.env`:
  - [ ] `LAVA_API_KEY` (the new one), `LAVA_API_URL=https://gate.lava.top`
  - [ ] `LAVA_WEBHOOK_SECRET`: a long random value, e.g. `openssl rand -hex 32`
  - [ ] `TOKENS_LAVA_OFFER_ID=7ec77746-effb-415a-b93d-7d6bfc8796a6`, `TOKENS_LAVA_PRODUCT_ID=a636666c-3745-4a2b-9876-630cfa3ba800`
  - [ ] `LAVA_ADMIN_EMAIL` (refunds, chargebacks, unmatched payments)
  - [ ] `LLM_FREE_TOKENS`, `LLM_PACK_TOKENS`, `LLM_MIN_TOKENS_PER_REQUEST`, `LLM_LOW_BALANCE_TOKENS`
  - [ ] `LESSON_ASSISTANT_ENABLED`: `admin` for a staged start, then the value that enables it for everyone
  - [ ] `VERSION`: bump it, so browsers reload the changed CSS and JS
- [ ] `config.php`: the `lava_products` block with RUB, USD and EUR prices and the promo codes (as in `config.php.example`).
- [ ] Lava profile → webhook: URL `https://sqltest.online/lava/webhook`, auth "API key" = `LAVA_WEBHOOK_SECRET`.

### Deploy

- [ ] Merge `lesson_llm_integration` into `main`; wait for the "Auto-minify assets" commit (`style.min.css`, `css/lesson.min.css`) before deploying.
- [ ] `composer dump-autoload` on the server (new classes: `TokenPurchase`, `LavaClient`).
- [ ] Deploy.

### Right after deploy

- [ ] `/ru/buy-tokens` and `/en/buy-tokens` load; `/ru/subscribe` and `/ru/tokens` redirect to them.
- [ ] Log in: the profile shows the balance and the "AI tokens" tab.
- [ ] The lesson assistant answers a question and the balance goes down.
- [ ] Webhook auth: the `curl` above against `https://sqltest.online/lava/webhook` → `401`.
- [ ] One real purchase on prod with a promo code; check `lava_webhook_log` and the balance as on dev.
- [ ] Security headers: `curl -sI https://sqltest.online/ | grep -iE "strict|nosniff|frame|set-cookie"`.

### After a few days

- [ ] Nothing stuck: `SELECT * FROM lava_webhook_log WHERE result IN ('unmatched', 'error') ORDER BY id DESC;`
      and `SELECT * FROM token_purchases WHERE status = 'pending' AND created_at < now() - interval '1 day';`
      A pending row the buyer actually paid for (check in Lava) means a lost webhook. Mark it paid first, so a late
      webhook is ignored as a duplicate, then credit the pack:
      `UPDATE token_purchases SET status = 'paid', paid_at = now() WHERE contract_id = '<id>';` and
      `php scripts/grant_tokens.php --user=<email> --tokens=<pack>`.
- [ ] Drop `users.subscribed_till`: `sql/token_purchases_migration.sql` (its subscription-table part is for dev only).
- [ ] In Lava: disable the unused `TESTFREE` / `FIRST10` codes (the site's codes live in `config.php`).
- [ ] Keep Lava payout statements and LLM/hosting invoices from the first sale.
