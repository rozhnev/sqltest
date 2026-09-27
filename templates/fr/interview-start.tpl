{if $InterviewLoginRequired}
    <div style="max-width: 720px; margin: 1rem auto 0; padding: 1rem 1.25rem; border-radius: 12px; background: #FEF3C7; color: #92400E; text-align: center;">
        Connectez-vous pour commencer l'entretien pour le poste et le niveau choisis.
    </div>
{/if}
{if $ActiveInterviewSession}
    <div class="interview-notice">
        Vous avez déjà un entretien non terminé.
        <a class="interview-start-btn" href="/{$Lang}/interview/{$ActiveInterviewSession.id}">Reprendre l'entretien</a>
    </div>
{/if}
<div class="interview-page">
<section class="interview-hero">
    <div class="interview-hero-logo">
        <img src="/images/interview/meridian-logistics-logo.svg" alt="Logo de Meridian Logistics">
    </div>
    <div class="interview-hero-text">
        <h1>Nous sommes Meridian Logistics</h1>
        <p class="interview-hero-tagline">Nous transportons des marchandises. Grâce aux données.</p>
        <p>
            Nous sommes une entreprise de transport de marchandises et de chaîne logistique présente sur trois continents. Chaque jour, notre plateforme suit des milliers d'expéditions, des centaines de transporteurs et un réseau d'entrepôts en pleine croissance — et tout cela repose sur SQL. Pour accompagner notre croissance, nous cherchons des personnes aussi à l'aise avec un JOIN qu'avec un délai de livraison.
        </p>
        <div class="interview-quote">
            <img src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
            <div>
                <blockquote>« Nos entrepôts tournent grâce aux chariots élévateurs. Nos décisions tournent grâce à SQL. »</blockquote>
                <cite>Elena Cho, directrice Données et Ingénierie</cite>
            </div>
        </div>
    </div>
</section>

<p class="interview-disclaimer" role="note"><strong>À noter :</strong> il s'agit d'une simulation d'entraînement, et non d'un véritable entretien d'embauche. Meridian Logistics, ses employés et ses offres d'emploi sont fictifs. Terminer l'entretien ne donne lieu à aucune offre d'emploi ni à aucune forme d'embauche — le résultat et le retour ne sont qu'une auto-évaluation pédagogique de vos compétences SQL.</p>

<h2 style="color:#0F172A; margin-bottom: 1rem;">Postes ouverts</h2>

<section class="interview-positions">
    <article class="interview-position-card">
        <h2>SQL Developer</h2>
        <p>
            Vous concevrez et maintiendrez les bases de données de notre système de gestion des transports — suivi des expéditions, contrats avec les transporteurs, données d'itinéraires et facturation. Au programme : conception de schémas, optimisation de requêtes et collaboration étroite avec l'équipe d'ingénierie qui s'appuie sur votre travail.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>À l'aise pour écrire des requêtes SELECT avec des JOIN et des agrégations.</li>
                    <li>Motivé pour apprendre la conception de schémas et l'indexation.</li>
                    <li>Une première expérience pratique d'une base de données relationnelle (n'importe quel SGBD).</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=2">Commencer l'entretien</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Sait concevoir un schéma normalisé à partir de zéro.</li>
                    <li>Écrit des requêtes efficaces sur des tables de plusieurs millions de lignes.</li>
                    <li>Comprend les compromis de l'indexation et a déjà diagnostiqué une requête lente en production.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=3">Commencer l'entretien</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Porte de bout en bout les décisions d'architecture des bases de données.</li>
                    <li>À l'aise avec l'optimisation de requêtes, le partitionnement et les compromis de la réplication.</li>
                    <li>Accompagne les autres développeurs et s'oppose aux changements de schéma risqués.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=4">Commencer l'entretien</a>
            </div>
        </div>
    </article>

    <article class="interview-position-card">
        <h2>Data Analyst</h2>
        <p>
            Vous transformerez les données brutes d'expéditions et d'entrepôts en réponses : quels itinéraires perdent de l'argent, quels transporteurs sont ponctuels et où installer le prochain entrepôt. Vous travaillerez étroitement avec les équipes opérations et finance pour transformer des requêtes SQL en décisions.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Sait écrire des requêtes SQL avec GROUP BY, HAVING et des fonctions de fenêtrage simples.</li>
                    <li>À l'aise pour traduire une question métier en requête.</li>
                    <li>Une première expérience de présentation de chiffres à un public non technique.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=2">Commencer l'entretien</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Gère des demandes ambiguës venant de plusieurs parties prenantes.</li>
                    <li>Utilise les fonctions de fenêtrage, les CTE et l'optimisation de requêtes pour des rapports récurrents fiables.</li>
                    <li>Sait défendre une méthodologie face à la critique.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=3">Commencer l'entretien</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Définit les standards analytiques suivis par les autres analystes.</li>
                    <li>Porte de bout en bout la définition des métriques.</li>
                    <li>N'hésite pas à remettre en question les hypothèses d'une partie prenante, données à l'appui.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=4">Commencer l'entretien</a>
            </div>
        </div>
    </article>
</section>
</div>
