{* /zh/database/employee 页面的文本（Controller::database()，外壳 database.tpl）。
   行数和查询结果已在 firebird4_employee 练习场数据库上核对。 *}
<h1>Employee 数据库（Firebird）：模式、表和 SQL 练习</h1>
<p class="db-lead">
    Employee 是 Firebird 自带的示例数据库：一家小公司的员工、部门、职位、项目、客户和销售。
    在 SQLtest.online 上，你可以直接在浏览器中查询它：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>10</strong> 张表和 1 个视图</li>
    <li><strong>42</strong> 名员工</li>
    <li><strong>21</strong> 个部门</li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 Employee 练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 Employee</a>
    {/if}
</div>

<h2>什么是 Employee</h2>
<p>
    Employee 是 Firebird 的经典示例数据库，源自 InterBase。它描述一家小型跨国公司：部门树、员工和薪资历史、带预算的项目以及面向客户的销售。
</p>
<p>
    数据库规模不大，结果很容易用肉眼核对，但其中的关系很有意思：部门层级、员工到职位的复合外键，以及员工与项目之间的多对多关系。它也是练习 Firebird SQL 方言的好地方。
</p>

{if $ErdImage}
    <h2>ER 图</h2>
    <p>该图展示了 Employee 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Employee 数据库 ER 图">Employee 数据库 ER 图</object>
    </a>
{/if}

<h2>数据库包含什么</h2>
<p>这些表分为三组。</p>
<div class="db-groups">
    <div>
        <h3>人员</h3>
        <p><span class="sql">EMPLOYEE</span>、<span class="sql">DEPARTMENT</span>（每个部门都有上级部门）、<span class="sql">JOB</span> 和 <span class="sql">SALARY_HISTORY</span>。</p>
    </div>
    <div>
        <h3>项目</h3>
        <p><span class="sql">PROJECT</span>、关联表 <span class="sql">EMPLOYEE_PROJECT</span> 以及 <span class="sql">PROJ_DEPT_BUDGET</span> 中的年度预算。</p>
    </div>
    <div>
        <h3>销售</h3>
        <p><span class="sql">CUSTOMER</span>、<span class="sql">SALES</span>（采购订单）和包含货币信息的 <span class="sql">COUNTRY</span>。</p>
    </div>
</div>
<p>
    最需要记住的一点：职位由三列共同确定（代码、级别和国家），因此 <span class="sql">EMPLOYEE</span> 与 <span class="sql">JOB</span> 的连接需要这三列。视图 <span class="sql">PHONE_LIST</span> 把员工和所在部门的电话合并在一起。
</p>

<p>各表的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">EMPLOYEE</span></td><td class="num">42</td><td>员工</td></tr>
        <tr><td><span class="sql">DEPARTMENT</span></td><td class="num">21</td><td>部门</td></tr>
        <tr><td><span class="sql">JOB</span></td><td class="num">31</td><td>职位和薪资范围</td></tr>
        <tr><td><span class="sql">SALARY_HISTORY</span></td><td class="num">49</td><td>薪资变动</td></tr>
        <tr><td><span class="sql">PROJECT</span></td><td class="num">6</td><td>项目</td></tr>
        <tr><td><span class="sql">EMPLOYEE_PROJECT</span></td><td class="num">28</td><td>员工 ↔ 项目</td></tr>
        <tr><td><span class="sql">PROJ_DEPT_BUDGET</span></td><td class="num">24</td><td>按部门和年份的项目预算</td></tr>
        <tr><td><span class="sql">CUSTOMER</span></td><td class="num">15</td><td>客户</td></tr>
        <tr><td><span class="sql">SALES</span></td><td class="num">33</td><td>采购订单</td></tr>
        <tr><td><span class="sql">COUNTRY</span></td><td class="num">16</td><td>国家和货币</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>{if $PlaygroundLink}这些查询展示了数据之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。{else}这些查询展示了数据之间是如何关联的。{/if}</p>

<p><strong>员工、部门和职位</strong>：基于三列复合键的连接。</p>
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

<p><strong>订单和客户</strong>：Firebird 使用 <span class="sql">FIRST n</span> 限制行数。</p>
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

<h2>按主题分类的 SQL 练习</h2>
<p>
    基于 Employee 数据库共有 {$TasksCount} 道练习，从简单查询到窗口函数和数据修改。答案会在真实的 Firebird 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>Employee 数据库的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 Employee 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用 Employee 需要安装 Firebird 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，Employee 可在 Firebird 4.0 上使用。</p>
    <h3>Employee 数据库从何而来？</h3>
    <p>它作为示例数据库（employee.fdb）随 Firebird 一起发布，最早可追溯到 Firebird 的前身 InterBase。</p>
    <h3>Firebird 的 SQL 有什么不同？</h3>
    <p>大部分标准 SQL 都能照常使用。最先会遇到的差异是：用 <span class="sql">FIRST n</span> / <span class="sql">SKIP n</span> 或 <span class="sql">FETCH FIRST n ROWS ONLY</span> 限制行数，以及对象名称为大写。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用 Employee 需要安装 Firebird 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，Employee 可在 Firebird 4.0 上使用。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Employee 数据库从何而来？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "它作为示例数据库（employee.fdb）随 Firebird 一起发布，最早可追溯到 Firebird 的前身 InterBase。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Firebird 的 SQL 有什么不同？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "大部分标准 SQL 都能照常使用。最先会遇到的差异是：用 FIRST n / SKIP n 或 FETCH FIRST n ROWS ONLY 限制行数，以及对象名称为大写。"{rdelim}{rdelim}
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
