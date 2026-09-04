<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · Percona Live Amsterdam</p>
    <h1>Desafio MariaDB Foundation<br>e SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">9–11 de setembro de 2026</a>
        · Percona Live, Amsterdã · estande da MariaDB Foundation
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Registar</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Entrar</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Começar quiz</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuar quiz</a>
            {/if}
        {/if}
        <span class="hero-note">Quiz MariaDB + tarefas SQL · vencedores notificados por email · sorteio diário de prémios</span>
    </div>
</section>

<section class="mariadb-highlight">
    <div>
        <h2>Acha que conhece MariaDB? Prove.</h2>
        <p>
            Um pequeno quiz sobre factos, capacidades e casos de uso reais do MariaDB, além de três tarefas práticas de SQL que resolve aqui mesmo e valida imediatamente.
            Todos os participantes recebem algo. Os melhores recebem ainda mais.
        </p>
        <ul class="mariadb-list">
            <li>Teste o seu conhecimento sobre funcionalidades, história e casos de uso reais do MariaDB.</li>
            <li>Resolva tarefas SQL no estande e receba feedback imediato.</li>
            <li>Ganhe um autocolante ao concluir o quiz e participe no sorteio diário resolvendo as tarefas SQL.</li>
            <li>Jogue a qualquer momento durante a conferência e volte mais tarde se precisar de fazer uma pausa.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>Desafio prático</h3>
        <p>
            O quiz combina testes de conhecimento sobre MariaDB com exercícios reais de SQL. Serve tanto para visitantes curiosos como para profissionais experientes em bases de dados.
        </p>
        <p>
            Registe-se uma vez, continue mais tarde durante o evento e termine o desafio ao seu ritmo enquanto visita a conferência.
        </p>
    </div>
</section>

<section class="mariadb-grid">
    <article>
        <h3>Como participar</h3>
        <ol class="mariadb-list">
            <li>Digitalize o código QR no estande da MariaDB Foundation ou abra esta página no seu dispositivo.</li>
            <li>Registe-se e complete o quiz em qualquer momento durante a conferência. Pode pausar e continuar mais tarde.</li>
            <li>Conclua o quiz e mostre o resultado no estande para receber um autocolante.</li>
            <li>Responda corretamente às tarefas SQL para participar no sorteio diário.</li>
            <li>O sorteio acontece no estande às 17:00 todos os dias. Prémio: vale de certificação MariaDB. Os vencedores também são notificados por email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Prémios</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Quiz concluído</h4>
            <p>Autocolante MariaDB no estande.</p>
        </div>
        <div class="prize-card">
            <h4>Ronda de funcionalidades concluída</h4>
            <p>Camiseta oficial da MariaDB para os primeiros 50 participantes.</p>
        </div>
        <div class="prize-card">
            <h4>Todas as tarefas SQL resolvidas corretamente</h4>
            <p>Entrada no sorteio diário de vales de certificação MariaDB.</p>
        </div>
    </div>
    <p class="prize-note">
        Todos os participantes recebem algo. Os melhores obtêm mais, e os vencedores podem também ser contactados por email se não estiverem presentes no estande.
    </p>
</section>

<section class="mariadb-final">
    <p>
        Se estiver a visitar o Percona Live Amsterdam, passe pelo estande da MariaDB Foundation, faça o quiz e teste os seus conhecimentos de MariaDB em pessoa.
        <a class="external-link" href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">
            Saiba mais sobre o Percona Live Amsterdam
        </a>
    </p>
    <p class="hero-note">
        O seu email é usado para notificar os vencedores. Só é partilhado com a MariaDB Foundation para a sua newsletter se marcar a caixa acima. Consulte a política de privacidade para mais detalhes.
    </p>
    {if $User->logged() === false}
        <button type="button" class="mariadb-button mariadb-register-btn">Registar</button>
        <button type="button" class="mariadb-button mariadb-login-btn">Entrar</button>
    {else}
        {if !$LastTest || $LastTest.closed}
            <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Começar quiz</a>
        {else}
            <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuar quiz</a>
        {/if}
    {/if}
</section>

