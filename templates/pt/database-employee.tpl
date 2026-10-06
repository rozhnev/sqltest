{* Texto da página /pt/database/employee (Controller::database(), estrutura database.tpl).
   Contagens de linhas e resultados verificados no banco do playground firebird4_employee. *}
<h1>Banco de dados Employee (Firebird): esquema, tabelas e exercícios de SQL</h1>
<p class="db-lead">
    Employee é o banco de exemplo que acompanha o Firebird: funcionários, departamentos, cargos, projetos, clientes e vendas de uma pequena empresa.
    No SQLtest.online você consulta o banco direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>10</strong> tabelas e 1 view</li>
    <li><strong>42</strong> funcionários</li>
    <li><strong>21</strong> departamentos</li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no Employee</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o Employee no playground</a>
    {/if}
</div>

<h2>O que é o Employee</h2>
<p>
    Employee é o banco de exemplo clássico do Firebird, herdado do InterBase. Ele descreve uma pequena empresa internacional: a árvore de departamentos, os funcionários e o histórico de salários, projetos com orçamentos e vendas a clientes.
</p>
<p>
    O banco é pequeno, então os resultados são fáceis de conferir, mas tem relacionamentos interessantes: uma hierarquia de departamentos, uma chave estrangeira composta de funcionários para cargos e ligações de muitos para muitos entre funcionários e projetos. Também é o lugar para praticar o dialeto SQL do Firebird.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>O diagrama mostra as tabelas do Employee e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados Employee">Diagrama ER do banco de dados Employee</object>
    </a>
{/if}

<h2>O que há no banco</h2>
<p>As tabelas se dividem em três grupos.</p>
<div class="db-groups">
    <div>
        <h3>Pessoal</h3>
        <p><span class="sql">EMPLOYEE</span>, <span class="sql">DEPARTMENT</span> (cada departamento tem um superior), <span class="sql">JOB</span> e <span class="sql">SALARY_HISTORY</span>.</p>
    </div>
    <div>
        <h3>Projetos</h3>
        <p><span class="sql">PROJECT</span>, a tabela de ligação <span class="sql">EMPLOYEE_PROJECT</span> e os orçamentos anuais em <span class="sql">PROJ_DEPT_BUDGET</span>.</p>
    </div>
    <div>
        <h3>Vendas</h3>
        <p><span class="sql">CUSTOMER</span>, <span class="sql">SALES</span> (pedidos) e <span class="sql">COUNTRY</span> com as moedas.</p>
    </div>
</div>
<p>
    O ponto principal: um cargo é identificado por três colunas ao mesmo tempo (código, nível e país), por isso a junção de <span class="sql">EMPLOYEE</span> com <span class="sql">JOB</span> precisa das três. A view <span class="sql">PHONE_LIST</span> combina os funcionários com os telefones dos departamentos.
</p>

<p>Quantos dados há nas tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">EMPLOYEE</span></td><td class="num">42</td><td>funcionários</td></tr>
        <tr><td><span class="sql">DEPARTMENT</span></td><td class="num">21</td><td>departamentos</td></tr>
        <tr><td><span class="sql">JOB</span></td><td class="num">31</td><td>cargos e faixas salariais</td></tr>
        <tr><td><span class="sql">SALARY_HISTORY</span></td><td class="num">49</td><td>alterações salariais</td></tr>
        <tr><td><span class="sql">PROJECT</span></td><td class="num">6</td><td>projetos</td></tr>
        <tr><td><span class="sql">EMPLOYEE_PROJECT</span></td><td class="num">28</td><td>funcionários ↔ projetos</td></tr>
        <tr><td><span class="sql">PROJ_DEPT_BUDGET</span></td><td class="num">24</td><td>orçamentos de projetos por departamento e ano</td></tr>
        <tr><td><span class="sql">CUSTOMER</span></td><td class="num">15</td><td>clientes</td></tr>
        <tr><td><span class="sql">SALES</span></td><td class="num">33</td><td>pedidos</td></tr>
        <tr><td><span class="sql">COUNTRY</span></td><td class="num">16</td><td>países e moedas</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>{if $PlaygroundLink}Estas consultas mostram como os dados se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas mostram como os dados se relacionam.{/if}</p>

<p><strong>Um funcionário, departamento e cargo</strong>: uma junção por chave composta de três colunas.</p>
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

<p><strong>Pedidos e clientes</strong>: o Firebird usa <span class="sql">FIRST n</span> para limitar as linhas.</p>
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

<h2>Exercícios de SQL por tema</h2>
<p>
    Há {$TasksCount} exercícios no banco Employee, de seleções simples a funções de janela e alteração de dados. As soluções são verificadas automaticamente em um Firebird real.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios do banco Employee:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do Employee →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o Firebird para usar o Employee?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o Employee está disponível no Firebird 4.0.</p>
    <h3>De onde vem o banco Employee?</h3>
    <p>Ele acompanha o Firebird como banco de exemplo (employee.fdb) e vem desde o InterBase, o antecessor do Firebird.</p>
    <h3>Em que o SQL do Firebird é diferente?</h3>
    <p>A maior parte do SQL padrão funciona normalmente. As primeiras diferenças que você vai encontrar: <span class="sql">FIRST n</span> / <span class="sql">SKIP n</span> ou <span class="sql">FETCH FIRST n ROWS ONLY</span> para limitar linhas, e nomes de objetos em maiúsculas.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o Firebird para usar o Employee?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o Employee está disponível no Firebird 4.0."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "De onde vem o banco Employee?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Ele acompanha o Firebird como banco de exemplo (employee.fdb) e vem desde o InterBase, o antecessor do Firebird."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Em que o SQL do Firebird é diferente?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "A maior parte do SQL padrão funciona normalmente. As primeiras diferenças que você vai encontrar: FIRST n / SKIP n ou FETCH FIRST n ROWS ONLY para limitar linhas, e nomes de objetos em maiúsculas."{rdelim}{rdelim}
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
