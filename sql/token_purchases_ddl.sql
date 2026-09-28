--
-- AI token purchases via Lava.top (see TOKEN_PURCHASE_PLAN.md).
-- The balance itself is users.llm_tokens; a paid purchase adds its pack to it
-- (TokenPurchase::handleWebhook()).
--

-- One row per checkout: the Lava contract created by our invoice
CREATE TABLE public.token_purchases (
    contract_id uuid NOT NULL,                          -- Lava contract id
    user_id uuid NOT NULL,
    email text NOT NULL,                                -- email sent to Lava
    tokens integer NOT NULL,                            -- pack size at checkout time
    currency character varying(3) NOT NULL,
    promo_code character varying(36),                   -- config.php 'promo_codes'; its discount is already in amount
    status character varying(16) DEFAULT 'pending' NOT NULL,
    amount numeric(12,2),                               -- charged amount from the webhook
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    paid_at timestamp without time zone,
    error text,                                         -- Lava's errorMessage for a failed payment
    CONSTRAINT token_purchases_pkey PRIMARY KEY (contract_id),
    CONSTRAINT token_purchases_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
    CONSTRAINT token_purchases_status_check CHECK (status IN ('pending', 'paid', 'failed')),
    CONSTRAINT token_purchases_tokens_check CHECK (tokens > 0)
);

CREATE INDEX token_purchases_user_created_idx ON public.token_purchases USING btree (user_id, created_at);

-- Every webhook received from Lava, raw: debugging, refunds/chargebacks, events we couldn't match.
-- IF NOT EXISTS: the dev database already has it from the former subscription DDL.
CREATE TABLE IF NOT EXISTS public.lava_webhook_log (
    id bigserial NOT NULL,
    event_type character varying(64),
    contract_id uuid,
    body jsonb NOT NULL,
    received_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    result character varying(16) DEFAULT 'received' NOT NULL, -- received | processed | duplicate | ignored | unmatched | error
    error text,
    CONSTRAINT lava_webhook_log_pkey PRIMARY KEY (id)
);


ALTER TABLE public.token_purchases OWNER TO dba;
ALTER TABLE public.lava_webhook_log OWNER TO dba;

GRANT SELECT, INSERT, UPDATE ON TABLE public.token_purchases TO sqltester;
GRANT SELECT, INSERT, UPDATE ON TABLE public.lava_webhook_log TO sqltester;
GRANT USAGE ON SEQUENCE public.lava_webhook_log_id_seq TO sqltester;


--
-- Admin snippets
--

-- A user's purchases:
-- SELECT contract_id, status, tokens, amount, currency, promo_code, created_at, paid_at, error
-- FROM public.token_purchases WHERE user_id = :user_id ORDER BY created_at DESC;

-- Webhooks that need attention:
-- SELECT id, received_at, event_type, result, error, body
-- FROM public.lava_webhook_log WHERE result IN ('unmatched', 'error') ORDER BY id DESC;
