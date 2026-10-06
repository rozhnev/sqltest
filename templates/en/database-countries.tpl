{* Text of the /en/database/countries landing page (Controller::database(), shell database.tpl).
   Row counts and query results checked on the psql17postgis playground database. *}
<h1>Countries database (PostGIS): spatial tables and SQL exercises</h1>
<p class="db-lead">
    Countries is a PostGIS database for learning spatial SQL: world countries and capitals, plus New York City layers with census blocks, neighborhoods, streets and subway stations.
    On SQLtest.online you can query it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>7</strong> spatial tables</li>
    <li><strong>246</strong> countries</li>
    <li><strong>491</strong> subway stations</li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve Countries exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open Countries in the playground</a>
    {/if}
</div>

<h2>What is Countries</h2>
<p>
    PostGIS is the PostgreSQL extension that adds geometry types and hundreds of spatial functions: distances, areas, intersections, coordinate transformations. This database lets you try them on familiar data.
</p>
<p>
    The New York City tables come from the well-known PostGIS workshop "Introduction to PostGIS", and the world tables hold country borders and capitals. Together they cover points, lines and polygons in two coordinate systems.
</p>

{if $ErdImage}
    <h2>ER diagram</h2>
    <p>The diagram shows the Countries tables and the foreign keys between them. Click it to open the full-size version.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the Countries database">ER diagram of the Countries database</object>
    </a>
{/if}

<h2>What's inside</h2>
<p>The tables fall into two groups.</p>
<div class="db-groups">
    <div>
        <h3>World</h3>
        <p><span class="sql">countries</span> with border polygons and <span class="sql">capitals</span> with points, both in SRID 4326 (longitude and latitude).</p>
    </div>
    <div>
        <h3>New York City</h3>
        <p><span class="sql">nyc_census_blocks</span>, <span class="sql">nyc_neighborhoods</span>, <span class="sql">nyc_streets</span>, <span class="sql">nyc_subway_stations</span> and <span class="sql">nyc_homicides</span>, in SRID 26918 (UTM zone 18N, meters).</p>
    </div>
</div>
<p>
    The key thing to remember: the world tables store degrees, the New York tables store meters. Distances and areas in the New York layers come out in meters directly; for the world tables, cast to <span class="sql">geography</span> or transform the geometry first.
</p>

<p>How much data the tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">countries</span></td><td class="num">246</td><td>countries and their borders</td></tr>
        <tr><td><span class="sql">capitals</span></td><td class="num">192</td><td>capitals</td></tr>
        <tr><td><span class="sql">nyc_census_blocks</span></td><td class="num">38,794</td><td>census blocks with population</td></tr>
        <tr><td><span class="sql">nyc_neighborhoods</span></td><td class="num">129</td><td>neighborhoods</td></tr>
        <tr><td><span class="sql">nyc_streets</span></td><td class="num">19,091</td><td>streets</td></tr>
        <tr><td><span class="sql">nyc_subway_stations</span></td><td class="num">491</td><td>subway stations</td></tr>
        <tr><td><span class="sql">nyc_homicides</span></td><td class="num">3,982</td><td>homicides</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>{if $PlaygroundLink}These queries show how the data is connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.{else}These queries show how the data is connected.{/if}</p>

<p><strong>A capital in its country</strong>: point coordinates with <span class="sql">ST_X</span> / <span class="sql">ST_Y</span> and a spatial check with <span class="sql">ST_Contains</span>.</p>
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

<p><strong>Subway stations and their SRID</strong>: New York layers use the projected system 26918.</p>
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

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} PostGIS exercises on this database: distances, areas, lengths, conversions to text and JSON, and spatial joins. Solutions are checked automatically on a real PostgreSQL with PostGIS.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises on the Countries database:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All Countries exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install PostGIS to use this database?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, choose PostgreSQL 17 + PostGIS WorkShop.</p>
    <h3>What is an SRID?</h3>
    <p>A spatial reference identifier: it says which coordinate system the coordinates are in. 4326 is longitude and latitude in degrees (WGS 84); 26918 is UTM zone 18N in meters, used for New York.</p>
    <h3>Where do the New York tables come from?</h3>
    <p>From the data set of the "Introduction to PostGIS" workshop published on postgis.net, a common starting point for learning PostGIS.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install PostGIS to use this database?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, choose PostgreSQL 17 + PostGIS WorkShop."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "What is an SRID?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "A spatial reference identifier: it says which coordinate system the coordinates are in. 4326 is longitude and latitude in degrees (WGS 84); 26918 is UTM zone 18N in meters, used for New York."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Where do the New York tables come from?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "From the data set of the \"Introduction to PostGIS\" workshop published on postgis.net, a common starting point for learning PostGIS."{rdelim}{rdelim}
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
