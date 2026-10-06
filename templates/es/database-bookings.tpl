{* Texto de la página /es/database/bookings (Controller::database(), estructura database.tpl).
   Recuentos de filas y resultados comprobados en la base del playground psql18demo. *}
<h1>Base de datos Bookings: esquema de aerolínea, tablas y ejercicios de SQL</h1>
<p class="db-lead">
    Bookings es la base de demostración de PostgreSQL de una aerolínea: vuelos entre 104 aeropuertos, reservas, billetes y tarjetas de embarque.
    En SQLtest.online puedes consultarla directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>8</strong> tablas y 4 vistas</li>
    <li><strong>33 121</strong> vuelos</li>
    <li><strong>1 045 726</strong> tramos de billetes</li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de Bookings</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir Bookings en el playground</a>
    {/if}
</div>

<h2>Qué es Bookings</h2>
<p>
    Bookings es la base de demostración que Postgres Professional publica para aprender PostgreSQL. Modela los vuelos de una aerolínea rusa: rutas, aviones y sus mapas de asientos, reservas, billetes y tarjetas de embarque.
</p>
<p>
    Esta copia contiene vuelos de julio a septiembre de 2017. Los nombres de aeropuertos y aviones se guardan en JSONB en inglés y ruso, y las coordenadas de los aeropuertos usan el tipo <span class="sql">point</span>. Por eso la base sirve para practicar tanto las particularidades de PostgreSQL como JOIN y análisis sobre tablas grandes.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>El diagrama muestra las tablas de Bookings y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos Bookings">Diagrama ER de la base de datos Bookings</object>
    </a>
{/if}

<h2>Qué contiene la base</h2>
<p>Las tablas se dividen en dos grupos.</p>
<div class="db-groups">
    <div>
        <h3>Datos de referencia</h3>
        <p><span class="sql">airports_data</span>, <span class="sql">aircrafts_data</span> y <span class="sql">seats</span>: el mapa de asientos de cada modelo de avión.</p>
    </div>
    <div>
        <h3>Ventas y vuelos</h3>
        <p><span class="sql">bookings</span> → <span class="sql">tickets</span> → <span class="sql">ticket_flights</span> ← <span class="sql">flights</span>, además de <span class="sql">boarding_passes</span>, que se emiten en el check-in.</p>
    </div>
</div>
<p>
    Lo principal: una reserva puede incluir varios pasajeros, y un billete puede cubrir varios vuelos. La relación entre billetes y vuelos es <span class="sql">ticket_flights</span>, la tabla más grande. Las vistas <span class="sql">aircrafts</span>, <span class="sql">airports</span>, <span class="sql">flights_v</span> y <span class="sql">routes</span> muestran los mismos datos de forma más cómoda.
</p>

<p>Cuántos datos hay en las tablas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">bookings</span></td><td class="num">262 788</td><td>reservas</td></tr>
        <tr><td><span class="sql">tickets</span></td><td class="num">366 733</td><td>billetes, uno por pasajero</td></tr>
        <tr><td><span class="sql">ticket_flights</span></td><td class="num">1 045 726</td><td>tramos de vuelo de los billetes</td></tr>
        <tr><td><span class="sql">boarding_passes</span></td><td class="num">579 686</td><td>tarjetas de embarque</td></tr>
        <tr><td><span class="sql">flights</span></td><td class="num">33 121</td><td>vuelos programados y realizados</td></tr>
        <tr><td><span class="sql">airports_data</span></td><td class="num">104</td><td>aeropuertos</td></tr>
        <tr><td><span class="sql">aircrafts_data</span></td><td class="num">9</td><td>modelos de avión</td></tr>
        <tr><td><span class="sql">seats</span></td><td class="num">1339</td><td>asientos por modelo de avión</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>{if $PlaygroundLink}Estas consultas muestran cómo se relacionan los datos. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas muestran cómo se relacionan los datos.{/if}</p>

<p><strong>Un billete y su reserva</strong>: el pasajero y el importe de la reserva.</p>
<pre><code class="language-sql">SELECT t.ticket_no, t.passenger_name, b.book_date, b.total_amount
FROM tickets t
JOIN bookings b ON b.book_ref = t.book_ref
ORDER BY t.ticket_no
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>passenger_name</th><th>book_date</th><th>total_amount</th></tr>
        <tr><td class="num">0005432000987</td><td>VALERIY TIKHONOV</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000988</td><td>EVGENIYA ALEKSEEVA</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000989</td><td>ARTUR GERASIMOV</td><td>2017-06-28 22:55:00+00</td><td class="num">24700.00</td></tr>
    </table>
</div>

<p><strong>Un vuelo y su avión</strong>: el nombre en inglés leído de una columna JSONB con <span class="sql">-&gt;&gt;</span>.</p>
<pre><code class="language-sql">SELECT f.flight_no, f.departure_airport, f.arrival_airport,
       a.model -&gt;&gt; 'en' AS aircraft
FROM flights f
JOIN aircrafts_data a ON a.aircraft_code = f.aircraft_code
ORDER BY f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>flight_no</th><th>departure_airport</th><th>arrival_airport</th><th>aircraft</th></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0404</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
    </table>
</div>

<p><strong>Tarifa y asiento</strong>: del tramo del billete al vuelo y la tarjeta de embarque. El LEFT JOIN conserva los tramos sin tarjeta.</p>
<pre><code class="language-sql">SELECT tf.ticket_no, f.flight_no, tf.fare_conditions, tf.amount, bp.seat_no
FROM ticket_flights tf
JOIN flights f ON f.flight_id = tf.flight_id
LEFT JOIN boarding_passes bp
       ON bp.ticket_no = tf.ticket_no AND bp.flight_id = tf.flight_id
ORDER BY tf.ticket_no, f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>flight_no</th><th>fare_conditions</th><th>amount</th><th>seat_no</th></tr>
        <tr><td class="num">0005432000987</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>7A</td></tr>
        <tr><td class="num">0005432000988</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>10E</td></tr>
        <tr><td class="num">0005432000989</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>18E</td></tr>
    </table>
</div>

<h2>Ejercicios de SQL por tema</h2>
<p>
    La base Bookings tiene {$TasksCount} ejercicios, desde consultas sencillas hasta análisis sobre un millón de filas. Las soluciones se comprueban automáticamente en un PostgreSQL real.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la base Bookings:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de Bookings →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar PostgreSQL para usar Bookings?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, Bookings está disponible en PostgreSQL 18.</p>
    <h3>¿Dónde descargar la base de demostración Bookings?</h3>
    <p>Postgres Professional la publica en varios tamaños en su sitio web, junto con la descripción del esquema.</p>
    <h3>¿Por qué algunos nombres aparecen entre llaves?</h3>
    <p>Los nombres de aeropuertos, ciudades y aviones son objetos JSONB con valores en inglés y ruso. Usa <span class="sql">-&gt;&gt; 'en'</span> para obtener el texto en inglés o consulta las vistas, que eligen un idioma.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar PostgreSQL para usar Bookings?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, Bookings está disponible en PostgreSQL 18."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Dónde descargar la base de demostración Bookings?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Postgres Professional la publica en varios tamaños en su sitio web, junto con la descripción del esquema."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Por qué algunos nombres aparecen entre llaves?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Los nombres de aeropuertos, ciudades y aviones son objetos JSONB con valores en inglés y ruso. Usa -&gt;&gt; 'en' para obtener el texto en inglés o consulta las vistas, que eligen un idioma."{rdelim}{rdelim}
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
