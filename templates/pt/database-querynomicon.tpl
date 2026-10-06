{* Texto da página /pt/database/querynomicon (Controller::database(), estrutura database.tpl).
   Contagens de linhas e resultados verificados no banco do playground sqlite3_data. *}
<h1>Banco de dados Querynomicon (SQLite): pinguins, tabelas e exercícios de SQL</h1>
<p class="db-lead">
    Querynomicon é um pequeno banco SQLite para aprender SQL do zero: o conjunto de dados dos pinguins de Palmer e um pequeno laboratório com funcionários, experimentos e placas de ensaio.
    No SQLtest.online você consulta o banco direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>13</strong> tabelas</li>
    <li><strong>344</strong> pinguins</li>
    <li><strong>50</strong> experimentos</li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no Querynomicon</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o Querynomicon no playground</a>
    {/if}
</div>

<h2>O que é o Querynomicon</h2>
<p>
    O banco vem do Querynomicon, o tutorial gratuito de Greg Wilson "An Introduction to SQL for Wary Data Scientists". A tabela principal traz os pinguins de Palmer: medidas de 344 pinguins de três espécies de três ilhas da Antártida.
</p>
<p>
    Os dados são poucos e fáceis de ler, mas têm as peculiaridades de dados reais: valores ausentes (NULL) nas medidas e na coluna de sexo. Por isso o banco é ótimo para aprender filtros, ordenação, agrupamento, tratamento de NULL e o básico de DDL e DML.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>O diagrama mostra as tabelas do Querynomicon e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados Querynomicon">Diagrama ER do banco de dados Querynomicon</object>
    </a>
{/if}

<h2>O que há no banco</h2>
<p>As tabelas se dividem em dois grupos.</p>
<div class="db-groups">
    <div>
        <h3>Pinguins</h3>
        <p><span class="sql">penguins</span> com as 344 aves e <span class="sql">little_penguins</span>, uma amostra de 10 linhas para testes rápidos.</p>
    </div>
    <div>
        <h3>Laboratório</h3>
        <p><span class="sql">department</span>, <span class="sql">staff</span>, <span class="sql">experiment</span>, <span class="sql">performed</span> (quem realizou cada experimento), <span class="sql">plate</span> e <span class="sql">invalidated</span>, além de <span class="sql">machine</span>, <span class="sql">usage</span>, <span class="sql">person</span> e <span class="sql">contact</span>.</p>
    </div>
</div>
<p>
    As tabelas de pinguins não têm chaves: cada linha é uma ave. As tabelas do laboratório se ligam por identificadores numéricos, e <span class="sql">performed</span> liga funcionários e experimentos em uma relação de muitos para muitos.
</p>

<p>Quantos dados há nas tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">penguins</span></td><td class="num">344</td><td>pinguins e suas medidas</td></tr>
        <tr><td><span class="sql">little_penguins</span></td><td class="num">10</td><td>amostra de 10 pinguins</td></tr>
        <tr><td><span class="sql">department</span></td><td class="num">4</td><td>departamentos</td></tr>
        <tr><td><span class="sql">staff</span></td><td class="num">10</td><td>funcionários</td></tr>
        <tr><td><span class="sql">experiment</span></td><td class="num">50</td><td>experimentos</td></tr>
        <tr><td><span class="sql">performed</span></td><td class="num">65</td><td>funcionários ↔ experimentos</td></tr>
        <tr><td><span class="sql">plate</span></td><td class="num">256</td><td>placas de ensaio</td></tr>
        <tr><td><span class="sql">invalidated</span></td><td class="num">30</td><td>placas invalidadas</td></tr>
        <tr><td><span class="sql">machine</span></td><td class="num">3</td><td>aparelhos do laboratório</td></tr>
        <tr><td><span class="sql">person</span></td><td class="num">15</td><td>pessoas</td></tr>
        <tr><td><span class="sql">usage</span></td><td class="num">8</td><td>registro de uso dos aparelhos</td></tr>
        <tr><td><span class="sql">contact</span></td><td class="num">8</td><td>contatos</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>{if $PlaygroundLink}Estas consultas mostram como os dados se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas mostram como os dados se relacionam.{/if}</p>

<p><strong>Experimentos e placas</strong>: uma relação de um para muitos com LEFT JOIN e contagem.</p>
<pre><code class="language-sql">SELECT e.ident, e.kind, e.started, COUNT(p.ident) AS plates
FROM experiment e
LEFT JOIN plate p ON p.experiment = e.ident
GROUP BY e.ident
ORDER BY e.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ident</th><th>kind</th><th>started</th><th>plates</th></tr>
        <tr><td class="num">1</td><td>calibration</td><td>2023-08-25</td><td class="num">1</td></tr>
        <tr><td class="num">2</td><td>calibration</td><td>2023-02-14</td><td class="num">1</td></tr>
        <tr><td class="num">3</td><td>trial</td><td>2023-02-22</td><td class="num">10</td></tr>
    </table>
</div>

<p><strong>Quem realizou um experimento</strong>: uma relação de muitos para muitos por <span class="sql">performed</span>.</p>
<pre><code class="language-sql">SELECT s.personal, s.family, e.kind, e.started
FROM performed pf
JOIN staff s ON s.ident = pf.staff
JOIN experiment e ON e.ident = pf.experiment
ORDER BY e.ident, s.ident
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>personal</th><th>family</th><th>kind</th><th>started</th></tr>
        <tr><td>Nitya</td><td>Lal</td><td>calibration</td><td>2023-08-25</td></tr>
        <tr><td>Indrans</td><td>Sridhar</td><td>calibration</td><td>2023-02-14</td></tr>
        <tr><td>Kartik</td><td>Gupta</td><td>trial</td><td>2023-02-22</td></tr>
    </table>
</div>

<h2>Exercícios de SQL por tema</h2>
<p>
    Há {$TasksCount} exercícios no banco Querynomicon, do primeiro SELECT a views, índices e triggers. As soluções são verificadas automaticamente em um SQLite real.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios do banco Querynomicon:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do Querynomicon →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o SQLite para usar o Querynomicon?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, escolha SQLite 3 Preloaded.</p>
    <h3>O que são os pinguins de Palmer?</h3>
    <p>Um conjunto de dados didático popular: medidas de pinguins-de-adélia, pinguins-de-barbicha e pinguins-gentoo coletadas na Estação Palmer, na Antártida. É muito usado como substituto moderno do conjunto de dados iris.</p>
    <h3>Este banco é bom para iniciantes?</h3>
    <p>Sim. As tabelas são pequenas e o tema dispensa explicações, então você pode se concentrar no SQL em si: SELECT, WHERE, ORDER BY, GROUP BY e tratamento de NULL.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o SQLite para usar o Querynomicon?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, escolha SQLite 3 Preloaded."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "O que são os pinguins de Palmer?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Um conjunto de dados didático popular: medidas de pinguins-de-adélia, pinguins-de-barbicha e pinguins-gentoo coletadas na Estação Palmer, na Antártida. É muito usado como substituto moderno do conjunto de dados iris."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Este banco é bom para iniciantes?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Sim. As tabelas são pequenas e o tema dispensa explicações, então você pode se concentrar no SQL em si: SELECT, WHERE, ORDER BY, GROUP BY e tratamento de NULL."{rdelim}{rdelim}
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
