--
-- Inserts the 12 "professional skills" (soft-skills) questions drafted in
-- PROFESSIONAL_SKILLS_QUESTIONS_DRAFT.md into questions/questions_localization
-- (ru + en), and wires each one into interview_questions (see
-- sql/interview_questions_ddl.sql and INTERVIEW_SIMULATION_PLAN.md, Этап 0 п.4).
--
-- All 12 are question_type = 'free_answer'. db_template/db/query_valid_result
-- carry the same kind of placeholder defaults the admin editor falls back to
-- for non-query questions (AdminQuestionManager::normalizeQuestionPayload),
-- with db_template set to 'theory' instead of the query-question default
-- 'sakila': query_valid_result = ''.
--
-- Grade coverage reuses the same overlapping windows as the rest of the bank
-- (INTERVIEW_SIMULATION_PLAN.md п. 4.1 / scripts/classify_interview_questions.py):
--   rate 2 -> Junior + Middle (grades 2,3)
--   rate 3 or 4 -> Middle + Senior (grades 3,4)
--
-- Review the drafted texts before running this against production.
--

BEGIN;

-- 1. SQL Developer / Junior — реакция на код-ревью
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('code-review-feedback', '', 'theory', 'Soft Skills', 2, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как вы реагируете на замечания в код-ревью?',
        'Ревьюер оставил в вашем pull request с SQL-запросом комментарии, с частью которых вы не согласны. Опишите, как вы будете действовать: что сделаете сразу, а что обсудите с ревьюером, и почему.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you react to code review feedback?',
        'A reviewer left comments on your pull request with a SQL query, and you disagree with some of them. Describe how you would act: what you would do right away, and what you would discuss with the reviewer, and why.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'sql_developer', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[2, 3]) AS g(grade);

-- 2. SQL Developer / Junior — работа с непонятной задачей
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('unclear-task-junior', '', 'theory', 'Soft Skills', 2, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Что делать, если задача на написание запроса непонятна?',
        'Вам поставили задачу написать SQL-отчёт, но формулировка расплывчата и не понятно, какие именно данные нужны заказчику. Опишите ваши первые шаги, прежде чем сесть писать запрос.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'What do you do when a query task is unclear?',
        'You have been assigned to write a SQL report, but the requirements are vague and it is not clear exactly what data the requester needs. Describe your first steps before you start writing the query.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'sql_developer', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[2, 3]) AS g(grade);

-- 3. SQL Developer / Middle — приоритизация технического долга
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('tech-debt-vs-deadlines', '', 'theory', 'Soft Skills', 3, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как убедить команду выделить время на рефакторинг медленных запросов?',
        'Вы знаете, что несколько тяжёлых SQL-запросов в проекте плохо оптимизированы и со временем это станет проблемой, но бизнес требует быстрее выпускать новые фичи. Опишите, как бы вы аргументировали необходимость выделить время на исправление, и что бы сделали, если приоритет всё равно не дали.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you convince the team to allocate time for optimizing slow queries?',
        'You know that several heavy SQL queries in the project are poorly optimized and will become a problem over time, but the business wants new features shipped faster. Describe how you would argue for allocating time to fix this, and what you would do if the priority still is not granted.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'sql_developer', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

-- 4. SQL Developer / Middle — расхождения с DBA/смежной командой
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('disagreement-with-dba', '', 'theory', 'Soft Skills', 3, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Расхождение во мнениях с DBA по схеме таблицы',
        'Вы предлагаете добавить новый индекс/изменить схему таблицы для ускорения запроса, а администратор БД (DBA) считает это решение опасным для продакшена. Опишите, как вы будете выстраивать диалог, чтобы найти решение.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'Disagreement with a DBA over a table schema change',
        'You propose adding a new index or changing a table schema to speed up a query, but the database administrator (DBA) considers this change risky for production. Describe how you would approach the conversation to find a solution.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'sql_developer', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

-- 5. SQL Developer / Senior — постмортем инцидента
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('incident-postmortem', '', 'theory', 'Soft Skills', 4, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как вы проводите разбор инцидента после сбоя из-за SQL-запроса?',
        'Из-за неоптимального запроса, который вы написали, произошла деградация продакшн-базы данных. Опишите, как вы будете вести себя после инцидента: что скажете команде, как будете разбирать причины и что предложите, чтобы такое не повторилось.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you run a postmortem after an incident caused by a SQL query?',
        'A poorly optimized query you wrote caused a production database outage. Describe how you would behave after the incident: what you would tell the team, how you would investigate the root cause, and what you would propose to prevent it from happening again.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'sql_developer', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

-- 6. SQL Developer / Senior — менторство и распространение стандартов
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('mentoring-sql-standards', '', 'theory', 'Soft Skills', 4, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как вы внедряете единые стандарты написания SQL в команде?',
        'В команде разработчики пишут SQL-запросы по-разному: кто-то не использует индексы осознанно, кто-то злоупотребляет подзапросами там, где подошёл бы JOIN. Опишите, как вы, как более опытный разработчик, будете повышать общий уровень качества SQL-кода в команде.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you introduce consistent SQL standards across the team?',
        'Developers on your team write SQL queries very differently: some do not use indexes deliberately, others overuse subqueries where a JOIN would fit better. Describe how you, as a more experienced developer, would raise the overall quality of SQL code in the team.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'sql_developer', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

-- 7. Data Analyst / Junior — объяснение результата нетехническому коллеге
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('explain-results-non-technical', '', 'theory', 'Soft Skills', 2, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как объяснить результат SQL-анализа коллеге без технического бэкграунда?',
        'Вы посчитали метрику с помощью SQL-запроса и должны рассказать о результате коллеге из отдела продаж, который не знаком с SQL. Опишите, как вы построите объяснение, не показывая сам запрос.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you explain a SQL analysis result to a non-technical colleague?',
        'You calculated a metric using a SQL query and need to explain the result to a colleague from the sales team who is not familiar with SQL. Describe how you would structure the explanation without showing the query itself.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'data_analyst', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[2, 3]) AS g(grade);

-- 8. Data Analyst / Junior — проверка собственных результатов
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('double-check-own-results', '', 'theory', 'Soft Skills', 2, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как вы проверяете правильность собственного SQL-отчёта перед тем как его отправить?',
        'Вы написали запрос для регулярного отчёта и получили результат, который выглядит правдоподобно. Опишите, какие шаги вы предпримете, чтобы убедиться, что цифры действительно верны, прежде чем отправить отчёт дальше.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you verify your own SQL report before sending it out?',
        'You wrote a query for a recurring report and got a result that looks plausible. Describe the steps you would take to make sure the numbers are actually correct before sending the report further.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'data_analyst', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[2, 3]) AS g(grade);

-- 9. Data Analyst / Middle — противоречивые запросы от разных отделов
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('conflicting-metric-requests', '', 'theory', 'Soft Skills', 3, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Два отдела просят похожую метрику, но результаты не сходятся — что делать?',
        'Отдел маркетинга и отдел продаж независимо попросили вас посчитать "конверсию", и после расчёта оказалось, что у вас получаются разные числа для, казалось бы, одной и той же метрики. Опишите, как вы разберётесь в причине расхождения и что сообщите обеим сторонам.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'Two departments ask for a similar metric but the numbers do not match — what do you do?',
        'The marketing and sales departments independently asked you to calculate "conversion rate", and it turns out you get different numbers for what looks like the same metric. Describe how you would investigate the discrepancy and what you would communicate to both sides.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'data_analyst', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

-- 10. Data Analyst / Middle — приоритизация конкурирующих ad-hoc запросов
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('prioritize-adhoc-requests', '', 'theory', 'Soft Skills', 3, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как расставлять приоритеты, когда несколько человек одновременно просят срочный анализ?',
        'В течение одного дня к вам поступило три "срочных" запроса на анализ от разных руководителей. У вас нет возможности сделать всё сразу. Опишите, как вы будете определять, что делать в первую очередь, и как будете коммуницировать это заказчикам.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you prioritize when several people ask for urgent analysis at the same time?',
        'Within a single day you received three "urgent" analysis requests from different managers. You cannot do everything at once. Describe how you would decide what to work on first, and how you would communicate this to the requesters.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'data_analyst', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

-- 11. Data Analyst / Senior — отстаивание вывода, который не нравится стейкхолдеру
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('defend-unpopular-finding', '', 'theory', 'Soft Skills', 4, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Ваш анализ показал результат, который стейкхолдер не хочет принимать',
        'Вы провели анализ, и он показывает, что успешная, по мнению руководителя, маркетинговая кампания на самом деле не окупилась. Руководитель ставит под сомнение вашу методологию. Опишите, как вы будете действовать: как перепроверите свои выводы и как будете выстраивать разговор.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'Your analysis shows a result a stakeholder does not want to accept',
        'Your analysis shows that a marketing campaign the manager considers successful actually did not pay off. The manager questions your methodology. Describe how you would act: how you would double-check your findings and how you would approach the conversation.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'data_analyst', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

-- 12. Data Analyst / Senior — построение единого источника правды для метрик
WITH ins_question AS (
    INSERT INTO questions (title_sef, query_valid_result, db_template, dbms, rate, question_type)
    VALUES ('single-source-of-truth-metrics', '', 'theory', 'Soft Skills', 4, 'free_answer')
    RETURNING id
), ins_loc_ru AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'ru',
        'Как вы наводите порядок, когда в компании нет единого определения ключевых метрик?',
        'В компании разные команды считают одну и ту же ключевую метрику (например, "активный пользователь") по-разному, что приводит к путанице и спорам на встречах. Опишите, как вы, как ведущий аналитик, будете решать эту проблему на уровне процесса, а не одного разового расчёта.'
    FROM ins_question
), ins_loc_en AS (
    INSERT INTO questions_localization (question_id, language, title, task)
    SELECT id, 'en',
        'How do you fix the lack of a single definition for key metrics?',
        'Different teams in the company calculate the same key metric (e.g. "active user") differently, which causes confusion and disagreements in meetings. Describe how you, as a lead analyst, would solve this problem at the process level, not just with a one-off recalculation.'
    FROM ins_question
)
INSERT INTO interview_questions (position, grade, question_id)
SELECT 'data_analyst', g.grade, ins_question.id
FROM ins_question, unnest(ARRAY[3, 4]) AS g(grade);

COMMIT;
