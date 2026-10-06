{* Texte de la page /fr/database/sakila (Controller::database(), structure database.tpl).
   Nombres de lignes vérifiés sur la base du bac à sable mysql80_sakila. *}
<h1>Base de données Sakila : schéma, tables et exercices SQL</h1>
<p class="db-lead">
    Sakila est la base de données d'exemple de MySQL qui décrit un réseau de magasins de location de films en DVD.
    Sur SQLtest.online, vous l'utilisez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tables et 7 vues</li>
    <li><strong>1 000</strong> films</li>
    <li><strong>16 044</strong> locations</li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices Sakila</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Ouvrir Sakila dans le bac à sable</a>
</div>

<h2>Qu'est-ce que Sakila</h2>
<p>
    Sakila a été créée par Mike Hillyer, de l'équipe de documentation de MySQL, pour que les exemples de la documentation et des livres partagent un même schéma réaliste.
    Elle porte le nom de Sakila, le dauphin du logo MySQL, et est distribuée sous licence BSD.
</p>
<p>
    La base modélise une activité ordinaire : un catalogue de films avec acteurs et genres, les clients et le personnel de deux magasins, les locations de disques et les paiements.
    C'est ce qui la rend idéale pour apprendre : les relations se comprennent sans explication, et il y a assez de données pour les regroupements, les fonctions de fenêtrage et l'analyse.
</p>

<h2>Diagramme ER</h2>
<p>Le diagramme montre les tables de Sakila et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
<a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
    {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
    <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données Sakila : tables et relations">Diagramme ER de la base de données Sakila</object>
</a>

<h2>Contenu de la base</h2>
<p>Les tables de Sakila se répartissent en trois groupes.</p>
<div class="db-groups">
    <div>
        <h3>Catalogue de films</h3>
        <p><span class="sql">film</span>, <span class="sql">actor</span>, <span class="sql">category</span>, <span class="sql">language</span> et les tables de liaison <span class="sql">film_actor</span>, <span class="sql">film_category</span>.</p>
    </div>
    <div>
        <h3>Magasins et personnes</h3>
        <p><span class="sql">store</span>, <span class="sql">staff</span>, <span class="sql">customer</span> et les adresses : <span class="sql">address</span> → <span class="sql">city</span> → <span class="sql">country</span>.</p>
    </div>
    <div>
        <h3>Locations et paiements</h3>
        <p><span class="sql">inventory</span> contient les disques de chaque magasin, <span class="sql">rental</span> les locations, <span class="sql">payment</span> les paiements.</p>
    </div>
</div>
<p>
    L'essentiel à retenir : un client loue un disque, pas un film. C'est pourquoi <span class="sql">rental</span> est reliée à <span class="sql">film</span> par <span class="sql">inventory</span>, et non directement.
    La table <span class="sql">film_text</span> est une copie auxiliaire des titres et descriptions pour la recherche en texte intégral.
</p>

<p>Volume de données des principales tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">rental</span></td><td class="num">16 044</td><td>locations de disques</td></tr>
        <tr><td><span class="sql">payment</span></td><td class="num">16 049</td><td>paiements des clients</td></tr>
        <tr><td><span class="sql">film_actor</span></td><td class="num">5 462</td><td>rôles des acteurs dans les films</td></tr>
        <tr><td><span class="sql">inventory</span></td><td class="num">4 581</td><td>disques en magasin</td></tr>
        <tr><td><span class="sql">film</span></td><td class="num">1 000</td><td>films</td></tr>
        <tr><td><span class="sql">customer</span></td><td class="num">599</td><td>clients</td></tr>
        <tr><td><span class="sql">city</span></td><td class="num">600</td><td>villes</td></tr>
        <tr><td><span class="sql">actor</span></td><td class="num">200</td><td>acteurs</td></tr>
        <tr><td><span class="sql">country</span></td><td class="num">109</td><td>pays</td></tr>
        <tr><td><span class="sql">category</span></td><td class="num">16</td><td>genres</td></tr>
        <tr><td><span class="sql">store</span></td><td class="num">2</td><td>magasins</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>Ces requêtes montrent comment les tables sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.</p>

<p><strong>Un film et sa langue</strong> : une relation simple plusieurs-à-un.</p>
<pre><code class="language-sql">SELECT f.title, l.name AS language, f.rental_rate, f.length
FROM film f
JOIN language l ON l.language_id = f.language_id
ORDER BY f.film_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>title</th><th>language</th><th>rental_rate</th><th>length</th></tr>
        <tr><td>ACADEMY DINOSAUR</td><td>English</td><td class="num">0.99</td><td class="num">86</td></tr>
        <tr><td>ACE GOLDFINGER</td><td>English</td><td class="num">4.99</td><td class="num">48</td></tr>
        <tr><td>ADAPTATION HOLES</td><td>English</td><td class="num">2.99</td><td class="num">50</td></tr>
    </table>
</div>

<p><strong>Où habite un client</strong> : une chaîne de quatre tables.</p>
<pre><code class="language-sql">SELECT c.first_name, c.last_name, ci.city, co.country
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
ORDER BY c.customer_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>city</th><th>country</th></tr>
        <tr><td>MARY</td><td>SMITH</td><td>Sasebo</td><td>Japan</td></tr>
        <tr><td>PATRICIA</td><td>JOHNSON</td><td>San Bernardino</td><td>United States</td></tr>
        <tr><td>LINDA</td><td>WILLIAMS</td><td>Athenai</td><td>Greece</td></tr>
    </table>
</div>

<p><strong>Quel film a été loué et combien a été payé</strong> : de la location au film en passant par <span class="sql">inventory</span>.</p>
<pre><code class="language-sql">SELECT r.rental_date, f.title, p.amount
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
JOIN payment p ON p.rental_id = r.rental_id
ORDER BY r.rental_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>rental_date</th><th>title</th><th>amount</th></tr>
        <tr><td>2005-05-24 22:53:30</td><td>BLANKET BEVERLY</td><td class="num">2.99</td></tr>
        <tr><td>2005-05-24 22:54:33</td><td>FREAKY POCUS</td><td class="num">2.99</td></tr>
        <tr><td>2005-05-24 23:03:39</td><td>GRADUATE LORD</td><td class="num">3.99</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    La base Sakila compte {$TasksCount} exercices, des simples requêtes SELECT jusqu'à l'analyse avec des fonctions de fenêtrage. Les solutions sont vérifiées automatiquement sur un vrai serveur MySQL.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices de la section « Base de données Sakila » :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices Sakila →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer MySQL pour utiliser Sakila ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, Sakila est disponible sous MySQL 8.0, MySQL 9.7 et MariaDB 10.</p>
    <h3>Où télécharger la base de données Sakila ?</h3>
    <p>Les fichiers officiels <span class="sql">sakila-schema.sql</span> et <span class="sql">sakila-data.sql</span> se trouvent sur la <a href="https://dev.mysql.com/doc/index-other.html" target="_blank" rel="noopener">page des bases d'exemple de MySQL</a>, et la <a href="https://dev.mysql.com/doc/sakila/en/" target="_blank" rel="noopener">documentation de Sakila</a> les décrit.</p>
    <h3>Existe-t-il une version de Sakila pour PostgreSQL ?</h3>
    <p>Oui, il en existe un portage appelé Pagila. La structure est la même, mais certains types et fonctions sont remplacés par leurs équivalents PostgreSQL.</p>
    <h3>Peut-on modifier les données de Sakila ?</h3>
    <p>Dans le bac à sable, la base est en lecture seule pour que tout le monde voie les mêmes données. Les exercices sur INSERT, UPDATE et DELETE s'exécutent sur une copie temporaire de la table concernée, dont le contenu est ensuite vérifié.</p>
    <h3>Sakila convient-elle pour préparer un entretien SQL ?</h3>
    <p>Oui. Elle permet de s'entraîner facilement aux JOIN, aux regroupements, aux sous-requêtes et aux fonctions de fenêtrage, les sujets les plus demandés en entretien technique.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer MySQL pour utiliser Sakila ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, Sakila est disponible sous MySQL 8.0, MySQL 9.7 et MariaDB 10."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Où télécharger la base de données Sakila ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Les fichiers officiels sakila-schema.sql et sakila-data.sql se trouvent sur la page des bases d'exemple de MySQL (dev.mysql.com/doc/index-other.html), et la documentation de Sakila les décrit."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Existe-t-il une version de Sakila pour PostgreSQL ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Oui, il en existe un portage appelé Pagila. La structure est la même, mais certains types et fonctions sont remplacés par leurs équivalents PostgreSQL."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Peut-on modifier les données de Sakila ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Dans le bac à sable, la base est en lecture seule pour que tout le monde voie les mêmes données. Les exercices sur INSERT, UPDATE et DELETE s'exécutent sur une copie temporaire de la table concernée, dont le contenu est ensuite vérifié."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Sakila convient-elle pour préparer un entretien SQL ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Oui. Elle permet de s'entraîner facilement aux JOIN, aux regroupements, aux sous-requêtes et aux fonctions de fenêtrage, les sujets les plus demandés en entretien technique."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Commencer les exercices</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Ouvrir le bac à sable</a>
</div>
