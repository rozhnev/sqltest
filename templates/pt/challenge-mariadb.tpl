<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · OPEN SOURCE INDIA</p>
    <h1>Desafio MariaDB Foundation<br>e SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">7–8 de outubro de 2026</a>
        · OPEN SOURCE INDIA · NIMHANS Convention Center, Bengaluru · estande da MariaDB Foundation
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
        <span class="hero-note">Quiz MariaDB + tarefas SQL · grande prémio: vale de certificação MariaDB · vencedores notificados por email</span>
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
            <li>Responda a pelo menos 5 perguntas para ganhar um prémio de participação e resolva as tarefas SQL para disputar o grande prémio.</li>
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
            <li>Conclua o quiz, responda a pelo menos 5 perguntas e mostre o resultado no estande para receber um prémio de participação.</li>
            <li>Resolva corretamente as tarefas SQL para disputar o grande prémio.</li>
            <li>Grande prémio: um vale de certificação MariaDB no valor de 150 USD. Os vencedores são notificados por email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Prémios</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Grande prémio</h4>
            <p>Os 3 primeiros vencedores recebem um vale de certificação MariaDB no valor de 150 USD para escolher qualquer um dos nossos cursos.</p>
        </div>
        <div class="prize-card">
            <h4>Prémio de participação</h4>
            <p>Quem responder a pelo menos 5 perguntas ganha um prémio de participação (passe pelo estande para levantar o seu).</p>
        </div>
    </div>
</section>

<section class="mariadb-final">
    <p>
        Se estiver a visitar o OPEN SOURCE INDIA, passe pelo estande da MariaDB Foundation, faça o quiz e teste os seus conhecimentos de MariaDB em pessoa.
        <a class="external-link" href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">
            Saiba mais sobre o OPEN SOURCE INDIA
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

