<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Day Bruxelles · FOSDEM</p>
    <h1>Défi SQL MariaDB</h1>
    <p class="hero-subtitle">
        <a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">Dimanche 1er février 2026</a>
        · Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 Bruxelles
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Inscription</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Connexion</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Démarrer le quiz</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuer le quiz</a>
            {/if}
        {/if}
        <span class="hero-note">10 questions théoriques &amp; pratiques · des prix pour les 10 premiers à terminer au FOSDEM</span>
    </div>
</section>
<section class="mariadb-highlight">
    <div>
        <h2>Points forts du MariaDB Day Bruxelles</h2>
        <p>
            Le MariaDB Day Bruxelles est une rencontre communautaire d'une journée entière qui réunit mainteneurs, contributeurs, partenaires et utilisateurs pour présenter le présent et l'avenir de MariaDB. 
            C'est l'échauffement parfait avant le parcours MariaDB au sein du FOSDEM.
        </p>
        <ul class="mariadb-list">
            <li>Dernières mises à jour directes des mainteneurs et contributeurs de la Fondation MariaDB.</li>
            <li>Sessions sur le développement de base, le débit de l'Enterprise Server 11.8 et la feuille de route LTS 12.3.</li>
            <li>Plongées techniques approfondies dans les API de plugins, RAG, l'intégration de l'IA, l'automatisation et les scénarios de Vector DB.</li>
            <li>Perspectives de la communauté et des partenaires, ainsi que des conversations en personne avec les personnes qui bâtissent MariaDB.</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>Intervenants et thèmes</h3>
        <p>
            Michael Widenius, Nikita Malyavin, Steve Shaw, Jan Lindström, Paul Clevett, Nick Denning, Alejandro Duarte, 
            Dirk Hillbrecht, Andrija Vučinić, Carl Schwan, Roman Agabekov, et plus encore.
        </p>
        <p>
            Les sujets incluent : rencontre avec la 12.3 LTS, débit OLTP dans Enterprise Server 11.8, MariaDB est l'avenir de MySQL, 
            extension de MariaDB avec l'API de plugins, déploiement de RAG sans plomberie, avantages architecturaux de l'IA, automatisation plus sûre 
            et mises à niveau (presque) sans temps d'arrêt.
        </p>
    </div>
</section>
<section class="mariadb-grid">
    {* <article>
        <h3>Format du quiz</h3>
        <p>
            Dix questions sélectionnées qui reflètent l'ordre du jour du MariaDB Day : un mélange d'aperçus théoriques sur la feuille de route de la plateforme 
            et d'exercices pratiques sollicitant l'écriture de requêtes, les migrations et l'automatisation.
        </p>
        <ul class="mariadb-list">
            <li>Cinq vérifications théoriques sur l'architecture, les décisions de publication et la stratégie communautaire.</li>
            <li>Cinq tâches pratiques fondées sur la syntaxe MariaDB, les indices de l'optimiseur et des formes de données réelles.</li>
            <li>Une fenêtre de 3 heures pour soumettre vos réponses, vous permettant de digérer les conférences puis de prouver votre maîtrise.</li>
        </ul>
    </article> *}
    <article>
        <h3>Comment participer</h3>
        <ol class="mariadb-list">
            <li>Obtenez le lien du quiz au stand MariaDB (FOSDEM).
                K niveau 1 (groupe B) https://fosdem.org/2026/stands/
                Scannez le code QR sur notre dépliant.
            </li>
            <li>Répondez au quiz n'importe quand le samedi (31 janvier 2026).
                Vous pouvez le terminer d'un coup ou revenir plus tard dans la journée.
            </li>
            <li>Soumettez vos réponses avant la fin du samedi.
                Seules les participations entièrement soumises comptent.
            </li>
            <li>Répondez correctement à toutes les questions pour participer au tirage au sort.
                Tous ceux ayant un score parfait sont inscrits à la loterie.
            </li>
            <li><a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">Tirage en direct le dimanche à 12h30 (MariaDB Day Bruxelles).</a>
                Nous annoncerons le gagnant pendant le MariaDB Day le 1er février 2026.
                Adresse : Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 Bruxelles – Belgique
            </li>
        </ol>
        {* <p>
            Le quiz se déroule sur notre stand MariaDB Day près du hall du FOSDEM, vous laissant le temps de comparer vos notes avec les intervenants
            en attendant les résultats. Vous pouvez faire une pause sur votre ordinateur portable, consulter le tableau des scores et démarrer une nouvelle série de questions
            avant les pauses des conférences plénières.
        </p>
        <p>
            Tous ceux qui terminent reçoivent un aperçu de leur position par rapport à la communauté et un lien vers le rapport du quiz.
        </p> *}
    </article>
</section>
{* <section class="mariadb-prizes">
    <h2>Prix pour les 10 premiers gagnants</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>De la 1ère à la 3ème place</h4>
            <p>Matériel MariaDB exclusif, livres dédicacés par les architectes et un bon de formation pour la prochaine version.</p>
        </div>
        <div class="prize-card">
            <h4>De la 4ème à la 7ème place</h4>
            <p>Invitations prioritaires aux laboratoires MariaDB, packs de goodies premium et conversations privilégiées avec les ingénieurs.</p>
        </div>
        <div class="prize-card">
            <h4>De la 8ème à la 10ème place</h4>
            <p>Pack de goodies MariaDB, crédits numériques pour l'outillage et une mention lors de la session de clôture.</p>
        </div>
    </div>
    <p class="prize-note">
        Les gagnants seront annoncés sur scène et informés via le tableau de bord du quiz avant la fin de la journée.
    </p>
</section> *}
<section class="mariadb-final">
    <p>
        Apportez votre curiosité, votre ordinateur portable et votre appétit pour MariaDB. {*Le quiz reflète les conférences de l'ordre du jour que vous
        venez d'explorer, vous donnant une chance de gagner des prix tout en célébrant la communauté au FOSDEM.*}
        <a class="external-link" href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">
            En savoir plus sur le MariaDB Day Bruxelles
        </a>
    </p>
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">Inscription</button>
            <button type="button" class="mariadb-button mariadb-login-btn">Connexion</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">Démarrer le quiz</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">Continuer le quiz</a>
            {/if}
        {/if}
</section>
