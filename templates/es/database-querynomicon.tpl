{* Texto de la página /es/database/querynomicon (Controller::database(), estructura database.tpl).
   Recuentos de filas y resultados comprobados en la base del playground sqlite3_data. *}
<h1>Base de datos Querynomicon (SQLite): pingüinos, tablas y ejercicios de SQL</h1>
<p class="db-lead">
    Querynomicon es una pequeña base SQLite para aprender SQL desde cero: el conjunto de datos de pingüinos de Palmer y un diminuto laboratorio con personal, experimentos y placas de ensayo.
    En SQLtest.online puedes consultarla directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>13</strong> tablas</li>
    <li><strong>344</strong> pingüinos</li>
    <li><strong>50</strong> experimentos</li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de Querynomicon</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir Querynomicon en el playground</a>
    {/if}
</div>

<h2>Qué es Querynomicon</h2>
<p>
    La base procede del Querynomicon, el tutorial gratuito de Greg Wilson «An Introduction to SQL for Wary Data Scientists». Su tabla principal contiene los pingüinos de Palmer: medidas de 344 pingüinos de tres especies de tres islas de la Antártida.
</p>
<p>
    Los datos son pocos y fáciles de leer, pero tienen las particularidades de los datos reales: valores ausentes (NULL) en las medidas y en la columna de sexo. Por eso la base es ideal para aprender filtrado, ordenación, agrupación, tratamiento de NULL y lo básico de DDL y DML.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>El diagrama muestra las tablas de Querynomicon y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos Querynomicon">Diagrama ER de la base de datos Querynomicon</object>
    </a>
{/if}

<h2>Qué contiene la base</h2>
<p>Las tablas se agrupan en dos bloques.</p>
<div class="db-groups">
    <div>
        <h3>Pingüinos</h3>
        <p><span class="sql">penguins</span> con las 344 aves y <span class="sql">little_penguins</span>, una muestra de 10 filas para pruebas rápidas.</p>
    </div>
    <div>
        <h3>Laboratorio</h3>
        <p><span class="sql">department</span>, <span class="sql">staff</span>, <span class="sql">experiment</span>, <span class="sql">performed</span> (quién realizó cada experimento), <span class="sql">plate</span> e <span class="sql">invalidated</span>, además de <span class="sql">machine</span>, <span class="sql">usage</span>, <span class="sql">person</span> y <span class="sql">contact</span>.</p>
    </div>
</div>
<p>
    Las tablas de pingüinos no tienen claves: cada fila es un ave. Las tablas del laboratorio se relacionan con identificadores numéricos, y <span class="sql">performed</span> une personal y experimentos en una relación de muchos a muchos.
</p>

<p>Cuántos datos hay en las tablas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">penguins</span></td><td class="num">344</td><td>pingüinos y sus medidas</td></tr>
        <tr><td><span class="sql">little_penguins</span></td><td class="num">10</td><td>una muestra de 10 pingüinos</td></tr>
        <tr><td><span class="sql">department</span></td><td class="num">4</td><td>departamentos</td></tr>
        <tr><td><span class="sql">staff</span></td><td class="num">10</td><td>personal</td></tr>
        <tr><td><span class="sql">experiment</span></td><td class="num">50</td><td>experimentos</td></tr>
        <tr><td><span class="sql">performed</span></td><td class="num">65</td><td>personal ↔ experimentos</td></tr>
        <tr><td><span class="sql">plate</span></td><td class="num">256</td><td>placas de ensayo</td></tr>
        <tr><td><span class="sql">invalidated</span></td><td class="num">30</td><td>placas invalidadas</td></tr>
        <tr><td><span class="sql">machine</span></td><td class="num">3</td><td>aparatos del laboratorio</td></tr>
        <tr><td><span class="sql">person</span></td><td class="num">15</td><td>personas</td></tr>
        <tr><td><span class="sql">usage</span></td><td class="num">8</td><td>registro de uso de aparatos</td></tr>
        <tr><td><span class="sql">contact</span></td><td class="num">8</td><td>contactos</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>{if $PlaygroundLink}Estas consultas muestran cómo se relacionan los datos. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas muestran cómo se relacionan los datos.{/if}</p>

<p><strong>Experimentos y placas</strong>: una relación de uno a muchos con LEFT JOIN y un recuento.</p>
<pre><code class="language-sql">SELECT e.ident, e.kind, e.started, COUNT(p.ident) AS plates
FROM experiment e
LEFT JOIN plate p ON p.experiment = e.ident
GROUP BY e.ident
ORDER BY e.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ident</th><th>kind</th><th>started</th><th>plates</th></tr>
        <tr><td class="num">1</td><td>calibration</td><td>2023-08-25</td><td class="num">1</td></tr>
        <tr><td class="num">2</td><td>calibration</td><td>2023-02-14</td><td class="num">1</td></tr>
        <tr><td class="num">3</td><td>trial</td><td>2023-02-22</td><td class="num">10</td></tr>
    </table>
</div>

<p><strong>Quién realizó un experimento</strong>: una relación de muchos a muchos mediante <span class="sql">performed</span>.</p>
<pre><code class="language-sql">SELECT s.personal, s.family, e.kind, e.started
FROM performed pf
JOIN staff s ON s.ident = pf.staff
JOIN experiment e ON e.ident = pf.experiment
ORDER BY e.ident, s.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>personal</th><th>family</th><th>kind</th><th>started</th></tr>
        <tr><td>Nitya</td><td>Lal</td><td>calibration</td><td>2023-08-25</td></tr>
        <tr><td>Indrans</td><td>Sridhar</td><td>calibration</td><td>2023-02-14</td></tr>
        <tr><td>Kartik</td><td>Gupta</td><td>trial</td><td>2023-02-22</td></tr>
    </table>
</div>

<h2>Ejercicios de SQL por tema</h2>
<p>
    La base Querynomicon tiene {$TasksCount} ejercicios, desde el primer SELECT hasta vistas, índices y triggers. Las soluciones se comprueban automáticamente en un SQLite real.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la base Querynomicon:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de Querynomicon →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar SQLite para usar Querynomicon?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, elige SQLite 3 Preloaded.</p>
    <h3>¿Qué son los pingüinos de Palmer?</h3>
    <p>Un conjunto de datos didáctico muy popular: medidas de pingüinos adelia, barbijo y papúa tomadas en la estación Palmer, en la Antártida. Se usa a menudo como sustituto moderno del conjunto de datos iris.</p>
    <h3>¿Es buena esta base para principiantes?</h3>
    <p>Sí. Las tablas son pequeñas y el tema no necesita explicación, así que puedes centrarte en el propio SQL: SELECT, WHERE, ORDER BY, GROUP BY y el tratamiento de NULL.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar SQLite para usar Querynomicon?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, elige SQLite 3 Preloaded."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Qué son los pingüinos de Palmer?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Un conjunto de datos didáctico muy popular: medidas de pingüinos adelia, barbijo y papúa tomadas en la estación Palmer, en la Antártida. Se usa a menudo como sustituto moderno del conjunto de datos iris."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Es buena esta base para principiantes?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Sí. Las tablas son pequeñas y el tema no necesita explicación, así que puedes centrarte en el propio SQL: SELECT, WHERE, ORDER BY, GROUP BY y el tratamiento de NULL."{rdelim}{rdelim}
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
