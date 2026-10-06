{* Текст лендинга /ru/database/querynomicon (Controller::database(), оболочка database.tpl).
   Числа строк и результаты запросов проверены на базе песочницы sqlite3_data. *}
<h1>База данных Querynomicon (SQLite): пингвины, таблицы и SQL-задачи</h1>
<p class="db-lead">
    Querynomicon — небольшая база SQLite для изучения SQL с нуля: набор данных о пингвинах Палмера и крошечная лаборатория с сотрудниками, экспериментами и планшетами для анализов.
    На SQLtest.online с ней можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>13</strong> таблиц</li>
    <li><strong>344</strong> пингвина</li>
    <li><strong>50</strong> экспериментов</li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по Querynomicon</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть Querynomicon в песочнице</a>
    {/if}
</div>

<h2>Что такое Querynomicon</h2>
<p>
    База взята из Querynomicon — бесплатного учебника Грега Уилсона «An Introduction to SQL for Wary Data Scientists». Главная таблица содержит пингвинов Палмера: измерения 344 пингвинов трёх видов с трёх островов в Антарктиде.
</p>
<p>
    Данных немного, и они понятны, но в них есть особенности настоящих данных: пропуски (NULL) в измерениях и в столбце пола. Поэтому на базе удобно учиться фильтрации, сортировке, группировке, работе с NULL и основам DDL и DML.
</p>

{if $ErdImage}
    <h2>ER-диаграмма</h2>
    <p>Диаграмма показывает таблицы Querynomicon и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных Querynomicon">ER-диаграмма базы данных Querynomicon</object>
    </a>
{/if}

<h2>Из чего состоит база</h2>
<p>Таблицы делятся на две группы.</p>
<div class="db-groups">
    <div>
        <h3>Пингвины</h3>
        <p><span class="sql">penguins</span> со всеми 344 птицами и <span class="sql">little_penguins</span> — выборка из 10 строк для быстрых экспериментов.</p>
    </div>
    <div>
        <h3>Лаборатория</h3>
        <p><span class="sql">department</span>, <span class="sql">staff</span>, <span class="sql">experiment</span>, <span class="sql">performed</span> (кто проводил какой эксперимент), <span class="sql">plate</span> и <span class="sql">invalidated</span>, а также <span class="sql">machine</span>, <span class="sql">usage</span>, <span class="sql">person</span> и <span class="sql">contact</span>.</p>
    </div>
</div>
<p>
    В таблицах с пингвинами нет ключей: каждая строка — одна птица. Таблицы лаборатории связаны числовыми идентификаторами, а <span class="sql">performed</span> связывает сотрудников и эксперименты «многие ко многим».
</p>

<p>Сколько данных в таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">penguins</span></td><td class="num">344</td><td>пингвины и их измерения</td></tr>
        <tr><td><span class="sql">little_penguins</span></td><td class="num">10</td><td>выборка из 10 пингвинов</td></tr>
        <tr><td><span class="sql">department</span></td><td class="num">4</td><td>отделы</td></tr>
        <tr><td><span class="sql">staff</span></td><td class="num">10</td><td>сотрудники</td></tr>
        <tr><td><span class="sql">experiment</span></td><td class="num">50</td><td>эксперименты</td></tr>
        <tr><td><span class="sql">performed</span></td><td class="num">65</td><td>сотрудники ↔ эксперименты</td></tr>
        <tr><td><span class="sql">plate</span></td><td class="num">256</td><td>планшеты с анализами</td></tr>
        <tr><td><span class="sql">invalidated</span></td><td class="num">30</td><td>забракованные планшеты</td></tr>
        <tr><td><span class="sql">machine</span></td><td class="num">3</td><td>приборы лаборатории</td></tr>
        <tr><td><span class="sql">person</span></td><td class="num">15</td><td>люди</td></tr>
        <tr><td><span class="sql">usage</span></td><td class="num">8</td><td>журнал использования приборов</td></tr>
        <tr><td><span class="sql">contact</span></td><td class="num">8</td><td>контакты</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>{if $PlaygroundLink}Эти запросы показывают, как связаны данные. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.{else}Эти запросы показывают, как связаны данные.{/if}</p>

<p><strong>Эксперименты и планшеты</strong> — связь «один ко многим» с LEFT JOIN и подсчётом:</p>
<pre><code class="language-sql">SELECT e.ident, e.kind, e.started, COUNT(p.ident) AS plates
FROM experiment e
LEFT JOIN plate p ON p.experiment = e.ident
GROUP BY e.ident
ORDER BY e.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ident</th><th>kind</th><th>started</th><th>plates</th></tr>
        <tr><td class="num">1</td><td>calibration</td><td>2023-08-25</td><td class="num">1</td></tr>
        <tr><td class="num">2</td><td>calibration</td><td>2023-02-14</td><td class="num">1</td></tr>
        <tr><td class="num">3</td><td>trial</td><td>2023-02-22</td><td class="num">10</td></tr>
    </table>
</div>

<p><strong>Кто проводил эксперимент</strong> — связь «многие ко многим» через <span class="sql">performed</span>:</p>
<pre><code class="language-sql">SELECT s.personal, s.family, e.kind, e.started
FROM performed pf
JOIN staff s ON s.ident = pf.staff
JOIN experiment e ON e.ident = pf.experiment
ORDER BY e.ident, s.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>personal</th><th>family</th><th>kind</th><th>started</th></tr>
        <tr><td>Nitya</td><td>Lal</td><td>calibration</td><td>2023-08-25</td></tr>
        <tr><td>Indrans</td><td>Sridhar</td><td>calibration</td><td>2023-02-14</td></tr>
        <tr><td>Kartik</td><td>Gupta</td><td>trial</td><td>2023-02-22</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач на базе Querynomicon: {$TasksCount} — от первого SELECT до представлений, индексов и триггеров. Решение проверяется автоматически на настоящем SQLite.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи по базе Querynomicon:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по Querynomicon →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать SQLite, чтобы работать с Querynomicon?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице выберите SQLite 3 Preloaded.</p>
    <h3>Что такое пингвины Палмера?</h3>
    <p>Популярный учебный набор данных: измерения пингвинов Адели, антарктических и папуанских пингвинов, собранные на станции Палмер в Антарктиде. Его часто используют как современную замену набору данных об ирисах.</p>
    <h3>Подходит ли эта база для начинающих?</h3>
    <p>Да. Таблицы маленькие, а предметная область не требует пояснений, поэтому можно сосредоточиться на самом SQL: SELECT, WHERE, ORDER BY, GROUP BY и работе с NULL.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать SQLite, чтобы работать с Querynomicon?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице выберите SQLite 3 Preloaded."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Что такое пингвины Палмера?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Популярный учебный набор данных: измерения пингвинов Адели, антарктических и папуанских пингвинов, собранные на станции Палмер в Антарктиде. Его часто используют как современную замену набору данных об ирисах."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Подходит ли эта база для начинающих?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Да. Таблицы маленькие, а предметная область не требует пояснений, поэтому можно сосредоточиться на самом SQL: SELECT, WHERE, ORDER BY, GROUP BY и работе с NULL."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Начать решать задачи</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть песочницу</a>
    {/if}
</div>
