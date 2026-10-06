{* Texte de la page /fr/database/university (Controller::database(), structure database.tpl).
   Nombres de lignes et résultats vérifiés sur la base du bac à sable mariadb118_university. *}
<h1>Base de données University (MariaDB) : schéma, tables et exercices SQL</h1>
<p class="db-lead">
    University est une base d'exemple MariaDB sur une université : départements, enseignants, étudiants, cours, groupes, inscriptions, notes et recherche.
    Sur SQLtest.online, vous l'interrogez directement dans le navigateur : vous résolvez des exercices corrigés automatiquement et exécutez vos propres requêtes dans le bac à sable, sans rien installer.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tables et 7 vues</li>
    <li><strong>2 000</strong> étudiants</li>
    <li><strong>24 981</strong> inscriptions</li>
    <li><strong>{$TasksCount}</strong> exercices SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Résoudre les exercices University</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Ouvrir University dans le bac à sable</a>
    {/if}
</div>

<h2>Qu'est-ce que University</h2>
<p>
    University est une base d'exemple moderne pour MariaDB 11, conçue comme une alternative plus riche à la classique Sakila. Elle est normalisée jusqu'à la troisième forme normale et utilise de nombreux types de données MariaDB : JSON, ENUM et SET, index FULLTEXT et colonnes VECTOR pour les embeddings.
</p>
<p>
    Les données suffisent pour une vraie analyse : environ 25 000 inscriptions, 300 000 notes et un journal d'audit de plus d'un demi-million de lignes. Le sujet reste familier à quiconque a fait des études supérieures.
</p>

{if $ErdImage}
    <h2>Diagramme ER</h2>
    <p>Le diagramme montre les tables de University et les clés étrangères qui les relient. Cliquez pour l'ouvrir en taille réelle.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagramme ER de la base de données University">Diagramme ER de la base de données University</object>
    </a>
{/if}

<h2>Contenu de la base</h2>
<p>Les tables se répartissent en trois groupes.</p>
<div class="db-groups">
    <div>
        <h3>Personnes et structure</h3>
        <p><span class="sql">departments</span> (un arbre), <span class="sql">faculty</span>, <span class="sql">students</span> et <span class="sql">rooms</span>.</p>
    </div>
    <div>
        <h3>Enseignement</h3>
        <p><span class="sql">courses</span> avec <span class="sql">course_prerequisites</span>, <span class="sql">semesters</span>, <span class="sql">sections</span>, <span class="sql">enrollments</span> et <span class="sql">grade_events</span>.</p>
    </div>
    <div>
        <h3>Recherche et bourses</h3>
        <p><span class="sql">research_projects</span>, <span class="sql">project_members</span>, <span class="sql">publications</span>, <span class="sql">scholarships</span> et <span class="sql">student_scholarships</span>, ainsi que <span class="sql">audit_log</span>.</p>
    </div>
</div>
<p>
    L'essentiel à retenir : l'étudiant s'inscrit à un groupe, une session précise d'un cours dans un semestre, et non au cours lui-même. Le chemin de l'étudiant au cours est donc <span class="sql">enrollments</span> → <span class="sql">sections</span> → <span class="sql">courses</span>. Sept vues, comme <span class="sql">v_student_gpa</span> et <span class="sql">v_course_pass_rate</span>, contiennent des rapports tout prêts.
</p>

<p>Volume de données des tables :</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Table</th><th>Lignes</th><th>Contenu</th></tr>
        <tr><td><span class="sql">students</span></td><td class="num">2 000</td><td>étudiants</td></tr>
        <tr><td><span class="sql">faculty</span></td><td class="num">250</td><td>enseignants</td></tr>
        <tr><td><span class="sql">departments</span></td><td class="num">25</td><td>départements</td></tr>
        <tr><td><span class="sql">courses</span></td><td class="num">116</td><td>cours</td></tr>
        <tr><td><span class="sql">course_prerequisites</span></td><td class="num">49</td><td>prérequis des cours</td></tr>
        <tr><td><span class="sql">semesters</span></td><td class="num">20</td><td>semestres</td></tr>
        <tr><td><span class="sql">sections</span></td><td class="num">1 715</td><td>groupes d'un cours dans un semestre</td></tr>
        <tr><td><span class="sql">rooms</span></td><td class="num">48</td><td>salles</td></tr>
        <tr><td><span class="sql">enrollments</span></td><td class="num">24 981</td><td>inscriptions aux groupes</td></tr>
        <tr><td><span class="sql">grade_events</span></td><td class="num">307 081</td><td>notes des devoirs et examens</td></tr>
        <tr><td><span class="sql">research_projects</span></td><td class="num">200</td><td>projets de recherche</td></tr>
        <tr><td><span class="sql">project_members</span></td><td class="num">876</td><td>membres des projets</td></tr>
        <tr><td><span class="sql">publications</span></td><td class="num">500</td><td>publications</td></tr>
        <tr><td><span class="sql">scholarships</span></td><td class="num">20</td><td>bourses</td></tr>
        <tr><td><span class="sql">student_scholarships</span></td><td class="num">773</td><td>bourses attribuées aux étudiants</td></tr>
        <tr><td><span class="sql">audit_log</span></td><td class="num">664 124</td><td>journal des modifications</td></tr>
    </table>
</div>

<h2>Structure des tables</h2>
<p>Cliquez sur une table pour voir ses colonnes, une ligne d'exemple et ses clés.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemples de requêtes</h2>
<p>{if $PlaygroundLink}Ces requêtes montrent comment les données sont reliées. Copiez-en une et exécutez-la dans le <a href="{$PlaygroundLink}">bac à sable</a>.{else}Ces requêtes montrent comment les données sont reliées.{/if}</p>

<p><strong>Un étudiant, un cours et une note</strong> : de l'inscription au cours et au semestre en passant par le groupe.</p>
<pre><code class="language-sql">SELECT s.first_name, s.last_name, c.code, sem.name AS semester, e.final_grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN sections sec ON sec.section_id = e.section_id
JOIN courses c ON c.course_id = sec.course_id
JOIN semesters sem ON sem.semester_id = sec.semester_id
WHERE e.final_grade IS NOT NULL
ORDER BY e.enrollment_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>code</th><th>semester</th><th>final_grade</th></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH111</td><td>Fall 2024</td><td>B+</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>NURS102</td><td>Fall 2024</td><td>B</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH106</td><td>Summer 2024</td><td>B</td></tr>
    </table>
</div>

<p><strong>Heures de permanence en JSON</strong> : une valeur lue dans une colonne JSON avec <span class="sql">JSON_VALUE</span>.</p>
<pre><code class="language-sql">SELECT first_name, last_name,
       JSON_VALUE(office_hours, '$[0].day') AS day,
       JSON_VALUE(office_hours, '$[0].start') AS starts_at
FROM faculty
ORDER BY faculty_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>day</th><th>starts_at</th></tr>
        <tr><td>Danielle</td><td>Johnson</td><td>Tue</td><td>09:00</td></tr>
        <tr><td>Jason</td><td>Hahn</td><td>Fri</td><td>08:00</td></tr>
        <tr><td>Kathleen</td><td>Cannon</td><td>Fri</td><td>08:00</td></tr>
    </table>
</div>

<h2>Exercices SQL par thème</h2>
<p>
    La base University compte pour l'instant {$TasksCount} exercices, et d'autres sont en préparation. Les solutions sont vérifiées automatiquement sur un vrai serveur MariaDB.
    Le nombre à droite indique combien d'exercices compte le thème ; les points colorés montrent la plage de difficulté.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Par où commencer</h2>
    <p>Les premiers exercices sur la base University :</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Tous les exercices University →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Questions fréquentes</h2>
    <h3>Faut-il installer MariaDB pour utiliser University ?</h3>
    <p>Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, University est disponible sous MariaDB 11.8.</p>
    <h3>Quelles fonctionnalités de MariaDB utilise-t-elle ?</h3>
    <p>Des colonnes JSON, les types ENUM et SET, des index FULLTEXT, des colonnes VECTOR pour les embeddings, des vues et une hiérarchie de départements pour les requêtes récursives.</p>
    <h3>Peut-on modifier les données ?</h3>
    <p>Dans le bac à sable, la base est en lecture seule pour que tout le monde voie les mêmes données. Pour pratiquer INSERT, UPDATE et DELETE sur vos propres tables, choisissez une version ordinaire de MariaDB dans le bac à sable.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Faut-il installer MariaDB pour utiliser University ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Non. Les exercices et le bac à sable de SQLtest.online exécutent les requêtes sur nos serveurs : un navigateur suffit. Dans le bac à sable, University est disponible sous MariaDB 11.8."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Quelles fonctionnalités de MariaDB utilise-t-elle ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Des colonnes JSON, les types ENUM et SET, des index FULLTEXT, des colonnes VECTOR pour les embeddings, des vues et une hiérarchie de départements pour les requêtes récursives."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Peut-on modifier les données ?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Dans le bac à sable, la base est en lecture seule pour que tout le monde voie les mêmes données. Pour pratiquer INSERT, UPDATE et DELETE sur vos propres tables, choisissez une version ordinaire de MariaDB dans le bac à sable."{rdelim}{rdelim}
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
