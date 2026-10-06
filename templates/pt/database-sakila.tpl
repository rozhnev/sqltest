{* Texto da página /pt/database/sakila (Controller::database(), estrutura database.tpl).
   Contagens de linhas verificadas no banco do playground mysql80_sakila. *}
<h1>Banco de dados Sakila: esquema, tabelas e exercícios de SQL</h1>
<p class="db-lead">
    Sakila é o banco de dados de exemplo do MySQL que descreve uma rede de locadoras de filmes em DVD.
    No SQLtest.online você trabalha com ele direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>16</strong> tabelas e 7 views</li>
    <li><strong>1.000</strong> filmes</li>
    <li><strong>16.044</strong> locações</li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no Sakila</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Abrir o Sakila no playground</a>
</div>

<h2>O que é o Sakila</h2>
<p>
    O Sakila foi criado por Mike Hillyer, da equipe de documentação do MySQL, para que os exemplos da documentação e dos livros usassem um mesmo esquema realista.
    O nome vem de Sakila, o golfinho do logotipo do MySQL, e o banco é distribuído sob a licença BSD.
</p>
<p>
    O banco modela um negócio comum: um catálogo de filmes com atores e gêneros, clientes e funcionários de duas lojas, locações de discos e pagamentos.
    Por isso é ótimo para aprender: os relacionamentos são claros sem explicação, e há dados suficientes para agrupamentos, funções de janela e análises.
</p>

<h2>Diagrama ER</h2>
<p>O diagrama mostra as tabelas do Sakila e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
<a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
    {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
    <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados Sakila: tabelas e seus relacionamentos">Diagrama ER do banco de dados Sakila</object>
</a>

<h2>O que há no banco</h2>
<p>As tabelas do Sakila se dividem em três grupos.</p>
<div class="db-groups">
    <div>
        <h3>Catálogo de filmes</h3>
        <p><span class="sql">film</span>, <span class="sql">actor</span>, <span class="sql">category</span>, <span class="sql">language</span> e as tabelas de ligação <span class="sql">film_actor</span>, <span class="sql">film_category</span>.</p>
    </div>
    <div>
        <h3>Lojas e pessoas</h3>
        <p><span class="sql">store</span>, <span class="sql">staff</span>, <span class="sql">customer</span> e os endereços: <span class="sql">address</span> → <span class="sql">city</span> → <span class="sql">country</span>.</p>
    </div>
    <div>
        <h3>Locações e pagamentos</h3>
        <p><span class="sql">inventory</span> guarda os discos de cada loja, <span class="sql">rental</span> as locações, <span class="sql">payment</span> os pagamentos.</p>
    </div>
</div>
<p>
    O ponto principal: o cliente aluga um disco, não um filme. Por isso <span class="sql">rental</span> se liga a <span class="sql">film</span> através de <span class="sql">inventory</span>, e não diretamente.
    A tabela <span class="sql">film_text</span> é uma cópia auxiliar de títulos e descrições para busca de texto completo.
</p>

<p>Quantos dados há nas principais tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">rental</span></td><td class="num">16.044</td><td>locações de discos</td></tr>
        <tr><td><span class="sql">payment</span></td><td class="num">16.049</td><td>pagamentos de clientes</td></tr>
        <tr><td><span class="sql">film_actor</span></td><td class="num">5.462</td><td>papéis dos atores nos filmes</td></tr>
        <tr><td><span class="sql">inventory</span></td><td class="num">4.581</td><td>discos nas lojas</td></tr>
        <tr><td><span class="sql">film</span></td><td class="num">1.000</td><td>filmes</td></tr>
        <tr><td><span class="sql">customer</span></td><td class="num">599</td><td>clientes</td></tr>
        <tr><td><span class="sql">city</span></td><td class="num">600</td><td>cidades</td></tr>
        <tr><td><span class="sql">actor</span></td><td class="num">200</td><td>atores</td></tr>
        <tr><td><span class="sql">country</span></td><td class="num">109</td><td>países</td></tr>
        <tr><td><span class="sql">category</span></td><td class="num">16</td><td>gêneros</td></tr>
        <tr><td><span class="sql">store</span></td><td class="num">2</td><td>lojas</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>Estas consultas mostram como as tabelas se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.</p>

<p><strong>Um filme e seu idioma</strong>: um relacionamento simples de muitos para um.</p>
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

<p><strong>Onde o cliente mora</strong>: uma cadeia de quatro tabelas.</p>
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

<p><strong>Qual filme foi alugado e quanto foi pago</strong>: da locação ao filme passando por <span class="sql">inventory</span>.</p>
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

<h2>Exercícios de SQL por tema</h2>
<p>
    Há {$TasksCount} exercícios no banco Sakila, de consultas SELECT simples a análises com funções de janela. As soluções são verificadas automaticamente em um MySQL real.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios da seção "Banco de dados Sakila":</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do Sakila →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o MySQL para usar o Sakila?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o Sakila está disponível no MySQL 8.0, no MySQL 9.7 e no MariaDB 10.</p>
    <h3>Onde baixar o banco de dados Sakila?</h3>
    <p>Os arquivos oficiais <span class="sql">sakila-schema.sql</span> e <span class="sql">sakila-data.sql</span> estão na <a href="https://dev.mysql.com/doc/index-other.html" target="_blank" rel="noopener">página de bancos de exemplo do MySQL</a>, e a <a href="https://dev.mysql.com/doc/sakila/en/" target="_blank" rel="noopener">documentação do Sakila</a> os descreve.</p>
    <h3>Existe Sakila para PostgreSQL?</h3>
    <p>Sim, existe uma versão chamada Pagila. A estrutura é a mesma, mas alguns tipos e funções foram trocados pelos equivalentes do PostgreSQL.</p>
    <h3>Posso alterar os dados do Sakila?</h3>
    <p>No playground o banco é somente leitura, para que todos vejam os mesmos dados. Os exercícios de INSERT, UPDATE e DELETE rodam em uma cópia temporária da tabela necessária, e depois o conteúdo dessa cópia é verificado.</p>
    <h3>O Sakila serve para se preparar para entrevistas de SQL?</h3>
    <p>Sim. Com ele é fácil praticar JOINs, agrupamentos, subconsultas e funções de janela, os temas mais cobrados em entrevistas técnicas.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o MySQL para usar o Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o Sakila está disponível no MySQL 8.0, no MySQL 9.7 e no MariaDB 10."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Onde baixar o banco de dados Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Os arquivos oficiais sakila-schema.sql e sakila-data.sql estão na página de bancos de exemplo do MySQL (dev.mysql.com/doc/index-other.html), e a documentação do Sakila os descreve."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Existe Sakila para PostgreSQL?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Sim, existe uma versão chamada Pagila. A estrutura é a mesma, mas alguns tipos e funções foram trocados pelos equivalentes do PostgreSQL."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Posso alterar os dados do Sakila?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "No playground o banco é somente leitura, para que todos vejam os mesmos dados. Os exercícios de INSERT, UPDATE e DELETE rodam em uma cópia temporária da tabela necessária, e depois o conteúdo dessa cópia é verificado."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "O Sakila serve para se preparar para entrevistas de SQL?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Sim. Com ele é fácil praticar JOINs, agrupamentos, subconsultas e funções de janela, os temas mais cobrados em entrevistas técnicas."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Começar a resolver</a>
    {/if}
    <a class="button blue" href="{$PlaygroundLink}">Abrir o playground</a>
</div>
