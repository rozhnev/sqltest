{* Text of the /en/database/university landing page (Controller::database(), shell database.tpl).
   Row counts and query results checked on the mariadb118_university playground database. *}
<h1>University database (MariaDB): schema, tables and SQL exercises</h1>
<p class="db-lead">
    University is a sample MariaDB database of a university: departments, faculty, students, courses, class sections, enrollments, grades and research.
    On SQLtest.online you can query it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tables and 7 views</li>
    <li><strong>2,000</strong> students</li>
    <li><strong>24,981</strong> enrollments</li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve University exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open University in the playground</a>
    {/if}
</div>

<h2>What is University</h2>
<p>
    University is a modern sample database for MariaDB 11, designed as a richer alternative to the classic Sakila. It is normalized to third normal form and uses many MariaDB data types: JSON, ENUM and SET, FULLTEXT indexes and VECTOR columns for embeddings.
</p>
<p>
    The data is large enough for real analytics: about 25 thousand enrollments, 300 thousand grade events and an audit log of more than half a million rows. At the same time the subject is familiar to anyone who has studied at a university.
</p>

{if $ErdImage}
    <h2>ER diagram</h2>
    <p>The diagram shows the University tables and the foreign keys between them. Click it to open the full-size version.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the University database">ER diagram of the University database</object>
    </a>
{/if}

<h2>What's inside</h2>
<p>The tables fall into three groups.</p>
<div class="db-groups">
    <div>
        <h3>People and structure</h3>
        <p><span class="sql">departments</span> (a tree), <span class="sql">faculty</span>, <span class="sql">students</span> and <span class="sql">rooms</span>.</p>
    </div>
    <div>
        <h3>Teaching</h3>
        <p><span class="sql">courses</span> with <span class="sql">course_prerequisites</span>, <span class="sql">semesters</span>, <span class="sql">sections</span>, <span class="sql">enrollments</span> and <span class="sql">grade_events</span>.</p>
    </div>
    <div>
        <h3>Research and money</h3>
        <p><span class="sql">research_projects</span>, <span class="sql">project_members</span>, <span class="sql">publications</span>, <span class="sql">scholarships</span> and <span class="sql">student_scholarships</span>, plus <span class="sql">audit_log</span>.</p>
    </div>
</div>
<p>
    The key thing to remember: students enroll in a section, a specific run of a course in a semester, not in the course itself. So the path from a student to a course is <span class="sql">enrollments</span> → <span class="sql">sections</span> → <span class="sql">courses</span>. Seven views, such as <span class="sql">v_student_gpa</span> and <span class="sql">v_course_pass_rate</span>, contain ready-made reports.
</p>

<p>How much data the tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">students</span></td><td class="num">2,000</td><td>students</td></tr>
        <tr><td><span class="sql">faculty</span></td><td class="num">250</td><td>teaching staff</td></tr>
        <tr><td><span class="sql">departments</span></td><td class="num">25</td><td>departments</td></tr>
        <tr><td><span class="sql">courses</span></td><td class="num">116</td><td>courses</td></tr>
        <tr><td><span class="sql">course_prerequisites</span></td><td class="num">49</td><td>course prerequisites</td></tr>
        <tr><td><span class="sql">semesters</span></td><td class="num">20</td><td>semesters</td></tr>
        <tr><td><span class="sql">sections</span></td><td class="num">1,715</td><td>course sections in a semester</td></tr>
        <tr><td><span class="sql">rooms</span></td><td class="num">48</td><td>rooms</td></tr>
        <tr><td><span class="sql">enrollments</span></td><td class="num">24,981</td><td>enrollments in sections</td></tr>
        <tr><td><span class="sql">grade_events</span></td><td class="num">307,081</td><td>grades for assignments and exams</td></tr>
        <tr><td><span class="sql">research_projects</span></td><td class="num">200</td><td>research projects</td></tr>
        <tr><td><span class="sql">project_members</span></td><td class="num">876</td><td>project members</td></tr>
        <tr><td><span class="sql">publications</span></td><td class="num">500</td><td>publications</td></tr>
        <tr><td><span class="sql">scholarships</span></td><td class="num">20</td><td>scholarships</td></tr>
        <tr><td><span class="sql">student_scholarships</span></td><td class="num">773</td><td>scholarships awarded to students</td></tr>
        <tr><td><span class="sql">audit_log</span></td><td class="num">664,124</td><td>change log</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>{if $PlaygroundLink}These queries show how the data is connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.{else}These queries show how the data is connected.{/if}</p>

<p><strong>A student, course and grade</strong>: from an enrollment through the section to the course and semester.</p>
<pre><code class="language-sql">SELECT s.first_name, s.last_name, c.code, sem.name AS semester, e.final_grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN sections sec ON sec.section_id = e.section_id
JOIN courses c ON c.course_id = sec.course_id
JOIN semesters sem ON sem.semester_id = sec.semester_id
WHERE e.final_grade IS NOT NULL
ORDER BY e.enrollment_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>code</th><th>semester</th><th>final_grade</th></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH111</td><td>Fall 2024</td><td>B+</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>NURS102</td><td>Fall 2024</td><td>B</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH106</td><td>Summer 2024</td><td>B</td></tr>
    </table>
</div>

<p><strong>Office hours from JSON</strong>: reading a value from a JSON column with <span class="sql">JSON_VALUE</span>.</p>
<pre><code class="language-sql">SELECT first_name, last_name,
       JSON_VALUE(office_hours, '$[0].day') AS day,
       JSON_VALUE(office_hours, '$[0].start') AS starts_at
FROM faculty
ORDER BY faculty_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>day</th><th>starts_at</th></tr>
        <tr><td>Danielle</td><td>Johnson</td><td>Tue</td><td>09:00</td></tr>
        <tr><td>Jason</td><td>Hahn</td><td>Fri</td><td>08:00</td></tr>
        <tr><td>Kathleen</td><td>Cannon</td><td>Fri</td><td>08:00</td></tr>
    </table>
</div>

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} exercises on the University database so far, and new ones are being added. Solutions are checked automatically on a real MariaDB server.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises on the University database:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All University exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install MariaDB to use the University database?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, University is available on MariaDB 11.8.</p>
    <h3>Which MariaDB features does it use?</h3>
    <p>JSON columns, ENUM and SET types, FULLTEXT indexes, VECTOR columns for embeddings, views and a department hierarchy for recursive queries.</p>
    <h3>Can I change the data?</h3>
    <p>In the playground the database is read-only, so everyone sees the same data. Use a regular MariaDB version in the playground to practice INSERT, UPDATE and DELETE on your own tables.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install MariaDB to use the University database?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, University is available on MariaDB 11.8."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Which MariaDB features does it use?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "JSON columns, ENUM and SET types, FULLTEXT indexes, VECTOR columns for embeddings, views and a department hierarchy for recursive queries."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Can I change the data?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "In the playground the database is read-only, so everyone sees the same data. Use a regular MariaDB version in the playground to practice INSERT, UPDATE and DELETE on your own tables."{rdelim}{rdelim}
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
