--
-- Migration: interview_entitlements for Lava.top payments
-- (INTERVIEW_SIMULATION_PLAN.md, п. 3.5, Вариант B — single-table approach).
-- A checkout inserts a 'pending' row with the Lava.top contract id; the payment
-- webhook flips it to 'active'. Existing manual/promo rows become 'active'.
--

ALTER TABLE public.interview_entitlements
    ADD COLUMN status varchar(16) NOT NULL DEFAULT 'active'
        CHECK (status IN ('pending','active','failed','refunded')),
    ADD COLUMN lava_contract_id uuid UNIQUE,   -- NULL for manual/promo
    ADD COLUMN lava_offer_id uuid,
    ADD COLUMN amount numeric(12,2),
    ADD COLUMN currency varchar(3),
    ADD COLUMN paid_at timestamp,
    ADD COLUMN raw_webhook jsonb;

GRANT INSERT, UPDATE ON public.interview_entitlements TO sqltester;
GRANT USAGE ON SEQUENCE public.interview_entitlements_id_seq TO sqltester;
