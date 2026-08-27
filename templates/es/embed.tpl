<link rel="stylesheet" type="text/css" href="/embed.css?v={$VERSION}" media="all">

<div class="embed-page">
<div class="docs-wrapper">
    <aside class="docs-sidebar">
        <h4>Documentación</h4>
        <ul>
            <li><a href="#features">Características Clave</a></li>
            <li><a href="#getting-started">Introducción</a></li>
            <li><a href="#configuration">Atributos de Configuración</a></li>
            <li><a href="#versions">Motores Soportados</a></li>
            <li><a href="#use-cases">Casos de Uso</a></li>
            <li><a href="#pricing">Política de Precios</a></li>
            <li><a href="#reference-examples">Ejemplos</a>
                <ul style="padding-left: 20px; font-size: 13px; margin-top: 5px; list-style: none;">
                    <li><a href="#example-mysql">1. MySQL 8.0</a></li>
                    <li><a href="#example-psql">2. PostgreSQL 15</a></li>
                    <li><a href="#example-mariadb">3. MariaDB Vector</a></li>
                    <li><a href="#example-readonly">4. Solo Lectura</a></li>
                    <li><a href="#example-result-height">5. Altura del Resultado</a></li>
                    <li><a href="#chaining">6. Encadenamiento de Consultas</a></li>
                </ul>
            </li>
            <li><a href="#license">Licencia</a></li>
        </ul>
    </aside>

    <div class="text-content">
        <h1>Documentación de SQLize Embed</h1>
        <p>SQLize Embed es un editor y ejecutor de SQL ligero y responsivo que puedes incrustar en cualquier sitio web. Permite a tus usuarios ejecutar consultas SQL contra varios motores de bases de datos directamente en su navegador.</p>

        <h2 id="features"><a href="#features" style="color: inherit; text-decoration: none;">Características Clave</a></h2>
<ul>
    <li><strong>Soporte Multi-Motor</strong>: Soporta MySQL (8.0, 9.3), PostgreSQL (14-18), MS SQL Server, MariaDB (11.4, 11.8), SQLite, Oracle, Firebird, ClickHouse, y más.</li>
    <li><strong>Conjuntos de Datos Listos para Usar</strong>: Acceso a bases de datos precargadas como Sakila, UniversityDB, y Bookings.</li>
    <li><strong>Diseño Responsivo</strong>: Funciona en escritorios y dispositivos móviles.</li>
    <li><strong>Inicialización Dinámica</strong>: Detecta automáticamente nuevos editores añadidos a la página a través de AJAX o desplazamiento infinito.</li>
    <li><strong>Impulsado por Ace Editor</strong>: Experiencia de edición y resaltado de código de alta calidad.</li>
</ul>

<hr>

<h2 id="getting-started"><a href="#getting-started" style="color: inherit; text-decoration: none;">Introducción</a></h2>

<h3 id="include-script"><a href="#include-script" style="color: inherit; text-decoration: none;">1. Incluir el Script</a></h3>
<p>Agrega la siguiente etiqueta de script en el <code>&lt;head&gt;</code> o antes de la etiqueta de cierre <code>&lt;/body&gt;</code> de tu sitio web:</p>

<pre><code>&lt;script src="https://sqlize.online/js/sqlize-embed.js"&gt;&lt;/script&gt;</code></pre>

<h3 id="add-container"><a href="#add-container" style="color: inherit; text-decoration: none;">2. Agregar un Contenedor de Editor</a></h3>
<p>Crea un elemento <code>div</code> con el atributo <code>data-sqlize-editor</code>. Puedes especificar la versión de la base de datos y el número de filas visibles para el editor.</p>

<pre><code>&lt;div data-sqlize-editor 
 data-sql-version="mysql80" 
 code-rows="10"&gt;
SELECT * FROM sakila.actor LIMIT 5;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="configuration"><a href="#configuration" style="color: inherit; text-decoration: none;">Atributos de Configuración</a></h2>

<table>
    <thead>
        <tr>
            <th>Atributo</th>
            <th>Descripción</th>
            <th>Por Defecto</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>data-sqlize-editor</code></td>
            <td>Atributo requerido para identificar el contenedor como un editor.</td>
            <td>N/A</td>
        </tr>
        <tr>
            <td><code>data-sql-version</code></td>
            <td>El motor de base de datos a utilizar (por ejemplo, <code>mysql80</code>, <code>psql17</code>, <code>sqlite3</code>).</td>
            <td><code>mysql80</code></td>
        </tr>
        <tr>
            <td><code>code-rows</code></td>
            <td>El número fijo de líneas que el editor debe mostrar.</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>result-rows</code></td>
            <td>El número fijo de líneas que el bloque de resultados debe mostrar.</td>
            <td><code>12</code></td>
        </tr>
        <tr>
            <td><code>data-read-only</code></td>
            <td>Establecer en <code>true</code> para deshabilitar la edición.</td>
            <td><code>false</code></td>
        </tr>
        <tr>
            <td><code>data-sqlize-id</code></td>
            <td>Identificador único para el contenedor del editor.</td>
            <td>N/A</td>
        </tr>
        <tr>
            <td><code>data-sqlize-parent</code></td>
            <td>El <code>data-sqlize-id</code> del editor padre cuyo código será precedido.</td>
            <td>N/A</td>
        </tr>
    </tbody>
</table>

<hr>

<h2 id="versions"><a href="#versions" style="color: inherit; text-decoration: none;">Versiones de Base de Datos Soportadas</a></h2>
<p>Utiliza estos valores en el atributo <code>data-sql-version</code>:</p>

<table>
    <thead>
        <tr>
            <th>Valor</th>
            <th>Motor de Base de Datos</th>
        </tr>
    </thead>
    <tbody>
        <tr><td><code>mysql80</code></td><td>MySQL 8.0</td></tr>
        <tr><td><code>mysql93</code></td><td>MySQL 9.3.0</td></tr>
        <tr><td><code>mysql97_sakila</code></td><td>MySQL 9.7 Sakila (Solo Lectura)</td></tr>
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
<p><em>Nota: Conjuntos de datos precargados como <code>mysql97_sakila</code>, <code>psql17postgis</code>, <code>mssql2022aw</code>, <code>mysql80_sakila</code>, <code>mariadb118_university</code>, y <code>psql10demo</code> también están disponibles.</em></p>

<hr>

<h2 id="use-cases"><a href="#use-cases" style="color: inherit; text-decoration: none;">Casos de Uso</a></h2>

<h3 id="use-case-education"><a href="#use-case-education" style="color: inherit; text-decoration: none;">Blogs Educativos &amp; Tutoriales</a></h3>
<p>Perfecto para enseñar SQL. Proporciona ejemplos interactivos donde los estudiantes pueden modificar consultas y ver resultados al instante sin instalar ningún software.</p>

<h3 id="use-case-docs"><a href="#use-case-docs" style="color: inherit; text-decoration: none;">Documentación para Herramientas de Base de Datos</a></h3>
<p>Incluye secciones de "Pruébalo ahora" en tu documentación para demostrar características específicas de un motor de base de datos.</p>

<h3 id="use-case-portfolio"><a href="#use-case-portfolio" style="color: inherit; text-decoration: none;">Portafolio &amp; Entrevistas Técnicas</a></h3>
<p>Muestra consultas SQL complejas en tu blog o úsalo como una plataforma simple para evaluaciones técnicas.</p>

<hr>

<h2 id="pricing"><a href="#pricing" style="color: inherit; text-decoration: none;">Política de Precios</a></h2>

<p>SQLize Embed se distribuye bajo un <strong>modelo de suscripción paga</strong> por dominio.</p>

<table>
    <thead>
        <tr>
            <th>Plan</th>
            <th>Precio</th>
            <th>Solicitudes Incluidas</th>
            <th>Uso Adicional</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Licencia por Dominio</strong></td>
            <td><strong>$10 / mes</strong></td>
            <td>1,000 solicitudes API / mes</td>
            <td>$1 por cada 1,000 solicitudes sobre el límite mensual</td>
        </tr>
    </tbody>
</table>

<ul>
    <li><strong>Licenciamiento por Dominio</strong>: Una suscripción cubre un dominio de nivel superior. Cada dominio adicional requiere una licencia separada.</li>
    <li><strong>Cuota Incluida</strong>: Se incluyen 1,000 solicitudes API por mes en el precio base.</li>
    <li><strong>Exceso</strong>: El uso adicional más allá del límite mensual se factura a $1 por cada 1,000 solicitudes.</li>
    <li><strong>Precios Especiales &amp; Descuentos</strong>: Disponibles a pedido para casos de uso de alto volumen o educativos.</li>
</ul>

<p>Para obtener tu clave de licencia o solicitar un presupuesto personalizado, contáctanos en <a href="mailto:support@sqlize.com">support@sqlize.com</a>.</p>

<hr>

<h2 id="reference-examples"><a href="#reference-examples" style="color: inherit; text-decoration: none;">Ejemplos</a></h2>

<h3 id="ref-postgis"><a href="#ref-postgis" style="color: inherit; text-decoration: none;">PostgreSQL con PostGIS</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="psql17" code-rows="5"&gt;
SELECT postgis_full_version();
&lt;/div&gt;</code></pre>

<h3 id="ref-sqlite"><a href="#ref-sqlite" style="color: inherit; text-decoration: none;">SQLite (Editor Vacío)</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="sqlite3"&gt;
-- Escribe tu consulta SQLite aquí
&lt;/div&gt;</code></pre>

<h3 id="ref-readonly"><a href="#ref-readonly" style="color: inherit; text-decoration: none;">Editor de Solo Lectura</a></h3>
<pre><code>&lt;div data-sqlize-editor data-sql-version="mysql80" data-read-only="true"&gt;
-- Este código no puede ser editado
SELECT '¡Puedes verme, pero no puedes tocarme!' as message;
&lt;/div&gt;</code></pre>

<hr>

<h2 id="license"><a href="#license" style="color: inherit; text-decoration: none;">Licencia</a></h2>
<p>Este script utiliza el <a href="https://ace.c9.io/">Ace Editor</a>, que está licenciado bajo la Licencia BSD de 3 cláusulas. Al utilizar este script, aceptas los Términos de Servicio de SQLize Embed.</p>
    <h1>Ejemplo de Incrustación de SQLize.online</h1>
    
    <p class="description" id="examples">
        Esta página demuestra cómo incrustar un editor SQL interactivo utilizando el script <code>sqlize-embed.js</code>. 
        Puedes especificar la versión de la base de datos utilizando el atributo <code>data-sql-version</code>.
    </p>

    <!-- Example 1: MySQL 8.0 -->
    <h2 id="example-mysql"><a href="#example-mysql" style="color: inherit; text-decoration: none;">1. Ejemplo de MySQL 8.0</a></h2>
    <div data-sqlize-editor data-sql-version="mysql80" code-rows="15">
-- Crear una tabla de ejemplo
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Insertar algunos datos
INSERT INTO users (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

-- Consultar los datos
SELECT * FROM users;
    </div>

    <!-- Example 2: PostgreSQL 15 -->
    <h2 id="example-psql"><a href="#example-psql" style="color: inherit; text-decoration: none;">2. Ejemplo de PostgreSQL 15</a></h2>
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
    <h2 id="example-mariadb"><a href="#example-mariadb" style="color: inherit; text-decoration: none;">3. Ejemplo de MariaDB 11.8 con Tipo Vector</a></h2>
    <div data-sqlize-editor data-sql-version="mariadb118" code-rows="16">
{literal}
-- Crear una tabla con una columna Vector
CREATE TABLE t1 (id INT PRIMARY KEY, v VECTOR(3));

-- Insertar datos vectoriales usando VEC_FromText
INSERT INTO t1 VALUES 
(1, VEC_FromText('[1,2,3]')), 
(2, VEC_FromText('[4,5,6]')), 
(3, VEC_FromText('[7,8,9]'));

-- Calcular la distancia euclidiana
SELECT 
    id, 
    VEC_ToText(v) as `vector`, 
    VEC_DISTANCE_EUCLIDEAN(v, VEC_FromText('[1,1,1]')) as distance 
FROM t1 
ORDER BY distance;
{/literal}
    </div>

    <!-- Example 4: Read-Only Example -->
    <h2 id="example-readonly"><a href="#example-readonly" style="color: inherit; text-decoration: none;">4. Ejemplo de Solo Lectura</a></h2>
    <p>Este editor está configurado como <code>data-read