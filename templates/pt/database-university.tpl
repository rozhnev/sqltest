{* Texto da página /pt/database/university (Controller::database(), estrutura database.tpl).
   Contagens de linhas e resultados verificados no banco do playground mariadb118_university. *}
<h1>Banco de dados University (MariaDB): esquema, tabelas e exercícios de SQL</h1>
<p class="db-lead">
    University é um banco de exemplo do MariaDB sobre uma universidade: departamentos, professores, alunos, cursos, turmas, matrículas, notas e pesquisa.
    No SQLtest.online você consulta o banco direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tabelas e 7 views</li>
    <li><strong>2.000</strong> alunos</li>
    <li><strong>24.981</strong> matrículas</li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no University</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o University no playground</a>
    {/if}
</div>

<h2>O que é o University</h2>
<p>
    University é um banco de exemplo moderno para o MariaDB 11, pensado como uma alternativa mais rica ao clássico Sakila. Ele está normalizado até a terceira forma normal e usa muitos tipos de dados do MariaDB: JSON, ENUM e SET, índices FULLTEXT e colunas VECTOR para embeddings.
</p>
<p>
    Há dados suficientes para análises reais: cerca de 25 mil matrículas, 300 mil notas e um log de auditoria com mais de meio milhão de linhas. Ao mesmo tempo, o tema é familiar para quem já estudou em uma universidade.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>O diagrama mostra as tabelas do University e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados University">Diagrama ER do banco de dados University</object>
    </a>
{/if}

<h2>O que há no banco</h2>
<p>As tabelas se dividem em três grupos.</p>
<div class="db-groups">
    <div>
        <h3>Pessoas e estrutura</h3>
        <p><span class="sql">departments</span> (uma árvore), <span class="sql">faculty</span>, <span class="sql">students</span> e <span class="sql">rooms</span>.</p>
    </div>
    <div>
        <h3>Ensino</h3>
        <p><span class="sql">courses</span> com <span class="sql">course_prerequisites</span>, <span class="sql">semesters</span>, <span class="sql">sections</span>, <span class="sql">enrollments</span> e <span class="sql">grade_events</span>.</p>
    </div>
    <div>
        <h3>Pesquisa e bolsas</h3>
        <p><span class="sql">research_projects</span>, <span class="sql">project_members</span>, <span class="sql">publications</span>, <span class="sql">scholarships</span> e <span class="sql">student_scholarships</span>, além de <span class="sql">audit_log</span>.</p>
    </div>
</div>
<p>
    O ponto principal: o aluno se matricula em uma turma, uma oferta específica do curso no semestre, e não no curso em si. Por isso o caminho do aluno até o curso é <span class="sql">enrollments</span> → <span class="sql">sections</span> → <span class="sql">courses</span>. Sete views, como <span class="sql">v_student_gpa</span> e <span class="sql">v_course_pass_rate</span>, trazem relatórios prontos.
</p>

<p>Quantos dados há nas tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">students</span></td><td class="num">2.000</td><td>alunos</td></tr>
        <tr><td><span class="sql">faculty</span></td><td class="num">250</td><td>professores</td></tr>
        <tr><td><span class="sql">departments</span></td><td class="num">25</td><td>departamentos</td></tr>
        <tr><td><span class="sql">courses</span></td><td class="num">116</td><td>cursos</td></tr>
        <tr><td><span class="sql">course_prerequisites</span></td><td class="num">49</td><td>pré-requisitos dos cursos</td></tr>
        <tr><td><span class="sql">semesters</span></td><td class="num">20</td><td>semestres</td></tr>
        <tr><td><span class="sql">sections</span></td><td class="num">1.715</td><td>turmas de um curso no semestre</td></tr>
        <tr><td><span class="sql">rooms</span></td><td class="num">48</td><td>salas</td></tr>
        <tr><td><span class="sql">enrollments</span></td><td class="num">24.981</td><td>matrículas nas turmas</td></tr>
        <tr><td><span class="sql">grade_events</span></td><td class="num">307.081</td><td>notas de trabalhos e provas</td></tr>
        <tr><td><span class="sql">research_projects</span></td><td class="num">200</td><td>projetos de pesquisa</td></tr>
        <tr><td><span class="sql">project_members</span></td><td class="num">876</td><td>membros dos projetos</td></tr>
        <tr><td><span class="sql">publications</span></td><td class="num">500</td><td>publicações</td></tr>
        <tr><td><span class="sql">scholarships</span></td><td class="num">20</td><td>bolsas</td></tr>
        <tr><td><span class="sql">student_scholarships</span></td><td class="num">773</td><td>bolsas concedidas aos alunos</td></tr>
        <tr><td><span class="sql">audit_log</span></td><td class="num">664.124</td><td>log de alterações</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>{if $PlaygroundLink}Estas consultas mostram como os dados se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas mostram como os dados se relacionam.{/if}</p>

<p><strong>Aluno, curso e nota</strong>: da matrícula, passando pela turma, até o curso e o semestre.</p>
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

<p><strong>Horário de atendimento em JSON</strong>: um valor lido de uma coluna JSON com <span class="sql">JSON_VALUE</span>.</p>
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

<h2>Exercícios de SQL por tema</h2>
<p>
    Por enquanto há {$TasksCount} exercícios no banco University, e novos estão sendo adicionados. As soluções são verificadas automaticamente em um MariaDB real.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios do banco University:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do University →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o MariaDB para usar o University?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o University está disponível no MariaDB 11.8.</p>
    <h3>Quais recursos do MariaDB ele usa?</h3>
    <p>Colunas JSON, tipos ENUM e SET, índices FULLTEXT, colunas VECTOR para embeddings, views e uma hierarquia de departamentos para consultas recursivas.</p>
    <h3>Posso alterar os dados?</h3>
    <p>No playground o banco é somente leitura, para que todos vejam os mesmos dados. Para praticar INSERT, UPDATE e DELETE nas suas próprias tabelas, escolha uma versão comum do MariaDB no playground.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o MariaDB para usar o University?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o University está disponível no MariaDB 11.8."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Quais recursos do MariaDB ele usa?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Colunas JSON, tipos ENUM e SET, índices FULLTEXT, colunas VECTOR para embeddings, views e uma hierarquia de departamentos para consultas recursivas."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Posso alterar os dados?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No playground o banco é somente leitura, para que todos vejam os mesmos dados. Para praticar INSERT, UPDATE e DELETE nas suas próprias tabelas, escolha uma versão comum do MariaDB no playground."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Começar a resolver</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o playground</a>
    {/if}
</div>
