{* Texte de la page /fr/database/employee (Controller::database(), structure database.tpl).
   Nombres de lignes et résultats vérifiés sur la base du bac à sable firebird4_employee. *}
<h1>Base de données Employee (Firebird) : schéma, tables et exercices SQL</h1>
<p class="db-lead">
    Employee est la base d'exemple fournie avec Firebird : employés, services, postes, projets, clients et ventes d'une petite entreprise.
    Sur SQLtest.online, vous l'interrogez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>10</strong> tables et 1 vue</li>
    <li><strong>42</strong> employés</li>
    <li><strong>21</strong> services</li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices Employee</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir Employee dans le bac à sable</a>
    {/if}
</div>

<h2>Qu'est-ce que Employee</h2>
<p>
    Employee est la base d'exemple classique de Firebird, héritée d'InterBase. Elle décrit une petite entreprise internationale : l'arbre des services, le personnel et l'historique des salaires, des projets avec leurs budgets et des ventes aux clients.
</p>
<p>
    La base est petite, les résultats se vérifient donc à l'œil, mais ses relations sont intéressantes : une hiérarchie de services, une clé étrangère composite des employés vers les postes et des liens plusieurs-à-plusieurs entre employés et projets. C'est aussi l'occasion de pratiquer le dialecte SQL de Firebird.
</p>

{if $ErdImage}
    <h2>Diagramme ER</h2>
    <p>Le diagramme montre les tables de Employee et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données Employee">Diagramme ER de la base de données Employee</object>
    </a>
{/if}

<h2>Contenu de la base</h2>
<p>Les tables se répartissent en trois groupes.</p>
<div class="db-groups">
    <div>
        <h3>Personnel</h3>
        <p><span class="sql">EMPLOYEE</span>, <span class="sql">DEPARTMENT</span> (chaque service a un service parent), <span class="sql">JOB</span> et <span class="sql">SALARY_HISTORY</span>.</p>
    </div>
    <div>
        <h3>Projets</h3>
        <p><span class="sql">PROJECT</span>, la table de liaison <span class="sql">EMPLOYEE_PROJECT</span> et les budgets annuels dans <span class="sql">PROJ_DEPT_BUDGET</span>.</p>
    </div>
    <div>
        <h3>Ventes</h3>
        <p><span class="sql">CUSTOMER</span>, <span class="sql">SALES</span> (bons de commande) et <span class="sql">COUNTRY</span> avec les devises.</p>
    </div>
</div>
<p>
    L'essentiel à retenir : un poste est identifié par trois colonnes à la fois (code, grade et pays), la jointure de <span class="sql">EMPLOYEE</span> avec <span class="sql">JOB</span> les utilise donc toutes les trois. La vue <span class="sql">PHONE_LIST</span> associe les employés aux téléphones de leur service.
</p>

<p>Volume de données des tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">EMPLOYEE</span></td><td class="num">42</td><td>employés</td></tr>
        <tr><td><span class="sql">DEPARTMENT</span></td><td class="num">21</td><td>services</td></tr>
        <tr><td><span class="sql">JOB</span></td><td class="num">31</td><td>postes et fourchettes de salaire</td></tr>
        <tr><td><span class="sql">SALARY_HISTORY</span></td><td class="num">49</td><td>évolutions de salaire</td></tr>
        <tr><td><span class="sql">PROJECT</span></td><td class="num">6</td><td>projets</td></tr>
        <tr><td><span class="sql">EMPLOYEE_PROJECT</span></td><td class="num">28</td><td>employés ↔ projets</td></tr>
        <tr><td><span class="sql">PROJ_DEPT_BUDGET</span></td><td class="num">24</td><td>budgets de projet par service et par année</td></tr>
        <tr><td><span class="sql">CUSTOMER</span></td><td class="num">15</td><td>clients</td></tr>
        <tr><td><span class="sql">SALES</span></td><td class="num">33</td><td>bons de commande</td></tr>
        <tr><td><span class="sql">COUNTRY</span></td><td class="num">16</td><td>pays et devises</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>{if $PlaygroundLink}Ces requêtes montrent comment les données sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.{else}Ces requêtes montrent comment les données sont reliées.{/if}</p>

<p><strong>Un employé, son service et son poste</strong> : une jointure sur une clé composite de trois colonnes.</p>
<pre><code class="language-sql">SELECT FIRST 3 e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT, j.JOB_TITLE
FROM EMPLOYEE e
JOIN DEPARTMENT d ON d.DEPT_NO = e.DEPT_NO
JOIN JOB j ON j.JOB_CODE = e.JOB_CODE
          AND j.JOB_GRADE = e.JOB_GRADE
          AND j.JOB_COUNTRY = e.JOB_COUNTRY
ORDER BY e.EMP_NO;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>FIRST_NAME</th><th>LAST_NAME</th><th>DEPARTMENT</th><th>JOB_TITLE</th></tr>
        <tr><td>Robert</td><td>Nelson</td><td>Engineering</td><td>Vice President</td></tr>
        <tr><td>Bruce</td><td>Young</td><td>Software Development</td><td>Engineer</td></tr>
        <tr><td>Kim</td><td>Lambert</td><td>Field Office: East Coast</td><td>Engineer</td></tr>
    </table>
</div>

<p><strong>Commandes et clients</strong> : Firebird limite les lignes avec <span class="sql">FIRST n</span>.</p>
<pre><code class="language-sql">SELECT FIRST 3 s.PO_NUMBER, c.CUSTOMER, s.ORDER_DATE, s.TOTAL_VALUE
FROM SALES s
JOIN CUSTOMER c ON c.CUST_NO = s.CUST_NO
ORDER BY s.ORDER_DATE;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>PO_NUMBER</th><th>CUSTOMER</th><th>ORDER_DATE</th><th>TOTAL_VALUE</th></tr>
        <tr><td>V91E0210</td><td>Central Bank</td><td>1991-03-04 00:00:00</td><td class="num">5000.00</td></tr>
        <tr><td>V92J1003</td><td>MPM Corporation</td><td>1992-07-26 00:00:00</td><td class="num">2985.00</td></tr>
        <tr><td>V92E0340</td><td>Central Bank</td><td>1992-10-15 00:00:00</td><td class="num">70000.00</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    La base Employee compte {$TasksCount} exercices, des sélections simples jusqu'aux fonctions de fenêtrage et à la modification des données. Les solutions sont vérifiées automatiquement sur un vrai serveur Firebird.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices sur la base Employee :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices Employee →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer Firebird pour utiliser Employee ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, Employee est disponible sous Firebird 4.0.</p>
    <h3>D'où vient la base Employee ?</h3>
    <p>Elle est fournie avec Firebird comme base d'exemple (employee.fdb) et remonte à InterBase, le prédécesseur de Firebird.</p>
    <h3>En quoi le SQL de Firebird est-il différent ?</h3>
    <p>La plupart du SQL standard fonctionne normalement. Premières différences rencontrées : <span class="sql">FIRST n</span> / <span class="sql">SKIP n</span> ou <span class="sql">FETCH FIRST n ROWS ONLY</span> pour limiter les lignes, et des noms d'objets en majuscules.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer Firebird pour utiliser Employee ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, Employee est disponible sous Firebird 4.0."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "D'où vient la base Employee ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Elle est fournie avec Firebird comme base d'exemple (employee.fdb) et remonte à InterBase, le prédécesseur de Firebird."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "En quoi le SQL de Firebird est-il différent ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "La plupart du SQL standard fonctionne normalement. Premières différences rencontrées : FIRST n / SKIP n ou FETCH FIRST n ROWS ONLY pour limiter les lignes, et des noms d'objets en majuscules."{rdelim}{rdelim}
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
