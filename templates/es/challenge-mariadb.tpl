<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · Percona Live Amsterdam</p>
    <h1>Desafío MariaDB Foundation<br>y SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">9–11 de septiembre de 2026</a>
        · Percona Live, Ámsterdam · stand de MariaDB Foundation
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
        <span class="hero-note">Cuestionario de MariaDB + tareas SQL · ganadores notificados por email · sorteo diario de premios</span>
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
            <li>Gana una pegatina al completar el cuestionario y entra al sorteo diario resolviendo las tareas SQL.</li>
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
            <li>Termina el cuestionario y muestra tu resultado en el stand para recibir una pegatina.</li>
            <li>Resuelve correctamente las tareas SQL para participar en el sorteo diario.</li>
            <li>El sorteo se realiza en el stand a las 17:00 cada día. Premio: una tarjeta de certificación de MariaDB. Los ganadores también reciben notificación por email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Premios</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Cuestionario completado</h4>
            <p>Pegatina de MariaDB en el stand.</p>
        </div>
        <div class="prize-card">
            <h4>Ronda de funciones completada</h4>
            <p>Camiseta oficial de MariaDB para los primeros 50 participantes.</p>
        </div>
        <div class="prize-card">
            <h4>Tareas SQL resueltas correctamente</h4>
            <p>Participación en el sorteo diario de vales de certificación MariaDB.</p>
        </div>
    </div>
    <p class="prize-note">
        Todos los participantes reciben algo. Los mejores obtienen más, y los ganadores también pueden ser contactados por email si no están presentes en el stand.
    </p>
</section>

<section class="mariadb-final">
    <p>
        Si visitas Percona Live Amsterdam, pásate por el stand de MariaDB Foundation, realiza el cuestionario y comprueba tus conocimientos de MariaDB en persona.
        <a class="external-link" href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">
            Más información sobre Percona Live Amsterdam
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
