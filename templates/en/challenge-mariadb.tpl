<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · OPEN SOURCE INDIA</p>
    <h1>MariaDB Foundation Challenge<br>and SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">7–8 October 2026</a>
        · OPEN SOURCE INDIA · NIMHANS Convention Center, Bengaluru · MariaDB Foundation booth
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
        <span class="hero-note">MariaDB quiz + SQL tasks · grand prize: MariaDB certification voucher · winners notified by email</span>
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
            <li>Answer at least 5 questions to win a participation prize, and solve the SQL tasks to compete for the grand prize.</li>
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
            <li>Finish the quiz, answer at least 5 questions and show your result at the booth to get a participation prize.</li>
            <li>Solve the SQL tasks correctly to compete for the grand prize.</li>
            <li>Grand Prize: a MariaDB certification voucher worth 150 USD. Winners are notified by email.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Prizes</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Grand prize</h4>
            <p>The first 3 winners will receive a MariaDB certification voucher worth 150 USD to choose any of our courses.</p>
        </div>
        <div class="prize-card">
            <h4>Participation prize</h4>
            <p>Those who answer at least 5 questions win a participation prize (come to the booth to get yours).</p>
        </div>
    </div>
</section>

<section class="mariadb-final">
    <p>
        If you are visiting OPEN SOURCE INDIA, stop by the MariaDB Foundation booth, take the quiz, and test your MariaDB skills in person.
        <a class="external-link" href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">
            Learn more about OPEN SOURCE INDIA
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
