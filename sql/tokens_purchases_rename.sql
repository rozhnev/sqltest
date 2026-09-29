-- Rename token_purchases to tokens_purchases, with its constraints and index.
--
-- Step 1: run BEFORE deploying the code that uses tokens_purchases. The view keeps the old
-- name working (a simple view is insertable and updatable), so checkouts and Lava webhooks
-- handled by the old code during the deploy still land in the table.
BEGIN;
ALTER TABLE public.token_purchases RENAME TO tokens_purchases;
-- Renaming the primary key also renames its index
ALTER TABLE public.tokens_purchases RENAME CONSTRAINT token_purchases_pkey TO tokens_purchases_pkey;
ALTER TABLE public.tokens_purchases RENAME CONSTRAINT token_purchases_user_id_fkey TO tokens_purchases_user_id_fkey;
ALTER TABLE public.tokens_purchases RENAME CONSTRAINT token_purchases_status_check TO tokens_purchases_status_check;
ALTER TABLE public.tokens_purchases RENAME CONSTRAINT token_purchases_tokens_check TO tokens_purchases_tokens_check;
ALTER INDEX public.token_purchases_user_created_idx RENAME TO tokens_purchases_user_created_idx;

CREATE VIEW public.token_purchases AS SELECT * FROM public.tokens_purchases;
ALTER VIEW public.token_purchases OWNER TO dba;
GRANT SELECT, INSERT, UPDATE ON public.token_purchases TO sqltester;
COMMIT;

-- Step 2: AFTER the new code is deployed.
-- DROP VIEW public.token_purchases;
