<link rel="stylesheet" type="text/css" href="/embed.css?v={$VERSION}" media="all">

<div class="embed-page">

<div class="docs-wrapper">
    <aside class="docs-sidebar">
        <h4>Документация</h4>
        <ul>
            <li><a href="#features">Ключевые особенности</a></li>
            <li><a href="#getting-started">Начало работы</a></li>
            <li><a href="#configuration">Атрибуты конфигурации</a></li>
            <li><a href="#versions">Поддерживаемые СУБД</a></li>
            <li><a href="#use-cases">Сценарии использования</a></li>
            <li><a href="#pricing">Ценовая политика</a></li>
            <li><a href="#reference-examples">Примеры</a>
                <ul style="padding-left: 20px; font-size: 13px; margin-top: 5px; list-style: none;">
                    <li><a href="#example-mysql">1. MySQL 8.0</a></li>
                    <li><a href="#example-psql">2. PostgreSQL 15</a></li>
                    <li><a href="#example-mariadb">3. MariaDB Vector</a></li>
                    <li><a href="#example-readonly">4. Только для чтения</a></li>
                    <li><a href="#example-result-height">5. Высота результата</a></li>
                    <li><a href="#chaining">6. Цепочки запросов</a></li>
                </ul>
            </li>
            <li><a href="#license">Лицензия</a></li>
        </ul>
    </aside>

    <div class="text-content">
        <h1>Документация SQLize Embed</h1>
        <p>SQLize Embed — это легкий и адаптивный редактор и исполнитель SQL, который можно встроить в любой веб-сайт. Он позволяет вашим пользователям выполнять SQL-запросы к различным движкам баз данных прямо в браузере.</p>

        <h2 id="features"><a href="#features" style="color: inherit; text-decoration: none;">Ключевые особенности</a></h2>
<ul>
    <li><strong>Поддержка нескольких движков</strong>: Поддерживает MySQL (8.0, 9.3), PostgreSQL (14-18), MS SQL Server, MariaDB (11.4, 11.8), SQLite, Oracle, Firebird, ClickHouse и другие.</li>
    <li><strong>Готовые наборы данных</strong>: Доступ к предустановленным базам данных, таким как Sakila, UniversityDB и Bookings.</li>
    <li><strong>Адаптивный дизайн</strong>: Работает на компьютерах и мобильных устройствах.</li>
    <li><strong>Динамическая инициализация</strong>: Автоматически обнаруживает новые редакторы, добавленные на страницу через AJAX или бесконечную прокрутку.</li>
    <li><strong>На базе Ace Editor</strong>: Качественная подсветка кода и удобство редактирования.</li>
</ul>

<hr>

<h2 id="getting-started"><a href="#getting-started" style="color: inherit; text-decoration: none;">Начало работы</a></h2>

<h3 id="include-script"><a href="#include-script" style="color: inherit; text-decoration: none;">1. Подключите скрипт</a></h3>
<p>Добавьте следующий тег скрипта в раздел <code>&lt;head&gt;</code> или перед закрывающим тегом <code>&lt;/body&gt;</code> вашего сайта:</p>

<pre><code>&lt;script src="https://sqltest-online.ru/js/sql-embed.js"&gt;&lt;/script&gt;</code></pre>

<h3 id="add-container"><a href="#add-container" style="color: inherit; text-decoration: none;">2. Добавьте контейнер редактора</a></h3>
<p>Создайте элемент <code>div</code> с атрибутом <code>data-sqlize-editor</code>. Вы можете указать версию базы данных и количество видимых строк для редактора.</p>

<pre><code>&lt;div data-sqlize-editor 
 data-sql-version="mysql80" 
 code-rows="10"&gt;
SELECT * FROM sakila.actor LIMIT 5;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="configuration"><a href="#configuration" style="color: inherit; text-decoration: none;">Атрибуты конфигурации</a></h2>

<table>
    <thead>
        <tr>
            <th>Атрибут</th>
            <th>Описание</th>
            <th>По умолчанию</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>data-sqlize-editor</code></td>
            <td>Обязательный атрибут для идентификации контейнера как редактора.</td>
            <td>N/A</td>
        </tr>
        <tr>
            <td><code>data-sql-version</code></td>
            <td>Движок базы данных для использования (например, <code>mysql80</code>, <code>psql17</code>, <code>sqlite3</code>).</td>
            <td><code>mysql80</code></td>
        </tr>
        <tr>
            <td><code>code-rows</code></td>
            <td>Фиксированное количество строк, которое должен отображать редактор.</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>result-rows</code></td>
            <td>Фиксированное количество строк, которое должен отображать блок результатов.</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>data-read-only</code></td>
            <td>Установите в <code>true</code>, чтобы запретить редактирование.</td>
            <td><code>false</code></td>
        </tr>
        <tr>
            <td><code>data-sqlize-id</code></td>
            <td>Уникальный идентификатор контейнера редактора.</td>
            <td>N/A</td>
        </tr>
        <tr>
            <td><code>data-sqlize-parent</code></td>
            <td>Атрибут <code>data-sqlize-id</code> родительского редактора, код которого будет добавлен в начало.</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

<hr>

<h2 id="versions"><a href="#versions" style="color: inherit; text-decoration: none;">Поддерживаемые версии баз данных</a></h2>
<p>Используйте эти значения в атрибуте <code>data-sql-version</code>:</p>

<table>
    <thead>
        <tr>
            <th>Значение</th>
            <th>Движок базы данных</th>
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
<p><em>Примечание: также доступны предустановленные наборы данных, такие как <code>mysql97_sakila</code>, <code>psql17postgis</code>, <code>mssql2022aw</code>, <code>mysql80_sakila</code>, <code>mariadb118_university</code> и <code>psql10demo</code>.</em></p>

<hr>

<h2 id="use-cases"><a href="#use-cases" style="color: inherit; text-decoration: none;">Сценарии использования</a></h2>

<h3 id="use-case-education"><a href="#use-case-education" style="color: inherit; text-decoration: none;">Образовательные блоги и руководства</a></h3>
<p>Идеально для обучения SQL. Предоставляйте интерактивные примеры, где студенты могут изменять запросы и мгновенно видеть результаты без установки какого-либо программного обеспечения.</p>

<h3 id="use-case-docs"><a href="#use-case-docs" style="color: inherit; text-decoration: none;">Документация для инструментов баз данных</a></h3>
<p>Добавляйте разделы "Попробовать сейчас" в вашу документацию, чтобы продемонстрировать специфические возможности движка базы данных.</p>

<h3 id="use-case-portfolio"><a href="#use-case-portfolio" style="color: inherit; text-decoration: none;">Портфолио и технические интервью</a></h3>
<p>Демонстрируйте сложные SQL-запросы в своем блоге или используйте его как простую платформу для технических оценок.</p>

<hr>

<h2 id="pricing"><a href="#pricing" style="color: inherit; text-decoration: none;">Ценовая политика</a></h2>

<p>SQLize Embed распространяется на основе <strong>платной подписки</strong> по доменам.</p>

<table>
    <thead>
        <tr>
            <th>Тариф</th>
            <th>Цена</th>
            <th>Включено запросов</th>
            <th>Превышение лимита</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Лицензия на домен</strong></td>
            <td><strong>$10 / месяц</strong></td>
            <td>1 000 API-запросов / месяц</td>
            <td>$1 за каждые 1 000 запросов сверх месячного лимита</td>
        </tr>
    </tbody>
</table>

<ul>
    <li><strong>Лицензирование по доменам</strong>: Одна подписка распространяется на один домен верхнего уровня. Для каждого дополнительного домена требуется отдельная лицензия.</li>
    <li><strong>Включённая квота</strong>: 1 000 API-запросов в месяц включены в базовую стоимость.</li>
    <li><strong>Превышение лимита</strong>: Использование сверх месячного лимита тарифицируется по $1 за каждые 1 000 запросов.</li>
    <li><strong>Специальные цены и скидки</strong>: Доступны по запросу для высоконагруженных проектов и образовательных организаций.</li>
</ul>

<p>Для получения лицензионного ключа или индивидуального предложения свяжитесь с нами по адресу <a href="mailto:support@sqlize.com">support@sqlize.com</a>.</p>

<hr>

<h2 id="reference-examples"><a href="#reference-examples" style="color: inherit; text-decoration: none;">Примеры</a></h2>

<h3 id="ref-postgis"><a href="#ref-postgis" style="color: inherit; text-decoration: none;">PostgreSQL с PostGIS</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="psql17" code-rows="5"&gt;
SELECT postgis_full_version();
&lt;/div&gt;</code></pre>

<h3 id="ref-sqlite"><a href="#ref-sqlite" style="color: inherit; text-decoration: none;">SQLite (Пустой редактор)</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="sqlite3"&gt;
-- Введите ваш запрос SQLite здесь
&lt;/div&gt;</code></pre>

<h3 id="ref-readonly"><a href="#ref-readonly" style="color: inherit; text-decoration: none;">Редактор только для чтения</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="mysql80" data-read-only="true"&gt;
-- Этот код нельзя редактировать
SELECT 'Вы можете видеть меня, но не можете трогать!' as message;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="license"><a href="#license" style="color: inherit; text-decoration: none;">Лицензия</a></h2>
<p>Этот скрипт использует редактор <a href="https://ace.c9.io/">Ace Editor</a>, который распространяется под лицензией BSD 3-Clause. Используя этот скрипт, вы соглашаетесь с Условиями использования SQLize Embed.</p>
    <h1>Пример встраивания SQLize.online</h1>
    
    <p class="description" id="examples">
        Эта страница демонстрирует, как встроить интерактивный редактор SQL с помощью скрипта <code>sqlize-embed.js</code>. 
        Вы можете указать версию базы данных с помощью атрибута <code>data-sql-version</code>.
    </p>

    <!-- Example 1: MySQL 8.0 -->
    <h2 id="example-mysql"><a href="#example-mysql" style="color: inherit; text-decoration: none;">1. Пример MySQL 8.0</a></h2>
    <div data-sqlize-editor data-sql-version="mysql80" code-rows="15">
-- Создание таблицы-примера
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Вставка данных
INSERT INTO users (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

-- Запрос данных
SELECT * FROM users;
    </div>

    <!-- Example 2: PostgreSQL 15 -->
    <h2 id="example-psql"><a href="#example-psql" style="color: inherit; text-decoration: none;">2. Пример PostgreSQL 15</a></h2>
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
    <h2 id="example-mariadb"><a href="#example-mariadb" style="color: inherit; text-decoration: none;">3. Пример MariaDB 11.8 с типом Vector</a></h2>
    <div data-sqlize-editor data-sql-version="mariadb118" code-rows="16">
{literal}
-- Создание таблицы с колонкой Vector
CREATE TABLE t1 (id INT PRIMARY KEY, v VECTOR(3));

-- Вставка векторных данных с помощью VEC_FromText
INSERT INTO t1 VALUES 
(1, VEC_FromText('[1,2,3]')), 
(2, VEC_FromText('[4,5,6]')), 
(3, VEC_FromText('[7,8,9]'));

-- Вычисление евклидова расстояния
SELECT 
    id, 
    VEC_ToText(v) as `vector`, 
    VEC_DISTANCE_EUCLIDEAN(v, VEC_FromText('[1,1,1]')) as distance 
FROM t1 
ORDER BY distance;
{/literal}
    </div>

    <!-- Example 4: Read-Only Example -->
    <h2 id="example-readonly"><a href="#example-readonly" style="color: inherit; text-decoration: none;">4. Пример только для чтения</a></h2>
    <p>Для этого редактора установлено значение <code>data-read-only="true"</code>, что означает, что вы можете запустить запрос, но не можете его изменить.</p>
    <div data-sqlize-editor data-sql-version="mysql80" data-read-only="true" code-rows="5">
-- Этот редактор только для чтения
SELECT 'Привет из редактора только для чтения!' AS message, NOW() AS execution_time;
    </div>

    <!-- Example 5: Custom Result Height -->
    <h2 id="example-result-height"><a href="#example-result-height" style="color: inherit; text-decoration: none;">5. Пример с настраиваемой высотой результата</a></h2>
    <p>Этот редактор использует <code>result-rows="6"</code>, чтобы сделать блок результатов меньше, чем по умолчанию.</p>
    <div data-sqlize-editor data-sql-version="sqlite3" code-rows="6" result-rows="6">
-- Более компактный редактор и блок результатов
SELECT 'Компактный блок результатов' as note;
    </div>

    <hr>

    <h2 id="chaining"><a href="#chaining" style="color: inherit; text-decoration: none;">6. Цепочки SQL-запросов</a></h2>
    <p>Вы можете объединять несколько редакторов в цепочку. Когда вы запускаете редактор, у которого есть атрибут <code>data-sqlize-parent</code>, код из всех родительских редакторов в цепочке (начиная с корня) будет добавлен к коду текущего редактора перед выполнением.</p>

    <div class="example-chain">
        <h3 id="chain-example"><a href="#chain-example" style="color: inherit; text-decoration: none;">Пример: Цепочка Родитель-Потомок</a></h3>
        <p>Первый редактор создает таблицу, а второй вставляет данные и выбирает их. Запуск второго редактора автоматически включает инструкцию <code>CREATE TABLE</code> из первого.</p>
        
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
    <h2 id="example-preloaded"><a href="#example-preloaded" style="color: inherit; text-decoration: none;">7. Примеры с предустановленными базами данных</a></h2>
    <p>Используйте базы данных только для чтения с готовыми данными — никакой настройки не требуется.</p>

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
    <h3 id="how-to-use-summary"><a href="#how-to-use-summary" style="color: inherit; text-decoration: none;">Как использовать:</a></h3>
    <ol>
        <li>Подключите скрипт: <code>&lt;script src="/js/sqlize-embed.js"&gt;&lt;/script&gt;</code></li>
        <li>Добавьте контейнер: <code>&lt;div data-sqlize-editor data-sql-version="mysql80"&gt;SELECT ...&lt;/div&gt;</code></li>
    </ol>
</div>
</div>

<script src="/js/sqlize-embed.js?v={$VERSION}"></script>
</div>
