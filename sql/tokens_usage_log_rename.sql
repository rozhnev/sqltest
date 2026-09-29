-- Rename llm_usage_log to tokens_usage_log, with its sequence, constraints and index.
--
-- Step 1: run BEFORE deploying the code that uses tokens_usage_log. The view keeps the old
-- name working (a simple view is insertable), so charges made by the old code during the
-- deploy still land in the table.
BEGIN;
ALTER TABLE public.llm_usage_log RENAME TO tokens_usage_log;
ALTER SEQUENCE public.llm_usage_log_id_seq RENAME TO tokens_usage_log_id_seq;
-- Renaming the primary key also renames its index
ALTER TABLE public.tokens_usage_log RENAME CONSTRAINT llm_usage_log_pkey TO tokens_usage_log_pkey;
ALTER TABLE public.tokens_usage_log RENAME CONSTRAINT llm_usage_log_user_id_fkey TO tokens_usage_log_user_id_fkey;
ALTER INDEX public.llm_usage_log_user_created_idx RENAME TO tokens_usage_log_user_created_idx;

CREATE VIEW public.llm_usage_log AS SELECT * FROM public.tokens_usage_log;
ALTER VIEW public.llm_usage_log OWNER TO dba;
GRANT SELECT, INSERT ON public.llm_usage_log TO sqltester;
COMMIT;

-- Step 2: AFTER the new code is deployed.
-- DROP VIEW public.llm_usage_log;
