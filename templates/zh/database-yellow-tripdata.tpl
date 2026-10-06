{* /zh/database/yellow-tripdata 页面的文本（Controller::database()，外壳 database.tpl）。
   行数和查询结果已在 duckdb_data 练习场数据库上核对。 *}
<h1>纽约黄色出租车数据集（DuckDB）：yellow_tripdata 表和 SQL 练习</h1>
<p class="db-lead">
    yellow_tripdata 收录了 2024 年 1 月纽约黄色出租车的行程，近 300 万行，已导入 DuckDB 用于分析型 SQL。
    在 SQLtest.online 上，你可以直接在浏览器中查询这些数据：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>1</strong> 张表，19 列</li>
    <li><strong>2,964,624</strong> 次行程</li>
    <li><strong>2024 年 1 月</strong> </li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 NYC Yellow Taxi 练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 NYC Yellow Taxi</a>
    {/if}
</div>

<h2>什么是 NYC Yellow Taxi</h2>
<p>
    数据来自纽约市出租车和豪华轿车委员会（TLC）每月发布的行程记录。每一行是一次行程：上下车时间、距离、乘客人数、上下车区域、支付方式以及车费的各个组成部分。
</p>
<p>
    DuckDB 是采用列式存储的嵌入式分析数据库，对数百万行的聚合只需不到一秒。因此这个数据集非常适合练习真正的数据分析：时间序列、分布、百分位数和数据清洗。
</p>

{if $ErdImage}
    <h2>ER 图</h2>
    <p>该图展示了 NYC Yellow Taxi 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="NYC Yellow Taxi 数据库 ER 图">NYC Yellow Taxi 数据库 ER 图</object>
    </a>
{/if}

<h2>数据库包含什么</h2>
<p>
    所有数据都在一张表 <span class="sql">yellow_tripdata</span> 中。所有列都允许 NULL，没有键和约束。<span class="sql">PULocationID</span> 和 <span class="sql">DOLocationID</span> 是 TLC 出租车区域编号。少数行程的上车时间不在 2024 年 1 月内，还有一些金额为零或负数：真实数据需要清洗，部分练习正是关于这一点。
</p>

<p>各表的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">yellow_tripdata</span></td><td class="num">2,964,624</td><td>黄色出租车行程</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>{if $PlaygroundLink}这些查询展示了数据之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。{else}这些查询展示了数据之间是如何关联的。{/if}</p>

<p><strong>行程时长</strong>：用 DuckDB 的 <span class="sql">date_diff</span> 计算上下车之间的时间。</p>
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

<p><strong>快速计数</strong>：DuckDB 的 <span class="sql">GROUP BY ALL</span> 会按所有非聚合列分组。</p>
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

<h2>按主题分类的 SQL 练习</h2>
<p>
    基于这个数据集共有 {$TasksCount} 道练习，从整体统计到时间序列和数据质量检查。答案会在真实的 DuckDB 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>NYC Yellow Taxi 数据库的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 NYC Yellow Taxi 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用这个数据集需要安装 DuckDB 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中选择 DuckDB 即可。</p>
    <h3>数据从哪里来？</h3>
    <p>来自纽约市出租车和豪华轿车委员会（TLC）的开放行程数据，每月以 Parquet 文件发布。这个副本包含 2024 年 1 月的黄色出租车行程。</p>
    <h3>DuckDB 的 SQL 有什么不同？</h3>
    <p>它与 PostgreSQL 接近，并增加了用于分析的功能，例如 <span class="sql">GROUP BY ALL</span>、<span class="sql">QUALIFY</span>、<span class="sql">date_diff</span> 和分位数函数。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用这个数据集需要安装 DuckDB 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中选择 DuckDB 即可。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "数据从哪里来？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "来自纽约市出租车和豪华轿车委员会（TLC）的开放行程数据，每月以 Parquet 文件发布。这个副本包含 2024 年 1 月的黄色出租车行程。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "DuckDB 的 SQL 有什么不同？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "它与 PostgreSQL 接近，并增加了用于分析的功能，例如 GROUP BY ALL、QUALIFY、date_diff 和分位数函数。"{rdelim}{rdelim}
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
