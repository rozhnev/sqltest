{* Текст лендинга /ru/database/yellow-tripdata (Controller::database(), оболочка database.tpl).
   Числа строк и результаты запросов проверены на базе песочницы duckdb_data. *}
<h1>Набор данных NYC Yellow Taxi (DuckDB): таблица yellow_tripdata и SQL-задачи</h1>
<p class="db-lead">
    yellow_tripdata — поездки жёлтых такси Нью-Йорка за январь 2024 года, почти 3 миллиона строк, загруженные в DuckDB для аналитического SQL.
    На SQLtest.online с ними можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>1</strong> таблица, 19 столбцов</li>
    <li><strong>2 964 624</strong> поездки</li>
    <li><strong>январь 2024</strong> </li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по NYC Yellow Taxi</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть NYC Yellow Taxi в песочнице</a>
    {/if}
</div>

<h2>Что такое NYC Yellow Taxi</h2>
<p>
    Данные взяты из записей о поездках, которые Комиссия такси и лимузинов Нью-Йорка (TLC) публикует каждый месяц. Каждая строка — одна поездка: время посадки и высадки, расстояние, число пассажиров, зоны посадки и высадки, способ оплаты и все составляющие стоимости.
</p>
<p>
    DuckDB — встраиваемая аналитическая СУБД с колоночным хранением, поэтому агрегации по миллионам строк выполняются за доли секунды. На этих данных удобно тренировать настоящую аналитику: временные ряды, распределения, перцентили и очистку данных.
</p>

{if $ErdImage}
    <h2>ER-диаграмма</h2>
    <p>Диаграмма показывает таблицы NYC Yellow Taxi и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных NYC Yellow Taxi">ER-диаграмма базы данных NYC Yellow Taxi</object>
    </a>
{/if}

<h2>Из чего состоит база</h2>
<p>
    Все данные лежат в одной таблице <span class="sql">yellow_tripdata</span>. Все столбцы допускают NULL, ключей и ограничений нет. <span class="sql">PULocationID</span> и <span class="sql">DOLocationID</span> — номера зон такси TLC. У нескольких поездок время посадки выходит за январь 2024 года, а у некоторых суммы нулевые или отрицательные: настоящие данные нужно чистить, и часть задач именно об этом.
</p>

<p>Сколько данных в таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">yellow_tripdata</span></td><td class="num">2 964 624</td><td>поездки жёлтых такси</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>{if $PlaygroundLink}Эти запросы показывают, как связаны данные. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.{else}Эти запросы показывают, как связаны данные.{/if}</p>

<p><strong>Длительность поездки</strong> — функция DuckDB <span class="sql">date_diff</span> между посадкой и высадкой:</p>
<pre><code class="language-sql">SELECT tpep_pickup_datetime,
       date_diff('minute', tpep_pickup_datetime, tpep_dropoff_datetime) AS minutes,
       trip_distance, total_amount
FROM yellow_tripdata
WHERE tpep_pickup_datetime &gt;= '2024-01-01'
ORDER BY tpep_pickup_datetime
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>tpep_pickup_datetime</th><th>minutes</th><th>trip_distance</th><th>total_amount</th></tr>
        <tr><td>2024-01-01 00:00:00</td><td class="num">2</td><td class="num">0.3</td><td class="num">11.25</td></tr>
        <tr><td>2024-01-01 00:00:02</td><td class="num">4</td><td class="num">1.57</td><td class="num">16.32</td></tr>
        <tr><td>2024-01-01 00:00:03</td><td class="num">3</td><td class="num">0.5</td><td class="num">7.6</td></tr>
    </table>
</div>

<p><strong>Быстрый подсчёт</strong> — <span class="sql">GROUP BY ALL</span> в DuckDB группирует по всем неагрегированным столбцам:</p>
<pre><code class="language-sql">SELECT store_and_fwd_flag, COUNT(*) AS trips
FROM yellow_tripdata
GROUP BY ALL
ORDER BY trips DESC;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>store_and_fwd_flag</th><th>trips</th></tr>
        <tr><td>N</td><td class="num">2813126</td></tr>
        <tr><td>NULL</td><td class="num">140162</td></tr>
        <tr><td>Y</td><td class="num">11336</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач на этом наборе данных: {$TasksCount} — от общей статистики до временных рядов и проверки качества данных. Решение проверяется автоматически на настоящей DuckDB.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи по базе NYC Yellow Taxi:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по NYC Yellow Taxi →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать DuckDB, чтобы работать с этими данными?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице выберите DuckDB.</p>
    <h3>Откуда эти данные?</h3>
    <p>Из открытых данных Комиссии такси и лимузинов Нью-Йорка (TLC), которые публикуются каждый месяц в формате Parquet. В этой копии — поездки жёлтых такси за январь 2024 года.</p>
    <h3>Чем отличается SQL в DuckDB?</h3>
    <p>Он близок к PostgreSQL и дополнен возможностями для аналитики: <span class="sql">GROUP BY ALL</span>, <span class="sql">QUALIFY</span>, <span class="sql">date_diff</span> и функциями квантилей.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать DuckDB, чтобы работать с этими данными?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице выберите DuckDB."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Откуда эти данные?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Из открытых данных Комиссии такси и лимузинов Нью-Йорка (TLC), которые публикуются каждый месяц в формате Parquet. В этой копии — поездки жёлтых такси за январь 2024 года."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Чем отличается SQL в DuckDB?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Он близок к PostgreSQL и дополнен возможностями для аналитики: GROUP BY ALL, QUALIFY, date_diff и функциями квантилей."{rdelim}{rdelim}
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
