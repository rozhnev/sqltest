{* /zh/database/countries 页面的文本（Controller::database()，外壳 database.tpl）。
   行数和查询结果已在 psql17postgis 练习场数据库上核对。 *}
<h1>Countries 数据库（PostGIS）：空间表和 SQL 练习</h1>
<p class="db-lead">
    Countries 是用于学习空间 SQL 的 PostGIS 数据库：包含世界各国及首都，以及纽约市的人口普查街区、街区、街道和地铁站图层。
    在 SQLtest.online 上，你可以直接在浏览器中查询它：做自动判题的练习，或在练习场中运行自己的查询，无需安装任何软件。
</p>

<ul class="db-stats">
    <li><strong>7</strong> 张空间表</li>
    <li><strong>246</strong> 个国家</li>
    <li><strong>491</strong> 个地铁站</li>
    <li><strong>{$TasksCount}</strong> 道 SQL 练习</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">开始做 Countries 练习</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">在练习场中打开 Countries</a>
    {/if}
</div>

<h2>什么是 Countries</h2>
<p>
    PostGIS 是 PostgreSQL 的扩展，增加了几何类型和数百个空间函数：距离、面积、相交、坐标转换等。这个数据库让你可以在熟悉的数据上试用它们。
</p>
<p>
    纽约市的表来自著名的 PostGIS 教程 "Introduction to PostGIS"，世界数据表包含各国边界和首都。它们共同涵盖了两种坐标系中的点、线和多边形。
</p>

{if $ErdImage}
    <h2>ER 图</h2>
    <p>该图展示了 Countries 的表以及它们之间的外键关系。点击可查看完整尺寸。</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Countries 数据库 ER 图">Countries 数据库 ER 图</object>
    </a>
{/if}

<h2>数据库包含什么</h2>
<p>这些表分为两组。</p>
<div class="db-groups">
    <div>
        <h3>世界</h3>
        <p>带边界多边形的 <span class="sql">countries</span> 和带点坐标的 <span class="sql">capitals</span>，均为 SRID 4326（经度和纬度）。</p>
    </div>
    <div>
        <h3>纽约市</h3>
        <p><span class="sql">nyc_census_blocks</span>、<span class="sql">nyc_neighborhoods</span>、<span class="sql">nyc_streets</span>、<span class="sql">nyc_subway_stations</span> 和 <span class="sql">nyc_homicides</span>，SRID 为 26918（UTM 18N 区，单位为米）。</p>
    </div>
</div>
<p>
    最需要记住的一点：世界数据表存储的是度，纽约数据表存储的是米。纽约图层中的距离和面积直接以米为单位；对于世界数据表，需要先转换为 <span class="sql">geography</span> 或对几何进行投影变换。
</p>

<p>各表的数据量：</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>表</th><th>行数</th><th>内容</th></tr>
        <tr><td><span class="sql">countries</span></td><td class="num">246</td><td>国家及其边界</td></tr>
        <tr><td><span class="sql">capitals</span></td><td class="num">192</td><td>首都</td></tr>
        <tr><td><span class="sql">nyc_census_blocks</span></td><td class="num">38,794</td><td>带人口数据的普查街区</td></tr>
        <tr><td><span class="sql">nyc_neighborhoods</span></td><td class="num">129</td><td>街区</td></tr>
        <tr><td><span class="sql">nyc_streets</span></td><td class="num">19,091</td><td>街道</td></tr>
        <tr><td><span class="sql">nyc_subway_stations</span></td><td class="num">491</td><td>地铁站</td></tr>
        <tr><td><span class="sql">nyc_homicides</span></td><td class="num">3,982</td><td>凶杀案</td></tr>
    </table>
</div>

<h2>表结构</h2>
<p>点击表名可查看它的列、示例行和键。</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>示例查询</h2>
<p>{if $PlaygroundLink}这些查询展示了数据之间是如何关联的。复制任意一条，在<a href="{$PlaygroundLink}">练习场</a>中运行即可。{else}这些查询展示了数据之间是如何关联的。{/if}</p>

<p><strong>首都位于本国境内</strong>：用 <span class="sql">ST_X</span> / <span class="sql">ST_Y</span> 获取点坐标，并用 <span class="sql">ST_Contains</span> 做空间判断。</p>
<pre><code class="language-sql">SELECT c.name AS capital, co.name AS country,
       round(ST_Y(c.location)::numeric, 2) AS lat,
       round(ST_X(c.location)::numeric, 2) AS lon,
       ST_Contains(co.border, c.location) AS inside_border
FROM capitals c
JOIN countries co ON co.id = c.country_id
ORDER BY c.name
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>capital</th><th>country</th><th>lat</th><th>lon</th><th>inside_border</th></tr>
        <tr><td>Abu Dhabi</td><td>United Arab Emirates</td><td class="num">24.30</td><td class="num">54.70</td><td>true</td></tr>
        <tr><td>Abuja</td><td>Nigeria</td><td class="num">9.08</td><td class="num">7.40</td><td>true</td></tr>
        <tr><td>Accra</td><td>Ghana</td><td class="num">5.60</td><td class="num">-0.19</td><td>true</td></tr>
    </table>
</div>

<p><strong>地铁站及其 SRID</strong>：纽约图层使用投影坐标系 26918。</p>
<pre><code class="language-sql">SELECT s.name AS station, s.borough, s.routes, ST_SRID(s.geom) AS srid
FROM nyc_subway_stations s
ORDER BY s.gid
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>station</th><th>borough</th><th>routes</th><th>srid</th></tr>
        <tr><td>Cortlandt St</td><td>Manhattan</td><td>R,W</td><td class="num">26918</td></tr>
        <tr><td>Rector St</td><td>Manhattan</td><td class="num">1</td><td class="num">26918</td></tr>
        <tr><td>South Ferry</td><td>Manhattan</td><td class="num">1</td><td class="num">26918</td></tr>
    </table>
</div>

<h2>按主题分类的 SQL 练习</h2>
<p>
    这个数据库上共有 {$TasksCount} 道 PostGIS 练习：距离、面积、长度、转换为文本和 JSON 以及空间连接。答案会在带 PostGIS 的真实 PostgreSQL 上自动检查。
    右侧数字是该主题的练习数量，彩色圆点表示难度范围。
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>从哪里开始</h2>
    <p>Countries 数据库的前几道练习：</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">全部 Countries 练习 →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>常见问题</h2>
    <h3>使用这个数据库需要安装 PostGIS 吗？</h3>
    <p>不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中选择 PostgreSQL 17 + PostGIS WorkShop 即可。</p>
    <h3>什么是 SRID？</h3>
    <p>空间参考标识符：它说明坐标使用的是哪种坐标系。4326 表示以度为单位的经纬度（WGS 84）；26918 表示以米为单位的 UTM 18N 区，用于纽约。</p>
    <h3>纽约的表来自哪里？</h3>
    <p>来自 postgis.net 上发布的 "Introduction to PostGIS" 教程数据集，这是学习 PostGIS 的常见起点。</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "使用这个数据库需要安装 PostGIS 吗？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "不需要。SQLtest.online 的练习和练习场都在我们的服务器上执行查询，有浏览器就够了。在练习场中选择 PostgreSQL 17 + PostGIS WorkShop 即可。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "什么是 SRID？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "空间参考标识符：它说明坐标使用的是哪种坐标系。4326 表示以度为单位的经纬度（WGS 84）；26918 表示以米为单位的 UTM 18N 区，用于纽约。"{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "纽约的表来自哪里？", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "来自 postgis.net 上发布的 \"Introduction to PostGIS\" 教程数据集，这是学习 PostGIS 的常见起点。"{rdelim}{rdelim}
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
