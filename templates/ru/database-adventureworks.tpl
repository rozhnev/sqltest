{* Текст лендинга /ru/database/adventureworks (Controller::database(), оболочка database.tpl).
   Числа строк и результаты запросов проверены на базе песочницы mssql2022aw. *}
<h1>База данных AdventureWorks LT: схема, таблицы и SQL-задачи</h1>
<p class="db-lead">
    AdventureWorks LT — учебная база Microsoft SQL Server о производителе велосипедов: клиенты, товары, категории товаров и заказы.
    На SQLtest.online с ней можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>10</strong> основных таблиц</li>
    <li><strong>847</strong> клиентов</li>
    <li><strong>295</strong> товаров</li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по AdventureWorks</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть AdventureWorks в песочнице</a>
    {/if}
</div>

<h2>Что такое AdventureWorks</h2>
<p>
    AdventureWorks — пример базы данных, который Microsoft поставляет для SQL Server и Azure SQL. Она описывает вымышленную компанию Adventure Works Cycles, которая производит и продаёт велосипеды, запчасти и аксессуары.
</p>
<p>
    На сайте используется AdventureWorks LT — облегчённая версия: тот же бизнес примерно в десяти таблицах вместо нескольких десятков. На ней удобно тренировать T-SQL: <span class="sql">TOP</span>, самосоединение по дереву категорий и связи «многие ко многим».
</p>

{if $ErdImage}
    <h2>ER-диаграмма</h2>
    <p>Диаграмма показывает таблицы AdventureWorks и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных AdventureWorks">ER-диаграмма базы данных AdventureWorks</object>
    </a>
{/if}

<h2>Из чего состоит база</h2>
<p>Таблицы делятся на три группы.</p>
<div class="db-groups">
    <div>
        <h3>Клиенты</h3>
        <p><span class="sql">Customer</span>, <span class="sql">Address</span> и таблица связей <span class="sql">CustomerAddress</span>, где хранится и тип адреса.</p>
    </div>
    <div>
        <h3>Товары</h3>
        <p><span class="sql">Product</span>, <span class="sql">ProductCategory</span> (дерево: у категории может быть родитель), <span class="sql">ProductModel</span> и описания на нескольких языках.</p>
    </div>
    <div>
        <h3>Продажи</h3>
        <p><span class="sql">SalesOrderHeader</span> — заказы, <span class="sql">SalesOrderDetail</span> — их строки.</p>
    </div>
</div>
<p>
    Все 32 заказа в этой версии датированы 1 июня 2008 года. Описания товаров связаны с моделями через <span class="sql">ProductModelProductDescription</span>, где указан и язык (culture) описания. Служебные таблицы <span class="sql">BuildVersion</span>, <span class="sql">ErrorLog</span> и <span class="sql">sysdiagrams</span> в задачах не используются.
</p>

<p>Сколько данных в таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">Customer</span></td><td class="num">847</td><td>клиенты</td></tr>
        <tr><td><span class="sql">CustomerAddress</span></td><td class="num">417</td><td>связи клиентов и адресов</td></tr>
        <tr><td><span class="sql">Address</span></td><td class="num">450</td><td>адреса</td></tr>
        <tr><td><span class="sql">SalesOrderHeader</span></td><td class="num">32</td><td>заказы</td></tr>
        <tr><td><span class="sql">SalesOrderDetail</span></td><td class="num">542</td><td>строки заказов</td></tr>
        <tr><td><span class="sql">Product</span></td><td class="num">295</td><td>товары</td></tr>
        <tr><td><span class="sql">ProductCategory</span></td><td class="num">41</td><td>категории товаров</td></tr>
        <tr><td><span class="sql">ProductModel</span></td><td class="num">128</td><td>модели товаров</td></tr>
        <tr><td><span class="sql">ProductDescription</span></td><td class="num">762</td><td>описания товаров</td></tr>
        <tr><td><span class="sql">ProductModelProductDescription</span></td><td class="num">762</td><td>связи моделей и описаний по языкам</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>{if $PlaygroundLink}Эти запросы показывают, как связаны данные. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.{else}Эти запросы показывают, как связаны данные.{/if}</p>

<p><strong>Клиент и его адреса</strong> — связь «многие ко многим» через <span class="sql">CustomerAddress</span>:</p>
<pre><code class="language-sql">SELECT TOP 3 c.FirstName, c.LastName, ca.AddressType, a.City
FROM Customer c
JOIN CustomerAddress ca ON ca.CustomerID = c.CustomerID
JOIN Address a ON a.AddressID = ca.AddressID
ORDER BY c.CustomerID;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>FirstName</th><th>LastName</th><th>AddressType</th><th>City</th></tr>
        <tr><td>Catherine</td><td>Abel</td><td>Main Office</td><td>Van Nuys</td></tr>
        <tr><td>Kim</td><td>Abercrombie</td><td>Main Office</td><td>Branch</td></tr>
        <tr><td>Frances</td><td>Adams</td><td>Main Office</td><td>Modesto</td></tr>
    </table>
</div>

<p><strong>Заказ и его строки</strong> — от заголовка заказа к товарам:</p>
<pre><code class="language-sql">SELECT TOP 3 h.SalesOrderID, h.OrderDate, p.Name, d.OrderQty, d.UnitPrice
FROM SalesOrderHeader h
JOIN SalesOrderDetail d ON d.SalesOrderID = h.SalesOrderID
JOIN Product p ON p.ProductID = d.ProductID
ORDER BY h.SalesOrderID, d.SalesOrderDetailID;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>SalesOrderID</th><th>OrderDate</th><th>Name</th><th>OrderQty</th><th>UnitPrice</th></tr>
        <tr><td class="num">71774</td><td>2008-06-01 00:00:00.000</td><td>ML Road Frame-W - Yellow, 48</td><td class="num">1</td><td class="num">356.8980</td></tr>
        <tr><td class="num">71774</td><td>2008-06-01 00:00:00.000</td><td>ML Road Frame-W - Yellow, 38</td><td class="num">1</td><td class="num">356.8980</td></tr>
        <tr><td class="num">71776</td><td>2008-06-01 00:00:00.000</td><td>Rear Brakes</td><td class="num">1</td><td class="num">63.9000</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач на базе AdventureWorks: {$TasksCount} — от простых фильтров до аналитики по заказам и товарам. Решение проверяется автоматически на настоящем SQL Server.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи по базе AdventureWorks:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по AdventureWorks →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать SQL Server, чтобы работать с AdventureWorks?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице AdventureWorks доступна в SQL Server 2022.</p>
    <h3>Чем AdventureWorks LT отличается от полной AdventureWorks?</h3>
    <p>В полной базе десятки таблиц в нескольких схемах (Sales, Production, Person и другие). Версия LT оставляет основу бизнеса — клиентов, товары и заказы — примерно в десяти таблицах, поэтому учиться на ней проще.</p>
    <h3>Какой диалект SQL используется?</h3>
    <p>T-SQL — диалект SQL Server. Например, вместо <span class="sql">LIMIT</span> используйте <span class="sql">TOP</span> или <span class="sql">OFFSET … FETCH</span>.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать SQL Server, чтобы работать с AdventureWorks?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице AdventureWorks доступна в SQL Server 2022."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Чем AdventureWorks LT отличается от полной AdventureWorks?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "В полной базе десятки таблиц в нескольких схемах (Sales, Production, Person и другие). Версия LT оставляет основу бизнеса — клиентов, товары и заказы — примерно в десяти таблицах, поэтому учиться на ней проще."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Какой диалект SQL используется?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "T-SQL — диалект SQL Server. Например, вместо LIMIT используйте TOP или OFFSET … FETCH."{rdelim}{rdelim}
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
