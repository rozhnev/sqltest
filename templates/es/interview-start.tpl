{if $InterviewLoginRequired}
    <div style="max-width: 720px; margin: 1rem auto 0; padding: 1rem 1.25rem; border-radius: 12px; background: #FEF3C7; color: #92400E; text-align: center;">
        Inicia sesión para empezar la entrevista para el puesto y el nivel elegidos.
    </div>
{/if}
{if $ActiveInterviewSession}
    <div class="interview-notice">
        Ya tienes una entrevista sin terminar.
        <a class="interview-start-btn" href="/{$Lang}/interview/{$ActiveInterviewSession.id}">Continuar la entrevista</a>
    </div>
{/if}
<div class="interview-page">
<section class="interview-hero">
    <div class="interview-hero-logo">
        <img src="/images/interview/meridian-logistics-logo.svg" alt="Logotipo de Meridian Logistics">
    </div>
    <div class="interview-hero-text">
        <h1>Somos Meridian Logistics</h1>
        <p class="interview-hero-tagline">Movemos carga. Impulsados por datos.</p>
        <p>
            Somos una empresa de transporte de mercancías y cadena de suministro presente en tres continentes. Cada día, nuestra plataforma sigue miles de envíos, cientos de transportistas y una red creciente de almacenes, y todo funciona con SQL. A medida que crecemos, buscamos personas que se sientan tan cómodas con un JOIN como con un plazo de entrega.
        </p>
        <div class="interview-quote">
            <img src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
            <div>
                <blockquote>«Nuestros almacenes funcionan con carretillas elevadoras. Nuestras decisiones, con SQL.»</blockquote>
                <cite>Elena Cho, directora de Datos e Ingeniería</cite>
            </div>
        </div>
    </div>
</section>

<p class="interview-disclaimer" role="note"><strong>Ten en cuenta:</strong> esto es una simulación de práctica, no una entrevista de trabajo real. Meridian Logistics, sus empleados y sus vacantes son ficticios. Completar la entrevista no conlleva una oferta de trabajo ni ninguna forma de contratación: el resultado y la valoración son solo una autoevaluación educativa de tus habilidades de SQL.</p>

<h2 style="color:#0F172A; margin-bottom: 1rem;">Vacantes abiertas</h2>

<section class="interview-positions">
    <article class="interview-position-card">
        <h2>SQL Developer</h2>
        <p>
            Diseñarás y mantendrás las bases de datos de nuestro sistema de gestión del transporte: seguimiento de envíos, contratos con transportistas, datos de rutas y facturación. Te esperan el diseño de esquemas, la optimización de consultas y una colaboración estrecha con el equipo de ingeniería que construye sobre lo que entregas.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Escribes con soltura consultas SELECT con JOIN y agregaciones.</li>
                    <li>Tienes ganas de aprender diseño de esquemas e indexación.</li>
                    <li>Algo de experiencia práctica con una base de datos relacional (cualquier SGBD).</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=2">Empezar la entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Sabes diseñar un esquema normalizado desde cero.</li>
                    <li>Escribes consultas eficientes sobre tablas con millones de filas.</li>
                    <li>Entiendes los compromisos de los índices y ya has depurado una consulta lenta en producción.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=3">Empezar la entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Te responsabilizas de principio a fin de las decisiones de arquitectura de bases de datos.</li>
                    <li>Te manejas con soltura en la optimización de consultas, el particionado y los compromisos de la replicación.</li>
                    <li>Orientas a otros desarrolladores y cuestionas los cambios de esquema arriesgados.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=4">Empezar la entrevista</a>
            </div>
        </div>
    </article>

    <article class="interview-position-card">
        <h2>Data Analyst</h2>
        <p>
            Convertirás los datos en bruto de envíos y almacenes en respuestas: qué rutas pierden dinero, qué transportistas son puntuales y dónde debe ir el próximo almacén. Trabajarás de cerca con operaciones y finanzas para convertir consultas SQL en decisiones.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Sabes escribir consultas SQL con GROUP BY, HAVING y funciones de ventana básicas.</li>
                    <li>Conviertes con soltura una pregunta de negocio en una consulta.</li>
                    <li>Algo de experiencia presentando cifras a personas no técnicas.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=2">Empezar la entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Gestionas peticiones ambiguas de varias partes interesadas.</li>
                    <li>Usas funciones de ventana, CTE y optimización de consultas para informes recurrentes fiables.</li>
                    <li>Sabes defender una metodología cuando la cuestionan.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=3">Empezar la entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Creas los estándares analíticos que siguen otros analistas.</li>
                    <li>Te responsabilizas de principio a fin de la definición de las métricas.</li>
                    <li>Cuestionas con datos, sin reparos, las suposiciones de las partes interesadas.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=4">Empezar la entrevista</a>
            </div>
        </div>
    </article>
</section>
</div>
