{* Texto de la página /es/database/university (Controller::database(), estructura database.tpl).
   Recuentos de filas y resultados comprobados en la base del playground mariadb118_university. *}
<h1>Base de datos University (MariaDB): esquema, tablas y ejercicios de SQL</h1>
<p class="db-lead">
    University es una base de ejemplo de MariaDB sobre una universidad: departamentos, profesores, estudiantes, cursos, grupos, matrículas, calificaciones e investigación.
    En SQLtest.online puedes consultarla directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tablas y 7 vistas</li>
    <li><strong>2000</strong> estudiantes</li>
    <li><strong>24 981</strong> matrículas</li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de University</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir University en el playground</a>
    {/if}
</div>

<h2>Qué es University</h2>
<p>
    University es una base de ejemplo moderna para MariaDB 11, pensada como una alternativa más rica a la clásica Sakila. Está normalizada hasta la tercera forma normal y usa muchos tipos de datos de MariaDB: JSON, ENUM y SET, índices FULLTEXT y columnas VECTOR para embeddings.
</p>
<p>
    Hay datos suficientes para análisis reales: unas 25 000 matrículas, 300 000 calificaciones y un registro de auditoría de más de medio millón de filas. Y el tema resulta familiar para cualquiera que haya estudiado en la universidad.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>El diagrama muestra las tablas de University y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos University">Diagrama ER de la base de datos University</object>
    </a>
{/if}

<h2>Qué contiene la base</h2>
<p>Las tablas se agrupan en tres bloques.</p>
<div class="db-groups">
    <div>
        <h3>Personas y estructura</h3>
        <p><span class="sql">departments</span> (un árbol), <span class="sql">faculty</span>, <span class="sql">students</span> y <span class="sql">rooms</span>.</p>
    </div>
    <div>
        <h3>Docencia</h3>
        <p><span class="sql">courses</span> con <span class="sql">course_prerequisites</span>, <span class="sql">semesters</span>, <span class="sql">sections</span>, <span class="sql">enrollments</span> y <span class="sql">grade_events</span>.</p>
    </div>
    <div>
        <h3>Investigación y becas</h3>
        <p><span class="sql">research_projects</span>, <span class="sql">project_members</span>, <span class="sql">publications</span>, <span class="sql">scholarships</span> y <span class="sql">student_scholarships</span>, además de <span class="sql">audit_log</span>.</p>
    </div>
</div>
<p>
    Lo principal: el estudiante se matricula en un grupo, una edición concreta del curso en un semestre, no en el curso en sí. Por eso el camino del estudiante al curso es <span class="sql">enrollments</span> → <span class="sql">sections</span> → <span class="sql">courses</span>. Siete vistas, como <span class="sql">v_student_gpa</span> y <span class="sql">v_course_pass_rate</span>, contienen informes ya preparados.
</p>

<p>Cuántos datos hay en las tablas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">students</span></td><td class="num">2000</td><td>estudiantes</td></tr>
        <tr><td><span class="sql">faculty</span></td><td class="num">250</td><td>profesores</td></tr>
        <tr><td><span class="sql">departments</span></td><td class="num">25</td><td>departamentos</td></tr>
        <tr><td><span class="sql">courses</span></td><td class="num">116</td><td>cursos</td></tr>
        <tr><td><span class="sql">course_prerequisites</span></td><td class="num">49</td><td>requisitos previos de los cursos</td></tr>
        <tr><td><span class="sql">semesters</span></td><td class="num">20</td><td>semestres</td></tr>
        <tr><td><span class="sql">sections</span></td><td class="num">1715</td><td>grupos de un curso en el semestre</td></tr>
        <tr><td><span class="sql">rooms</span></td><td class="num">48</td><td>aulas</td></tr>
        <tr><td><span class="sql">enrollments</span></td><td class="num">24 981</td><td>matrículas en grupos</td></tr>
        <tr><td><span class="sql">grade_events</span></td><td class="num">307 081</td><td>calificaciones de tareas y exámenes</td></tr>
        <tr><td><span class="sql">research_projects</span></td><td class="num">200</td><td>proyectos de investigación</td></tr>
        <tr><td><span class="sql">project_members</span></td><td class="num">876</td><td>miembros de los proyectos</td></tr>
        <tr><td><span class="sql">publications</span></td><td class="num">500</td><td>publicaciones</td></tr>
        <tr><td><span class="sql">scholarships</span></td><td class="num">20</td><td>becas</td></tr>
        <tr><td><span class="sql">student_scholarships</span></td><td class="num">773</td><td>becas concedidas a estudiantes</td></tr>
        <tr><td><span class="sql">audit_log</span></td><td class="num">664 124</td><td>registro de cambios</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>{if $PlaygroundLink}Estas consultas muestran cómo se relacionan los datos. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas muestran cómo se relacionan los datos.{/if}</p>

<p><strong>Un estudiante, un curso y una nota</strong>: de la matrícula, pasando por el grupo, al curso y el semestre.</p>
<pre><code class="language-sql">SELECT s.first_name, s.last_name, c.code, sem.name AS semester, e.final_grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN sections sec ON sec.section_id = e.section_id
JOIN courses c ON c.course_id = sec.course_id
JOIN semesters sem ON sem.semester_id = sec.semester_id
WHERE e.final_grade IS NOT NULL
ORDER BY e.enrollment_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>code</th><th>semester</th><th>final_grade</th></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH111</td><td>Fall 2024</td><td>B+</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>NURS102</td><td>Fall 2024</td><td>B</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH106</td><td>Summer 2024</td><td>B</td></tr>
    </table>
</div>

<p><strong>Horario de tutorías en JSON</strong>: un valor leído de una columna JSON con <span class="sql">JSON_VALUE</span>.</p>
<pre><code class="language-sql">SELECT first_name, last_name,
       JSON_VALUE(office_hours, '$[0].day') AS day,
       JSON_VALUE(office_hours, '$[0].start') AS starts_at
FROM faculty
ORDER BY faculty_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>day</th><th>starts_at</th></tr>
        <tr><td>Danielle</td><td>Johnson</td><td>Tue</td><td>09:00</td></tr>
        <tr><td>Jason</td><td>Hahn</td><td>Fri</td><td>08:00</td></tr>
        <tr><td>Kathleen</td><td>Cannon</td><td>Fri</td><td>08:00</td></tr>
    </table>
</div>

<h2>Ejercicios de SQL por tema</h2>
<p>
    Por ahora la base University tiene {$TasksCount} ejercicios, y se están añadiendo más. Las soluciones se comprueban automáticamente en un MariaDB real.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la base University:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de University →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar MariaDB para usar University?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, University está disponible en MariaDB 11.8.</p>
    <h3>¿Qué funciones de MariaDB usa?</h3>
    <p>Columnas JSON, tipos ENUM y SET, índices FULLTEXT, columnas VECTOR para embeddings, vistas y una jerarquía de departamentos para consultas recursivas.</p>
    <h3>¿Se pueden modificar los datos?</h3>
    <p>En el playground la base es de solo lectura, para que todos vean los mismos datos. Para practicar INSERT, UPDATE y DELETE en tus propias tablas, elige una versión normal de MariaDB en el playground.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar MariaDB para usar University?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, University está disponible en MariaDB 11.8."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Qué funciones de MariaDB usa?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Columnas JSON, tipos ENUM y SET, índices FULLTEXT, columnas VECTOR para embeddings, vistas y una jerarquía de departamentos para consultas recursivas."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿Se pueden modificar los datos?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "En el playground la base es de solo lectura, para que todos vean los mismos datos. Para practicar INSERT, UPDATE y DELETE en tus propias tablas, elige una versión normal de MariaDB en el playground."{rdelim}{rdelim}
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
