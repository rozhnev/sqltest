<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · Percona Live Amsterdam</p>
    <h1>Défi MariaDB Foundation<br>et SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">9–11 septembre 2026</a>
        · Percona Live, Amsterdam · stand MariaDB Foundation
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
        <span class="hero-note">Quiz MariaDB + tâches SQL · gagnants informés par e-mail · tirage au sort quotidien</span>
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
            <li>Gagnez un autocollant en terminant le quiz et participez au tirage quotidien en résolvant les tâches SQL.</li>
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
            <li>Terminez le quiz et montrez votre résultat au stand pour recevoir un autocollant.</li>
            <li>Résolvez correctement les tâches SQL pour participer au tirage quotidien.</li>
            <li>Le tirage a lieu au stand à 17:00 chaque jour. Prix : un bon de certification MariaDB. Les gagnants sont aussi informés par e-mail.</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>Prix</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>Quiz terminé</h4>
            <p>Autocollant MariaDB au stand.</p>
        </div>
        <div class="prize-card">
            <h4>Étape des fonctionnalités terminée</h4>
            <p>T-shirt officiel MariaDB pour les 50 premiers participants.</p>
        </div>
        <div class="prize-card">
            <h4>Toutes les tâches SQL résolues correctement</h4>
            <p>Participation au tirage quotidien pour un bon de certification MariaDB.</p>
        </div>
    </div>
    <p class="prize-note">
        Tout le monde reçoit quelque chose. Les meilleurs participants obtiennent plus, et les gagnants peuvent aussi être contactés par e-mail s'ils ne sont pas présents au stand.
    </p>
</section>

<section class="mariadb-final">
    <p>
        Si vous êtes à Percona Live Amsterdam, rendez-vous au stand MariaDB Foundation, passez le quiz et vérifiez vos compétences MariaDB en personne.
        <a class="external-link" href="https://perconalive.com/2026-amsterdam/" target="_blank" rel="noreferrer">
            En savoir plus sur Percona Live Amsterdam
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

