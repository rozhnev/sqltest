{* Text of the /en/database/bookings landing page (Controller::database(), shell database.tpl).
   Row counts and query results checked on the psql18demo playground database. *}
<h1>Bookings database: airline schema, tables and SQL exercises</h1>
<p class="db-lead">
    Bookings is the PostgreSQL demo database of an airline: flights between 104 airports, bookings, tickets and boarding passes.
    On SQLtest.online you can query it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>8</strong> tables and 4 views</li>
    <li><strong>33,121</strong> flights</li>
    <li><strong>1,045,726</strong> tickets × flights</li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve Bookings exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open Bookings in the playground</a>
    {/if}
</div>

<h2>What is Bookings</h2>
<p>
    Bookings is the demo database that Postgres Professional publishes for learning PostgreSQL. It models the flights of a Russian airline: routes, aircraft and their seat maps, bookings, tickets and boarding passes.
</p>
<p>
    This copy holds flights from July to September 2017. Airport and aircraft names are stored as JSONB in English and Russian, and airport coordinates use the PostgreSQL <span class="sql">point</span> type, so the database is good for practicing PostgreSQL-specific SQL as well as JOINs and analytics on large tables.
</p>

{if $ErdImage}
    <h2>ER diagram</h2>
    <p>The diagram shows the Bookings tables and the foreign keys between them. Click it to open the full-size version.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the Bookings database">ER diagram of the Bookings database</object>
    </a>
{/if}

<h2>What's inside</h2>
<p>The tables fall into two groups.</p>
<div class="db-groups">
    <div>
        <h3>Reference data</h3>
        <p><span class="sql">airports_data</span>, <span class="sql">aircrafts_data</span> and <span class="sql">seats</span>: the seat map of each aircraft model.</p>
    </div>
    <div>
        <h3>Sales and flights</h3>
        <p><span class="sql">bookings</span> → <span class="sql">tickets</span> → <span class="sql">ticket_flights</span> ← <span class="sql">flights</span>, plus <span class="sql">boarding_passes</span> issued at check-in.</p>
    </div>
</div>
<p>
    The key thing to remember: one booking can include several passengers, and one ticket can cover several flights. The link between tickets and flights is <span class="sql">ticket_flights</span>, the largest table. The views <span class="sql">aircrafts</span>, <span class="sql">airports</span>, <span class="sql">flights_v</span> and <span class="sql">routes</span> show the same data in a friendlier form.
</p>

<p>How much data the tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">bookings</span></td><td class="num">262,788</td><td>bookings</td></tr>
        <tr><td><span class="sql">tickets</span></td><td class="num">366,733</td><td>tickets, one per passenger</td></tr>
        <tr><td><span class="sql">ticket_flights</span></td><td class="num">1,045,726</td><td>flight segments of tickets</td></tr>
        <tr><td><span class="sql">boarding_passes</span></td><td class="num">579,686</td><td>boarding passes</td></tr>
        <tr><td><span class="sql">flights</span></td><td class="num">33,121</td><td>scheduled and performed flights</td></tr>
        <tr><td><span class="sql">airports_data</span></td><td class="num">104</td><td>airports</td></tr>
        <tr><td><span class="sql">aircrafts_data</span></td><td class="num">9</td><td>aircraft models</td></tr>
        <tr><td><span class="sql">seats</span></td><td class="num">1,339</td><td>seats by aircraft model</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>{if $PlaygroundLink}These queries show how the data is connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.{else}These queries show how the data is connected.{/if}</p>

<p><strong>A ticket and its booking</strong>: the passenger and the booking amount.</p>
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

<p><strong>A flight and its aircraft</strong>: reading an English name from a JSONB column with <span class="sql">-&gt;&gt;</span>.</p>
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

<p><strong>Fare and seat</strong>: from a ticket segment to its flight and boarding pass. The LEFT JOIN keeps segments without a boarding pass.</p>
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

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} exercises on the Bookings database, from simple lookups to analytics over a million rows. Solutions are checked automatically on a real PostgreSQL server.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises on the Bookings database:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All Bookings exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install PostgreSQL to use the Bookings database?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, Bookings is available on PostgreSQL 18.</p>
    <h3>Where can I download the Bookings demo database?</h3>
    <p>Postgres Professional publishes it in several sizes on its website, together with a description of the schema.</p>
    <h3>Why are some names in curly braces?</h3>
    <p>Airport, city and aircraft names are JSONB objects with English and Russian values. Use <span class="sql">-&gt;&gt; 'en'</span> to get the English text, or query the views, which pick one language.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install PostgreSQL to use the Bookings database?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, Bookings is available on PostgreSQL 18."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Where can I download the Bookings demo database?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Postgres Professional publishes it in several sizes on its website, together with a description of the schema."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Why are some names in curly braces?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Airport, city and aircraft names are JSONB objects with English and Russian values. Use -&gt;&gt; 'en' to get the English text, or query the views, which pick one language."{rdelim}{rdelim}
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
