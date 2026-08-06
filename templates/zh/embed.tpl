<link rel="stylesheet" type="text/css" href="/embed.css?v={$VERSION}" media="all">

<div class="embed-page">
<div class="docs-wrapper">
    <aside class="docs-sidebar">
        <h4>文档</h4>
        <ul>
            <li><a href="#features">主要特性</a></li>
            <li><a href="#getting-started">开始使用</a></li>
            <li><a href="#configuration">配置属性</a></li>
            <li><a href="#versions">支持的引擎</a></li>
            <li><a href="#use-cases">使用案例</a></li>
            <li><a href="#pricing">定价政策</a></li>
            <li><a href="#reference-examples">示例</a>
                <ul style="padding-left: 20px; font-size: 13px; margin-top: 5px; list-style: none;">
                    <li><a href="#example-mysql">1. MySQL 8.0</a></li>
                    <li><a href="#example-psql">2. PostgreSQL 15</a></li>
                    <li><a href="#example-mariadb">3. MariaDB Vector</a></li>
                    <li><a href="#example-readonly">4. 只读</a></li>
                    <li><a href="#example-result-height">5. 结果高度</a></li>
                    <li><a href="#chaining">6. 查询链</a></li>
                </ul>
            </li>
            <li><a href="#license">许可证</a></li>
        </ul>
    </aside>

    <div class="text-content">
        <h1>SQLize 嵌入文档</h1>
        <p>SQLize 嵌入是一个轻量级、响应式的 SQL 编辑器和执行器，您可以将其嵌入到任何网站中。它允许您的用户直接在浏览器中对各种数据库引擎运行 SQL 查询。</p>

        <h2 id="features"><a href="#features" style="color: inherit; text-decoration: none;">主要特性</a></h2>
<ul>
    <li><strong>多引擎支持</strong>：支持 MySQL (8.0, 9.3)、PostgreSQL (14-18)、MS SQL Server、MariaDB (11.4, 11.8)、SQLite、Oracle、Firebird、ClickHouse 等。</li>
    <li><strong>现成的数据集</strong>：访问预加载的数据库，如 Sakila、UniversityDB 和 Bookings。</li>
    <li><strong>响应式设计</strong>：适用于桌面和移动设备。</li>
    <li><strong>动态初始化</strong>：自动检测通过 AJAX 或无限滚动添加到页面的新编辑器。</li>
    <li><strong>Ace 编辑器支持</strong>：高质量的代码高亮和编辑体验。</li>
</ul>

<hr>

<h2 id="getting-started"><a href="#getting-started" style="color: inherit; text-decoration: none;">开始使用</a></h2>

<h3 id="include-script"><a href="#include-script" style="color: inherit; text-decoration: none;">1. 包含脚本</a></h3>
<p>将以下脚本标签添加到您的网站的 <code>&lt;head&gt;</code> 或关闭的 <code>&lt;/body&gt;</code> 标签之前：</p>

<pre><code>&lt;script src="https://sqlize.online/js/sqlize-embed.js"&gt;&lt;/script&gt;</code></pre>

<h3 id="add-container"><a href="#add-container" style="color: inherit; text-decoration: none;">2. 添加编辑器容器</a></h3>
<p>创建一个带有 <code>data-sqlize-editor</code> 属性的 <code>div</code> 元素。您可以指定数据库版本和编辑器的可见行数。</p>

<pre><code>&lt;div data-sqlize-editor 
 data-sql-version="mysql80" 
 code-rows="10"&gt;
SELECT * FROM sakila.actor LIMIT 5;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="configuration"><a href="#configuration" style="color: inherit; text-decoration: none;">配置属性</a></h2>

<table>
    <thead>
        <tr>
            <th>属性</th>
            <th>描述</th>
            <th>默认</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>data-sqlize-editor</code></td>
            <td>必需的属性，用于将容器标识为编辑器。</td>
            <td>不适用</td>
        </tr>
        <tr>
            <td><code>data-sql-version</code></td>
            <td>要使用的数据库引擎（例如，<code>mysql80</code>、<code>psql17</code>、<code>sqlite3</code>）。</td>
            <td><code>mysql80</code></td>
        </tr>
        <tr>
            <td><code>code-rows</code></td>
            <td>编辑器应显示的固定行数。</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>result-rows</code></td>
            <td>结果块应显示的固定行数。</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>data-read-only</code></td>
            <td>设置为 <code>true</code> 以禁用编辑。</td>
            <td><code>false</code></td>
        </tr>
        <tr>
            <td><code>data-sqlize-id</code></td>
            <td>编辑器容器的唯一标识符。</td>
            <td>不适用</td>
        </tr>
        <tr>
            <td><code>data-sqlize-parent</code></td>
            <td>将代码添加到的父编辑器的 <code>data-sqlize-id</code>。</td>
            <td>不适用</td>
        </tr>
    </tbody>
</table>

<hr>

<h2 id="versions"><a href="#versions" style="color: inherit; text-decoration: none;">支持的数据库版本</a></h2>
<p>在 <code>data-sql-version</code> 属性中使用这些值：</p>

<table>
    <thead>
        <tr>
            <th>值</th>
            <th>数据库引擎</th>
        </tr>
    </thead>
    <tbody>
        <tr><td><code>mysql80</code></td><td>MySQL 8.0</td></tr>
        <tr><td><code>mysql93</code></td><td>MySQL 9.3.0</td></tr>
        <tr><td><code>mysql97_sakila</code></td><td>MySQL 9.7 Sakila（只读）</td></tr>
        <tr><td><code>mariadb123</code></td><td>MariaDB 12.3</td></tr>
        <tr><td><code>mariadb118</code></td><td>MariaDB 11.8</td></tr>
        <tr><td><code>mariadb</code></td><td>MariaDB 10</td></tr>
        <tr><td><code>psql14</code></td><td>PostgreSQL 14</td></tr>
        <tr><td><code>psql15</code></td><td>PostgreSQL 15</td></tr>
        <tr><td><code>psql16</code></td><td>PostgreSQL 16</td></tr>
        <tr><td><code>psql17</code></td><td>PostgreSQL 17 + PostGIS</td></tr>
        <tr><td><code>psql18</code></td><td>PostgreSQL 18</td></tr>
        <tr><td><code>mssql2017</code></td><td>MS SQL Server 2017</td></tr>
        <tr><td><code>mssql2019</code></td><td>MS SQL Server 2019</td></tr>
        <tr><td><code>mssql2022</code></td><td>MS SQL Server 2022</td></tr>
        <tr><td><code>mssql2025</code></td><td>MS SQL Server 2025</td></tr>
        <tr><td><code>sqlite3</code></td><td>SQLite 3</td></tr>
        <tr><td><code>oracle21</code></td><td>Oracle Database 21c</td></tr>
        <tr><td><code>oracle23</code></td><td>Oracle Database 26ai</td></tr>
        <tr><td><code>firebird4</code></td><td>Firebird 4.0</td></tr>
        <tr><td><code>firebird5</code></td><td>Firebird 5.0</td></tr>
        <tr><td><code>clickhouse</code></td><td>ClickHouse</td></tr>
    </tbody>
</table>
<p><em>注意：预加载的数据集如 <code>mysql97_sakila</code>、<code>psql17postgis</code>、<code>mssql2022aw</code>、<code>mysql80_sakila</code>、<code>mariadb118_university</code> 和 <code>psql10demo</code> 也可用。</em></p>

<hr>

<h2 id="use-cases"><a href="#use-cases" style="color: inherit; text-decoration: none;">使用案例</a></h2>

<h3 id="use-case-education"><a href="#use-case-education" style="color: inherit; text-decoration: none;">教育博客与教程</a></h3>
<p>非常适合教授 SQL。提供互动示例，学生可以修改查询并即时查看结果，而无需安装任何软件。</p>

<h3 id="use-case-docs"><a href="#use-case-docs" style="color: inherit; text-decoration: none;">数据库工具文档</a></h3>
<p>在您的文档中包含“立即尝试”部分，以演示数据库引擎的特定功能。</p>

<h3 id="use-case-portfolio"><a href="#use-case-portfolio" style="color: inherit; text-decoration: none;">作品集与技术面试</a></h3>
<p>在您的博客中展示复杂的 SQL 查询，或将其用作技术评估的简单平台。</p>

<hr>

<h2 id="pricing"><a href="#pricing" style="color: inherit; text-decoration: none;">定价政策</a></h2>

<p>SQLize 嵌入以 <strong>按域名收费的订阅方式</strong> 分发。</p>

<table>
    <thead>
        <tr>
            <th>计划</th>
            <th>价格</th>
            <th>包含请求</th>
            <th>额外使用</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>每域名许可证</strong></td>
            <td><strong>$10 / 月</strong></td>
            <td>每月 1,000 次 API 请求</td>
            <td>每超出每月限制的 1,000 次请求 $1</td>
        </tr>
    </tbody>
</table>

<ul>
    <li><strong>每域名许可</strong>：一个订阅覆盖一个顶级域名。每个额外域名需要单独的许可证。</li>
    <li><strong>包含配额</strong>：每月包含 1,000 次 API 请求。</li>
    <li><strong>超额使用</strong>：超出每月限制的额外使用按每 1,000 次请求 $1 收费。</li>
    <li><strong>特殊定价与折扣</strong>：对于高容量或教育使用案例可根据请求提供。</li>
</ul>

<p>要获取您的许可证密钥或请求自定义报价，请通过 <a href="mailto:support@sqlize.com">support@sqlize.com</a> 联系我们。</p>

<hr>

<h2 id="reference-examples"><a href="#reference-examples" style="color: inherit; text-decoration: none;">示例</a></h2>

<h3 id="ref-postgis"><a href="#ref-postgis" style="color: inherit; text-decoration: none;">PostgreSQL 与 PostGIS</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="psql17" code-rows="5"&gt;
SELECT postgis_full_version();
&lt;/div&gt;</code></pre>

<h3 id="ref-sqlite"><a href="#ref-sqlite" style="color: inherit; text-decoration: none;">SQLite（空编辑器）</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="sqlite3"&gt;
-- 在这里输入您的 SQLite 查询
&lt;/div&gt;</code></pre>

<h3 id="ref-readonly"><a href="#ref-readonly" style="color: inherit; text-decoration: none;">只读编辑器</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="mysql80" data-read-only="true"&gt;
-- 此代码无法编辑
SELECT '你可以看到我，但你不能碰我！' as message;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="license"><a href="#license" style="color: inherit; text-decoration: none;">许可证</a></h2>
<p>此脚本使用 <a href="https://ace.c9.io/">Ace 编辑器</a>，其许可证为 BSD 3-Clause License。使用此脚本即表示您同意 SQLize 嵌入服务条款。</p>
    <h1>SQLize.online 嵌入示例</h1>
    
    <p class="description" id="examples">
        此页面演示如何使用 <code>sqlize-embed.js</code> 脚本嵌入交互式 SQL 编辑器。 
        您可以使用 <code>data-sql-version</code> 属性指定数据库版本。
    </p>

    <!-- 示例 1：MySQL 8.0 -->
    <h2 id="example-mysql"><a href="#example-mysql" style="color: inherit; text-decoration: none;">1. MySQL 8.0 示例</a></h2>
    <div data-sqlize-editor data-sql-version="mysql80" code-rows="15">
-- 创建一个示例表
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- 插入一些数据
INSERT INTO users (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

-- 查询数据
SELECT * FROM users;
    </div>

    <!-- 示例 2：PostgreSQL 15 -->
    <h2 id="example-psql"><a href="#example-psql" style="color: inherit; text-decoration: none;">2. PostgreSQL 15 示例</a></h2>
    <div data-sqlize-editor data-sql-version="psql15">
{literal}
SELECT version();

CREATE TABLE products (
    pid serial PRIMARY KEY,
    pname text NOT NULL,
    price numeric CHECK (price > 0)
);

INSERT INTO products (pname, price) VALUES ('SQLize Pro', 19.99);

SELECT * FROM products;
{/literal}
    </div>

    <!-- 示例 3：MariaDB 11.8 Vector -->
    <h2 id="example-mariadb"><a href="#example-mariadb" style="color: inherit; text-decoration: none;">3. MariaDB 11.8 示例与 Vector 类型</a></h2>
    <div data-sqlize-editor data-sql-version="mariadb118" code-rows="16">
{literal}
-- 创建一个带有 Vector 列的表
CREATE TABLE t1 (id INT PRIMARY KEY, v VECTOR(3));

-- 使用 VEC_FromText 插入向量数据
INSERT INTO t1 VALUES 
(1, VEC_FromText('[1,2,3]')), 
(2, VEC_FromText('[4,5,6]')), 
(3, VEC_FromText('[7,8,9]'));

-- 计算欧几里得距离
SELECT 
    id, 
    VEC_ToText(v) as `vector`, 
    VEC_DISTANCE_EUCLIDEAN(v, VEC_FromText('[1,1,1]')) as distance 
FROM t1 
ORDER BY distance;
{/literal}
    </div>

    <!-- 示例 4：只读示例 -->
    <h2 id="example-readonly"><a href="#example-readonly" style="color: inherit; text-decoration: none;">4. 只读示例</a></h2>
    <p>此编辑器设置为 <code>data-read-only="true"</code>，这意味着您可以运行查询但无法修改它。</p>
    <div data-sqlize-editor data-sql-version="mysql80" data-read-only="true" code-rows="5">
-- 此编辑器为只读
SELECT '来自只读编辑器的问候！' AS message, NOW() AS execution_time;
    </div>

    <!-- 示例 5：自