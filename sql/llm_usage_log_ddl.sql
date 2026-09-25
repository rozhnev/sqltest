--
-- llm_usage_log — append-only per-call log of user-triggered LLM usage
-- (see LESSON_ASSISTANT_PLAN.md, Stage 2). Used for cost analysis, abuse
-- review and tuning limits. The quota check never reads it: the balance
-- itself is users.llm_tokens, decremented by TokenQuota::charge() in the
-- same transaction as the insert here.
--

CREATE TABLE public.llm_usage_log (
    id bigserial NOT NULL,
    user_id uuid NOT NULL,
    feature character varying(32) NOT NULL,   -- 'lesson_assistant' | 'free_answer'
    ref_id integer,                           -- lesson id / question id
    llm_profile character varying(64) NOT NULL,
    prompt_tokens integer NOT NULL,
    completion_tokens integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.llm_usage_log OWNER TO dba;

ALTER TABLE ONLY public.llm_usage_log
    ADD CONSTRAINT llm_usage_log_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.llm_usage_log
    ADD CONSTRAINT llm_usage_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);

CREATE INDEX llm_usage_log_user_created_idx ON public.llm_usage_log USING btree (user_id, created_at);


GRANT SELECT, INSERT ON TABLE public.llm_usage_log TO sqltester;
GRANT USAGE ON SEQUENCE public.llm_usage_log_id_seq TO sqltester;


--
-- Admin snippets
--

-- User balance against plan size (admins see raw numbers, users only percentages):
-- SELECT id, login, llm_tokens, subscribed_till,
--        CASE WHEN subscribed_till > CURRENT_DATE THEN 1000000 ELSE 50000 END AS plan_size
-- FROM public.users WHERE id = :user_id;

-- Monthly cost by feature and profile:
-- SELECT date_trunc('month', created_at) AS month, feature, llm_profile,
--        COUNT(*) AS calls, SUM(prompt_tokens) AS prompt_tokens, SUM(completion_tokens) AS completion_tokens
-- FROM public.llm_usage_log
-- GROUP BY 1, 2, 3
-- ORDER BY 1 DESC, 2, 3;
