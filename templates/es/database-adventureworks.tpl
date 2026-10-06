{* Texto de la página /es/database/adventureworks (Controller::database(), estructura database.tpl).
   Recuentos de filas y resultados comprobados en la base del playground mssql2022aw. *}
<h1>Base de datos AdventureWorks LT: esquema, tablas y ejercicios de SQL</h1>
<p class="db-lead">
    AdventureWorks LT es la base de ejemplo de Microsoft SQL Server de un fabricante de bicicletas: clientes, productos, categorías de productos y pedidos.
    En SQLtest.online puedes consultarla directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>10</strong> tablas principales</li>
    <li><strong>847</strong> clientes</li>
    <li><strong>295</strong> productos</li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de AdventureWorks</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir AdventureWorks en el playground</a>
    {/if}
</div>

<h2>Qué es AdventureWorks</h2>
<p>
    AdventureWorks es la base de ejemplo que Microsoft distribuye para SQL Server y Azure SQL. Describe Adventure Works Cycles, una empresa ficticia que fabrica y vende bicicletas, piezas y accesorios.
</p>
<p>
    El sitio usa AdventureWorks LT, la edición ligera: el mismo negocio en unas diez tablas en lugar de decenas. Es ideal para practicar T-SQL, incluidos <span class="sql">TOP</span>, las autouniones sobre el árbol de categorías y las relaciones de muchos a muchos.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>El diagrama muestra las tablas de AdventureWorks y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos AdventureWorks">Diagrama ER de la base de datos AdventureWorks</object>
    </a>
{/if}

<h2>Qué contiene la base</h2>
<p>Las tablas se agrupan en tres bloques.</p>
<div class="db-groups">
    <div>
        <h3>Clientes</h3>
        <p><span class="sql">Customer</span>, <span class="sql">Address</span> y la tabla de relación <span class="sql">CustomerAddress</span>, que también guarda el tipo de dirección.</p>
    </div>
    <div>
        <h3>Productos</h3>
        <p><span class="sql">Product</span>, <span class="sql">ProductCategory</span> (un árbol: cada categoría puede tener un padre), <span class="sql">ProductModel</span> y descripciones en varios idiomas.</p>
    </div>
    <div>
        <h3>Ventas</h3>
        <p><span class="sql">SalesOrderHeader</span> guarda los pedidos y <span class="sql">SalesOrderDetail</span> sus líneas.</p>
    </div>
</div>
<p>
    Los 32 pedidos de esta edición tienen fecha del 1 de junio de 2008. Las descripciones de productos se relacionan con los modelos mediante <span class="sql">ProductModelProductDescription</span>, que también guarda el idioma (culture) de cada descripción. Las tablas de servicio <span class="sql">BuildVersion</span>, <span class="sql">ErrorLog</span> y <span class="sql">sysdiagrams</span> no se usan en los ejercicios.
</p>

<p>Cuántos datos hay en las tablas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">Customer</span></td><td class="num">847</td><td>clientes</td></tr>
        <tr><td><span class="sql">CustomerAddress</span></td><td class="num">417</td><td>relaciones cliente ↔ dirección</td></tr>
        <tr><td><span class="sql">Address</span></td><td class="num">450</td><td>direcciones</td></tr>
        <tr><td><span class="sql">SalesOrderHeader</span></td><td class="num">32</td><td>pedidos</td></tr>
        <tr><td><span class="sql">SalesOrderDetail</span></td><td class="num">542</td><td>líneas de pedido</td></tr>
        <tr><td><span class="sql">Product</span></td><td class="num">295</td><td>productos</td></tr>
        <tr><td><span class="sql">ProductCategory</span></td><td class="num">41</td><td>categorías de productos</td></tr>
        <tr><td><span class="sql">ProductModel</span></td><td class="num">128</td><td>modelos de productos</td></tr>
        <tr><td><span class="sql">ProductDescription</span></td><td class="num">762</td><td>descripciones de productos</td></tr>
        <tr><td><span class="sql">ProductModelProductDescription</span></td><td class="num">762</td><td>relaciones modelo ↔ descripción por idioma</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>{if $PlaygroundLink}Estas consultas muestran cómo se relacionan los datos. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas muestran cómo se relacionan los datos.{/if}</p>

<p><strong>Un cliente y sus direcciones</strong>: una relación de muchos a muchos mediante <span class="sql">CustomerAddress</span>.</p>
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

<p><strong>Un pedido y sus líneas</strong>: de la cabecera del pedido a los productos.</p>
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

<h2>Ejercicios de SQL por tema</h2>
<p>
    La base AdventureWorks tiene {$TasksCount} ejercicios, desde filtros sencillos hasta análisis de pedidos y productos. Las soluciones se comprueban automáticamente en un SQL Server real.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la base AdventureWorks:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de AdventureWorks →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar SQL Server para usar AdventureWorks?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, AdventureWorks está disponible en SQL Server 2022.</p>
    <h3>¿En qué se diferencia AdventureWorks LT del AdventureWorks completo?</h3>
    <p>La base completa tiene decenas de tablas en varios esquemas (Sales, Production, Person y otros). La edición LT conserva el núcleo del negocio, clientes, productos y pedidos, en unas diez tablas, lo que facilita el aprendizaje.</p>
    <h3>¿Qué dialecto de SQL se usa?</h3>
    <p>T-SQL, el dialecto de SQL Server. Por ejemplo, usa <span class="sql">TOP</span> u <span class="sql">OFFSET … FETCH</span> en lugar de <span class="sql">LIMIT</span>.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar SQL Server para usar AdventureWorks?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, AdventureWorks está disponible en SQL Server 2022."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿En qué se diferencia AdventureWorks LT del AdventureWorks completo?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "La base completa tiene decenas de tablas en varios esquemas (Sales, Production, Person y otros). La edición LT conserva el núcleo del negocio, clientes, productos y pedidos, en unas diez tablas, lo que facilita el aprendizaje."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Qué dialecto de SQL se usa?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "T-SQL, el dialecto de SQL Server. Por ejemplo, usa TOP u OFFSET … FETCH en lugar de LIMIT."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Empezar a resolver</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir el playground</a>
    {/if}
</div>
