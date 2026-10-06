{* Texte de la page /fr/database/adventureworks (Controller::database(), structure database.tpl).
   Nombres de lignes et résultats vérifiés sur la base du bac à sable mssql2022aw. *}
<h1>Base de données AdventureWorks LT : schéma, tables et exercices SQL</h1>
<p class="db-lead">
    AdventureWorks LT est la base d'exemple de Microsoft SQL Server d'un fabricant de vélos : clients, produits, catégories de produits et commandes.
    Sur SQLtest.online, vous l'interrogez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>10</strong> tables principales</li>
    <li><strong>847</strong> clients</li>
    <li><strong>295</strong> produits</li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices AdventureWorks</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir AdventureWorks dans le bac à sable</a>
    {/if}
</div>

<h2>Qu'est-ce que AdventureWorks</h2>
<p>
    AdventureWorks est la base d'exemple que Microsoft fournit pour SQL Server et Azure SQL. Elle décrit Adventure Works Cycles, une entreprise fictive qui fabrique et vend des vélos, des pièces et des accessoires.
</p>
<p>
    Le site utilise AdventureWorks LT, l'édition allégée : la même activité en une dizaine de tables au lieu de plusieurs dizaines. Elle permet de s'entraîner au T-SQL, notamment <span class="sql">TOP</span>, les auto-jointures sur l'arbre des catégories et les relations plusieurs-à-plusieurs.
</p>

{if $ErdImage}
    <h2>Diagramme ER</h2>
    <p>Le diagramme montre les tables de AdventureWorks et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données AdventureWorks">Diagramme ER de la base de données AdventureWorks</object>
    </a>
{/if}

<h2>Contenu de la base</h2>
<p>Les tables se répartissent en trois groupes.</p>
<div class="db-groups">
    <div>
        <h3>Clients</h3>
        <p><span class="sql">Customer</span>, <span class="sql">Address</span> et la table de liaison <span class="sql">CustomerAddress</span>, qui stocke aussi le type d'adresse.</p>
    </div>
    <div>
        <h3>Produits</h3>
        <p><span class="sql">Product</span>, <span class="sql">ProductCategory</span> (un arbre : chaque catégorie peut avoir un parent), <span class="sql">ProductModel</span> et des descriptions en plusieurs langues.</p>
    </div>
    <div>
        <h3>Ventes</h3>
        <p><span class="sql">SalesOrderHeader</span> contient les commandes, <span class="sql">SalesOrderDetail</span> leurs lignes.</p>
    </div>
</div>
<p>
    Les 32 commandes de cette édition sont toutes datées du 1er juin 2008. Les descriptions de produits sont reliées aux modèles par <span class="sql">ProductModelProductDescription</span>, qui stocke aussi la langue (culture) de chaque description. Les tables de service <span class="sql">BuildVersion</span>, <span class="sql">ErrorLog</span> et <span class="sql">sysdiagrams</span> ne sont pas utilisées dans les exercices.
</p>

<p>Volume de données des tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">Customer</span></td><td class="num">847</td><td>clients</td></tr>
        <tr><td><span class="sql">CustomerAddress</span></td><td class="num">417</td><td>liens client ↔ adresse</td></tr>
        <tr><td><span class="sql">Address</span></td><td class="num">450</td><td>adresses</td></tr>
        <tr><td><span class="sql">SalesOrderHeader</span></td><td class="num">32</td><td>commandes</td></tr>
        <tr><td><span class="sql">SalesOrderDetail</span></td><td class="num">542</td><td>lignes de commande</td></tr>
        <tr><td><span class="sql">Product</span></td><td class="num">295</td><td>produits</td></tr>
        <tr><td><span class="sql">ProductCategory</span></td><td class="num">41</td><td>catégories de produits</td></tr>
        <tr><td><span class="sql">ProductModel</span></td><td class="num">128</td><td>modèles de produits</td></tr>
        <tr><td><span class="sql">ProductDescription</span></td><td class="num">762</td><td>descriptions de produits</td></tr>
        <tr><td><span class="sql">ProductModelProductDescription</span></td><td class="num">762</td><td>liens modèle ↔ description par langue</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>{if $PlaygroundLink}Ces requêtes montrent comment les données sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.{else}Ces requêtes montrent comment les données sont reliées.{/if}</p>

<p><strong>Un client et ses adresses</strong> : une relation plusieurs-à-plusieurs via <span class="sql">CustomerAddress</span>.</p>
<pre><code class="language-sql">SELECT TOP 3 c.FirstName, c.LastName, ca.AddressType, a.City
FROM Customer c
JOIN CustomerAddress ca ON ca.CustomerID = c.CustomerID
JOIN Address a ON a.AddressID = ca.AddressID
ORDER BY c.CustomerID;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>FirstName</th><th>LastName</th><th>AddressType</th><th>City</th></tr>
        <tr><td>Catherine</td><td>Abel</td><td>Main Office</td><td>Van Nuys</td></tr>
        <tr><td>Kim</td><td>Abercrombie</td><td>Main Office</td><td>Branch</td></tr>
        <tr><td>Frances</td><td>Adams</td><td>Main Office</td><td>Modesto</td></tr>
    </table>
</div>

<p><strong>Une commande et ses lignes</strong> : de l'en-tête de commande aux produits.</p>
<pre><code class="language-sql">SELECT TOP 3 h.SalesOrderID, h.OrderDate, p.Name, d.OrderQty, d.UnitPrice
FROM SalesOrderHeader h
JOIN SalesOrderDetail d ON d.SalesOrderID = h.SalesOrderID
JOIN Product p ON p.ProductID = d.ProductID
ORDER BY h.SalesOrderID, d.SalesOrderDetailID;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>SalesOrderID</th><th>OrderDate</th><th>Name</th><th>OrderQty</th><th>UnitPrice</th></tr>
        <tr><td class="num">71774</td><td>2008-06-01 00:00:00.000</td><td>ML Road Frame-W - Yellow, 48</td><td class="num">1</td><td class="num">356.8980</td></tr>
        <tr><td class="num">71774</td><td>2008-06-01 00:00:00.000</td><td>ML Road Frame-W - Yellow, 38</td><td class="num">1</td><td class="num">356.8980</td></tr>
        <tr><td class="num">71776</td><td>2008-06-01 00:00:00.000</td><td>Rear Brakes</td><td class="num">1</td><td class="num">63.9000</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    La base AdventureWorks compte {$TasksCount} exercices, des filtres simples jusqu'à l'analyse des commandes et des produits. Les solutions sont vérifiées automatiquement sur un vrai SQL Server.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices sur la base AdventureWorks :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices AdventureWorks →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer SQL Server pour utiliser AdventureWorks ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, AdventureWorks est disponible sous SQL Server 2022.</p>
    <h3>Quelle différence entre AdventureWorks LT et l'AdventureWorks complet ?</h3>
    <p>La base complète compte des dizaines de tables réparties dans plusieurs schémas (Sales, Production, Person et d'autres). L'édition LT garde le cœur de l'activité, clients, produits et commandes, en une dizaine de tables, ce qui facilite l'apprentissage.</p>
    <h3>Quel dialecte SQL utilise-t-on ?</h3>
    <p>Le T-SQL, le dialecte de SQL Server. Par exemple, utilisez <span class="sql">TOP</span> ou <span class="sql">OFFSET … FETCH</span> au lieu de <span class="sql">LIMIT</span>.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer SQL Server pour utiliser AdventureWorks ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, AdventureWorks est disponible sous SQL Server 2022."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Quelle différence entre AdventureWorks LT et l'AdventureWorks complet ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "La base complète compte des dizaines de tables réparties dans plusieurs schémas (Sales, Production, Person et d'autres). L'édition LT garde le cœur de l'activité, clients, produits et commandes, en une dizaine de tables, ce qui facilite l'apprentissage."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Quel dialecte SQL utilise-t-on ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Le T-SQL, le dialecte de SQL Server. Par exemple, utilisez TOP ou OFFSET … FETCH au lieu de LIMIT."{rdelim}{rdelim}
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
