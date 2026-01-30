<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Day Brussels · FOSDEM</p>
    <h1>MariaDB SQL Challenge</h1>
    <p class="hero-subtitle">
        <a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">Sunday, February 1, 2026</a>
        · Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 Brussels
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Registration</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Login</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Start quiz</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continue quiz</a>
            {/if}
        {/if}
        <span class="hero-note">10 theoretical &amp; practical questions · prizes for the first 10 finishers at FOSDEM</span>
    </div>
</section>
<section class="mariadb-highlight">
    <div>
        <h2>MariaDB Day Brussels highlights</h2>
        <p>
            MariaDB Day Brussels is a full-day community gathering that brings maintainers, contributors, partners, and users together to show the present and future of MariaDB. 
            It is the perfect warm-up for the MariaDB track inside FOSDEM.
        </p>
        <ul class="mariadb-list">
            <li>Latest updates directly from MariaDB Foundation maintainers and contributors.</li>
            <li>Sessions on core development, Enterprise Server 11.8 throughput, and the 12.3 LTS roadmap.</li>
            <li>Technical deep dives into plugin APIs, RAG, AI integration, automation, and Vector DB scenarios.</li>
            <li>Community and partner perspectives plus in-person conversations with the people who build MariaDB.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>Speakers and focus</h3>
        <p>
            Michael Widenius, Nikita Malyavin, Steve Shaw, Jan Lindström, Paul Clevett, Nick Denning, Alejandro Duarte, 
            Dirk Hillbrecht, Andrija Vučinić, Carl Schwan, Roman Agabekov, and more.
        </p>
        <p>
            Topics include Meet 12.3 LTS, OLTP throughput in Enterprise Server 11.8, MariaDB is the Future of MySQL, 
            extending MariaDB with the plugin API, deploying RAG without the plumbing, architectural AI advantages, safer automation, 
            and (almost) no downtime upgrades.
        </p>
    </div>
</section>
<section class="mariadb-grid">
    {* <article>
        <h3>Quiz format</h3>
        <p>
            Ten curated questions that mirror the MariaDB Day agenda: a mix of theoretical insights about the platform's 
            roadmap and practical exercises that exercise query writing, migrations, and automation.
        </p>
        <ul class="mariadb-list">
            <li>Five theory checks on architecture, release decisions, and community strategy.</li>
            <li>Five hands-on tasks that run against MariaDB syntax, optimizer hints, and real-world data shapes.</li>
            <li>A 3-hour window to submit answers, letting you digest the conference talks and then prove mastery.</li>
        </ul>
    </article> *}
    <article>
        <h3>How to participate</h3>
        <ol class="mariadb-list">
            <li>Get the quiz link at the MariaDB stand (FOSDEM).
                K level 1 (group B) https://fosdem.org/2026/stands/
                Scan the QR code on our flyer.
            </li>
            <li>Answer the quiz any time on Saturday (31 January 2026).
                You can complete it in one go or come back later that day.
            </li>
            <li>Submit your answers before the end of Saturday.
                Only fully submitted entries count.
            </li>
            <li>Get all questions correct to enter the prize draw.
                Everyone with a perfect score is entered into the lottery.
            </li>
            <li><a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">Live draw on Sunday at 12:30 (MariaDB Day Brussels).</a>
                We’ll announce the winner during MariaDB Day on 1 February 2026.
                Address: Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 Brussels – Belgium
            </li>
        </ol>
        {* <p>
            The quiz runs on our MariaDB Day booth near the FOSDEM hall, giving you time to compare notes with speakers
            while you wait for results. You can pause on your laptop, check the scoreboard, and start a fresh question set
            before the keynote breaks.
        </p>
        <p>
            Everyone who finishes gets a snapshot of how they stack up against the community and a link to the quiz report.
        </p> *}
    </article>
</section>
{* <section class="mariadb-prizes">
    <h2>Prizes for the first 10 winners</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>1st–3rd place</h4>
            <p>Exclusive MariaDB hardware, signed books from the architects, and a training voucher for the next release.</p>
        </div>
        <div class="prize-card">
            <h4>4th–7th place</h4>
            <p>Priority invites to MariaDB labs, premium swag bundles, and backstage conversations with engineers.</p>
        </div>
        <div class="prize-card">
            <h4>8th–10th place</h4>
            <p>MariaDB swag pack, digital credits for tooling, and a shout-out during the closing session.</p>
        </div>
    </div>
    <p class="prize-note">
        Winners will be announced on stage and notified via the quiz dashboard before the day closes.
    </p>
</section> *}
<section class="mariadb-final">
    <p>
        Bring your curiosity, your laptop, and your appetite for MariaDB. {*The quiz mirrors the talks from the agenda you
        just explored, giving you a chance to win prizes while celebrating the community at FOSDEM.*}
        <a class="external-link" href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">
            Learn more about MariaDB Day Brussels
        </a>
    </p>
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Registration</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Login</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Start quiz</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continue quiz</a>
            {/if}
        {/if}
</section>
