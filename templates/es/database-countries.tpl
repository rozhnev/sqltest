{* Texto de la página /es/database/countries (Controller::database(), estructura database.tpl).
   Recuentos de filas y resultados comprobados en la base del playground psql17postgis. *}
<h1>Base de datos Countries (PostGIS): tablas espaciales y ejercicios de SQL</h1>
<p class="db-lead">
    Countries es una base PostGIS para aprender SQL espacial: países y capitales del mundo, además de capas de Nueva York con manzanas censales, barrios, calles y estaciones de metro.
    En SQLtest.online puedes consultarla directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>7</strong> tablas espaciales</li>
    <li><strong>246</strong> países</li>
    <li><strong>491</strong> estaciones de metro</li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de Countries</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir Countries en el playground</a>
    {/if}
</div>

<h2>Qué es Countries</h2>
<p>
    PostGIS es la extensión de PostgreSQL que añade tipos geométricos y cientos de funciones espaciales: distancias, áreas, intersecciones, transformaciones de coordenadas. Esta base permite probarlas con datos conocidos.
</p>
<p>
    Las tablas de Nueva York proceden del conocido taller «Introduction to PostGIS», y las tablas del mundo contienen las fronteras de los países y las capitales. Juntas cubren puntos, líneas y polígonos en dos sistemas de coordenadas.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>El diagrama muestra las tablas de Countries y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos Countries">Diagrama ER de la base de datos Countries</object>
    </a>
{/if}

<h2>Qué contiene la base</h2>
<p>Las tablas se agrupan en dos bloques.</p>
<div class="db-groups">
    <div>
        <h3>Mundo</h3>
        <p><span class="sql">countries</span> con polígonos de fronteras y <span class="sql">capitals</span> con puntos, ambas en SRID 4326 (longitud y latitud).</p>
    </div>
    <div>
        <h3>Nueva York</h3>
        <p><span class="sql">nyc_census_blocks</span>, <span class="sql">nyc_neighborhoods</span>, <span class="sql">nyc_streets</span>, <span class="sql">nyc_subway_stations</span> y <span class="sql">nyc_homicides</span>, en SRID 26918 (UTM zona 18N, metros).</p>
    </div>
</div>
<p>
    Lo principal: las tablas del mundo guardan grados y las de Nueva York, metros. En las capas de Nueva York las distancias y áreas salen directamente en metros; en las tablas del mundo, convierte primero a <span class="sql">geography</span> o transforma la geometría.
</p>

<p>Cuántos datos hay en las tablas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">countries</span></td><td class="num">246</td><td>países y sus fronteras</td></tr>
        <tr><td><span class="sql">capitals</span></td><td class="num">192</td><td>capitales</td></tr>
        <tr><td><span class="sql">nyc_census_blocks</span></td><td class="num">38 794</td><td>manzanas censales con población</td></tr>
        <tr><td><span class="sql">nyc_neighborhoods</span></td><td class="num">129</td><td>barrios</td></tr>
        <tr><td><span class="sql">nyc_streets</span></td><td class="num">19 091</td><td>calles</td></tr>
        <tr><td><span class="sql">nyc_subway_stations</span></td><td class="num">491</td><td>estaciones de metro</td></tr>
        <tr><td><span class="sql">nyc_homicides</span></td><td class="num">3982</td><td>homicidios</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>{if $PlaygroundLink}Estas consultas muestran cómo se relacionan los datos. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas muestran cómo se relacionan los datos.{/if}</p>

<p><strong>Una capital dentro de su país</strong>: coordenadas del punto con <span class="sql">ST_X</span> / <span class="sql">ST_Y</span> y comprobación espacial con <span class="sql">ST_Contains</span>.</p>
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

<p><strong>Estaciones de metro y su SRID</strong>: las capas de Nueva York usan la proyección 26918.</p>
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

<h2>Ejercicios de SQL por tema</h2>
<p>
    Esta base tiene {$TasksCount} ejercicios de PostGIS: distancias, áreas, longitudes, conversiones a texto y JSON y uniones espaciales. Las soluciones se comprueban automáticamente en un PostgreSQL real con PostGIS.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la base Countries:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de Countries →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar PostGIS para usar esta base?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, elige PostgreSQL 17 + PostGIS WorkShop.</p>
    <h3>¿Qué es un SRID?</h3>
    <p>Un identificador de sistema de referencia espacial: indica en qué sistema están las coordenadas. 4326 es longitud y latitud en grados (WGS 84); 26918 es UTM zona 18N en metros, el que se usa para Nueva York.</p>
    <h3>¿De dónde vienen las tablas de Nueva York?</h3>
    <p>Del conjunto de datos del taller «Introduction to PostGIS» publicado en postgis.net, un punto de partida habitual para aprender PostGIS.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar PostGIS para usar esta base?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, elige PostgreSQL 17 + PostGIS WorkShop."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Qué es un SRID?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Un identificador de sistema de referencia espacial: indica en qué sistema están las coordenadas. 4326 es longitud y latitud en grados (WGS 84); 26918 es UTM zona 18N en metros, el que se usa para Nueva York."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿De dónde vienen las tablas de Nueva York?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Del conjunto de datos del taller «Introduction to PostGIS» publicado en postgis.net, un punto de partida habitual para aprender PostGIS."{rdelim}{rdelim}
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
