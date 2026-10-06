{* Текст лендинга /ru/database/bookings (Controller::database(), оболочка database.tpl).
   Числа строк и результаты запросов проверены на базе песочницы psql18demo. *}
<h1>База данных Bookings: авиаперевозки, схема, таблицы и SQL-задачи</h1>
<p class="db-lead">
    Bookings — демонстрационная база PostgreSQL об авиакомпании: рейсы между 104 аэропортами, бронирования, билеты и посадочные талоны.
    На SQLtest.online с ней можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>8</strong> таблиц и 4 представления</li>
    <li><strong>33 121</strong> рейс</li>
    <li><strong>1 045 726</strong> перелётов по билетам</li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по Bookings</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть Bookings в песочнице</a>
    {/if}
</div>

<h2>Что такое Bookings</h2>
<p>
    Bookings — демобаза, которую компания Postgres Professional выпускает для изучения PostgreSQL. Она описывает рейсы российской авиакомпании: маршруты, самолёты и схемы их салонов, бронирования, билеты и посадочные талоны.
</p>
<p>
    В этой копии рейсы с июля по сентябрь 2017 года. Названия аэропортов и самолётов хранятся в JSONB на английском и русском, а координаты аэропортов — в типе <span class="sql">point</span>. Поэтому на базе удобно тренировать и особенности PostgreSQL, и JOIN, и аналитику на больших таблицах.
</p>

{if $ErdImage}
    <h2>ER-диаграмма</h2>
    <p>Диаграмма показывает таблицы Bookings и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных Bookings">ER-диаграмма базы данных Bookings</object>
    </a>
{/if}

<h2>Из чего состоит база</h2>
<p>Таблицы делятся на две группы.</p>
<div class="db-groups">
    <div>
        <h3>Справочники</h3>
        <p><span class="sql">airports_data</span>, <span class="sql">aircrafts_data</span> и <span class="sql">seats</span> — схема мест для каждой модели самолёта.</p>
    </div>
    <div>
        <h3>Продажи и рейсы</h3>
        <p><span class="sql">bookings</span> → <span class="sql">tickets</span> → <span class="sql">ticket_flights</span> ← <span class="sql">flights</span>, а также <span class="sql">boarding_passes</span>, которые выдаются при регистрации.</p>
    </div>
</div>
<p>
    Главное, что стоит запомнить: в одном бронировании может быть несколько пассажиров, а один билет может включать несколько перелётов. Билеты и рейсы связывает <span class="sql">ticket_flights</span> — самая большая таблица. Представления <span class="sql">aircrafts</span>, <span class="sql">airports</span>, <span class="sql">flights_v</span> и <span class="sql">routes</span> показывают те же данные в более удобном виде.
</p>

<p>Сколько данных в таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">bookings</span></td><td class="num">262 788</td><td>бронирования</td></tr>
        <tr><td><span class="sql">tickets</span></td><td class="num">366 733</td><td>билеты, по одному на пассажира</td></tr>
        <tr><td><span class="sql">ticket_flights</span></td><td class="num">1 045 726</td><td>перелёты, входящие в билеты</td></tr>
        <tr><td><span class="sql">boarding_passes</span></td><td class="num">579 686</td><td>посадочные талоны</td></tr>
        <tr><td><span class="sql">flights</span></td><td class="num">33 121</td><td>рейсы по расписанию и выполненные</td></tr>
        <tr><td><span class="sql">airports_data</span></td><td class="num">104</td><td>аэропорты</td></tr>
        <tr><td><span class="sql">aircrafts_data</span></td><td class="num">9</td><td>модели самолётов</td></tr>
        <tr><td><span class="sql">seats</span></td><td class="num">1 339</td><td>места в салонах самолётов</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>{if $PlaygroundLink}Эти запросы показывают, как связаны данные. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.{else}Эти запросы показывают, как связаны данные.{/if}</p>

<p><strong>Билет и его бронирование</strong> — пассажир и сумма бронирования:</p>
<pre><code class="language-sql">SELECT t.ticket_no, t.passenger_name, b.book_date, b.total_amount
FROM tickets t
JOIN bookings b ON b.book_ref = t.book_ref
ORDER BY t.ticket_no
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>passenger_name</th><th>book_date</th><th>total_amount</th></tr>
        <tr><td class="num">0005432000987</td><td>VALERIY TIKHONOV</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000988</td><td>EVGENIYA ALEKSEEVA</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000989</td><td>ARTUR GERASIMOV</td><td>2017-06-28 22:55:00+00</td><td class="num">24700.00</td></tr>
    </table>
</div>

<p><strong>Рейс и самолёт</strong> — английское название из JSONB-столбца через <span class="sql">-&gt;&gt;</span>:</p>
<pre><code class="language-sql">SELECT f.flight_no, f.departure_airport, f.arrival_airport,
       a.model -&gt;&gt; 'en' AS aircraft
FROM flights f
JOIN aircrafts_data a ON a.aircraft_code = f.aircraft_code
ORDER BY f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>flight_no</th><th>departure_airport</th><th>arrival_airport</th><th>aircraft</th></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0404</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
    </table>
</div>

<p><strong>Тариф и место</strong> — от перелёта по билету к рейсу и посадочному талону. LEFT JOIN сохраняет перелёты без талона:</p>
<pre><code class="language-sql">SELECT tf.ticket_no, f.flight_no, tf.fare_conditions, tf.amount, bp.seat_no
FROM ticket_flights tf
JOIN flights f ON f.flight_id = tf.flight_id
LEFT JOIN boarding_passes bp
       ON bp.ticket_no = tf.ticket_no AND bp.flight_id = tf.flight_id
ORDER BY tf.ticket_no, f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>flight_no</th><th>fare_conditions</th><th>amount</th><th>seat_no</th></tr>
        <tr><td class="num">0005432000987</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>7A</td></tr>
        <tr><td class="num">0005432000988</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>10E</td></tr>
        <tr><td class="num">0005432000989</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>18E</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач на базе Bookings: {$TasksCount} — от простых выборок до аналитики по миллиону строк. Решение проверяется автоматически на настоящем PostgreSQL.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи по базе Bookings:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по Bookings →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать PostgreSQL, чтобы работать с Bookings?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице Bookings доступна в PostgreSQL 18.</p>
    <h3>Где скачать демобазу Bookings?</h3>
    <p>Postgres Professional публикует её на своём сайте в нескольких размерах вместе с описанием схемы.</p>
    <h3>Почему некоторые названия в фигурных скобках?</h3>
    <p>Названия аэропортов, городов и самолётов — это JSONB-объекты с английским и русским значениями. Чтобы получить текст на одном языке, используйте <span class="sql">-&gt;&gt; 'ru'</span> или обращайтесь к представлениям.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать PostgreSQL, чтобы работать с Bookings?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице Bookings доступна в PostgreSQL 18."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Где скачать демобазу Bookings?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Postgres Professional публикует её на своём сайте в нескольких размерах вместе с описанием схемы."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Почему некоторые названия в фигурных скобках?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Названия аэропортов, городов и самолётов — это JSONB-объекты с английским и русским значениями. Чтобы получить текст на одном языке, используйте -&gt;&gt; 'ru' или обращайтесь к представлениям."{rdelim}{rdelim}
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
