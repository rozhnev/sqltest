{* /zh/database/university 页面的文本（Controller::database()，外壳 database.tpl）。
   行数和查询结果已在 mariadb118_university 练习场数据库上核对。 *}
<h1>University 数据库（MariaDB）：模式、表和 SQL 练习</h1>
<p class="db-lead">
    University 是关于大学的 MariaDB 示例数据库：院系、教师、学生、课程、教学班、选课、成绩和科研。
    在 SQLtest.online 上，你可以直接在浏览器中查询它：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>16</strong> 张表和 7 个视图</li>
    <li><strong>2,000</strong> 名学生</li>
    <li><strong>24,981</strong> 条选课记录</li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 University 练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 University</a>
    {/if}
</div>

<h2>什么是 University</h2>
<p>
    University 是为 MariaDB 11 设计的现代示例数据库，旨在成为经典 Sakila 的更丰富替代品。它规范化到第三范式，并使用了多种 MariaDB 数据类型：JSON、ENUM 和 SET、全文索引以及用于嵌入向量的 VECTOR 列。
</p>
<p>
    数据量足以进行真正的分析：约 2.5 万条选课记录、30 万条成绩记录和超过 50 万行的审计日志。同时，这个主题对上过大学的人来说都很熟悉。
</p>

{if $ErdImage}
    <h2>ER 图</h2>
    <p>该图展示了 University 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="University 数据库 ER 图">University 数据库 ER 图</object>
    </a>
{/if}

<h2>数据库包含什么</h2>
<p>这些表分为三组。</p>
<div class="db-groups">
    <div>
        <h3>人员和组织</h3>
        <p><span class="sql">departments</span>（树形结构）、<span class="sql">faculty</span>、<span class="sql">students</span> 和 <span class="sql">rooms</span>。</p>
    </div>
    <div>
        <h3>教学</h3>
        <p><span class="sql">courses</span> 及 <span class="sql">course_prerequisites</span>、<span class="sql">semesters</span>、<span class="sql">sections</span>、<span class="sql">enrollments</span> 和 <span class="sql">grade_events</span>。</p>
    </div>
    <div>
        <h3>科研和奖学金</h3>
        <p><span class="sql">research_projects</span>、<span class="sql">project_members</span>、<span class="sql">publications</span>、<span class="sql">scholarships</span> 和 <span class="sql">student_scholarships</span>，以及 <span class="sql">audit_log</span>。</p>
    </div>
</div>
<p>
    最需要记住的一点：学生选的不是课程本身，而是教学班——某门课程在某学期的具体开课。因此从学生到课程的路径是 <span class="sql">enrollments</span> → <span class="sql">sections</span> → <span class="sql">courses</span>。七个视图（如 <span class="sql">v_student_gpa</span> 和 <span class="sql">v_course_pass_rate</span>）包含现成的报表。
</p>

<p>各表的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">students</span></td><td class="num">2,000</td><td>学生</td></tr>
        <tr><td><span class="sql">faculty</span></td><td class="num">250</td><td>教师</td></tr>
        <tr><td><span class="sql">departments</span></td><td class="num">25</td><td>院系</td></tr>
        <tr><td><span class="sql">courses</span></td><td class="num">116</td><td>课程</td></tr>
        <tr><td><span class="sql">course_prerequisites</span></td><td class="num">49</td><td>先修课程</td></tr>
        <tr><td><span class="sql">semesters</span></td><td class="num">20</td><td>学期</td></tr>
        <tr><td><span class="sql">sections</span></td><td class="num">1,715</td><td>某学期的教学班</td></tr>
        <tr><td><span class="sql">rooms</span></td><td class="num">48</td><td>教室</td></tr>
        <tr><td><span class="sql">enrollments</span></td><td class="num">24,981</td><td>选课记录</td></tr>
        <tr><td><span class="sql">grade_events</span></td><td class="num">307,081</td><td>作业和考试成绩</td></tr>
        <tr><td><span class="sql">research_projects</span></td><td class="num">200</td><td>科研项目</td></tr>
        <tr><td><span class="sql">project_members</span></td><td class="num">876</td><td>项目成员</td></tr>
        <tr><td><span class="sql">publications</span></td><td class="num">500</td><td>论文</td></tr>
        <tr><td><span class="sql">scholarships</span></td><td class="num">20</td><td>奖学金</td></tr>
        <tr><td><span class="sql">student_scholarships</span></td><td class="num">773</td><td>学生获得的奖学金</td></tr>
        <tr><td><span class="sql">audit_log</span></td><td class="num">664,124</td><td>变更日志</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>{if $PlaygroundLink}这些查询展示了数据之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。{else}这些查询展示了数据之间是如何关联的。{/if}</p>

<p><strong>学生、课程和成绩</strong>：从选课记录经由教学班到课程和学期。</p>
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

<p><strong>JSON 中的答疑时间</strong>：用 <span class="sql">JSON_VALUE</span> 从 JSON 列中读取值。</p>
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

<h2>按主题分类的 SQL 练习</h2>
<p>
    目前基于 University 数据库共有 {$TasksCount} 道练习，更多练习正在添加中。答案会在真实的 MariaDB 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>University 数据库的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 University 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用 University 需要安装 MariaDB 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，University 可在 MariaDB 11.8 上使用。</p>
    <h3>它使用了 MariaDB 的哪些功能？</h3>
    <p>JSON 列、ENUM 和 SET 类型、全文索引、用于嵌入向量的 VECTOR 列、视图，以及可用于递归查询的院系层级。</p>
    <h3>可以修改数据吗？</h3>
    <p>在练习场中数据库是只读的，以保证所有人看到相同的数据。如果想在自己的表上练习 INSERT、UPDATE 和 DELETE，请在练习场中选择普通的 MariaDB 版本。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用 University 需要安装 MariaDB 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，University 可在 MariaDB 11.8 上使用。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "它使用了 MariaDB 的哪些功能？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "JSON 列、ENUM 和 SET 类型、全文索引、用于嵌入向量的 VECTOR 列、视图，以及可用于递归查询的院系层级。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "可以修改数据吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "在练习场中数据库是只读的，以保证所有人看到相同的数据。如果想在自己的表上练习 INSERT、UPDATE 和 DELETE，请在练习场中选择普通的 MariaDB 版本。"{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">打开练习场</a>
    {/if}
</div>
