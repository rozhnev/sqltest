<link rel="stylesheet" type="text/css" href="/embed.css?v={$VERSION}" media="all">

<div class="embed-page">
<div class="docs-wrapper">
    <aside class="docs-sidebar">
        <h4>Documentation</h4>
        <ul>
            <li><a href="#features">Key Features</a></li>
            <li><a href="#getting-started">Getting Started</a></li>
            <li><a href="#configuration">Configuration Attributes</a></li>
            <li><a href="#versions">Supported Engines</a></li>
            <li><a href="#use-cases">Use Cases</a></li>
            <li><a href="#pricing">Pricing Policy</a></li>
            <li><a href="#reference-examples">Examples</a>
                <ul style="padding-left: 20px; font-size: 13px; margin-top: 5px; list-style: none;">
                    <li><a href="#example-mysql">1. MySQL 8.0</a></li>
                    <li><a href="#example-psql">2. PostgreSQL 15</a></li>
                    <li><a href="#example-mariadb">3. MariaDB Vector</a></li>
                    <li><a href="#example-readonly">4. Read-Only</a></li>
                    <li><a href="#example-result-height">5. Result Height</a></li>
                    <li><a href="#chaining">6. Query Chaining</a></li>
                </ul>
            </li>
            <li><a href="#license">License</a></li>
        </ul>
    </aside>

    <div class="text-content">
        <h1>SQLize Embed Documentation</h1>
        <p>SQLize Embed is a lightweight, responsive SQL editor and executor that you can embed into any website. It allows your users to run SQL queries against various database engines directly in their browser.</p>

        <h2 id="features"><a href="#features" style="color: inherit; text-decoration: none;">Key Features</a></h2>
<ul>
    <li><strong>Multi-Engine Support</strong>: Supports MySQL (8.0, 9.3), PostgreSQL (14-18), MS SQL Server, MariaDB (11.4, 11.8), SQLite, Oracle, Firebird, ClickHouse, and more.</li>
    <li><strong>Ready-to-Use Datasets</strong>: Access preloaded databases like Sakila, UniversityDB, and Bookings.</li>
    <li><strong>Responsive Design</strong>: Works on desktops and mobile devices.</li>
    <li><strong>Dynamic Initialization</strong>: Automatically detects new editors added to the page via AJAX or infinite scroll.</li>
    <li><strong>Ace Editor Powered</strong>: High-quality code highlighting and editing experience.</li>
</ul>

<hr>

<h2 id="getting-started"><a href="#getting-started" style="color: inherit; text-decoration: none;">Getting Started</a></h2>

<h3 id="include-script"><a href="#include-script" style="color: inherit; text-decoration: none;">1. Include the Script</a></h3>
<p>Add the following script tag to the <code>&lt;head&gt;</code> or before the closing <code>&lt;/body&gt;</code> tag of your website:</p>

<pre><code>&lt;script src="https://sqlize.online/js/sqlize-embed.js"&gt;&lt;/script&gt;</code></pre>

<h3 id="add-container"><a href="#add-container" style="color: inherit; text-decoration: none;">2. Add an Editor Container</a></h3>
<p>Create a <code>div</code> element with the <code>data-sqlize-editor</code> attribute. You can specify the database version and the number of visible rows for the editor.</p>

<pre><code>&lt;div data-sqlize-editor 
 data-sql-version="mysql80" 
 code-rows="10"&gt;
SELECT * FROM sakila.actor LIMIT 5;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="configuration"><a href="#configuration" style="color: inherit; text-decoration: none;">Configuration Attributes</a></h2>

<table>
    <thead>
        <tr>
            <th>Attribute</th>
            <th>Description</th>
            <th>Default</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>data-sqlize-editor</code></td>
            <td>Required attribute to identify the container as an editor.</td>
            <td>N/A</td>
        </tr>
        <tr>
            <td><code>data-sql-version</code></td>
            <td>The database engine to use (e.g., <code>mysql80</code>, <code>psql17</code>, <code>sqlite3</code>).</td>
            <td><code>mysql80</code></td>
        </tr>
        <tr>
            <td><code>code-rows</code></td>
            <td>The fixed number of lines the editor should display.</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>result-rows</code></td>
            <td>The fixed number of lines the result block should display.</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>data-read-only</code></td>
            <td>Set to <code>true</code> to disable editing.</td>
            <td><code>false</code></td>
        </tr>
        <tr>
            <td><code>data-sqlize-id</code></td>
            <td>Unique identifier for the editor container.</td>
            <td>N/A</td>
        </tr>
        <tr>
            <td><code>data-sqlize-parent</code></td>
            <td>The <code>data-sqlize-id</code> of the parent editor whose code will be prepended.</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

<hr>

<h2 id="versions"><a href="#versions" style="color: inherit; text-decoration: none;">Supported Database Versions</a></h2>
<p>Use these values in the <code>data-sql-version</code> attribute:</p>

<table>
    <thead>
        <tr>
            <th>Value</th>
            <th>Database Engine</th>
        </tr>
    </thead>
    <tbody>
        <tr><td><code>mysql80</code></td><td>MySQL 8.0</td></tr>
        <tr><td><code>mysql93</code></td><td>MySQL 9.3.0</td></tr>
        <tr><td><code>mysql97_sakila</code></td><td>MySQL 9.7 Sakila (ReadOnly)</td></tr>
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
<p><em>Note: Preloaded datasets like <code>mysql97_sakila</code>, <code>psql17postgis</code>, <code>mssql2022aw</code>, <code>mysql80_sakila</code>, <code>mariadb118_university</code>, and <code>psql10demo</code> are also available.</em></p>

<hr>

<h2 id="use-cases"><a href="#use-cases" style="color: inherit; text-decoration: none;">Use Cases</a></h2>

<h3 id="use-case-education"><a href="#use-case-education" style="color: inherit; text-decoration: none;">Educational Blogs &amp; Tutorials</a></h3>
<p>Perfect for teaching SQL. Provide interactive examples where students can modify queries and see results instantly without installing any software.</p>

<h3 id="use-case-docs"><a href="#use-case-docs" style="color: inherit; text-decoration: none;">Documentation for Database Tools</a></h3>
<p>Include "Try it now" sections in your documentation to demonstrate specific features of a database engine.</p>

<h3 id="use-case-portfolio"><a href="#use-case-portfolio" style="color: inherit; text-decoration: none;">Portfolio &amp; Technical Interviewing</a></h3>
<p>Showcase complex SQL queries in your blog or use it as a simple platform for technical assessments.</p>

<hr>

<h2 id="pricing"><a href="#pricing" style="color: inherit; text-decoration: none;">Pricing Policy</a></h2>

<p>SQLize Embed is distributed on a <strong>paid subscription basis</strong> per domain.</p>

<table>
    <thead>
        <tr>
            <th>Plan</th>
            <th>Price</th>
            <th>Included requests</th>
            <th>Extra usage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Per-Domain License</strong></td>
            <td><strong>$10 / month</strong></td>
            <td>1,000 API requests / month</td>
            <td>$1 per 1,000 requests over the monthly limit</td>
        </tr>
    </tbody>
</table>

<ul>
    <li><strong>Per-Domain Licensing</strong>: One subscription covers one top-level domain. Each additional domain requires a separate license.</li>
    <li><strong>Included quota</strong>: 1,000 API requests per month are included in the base price.</li>
    <li><strong>Overage</strong>: Additional usage beyond the monthly limit is billed at $1 per 1,000 requests.</li>
    <li><strong>Special pricing &amp; discounts</strong>: Available on request for high-volume or educational use cases.</li>
</ul>

<p>To obtain your license key or request a custom quote, contact us at <a href="mailto:support@sqlize.com">support@sqlize.com</a>.</p>

<hr>

<h2 id="reference-examples"><a href="#reference-examples" style="color: inherit; text-decoration: none;">Examples</a></h2>

<h3 id="ref-postgis"><a href="#ref-postgis" style="color: inherit; text-decoration: none;">PostgreSQL with PostGIS</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="psql17" code-rows="5"&gt;
SELECT postgis_full_version();
&lt;/div&gt;</code></pre>

<h3 id="ref-sqlite"><a href="#ref-sqlite" style="color: inherit; text-decoration: none;">SQLite (Empty Editor)</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="sqlite3"&gt;
-- Type your SQLite query here
&lt;/div&gt;</code></pre>

<h3 id="ref-readonly"><a href="#ref-readonly" style="color: inherit; text-decoration: none;">Read-Only Editor</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="mysql80" data-read-only="true"&gt;
-- This code cannot be edited
SELECT 'You can see me, but you can\'t touch me!' as message;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="license"><a href="#license" style="color: inherit; text-decoration: none;">License</a></h2>
<p>This script utilizes the <a href="https://ace.c9.io/">Ace Editor</a>, which is licensed under the BSD 3-Clause License. By using this script, you agree to the SQLize Embed Terms of Service.</p>
    <h1>SQLize.online Embedding Example</h1>
    
    <p class="description" id="examples">
        This page demonstrates how to embed an interactive SQL editor using the <code>sqlize-embed.js</code> script. 
        You can specify the database version using the <code>data-sql-version</code> attribute.
    </p>

    <!-- Example 1: MySQL 8.0 -->
    <h2 id="example-mysql"><a href="#example-mysql" style="color: inherit; text-decoration: none;">1. MySQL 8.0 Example</a></h2>
    <div data-sqlize-editor data-sql-version="mysql80" code-rows="15">
-- Create a sample table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Insert some data
INSERT INTO users (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

-- Query the data
SELECT * FROM users;
    </div>

    <!-- Example 2: PostgreSQL 15 -->
    <h2 id="example-psql"><a href="#example-psql" style="color: inherit; text-decoration: none;">2. PostgreSQL 15 Example</a></h2>
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

    <!-- Example 3: MariaDB 11.8 Vector -->
    <h2 id="example-mariadb"><a href="#example-mariadb" style="color: inherit; text-decoration: none;">3. MariaDB 11.8 Example with Vector Type</a></h2>
    <div data-sqlize-editor data-sql-version="mariadb118" code-rows="16">
{literal}
-- Create a table with a Vector column
CREATE TABLE t1 (id INT PRIMARY KEY, v VECTOR(3));

-- Insert vector data using VEC_FromText
INSERT INTO t1 VALUES 
(1, VEC_FromText('[1,2,3]')), 
(2, VEC_FromText('[4,5,6]')), 
(3, VEC_FromText('[7,8,9]'));

-- Calculate Euclidean distance
SELECT 
    id, 
    VEC_ToText(v) as `vector`, 
    VEC_DISTANCE_EUCLIDEAN(v, VEC_FromText('[1,1,1]')) as distance 
FROM t1 
ORDER BY distance;
{/literal}
    </div>

    <!-- Example 4: Read-Only Example -->
    <h2 id="example-readonly"><a href="#example-readonly" style="color: inherit; text-decoration: none;">4. Read-Only Example</a></h2>
    <p>This editor is set to <code>data-read-only="true"</code>, meaning you can run the query but not modify it.</p>
    <div data-sqlize-editor data-sql-version="mysql80" data-read-only="true" code-rows="5">
-- This editor is read-only
SELECT 'Hello from a read-only editor!' AS message, NOW() AS execution_time;
    </div>

    <!-- Example 5: Custom Result Height -->
    <h2 id="example-result-height"><a href="#example-result-height" style="color: inherit; text-decoration: none;">5. Custom Result Height Example</a></h2>
    <p>This editor uses <code>result-rows="6"</code> to make the result block smaller than the default.</p>
    <div data-sqlize-editor data-sql-version="sqlite3" code-rows="6" result-rows="6">
-- Smaller editor and smaller result block
SELECT 'Small result block' as note;
    </div>

    <hr>

    <h2 id="chaining"><a href="#chaining" style="color: inherit; text-decoration: none;">6. SQL Query Chaining</a></h2>
    <p>You can chain multiple editors together. When you run an editor that has a <code>data-sqlize-parent</code>, the code from all parent editors in the chain (starting from the root) will be prepended to the current editor's code before execution.</p>

    <div class="example-chain">
        <h3 id="chain-example"><a href="#chain-example" style="color: inherit; text-decoration: none;">Example: Parent-Child Chain</a></h3>
        <p>The first editor creates a table, and the second editor inserts data and selects from it. Running the second editor automatically includes the <code>CREATE TABLE</code> statement from the first one.</p>
        
        <div data-sqlize-editor 
             data-sqlize-id="base-setup" 
             data-sql-version="mysql80" 
             code-rows="3">
CREATE TABLE temp_users (id INT, name VARCHAR(50));
INSERT INTO temp_users VALUES (1, 'John Doe'), (2, 'Jane Smith');
        </div>

        <div data-sqlize-editor 
             data-sqlize-parent="base-setup" 
             data-sql-version="mysql80" 
             code-rows="4">
SELECT * FROM temp_users;
        </div>
    </div>

    <hr>

    <!-- Example 7: Preloaded Databases -->
    <h2 id="example-preloaded"><a href="#example-preloaded" style="color: inherit; text-decoration: none;">7. Preloaded Database Examples</a></h2>
    <p>Use read-only preloaded databases to query real data without any setup.</p>

    <h3 id="example-mysql97-sakila"><a href="#example-mysql97-sakila" style="color: inherit; text-decoration: none;">MySQL 9.7 — Sakila</a></h3>
    <div data-sqlize-editor data-sql-version="mysql97_sakila" code-rows="5">
SELECT actor_id, first_name, last_name FROM actor LIMIT 10;
    </div>

    <h3 id="example-psql17postgis"><a href="#example-psql17postgis" style="color: inherit; text-decoration: none;">PostgreSQL 17 + PostGIS Workshop</a></h3>
    <div data-sqlize-editor data-sql-version="psql17postgis" code-rows="5">
SELECT name, ST_AsText(geom) FROM nyc_neighborhoods LIMIT 5;
    </div>

    <h3 id="example-mssql2022aw"><a href="#example-mssql2022aw" style="color: inherit; text-decoration: none;">MS SQL Server 2022 — AdventureWorks</a></h3>
    <div data-sqlize-editor data-sql-version="mssql2022aw" code-rows="5">
SELECT TOP 10 ProductID, Name, ListPrice FROM Product ORDER BY ListPrice DESC;
    </div>

    <hr>
    <h3 id="how-to-use-summary"><a href="#how-to-use-summary" style="color: inherit; text-decoration: none;">How to use:</a></h3>
    <ol>
        <li>Include the script: <code>&lt;script src="/js/sqlize-embed.js"&gt;&lt;/script&gt;</code></li>
        <li>Add a container: <code>&lt;div data-sqlize-editor data-sql-version="mysql80"&gt;SELECT ...&lt;/div&gt;</code></li>
    </ol>
</div>
</div>
</div>