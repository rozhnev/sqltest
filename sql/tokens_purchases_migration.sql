-- Switch from the monthly subscription to token purchases (see TOKEN_PURCHASE_PLAN.md).
-- Apply sql/tokens_purchases_ddl.sql first.

-- Dev database only: the subscription tables never existed on prod.
DROP TABLE IF EXISTS public.subscription_payments, public.subscriptions;

-- Both databases, after the code that no longer reads subscribed_till is deployed.
ALTER TABLE public.users DROP COLUMN IF EXISTS subscribed_till;
