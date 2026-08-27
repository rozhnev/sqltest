<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Day Bruselas · FOSDEM</p>
    <h2>Desafío SQL de MariaDB</h2>
    <p class="hero-subtitle">
        <a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">Domingo, 1 de febrero de 2026</a>
        · Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 Bruselas
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Registro</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Iniciar sesión</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Iniciar cuestionario</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuar cuestionario</a>
            {/if}
        {/if}
        <span class="hero-note">10 preguntas teóricas y prácticas · premios para los primeros 10 finalistas en FOSDEM</span>
    </div>
</section>
<section class="mariadb-highlight">
    <div>
        <h3>Aspectos destacados del MariaDB Day Bruselas</h3>
        <p>
            MariaDB Day Bruselas es un encuentro comunitario de un día completo que reúne a mantenedores, contribuyentes, socios y usuarios para mostrar el presente y futuro de MariaDB. 
            Es el calentamiento perfecto para la pista de MariaDB dentro de FOSDEM.
        </p>
        <ul class="mariadb-list">
            <li>Últimas actualizaciones directamente de los mantenedores y contribuyentes de la Fundación MariaDB.</li>
            <li>Sesiones sobre desarrollo central, rendimiento del Enterprise Server 11.8 y la hoja de ruta del 12.3 LTS.</li>
            <li>Profundizaciones técnicas en APIs de plugins, RAG, integración de IA, automatización y escenarios de Vector DB.</li>
            <li>Perspectivas de la comunidad y socios, además de conversaciones en persona con las personas que construyen MariaDB.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h4>Oradores y enfoque</h4>
        <p>
            Michael Widenius, Nikita Malyavin, Steve Shaw, Jan Lindström, Paul Clevett, Nick Denning, Alejandro Duarte, 
            Dirk Hillbrecht, Andrija Vučinić, Carl Schwan, Roman Agabekov, y más.
        </p>
        <p>
            Los temas incluyen Conocer 12.3 LTS, rendimiento OLTP en Enterprise Server 11.8, MariaDB es el futuro de MySQL, 
            extender MariaDB con la API de plugins, implementar RAG sin la infraestructura, ventajas arquitectónicas de la IA, automatización más segura, 
            y actualizaciones (casi) sin tiempo de inactividad.
        </p>
    </div>
</section>
<section class="mariadb-grid">
    {* <article>
        <h4>Formato del cuestionario</h4>
        <p>
            Diez preguntas curadas que reflejan la agenda del MariaDB Day: una mezcla de conocimientos teóricos sobre la 
            hoja de ruta de la plataforma y ejercicios prácticos que ejercitan la escritura de consultas, migraciones y automatización.
        </p>
        <ul class="mariadb-list">
            <li>Cinco verificaciones teóricas sobre arquitectura, decisiones de lanzamiento y estrategia comunitaria.</li>
            <li>Cinco tareas prácticas que se ejecutan contra la sintaxis de MariaDB, sugerencias del optimizador y formas de datos del mundo real.</li>
            <li>Una ventana de 3 horas para enviar respuestas, permitiéndote digerir las charlas de la conferencia y luego demostrar dominio.</li>
        </ul>
    </article> *}
    <article>
        <h4>Cómo participar</h4>
        <ol class="mariadb-list">
            <li>Obtén el enlace del cuestionario en el stand de MariaDB (FOSDEM).
                K nivel 1 (grupo B) https://fosdem.org/2026/stands/
                Escanea el código QR en nuestro volante.
            </li>
            <li>Responde el cuestionario en cualquier momento del sábado (31 de enero de 2026).
                Puedes completarlo de una vez o volver más tarde ese día.
            </li>
            <li>Envía tus respuestas antes del final del sábado.
                Solo las entradas completamente enviadas cuentan.
            </li>
            <li>Obtén todas las preguntas correctas para participar en el sorteo de premios.
                Todos los que tengan una puntuación perfecta entran en la lotería.
            </li>
            <li><a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">Sorteo en vivo el domingo a las 12:30 (MariaDB Day Bruselas).</a>
                Anunciaremos al ganador durante el MariaDB Day el 1 de febrero de 2026.
                Dirección: Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 Bruselas – Bélgica
            </li>
        </ol>
        {* <p>
            El cuestionario se realiza en nuestro stand de MariaDB Day cerca del salón de FOSDEM, dándote tiempo para comparar notas con los oradores
            mientras esperas los resultados. Puedes pausar en tu laptop, verificar el marcador y comenzar un nuevo conjunto de preguntas
            antes de que comiencen las charlas principales.
        </p>
        <p>
            Todos los que terminen obtienen una instantánea de cómo se comparan con la comunidad y un enlace al informe del cuestionario.
        </p> *}
    </article>
</section>
{* <section class="mariadb-prizes">
    <h3>Premios para los primeros 10 ganadores</h3>
    <div class="prize-grid">
        <div class="prize-card">
            <h5>1.º–3.er lugar</h5>
            <p>Hardware exclusivo de MariaDB, libros firmados por los arquitectos y un vale de capacitación para la próxima versión.</p>
        </div>
        <div class="prize-card">
            <h5>4.º–7.º lugar</h5>
            <p>Invitaciones prioritarias a laboratorios de MariaDB, paquetes de productos premium y conversaciones en privado con ingenieros.</p>
        </div>
        <div class="prize-card">
            <h5>8.º–10.º lugar</h5>
            <p>Paquete de productos de MariaDB, créditos digitales para herramientas y un reconocimiento durante la sesión de clausura.</p>
        </div>
    </div>
    <p class="prize-note">
        Los ganadores serán anunciados en el escenario y notificados a través del panel de control del cuestionario antes de que finalice el día.
    </p>
</section> *}
<section class="mariadb-final">
    <p>
        Trae tu curiosidad, tu laptop y tu apetito por MariaDB. {*El cuestionario refleja las charlas de la agenda que
        acabas de explorar, dándote la oportunidad de ganar premios mientras celebras la comunidad en FOSDEM.*}
        <a class="external-link" href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">
            Aprende más sobre el MariaDB Day Bruselas
        </a>
    </p>
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Registro</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Iniciar sesión</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Iniciar cuestionario</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuar cuestionario</a>
            {/if}
        {/if}
</section>