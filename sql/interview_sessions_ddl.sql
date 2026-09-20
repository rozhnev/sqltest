--
-- interview_sessions / interview_session_questions — the "job interview
-- simulation" session state, analogous to tests/test_questions (see
-- INTERVIEW_SIMULATION_PLAN.md, п. 2.2, 3.1.4, 3.1.5).
--
-- id uses uuidv7() (time-ordered UUID), matching the newer tables in this
-- schema (e.g. donations) rather than the app-generated random UUID used by
-- the older tests table.
--

CREATE TABLE public.interview_sessions (
    id uuid DEFAULT uuidv7() NOT NULL,
    user_id uuid NOT NULL,
    position character varying(32) NOT NULL,
    grade smallint NOT NULL,
    company_key character varying(64),
    self_intro text,
    self_intro_analysis jsonb,
    status character varying(16) DEFAULT 'intro'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    closed_at timestamp without time zone,
    final_score numeric(5,2),
    result jsonb,
    CONSTRAINT interview_sessions_position_check
        CHECK (((position)::text = ANY ((ARRAY['sql_developer'::character varying, 'data_analyst'::character varying])::text[]))),
    CONSTRAINT interview_sessions_status_check
        CHECK (((status)::text = ANY ((ARRAY['intro'::character varying, 'intro_followup'::character varying, 'in_progress'::character varying, 'finished'::character varying])::text[])))
);


ALTER TABLE public.interview_sessions OWNER TO dba;


--
-- Name: interview_sessions interview_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_sessions
    ADD CONSTRAINT interview_sessions_pkey PRIMARY KEY (id);


--
-- Name: interview_sessions interview_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_sessions
    ADD CONSTRAINT interview_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: interview_sessions interview_sessions_grade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_sessions
    ADD CONSTRAINT interview_sessions_grade_fkey FOREIGN KEY (grade) REFERENCES public.grades(id);


--
-- Lookup index: cooldown check (last session by user_id+position+grade) and
-- the anti-duplicate question window (last 3 attempts), see п. 4.4.
--

CREATE INDEX interview_sessions_user_position_grade_idx ON public.interview_sessions USING btree (user_id, position, grade, created_at);


--
-- Enforces "only one active session per user" (п. 1) at the DB level, not
-- just in Interview::checkAccess() -- a partial unique index over the
-- non-finished statuses.
--

CREATE UNIQUE INDEX interview_sessions_one_active_per_user_idx ON public.interview_sessions USING btree (user_id)
    WHERE ((status)::text <> 'finished'::text);


--
-- Name: TABLE interview_sessions; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.interview_sessions TO sqltester;


--
-- interview_session_questions -- per-question state within a session, and
-- (ordered by sequence) the transcript shown on the result page (п. 3.1.5).
--

CREATE TABLE public.interview_session_questions (
    session_id uuid NOT NULL,
    question_id integer NOT NULL,
    sequence smallint NOT NULL,
    category_id integer,
    question_type character varying(32) NOT NULL,
    asked_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    answered_at timestamp without time zone,
    answer_text text,
    last_query text,
    auto_check_ok boolean,
    llm_score smallint,
    llm_closeness character varying(16),
    llm_feedback text,
    attempt_number smallint DEFAULT 1 NOT NULL,
    max_attempts smallint DEFAULT 2 NOT NULL,
    CONSTRAINT interview_session_questions_question_type_check
        CHECK (((question_type)::text = ANY ((ARRAY['query'::character varying, 'answer'::character varying, 'free_answer'::character varying])::text[]))),
    CONSTRAINT interview_session_questions_llm_closeness_check
        CHECK ((llm_closeness IS NULL) OR ((llm_closeness)::text = ANY ((ARRAY['correct'::character varying, 'close'::character varying, 'far'::character varying])::text[])))
);


ALTER TABLE public.interview_session_questions OWNER TO dba;


--
-- Name: interview_session_questions interview_session_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--
-- A question can only appear once per session (a retry updates the same row
-- via attempt_number, it never inserts a second row -- see п. 4.3).
--

ALTER TABLE ONLY public.interview_session_questions
    ADD CONSTRAINT interview_session_questions_pkey PRIMARY KEY (session_id, question_id);


--
-- Name: interview_session_questions interview_session_questions_session_sequence_key; Type: CONSTRAINT; Schema: public; Owner: dba
--
-- Doubles as the index the result page uses to render the transcript in
-- order (ORDER BY sequence within one session_id).
--

ALTER TABLE ONLY public.interview_session_questions
    ADD CONSTRAINT interview_session_questions_session_sequence_key UNIQUE (session_id, sequence);


--
-- Name: interview_session_questions interview_session_questions_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_session_questions
    ADD CONSTRAINT interview_session_questions_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.interview_sessions(id) ON DELETE CASCADE;


--
-- Name: interview_session_questions interview_session_questions_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_session_questions
    ADD CONSTRAINT interview_session_questions_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: interview_session_questions interview_session_questions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_session_questions
    ADD CONSTRAINT interview_session_questions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: TABLE interview_session_questions; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.interview_session_questions TO sqltester;
