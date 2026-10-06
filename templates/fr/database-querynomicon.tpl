{* Texte de la page /fr/database/querynomicon (Controller::database(), structure database.tpl).
   Nombres de lignes et résultats vérifiés sur la base du bac à sable sqlite3_data. *}
<h1>Base de données Querynomicon (SQLite) : manchots, tables et exercices SQL</h1>
<p class="db-lead">
    Querynomicon est une petite base SQLite pour apprendre le SQL depuis zéro : le jeu de données des manchots de Palmer et un minuscule laboratoire avec son personnel, ses expériences et ses plaques d'analyse.
    Sur SQLtest.online, vous l'interrogez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>13</strong> tables</li>
    <li><strong>344</strong> manchots</li>
    <li><strong>50</strong> expériences</li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices Querynomicon</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir Querynomicon dans le bac à sable</a>
    {/if}
</div>

<h2>Qu'est-ce que Querynomicon</h2>
<p>
    La base provient du Querynomicon, le tutoriel gratuit de Greg Wilson « An Introduction to SQL for Wary Data Scientists ». Sa table principale contient les manchots de Palmer : les mesures de 344 manchots de trois espèces vivant sur trois îles de l'Antarctique.
</p>
<p>
    Les données sont peu nombreuses et faciles à lire, mais elles ont les particularités des vraies données : des valeurs manquantes (NULL) dans les mesures et dans la colonne du sexe. La base est donc idéale pour apprendre le filtrage, le tri, le regroupement, la gestion des NULL et les bases du DDL et du DML.
</p>

{if $ErdImage}
    <h2>Diagramme ER</h2>
    <p>Le diagramme montre les tables de Querynomicon et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données Querynomicon">Diagramme ER de la base de données Querynomicon</object>
    </a>
{/if}

<h2>Contenu de la base</h2>
<p>Les tables se répartissent en deux groupes.</p>
<div class="db-groups">
    <div>
        <h3>Manchots</h3>
        <p><span class="sql">penguins</span> avec les 344 oiseaux et <span class="sql">little_penguins</span>, un échantillon de 10 lignes pour des essais rapides.</p>
    </div>
    <div>
        <h3>Laboratoire</h3>
        <p><span class="sql">department</span>, <span class="sql">staff</span>, <span class="sql">experiment</span>, <span class="sql">performed</span> (qui a mené quelle expérience), <span class="sql">plate</span> et <span class="sql">invalidated</span>, ainsi que <span class="sql">machine</span>, <span class="sql">usage</span>, <span class="sql">person</span> et <span class="sql">contact</span>.</p>
    </div>
</div>
<p>
    Les tables de manchots n'ont pas de clés : chaque ligne est un oiseau. Les tables du laboratoire sont reliées par des identifiants numériques, et <span class="sql">performed</span> relie le personnel et les expériences en plusieurs-à-plusieurs.
</p>

<p>Volume de données des tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">penguins</span></td><td class="num">344</td><td>manchots et leurs mesures</td></tr>
        <tr><td><span class="sql">little_penguins</span></td><td class="num">10</td><td>un échantillon de 10 manchots</td></tr>
        <tr><td><span class="sql">department</span></td><td class="num">4</td><td>services</td></tr>
        <tr><td><span class="sql">staff</span></td><td class="num">10</td><td>personnel</td></tr>
        <tr><td><span class="sql">experiment</span></td><td class="num">50</td><td>expériences</td></tr>
        <tr><td><span class="sql">performed</span></td><td class="num">65</td><td>personnel ↔ expériences</td></tr>
        <tr><td><span class="sql">plate</span></td><td class="num">256</td><td>plaques d'analyse</td></tr>
        <tr><td><span class="sql">invalidated</span></td><td class="num">30</td><td>plaques invalidées</td></tr>
        <tr><td><span class="sql">machine</span></td><td class="num">3</td><td>appareils du laboratoire</td></tr>
        <tr><td><span class="sql">person</span></td><td class="num">15</td><td>personnes</td></tr>
        <tr><td><span class="sql">usage</span></td><td class="num">8</td><td>journal d'utilisation des appareils</td></tr>
        <tr><td><span class="sql">contact</span></td><td class="num">8</td><td>contacts</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>{if $PlaygroundLink}Ces requêtes montrent comment les données sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.{else}Ces requêtes montrent comment les données sont reliées.{/if}</p>

<p><strong>Expériences et plaques</strong> : une relation un-à-plusieurs avec LEFT JOIN et comptage.</p>
<pre><code class="language-sql">SELECT e.ident, e.kind, e.started, COUNT(p.ident) AS plates
FROM experiment e
LEFT JOIN plate p ON p.experiment = e.ident
GROUP BY e.ident
ORDER BY e.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ident</th><th>kind</th><th>started</th><th>plates</th></tr>
        <tr><td class="num">1</td><td>calibration</td><td>2023-08-25</td><td class="num">1</td></tr>
        <tr><td class="num">2</td><td>calibration</td><td>2023-02-14</td><td class="num">1</td></tr>
        <tr><td class="num">3</td><td>trial</td><td>2023-02-22</td><td class="num">10</td></tr>
    </table>
</div>

<p><strong>Qui a mené une expérience</strong> : une relation plusieurs-à-plusieurs via <span class="sql">performed</span>.</p>
<pre><code class="language-sql">SELECT s.personal, s.family, e.kind, e.started
FROM performed pf
JOIN staff s ON s.ident = pf.staff
JOIN experiment e ON e.ident = pf.experiment
ORDER BY e.ident, s.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>personal</th><th>family</th><th>kind</th><th>started</th></tr>
        <tr><td>Nitya</td><td>Lal</td><td>calibration</td><td>2023-08-25</td></tr>
        <tr><td>Indrans</td><td>Sridhar</td><td>calibration</td><td>2023-02-14</td></tr>
        <tr><td>Kartik</td><td>Gupta</td><td>trial</td><td>2023-02-22</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    La base Querynomicon compte {$TasksCount} exercices, du premier SELECT jusqu'aux vues, index et triggers. Les solutions sont vérifiées automatiquement sur un vrai SQLite.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices sur la base Querynomicon :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices Querynomicon →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer SQLite pour utiliser Querynomicon ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, choisissez SQLite 3 Preloaded.</p>
    <h3>Que sont les manchots de Palmer ?</h3>
    <p>Un jeu de données pédagogique très utilisé : les mesures de manchots Adélie, à jugulaire et papous relevées à la station Palmer, en Antarctique. Il sert souvent de remplaçant moderne au jeu de données iris.</p>
    <h3>Cette base convient-elle aux débutants ?</h3>
    <p>Oui. Les tables sont petites et le sujet ne demande aucune explication : vous pouvez vous concentrer sur le SQL lui-même, SELECT, WHERE, ORDER BY, GROUP BY et la gestion des NULL.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer SQLite pour utiliser Querynomicon ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, choisissez SQLite 3 Preloaded."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Que sont les manchots de Palmer ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Un jeu de données pédagogique très utilisé : les mesures de manchots Adélie, à jugulaire et papous relevées à la station Palmer, en Antarctique. Il sert souvent de remplaçant moderne au jeu de données iris."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Cette base convient-elle aux débutants ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Oui. Les tables sont petites et le sujet ne demande aucune explication : vous pouvez vous concentrer sur le SQL lui-même, SELECT, WHERE, ORDER BY, GROUP BY et la gestion des NULL."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Commencer les exercices</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir le bac à sable</a>
    {/if}
</div>
