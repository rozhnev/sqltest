{* Text of the /en/database/sakila landing page (Controller::database(), shell database.tpl).
   Row counts checked on the mysql80_sakila playground database. *}
<h1>Sakila database: schema, tables and SQL exercises</h1>
<p class="db-lead">
    Sakila is the MySQL sample database for a chain of DVD rental stores.
    On SQLtest.online you can use it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tables and 7 views</li>
    <li><strong>1,000</strong> films</li>
    <li><strong>16,044</strong> rentals</li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve Sakila exercises</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Open Sakila in the playground</a>
</div>

<h2>What is Sakila</h2>
<p>
    Sakila was created by Mike Hillyer of the MySQL documentation team, so that examples in the documentation and in books could share one realistic schema.
    It is named after Sakila, the dolphin in the MySQL logo, and is distributed under the BSD license.
</p>
<p>
    The database models an everyday business: a film catalog with actors and genres, customers and staff of two stores, disc rentals and payments.
    That makes it good for learning: the relationships are clear without explanation, and there is enough data for grouping, window functions and analytics.
</p>

<h2>ER diagram</h2>
<p>The diagram shows the Sakila tables and the foreign keys between them. Click it to open the full-size version.</p>
<a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
    {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
    <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the Sakila database: tables and their relationships">ER diagram of the Sakila database</object>
</a>

<h2>What's inside</h2>
<p>The Sakila tables fall into three groups.</p>
<div class="db-groups">
    <div>
        <h3>Film catalog</h3>
        <p><span class="sql">film</span>, <span class="sql">actor</span>, <span class="sql">category</span>, <span class="sql">language</span> and the link tables <span class="sql">film_actor</span>, <span class="sql">film_category</span>.</p>
    </div>
    <div>
        <h3>Stores and people</h3>
        <p><span class="sql">store</span>, <span class="sql">staff</span>, <span class="sql">customer</span> and addresses: <span class="sql">address</span> → <span class="sql">city</span> → <span class="sql">country</span>.</p>
    </div>
    <div>
        <h3>Rentals and payments</h3>
        <p><span class="sql">inventory</span> holds the physical discs in each store, <span class="sql">rental</span> the rentals, <span class="sql">payment</span> the payments.</p>
    </div>
</div>
<p>
    The key thing to remember: a customer rents a disc, not a film. So <span class="sql">rental</span> is linked to <span class="sql">film</span> through <span class="sql">inventory</span>, not directly.
    The <span class="sql">film_text</span> table is a helper copy of titles and descriptions for full-text search.
</p>

<p>How much data the main tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">rental</span></td><td class="num">16,044</td><td>disc rentals</td></tr>
        <tr><td><span class="sql">payment</span></td><td class="num">16,049</td><td>customer payments</td></tr>
        <tr><td><span class="sql">film_actor</span></td><td class="num">5,462</td><td>actors' roles in films</td></tr>
        <tr><td><span class="sql">inventory</span></td><td class="num">4,581</td><td>discs in stores</td></tr>
        <tr><td><span class="sql">film</span></td><td class="num">1,000</td><td>films</td></tr>
        <tr><td><span class="sql">customer</span></td><td class="num">599</td><td>customers</td></tr>
        <tr><td><span class="sql">city</span></td><td class="num">600</td><td>cities</td></tr>
        <tr><td><span class="sql">actor</span></td><td class="num">200</td><td>actors</td></tr>
        <tr><td><span class="sql">country</span></td><td class="num">109</td><td>countries</td></tr>
        <tr><td><span class="sql">category</span></td><td class="num">16</td><td>genres</td></tr>
        <tr><td><span class="sql">store</span></td><td class="num">2</td><td>stores</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>These queries show how the tables are connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.</p>

<p><strong>A film and its language</strong>: a simple many-to-one relationship.</p>
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

<p><strong>Where a customer lives</strong>: a chain of four tables.</p>
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

<p><strong>Which film was rented and how much was paid</strong>: from a rental to its film through <span class="sql">inventory</span>.</p>
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

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} exercises on the Sakila database, from simple SELECT queries to analytics with window functions. Solutions are checked automatically on a real MySQL server.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises of the "Sakila database" section:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All Sakila exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install MySQL to use Sakila?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, Sakila is available on MySQL 8.0, MySQL 9.7 and MariaDB 10.</p>
    <h3>Where can I download the Sakila database?</h3>
    <p>The official <span class="sql">sakila-schema.sql</span> and <span class="sql">sakila-data.sql</span> files are on the <a href="https://dev.mysql.com/doc/index-other.html" target="_blank" rel="noopener">MySQL example databases page</a>, and the <a href="https://dev.mysql.com/doc/sakila/en/" target="_blank" rel="noopener">Sakila documentation</a> describes them.</p>
    <h3>Is there a Sakila database for PostgreSQL?</h3>
    <p>Yes, there is a port called Pagila. The structure is the same, but some types and functions are replaced with their PostgreSQL equivalents.</p>
    <h3>Can I change the data in Sakila?</h3>
    <p>In the playground the database is read-only, so everyone sees the same data. Exercises on INSERT, UPDATE and DELETE run on a temporary copy of the table they need, and then the copy's contents are checked.</p>
    <h3>Is Sakila good for SQL interview preparation?</h3>
    <p>Yes. It is a convenient way to practice JOINs, grouping, subqueries and window functions, the topics most often asked in technical interviews.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install MySQL to use Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, Sakila is available on MySQL 8.0, MySQL 9.7 and MariaDB 10."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Where can I download the Sakila database?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "The official sakila-schema.sql and sakila-data.sql files are on the MySQL example databases page (dev.mysql.com/doc/index-other.html), and the Sakila documentation describes them."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Is there a Sakila database for PostgreSQL?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Yes, there is a port called Pagila. The structure is the same, but some types and functions are replaced with their PostgreSQL equivalents."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Can I change the data in Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "In the playground the database is read-only, so everyone sees the same data. Exercises on INSERT, UPDATE and DELETE run on a temporary copy of the table they need, and then the copy's contents are checked."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Is Sakila good for SQL interview preparation?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Yes. It is a convenient way to practice JOINs, grouping, subqueries and window functions, the topics most often asked in technical interviews."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Start solving exercises</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Open the playground</a>
</div>
