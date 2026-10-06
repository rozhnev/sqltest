{* /zh/database/querynomicon 页面的文本（Controller::database()，外壳 database.tpl）。
   行数和查询结果已在 sqlite3_data 练习场数据库上核对。 *}
<h1>Querynomicon 数据库（SQLite）：企鹅、表和 SQL 练习</h1>
<p class="db-lead">
    Querynomicon 是一个用于从零学习 SQL 的小型 SQLite 数据库：包含帕默企鹅数据集，以及一个有员工、实验和检测板的小型实验室。
    在 SQLtest.online 上，你可以直接在浏览器中查询它：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>13</strong> 张表</li>
    <li><strong>344</strong> 只企鹅</li>
    <li><strong>50</strong> 个实验</li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 Querynomicon 练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 Querynomicon</a>
    {/if}
</div>

<h2>什么是 Querynomicon</h2>
<p>
    这个数据库来自 Greg Wilson 的免费教程 Querynomicon（"An Introduction to SQL for Wary Data Scientists"）。主表是帕默企鹅数据：来自南极洲三个岛屿、三个物种的 344 只企鹅的测量值。
</p>
<p>
    数据量小、易于理解，但具有真实数据的特点：测量值和性别列中存在缺失值（NULL）。因此它非常适合学习筛选、排序、分组、NULL 处理以及 DDL 和 DML 基础。
</p>

{if $ErdImage}
    <h2>ER 图</h2>
    <p>该图展示了 Querynomicon 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Querynomicon 数据库 ER 图">Querynomicon 数据库 ER 图</object>
    </a>
{/if}

<h2>数据库包含什么</h2>
<p>这些表分为两组。</p>
<div class="db-groups">
    <div>
        <h3>企鹅</h3>
        <p>包含全部 344 只企鹅的 <span class="sql">penguins</span>，以及用于快速试验的 10 行样本 <span class="sql">little_penguins</span>。</p>
    </div>
    <div>
        <h3>实验室</h3>
        <p><span class="sql">department</span>、<span class="sql">staff</span>、<span class="sql">experiment</span>、<span class="sql">performed</span>（谁做了哪个实验）、<span class="sql">plate</span> 和 <span class="sql">invalidated</span>，以及 <span class="sql">machine</span>、<span class="sql">usage</span>、<span class="sql">person</span> 和 <span class="sql">contact</span>。</p>
    </div>
</div>
<p>
    企鹅表没有键：每一行就是一只企鹅。实验室的表通过数字标识符关联，<span class="sql">performed</span> 以多对多方式关联员工和实验。
</p>

<p>各表的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">penguins</span></td><td class="num">344</td><td>企鹅及其测量值</td></tr>
        <tr><td><span class="sql">little_penguins</span></td><td class="num">10</td><td>10 只企鹅的样本</td></tr>
        <tr><td><span class="sql">department</span></td><td class="num">4</td><td>部门</td></tr>
        <tr><td><span class="sql">staff</span></td><td class="num">10</td><td>员工</td></tr>
        <tr><td><span class="sql">experiment</span></td><td class="num">50</td><td>实验</td></tr>
        <tr><td><span class="sql">performed</span></td><td class="num">65</td><td>员工 ↔ 实验</td></tr>
        <tr><td><span class="sql">plate</span></td><td class="num">256</td><td>检测板</td></tr>
        <tr><td><span class="sql">invalidated</span></td><td class="num">30</td><td>作废的检测板</td></tr>
        <tr><td><span class="sql">machine</span></td><td class="num">3</td><td>实验室仪器</td></tr>
        <tr><td><span class="sql">person</span></td><td class="num">15</td><td>人员</td></tr>
        <tr><td><span class="sql">usage</span></td><td class="num">8</td><td>仪器使用记录</td></tr>
        <tr><td><span class="sql">contact</span></td><td class="num">8</td><td>联系人</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>{if $PlaygroundLink}这些查询展示了数据之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。{else}这些查询展示了数据之间是如何关联的。{/if}</p>

<p><strong>实验和检测板</strong>：使用 LEFT JOIN 和计数的一对多关系。</p>
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

<p><strong>谁做了实验</strong>：通过 <span class="sql">performed</span> 实现的多对多关系。</p>
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

<h2>按主题分类的 SQL 练习</h2>
<p>
    基于 Querynomicon 数据库共有 {$TasksCount} 道练习，从第一个 SELECT 到视图、索引和触发器。答案会在真实的 SQLite 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>Querynomicon 数据库的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 Querynomicon 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用 Querynomicon 需要安装 SQLite 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中选择 SQLite 3 Preloaded 即可。</p>
    <h3>什么是帕默企鹅？</h3>
    <p>一个很受欢迎的教学数据集：在南极帕默站收集的阿德利企鹅、帽带企鹅和巴布亚企鹅的测量数据。它常被用作鸢尾花数据集的现代替代品。</p>
    <h3>这个数据库适合初学者吗？</h3>
    <p>适合。表很小，主题也无需解释，你可以专注于 SQL 本身：SELECT、WHERE、ORDER BY、GROUP BY 以及 NULL 处理。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用 Querynomicon 需要安装 SQLite 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中选择 SQLite 3 Preloaded 即可。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "什么是帕默企鹅？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "一个很受欢迎的教学数据集：在南极帕默站收集的阿德利企鹅、帽带企鹅和巴布亚企鹅的测量数据。它常被用作鸢尾花数据集的现代替代品。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "这个数据库适合初学者吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "适合。表很小，主题也无需解释，你可以专注于 SQL 本身：SELECT、WHERE、ORDER BY、GROUP BY 以及 NULL 处理。"{rdelim}{rdelim}
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
