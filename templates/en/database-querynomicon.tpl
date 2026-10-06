{* Text of the /en/database/querynomicon landing page (Controller::database(), shell database.tpl).
   Row counts and query results checked on the sqlite3_data playground database. *}
<h1>Querynomicon database (SQLite): penguins, tables and SQL exercises</h1>
<p class="db-lead">
    Querynomicon is a small SQLite database for learning SQL from scratch: the Palmer penguins dataset plus a tiny laboratory with staff, experiments and assay plates.
    On SQLtest.online you can query it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>13</strong> tables</li>
    <li><strong>344</strong> penguins</li>
    <li><strong>50</strong> experiments</li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve Querynomicon exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open Querynomicon in the playground</a>
    {/if}
</div>

<h2>What is Querynomicon</h2>
<p>
    The database comes from the Querynomicon, Greg Wilson's free tutorial "An Introduction to SQL for Wary Data Scientists". Its main table holds the Palmer penguins: measurements of 344 penguins of three species from three islands in Antarctica.
</p>
<p>
    The data is small and easy to read, but it has the quirks of real data: missing values (NULL) in measurements and in the sex column. That makes it a good place to learn filtering, sorting, grouping, NULL handling and the basics of DDL and DML.
</p>

{if $ErdImage}
    <h2>ER diagram</h2>
    <p>The diagram shows the Querynomicon tables and the foreign keys between them. Click it to open the full-size version.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the Querynomicon database">ER diagram of the Querynomicon database</object>
    </a>
{/if}

<h2>What's inside</h2>
<p>The tables fall into two groups.</p>
<div class="db-groups">
    <div>
        <h3>Penguins</h3>
        <p><span class="sql">penguins</span> with all 344 birds and <span class="sql">little_penguins</span>, a 10-row sample for quick experiments.</p>
    </div>
    <div>
        <h3>Laboratory</h3>
        <p><span class="sql">department</span>, <span class="sql">staff</span>, <span class="sql">experiment</span>, <span class="sql">performed</span> (who ran which experiment), <span class="sql">plate</span> and <span class="sql">invalidated</span>, plus <span class="sql">machine</span>, <span class="sql">usage</span>, <span class="sql">person</span> and <span class="sql">contact</span>.</p>
    </div>
</div>
<p>
    The penguin tables have no keys: each row is one bird. The laboratory tables are linked by numeric identifiers, and <span class="sql">performed</span> links staff and experiments many-to-many.
</p>

<p>How much data the tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">penguins</span></td><td class="num">344</td><td>penguins and their measurements</td></tr>
        <tr><td><span class="sql">little_penguins</span></td><td class="num">10</td><td>a sample of 10 penguins</td></tr>
        <tr><td><span class="sql">department</span></td><td class="num">4</td><td>departments</td></tr>
        <tr><td><span class="sql">staff</span></td><td class="num">10</td><td>staff</td></tr>
        <tr><td><span class="sql">experiment</span></td><td class="num">50</td><td>experiments</td></tr>
        <tr><td><span class="sql">performed</span></td><td class="num">65</td><td>staff ↔ experiments</td></tr>
        <tr><td><span class="sql">plate</span></td><td class="num">256</td><td>assay plates</td></tr>
        <tr><td><span class="sql">invalidated</span></td><td class="num">30</td><td>invalidated plates</td></tr>
        <tr><td><span class="sql">machine</span></td><td class="num">3</td><td>lab machines</td></tr>
        <tr><td><span class="sql">person</span></td><td class="num">15</td><td>people</td></tr>
        <tr><td><span class="sql">usage</span></td><td class="num">8</td><td>machine usage log</td></tr>
        <tr><td><span class="sql">contact</span></td><td class="num">8</td><td>contacts</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>{if $PlaygroundLink}These queries show how the data is connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.{else}These queries show how the data is connected.{/if}</p>

<p><strong>Experiments and plates</strong>: a one-to-many relationship with a LEFT JOIN and a count.</p>
<pre><code class="language-sql">SELECT e.ident, e.kind, e.started, COUNT(p.ident) AS plates
FROM experiment e
LEFT JOIN plate p ON p.experiment = e.ident
GROUP BY e.ident
ORDER BY e.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ident</th><th>kind</th><th>started</th><th>plates</th></tr>
        <tr><td class="num">1</td><td>calibration</td><td>2023-08-25</td><td class="num">1</td></tr>
        <tr><td class="num">2</td><td>calibration</td><td>2023-02-14</td><td class="num">1</td></tr>
        <tr><td class="num">3</td><td>trial</td><td>2023-02-22</td><td class="num">10</td></tr>
    </table>
</div>

<p><strong>Who ran an experiment</strong>: a many-to-many relationship through <span class="sql">performed</span>.</p>
<pre><code class="language-sql">SELECT s.personal, s.family, e.kind, e.started
FROM performed pf
JOIN staff s ON s.ident = pf.staff
JOIN experiment e ON e.ident = pf.experiment
ORDER BY e.ident, s.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>personal</th><th>family</th><th>kind</th><th>started</th></tr>
        <tr><td>Nitya</td><td>Lal</td><td>calibration</td><td>2023-08-25</td></tr>
        <tr><td>Indrans</td><td>Sridhar</td><td>calibration</td><td>2023-02-14</td></tr>
        <tr><td>Kartik</td><td>Gupta</td><td>trial</td><td>2023-02-22</td></tr>
    </table>
</div>

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} exercises on the Querynomicon database, from the first SELECT to views, indexes and triggers. Solutions are checked automatically on a real SQLite.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises on the Querynomicon database:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All Querynomicon exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install SQLite to use the Querynomicon database?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, choose SQLite 3 Preloaded.</p>
    <h3>What are the Palmer penguins?</h3>
    <p>A popular teaching dataset: measurements of Adelie, Chinstrap and Gentoo penguins collected at Palmer Station, Antarctica. It is often used as a modern replacement for the iris dataset.</p>
    <h3>Is this database good for beginners?</h3>
    <p>Yes. The tables are small and the subject needs no explanation, so you can focus on SQL itself: SELECT, WHERE, ORDER BY, GROUP BY and handling NULL.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install SQLite to use the Querynomicon database?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, choose SQLite 3 Preloaded."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "What are the Palmer penguins?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "A popular teaching dataset: measurements of Adelie, Chinstrap and Gentoo penguins collected at Palmer Station, Antarctica. It is often used as a modern replacement for the iris dataset."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Is this database good for beginners?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Yes. The tables are small and the subject needs no explanation, so you can focus on SQL itself: SELECT, WHERE, ORDER BY, GROUP BY and handling NULL."{rdelim}{rdelim}
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
