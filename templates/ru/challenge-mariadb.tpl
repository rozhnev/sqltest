<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · OPEN SOURCE INDIA</p>
    <h1>Челлендж MariaDB Foundation<br>и SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">7–8 октября 2026</a>
        · OPEN SOURCE INDIA · NIMHANS Convention Center, Бенгалуру · стенд MariaDB Foundation
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
        <span class="hero-note">Квиз по MariaDB + SQL-задачи · главный приз: ваучер на сертификацию MariaDB · победители уведомляются по email</span>
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
            <li>Ответьте хотя бы на 5 вопросов, чтобы получить приз участника, и решите SQL-задачи, чтобы побороться за главный приз.</li>
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
            <li>Пройдите квиз, ответьте хотя бы на 5 вопросов и покажите результат на стенде, чтобы получить приз участника.</li>
            <li>Решите SQL-задачи правильно, чтобы побороться за главный приз.</li>
            <li>Главный приз: ваучер на сертификацию MariaDB стоимостью 150 USD. Победители уведомляются по email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Призы</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Главный приз</h4>
            <p>Первые 3 победителя получат ваучер на сертификацию MariaDB стоимостью 150 USD на любой из наших курсов.</p>
        </div>
        <div class="prize-card">
            <h4>Приз участника</h4>
            <p>Все, кто ответит хотя бы на 5 вопросов, получают приз участника (подойдите к стенду, чтобы забрать его).</p>
        </div>
    </div>
</section>

<section class="mariadb-final">
    <p>
        Если вы приезжаете на OPEN SOURCE INDIA, загляните к стенду MariaDB Foundation, пройдите квиз и проверьте свои знания MariaDB лично.
        <a class="external-link" href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">
            Подробнее про OPEN SOURCE INDIA
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
