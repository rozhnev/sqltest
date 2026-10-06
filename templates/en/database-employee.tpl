{* Text of the /en/database/employee landing page (Controller::database(), shell database.tpl).
   Row counts and query results checked on the firebird4_employee playground database. *}
<h1>Employee database (Firebird): schema, tables and SQL exercises</h1>
<p class="db-lead">
    Employee is the sample database that comes with Firebird: employees, departments, jobs, projects, customers and sales of a small company.
    On SQLtest.online you can query it right in your browser: solve exercises with automatic checking and run your own queries in the playground, with nothing to install.
</p>

<ul class="db-stats">
    <li><strong>10</strong> tables and 1 view</li>
    <li><strong>42</strong> employees</li>
    <li><strong>21</strong> departments</li>
    <li><strong>{$TasksCount}</strong> SQL exercises</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Solve Employee exercises</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Open Employee in the playground</a>
    {/if}
</div>

<h2>What is Employee</h2>
<p>
    Employee is the classic example database of Firebird, inherited from InterBase. It describes a small international company: its department tree, staff and salary history, projects with budgets, and sales to customers.
</p>
<p>
    The database is small, so results are easy to check by eye, but it has interesting relationships: a department hierarchy, a composite foreign key from employees to jobs and many-to-many links between employees and projects. It is also the place to practice the Firebird SQL dialect.
</p>

{if $ErdImage}
    <h2>ER diagram</h2>
    <p>The diagram shows the Employee tables and the foreign keys between them. Click it to open the full-size version.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER diagram of the Employee database">ER diagram of the Employee database</object>
    </a>
{/if}

<h2>What's inside</h2>
<p>The tables fall into three groups.</p>
<div class="db-groups">
    <div>
        <h3>Staff</h3>
        <p><span class="sql">EMPLOYEE</span>, <span class="sql">DEPARTMENT</span> (each department has a parent), <span class="sql">JOB</span> and <span class="sql">SALARY_HISTORY</span>.</p>
    </div>
    <div>
        <h3>Projects</h3>
        <p><span class="sql">PROJECT</span>, the link table <span class="sql">EMPLOYEE_PROJECT</span> and the yearly budgets in <span class="sql">PROJ_DEPT_BUDGET</span>.</p>
    </div>
    <div>
        <h3>Sales</h3>
        <p><span class="sql">CUSTOMER</span>, <span class="sql">SALES</span> (purchase orders) and <span class="sql">COUNTRY</span> with currencies.</p>
    </div>
</div>
<p>
    The key thing to remember: a job is identified by three columns at once (code, grade and country), so joining <span class="sql">EMPLOYEE</span> to <span class="sql">JOB</span> needs all three. The view <span class="sql">PHONE_LIST</span> combines employees with their department phone numbers.
</p>

<p>How much data the tables hold:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Rows</th><th>Contents</th></tr>
        <tr><td><span class="sql">EMPLOYEE</span></td><td class="num">42</td><td>employees</td></tr>
        <tr><td><span class="sql">DEPARTMENT</span></td><td class="num">21</td><td>departments</td></tr>
        <tr><td><span class="sql">JOB</span></td><td class="num">31</td><td>jobs and salary ranges</td></tr>
        <tr><td><span class="sql">SALARY_HISTORY</span></td><td class="num">49</td><td>salary changes</td></tr>
        <tr><td><span class="sql">PROJECT</span></td><td class="num">6</td><td>projects</td></tr>
        <tr><td><span class="sql">EMPLOYEE_PROJECT</span></td><td class="num">28</td><td>employees ↔ projects</td></tr>
        <tr><td><span class="sql">PROJ_DEPT_BUDGET</span></td><td class="num">24</td><td>project budgets by department and year</td></tr>
        <tr><td><span class="sql">CUSTOMER</span></td><td class="num">15</td><td>customers</td></tr>
        <tr><td><span class="sql">SALES</span></td><td class="num">33</td><td>purchase orders</td></tr>
        <tr><td><span class="sql">COUNTRY</span></td><td class="num">16</td><td>countries and currencies</td></tr>
    </table>
</div>

<h2>Table structure</h2>
<p>Click a table to see its columns, a sample row and its keys.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Sample queries</h2>
<p>{if $PlaygroundLink}These queries show how the data is connected. Copy any of them and run it in the <a href="{$PlaygroundLink}">playground</a>.{else}These queries show how the data is connected.{/if}</p>

<p><strong>An employee, department and job</strong>: a join on a composite key of three columns.</p>
<pre><code class="language-sql">SELECT FIRST 3 e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT, j.JOB_TITLE
FROM EMPLOYEE e
JOIN DEPARTMENT d ON d.DEPT_NO = e.DEPT_NO
JOIN JOB j ON j.JOB_CODE = e.JOB_CODE
          AND j.JOB_GRADE = e.JOB_GRADE
          AND j.JOB_COUNTRY = e.JOB_COUNTRY
ORDER BY e.EMP_NO;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>FIRST_NAME</th><th>LAST_NAME</th><th>DEPARTMENT</th><th>JOB_TITLE</th></tr>
        <tr><td>Robert</td><td>Nelson</td><td>Engineering</td><td>Vice President</td></tr>
        <tr><td>Bruce</td><td>Young</td><td>Software Development</td><td>Engineer</td></tr>
        <tr><td>Kim</td><td>Lambert</td><td>Field Office: East Coast</td><td>Engineer</td></tr>
    </table>
</div>

<p><strong>Orders and customers</strong>: Firebird uses <span class="sql">FIRST n</span> to limit rows.</p>
<pre><code class="language-sql">SELECT FIRST 3 s.PO_NUMBER, c.CUSTOMER, s.ORDER_DATE, s.TOTAL_VALUE
FROM SALES s
JOIN CUSTOMER c ON c.CUST_NO = s.CUST_NO
ORDER BY s.ORDER_DATE;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>PO_NUMBER</th><th>CUSTOMER</th><th>ORDER_DATE</th><th>TOTAL_VALUE</th></tr>
        <tr><td>V91E0210</td><td>Central Bank</td><td>1991-03-04 00:00:00</td><td class="num">5000.00</td></tr>
        <tr><td>V92J1003</td><td>MPM Corporation</td><td>1992-07-26 00:00:00</td><td class="num">2985.00</td></tr>
        <tr><td>V92E0340</td><td>Central Bank</td><td>1992-10-15 00:00:00</td><td class="num">70000.00</td></tr>
    </table>
</div>

<h2>SQL exercises by topic</h2>
<p>
    There are {$TasksCount} exercises on the Employee database, from simple selections to window functions and data changes. Solutions are checked automatically on a real Firebird server.
    The number on the right is how many exercises a topic has; the colored dots show its difficulty range.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Where to start</h2>
    <p>The first exercises on the Employee database:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">All Employee exercises →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>FAQ</h2>
    <h3>Do I need to install Firebird to use the Employee database?</h3>
    <p>No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, Employee is available on Firebird 4.0.</p>
    <h3>Where does the Employee database come from?</h3>
    <p>It ships with Firebird as an example database (employee.fdb) and dates back to InterBase, the predecessor of Firebird.</p>
    <h3>How is Firebird SQL different?</h3>
    <p>Most of standard SQL works as usual. Differences you will meet first: <span class="sql">FIRST n</span> / <span class="sql">SKIP n</span> or <span class="sql">FETCH FIRST n ROWS ONLY</span> to limit rows, and uppercase object names.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Do I need to install Firebird to use the Employee database?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. The exercises and the playground on SQLtest.online run your queries on our servers, so a browser is all you need. In the playground, Employee is available on Firebird 4.0."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Where does the Employee database come from?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "It ships with Firebird as an example database (employee.fdb) and dates back to InterBase, the predecessor of Firebird."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "How is Firebird SQL different?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Most of standard SQL works as usual. Differences you will meet first: FIRST n / SKIP n or FETCH FIRST n ROWS ONLY to limit rows, and uppercase object names."{rdelim}{rdelim}
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
