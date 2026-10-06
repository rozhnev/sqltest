{* Текст лендинга /ru/database/sakila (Controller::database(), оболочка database.tpl).
   Числа строк проверены на базе песочницы mysql80_sakila. *}
<h1>База данных Sakila: схема, таблицы и SQL-задачи</h1>
<p class="db-lead">
    Sakila — учебная база данных компании MySQL, которая описывает сеть пунктов проката фильмов на DVD.
    На SQLtest.online с ней можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>16</strong> таблиц и 7 представлений</li>
    <li><strong>1 000</strong> фильмов</li>
    <li><strong>16 044</strong> записи о прокате</li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по Sakila</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Открыть Sakila в песочнице</a>
</div>

<h2>Что такое Sakila</h2>
<p>
    Sakila создал Майк Хиллиер (Mike Hillyer) из команды документации MySQL, чтобы у примеров в документации и книгах была одна общая и достаточно реалистичная схема.
    Название база получила в честь дельфина Sakila с логотипа MySQL. Распространяется по лицензии BSD.
</p>
<p>
    База моделирует обычный бизнес: каталог фильмов с актёрами и жанрами, клиентов и сотрудников двух магазинов, прокат дисков и оплату.
    Поэтому на ней удобно учиться: связи между таблицами понятны без пояснений, а данных хватает для группировок, оконных функций и аналитики.
</p>

<h2>ER-диаграмма</h2>
<p>Диаграмма показывает таблицы Sakila и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
<a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
    {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
    <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных Sakila: таблицы и связи между ними">ER-диаграмма базы данных Sakila</object>
</a>

<h2>Из чего состоит база</h2>
<p>Таблицы Sakila удобно разделить на три группы.</p>
<div class="db-groups">
    <div>
        <h3>Каталог фильмов</h3>
        <p><span class="sql">film</span>, <span class="sql">actor</span>, <span class="sql">category</span>, <span class="sql">language</span> и таблицы связей <span class="sql">film_actor</span>, <span class="sql">film_category</span>.</p>
    </div>
    <div>
        <h3>Магазины и люди</h3>
        <p><span class="sql">store</span>, <span class="sql">staff</span>, <span class="sql">customer</span> и адреса: <span class="sql">address</span> → <span class="sql">city</span> → <span class="sql">country</span>.</p>
    </div>
    <div>
        <h3>Прокат и платежи</h3>
        <p><span class="sql">inventory</span> — конкретные диски в магазинах, <span class="sql">rental</span> — выдачи, <span class="sql">payment</span> — оплаты.</p>
    </div>
</div>
<p>
    Главное, что стоит запомнить: клиент берёт в прокат не фильм, а диск. Поэтому <span class="sql">rental</span> связана с <span class="sql">film</span> не напрямую, а через <span class="sql">inventory</span>.
    Таблица <span class="sql">film_text</span> — вспомогательная копия названий и описаний для полнотекстового поиска.
</p>

<p>Сколько данных в основных таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">rental</span></td><td class="num">16 044</td><td>выдачи дисков</td></tr>
        <tr><td><span class="sql">payment</span></td><td class="num">16 049</td><td>платежи клиентов</td></tr>
        <tr><td><span class="sql">film_actor</span></td><td class="num">5 462</td><td>роли актёров в фильмах</td></tr>
        <tr><td><span class="sql">inventory</span></td><td class="num">4 581</td><td>диски в магазинах</td></tr>
        <tr><td><span class="sql">film</span></td><td class="num">1 000</td><td>фильмы</td></tr>
        <tr><td><span class="sql">customer</span></td><td class="num">599</td><td>клиенты</td></tr>
        <tr><td><span class="sql">city</span></td><td class="num">600</td><td>города</td></tr>
        <tr><td><span class="sql">actor</span></td><td class="num">200</td><td>актёры</td></tr>
        <tr><td><span class="sql">country</span></td><td class="num">109</td><td>страны</td></tr>
        <tr><td><span class="sql">category</span></td><td class="num">16</td><td>жанры</td></tr>
        <tr><td><span class="sql">store</span></td><td class="num">2</td><td>магазины</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>Эти запросы показывают, как связаны таблицы. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.</p>

<p><strong>Фильм и его язык</strong> — простая связь «многие к одному»:</p>
<pre><code class="language-sql">SELECT f.title, l.name AS language, f.rental_rate, f.length
FROM film f
JOIN language l ON l.language_id = f.language_id
ORDER BY f.film_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>title</th><th>language</th><th>rental_rate</th><th>length</th></tr>
        <tr><td>ACADEMY DINOSAUR</td><td>English</td><td class="num">0.99</td><td class="num">86</td></tr>
        <tr><td>ACE GOLDFINGER</td><td>English</td><td class="num">4.99</td><td class="num">48</td></tr>
        <tr><td>ADAPTATION HOLES</td><td>English</td><td class="num">2.99</td><td class="num">50</td></tr>
    </table>
</div>

<p><strong>Где живёт клиент</strong> — цепочка из четырёх таблиц:</p>
<pre><code class="language-sql">SELECT c.first_name, c.last_name, ci.city, co.country
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
ORDER BY c.customer_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>city</th><th>country</th></tr>
        <tr><td>MARY</td><td>SMITH</td><td>Sasebo</td><td>Japan</td></tr>
        <tr><td>PATRICIA</td><td>JOHNSON</td><td>San Bernardino</td><td>United States</td></tr>
        <tr><td>LINDA</td><td>WILLIAMS</td><td>Athenai</td><td>Greece</td></tr>
    </table>
</div>

<p><strong>Какой фильм взяли и сколько заплатили</strong> — путь от проката к фильму через <span class="sql">inventory</span>:</p>
<pre><code class="language-sql">SELECT r.rental_date, f.title, p.amount
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN payment p ON p.rental_id = r.rental_id
ORDER BY r.rental_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>rental_date</th><th>title</th><th>amount</th></tr>
        <tr><td>2005-05-24 22:53:30</td><td>BLANKET BEVERLY</td><td class="num">2.99</td></tr>
        <tr><td>2005-05-24 22:54:33</td><td>FREAKY POCUS</td><td class="num">2.99</td></tr>
        <tr><td>2005-05-24 23:03:39</td><td>GRADUATE LORD</td><td class="num">3.99</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач на базе Sakila: {$TasksCount} — от простых SELECT до аналитики с оконными функциями. Решение проверяется автоматически на настоящей MySQL.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи раздела «База данных Sakila»:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по Sakila →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать MySQL, чтобы работать с Sakila?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице Sakila доступна в MySQL 8.0, MySQL 9.7 и MariaDB 10.</p>
    <h3>Где скачать базу Sakila?</h3>
    <p>Официальные файлы <span class="sql">sakila-schema.sql</span> и <span class="sql">sakila-data.sql</span> лежат на <a href="https://dev.mysql.com/doc/index-other.html" target="_blank" rel="noopener">странице примеров баз данных MySQL</a>, описание — в <a href="https://dev.mysql.com/doc/sakila/en/" target="_blank" rel="noopener">документации Sakila</a>.</p>
    <h3>Есть ли Sakila для PostgreSQL?</h3>
    <p>Да, есть порт под названием Pagila. Структура та же, но некоторые типы и функции заменены на аналоги из PostgreSQL.</p>
    <h3>Можно ли изменять данные в Sakila?</h3>
    <p>В песочнице база доступна только для чтения, чтобы у всех были одинаковые данные. Задачи на INSERT, UPDATE и DELETE выполняются на временной копии нужной таблицы, после чего проверяется её содержимое.</p>
    <h3>Подойдёт ли Sakila для подготовки к собеседованию?</h3>
    <p>Да. На ней удобно отработать JOIN, группировки, подзапросы и оконные функции — темы, которые чаще всего спрашивают на технических интервью.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать MySQL, чтобы работать с Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице Sakila доступна в MySQL 8.0, MySQL 9.7 и MariaDB 10."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Где скачать базу Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Официальные файлы sakila-schema.sql и sakila-data.sql лежат на странице примеров баз данных MySQL (dev.mysql.com/doc/index-other.html), описание — в документации Sakila."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Есть ли Sakila для PostgreSQL?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Да, есть порт под названием Pagila. Структура та же, но некоторые типы и функции заменены на аналоги из PostgreSQL."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Можно ли изменять данные в Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "В песочнице база доступна только для чтения, чтобы у всех были одинаковые данные. Задачи на INSERT, UPDATE и DELETE выполняются на временной копии нужной таблицы, после чего проверяется её содержимое."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Подойдёт ли Sakila для подготовки к собеседованию?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Да. На ней удобно отработать JOIN, группировки, подзапросы и оконные функции — темы, которые чаще всего спрашивают на технических интервью."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Начать решать задачи</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Открыть песочницу</a>
</div>
