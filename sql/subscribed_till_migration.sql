-- Stage 1 of LESSON_ASSISTANT_PLAN.md: subscription flag + AI token balance.

-- Phase 1: before deploying the code (already applied on prod).
-- Exclusive subscription end: payment on Sep 24 -> subscribed_till = Oct 24, active through Oct 23.
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS subscribed_till date;
-- Remaining LLM tokens: the user's whole AI balance. May go slightly negative
-- after one overshooting request, so there is no >= 0 check.
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS llm_tokens integer NOT NULL DEFAULT 0;
-- Existing users get the one-time free allowance (same value as LLM_FREE_TOKENS).
UPDATE public.users SET llm_tokens = 50000;

-- Phase 2: after the code using subscribed_till is deployed.
-- No real subscribers/donors exist yet, so hide_ad_till data is not copied.
ALTER TABLE public.users DROP COLUMN IF EXISTS hide_ad_till;
