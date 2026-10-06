{* Texte de la page /fr/database/yellow-tripdata (Controller::database(), structure database.tpl).
   Nombres de lignes et résultats vérifiés sur la base du bac à sable duckdb_data. *}
<h1>Jeu de données NYC Yellow Taxi (DuckDB) : la table yellow_tripdata et des exercices SQL</h1>
<p class="db-lead">
    yellow_tripdata contient les courses des taxis jaunes de New York de janvier 2024, près de 3 millions de lignes, chargées dans DuckDB pour du SQL analytique.
    Sur SQLtest.online, vous les interrogez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>1</strong> table, 19 colonnes</li>
    <li><strong>2 964 624</strong> courses</li>
    <li><strong>janvier 2024</strong> </li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices NYC Yellow Taxi</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir NYC Yellow Taxi dans le bac à sable</a>
    {/if}
</div>

<h2>Qu'est-ce que NYC Yellow Taxi</h2>
<p>
    Les données proviennent des relevés de courses que la Taxi and Limousine Commission de New York (TLC) publie chaque mois. Chaque ligne est une course : heures de prise en charge et de dépose, distance, nombre de passagers, zones de départ et d'arrivée, mode de paiement et chaque composante du prix.
</p>
<p>
    DuckDB est une base analytique embarquée à stockage en colonnes : les agrégations sur des millions de lignes s'exécutent en une fraction de seconde. Le jeu de données se prête donc à une vraie analyse : séries temporelles, distributions, percentiles et nettoyage des données.
</p>

{if $ErdImage}
    <h2>Diagramme ER</h2>
    <p>Le diagramme montre les tables de NYC Yellow Taxi et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données NYC Yellow Taxi">Diagramme ER de la base de données NYC Yellow Taxi</object>
    </a>
{/if}

<h2>Contenu de la base</h2>
<p>
    Toutes les données sont dans une seule table, <span class="sql">yellow_tripdata</span>. Toutes les colonnes acceptent NULL, sans clé ni contrainte. <span class="sql">PULocationID</span> et <span class="sql">DOLocationID</span> sont des numéros de zones de taxi de la TLC. Quelques courses ont une heure de départ hors de janvier 2024 et certaines ont des montants nuls ou négatifs : les vraies données doivent être nettoyées, et certains exercices portent justement là-dessus.
</p>

<p>Volume de données des tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">yellow_tripdata</span></td><td class="num">2 964 624</td><td>courses des taxis jaunes</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>{if $PlaygroundLink}Ces requêtes montrent comment les données sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.{else}Ces requêtes montrent comment les données sont reliées.{/if}</p>

<p><strong>Durée de la course</strong> : <span class="sql">date_diff</span> de DuckDB entre la prise en charge et la dépose.</p>
<pre><code class="language-sql">SELECT tpep_pickup_datetime,
       date_diff('minute', tpep_pickup_datetime, tpep_dropoff_datetime) AS minutes,
       trip_distance, total_amount
FROM yellow_tripdata
WHERE tpep_pickup_datetime &gt;= '2024-01-01'
ORDER BY tpep_pickup_datetime
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>tpep_pickup_datetime</th><th>minutes</th><th>trip_distance</th><th>total_amount</th></tr>
        <tr><td>2024-01-01 00:00:00</td><td class="num">2</td><td class="num">0.3</td><td class="num">11.25</td></tr>
        <tr><td>2024-01-01 00:00:02</td><td class="num">4</td><td class="num">1.57</td><td class="num">16.32</td></tr>
        <tr><td>2024-01-01 00:00:03</td><td class="num">3</td><td class="num">0.5</td><td class="num">7.6</td></tr>
    </table>
</div>

<p><strong>Un comptage rapide</strong> : le <span class="sql">GROUP BY ALL</span> de DuckDB regroupe par toutes les colonnes non agrégées.</p>
<pre><code class="language-sql">SELECT store_and_fwd_flag, COUNT(*) AS trips
FROM yellow_tripdata
GROUP BY ALL
ORDER BY trips DESC;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>store_and_fwd_flag</th><th>trips</th></tr>
        <tr><td>N</td><td class="num">2813126</td></tr>
        <tr><td>NULL</td><td class="num">140162</td></tr>
        <tr><td>Y</td><td class="num">11336</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    Ce jeu de données compte {$TasksCount} exercices, des statistiques globales jusqu'aux séries temporelles et aux contrôles de qualité. Les solutions sont vérifiées automatiquement sur un vrai DuckDB.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices sur la base NYC Yellow Taxi :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices NYC Yellow Taxi →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer DuckDB pour utiliser ce jeu de données ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, choisissez DuckDB.</p>
    <h3>D'où viennent les données ?</h3>
    <p>Des données ouvertes de la Taxi and Limousine Commission de New York (TLC), publiées chaque mois au format Parquet. Cette copie contient les courses des taxis jaunes de janvier 2024.</p>
    <h3>En quoi le SQL de DuckDB est-il différent ?</h3>
    <p>Il est proche de PostgreSQL, avec des ajouts pour l'analyse comme <span class="sql">GROUP BY ALL</span>, <span class="sql">QUALIFY</span>, <span class="sql">date_diff</span> et des fonctions de quantiles.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer DuckDB pour utiliser ce jeu de données ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, choisissez DuckDB."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "D'où viennent les données ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Des données ouvertes de la Taxi and Limousine Commission de New York (TLC), publiées chaque mois au format Parquet. Cette copie contient les courses des taxis jaunes de janvier 2024."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "En quoi le SQL de DuckDB est-il différent ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Il est proche de PostgreSQL, avec des ajouts pour l'analyse comme GROUP BY ALL, QUALIFY, date_diff et des fonctions de quantiles."{rdelim}{rdelim}
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
