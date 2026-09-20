--
-- interview_entitlements — "user is allowed to take N interview sessions"
-- (see INTERVIEW_SIMULATION_PLAN.md, п. 3.5, Вариант A: manually granted
-- after off-system payment, no billing integration yet). A user can be
-- granted access more than once over time (repeat purchase), so the row
-- identity is a surrogate id, not user_id.
--
-- Interview::checkAccess() reads this as the single source of truth so a
-- future Вариант B (real payment integration, п. 3.5) only needs to start
-- writing rows here -- no change to the rest of the feature.
--

CREATE TABLE public.interview_entitlements (
    id SERIAL NOT NULL,
    user_id uuid NOT NULL,
    granted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp without time zone,
    sessions_total smallint NOT NULL,
    sessions_used smallint DEFAULT 0 NOT NULL,
    source character varying(16) DEFAULT 'manual'::character varying NOT NULL,
    CONSTRAINT interview_entitlements_source_check
        CHECK (((source)::text = ANY ((ARRAY['manual'::character varying, 'lava'::character varying, 'promo'::character varying])::text[]))),
    CONSTRAINT interview_entitlements_sessions_used_check
        CHECK ((sessions_used >= 0) AND (sessions_used <= sessions_total))
);


ALTER TABLE public.interview_entitlements OWNER TO dba;

--
-- Name: interview_entitlements interview_entitlements_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_entitlements
    ADD CONSTRAINT interview_entitlements_pkey PRIMARY KEY (id);


--
-- Name: interview_entitlements interview_entitlements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_entitlements
    ADD CONSTRAINT interview_entitlements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Lookup index: Interview::checkAccess() finds the user's active grant(s)
-- with remaining sessions.
--

CREATE INDEX interview_entitlements_user_id_idx ON public.interview_entitlements USING btree (user_id);


--
-- Name: TABLE interview_entitlements; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.interview_entitlements TO sqltester;
