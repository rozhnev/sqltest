--
-- interview_questions — сопоставление вопросов банка (public.questions) с
-- позициями и грейдами для фичи "симуляция собеседования"
-- (см. INTERVIEW_SIMULATION_PLAN.md, п. 3.1.2).
--
-- Grade переиспользует существующую таблицу public.grades:
--   2 = Junior, 3 = Middle, 4 = Senior (Intern = 1 не используется интервью).
--
-- Одна и та же question_id может встречаться несколько раз для одной позиции
-- с разными grade — это осознанное перекрытие (MVP-логика подбора вопросов,
-- п. 4.1 плана): junior берёт rate 1-2, middle — rate 2-4, senior — rate 3-5,
-- поэтому вопрос среднего рейтинга закономерно попадает сразу в 2-3 грейда.
--

CREATE TABLE public.interview_questions (
    position character varying(32) NOT NULL,
    grade smallint NOT NULL,
    question_id integer NOT NULL,
    CONSTRAINT interview_questions_position_check
        CHECK (((position)::text = ANY ((ARRAY['sql_developer'::character varying, 'data_analyst'::character varying])::text[])))
);


ALTER TABLE public.interview_questions OWNER TO dba;


--
-- Name: interview_questions interview_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_questions
    ADD CONSTRAINT interview_questions_pkey PRIMARY KEY (position, grade, question_id);


--
-- Name: interview_questions interview_questions_grade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_questions
    ADD CONSTRAINT interview_questions_grade_fkey FOREIGN KEY (grade) REFERENCES public.grades(id);


--
-- Name: interview_questions interview_questions_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.interview_questions
    ADD CONSTRAINT interview_questions_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Lookup index: подбор стартового/адаптивного пула вопросов идёт по
-- (position, grade), question_id в PK уже покрывает точечные проверки.
--

CREATE INDEX interview_questions_position_grade_idx ON public.interview_questions USING btree (position, grade);


--
-- Name: TABLE interview_questions; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.interview_questions TO sqltester;
