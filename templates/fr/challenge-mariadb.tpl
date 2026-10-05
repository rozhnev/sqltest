<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · OPEN SOURCE INDIA</p>
    <h1>Défi MariaDB Foundation<br>et SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">7–8 octobre 2026</a>
        · OPEN SOURCE INDIA · NIMHANS Convention Center, Bengaluru · stand MariaDB Foundation
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">S'inscrire</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Connexion</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Démarrer le quiz</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuer le quiz</a>
            {/if}
        {/if}
        <span class="hero-note">Quiz MariaDB + tâches SQL · grand prix : bon de certification MariaDB · gagnants informés par e-mail</span>
    </div>
</section>

<section class="mariadb-highlight">
    <div>
        <h2>Vous pensez connaître MariaDB ? Faites-le voir.</h2>
        <p>
            Un court quiz sur les faits, capacités et usages réels de MariaDB, ainsi que trois tâches SQL pratiques que vous résolvez ici même et vérifiez instantanément.
            Tous les participants reçoivent quelque chose. Les meilleurs obtiennent encore plus.
        </p>
        <ul class="mariadb-list">
            <li>Testez vos connaissances sur les fonctionnalités, l'histoire et les cas d'usage concrets de MariaDB.</li>
            <li>Résolvez des tâches SQL au stand et obtenez un retour immédiat.</li>
            <li>Répondez à au moins 5 questions pour gagner un prix de participation, et résolvez les tâches SQL pour tenter de remporter le grand prix.</li>
            <li>Jouez à tout moment pendant la conférence et revenez plus tard si vous avez besoin de faire une pause.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>Défi pratique</h3>
        <p>
            Le quiz associe des questions sur MariaDB à des exercices SQL réels. Il convient aussi bien aux visiteurs curieux qu'aux professionnels expérimentés des bases de données.
        </p>
        <p>
            Inscrivez-vous une seule fois, poursuivez plus tard pendant l'événement, puis terminez le défi à votre rythme pendant la conférence.
        </p>
    </div>
</section>

<section class="mariadb-grid">
    <article>
        <h3>Comment participer</h3>
        <ol class="mariadb-list">
            <li>Scannez le QR code au stand MariaDB Foundation ou ouvrez cette page sur votre appareil.</li>
            <li>Inscrivez-vous et complétez le quiz à tout moment pendant la conférence. Vous pouvez faire une pause et reprendre plus tard.</li>
            <li>Terminez le quiz, répondez à au moins 5 questions et montrez votre résultat au stand pour obtenir un prix de participation.</li>
            <li>Résolvez correctement les tâches SQL pour tenter de remporter le grand prix.</li>
            <li>Grand prix : un bon de certification MariaDB d'une valeur de 150 USD. Les gagnants sont informés par e-mail.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Prix</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Grand prix</h4>
            <p>Les 3 premiers gagnants recevront un bon de certification MariaDB d'une valeur de 150 USD pour choisir l'un de nos cours.</p>
        </div>
        <div class="prize-card">
            <h4>Prix de participation</h4>
            <p>Ceux qui répondent à au moins 5 questions gagnent un prix de participation (passez au stand pour récupérer le vôtre).</p>
        </div>
    </div>
</section>

<section class="mariadb-final">
    <p>
        Si vous êtes à OPEN SOURCE INDIA, rendez-vous au stand MariaDB Foundation, passez le quiz et vérifiez vos compétences MariaDB en personne.
        <a class="external-link" href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">
            En savoir plus sur OPEN SOURCE INDIA
        </a>
    </p>
    <p class="hero-note">
        Votre e-mail est utilisé pour informer les gagnants. Il est partagé avec MariaDB Foundation pour sa newsletter uniquement si vous cochez la case ci-dessus. Consultez la politique de confidentialité pour plus de détails.
    </p>
    {if $User->logged() === false}
        <button type="button" class="mariadb-button mariadb-register-btn">S'inscrire</button>
        <button type="button" class="mariadb-button mariadb-login-btn">Connexion</button>
    {else}
        {if !$LastTest || $LastTest.closed}
            <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Démarrer le quiz</a>
        {else}
            <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuer le quiz</a>
        {/if}
    {/if}
</section>

