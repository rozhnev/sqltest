{* Texto da página /pt/database/adventureworks (Controller::database(), estrutura database.tpl).
   Contagens de linhas e resultados verificados no banco do playground mssql2022aw. *}
<h1>Banco de dados AdventureWorks LT: esquema, tabelas e exercícios de SQL</h1>
<p class="db-lead">
    AdventureWorks LT é o banco de exemplo do Microsoft SQL Server de um fabricante de bicicletas: clientes, produtos, categorias de produtos e pedidos.
    No SQLtest.online você consulta o banco direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>10</strong> tabelas principais</li>
    <li><strong>847</strong> clientes</li>
    <li><strong>295</strong> produtos</li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no AdventureWorks</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o AdventureWorks no playground</a>
    {/if}
</div>

<h2>O que é o AdventureWorks</h2>
<p>
    AdventureWorks é o banco de exemplo que a Microsoft distribui para o SQL Server e o Azure SQL. Ele descreve a Adventure Works Cycles, uma empresa fictícia que fabrica e vende bicicletas, peças e acessórios.
</p>
<p>
    O site usa o AdventureWorks LT, a edição leve: o mesmo negócio em cerca de dez tabelas em vez de dezenas. É ótimo para praticar T-SQL, incluindo <span class="sql">TOP</span>, autojunções na árvore de categorias e relacionamentos de muitos para muitos.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>O diagrama mostra as tabelas do AdventureWorks e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados AdventureWorks">Diagrama ER do banco de dados AdventureWorks</object>
    </a>
{/if}

<h2>O que há no banco</h2>
<p>As tabelas se dividem em três grupos.</p>
<div class="db-groups">
    <div>
        <h3>Clientes</h3>
        <p><span class="sql">Customer</span>, <span class="sql">Address</span> e a tabela de ligação <span class="sql">CustomerAddress</span>, que também guarda o tipo de endereço.</p>
    </div>
    <div>
        <h3>Produtos</h3>
        <p><span class="sql">Product</span>, <span class="sql">ProductCategory</span> (uma árvore: cada categoria pode ter um pai), <span class="sql">ProductModel</span> e descrições em vários idiomas.</p>
    </div>
    <div>
        <h3>Vendas</h3>
        <p><span class="sql">SalesOrderHeader</span> guarda os pedidos e <span class="sql">SalesOrderDetail</span> os itens.</p>
    </div>
</div>
<p>
    Todos os 32 pedidos desta edição têm a data de 1º de junho de 2008. As descrições dos produtos se ligam aos modelos por <span class="sql">ProductModelProductDescription</span>, que também guarda o idioma (culture) de cada descrição. As tabelas de serviço <span class="sql">BuildVersion</span>, <span class="sql">ErrorLog</span> e <span class="sql">sysdiagrams</span> não são usadas nos exercícios.
</p>

<p>Quantos dados há nas tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">Customer</span></td><td class="num">847</td><td>clientes</td></tr>
        <tr><td><span class="sql">CustomerAddress</span></td><td class="num">417</td><td>ligações cliente ↔ endereço</td></tr>
        <tr><td><span class="sql">Address</span></td><td class="num">450</td><td>endereços</td></tr>
        <tr><td><span class="sql">SalesOrderHeader</span></td><td class="num">32</td><td>pedidos</td></tr>
        <tr><td><span class="sql">SalesOrderDetail</span></td><td class="num">542</td><td>itens dos pedidos</td></tr>
        <tr><td><span class="sql">Product</span></td><td class="num">295</td><td>produtos</td></tr>
        <tr><td><span class="sql">ProductCategory</span></td><td class="num">41</td><td>categorias de produtos</td></tr>
        <tr><td><span class="sql">ProductModel</span></td><td class="num">128</td><td>modelos de produtos</td></tr>
        <tr><td><span class="sql">ProductDescription</span></td><td class="num">762</td><td>descrições de produtos</td></tr>
        <tr><td><span class="sql">ProductModelProductDescription</span></td><td class="num">762</td><td>ligações modelo ↔ descrição por idioma</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>{if $PlaygroundLink}Estas consultas mostram como os dados se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas mostram como os dados se relacionam.{/if}</p>

<p><strong>Um cliente e seus endereços</strong>: ligação de muitos para muitos por <span class="sql">CustomerAddress</span>.</p>
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

<p><strong>Um pedido e seus itens</strong>: do cabeçalho do pedido aos produtos.</p>
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

<h2>Exercícios de SQL por tema</h2>
<p>
    Há {$TasksCount} exercícios no banco AdventureWorks, de filtros simples a análises de pedidos e produtos. As soluções são verificadas automaticamente em um SQL Server real.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios do banco AdventureWorks:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do AdventureWorks →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o SQL Server para usar o AdventureWorks?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o AdventureWorks está disponível no SQL Server 2022.</p>
    <h3>Qual a diferença entre o AdventureWorks LT e o AdventureWorks completo?</h3>
    <p>O banco completo tem dezenas de tabelas em vários esquemas (Sales, Production, Person e outros). A edição LT mantém o núcleo do negócio, clientes, produtos e pedidos, em cerca de dez tabelas, o que facilita o aprendizado.</p>
    <h3>Qual dialeto de SQL é usado?</h3>
    <p>T-SQL, o dialeto do SQL Server. Por exemplo, use <span class="sql">TOP</span> ou <span class="sql">OFFSET … FETCH</span> em vez de <span class="sql">LIMIT</span>.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o SQL Server para usar o AdventureWorks?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o AdventureWorks está disponível no SQL Server 2022."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Qual a diferença entre o AdventureWorks LT e o AdventureWorks completo?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "O banco completo tem dezenas de tabelas em vários esquemas (Sales, Production, Person e outros). A edição LT mantém o núcleo do negócio, clientes, produtos e pedidos, em cerca de dez tabelas, o que facilita o aprendizado."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Qual dialeto de SQL é usado?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "T-SQL, o dialeto do SQL Server. Por exemplo, use TOP ou OFFSET … FETCH em vez de LIMIT."{rdelim}{rdelim}
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
