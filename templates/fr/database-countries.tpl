{* Texte de la page /fr/database/countries (Controller::database(), structure database.tpl).
   Nombres de lignes et résultats vérifiés sur la base du bac à sable psql17postgis. *}
<h1>Base de données Countries (PostGIS) : tables spatiales et exercices SQL</h1>
<p class="db-lead">
    Countries est une base PostGIS pour apprendre le SQL spatial : pays et capitales du monde, ainsi que des couches de New York avec îlots de recensement, quartiers, rues et stations de métro.
    Sur SQLtest.online, vous l'interrogez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>7</strong> tables spatiales</li>
    <li><strong>246</strong> pays</li>
    <li><strong>491</strong> stations de métro</li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices Countries</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir Countries dans le bac à sable</a>
    {/if}
</div>

<h2>Qu'est-ce que Countries</h2>
<p>
    PostGIS est l'extension de PostgreSQL qui ajoute des types géométriques et des centaines de fonctions spatiales : distances, surfaces, intersections, transformations de coordonnées. Cette base permet de les essayer sur des données familières.
</p>
<p>
    Les tables de New York proviennent du célèbre atelier PostGIS « Introduction to PostGIS », et les tables mondiales contiennent les frontières des pays et les capitales. Ensemble, elles couvrent points, lignes et polygones dans deux systèmes de coordonnées.
</p>

{if $ErdImage}
    <h2>Diagramme ER</h2>
    <p>Le diagramme montre les tables de Countries et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données Countries">Diagramme ER de la base de données Countries</object>
    </a>
{/if}

<h2>Contenu de la base</h2>
<p>Les tables se répartissent en deux groupes.</p>
<div class="db-groups">
    <div>
        <h3>Monde</h3>
        <p><span class="sql">countries</span> avec les polygones des frontières et <span class="sql">capitals</span> avec des points, tous deux en SRID 4326 (longitude et latitude).</p>
    </div>
    <div>
        <h3>New York</h3>
        <p><span class="sql">nyc_census_blocks</span>, <span class="sql">nyc_neighborhoods</span>, <span class="sql">nyc_streets</span>, <span class="sql">nyc_subway_stations</span> et <span class="sql">nyc_homicides</span>, en SRID 26918 (UTM zone 18N, mètres).</p>
    </div>
</div>
<p>
    L'essentiel à retenir : les tables mondiales stockent des degrés, celles de New York des mètres. Dans les couches de New York, distances et surfaces sortent directement en mètres ; pour les tables mondiales, convertissez d'abord en <span class="sql">geography</span> ou transformez la géométrie.
</p>

<p>Volume de données des tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">countries</span></td><td class="num">246</td><td>pays et leurs frontières</td></tr>
        <tr><td><span class="sql">capitals</span></td><td class="num">192</td><td>capitales</td></tr>
        <tr><td><span class="sql">nyc_census_blocks</span></td><td class="num">38 794</td><td>îlots de recensement avec population</td></tr>
        <tr><td><span class="sql">nyc_neighborhoods</span></td><td class="num">129</td><td>quartiers</td></tr>
        <tr><td><span class="sql">nyc_streets</span></td><td class="num">19 091</td><td>rues</td></tr>
        <tr><td><span class="sql">nyc_subway_stations</span></td><td class="num">491</td><td>stations de métro</td></tr>
        <tr><td><span class="sql">nyc_homicides</span></td><td class="num">3 982</td><td>homicides</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>{if $PlaygroundLink}Ces requêtes montrent comment les données sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.{else}Ces requêtes montrent comment les données sont reliées.{/if}</p>

<p><strong>Une capitale dans son pays</strong> : coordonnées du point avec <span class="sql">ST_X</span> / <span class="sql">ST_Y</span> et vérification spatiale avec <span class="sql">ST_Contains</span>.</p>
<pre><code class="language-sql">SELECT c.name AS capital, co.name AS country,
       round(ST_Y(c.location)::numeric, 2) AS lat,
       round(ST_X(c.location)::numeric, 2) AS lon,
       ST_Contains(co.border, c.location) AS inside_border
FROM capitals c
JOIN countries co ON co.id = c.country_id
ORDER BY c.name
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>capital</th><th>country</th><th>lat</th><th>lon</th><th>inside_border</th></tr>
        <tr><td>Abu Dhabi</td><td>United Arab Emirates</td><td class="num">24.30</td><td class="num">54.70</td><td>true</td></tr>
        <tr><td>Abuja</td><td>Nigeria</td><td class="num">9.08</td><td class="num">7.40</td><td>true</td></tr>
        <tr><td>Accra</td><td>Ghana</td><td class="num">5.60</td><td class="num">-0.19</td><td>true</td></tr>
    </table>
</div>

<p><strong>Les stations de métro et leur SRID</strong> : les couches de New York utilisent la projection 26918.</p>
<pre><code class="language-sql">SELECT s.name AS station, s.borough, s.routes, ST_SRID(s.geom) AS srid
FROM nyc_subway_stations s
ORDER BY s.gid
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>station</th><th>borough</th><th>routes</th><th>srid</th></tr>
        <tr><td>Cortlandt St</td><td>Manhattan</td><td>R,W</td><td class="num">26918</td></tr>
        <tr><td>Rector St</td><td>Manhattan</td><td class="num">1</td><td class="num">26918</td></tr>
        <tr><td>South Ferry</td><td>Manhattan</td><td class="num">1</td><td class="num">26918</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    Cette base compte {$TasksCount} exercices PostGIS : distances, surfaces, longueurs, conversions en texte et en JSON, jointures spatiales. Les solutions sont vérifiées automatiquement sur un vrai PostgreSQL avec PostGIS.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices sur la base Countries :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices Countries →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer PostGIS pour utiliser cette base ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, choisissez PostgreSQL 17 + PostGIS WorkShop.</p>
    <h3>Qu'est-ce qu'un SRID ?</h3>
    <p>Un identifiant de système de référence spatiale : il indique dans quel système sont exprimées les coordonnées. 4326 correspond à la longitude et la latitude en degrés (WGS 84) ; 26918 à l'UTM zone 18N en mètres, utilisé pour New York.</p>
    <h3>D'où viennent les tables de New York ?</h3>
    <p>Du jeu de données de l'atelier « Introduction to PostGIS » publié sur postgis.net, un point de départ courant pour apprendre PostGIS.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer PostGIS pour utiliser cette base ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, choisissez PostgreSQL 17 + PostGIS WorkShop."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Qu'est-ce qu'un SRID ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Un identifiant de système de référence spatiale : il indique dans quel système sont exprimées les coordonnées. 4326 correspond à la longitude et la latitude en degrés (WGS 84) ; 26918 à l'UTM zone 18N en mètres, utilisé pour New York."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "D'où viennent les tables de New York ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Du jeu de données de l'atelier « Introduction to PostGIS » publié sur postgis.net, un point de départ courant pour apprendre PostGIS."{rdelim}{rdelim}
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
