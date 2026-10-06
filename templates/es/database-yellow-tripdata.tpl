{* Texto de la página /es/database/yellow-tripdata (Controller::database(), estructura database.tpl).
   Recuentos de filas y resultados comprobados en la base del playground duckdb_data. *}
<h1>Conjunto de datos NYC Yellow Taxi (DuckDB): la tabla yellow_tripdata y ejercicios de SQL</h1>
<p class="db-lead">
    yellow_tripdata reúne los viajes de los taxis amarillos de Nueva York de enero de 2024, casi 3 millones de filas, cargados en DuckDB para SQL analítico.
    En SQLtest.online puedes consultarlos directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>1</strong> tabla, 19 columnas</li>
    <li><strong>2 964 624</strong> viajes</li>
    <li><strong>enero de 2024</strong> </li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de NYC Yellow Taxi</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir NYC Yellow Taxi en el playground</a>
    {/if}
</div>

<h2>Qué es NYC Yellow Taxi</h2>
<p>
    Los datos proceden de los registros de viajes que la Comisión de Taxis y Limusinas de Nueva York (TLC) publica cada mes. Cada fila es un viaje: hora de recogida y de llegada, distancia, número de pasajeros, zonas de recogida y destino, forma de pago y cada componente de la tarifa.
</p>
<p>
    DuckDB es una base de datos analítica embebida con almacenamiento en columnas, así que las agregaciones sobre millones de filas tardan fracciones de segundo. Por eso el conjunto es ideal para practicar análisis reales: series temporales, distribuciones, percentiles y limpieza de datos.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>El diagrama muestra las tablas de NYC Yellow Taxi y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos NYC Yellow Taxi">Diagrama ER de la base de datos NYC Yellow Taxi</object>
    </a>
{/if}

<h2>Qué contiene la base</h2>
<p>
    Todos los datos están en una sola tabla, <span class="sql">yellow_tripdata</span>. Todas las columnas admiten NULL y no hay claves ni restricciones. <span class="sql">PULocationID</span> y <span class="sql">DOLocationID</span> son números de zonas de taxi de la TLC. Algunos viajes tienen hora de recogida fuera de enero de 2024 y otros importes nulos o negativos: los datos reales hay que limpiarlos, y algunos ejercicios tratan justo de eso.
</p>

<p>Cuántos datos hay en las tablas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">yellow_tripdata</span></td><td class="num">2 964 624</td><td>viajes de los taxis amarillos</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>{if $PlaygroundLink}Estas consultas muestran cómo se relacionan los datos. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas muestran cómo se relacionan los datos.{/if}</p>

<p><strong>Duración del viaje</strong>: <span class="sql">date_diff</span> de DuckDB entre la recogida y la llegada.</p>
<pre><code class="language-sql">SELECT tpep_pickup_datetime,
       date_diff('minute', tpep_pickup_datetime, tpep_dropoff_datetime) AS minutes,
       trip_distance, total_amount
FROM yellow_tripdata
WHERE tpep_pickup_datetime &gt;= '2024-01-01'
ORDER BY tpep_pickup_datetime
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>tpep_pickup_datetime</th><th>minutes</th><th>trip_distance</th><th>total_amount</th></tr>
        <tr><td>2024-01-01 00:00:00</td><td class="num">2</td><td class="num">0.3</td><td class="num">11.25</td></tr>
        <tr><td>2024-01-01 00:00:02</td><td class="num">4</td><td class="num">1.57</td><td class="num">16.32</td></tr>
        <tr><td>2024-01-01 00:00:03</td><td class="num">3</td><td class="num">0.5</td><td class="num">7.6</td></tr>
    </table>
</div>

<p><strong>Un recuento rápido</strong>: <span class="sql">GROUP BY ALL</span> de DuckDB agrupa por todas las columnas no agregadas.</p>
<pre><code class="language-sql">SELECT store_and_fwd_flag, COUNT(*) AS trips
FROM yellow_tripdata
GROUP BY ALL
ORDER BY trips DESC;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>store_and_fwd_flag</th><th>trips</th></tr>
        <tr><td>N</td><td class="num">2813126</td></tr>
        <tr><td>NULL</td><td class="num">140162</td></tr>
        <tr><td>Y</td><td class="num">11336</td></tr>
    </table>
</div>

<h2>Ejercicios de SQL por tema</h2>
<p>
    Este conjunto de datos tiene {$TasksCount} ejercicios, desde estadísticas generales hasta series temporales y comprobaciones de calidad. Las soluciones se comprueban automáticamente en un DuckDB real.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la base NYC Yellow Taxi:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de NYC Yellow Taxi →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar DuckDB para usar este conjunto de datos?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, elige DuckDB.</p>
    <h3>¿De dónde vienen los datos?</h3>
    <p>De los datos abiertos de la Comisión de Taxis y Limusinas de Nueva York (TLC), que se publican cada mes en archivos Parquet. Esta copia contiene los viajes de los taxis amarillos de enero de 2024.</p>
    <h3>¿En qué se diferencia el SQL de DuckDB?</h3>
    <p>Es parecido al de PostgreSQL, con extras para análisis como <span class="sql">GROUP BY ALL</span>, <span class="sql">QUALIFY</span>, <span class="sql">date_diff</span> y funciones de cuantiles.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar DuckDB para usar este conjunto de datos?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, elige DuckDB."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿De dónde vienen los datos?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "De los datos abiertos de la Comisión de Taxis y Limusinas de Nueva York (TLC), que se publican cada mes en archivos Parquet. Esta copia contiene los viajes de los taxis amarillos de enero de 2024."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿En qué se diferencia el SQL de DuckDB?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Es parecido al de PostgreSQL, con extras para análisis como GROUP BY ALL, QUALIFY, date_diff y funciones de cuantiles."{rdelim}{rdelim}
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
