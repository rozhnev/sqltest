<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · Percona Live Amsterdam</p>
    <h1>MariaDB Foundation Challenge<br>and SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">9–11 September 2026</a>
        · Percona Live, Amsterdam · MariaDB Foundation booth
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Register</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Log in</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Start quiz</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continue quiz</a>
            {/if}
        {/if}
        <span class="hero-note">MariaDB quiz + SQL tasks · winners notified by email · daily prize draw</span>
    </div>
</section>

<section class="mariadb-highlight">
    <div>
        <h2>Think you know MariaDB? Prove it.</h2>
        <p>
            A short quiz on MariaDB facts, capabilities, and real-world use cases, plus three practical SQL tasks that you solve right here and get checked instantly.
            Everyone who takes part gets something. The best performers get even more.
        </p>
        <ul class="mariadb-list">
            <li>Test your knowledge of MariaDB features, history, and practical use cases.</li>
            <li>Solve SQL tasks on your device and get instant feedback.</li>
            <li>Earn a sticker by completing the quiz and enter the daily prize draw by solving the SQL tasks.</li>
            <li>Play at any time during the conference and return later if you need to pause.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>Hands-on challenge</h3>
        <p>
            The quiz combines MariaDB knowledge checks with real SQL exercises. It suits both curious visitors and experienced database professionals.
        </p>
        <p>
            Register once, continue later during the event, and finish the challenge at your own pace while visiting the conference.
        </p>
    </div>
</section>

<section class="mariadb-grid">
    <article>
        <h3>How to participate</h3>
        <ol class="mariadb-list">
            <li>Scan the QR code at the MariaDB Foundation booth or open this page on your device.</li>
            <li>Register and complete the quiz any time during the conference. You can pause and continue later.</li>
            <li>Finish the quiz and show your result at the booth to receive a sticker.</li>
            <li>Solve the SQL tasks correctly to qualify for the daily prize draw.</li>
            <li>The draw takes place at the booth at 17:00 each day. Prize: a MariaDB certification voucher. Winners are also notified by email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Prizes</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Quiz completed</h4>
            <p>MariaDB sticker at the booth.</p>
        </div>
        <div class="prize-card">
            <h4>Feature round completed</h4>
            <p>Premium sticker.</p>
        </div>
        <div class="prize-card">
            <h4>All SQL tasks solved correctly</h4>
            <p>Entry into the daily MariaDB certification voucher draw.</p>
        </div>
    </div>
    <p class="prize-note">
        Everyone who takes part gets something. The best performers get more, and winners may also be contacted by email if they are not present at the booth.
    </p>
</section>

<section class="mariadb-final">
    <p>
        If you are visiting Percona Live Amsterdam, stop by the MariaDB Foundation booth, take the quiz, and test your MariaDB skills in person.
        <a class="external-link" href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">
            Learn more about Percona Live Amsterdam
        </a>
    </p>
    <p class="hero-note">
        Your email is used to notify prize winners. It is shared with the MariaDB Foundation for its newsletter only if you tick the box above. See the privacy policy for details.
    </p>
    {if $User->logged() === false}
        <button type="button" class="mariadb-button mariadb-register-btn">Register</button>
        <button type="button" class="mariadb-button mariadb-login-btn">Log in</button>
    {else}
        {if !$LastTest || $LastTest.closed}
            <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Start quiz</a>
        {else}
            <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continue quiz</a>
        {/if}
    {/if}
</section>
