--
-- interview_skill_tags — навыки, по которым строится разбивка "сильные/слабые
-- стороны" и рекомендации уроков в симуляции собеседования (см.
-- INTERVIEW_SIMULATION_PLAN.md, п. 3.7). Отдельное пространство имён от
-- categories: categories — это разделы опросников сайта ("База данных Sakila",
-- "Уровень 2: Функции", "Просто"), а не навыки, и в отчёте интервью они
-- выглядели бессмысленно.
--
-- Таксономия фиксированная (id стабильны), LLM только выбирает теги из неё —
-- скрипт scripts/build_interview_skill_tags.php размечает вопросы
-- (question_interview_tags) и уроки (lesson_interview_tags). Добавить навык =
-- новая строка здесь + перезапуск скрипта.
--

CREATE TABLE public.interview_skill_tags (
    id smallint NOT NULL,
    code character varying(48) NOT NULL,
    sequence_position smallint NOT NULL
);

ALTER TABLE public.interview_skill_tags OWNER TO dba;

ALTER TABLE ONLY public.interview_skill_tags
    ADD CONSTRAINT interview_skill_tags_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.interview_skill_tags
    ADD CONSTRAINT interview_skill_tags_code_key UNIQUE (code);


CREATE TABLE public.interview_skill_tags_localization (
    skill_tag_id smallint NOT NULL,
    language character(2) NOT NULL,
    title text NOT NULL
);

ALTER TABLE public.interview_skill_tags_localization OWNER TO dba;

ALTER TABLE ONLY public.interview_skill_tags_localization
    ADD CONSTRAINT interview_skill_tags_localization_pkey PRIMARY KEY (skill_tag_id, language);

ALTER TABLE ONLY public.interview_skill_tags_localization
    ADD CONSTRAINT interview_skill_tags_localization_skill_tag_id_fkey FOREIGN KEY (skill_tag_id) REFERENCES public.interview_skill_tags(id) ON DELETE CASCADE;


--
-- question_interview_tags — 1-2 навыка на вопрос; ровно один основной
-- (is_primary): по нему вопрос попадает в тему итогового отчёта.
-- Полностью перезаписывается скриптом для вопроса при каждом прогоне.
--

CREATE TABLE public.question_interview_tags (
    question_id integer NOT NULL,
    skill_tag_id smallint NOT NULL,
    is_primary boolean DEFAULT false NOT NULL,
    confidence numeric(4,3),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE public.question_interview_tags OWNER TO dba;

ALTER TABLE ONLY public.question_interview_tags
    ADD CONSTRAINT question_interview_tags_pkey PRIMARY KEY (question_id, skill_tag_id);

ALTER TABLE ONLY public.question_interview_tags
    ADD CONSTRAINT question_interview_tags_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.question_interview_tags
    ADD CONSTRAINT question_interview_tags_skill_tag_id_fkey FOREIGN KEY (skill_tag_id) REFERENCES public.interview_skill_tags(id) ON DELETE CASCADE;

-- Не более одного основного навыка на вопрос.
CREATE UNIQUE INDEX question_interview_tags_one_primary_idx ON public.question_interview_tags USING btree (question_id)
    WHERE is_primary;


--
-- lesson_interview_tags — какие навыки прокачивает урок; Interview берёт 1-2
-- лучших урока по confidence для каждого слабого навыка.
--

CREATE TABLE public.lesson_interview_tags (
    lesson_id integer NOT NULL,
    skill_tag_id smallint NOT NULL,
    confidence numeric(4,3),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE public.lesson_interview_tags OWNER TO dba;

ALTER TABLE ONLY public.lesson_interview_tags
    ADD CONSTRAINT lesson_interview_tags_pkey PRIMARY KEY (lesson_id, skill_tag_id);

ALTER TABLE ONLY public.lesson_interview_tags
    ADD CONSTRAINT lesson_interview_tags_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.lesson_interview_tags
    ADD CONSTRAINT lesson_interview_tags_skill_tag_id_fkey FOREIGN KEY (skill_tag_id) REFERENCES public.interview_skill_tags(id) ON DELETE CASCADE;

-- Путь доступа Interview: "лучшие уроки для слабого навыка".
CREATE INDEX lesson_interview_tags_skill_confidence_idx ON public.lesson_interview_tags USING btree (skill_tag_id, confidence DESC);


GRANT SELECT ON TABLE public.interview_skill_tags TO sqltester;
GRANT SELECT ON TABLE public.interview_skill_tags_localization TO sqltester;
GRANT SELECT ON TABLE public.question_interview_tags TO sqltester;
GRANT SELECT ON TABLE public.lesson_interview_tags TO sqltester;


--
-- Таксономия навыков.
--

INSERT INTO public.interview_skill_tags (id, code, sequence_position) VALUES
    (1,  'select-basics',          1),
    (2,  'joins',                  2),
    (3,  'aggregation',            3),
    (4,  'subqueries-cte',         4),
    (5,  'window-functions',       5),
    (6,  'set-operations',         6),
    (7,  'functions-expressions',  7),
    (8,  'data-modification',      8),
    (9,  'schema-ddl',             9),
    (10, 'data-modeling',          10),
    (11, 'indexes-performance',    11),
    (12, 'transactions',           12),
    (13, 'dbms-internals',         13),
    (14, 'analytics',              14),
    (15, 'data-quality',           15),
    (16, 'professional-skills',    16);

INSERT INTO public.interview_skill_tags_localization (skill_tag_id, language, title) VALUES
    (1,  'en', 'Basic queries and filtering'),
    (1,  'ru', 'Базовые выборки и фильтрация'),
    (2,  'en', 'Joins'),
    (2,  'ru', 'Соединения таблиц (JOIN)'),
    (3,  'en', 'Aggregation and GROUP BY'),
    (3,  'ru', 'Агрегация и GROUP BY'),
    (4,  'en', 'Subqueries and CTEs'),
    (4,  'ru', 'Подзапросы и CTE'),
    (5,  'en', 'Window functions'),
    (5,  'ru', 'Оконные функции'),
    (6,  'en', 'Set operations (UNION, INTERSECT, EXCEPT)'),
    (6,  'ru', 'Операции над множествами (UNION, INTERSECT, EXCEPT)'),
    (7,  'en', 'Functions and expressions (strings, dates, CASE, NULL)'),
    (7,  'ru', 'Функции и выражения (строки, даты, CASE, NULL)'),
    (8,  'en', 'Data modification (INSERT, UPDATE, DELETE)'),
    (8,  'ru', 'Изменение данных (INSERT, UPDATE, DELETE)'),
    (9,  'en', 'Schema and DDL (tables, keys, constraints)'),
    (9,  'ru', 'Схема и DDL (таблицы, ключи, ограничения)'),
    (10, 'en', 'Data modeling and normalization'),
    (10, 'ru', 'Проектирование и нормализация'),
    (11, 'en', 'Indexes and query performance'),
    (11, 'ru', 'Индексы и производительность запросов'),
    (12, 'en', 'Transactions and concurrency'),
    (12, 'ru', 'Транзакции и конкурентный доступ'),
    (13, 'en', 'Database internals and DBMS specifics'),
    (13, 'ru', 'Устройство СУБД и их особенности'),
    (14, 'en', 'Analytics and metrics'),
    (14, 'ru', 'Аналитика и метрики'),
    (15, 'en', 'Data quality and validation'),
    (15, 'ru', 'Качество и проверка данных'),
    (16, 'en', 'Professional skills'),
    (16, 'ru', 'Профессиональные навыки'),

    (1,  'pt', 'Consultas básicas e filtragem'),
    (2,  'pt', 'Junções (JOIN)'),
    (3,  'pt', 'Agregação e GROUP BY'),
    (4,  'pt', 'Subconsultas e CTEs'),
    (5,  'pt', 'Funções de janela'),
    (6,  'pt', 'Operações de conjunto (UNION, INTERSECT, EXCEPT)'),
    (7,  'pt', 'Funções e expressões (strings, datas, CASE, NULL)'),
    (8,  'pt', 'Modificação de dados (INSERT, UPDATE, DELETE)'),
    (9,  'pt', 'Esquema e DDL (tabelas, chaves, restrições)'),
    (10, 'pt', 'Modelagem de dados e normalização'),
    (11, 'pt', 'Índices e desempenho de consultas'),
    (12, 'pt', 'Transações e concorrência'),
    (13, 'pt', 'Funcionamento interno e particularidades dos SGBDs'),
    (14, 'pt', 'Análise de dados e métricas'),
    (15, 'pt', 'Qualidade e validação de dados'),
    (16, 'pt', 'Habilidades profissionais'),

    (1,  'fr', 'Requêtes de base et filtrage'),
    (2,  'fr', 'Jointures (JOIN)'),
    (3,  'fr', 'Agrégation et GROUP BY'),
    (4,  'fr', 'Sous-requêtes et CTE'),
    (5,  'fr', 'Fonctions de fenêtrage'),
    (6,  'fr', 'Opérations ensemblistes (UNION, INTERSECT, EXCEPT)'),
    (7,  'fr', 'Fonctions et expressions (chaînes, dates, CASE, NULL)'),
    (8,  'fr', 'Modification des données (INSERT, UPDATE, DELETE)'),
    (9,  'fr', 'Schéma et DDL (tables, clés, contraintes)'),
    (10, 'fr', 'Modélisation des données et normalisation'),
    (11, 'fr', 'Index et performance des requêtes'),
    (12, 'fr', 'Transactions et concurrence'),
    (13, 'fr', 'Fonctionnement interne et spécificités des SGBD'),
    (14, 'fr', 'Analyse de données et métriques'),
    (15, 'fr', 'Qualité et validation des données'),
    (16, 'fr', 'Compétences professionnelles'),

    (1,  'es', 'Consultas básicas y filtrado'),
    (2,  'es', 'Uniones de tablas (JOIN)'),
    (3,  'es', 'Agregación y GROUP BY'),
    (4,  'es', 'Subconsultas y CTE'),
    (5,  'es', 'Funciones de ventana'),
    (6,  'es', 'Operaciones de conjuntos (UNION, INTERSECT, EXCEPT)'),
    (7,  'es', 'Funciones y expresiones (cadenas, fechas, CASE, NULL)'),
    (8,  'es', 'Modificación de datos (INSERT, UPDATE, DELETE)'),
    (9,  'es', 'Esquema y DDL (tablas, claves, restricciones)'),
    (10, 'es', 'Modelado de datos y normalización'),
    (11, 'es', 'Índices y rendimiento de consultas'),
    (12, 'es', 'Transacciones y concurrencia'),
    (13, 'es', 'Funcionamiento interno y particularidades de los SGBD'),
    (14, 'es', 'Análisis de datos y métricas'),
    (15, 'es', 'Calidad y validación de datos'),
    (16, 'es', 'Habilidades profesionales'),

    (1,  'zh', '基础查询与筛选'),
    (2,  'zh', '表连接（JOIN）'),
    (3,  'zh', '聚合与 GROUP BY'),
    (4,  'zh', '子查询与 CTE'),
    (5,  'zh', '窗口函数'),
    (6,  'zh', '集合运算（UNION、INTERSECT、EXCEPT）'),
    (7,  'zh', '函数与表达式（字符串、日期、CASE、NULL）'),
    (8,  'zh', '数据修改（INSERT、UPDATE、DELETE）'),
    (9,  'zh', '模式与 DDL（表、键、约束）'),
    (10, 'zh', '数据建模与规范化'),
    (11, 'zh', '索引与查询性能'),
    (12, 'zh', '事务与并发'),
    (13, 'zh', '数据库内部原理与各 DBMS 特性'),
    (14, 'zh', '数据分析与指标'),
    (15, 'zh', '数据质量与校验'),
    (16, 'zh', '职业技能');
