{* Texto de la página /es/database/employee (Controller::database(), estructura database.tpl).
   Recuentos de filas y resultados comprobados en la base del playground firebird4_employee. *}
<h1>Base de datos Employee (Firebird): esquema, tablas y ejercicios de SQL</h1>
<p class="db-lead">
    Employee es la base de ejemplo que viene con Firebird: empleados, departamentos, puestos, proyectos, clientes y ventas de una pequeña empresa.
    En SQLtest.online puedes consultarla directamente en el navegador: resolver ejercicios con corrección automática y ejecutar tus propias consultas en el playground, sin instalar nada.
</p>

<ul class="db-stats">
    <li><strong>10</strong> tablas y 1 vista</li>
    <li><strong>42</strong> empleados</li>
    <li><strong>21</strong> departamentos</li>
    <li><strong>{$TasksCount}</strong> ejercicios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver ejercicios de Employee</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir Employee en el playground</a>
    {/if}
</div>

<h2>Qué es Employee</h2>
<p>
    Employee es la base de ejemplo clásica de Firebird, heredada de InterBase. Describe una pequeña empresa internacional: el árbol de departamentos, el personal y el historial de salarios, proyectos con presupuestos y ventas a clientes.
</p>
<p>
    La base es pequeña, así que los resultados se comprueban a simple vista, pero sus relaciones son interesantes: una jerarquía de departamentos, una clave foránea compuesta de empleados a puestos y relaciones de muchos a muchos entre empleados y proyectos. También sirve para practicar el dialecto SQL de Firebird.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>El diagrama muestra las tablas de Employee y las claves foráneas que las unen. Haz clic para abrirlo a tamaño completo.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER de la base de datos Employee">Diagrama ER de la base de datos Employee</object>
    </a>
{/if}

<h2>Qué contiene la base</h2>
<p>Las tablas se agrupan en tres bloques.</p>
<div class="db-groups">
    <div>
        <h3>Personal</h3>
        <p><span class="sql">EMPLOYEE</span>, <span class="sql">DEPARTMENT</span> (cada departamento tiene uno superior), <span class="sql">JOB</span> y <span class="sql">SALARY_HISTORY</span>.</p>
    </div>
    <div>
        <h3>Proyectos</h3>
        <p><span class="sql">PROJECT</span>, la tabla de relación <span class="sql">EMPLOYEE_PROJECT</span> y los presupuestos anuales en <span class="sql">PROJ_DEPT_BUDGET</span>.</p>
    </div>
    <div>
        <h3>Ventas</h3>
        <p><span class="sql">CUSTOMER</span>, <span class="sql">SALES</span> (pedidos) y <span class="sql">COUNTRY</span> con las monedas.</p>
    </div>
</div>
<p>
    Lo principal: un puesto se identifica con tres columnas a la vez (código, grado y país), por eso la unión de <span class="sql">EMPLOYEE</span> con <span class="sql">JOB</span> necesita las tres. La vista <span class="sql">PHONE_LIST</span> combina los empleados con los teléfonos de sus departamentos.
</p>

<p>Cuántos datos hay en las tablas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabla</th><th>Filas</th><th>Contenido</th></tr>
        <tr><td><span class="sql">EMPLOYEE</span></td><td class="num">42</td><td>empleados</td></tr>
        <tr><td><span class="sql">DEPARTMENT</span></td><td class="num">21</td><td>departamentos</td></tr>
        <tr><td><span class="sql">JOB</span></td><td class="num">31</td><td>puestos y rangos salariales</td></tr>
        <tr><td><span class="sql">SALARY_HISTORY</span></td><td class="num">49</td><td>cambios de salario</td></tr>
        <tr><td><span class="sql">PROJECT</span></td><td class="num">6</td><td>proyectos</td></tr>
        <tr><td><span class="sql">EMPLOYEE_PROJECT</span></td><td class="num">28</td><td>empleados ↔ proyectos</td></tr>
        <tr><td><span class="sql">PROJ_DEPT_BUDGET</span></td><td class="num">24</td><td>presupuestos de proyectos por departamento y año</td></tr>
        <tr><td><span class="sql">CUSTOMER</span></td><td class="num">15</td><td>clientes</td></tr>
        <tr><td><span class="sql">SALES</span></td><td class="num">33</td><td>pedidos</td></tr>
        <tr><td><span class="sql">COUNTRY</span></td><td class="num">16</td><td>países y monedas</td></tr>
    </table>
</div>

<h2>Estructura de las tablas</h2>
<p>Haz clic en una tabla para ver sus columnas, una fila de ejemplo y sus claves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Consultas de ejemplo</h2>
<p>{if $PlaygroundLink}Estas consultas muestran cómo se relacionan los datos. Copia cualquiera y ejecútala en el <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas muestran cómo se relacionan los datos.{/if}</p>

<p><strong>Un empleado, su departamento y su puesto</strong>: una unión por una clave compuesta de tres columnas.</p>
<pre><code class="language-sql">SELECT FIRST 3 e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT, j.JOB_TITLE
FROM EMPLOYEE e
JOIN DEPARTMENT d ON d.DEPT_NO = e.DEPT_NO
JOIN JOB j ON j.JOB_CODE = e.JOB_CODE
          AND j.JOB_GRADE = e.JOB_GRADE
          AND j.JOB_COUNTRY = e.JOB_COUNTRY
ORDER BY e.EMP_NO;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>FIRST_NAME</th><th>LAST_NAME</th><th>DEPARTMENT</th><th>JOB_TITLE</th></tr>
        <tr><td>Robert</td><td>Nelson</td><td>Engineering</td><td>Vice President</td></tr>
        <tr><td>Bruce</td><td>Young</td><td>Software Development</td><td>Engineer</td></tr>
        <tr><td>Kim</td><td>Lambert</td><td>Field Office: East Coast</td><td>Engineer</td></tr>
    </table>
</div>

<p><strong>Pedidos y clientes</strong>: Firebird usa <span class="sql">FIRST n</span> para limitar las filas.</p>
<pre><code class="language-sql">SELECT FIRST 3 s.PO_NUMBER, c.CUSTOMER, s.ORDER_DATE, s.TOTAL_VALUE
FROM SALES s
JOIN CUSTOMER c ON c.CUST_NO = s.CUST_NO
ORDER BY s.ORDER_DATE;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>PO_NUMBER</th><th>CUSTOMER</th><th>ORDER_DATE</th><th>TOTAL_VALUE</th></tr>
        <tr><td>V91E0210</td><td>Central Bank</td><td>1991-03-04 00:00:00</td><td class="num">5000.00</td></tr>
        <tr><td>V92J1003</td><td>MPM Corporation</td><td>1992-07-26 00:00:00</td><td class="num">2985.00</td></tr>
        <tr><td>V92E0340</td><td>Central Bank</td><td>1992-10-15 00:00:00</td><td class="num">70000.00</td></tr>
    </table>
</div>

<h2>Ejercicios de SQL por tema</h2>
<p>
    La base Employee tiene {$TasksCount} ejercicios, desde selecciones sencillas hasta funciones de ventana y modificación de datos. Las soluciones se comprueban automáticamente en un Firebird real.
    El número de la derecha es la cantidad de ejercicios del tema; los puntos de color muestran el rango de dificultad.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por dónde empezar</h2>
    <p>Los primeros ejercicios de la base Employee:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos los ejercicios de Employee →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Preguntas frecuentes</h2>
    <h3>¿Hay que instalar Firebird para usar Employee?</h3>
    <p>No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, Employee está disponible en Firebird 4.0.</p>
    <h3>¿De dónde viene la base Employee?</h3>
    <p>Se distribuye con Firebird como base de ejemplo (employee.fdb) y viene de InterBase, el predecesor de Firebird.</p>
    <h3>¿En qué se diferencia el SQL de Firebird?</h3>
    <p>La mayor parte del SQL estándar funciona como siempre. Las primeras diferencias que encontrarás: <span class="sql">FIRST n</span> / <span class="sql">SKIP n</span> o <span class="sql">FETCH FIRST n ROWS ONLY</span> para limitar filas, y nombres de objetos en mayúsculas.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "¿Hay que instalar Firebird para usar Employee?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No. Los ejercicios y el playground de SQLtest.online ejecutan las consultas en nuestros servidores, así que basta con un navegador. En el playground, Employee está disponible en Firebird 4.0."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿De dónde viene la base Employee?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Se distribuye con Firebird como base de ejemplo (employee.fdb) y viene de InterBase, el predecesor de Firebird."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "¿En qué se diferencia el SQL de Firebird?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "La mayor parte del SQL estándar funciona como siempre. Las primeras diferencias que encontrarás: FIRST n / SKIP n o FETCH FIRST n ROWS ONLY para limitar filas, y nombres de objetos en mayúsculas."{rdelim}{rdelim}
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
