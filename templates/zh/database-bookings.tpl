{* /zh/database/bookings 页面的文本（Controller::database()，外壳 database.tpl）。
   行数和查询结果已在 psql18demo 练习场数据库上核对。 *}
<h1>Bookings 数据库：航空公司模式、表和 SQL 练习</h1>
<p class="db-lead">
    Bookings 是 PostgreSQL 的航空公司演示数据库：包含 104 个机场之间的航班、预订、机票和登机牌。
    在 SQLtest.online 上，你可以直接在浏览器中查询它：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>8</strong> 张表和 4 个视图</li>
    <li><strong>33,121</strong> 个航班</li>
    <li><strong>1,045,726</strong> 条机票航段</li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 Bookings 练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 Bookings</a>
    {/if}
</div>

<h2>什么是 Bookings</h2>
<p>
    Bookings 是 Postgres Professional 公司为学习 PostgreSQL 发布的演示数据库。它模拟一家俄罗斯航空公司的航班：航线、飞机及其座位图、预订、机票和登机牌。
</p>
<p>
    这个副本包含 2017 年 7 月至 9 月的航班。机场和飞机名称以 JSONB 形式存储英文和俄文，机场坐标使用 <span class="sql">point</span> 类型。因此它既适合练习 PostgreSQL 的特有功能，也适合练习 JOIN 和大表上的数据分析。
</p>

{if $ErdImage}
    <h2>ER 图</h2>
    <p>该图展示了 Bookings 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Bookings 数据库 ER 图">Bookings 数据库 ER 图</object>
    </a>
{/if}

<h2>数据库包含什么</h2>
<p>这些表分为两组。</p>
<div class="db-groups">
    <div>
        <h3>参考数据</h3>
        <p><span class="sql">airports_data</span>、<span class="sql">aircrafts_data</span> 和 <span class="sql">seats</span>：每种机型的座位图。</p>
    </div>
    <div>
        <h3>销售和航班</h3>
        <p><span class="sql">bookings</span> → <span class="sql">tickets</span> → <span class="sql">ticket_flights</span> ← <span class="sql">flights</span>，以及值机时发放的 <span class="sql">boarding_passes</span>。</p>
    </div>
</div>
<p>
    最需要记住的一点：一个预订可以包含多名乘客，一张机票可以包含多个航段。机票和航班通过 <span class="sql">ticket_flights</span> 关联，这是最大的一张表。视图 <span class="sql">aircrafts</span>、<span class="sql">airports</span>、<span class="sql">flights_v</span> 和 <span class="sql">routes</span> 以更易读的形式展示相同的数据。
</p>

<p>各表的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">bookings</span></td><td class="num">262,788</td><td>预订</td></tr>
        <tr><td><span class="sql">tickets</span></td><td class="num">366,733</td><td>机票，每位乘客一张</td></tr>
        <tr><td><span class="sql">ticket_flights</span></td><td class="num">1,045,726</td><td>机票包含的航段</td></tr>
        <tr><td><span class="sql">boarding_passes</span></td><td class="num">579,686</td><td>登机牌</td></tr>
        <tr><td><span class="sql">flights</span></td><td class="num">33,121</td><td>计划和已执行的航班</td></tr>
        <tr><td><span class="sql">airports_data</span></td><td class="num">104</td><td>机场</td></tr>
        <tr><td><span class="sql">aircrafts_data</span></td><td class="num">9</td><td>机型</td></tr>
        <tr><td><span class="sql">seats</span></td><td class="num">1,339</td><td>各机型的座位</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>{if $PlaygroundLink}这些查询展示了数据之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。{else}这些查询展示了数据之间是如何关联的。{/if}</p>

<p><strong>机票及其预订</strong>：乘客和预订金额。</p>
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

<p><strong>航班及其飞机</strong>：用 <span class="sql">-&gt;&gt;</span> 从 JSONB 列读取英文名称。</p>
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

<p><strong>票价和座位</strong>：从机票航段到航班和登机牌。LEFT JOIN 会保留没有登机牌的航段。</p>
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

<h2>按主题分类的 SQL 练习</h2>
<p>
    基于 Bookings 数据库共有 {$TasksCount} 道练习，从简单查询到百万行级别的数据分析。答案会在真实的 PostgreSQL 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>Bookings 数据库的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 Bookings 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用 Bookings 需要安装 PostgreSQL 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，Bookings 可在 PostgreSQL 18 上使用。</p>
    <h3>在哪里下载 Bookings 演示数据库？</h3>
    <p>Postgres Professional 在其网站上发布了多种规模的版本，并附有模式说明。</p>
    <h3>为什么有些名称带有花括号？</h3>
    <p>机场、城市和飞机名称是包含英文和俄文值的 JSONB 对象。使用 <span class="sql">-&gt;&gt; 'en'</span> 获取英文文本，或者查询会自动选择语言的视图。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用 Bookings 需要安装 PostgreSQL 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，Bookings 可在 PostgreSQL 18 上使用。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "在哪里下载 Bookings 演示数据库？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Postgres Professional 在其网站上发布了多种规模的版本，并附有模式说明。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "为什么有些名称带有花括号？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "机场、城市和飞机名称是包含英文和俄文值的 JSONB 对象。使用 -&gt;&gt; 'en' 获取英文文本，或者查询会自动选择语言的视图。"{rdelim}{rdelim}
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
