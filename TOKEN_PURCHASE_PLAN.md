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
| Promo codes | Kept: optional `promoCode` on the invoice (already implemented) |
| Refund / chargeback | Notify only (unchanged): log the event and email the admin; the admin deducts tokens manually with a script |
| Binding payment → user | By the contract id we get when *we* create the invoice (unchanged) |
| Quota display | The remaining balance as a number (e.g. "412K tokens left"). There is no plan size any more, so "% of plan used" no longer makes sense. Replaces the "no raw token numbers in the UI" rule of `LESSON_ASSISTANT_PLAN.md` |
| Pack price | Set in Lava (RUB and USD prices of the offer); the site shows no price of its own |

## Lava.top API (from `https://gate.lava.top/docs/documentation.yaml`)

- Auth: header `X-Api-Key: <API key>`.
- **Create invoice**: `POST /api/v3/invoice`, body:
  `email`, `offerId`, `currency` (`RUB|USD|EUR`), `paymentProvider`, `paymentMethod`, `buyerLanguage` (`EN|RU|ES`),
  `promoCode` (optional), `successful_return_url`, `failure_return_url`, `cancel_return_url`.
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
    promo_code   varchar(36),
    status       varchar(16) NOT NULL DEFAULT 'pending', -- pending | paid | failed
    amount       numeric(12,2),                       -- charged amount from the webhook (after a promo discount)
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

- `checkoutAvailable()`, `isValidWebhookKey()`, `normalizePromoCode()`: moved over unchanged.
- `startCheckout(User $user, string $email, string $lang, string $siteUrl, ?string $promoCode): string`
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
- **Buy**: pack size, "one-time payment, tokens never expire", optional promo code, "Buy" button.
- **`?payment=success`**: "Payment received, the tokens appear in a moment"; auto-refresh once (the webhook can
  lag behind the redirect). **`failed|cancelled`**: short message + the Buy button.
- **History**: the last purchases (date, tokens, amount).
- Short errors (`tokens_error_checkout`, `tokens_error_promo_code`) in `translations/`; page title too.

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
- checkout: pending row with the pack size, no `periodicity`, currency by language, `promoCode` only when given
- `payment.success` adds the pack; the same webhook again → `duplicate`, balance unchanged
- a negative balance is raised to 0 before the pack is added
- two purchases add up
- a 100%-discount payment (`amount: 0`) still credits the full pack
- `payment.failed` → `failed`, nothing credited; a late success after it still credits
- other product / unknown contract → `ignored` / `unmatched` (admin notified)
- refund / chargeback → admin notified, balance unchanged
- webhook auth: missing/wrong key → 401
- `TokenQuota` without subscriptions: remaining, exhausted, charging

## Rollout

1. In Lava: create a one-time digital product "AI tokens" with one offer (RUB and USD prices); note the offer
   and product ids. The webhook URL and secret stay the same.
2. Dev: apply `sql/token_purchases_ddl.sql`, drop the subscription tables, set the new `.env` keys, deploy.
3. Test on dev with the promo code `TESTFREE` (100% discount; Lava has no sandbox, so this is a real purchase
   that costs nothing). Check:
   - the invoice is accepted with the code and the Lava page shows a zero price;
   - `payment.success` arrives (`lava_webhook_log`) with `amount` 0, the purchase is `paid` and the balance
     grew by the pack;
   - the return to `/buy-tokens?payment=success` shows the new balance.
   If Lava doesn't create an invoice or send a webhook for a zero amount, repeat with `FIRST10` (90% discount):
   a real payment of 10% of the price, and `amount` in the webhook is the discounted sum.
   `TESTFREE` is limited to 10 uses in Lava; disable it once testing is done, since anyone who knows it gets free
   tokens.
4. Prod: apply `sql/token_purchases_ddl.sql`, deploy, then drop `users.subscribed_till`.
5. Update `LESSON_ASSISTANT_PLAN.md` (subscription parts) and `.github/database-schema.md`.
