<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · Percona Live Amsterdam</p>
    <h1>Челлендж MariaDB Foundation<br>и SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">9–11 сентября 2026</a>
        · Percona Live, Amsterdam · MariaDB Foundation booth
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Регистрация</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Войти</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Начать викторину</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Продолжить викторину</a>
            {/if}
        {/if}
        <span class="hero-note">Квиз по MariaDB + SQL-задачи · победители уведомляются по email · ежедневный розыгрыш призов</span>
    </div>
</section>

<section class="mariadb-highlight">
    <div>
        <h2>Подумайте, что знаете MariaDB? Докажите это.</h2>
        <p>
            Короткий квиз о фактах, возможностях и особенностях MariaDB, а также три практических SQL-задачи,
            которые вы решаете здесь же и получаете мгновенную проверку. Каждый, кто участвует, получает что-то.
            Лучшие участники получают ещё больше.
        </p>
        <ul class="mariadb-list">
            <li>Проверьте свои знания о возможностях MariaDB, истории и реальных сценариях использования.</li>
            <li>Решайте SQL-задачи на стенде и сразу получайте обратную связь.</li>
            <li>Получите стикер за завершение квиза и примите участие в ежедневном розыгрыше, решив SQL-задачи.</li>
            <li>Можно проходить в любое время во время конференции и вернуться позже, если нужно сделать паузу.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>Практический челлендж</h3>
        <p>
            Квиз объединяет вопросы по MariaDB с реальными SQL-задачами. Он подходит как любопытным участникам,
            так и опытным специалистам по базам данных.
        </p>
        <p>
            Можно зарегистрироваться один раз, продолжить позже и завершить испытание в удобном темпе во время конференции.
        </p>
    </div>
</section>

<section class="mariadb-grid">
    <article>
        <h3>Как участвовать</h3>
        <ol class="mariadb-list">
            <li>Отсканируйте QR-код у стенда MariaDB Foundation или откройте эту страницу на устройстве.</li>
            <li>Зарегистрируйтесь и проходите квиз в любое время во время конференции. Можно сделать паузу и вернуться позже.</li>
            <li>Завершите вопросы квиза и покажите результат на стенде, чтобы получить стикер.</li>
            <li>Решите SQL-задачи правильно, чтобы участвовать в дневном розыгрыше призов.</li>
            <li>Розыгрыш проходит у стенда в 17:00 каждый день. Приз: ваучер на сертификацию MariaDB. Победители также уведомляются по email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Призы</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Квиз завершён</h4>
            <p>Стикер MariaDB на стенде.</p>
        </div>
        <div class="prize-card">
            <h4>Раунд с фичами завершён</h4>
            <p>Фирменная футболка MariaDB для первых 50 участников.</p>
        </div>
        <div class="prize-card">
            <h4>Все SQL-задачи решены правильно</h4>
            <p>Участие в ежедневном розыгрыше ваучера на сертификацию MariaDB.</p>
        </div>
    </div>
    <p class="prize-note">
        Каждый участник получает что-то. Лучшие участники получают больше, а победители, не присутствующие на стенде, могут быть уведомлены по email.
    </p>
</section>

<section class="mariadb-final">
    <p>
        Если вы приезжаете на Percona Live Amsterdam, загляните к стенду MariaDB Foundation, пройдите квиз и проверьте свои знания MariaDB лично.
        <a class="external-link" href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">
            Подробнее про Percona Live Amsterdam
        </a>
    </p>
    <p class="hero-note">
        Ваш email используется для уведомления победителей. Он передаётся MariaDB Foundation для рассылки новостей только если вы отметите соответствующий чекбокс выше. Подробнее — в политике приватности.
    </p>
    {if $User->logged() === false}
        <button type="button" class="mariadb-button mariadb-register-btn">Регистрация</button>
        <button type="button" class="mariadb-button mariadb-login-btn">Войти</button>
    {else}
        {if !$LastTest || $LastTest.closed}
            <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Начать викторину</a>
        {else}
            <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Продолжить викторину</a>
        {/if}
    {/if}
</section>
