--
-- Automatic subscriptions via Lava.top (see SUBSCRIPTION_PLAN.md).
-- The subscription state itself stays in users.subscribed_till / users.llm_tokens
-- (User::grantSubscription()); these tables track the Lava contracts behind it.
--

-- One row per subscription: the first (parent) Lava contract, created by our checkout
CREATE TABLE public.subscriptions (
    contract_id uuid NOT NULL,
    user_id uuid NOT NULL,
    email text NOT NULL,                                -- email sent to Lava (needed to cancel)
    currency character varying(3) NOT NULL,
    status character varying(16) DEFAULT 'pending' NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    activated_at timestamp without time zone,
    cancelled_at timestamp without time zone,
    renewal_failed_at timestamp without time zone,      -- last failed renewal, cleared by a successful one
    renewal_error text,
    CONSTRAINT subscriptions_pkey PRIMARY KEY (contract_id),
    CONSTRAINT subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
    CONSTRAINT subscriptions_status_check CHECK (status IN ('pending', 'active', 'failed', 'cancelled'))
);

CREATE INDEX subscriptions_user_created_idx ON public.subscriptions USING btree (user_id, created_at);
CREATE INDEX subscriptions_email_idx ON public.subscriptions USING btree (lower(email));

-- One row per successful payment (first or renewal): the idempotency key for grants,
-- since Lava retries webhooks
CREATE TABLE public.subscription_payments (
    contract_id uuid NOT NULL,                          -- Lava contract id of this payment
    subscription_id uuid NOT NULL,
    amount numeric(12,2) NOT NULL,
    currency character varying(3) NOT NULL,
    paid_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT subscription_payments_pkey PRIMARY KEY (contract_id),
    CONSTRAINT subscription_payments_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(contract_id)
);

CREATE INDEX subscription_payments_subscription_idx ON public.subscription_payments USING btree (subscription_id);

-- Every webhook received from Lava, raw: debugging, refunds/chargebacks, events we couldn't match
CREATE TABLE public.lava_webhook_log (
    id bigserial NOT NULL,
    event_type character varying(64),
    contract_id uuid,
    body jsonb NOT NULL,
    received_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    result character varying(16) DEFAULT 'received' NOT NULL, -- received | processed | duplicate | ignored | unmatched | error
    error text,
    CONSTRAINT lava_webhook_log_pkey PRIMARY KEY (id)
);


ALTER TABLE public.subscriptions OWNER TO dba;
ALTER TABLE public.subscription_payments OWNER TO dba;
ALTER TABLE public.lava_webhook_log OWNER TO dba;

GRANT SELECT, INSERT, UPDATE ON TABLE public.subscriptions TO sqltester;
GRANT SELECT, INSERT ON TABLE public.subscription_payments TO sqltester;
GRANT SELECT, INSERT, UPDATE ON TABLE public.lava_webhook_log TO sqltester;
GRANT USAGE ON SEQUENCE public.lava_webhook_log_id_seq TO sqltester;


--
-- Admin snippets
--

-- A user's subscriptions and payments:
-- SELECT s.contract_id, s.status, s.created_at, s.activated_at, s.cancelled_at, s.renewal_failed_at,
--        p.contract_id AS payment_contract_id, p.amount, p.currency, p.paid_at
-- FROM public.subscriptions s LEFT JOIN public.subscription_payments p ON p.subscription_id = s.contract_id
-- WHERE s.user_id = :user_id ORDER BY s.created_at DESC, p.paid_at;

-- Webhooks that need attention:
-- SELECT id, received_at, event_type, result, error, body
-- FROM public.lava_webhook_log WHERE result IN ('unmatched', 'error') ORDER BY id DESC;
