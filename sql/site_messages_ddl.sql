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
    ('en', 'Support SQLtest.online', '<p>The lessons, tasks and playground on SQLtest.online are free and are kept running by your donations. Server and site maintenance costs <strong>$##goal##</strong> a month.</p>
<p><strong>New: the AI assistant.</strong> You can now ask the AI assistant questions in lessons: it explains the topic in simple words, shows more example queries and helps you figure out an error. In the playground, the assistant sees your query and the result of running it, so it can suggest what to fix and how to write the query better.</p>
<p>AI answers are paid for separately: each one costs money at the language model provider, so the assistant runs on AI tokens. New accounts get a free starter allowance, and after that you can <a href="/en/buy-tokens">buy tokens</a>. This way the AI features pay for themselves, and donations go to the site and new lessons.</p>
<p>To keep the site running next month, we need to raise at least this amount by the end of this month. Anything above it goes to new lessons and tasks.</p>'),
    ('ru', 'Поддержите SQLtest.online', '<p>Уроки, задания и песочница на SQLtest.online бесплатны и держатся на ваших донатах. Ежемесячные расходы на серверы и поддержку сайта составляют <strong>$##goal##</strong>.</p>
<p><strong>Новое: AI-ассистент.</strong> Теперь в уроках можно задать вопрос AI-ассистенту: он объяснит тему простыми словами, покажет дополнительные примеры запросов и поможет разобраться с ошибкой. В песочнице ассистент видит ваш запрос и результат его выполнения, поэтому может подсказать, что исправить и как написать запрос лучше.</p>
<p>Ответы AI оплачиваются отдельно: каждый из них стоит денег у провайдера языковой модели, поэтому ассистент работает на AI-токенах. Новые аккаунты получают бесплатный стартовый запас, а дальше токены можно <a href="/ru/buy-tokens">купить</a>. Так AI-функции окупают себя сами, а донаты идут на сайт и новые уроки.</p>
<p>Чтобы сайт продолжил работать в следующем месяце, до конца текущего месяца нужно собрать как минимум эту сумму. Всё, что будет собрано сверх неё, пойдёт на новые уроки и задания.</p>'),
    ('es', 'Apoyar a SQLtest.online', '<p>Las lecciones, los ejercicios y el sandbox de SQLtest.online son gratuitos y se mantienen gracias a tus donaciones. Los servidores y el mantenimiento del sitio cuestan <strong>$##goal##</strong> al mes.</p>
<p><strong>Novedad: el asistente de IA.</strong> Ahora puedes hacer preguntas al asistente de IA en las lecciones: explica el tema con palabras sencillas, muestra más ejemplos de consultas y te ayuda a entender un error. En el sandbox, el asistente ve tu consulta y el resultado de su ejecución, así que puede sugerir qué corregir y cómo escribir mejor la consulta.</p>
<p>Las respuestas de la IA se pagan aparte: cada una cuesta dinero en el proveedor del modelo de lenguaje, por eso el asistente funciona con tokens de IA. Las cuentas nuevas reciben una cantidad inicial gratuita, y después puedes <a href="/es/buy-tokens">comprar tokens</a>. Así las funciones de IA se pagan solas y las donaciones se destinan al sitio y a nuevas lecciones.</p>
<p>Para que el sitio siga funcionando el mes que viene, necesitamos reunir al menos esta cantidad antes de que termine este mes. Todo lo que se reúna por encima se destinará a nuevas lecciones y ejercicios.</p>'),
    ('fr', 'Soutenir SQLtest.online', '<p>Les leçons, les exercices et le bac à sable de SQLtest.online sont gratuits et vivent grâce à vos dons. Les serveurs et la maintenance du site coûtent <strong>$##goal##</strong> par mois.</p>
<p><strong>Nouveau : l''assistant IA.</strong> Vous pouvez maintenant poser vos questions à l''assistant IA dans les leçons : il explique le sujet avec des mots simples, montre d''autres exemples de requêtes et vous aide à comprendre une erreur. Dans le bac à sable, l''assistant voit votre requête et le résultat de son exécution : il peut donc suggérer quoi corriger et comment mieux écrire la requête.</p>
<p>Les réponses de l''IA sont payées à part : chacune coûte de l''argent auprès du fournisseur du modèle de langage, c''est pourquoi l''assistant fonctionne avec des jetons d''IA. Les nouveaux comptes reçoivent un crédit de départ gratuit, puis vous pouvez <a href="/fr/buy-tokens">acheter des jetons</a>. Ainsi, les fonctions d''IA se financent elles-mêmes, et les dons vont au site et aux nouvelles leçons.</p>
<p>Pour que le site continue de fonctionner le mois prochain, nous devons réunir au moins cette somme d''ici la fin du mois. Tout ce qui sera collecté au-delà ira à de nouvelles leçons et de nouveaux exercices.</p>'),
    ('pt', 'Apoie o SQLtest.online', '<p>As lições, as tarefas e o playground do SQLtest.online são gratuitos e se mantêm graças às suas doações. Os servidores e a manutenção do site custam <strong>$##goal##</strong> por mês.</p>
<p><strong>Novidade: o assistente de IA.</strong> Agora você pode fazer perguntas ao assistente de IA nas lições: ele explica o tema com palavras simples, mostra mais exemplos de consultas e ajuda a entender um erro. No playground, o assistente vê a sua consulta e o resultado da execução, então pode sugerir o que corrigir e como escrever a consulta melhor.</p>
<p>As respostas da IA são pagas à parte: cada uma custa dinheiro no provedor do modelo de linguagem, por isso o assistente funciona com tokens de IA. Contas novas recebem uma cota inicial gratuita e, depois, você pode <a href="/pt/buy-tokens">comprar tokens</a>. Assim, os recursos de IA se pagam sozinhos, e as doações vão para o site e para novas lições.</p>
<p>Para que o site continue funcionando no próximo mês, precisamos arrecadar pelo menos este valor até o fim deste mês. Tudo o que for arrecadado acima disso irá para novas lições e tarefas.</p>'),
    ('zh', '支持 SQLtest.online', '<p>SQLtest.online 的课程、练习和演练场都是免费的，全靠大家的捐款维持。服务器和网站维护每月需要 <strong>$##goal##</strong>。</p>
<p><strong>新功能：AI 助手。</strong>现在你可以在课程中向 AI 助手提问：它会用简单的语言讲解主题，展示更多查询示例，并帮你弄清楚错误原因。在演练场中，助手能看到你的查询及其运行结果，因此可以建议如何修改，以及怎样把查询写得更好。</p>
<p>AI 的回答是单独付费的：每一次回答都需要向语言模型提供商付费，所以助手使用 AI 令牌运行。新账户会获得一份免费的初始额度，之后可以<a href="/zh/buy-tokens">购买令牌</a>。这样 AI 功能能够自给自足，而捐款则用于网站和新课程。</p>
<p>为了让网站下个月继续运行，我们需要在本月底之前至少筹集到这个金额。超出的部分将用于新的课程和练习。</p>')
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
