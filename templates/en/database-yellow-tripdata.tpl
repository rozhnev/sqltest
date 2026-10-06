{* Text of the /en/database/yellow-tripdata landing page (Controller::database(), shell database.tpl).
   Row counts and query results checked on the duckdb_data playground database. *}
<h1>NYC Yellow Taxi dataset (DuckDB): the yellow_tripdata table and SQL exercises</h1>
<p class="db-lead">
    yellow_tripdata holds the New York City yellow taxi trips of January 2024, almost 3 million rows, loaded into DuckDB for analytical SQL.
    On SQLtest.online you can query it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>1</strong> table, 19 columns</li>
    <li><strong>2,964,624</strong> trips</li>
    <li><strong>January 2024</strong> </li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve NYC Yellow Taxi exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open NYC Yellow Taxi in the playground</a>
    {/if}
</div>

<h2>What is NYC Yellow Taxi</h2>
<p>
    The data comes from the trip records that the New York City Taxi and Limousine Commission (TLC) publishes every month. Each row is one trip: pickup and drop-off time, distance, number of passengers, pickup and drop-off zones, payment type and every part of the fare.
</p>
<p>
    DuckDB is an embedded analytical database with columnar storage, so aggregations over millions of rows run in a fraction of a second. That makes the dataset a good place to practice real analytics: time series, distributions, percentiles and data cleaning.
</p>

{if $ErdImage}
    <h2>ER diagram</h2>
    <p>The diagram shows the NYC Yellow Taxi tables and the foreign keys between them. Click it to open the full-size version.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the NYC Yellow Taxi database">ER diagram of the NYC Yellow Taxi database</object>
    </a>
{/if}

<h2>What's inside</h2>
<p>
    All the data is in one table, <span class="sql">yellow_tripdata</span>. Every column allows NULL, and there are no keys or constraints. <span class="sql">PULocationID</span> and <span class="sql">DOLocationID</span> are TLC taxi zone numbers. A few trips have pickup times outside January 2024 and some have zero or negative amounts: real data needs cleaning, and some exercises are about exactly that.
</p>

<p>How much data the tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">yellow_tripdata</span></td><td class="num">2,964,624</td><td>yellow taxi trips</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>{if $PlaygroundLink}These queries show how the data is connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.{else}These queries show how the data is connected.{/if}</p>

<p><strong>Trip duration</strong>: DuckDB's <span class="sql">date_diff</span> between pickup and drop-off.</p>
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

<p><strong>A quick count</strong>: DuckDB's <span class="sql">GROUP BY ALL</span> groups by every non-aggregated column.</p>
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

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} exercises on this dataset, from overall statistics to time series and data quality checks. Solutions are checked automatically on a real DuckDB.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises on the NYC Yellow Taxi database:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All NYC Yellow Taxi exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install DuckDB to use this dataset?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, choose DuckDB.</p>
    <h3>Where does the data come from?</h3>
    <p>From the NYC Taxi and Limousine Commission trip record data, which is published monthly as Parquet files. This copy holds the yellow taxi trips of January 2024.</p>
    <h3>How is DuckDB SQL different?</h3>
    <p>It is close to PostgreSQL, with extras for analytics such as <span class="sql">GROUP BY ALL</span>, <span class="sql">QUALIFY</span>, <span class="sql">date_diff</span> and quantile functions.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install DuckDB to use this dataset?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, choose DuckDB."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Where does the data come from?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "From the NYC Taxi and Limousine Commission trip record data, which is published monthly as Parquet files. This copy holds the yellow taxi trips of January 2024."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "How is DuckDB SQL different?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "It is close to PostgreSQL, with extras for analytics such as GROUP BY ALL, QUALIFY, date_diff and quantile functions."{rdelim}{rdelim}
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
