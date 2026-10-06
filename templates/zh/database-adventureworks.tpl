{* /zh/database/adventureworks 页面的文本（Controller::database()，外壳 database.tpl）。
   行数和查询结果已在 mssql2022aw 练习场数据库上核对。 *}
<h1>AdventureWorks LT 数据库：模式、表和 SQL 练习</h1>
<p class="db-lead">
    AdventureWorks LT 是 Microsoft SQL Server 的示例数据库，描述一家自行车制造商：客户、产品、产品类别和销售订单。
    在 SQLtest.online 上，你可以直接在浏览器中查询它：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>10</strong> 张主要表</li>
    <li><strong>847</strong> 位客户</li>
    <li><strong>295</strong> 种产品</li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 AdventureWorks 练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 AdventureWorks</a>
    {/if}
</div>

<h2>什么是 AdventureWorks</h2>
<p>
    AdventureWorks 是 Microsoft 为 SQL Server 和 Azure SQL 提供的示例数据库。它描述了一家虚构的公司 Adventure Works Cycles，这家公司生产和销售自行车、零件及配件。
</p>
<p>
    本站使用的是轻量版 AdventureWorks LT：同样的业务只用大约十张表，而不是几十张。它很适合练习 T-SQL，包括 <span class="sql">TOP</span>、类别树上的自连接以及多对多关系。
</p>

{if $ErdImage}
    <h2>ER 图</h2>
    <p>该图展示了 AdventureWorks 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="AdventureWorks 数据库 ER 图">AdventureWorks 数据库 ER 图</object>
    </a>
{/if}

<h2>数据库包含什么</h2>
<p>这些表分为三组。</p>
<div class="db-groups">
    <div>
        <h3>客户</h3>
        <p><span class="sql">Customer</span>、<span class="sql">Address</span> 以及关联表 <span class="sql">CustomerAddress</span>，后者还保存地址类型。</p>
    </div>
    <div>
        <h3>产品</h3>
        <p><span class="sql">Product</span>、<span class="sql">ProductCategory</span>（树形结构：每个类别可以有父类别）、<span class="sql">ProductModel</span> 以及多种语言的描述。</p>
    </div>
    <div>
        <h3>销售</h3>
        <p><span class="sql">SalesOrderHeader</span> 保存订单，<span class="sql">SalesOrderDetail</span> 保存订单明细。</p>
    </div>
</div>
<p>
    这个版本中的 32 个订单日期都是 2008 年 6 月 1 日。产品描述通过 <span class="sql">ProductModelProductDescription</span> 与型号关联，该表还保存每条描述的语言（culture）。服务表 <span class="sql">BuildVersion</span>、<span class="sql">ErrorLog</span> 和 <span class="sql">sysdiagrams</span> 不在练习中使用。
</p>

<p>各表的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">Customer</span></td><td class="num">847</td><td>客户</td></tr>
        <tr><td><span class="sql">CustomerAddress</span></td><td class="num">417</td><td>客户与地址的关联</td></tr>
        <tr><td><span class="sql">Address</span></td><td class="num">450</td><td>地址</td></tr>
        <tr><td><span class="sql">SalesOrderHeader</span></td><td class="num">32</td><td>订单</td></tr>
        <tr><td><span class="sql">SalesOrderDetail</span></td><td class="num">542</td><td>订单明细</td></tr>
        <tr><td><span class="sql">Product</span></td><td class="num">295</td><td>产品</td></tr>
        <tr><td><span class="sql">ProductCategory</span></td><td class="num">41</td><td>产品类别</td></tr>
        <tr><td><span class="sql">ProductModel</span></td><td class="num">128</td><td>产品型号</td></tr>
        <tr><td><span class="sql">ProductDescription</span></td><td class="num">762</td><td>产品描述</td></tr>
        <tr><td><span class="sql">ProductModelProductDescription</span></td><td class="num">762</td><td>按语言的型号与描述关联</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>{if $PlaygroundLink}这些查询展示了数据之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。{else}这些查询展示了数据之间是如何关联的。{/if}</p>

<p><strong>客户及其地址</strong>：通过 <span class="sql">CustomerAddress</span> 实现的多对多关系。</p>
<pre><code class="language-sql">SELECT TOP 3 c.FirstName, c.LastName, ca.AddressType, a.City
FROM Customer c
JOIN CustomerAddress ca ON ca.CustomerID = c.CustomerID
JOIN Address a ON a.AddressID = ca.AddressID
ORDER BY c.CustomerID;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>FirstName</th><th>LastName</th><th>AddressType</th><th>City</th></tr>
        <tr><td>Catherine</td><td>Abel</td><td>Main Office</td><td>Van Nuys</td></tr>
        <tr><td>Kim</td><td>Abercrombie</td><td>Main Office</td><td>Branch</td></tr>
        <tr><td>Frances</td><td>Adams</td><td>Main Office</td><td>Modesto</td></tr>
    </table>
</div>

<p><strong>订单及其明细</strong>：从订单头到产品。</p>
<pre><code class="language-sql">SELECT TOP 3 h.SalesOrderID, h.OrderDate, p.Name, d.OrderQty, d.UnitPrice
FROM SalesOrderHeader h
JOIN SalesOrderDetail d ON d.SalesOrderID = h.SalesOrderID
JOIN Product p ON p.ProductID = d.ProductID
ORDER BY h.SalesOrderID, d.SalesOrderDetailID;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>SalesOrderID</th><th>OrderDate</th><th>Name</th><th>OrderQty</th><th>UnitPrice</th></tr>
        <tr><td class="num">71774</td><td>2008-06-01 00:00:00.000</td><td>ML Road Frame-W - Yellow, 48</td><td class="num">1</td><td class="num">356.8980</td></tr>
        <tr><td class="num">71774</td><td>2008-06-01 00:00:00.000</td><td>ML Road Frame-W - Yellow, 38</td><td class="num">1</td><td class="num">356.8980</td></tr>
        <tr><td class="num">71776</td><td>2008-06-01 00:00:00.000</td><td>Rear Brakes</td><td class="num">1</td><td class="num">63.9000</td></tr>
    </table>
</div>

<h2>按主题分类的 SQL 练习</h2>
<p>
    基于 AdventureWorks 数据库共有 {$TasksCount} 道练习，从简单筛选到订单和产品分析。答案会在真实的 SQL Server 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>AdventureWorks 数据库的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 AdventureWorks 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用 AdventureWorks 需要安装 SQL Server 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，AdventureWorks 可在 SQL Server 2022 上使用。</p>
    <h3>AdventureWorks LT 与完整版 AdventureWorks 有什么区别？</h3>
    <p>完整版数据库在多个模式（Sales、Production、Person 等）中有几十张表。LT 版只保留业务核心——客户、产品和订单——大约十张表，更便于学习。</p>
    <h3>使用哪种 SQL 方言？</h3>
    <p>T-SQL，即 SQL Server 的方言。例如，使用 <span class="sql">TOP</span> 或 <span class="sql">OFFSET … FETCH</span> 代替 <span class="sql">LIMIT</span>。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用 AdventureWorks 需要安装 SQL Server 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中，AdventureWorks 可在 SQL Server 2022 上使用。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "AdventureWorks LT 与完整版 AdventureWorks 有什么区别？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "完整版数据库在多个模式（Sales、Production、Person 等）中有几十张表。LT 版只保留业务核心——客户、产品和订单——大约十张表，更便于学习。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "使用哪种 SQL 方言？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "T-SQL，即 SQL Server 的方言。例如，使用 TOP 或 OFFSET … FETCH 代替 LIMIT。"{rdelim}{rdelim}
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
