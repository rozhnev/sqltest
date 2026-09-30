--
-- Per-language site messages edited in the admin panel (/admin/site-messages) without a deploy:
-- the donation goal widget and the urgent banner. One row per language; the page loads the row
-- of its language (falling back to 'en') in one query, see Helper::getSiteMessages().
--

CREATE TABLE public.site_messages (
    language character varying(5) NOT NULL,
    donation_goal_title text DEFAULT '' NOT NULL,
    donation_goal text DEFAULT '' NOT NULL,                  -- widget text, HTML; ##goal## is replaced by the amount
    donation_goal_amount numeric(10,2) DEFAULT 50 NOT NULL,  -- USD per month; the admin page sets it for every language
    urgent_banner text DEFAULT '' NOT NULL,                  -- banner HTML
    urgent_banner_enabled boolean DEFAULT false NOT NULL,
    urgent_banner_version integer DEFAULT 1 NOT NULL,        -- bump to re-show the banner to visitors who closed it
    urgent_banner_background text DEFAULT 'linear-gradient(90deg, #7f1d1d 0%, #b91c1c 45%, #dc2626 100%)' NOT NULL,
    urgent_banner_text_color text DEFAULT '#ffffff' NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT site_messages_pkey PRIMARY KEY (language)
);

ALTER TABLE public.site_messages OWNER TO dba;
GRANT SELECT, INSERT, UPDATE ON TABLE public.site_messages TO sqltester;


--
-- Migration from templates/{lang}/donation_goal_widget.tpl and the urgent_banner table
--

-- Step 1: the donation widget texts (from the templates)
INSERT INTO public.site_messages (language, donation_goal_title, donation_goal) VALUES
    ('en', 'Support SQLtest.online', '<p>This project has only one funding source: your donations. The monthly maintenance cost is <strong>$##goal##</strong>.</p>
<p>Last month I added a new MariaDB database with a preloaded University DB, 9 new questions, and refactored many questions and lessons.</p>
<p>With your support, I plan to continue this work: write new lessons and tasks, and improve existing lessons.</p>
<p>To keep the project running next month, we need to collect at least this amount by the end of this month. Anything above it goes to new lessons, exercises, and features.</p>'),
    ('ru', 'Поддержите SQLtest.online', '<p>У проекта только один источник финансирования: ваши донаты. Ежемесячные расходы на поддержку проекта составляют <strong>$##goal##</strong>.</p>
<p>В прошлом месяце я добавил новую базу данных MariaDB с предустановленной базой University DB, 9 новых вопросов и отрефакторил много вопросов и уроков.</p>
<p>С вашей поддержкой я планирую продолжать работу: писать новые уроки и задания, улучшать существующие уроки.</p>
<p>Чтобы проект продолжил работать в следующем месяце, до конца текущего месяца нужно собрать как минимум эту сумму. Всё, что будет собрано сверх неё, пойдёт на новые уроки, задания и функции.</p>'),
    ('es', 'Apoyar a SQLtest.online', '<p>Este proyecto tiene una única fuente de financiación: tus donaciones. El costo de mantenimiento mensual es de <strong>$##goal##</strong>.</p>
<p>El mes pasado añadí una nueva base de datos MariaDB con una base de datos universitaria precargada, 9 nuevas preguntas y refactoricé muchas preguntas y lecciones.</p>
<p>Con tu apoyo, planeo continuar este trabajo: escribir nuevas lecciones y tareas, y mejorar las lecciones existentes.</p>
<p>Para mantener el proyecto en funcionamiento el próximo mes, necesitamos recaudar al menos esta cantidad para fin de mes. Cualquier monto adicional se destinará a nuevas lecciones, ejercicios y características.</p>'),
    ('fr', 'Soutenir SQLtest.online', '<p>Ce projet n''a qu''une seule source de financement : vos dons. Le coût de maintenance mensuel est de <strong>$##goal##</strong>.</p>
<p>Le mois dernier, j''ai ajouté une nouvelle base de données MariaDB avec une base University DB préchargée, 9 nouvelles questions, et j''ai refactoré de nombreuses questions et leçons.</p>
<p>Avec votre soutien, je prévois de poursuivre ce travail : écrire de nouvelles leçons et tâches, et améliorer les leçons existantes.</p>
<p>Pour maintenir le projet le mois prochain, nous devons recevoir au moins cette somme avant la fin du mois en cours. Tout ce qui dépasse ce montant sera consacré à de nouvelles leçons, à de nouveaux exercices et à de nouvelles fonctionnalités.</p>'),
    ('pt', 'Apoie o SQLtest.online', '<p>Este projeto tem apenas uma fonte de financiamento: as suas doações. O custo mensal de manutenção é <strong>$##goal##</strong>.</p>
<p>No mês passado, adicionei um novo banco de dados MariaDB com um banco University DB pré-carregado, 9 novas questões e refatorei muitas questões e lições.</p>
<p>Com o seu apoio, planeio continuar este trabalho: escrever novas lições e tarefas e melhorar as lições existentes.</p>
<p>Para manter o projeto no próximo mês, precisamos arrecadar pelo menos esse valor até o fim deste mês. Tudo o que passar disso será usado em novas lições, exercícios e recursos.</p>'),
    ('zh', '支持 SQLtest.online', '<p>这个项目只有一个资金来源：你的捐款。 每月维护成本为 <strong>$##goal##</strong>。</p>
<p>上个月我添加了一个新的 MariaDB 数据库，里面预加载了大学数据库，9 个新问题，并重构了许多问题和课程。</p>
<p>在你的支持下，我计划继续这项工作：编写新课程和任务，并改进现有课程。</p>
<p>为了让项目在下个月继续运行，我们需要在本月底之前至少收集到这个金额。 超过的部分将用于新课程、练习和功能。</p>')
ON CONFLICT (language) DO NOTHING;

-- Set the amount if DONATION_MONTHLY_GOAL in .env isn't 50:
-- UPDATE public.site_messages SET donation_goal_amount = 50;

-- Step 2: the urgent banner (texts per language, settings copied to every language)
UPDATE public.site_messages m SET
    urgent_banner = COALESCE(b.messages ->> m.language, ''),
    urgent_banner_enabled = b.enabled,
    urgent_banner_version = b.version,
    urgent_banner_background = b.background,
    urgent_banner_text_color = b.text_color
FROM public.urgent_banner b
WHERE b.id = 1;

-- Step 3: after the code that reads site_messages is deployed
-- DROP TABLE public.urgent_banner;
