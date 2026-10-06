{* Текст лендинга /ru/database/countries (Controller::database(), оболочка database.tpl).
   Числа строк и результаты запросов проверены на базе песочницы psql17postgis. *}
<h1>База данных Countries (PostGIS): пространственные таблицы и SQL-задачи</h1>
<p class="db-lead">
    Countries — база PostGIS для изучения пространственного SQL: страны и столицы мира, а также слои Нью-Йорка с переписными кварталами, районами, улицами и станциями метро.
    На SQLtest.online с ней можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>7</strong> пространственных таблиц</li>
    <li><strong>246</strong> стран</li>
    <li><strong>491</strong> станция метро</li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по Countries</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть Countries в песочнице</a>
    {/if}
</div>

<h2>Что такое Countries</h2>
<p>
    PostGIS — расширение PostgreSQL, которое добавляет геометрические типы и сотни пространственных функций: расстояния, площади, пересечения, преобразования координат. Эта база позволяет попробовать их на понятных данных.
</p>
<p>
    Таблицы Нью-Йорка взяты из известного практикума PostGIS «Introduction to PostGIS», а таблицы мира содержат границы стран и столицы. Вместе они охватывают точки, линии и полигоны в двух системах координат.
</p>

{if $ErdImage}
    <h2>ER-диаграмма</h2>
    <p>Диаграмма показывает таблицы Countries и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных Countries">ER-диаграмма базы данных Countries</object>
    </a>
{/if}

<h2>Из чего состоит база</h2>
<p>Таблицы делятся на две группы.</p>
<div class="db-groups">
    <div>
        <h3>Мир</h3>
        <p><span class="sql">countries</span> с полигонами границ и <span class="sql">capitals</span> с точками, обе в SRID 4326 (долгота и широта).</p>
    </div>
    <div>
        <h3>Нью-Йорк</h3>
        <p><span class="sql">nyc_census_blocks</span>, <span class="sql">nyc_neighborhoods</span>, <span class="sql">nyc_streets</span>, <span class="sql">nyc_subway_stations</span> и <span class="sql">nyc_homicides</span> в SRID 26918 (UTM, зона 18N, метры).</p>
    </div>
</div>
<p>
    Главное, что стоит запомнить: таблицы мира хранят градусы, а таблицы Нью-Йорка — метры. Расстояния и площади в слоях Нью-Йорка сразу получаются в метрах, а для таблиц мира геометрию нужно привести к <span class="sql">geography</span> или сначала преобразовать.
</p>

<p>Сколько данных в таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">countries</span></td><td class="num">246</td><td>страны и их границы</td></tr>
        <tr><td><span class="sql">capitals</span></td><td class="num">192</td><td>столицы</td></tr>
        <tr><td><span class="sql">nyc_census_blocks</span></td><td class="num">38 794</td><td>переписные кварталы с населением</td></tr>
        <tr><td><span class="sql">nyc_neighborhoods</span></td><td class="num">129</td><td>районы</td></tr>
        <tr><td><span class="sql">nyc_streets</span></td><td class="num">19 091</td><td>улицы</td></tr>
        <tr><td><span class="sql">nyc_subway_stations</span></td><td class="num">491</td><td>станции метро</td></tr>
        <tr><td><span class="sql">nyc_homicides</span></td><td class="num">3 982</td><td>убийства</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>{if $PlaygroundLink}Эти запросы показывают, как связаны данные. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.{else}Эти запросы показывают, как связаны данные.{/if}</p>

<p><strong>Столица внутри своей страны</strong> — координаты точки через <span class="sql">ST_X</span> / <span class="sql">ST_Y</span> и пространственная проверка <span class="sql">ST_Contains</span>:</p>
<pre><code class="language-sql">SELECT c.name AS capital, co.name AS country,
       round(ST_Y(c.location)::numeric, 2) AS lat,
       round(ST_X(c.location)::numeric, 2) AS lon,
       ST_Contains(co.border, c.location) AS inside_border
FROM capitals c
JOIN countries co ON co.id = c.country_id
ORDER BY c.name
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>capital</th><th>country</th><th>lat</th><th>lon</th><th>inside_border</th></tr>
        <tr><td>Abu Dhabi</td><td>United Arab Emirates</td><td class="num">24.30</td><td class="num">54.70</td><td>true</td></tr>
        <tr><td>Abuja</td><td>Nigeria</td><td class="num">9.08</td><td class="num">7.40</td><td>true</td></tr>
        <tr><td>Accra</td><td>Ghana</td><td class="num">5.60</td><td class="num">-0.19</td><td>true</td></tr>
    </table>
</div>

<p><strong>Станции метро и их SRID</strong> — слои Нью-Йорка используют проекцию 26918:</p>
<pre><code class="language-sql">SELECT s.name AS station, s.borough, s.routes, ST_SRID(s.geom) AS srid
FROM nyc_subway_stations s
ORDER BY s.gid
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>station</th><th>borough</th><th>routes</th><th>srid</th></tr>
        <tr><td>Cortlandt St</td><td>Manhattan</td><td>R,W</td><td class="num">26918</td></tr>
        <tr><td>Rector St</td><td>Manhattan</td><td class="num">1</td><td class="num">26918</td></tr>
        <tr><td>South Ferry</td><td>Manhattan</td><td class="num">1</td><td class="num">26918</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач по PostGIS на этой базе: {$TasksCount} — расстояния, площади, длины, преобразование в текст и JSON и пространственные соединения. Решение проверяется автоматически на настоящем PostgreSQL с PostGIS.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи по базе Countries:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по Countries →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать PostGIS, чтобы работать с этой базой?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице выберите PostgreSQL 17 + PostGIS WorkShop.</p>
    <h3>Что такое SRID?</h3>
    <p>Идентификатор пространственной системы координат: он говорит, в какой системе записаны координаты. 4326 — долгота и широта в градусах (WGS 84), 26918 — UTM, зона 18N, в метрах, её используют для Нью-Йорка.</p>
    <h3>Откуда взяты таблицы Нью-Йорка?</h3>
    <p>Из набора данных практикума «Introduction to PostGIS», опубликованного на postgis.net, — частой отправной точки для изучения PostGIS.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать PostGIS, чтобы работать с этой базой?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице выберите PostgreSQL 17 + PostGIS WorkShop."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Что такое SRID?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Идентификатор пространственной системы координат: он говорит, в какой системе записаны координаты. 4326 — долгота и широта в градусах (WGS 84), 26918 — UTM, зона 18N, в метрах, её используют для Нью-Йорка."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Откуда взяты таблицы Нью-Йорка?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Из набора данных практикума «Introduction to PostGIS», опубликованного на postgis.net, — частой отправной точки для изучения PostGIS."{rdelim}{rdelim}
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
