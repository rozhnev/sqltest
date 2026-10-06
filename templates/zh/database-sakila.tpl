{* /zh/database/sakila 页面的文本（Controller::database()，外壳 database.tpl）。
   行数已在 mysql80_sakila 练习场数据库上核对。 *}
<h1>Sakila 数据库：模式、表和 SQL 练习</h1>
<p class="db-lead">
    Sakila 是 MySQL 官方的示例数据库，描述了一家 DVD 影片租赁连锁店的业务。
    在 SQLtest.online 上，你可以直接在浏览器中使用它：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>16</strong> 张表和 7 个视图</li>
    <li><strong>1,000</strong> 部影片</li>
    <li><strong>16,044</strong> 条租赁记录</li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 Sakila 练习</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 Sakila</a>
</div>

<h2>什么是 Sakila</h2>
<p>
    Sakila 由 MySQL 文档团队的 Mike Hillyer 创建，目的是让文档和书籍中的示例使用同一个贴近实际的模式。
    它的名字来自 MySQL 标志上的海豚 Sakila，并以 BSD 许可证发布。
</p>
<p>
    这个数据库模拟了一个常见的业务：包含演员和类型的影片目录、两家门店的顾客和员工、光盘租赁和付款。
    因此它非常适合学习：表之间的关系一看就懂，数据量也足够练习分组、窗口函数和数据分析。
</p>

<h2>ER 图</h2>
<p>该图展示了 Sakila 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
<a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
    {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
    <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Sakila 数据库 ER 图：表及其关系">Sakila 数据库 ER 图</object>
</a>

<h2>数据库包含什么</h2>
<p>Sakila 的表可以分为三组。</p>
<div class="db-groups">
    <div>
        <h3>影片目录</h3>
        <p><span class="sql">film</span>、<span class="sql">actor</span>、<span class="sql">category</span>、<span class="sql">language</span>，以及关联表 <span class="sql">film_actor</span>、<span class="sql">film_category</span>。</p>
    </div>
    <div>
        <h3>门店和人员</h3>
        <p><span class="sql">store</span>、<span class="sql">staff</span>、<span class="sql">customer</span> 和地址：<span class="sql">address</span> → <span class="sql">city</span> → <span class="sql">country</span>。</p>
    </div>
    <div>
        <h3>租赁和付款</h3>
        <p><span class="sql">inventory</span> 是各门店的实体光盘，<span class="sql">rental</span> 是租赁记录，<span class="sql">payment</span> 是付款记录。</p>
    </div>
</div>
<p>
    最需要记住的一点：顾客租的是光盘，而不是影片。因此 <span class="sql">rental</span> 不是直接关联 <span class="sql">film</span>，而是通过 <span class="sql">inventory</span> 关联。
    <span class="sql">film_text</span> 表是标题和描述的辅助副本，用于全文搜索。
</p>

<p>主要表中的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">rental</span></td><td class="num">16,044</td><td>光盘租赁</td></tr>
        <tr><td><span class="sql">payment</span></td><td class="num">16,049</td><td>顾客付款</td></tr>
        <tr><td><span class="sql">film_actor</span></td><td class="num">5,462</td><td>演员在影片中的角色</td></tr>
        <tr><td><span class="sql">inventory</span></td><td class="num">4,581</td><td>门店中的光盘</td></tr>
        <tr><td><span class="sql">film</span></td><td class="num">1,000</td><td>影片</td></tr>
        <tr><td><span class="sql">customer</span></td><td class="num">599</td><td>顾客</td></tr>
        <tr><td><span class="sql">city</span></td><td class="num">600</td><td>城市</td></tr>
        <tr><td><span class="sql">actor</span></td><td class="num">200</td><td>演员</td></tr>
        <tr><td><span class="sql">country</span></td><td class="num">109</td><td>国家</td></tr>
        <tr><td><span class="sql">category</span></td><td class="num">16</td><td>类型</td></tr>
        <tr><td><span class="sql">store</span></td><td class="num">2</td><td>门店</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>这些查询展示了表之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。</p>

<p><strong>影片及其语言</strong>：简单的多对一关系。</p>
<pre><code class="language-sql">SELECT f.title, l.name AS language, f.rental_rate, f.length
FROM film f
JOIN language l ON l.language_id = f.language_id
ORDER BY f.film_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>title</th><th>language</th><th>rental_rate</th><th>length</th></tr>
        <tr><td>ACADEMY DINOSAUR</td><td>English</td><td class="num">0.99</td><td class="num">86</td></tr>
        <tr><td>ACE GOLDFINGER</td><td>English</td><td class="num">4.99</td><td class="num">48</td></tr>
        <tr><td>ADAPTATION HOLES</td><td>English</td><td class="num">2.99</td><td class="num">50</td></tr>
    </table>
</div>

<p><strong>顾客住在哪里</strong>：四张表组成的链条。</p>
<pre><code class="language-sql">SELECT c.first_name, c.last_name, ci.city, co.country
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
ORDER BY c.customer_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>city</th><th>country</th></tr>
        <tr><td>MARY</td><td>SMITH</td><td>Sasebo</td><td>Japan</td></tr>
        <tr><td>PATRICIA</td><td>JOHNSON</td><td>San Bernardino</td><td>United States</td></tr>
        <tr><td>LINDA</td><td>WILLIAMS</td><td>Athenai</td><td>Greece</td></tr>
    </table>
</div>

<p><strong>租了哪部影片、付了多少钱</strong>：从租赁记录经由 <span class="sql">inventory</span> 找到影片。</p>
<pre><code class="language-sql">SELECT r.rental_date, f.title, p.amount
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN payment p ON p.rental_id = r.rental_id
ORDER BY r.rental_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>rental_date</th><th>title</th><th>amount</th></tr>
        <tr><td>2005-05-24 22:53:30</td><td>BLANKET BEVERLY</td><td class="num">2.99</td></tr>
        <tr><td>2005-05-24 22:54:33</td><td>FREAKY POCUS</td><td class="num">2.99</td></tr>
        <tr><td>2005-05-24 23:03:39</td><td>GRADUATE LORD</td><td class="num">3.99</td></tr>
    </table>
</div>

<h2>按主题分类的 SQL 练习</h2>
<p>
    基于 Sakila 数据库共有 {$TasksCount} 道练习，从简单的 SELECT 查询到使用窗口函数的数据分析。答案会在真实的 MySQL 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>"Sakila 数据库"部分的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 Sakila 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用 Sakila 需要安装 MySQL 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，Sakila 可在 MySQL 8.0、MySQL 9.7 和 MariaDB 10 上使用。</p>
    <h3>在哪里下载 Sakila 数据库？</h3>
    <p>官方的 <span class="sql">sakila-schema.sql</span> 和 <span class="sql">sakila-data.sql</span> 文件位于 <a href="https://dev.mysql.com/doc/index-other.html" target="_blank" rel="noopener">MySQL 示例数据库页面</a>，<a href="https://dev.mysql.com/doc/sakila/en/" target="_blank" rel="noopener">Sakila 文档</a>中有详细说明。</p>
    <h3>有适用于 PostgreSQL 的 Sakila 吗？</h3>
    <p>有，它的移植版本叫 Pagila。结构相同，只是部分类型和函数换成了 PostgreSQL 中的对应写法。</p>
    <h3>可以修改 Sakila 中的数据吗？</h3>
    <p>在练习场中数据库是只读的，以保证所有人看到相同的数据。INSERT、UPDATE 和 DELETE 练习会在所需表的临时副本上执行，然后检查该副本的内容。</p>
    <h3>Sakila 适合用来准备 SQL 面试吗？</h3>
    <p>适合。用它可以方便地练习 JOIN、分组、子查询和窗口函数，这些都是技术面试中最常考的内容。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用 Sakila 需要安装 MySQL 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，Sakila 可在 MySQL 8.0、MySQL 9.7 和 MariaDB 10 上使用。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "在哪里下载 Sakila 数据库？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "官方的 sakila-schema.sql 和 sakila-data.sql 文件位于 MySQL 示例数据库页面（dev.mysql.com/doc/index-other.html），Sakila 文档中有详细说明。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "有适用于 PostgreSQL 的 Sakila 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "有，它的移植版本叫 Pagila。结构相同，只是部分类型和函数换成了 PostgreSQL 中的对应写法。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "可以修改 Sakila 中的数据吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "在练习场中数据库是只读的，以保证所有人看到相同的数据。INSERT、UPDATE 和 DELETE 练习会在所需表的临时副本上执行，然后检查该副本的内容。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Sakila 适合用来准备 SQL 面试吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "适合。用它可以方便地练习 JOIN、分组、子查询和窗口函数，这些都是技术面试中最常考的内容。"{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做练习</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">打开练习场</a>
</div>
