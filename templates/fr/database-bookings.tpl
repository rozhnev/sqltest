{* Texte de la page /fr/database/bookings (Controller::database(), structure database.tpl).
   Nombres de lignes et résultats vérifiés sur la base du bac à sable psql18demo. *}
<h1>Base de données Bookings : schéma aérien, tables et exercices SQL</h1>
<p class="db-lead">
    Bookings est la base de démonstration PostgreSQL d'une compagnie aérienne : vols entre 104 aéroports, réservations, billets et cartes d'embarquement.
    Sur SQLtest.online, vous l'interrogez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>8</strong> tables et 4 vues</li>
    <li><strong>33 121</strong> vols</li>
    <li><strong>1 045 726</strong> segments de billets</li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices Bookings</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir Bookings dans le bac à sable</a>
    {/if}
</div>

<h2>Qu'est-ce que Bookings</h2>
<p>
    Bookings est la base de démonstration que Postgres Professional publie pour apprendre PostgreSQL. Elle modélise les vols d'une compagnie aérienne russe : lignes, avions et plans de cabine, réservations, billets et cartes d'embarquement.
</p>
<p>
    Cette copie contient les vols de juillet à septembre 2017. Les noms des aéroports et des avions sont stockés en JSONB en anglais et en russe, et les coordonnées des aéroports utilisent le type <span class="sql">point</span>. La base convient donc aussi bien aux spécificités de PostgreSQL qu'aux JOIN et à l'analyse sur de grandes tables.
</p>

{if $ErdImage}
    <h2>Diagramme ER</h2>
    <p>Le diagramme montre les tables de Bookings et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données Bookings">Diagramme ER de la base de données Bookings</object>
    </a>
{/if}

<h2>Contenu de la base</h2>
<p>Les tables se répartissent en deux groupes.</p>
<div class="db-groups">
    <div>
        <h3>Données de référence</h3>
        <p><span class="sql">airports_data</span>, <span class="sql">aircrafts_data</span> et <span class="sql">seats</span> : le plan des sièges de chaque modèle d'avion.</p>
    </div>
    <div>
        <h3>Ventes et vols</h3>
        <p><span class="sql">bookings</span> → <span class="sql">tickets</span> → <span class="sql">ticket_flights</span> ← <span class="sql">flights</span>, ainsi que <span class="sql">boarding_passes</span>, émises à l'enregistrement.</p>
    </div>
</div>
<p>
    L'essentiel à retenir : une réservation peut comprendre plusieurs passagers, et un billet peut couvrir plusieurs vols. Le lien entre billets et vols est <span class="sql">ticket_flights</span>, la plus grande table. Les vues <span class="sql">aircrafts</span>, <span class="sql">airports</span>, <span class="sql">flights_v</span> et <span class="sql">routes</span> présentent les mêmes données sous une forme plus pratique.
</p>

<p>Volume de données des tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">bookings</span></td><td class="num">262 788</td><td>réservations</td></tr>
        <tr><td><span class="sql">tickets</span></td><td class="num">366 733</td><td>billets, un par passager</td></tr>
        <tr><td><span class="sql">ticket_flights</span></td><td class="num">1 045 726</td><td>segments de vol des billets</td></tr>
        <tr><td><span class="sql">boarding_passes</span></td><td class="num">579 686</td><td>cartes d'embarquement</td></tr>
        <tr><td><span class="sql">flights</span></td><td class="num">33 121</td><td>vols prévus et effectués</td></tr>
        <tr><td><span class="sql">airports_data</span></td><td class="num">104</td><td>aéroports</td></tr>
        <tr><td><span class="sql">aircrafts_data</span></td><td class="num">9</td><td>modèles d'avions</td></tr>
        <tr><td><span class="sql">seats</span></td><td class="num">1 339</td><td>sièges par modèle d'avion</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>{if $PlaygroundLink}Ces requêtes montrent comment les données sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.{else}Ces requêtes montrent comment les données sont reliées.{/if}</p>

<p><strong>Un billet et sa réservation</strong> : le passager et le montant de la réservation.</p>
<pre><code class="language-sql">SELECT t.ticket_no, t.passenger_name, b.book_date, b.total_amount
FROM tickets t
JOIN bookings b ON b.book_ref = t.book_ref
ORDER BY t.ticket_no
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>passenger_name</th><th>book_date</th><th>total_amount</th></tr>
        <tr><td class="num">0005432000987</td><td>VALERIY TIKHONOV</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000988</td><td>EVGENIYA ALEKSEEVA</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000989</td><td>ARTUR GERASIMOV</td><td>2017-06-28 22:55:00+00</td><td class="num">24700.00</td></tr>
    </table>
</div>

<p><strong>Un vol et son avion</strong> : le nom anglais lu dans une colonne JSONB avec <span class="sql">-&gt;&gt;</span>.</p>
<pre><code class="language-sql">SELECT f.flight_no, f.departure_airport, f.arrival_airport,
       a.model -&gt;&gt; 'en' AS aircraft
FROM flights f
JOIN aircrafts_data a ON a.aircraft_code = f.aircraft_code
ORDER BY f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>flight_no</th><th>departure_airport</th><th>arrival_airport</th><th>aircraft</th></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0404</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
    </table>
</div>

<p><strong>Tarif et siège</strong> : du segment de billet au vol et à la carte d'embarquement. Le LEFT JOIN garde les segments sans carte.</p>
<pre><code class="language-sql">SELECT tf.ticket_no, f.flight_no, tf.fare_conditions, tf.amount, bp.seat_no
FROM ticket_flights tf
JOIN flights f ON f.flight_id = tf.flight_id
LEFT JOIN boarding_passes bp
       ON bp.ticket_no = tf.ticket_no AND bp.flight_id = tf.flight_id
ORDER BY tf.ticket_no, f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>flight_no</th><th>fare_conditions</th><th>amount</th><th>seat_no</th></tr>
        <tr><td class="num">0005432000987</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>7A</td></tr>
        <tr><td class="num">0005432000988</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>10E</td></tr>
        <tr><td class="num">0005432000989</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>18E</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    La base Bookings compte {$TasksCount} exercices, des recherches simples jusqu'à l'analyse sur un million de lignes. Les solutions sont vérifiées automatiquement sur un vrai serveur PostgreSQL.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices sur la base Bookings :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices Bookings →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer PostgreSQL pour utiliser Bookings ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, Bookings est disponible sous PostgreSQL 18.</p>
    <h3>Où télécharger la base de démonstration Bookings ?</h3>
    <p>Postgres Professional la publie en plusieurs tailles sur son site, avec la description du schéma.</p>
    <h3>Pourquoi certains noms sont-ils entre accolades ?</h3>
    <p>Les noms d'aéroports, de villes et d'avions sont des objets JSONB avec des valeurs en anglais et en russe. Utilisez <span class="sql">-&gt;&gt; 'en'</span> pour obtenir le texte anglais, ou interrogez les vues, qui choisissent une langue.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer PostgreSQL pour utiliser Bookings ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, Bookings est disponible sous PostgreSQL 18."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Où télécharger la base de démonstration Bookings ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Postgres Professional la publie en plusieurs tailles sur son site, avec la description du schéma."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Pourquoi certains noms sont-ils entre accolades ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Les noms d'aéroports, de villes et d'avions sont des objets JSONB avec des valeurs en anglais et en russe. Utilisez -&gt;&gt; 'en' pour obtenir le texte anglais, ou interrogez les vues, qui choisissent une langue."{rdelim}{rdelim}
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
