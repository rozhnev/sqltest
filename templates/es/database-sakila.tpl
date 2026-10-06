{* Texto de la página /es/database/sakila (Controller::database(), estructura database.tpl).
   Recuentos de filas comprobados en la base del playground mysql80_sakila. *}
<h1>Base de datos Sakila: esquema, tablas y ejercicios de SQL</h1>
<p class="db-lead">
    Sakila es la base de datos de ejemplo de MySQL que describe una cadena de videoclubes de alquiler de películas en DVD.
    En SQLtest.online puedes usarla directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tablas y 7 vistas</li>
    <li><strong>1000</strong> películas</li>
    <li><strong>16 044</strong> alquileres</li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de Sakila</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Abrir Sakila en el playground</a>
</div>

<h2>Qué es Sakila</h2>
<p>
    Sakila la creó Mike Hillyer, del equipo de documentación de MySQL, para que los ejemplos de la documentación y de los libros compartieran un mismo esquema realista.
    Su nombre viene de Sakila, el delfín del logotipo de MySQL, y se distribuye con licencia BSD.
</p>
<p>
    La base modela un negocio corriente: un catálogo de películas con actores y géneros, clientes y empleados de dos tiendas, alquileres de discos y pagos.
    Por eso es ideal para aprender: las relaciones se entienden sin explicaciones y hay datos suficientes para agrupaciones, funciones de ventana y análisis.
</p>

<h2>Diagrama ER</h2>
<p>El diagrama muestra las tablas de Sakila y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
<a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
    {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
    <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos Sakila: tablas y sus relaciones">Diagrama ER de la base de datos Sakila</object>
</a>

<h2>Qué contiene la base</h2>
<p>Las tablas de Sakila se agrupan en tres bloques.</p>
<div class="db-groups">
    <div>
        <h3>Catálogo de películas</h3>
        <p><span class="sql">film</span>, <span class="sql">actor</span>, <span class="sql">category</span>, <span class="sql">language</span> y las tablas de relación <span class="sql">film_actor</span>, <span class="sql">film_category</span>.</p>
    </div>
    <div>
        <h3>Tiendas y personas</h3>
        <p><span class="sql">store</span>, <span class="sql">staff</span>, <span class="sql">customer</span> y las direcciones: <span class="sql">address</span> → <span class="sql">city</span> → <span class="sql">country</span>.</p>
    </div>
    <div>
        <h3>Alquileres y pagos</h3>
        <p><span class="sql">inventory</span> guarda los discos de cada tienda, <span class="sql">rental</span> los alquileres y <span class="sql">payment</span> los pagos.</p>
    </div>
</div>
<p>
    Lo principal: el cliente alquila un disco, no una película. Por eso <span class="sql">rental</span> se relaciona con <span class="sql">film</span> a través de <span class="sql">inventory</span>, no directamente.
    La tabla <span class="sql">film_text</span> es una copia auxiliar de títulos y descripciones para la búsqueda de texto completo.
</p>

<p>Cuántos datos hay en las tablas principales:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">rental</span></td><td class="num">16 044</td><td>alquileres de discos</td></tr>
        <tr><td><span class="sql">payment</span></td><td class="num">16 049</td><td>pagos de clientes</td></tr>
        <tr><td><span class="sql">film_actor</span></td><td class="num">5462</td><td>papeles de los actores en las películas</td></tr>
        <tr><td><span class="sql">inventory</span></td><td class="num">4581</td><td>discos en las tiendas</td></tr>
        <tr><td><span class="sql">film</span></td><td class="num">1000</td><td>películas</td></tr>
        <tr><td><span class="sql">customer</span></td><td class="num">599</td><td>clientes</td></tr>
        <tr><td><span class="sql">city</span></td><td class="num">600</td><td>ciudades</td></tr>
        <tr><td><span class="sql">actor</span></td><td class="num">200</td><td>actores</td></tr>
        <tr><td><span class="sql">country</span></td><td class="num">109</td><td>países</td></tr>
        <tr><td><span class="sql">category</span></td><td class="num">16</td><td>géneros</td></tr>
        <tr><td><span class="sql">store</span></td><td class="num">2</td><td>tiendas</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>Estas consultas muestran cómo se relacionan las tablas. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.</p>

<p><strong>Una película y su idioma</strong>: una relación sencilla de muchos a uno.</p>
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

<p><strong>Dónde vive un cliente</strong>: una cadena de cuatro tablas.</p>
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

<p><strong>Qué película se alquiló y cuánto se pagó</strong>: del alquiler a la película pasando por <span class="sql">inventory</span>.</p>
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

<h2>Ejercicios de SQL por tema</h2>
<p>
    La base Sakila tiene {$TasksCount} ejercicios, desde consultas SELECT sencillas hasta análisis con funciones de ventana. Las soluciones se comprueban automáticamente en un MySQL real.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la sección «Base de datos Sakila»:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de Sakila →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar MySQL para usar Sakila?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, Sakila está disponible en MySQL 8.0, MySQL 9.7 y MariaDB 10.</p>
    <h3>¿Dónde descargar la base de datos Sakila?</h3>
    <p>Los archivos oficiales <span class="sql">sakila-schema.sql</span> y <span class="sql">sakila-data.sql</span> están en la <a href="https://dev.mysql.com/doc/index-other.html" target="_blank" rel="noopener">página de bases de datos de ejemplo de MySQL</a>, y la <a href="https://dev.mysql.com/doc/sakila/en/" target="_blank" rel="noopener">documentación de Sakila</a> los describe.</p>
    <h3>¿Existe Sakila para PostgreSQL?</h3>
    <p>Sí, existe una adaptación llamada Pagila. La estructura es la misma, pero algunos tipos y funciones se sustituyen por sus equivalentes de PostgreSQL.</p>
    <h3>¿Se pueden modificar los datos de Sakila?</h3>
    <p>En el playground la base es de solo lectura, para que todos vean los mismos datos. Los ejercicios de INSERT, UPDATE y DELETE se ejecutan sobre una copia temporal de la tabla necesaria, y después se comprueba el contenido de esa copia.</p>
    <h3>¿Sirve Sakila para preparar una entrevista de SQL?</h3>
    <p>Sí. Con ella es fácil practicar JOIN, agrupaciones, subconsultas y funciones de ventana, los temas que más se preguntan en las entrevistas técnicas.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar MySQL para usar Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, Sakila está disponible en MySQL 8.0, MySQL 9.7 y MariaDB 10."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Dónde descargar la base de datos Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Los archivos oficiales sakila-schema.sql y sakila-data.sql están en la página de bases de datos de ejemplo de MySQL (dev.mysql.com/doc/index-other.html), y la documentación de Sakila los describe."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Existe Sakila para PostgreSQL?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Sí, existe una adaptación llamada Pagila. La estructura es la misma, pero algunos tipos y funciones se sustituyen por sus equivalentes de PostgreSQL."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Se pueden modificar los datos de Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "En el playground la base es de solo lectura, para que todos vean los mismos datos. Los ejercicios de INSERT, UPDATE y DELETE se ejecutan sobre una copia temporal de la tabla necesaria, y después se comprueba el contenido de esa copia."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Sirve Sakila para preparar una entrevista de SQL?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Sí. Con ella es fácil practicar JOIN, agrupaciones, subconsultas y funciones de ventana, los temas que más se preguntan en las entrevistas técnicas."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Empezar a resolver</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Abrir el playground</a>
</div>
