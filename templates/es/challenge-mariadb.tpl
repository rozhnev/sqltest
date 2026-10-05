<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · OPEN SOURCE INDIA</p>
    <h1>Desafío MariaDB Foundation<br>y SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">7–8 de octubre de 2026</a>
        · OPEN SOURCE INDIA · NIMHANS Convention Center, Bengaluru · stand de MariaDB Foundation
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Registrarse</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Iniciar sesión</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Iniciar cuestionario</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuar cuestionario</a>
            {/if}
        {/if}
        <span class="hero-note">Cuestionario de MariaDB + tareas SQL · gran premio: vale de certificación de MariaDB · ganadores notificados por email</span>
    </div>
</section>

<section class="mariadb-highlight">
    <div>
        <h2>¿Crees que conoces MariaDB? Demuéstralo.</h2>
        <p>
            Un breve cuestionario sobre datos, capacidades y casos de uso reales de MariaDB, además de tres tareas prácticas de SQL que resuelves aquí mismo y verificas al instante.
            Todos los participantes reciben algo. Los mejores obtienen aún más.
        </p>
        <ul class="mariadb-list">
            <li>Comprueba tus conocimientos sobre funciones, historia y usos reales de MariaDB.</li>
            <li>Resuelve tareas SQL en el stand y recibe retroalimentación inmediata.</li>
            <li>Responde al menos 5 preguntas para ganar un premio de participación y resuelve las tareas SQL para optar al gran premio.</li>
            <li>Participa en cualquier momento durante la conferencia y vuelve más tarde si necesitas pausar.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>Desafío práctico</h3>
        <p>
            El cuestionario combina pruebas de conocimiento sobre MariaDB con ejercicios reales de SQL. Está pensado tanto para visitantes curiosos como para profesionales de bases de datos con experiencia.
        </p>
        <p>
            Regístrate una sola vez, continúa más tarde durante el evento y termina el reto a tu ritmo mientras visitas la conferencia.
        </p>
    </div>
</section>

<section class="mariadb-grid">
    <article>
        <h3>Cómo participar</h3>
        <ol class="mariadb-list">
            <li>Escanea el código QR en el stand de MariaDB Foundation o abre esta página en tu dispositivo.</li>
            <li>Regístrate y completa el cuestionario en cualquier momento durante la conferencia. Puedes pausar y continuar más tarde.</li>
            <li>Termina el cuestionario, responde al menos 5 preguntas y muestra tu resultado en el stand para obtener un premio de participación.</li>
            <li>Resuelve correctamente las tareas SQL para optar al gran premio.</li>
            <li>Gran premio: un vale de certificación de MariaDB por valor de 150 USD. Los ganadores reciben notificación por email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Premios</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Gran premio</h4>
            <p>Los 3 primeros ganadores recibirán un vale de certificación de MariaDB por valor de 150 USD para elegir cualquiera de nuestros cursos.</p>
        </div>
        <div class="prize-card">
            <h4>Premio de participación</h4>
            <p>Quienes respondan al menos 5 preguntas ganan un premio de participación (pasa por el stand a recoger el tuyo).</p>
        </div>
    </div>
</section>

<section class="mariadb-final">
    <p>
        Si visitas OPEN SOURCE INDIA, pásate por el stand de MariaDB Foundation, realiza el cuestionario y comprueba tus conocimientos de MariaDB en persona.
        <a class="external-link" href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">
            Más información sobre OPEN SOURCE INDIA
        </a>
    </p>
    <p class="hero-note">
        Tu email se utiliza para notificar a los ganadores. Solo se compartirá con MariaDB Foundation para su boletín si marcas la casilla de arriba. Consulta la política de privacidad para más detalles.
    </p>
    {if $User->logged() === false}
        <button type="button" class="mariadb-button mariadb-register-btn">Registrarse</button>
        <button type="button" class="mariadb-button mariadb-login-btn">Iniciar sesión</button>
    {else}
        {if !$LastTest || $LastTest.closed}
            <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Iniciar cuestionario</a>
        {else}
            <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuar cuestionario</a>
        {/if}
    {/if}
</section>
