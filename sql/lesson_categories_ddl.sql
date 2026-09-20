--
-- lesson_categories — связывает уроки (public.lessons) с темами (public.categories),
-- уже используемыми у вопросов (question_categories), для блока рекомендаций
-- на финальном экране симуляции собеседования (см. INTERVIEW_SIMULATION_PLAN.md,
-- п. 3.6). Заполняется скриптом scripts/tag_lessons_categories.php, полностью
-- перезаписывается при каждом прогоне на урок (не накопительная разметка).
--

CREATE TABLE public.lesson_categories (
    lesson_id integer NOT NULL,
    category_id integer NOT NULL,
    confidence numeric(4,3),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.lesson_categories OWNER TO dba;


--
-- Name: lesson_categories lesson_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lesson_categories
    ADD CONSTRAINT lesson_categories_pkey PRIMARY KEY (lesson_id, category_id);


--
-- Name: lesson_categories lesson_categories_lesson_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lesson_categories
    ADD CONSTRAINT lesson_categories_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lesson_categories lesson_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dba
--

ALTER TABLE ONLY public.lesson_categories
    ADD CONSTRAINT lesson_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Lookup index: Interview::finish() reads "top lessons for weak category_id",
-- i.e. filters by category_id and orders by confidence — the PK above is
-- (lesson_id, category_id) and doesn't serve that access path.
--

CREATE INDEX lesson_categories_category_confidence_idx ON public.lesson_categories USING btree (category_id, confidence DESC);


--
-- Name: TABLE lesson_categories; Type: ACL; Schema: public; Owner: dba
--

GRANT SELECT ON TABLE public.lesson_categories TO sqltester;
