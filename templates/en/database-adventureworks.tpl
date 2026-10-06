{* Text of the /en/database/adventureworks landing page (Controller::database(), shell database.tpl).
   Row counts and query results checked on the mssql2022aw playground database. *}
<h1>AdventureWorks LT database: schema, tables and SQL exercises</h1>
<p class="db-lead">
    AdventureWorks LT is the Microsoft SQL Server sample database of a bicycle manufacturer: customers, products, product categories and sales orders.
    On SQLtest.online you can query it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>10</strong> main tables</li>
    <li><strong>847</strong> customers</li>
    <li><strong>295</strong> products</li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve AdventureWorks exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open AdventureWorks in the playground</a>
    {/if}
</div>

<h2>What is AdventureWorks</h2>
<p>
    AdventureWorks is the sample database Microsoft ships for SQL Server and Azure SQL. It describes Adventure Works Cycles, a fictional company that makes and sells bicycles, parts and accessories.
</p>
<p>
    The site uses AdventureWorks LT, the lightweight edition: the same business in about ten tables instead of dozens. It is a good place to practice T-SQL, including <span class="sql">TOP</span>, self-joins on a category tree and many-to-many relationships.
</p>

{if $ErdImage}
    <h2>ER diagram</h2>
    <p>The diagram shows the AdventureWorks tables and the foreign keys between them. Click it to open the full-size version.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the AdventureWorks database">ER diagram of the AdventureWorks database</object>
    </a>
{/if}

<h2>What's inside</h2>
<p>The tables fall into three groups.</p>
<div class="db-groups">
    <div>
        <h3>Customers</h3>
        <p><span class="sql">Customer</span>, <span class="sql">Address</span> and the link table <span class="sql">CustomerAddress</span>, which also stores the address type.</p>
    </div>
    <div>
        <h3>Products</h3>
        <p><span class="sql">Product</span>, <span class="sql">ProductCategory</span> (a tree: each category can have a parent), <span class="sql">ProductModel</span> and descriptions in several languages.</p>
    </div>
    <div>
        <h3>Sales</h3>
        <p><span class="sql">SalesOrderHeader</span> holds the orders, <span class="sql">SalesOrderDetail</span> their lines.</p>
    </div>
</div>
<p>
    All 32 orders in this edition are dated 1 June 2008. Product descriptions are linked to models through <span class="sql">ProductModelProductDescription</span>, which also stores the language (culture) of each description. The service tables <span class="sql">BuildVersion</span>, <span class="sql">ErrorLog</span> and <span class="sql">sysdiagrams</span> are not used in the exercises.
</p>

<p>How much data the tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">Customer</span></td><td class="num">847</td><td>customers</td></tr>
        <tr><td><span class="sql">CustomerAddress</span></td><td class="num">417</td><td>customer ↔ address links</td></tr>
        <tr><td><span class="sql">Address</span></td><td class="num">450</td><td>addresses</td></tr>
        <tr><td><span class="sql">SalesOrderHeader</span></td><td class="num">32</td><td>orders</td></tr>
        <tr><td><span class="sql">SalesOrderDetail</span></td><td class="num">542</td><td>order lines</td></tr>
        <tr><td><span class="sql">Product</span></td><td class="num">295</td><td>products</td></tr>
        <tr><td><span class="sql">ProductCategory</span></td><td class="num">41</td><td>product categories</td></tr>
        <tr><td><span class="sql">ProductModel</span></td><td class="num">128</td><td>product models</td></tr>
        <tr><td><span class="sql">ProductDescription</span></td><td class="num">762</td><td>product descriptions</td></tr>
        <tr><td><span class="sql">ProductModelProductDescription</span></td><td class="num">762</td><td>model ↔ description links by language</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>{if $PlaygroundLink}These queries show how the data is connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.{else}These queries show how the data is connected.{/if}</p>

<p><strong>A customer and their addresses</strong>: a many-to-many link through <span class="sql">CustomerAddress</span>.</p>
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

<p><strong>An order and its lines</strong>: from the order header to the products.</p>
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

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} exercises on the AdventureWorks database, from simple filters to analytics on orders and products. Solutions are checked automatically on a real SQL Server.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises on the AdventureWorks database:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All AdventureWorks exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install SQL Server to use AdventureWorks?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, AdventureWorks is available on SQL Server 2022.</p>
    <h3>How is AdventureWorks LT different from the full AdventureWorks?</h3>
    <p>The full database has dozens of tables in several schemas (Sales, Production, Person and others). The LT edition keeps the core of the business, customers, products and orders, in about ten tables, which is easier for learning.</p>
    <h3>Which SQL dialect do I use?</h3>
    <p>T-SQL, the SQL Server dialect. For example, use <span class="sql">TOP</span> or <span class="sql">OFFSET … FETCH</span> instead of <span class="sql">LIMIT</span>.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install SQL Server to use AdventureWorks?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, AdventureWorks is available on SQL Server 2022."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "How is AdventureWorks LT different from the full AdventureWorks?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "The full database has dozens of tables in several schemas (Sales, Production, Person and others). The LT edition keeps the core of the business, customers, products and orders, in about ten tables, which is easier for learning."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Which SQL dialect do I use?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "T-SQL, the SQL Server dialect. For example, use TOP or OFFSET … FETCH instead of LIMIT."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Start solving exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open the playground</a>
    {/if}
</div>
