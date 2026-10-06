{* Texto da página /pt/database/yellow-tripdata (Controller::database(), estrutura database.tpl).
   Contagens de linhas e resultados verificados no banco do playground duckdb_data. *}
<h1>Conjunto de dados NYC Yellow Taxi (DuckDB): a tabela yellow_tripdata e exercícios de SQL</h1>
<p class="db-lead">
    yellow_tripdata reúne as corridas dos táxis amarelos de Nova York em janeiro de 2024, quase 3 milhões de linhas, carregadas no DuckDB para SQL analítico.
    No SQLtest.online você consulta os dados direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>1</strong> tabela, 19 colunas</li>
    <li><strong>2.964.624</strong> corridas</li>
    <li><strong>janeiro de 2024</strong> </li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no NYC Yellow Taxi</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o NYC Yellow Taxi no playground</a>
    {/if}
</div>

<h2>O que é o NYC Yellow Taxi</h2>
<p>
    Os dados vêm dos registros de corridas que a Comissão de Táxis e Limusines de Nova York (TLC) publica todo mês. Cada linha é uma corrida: horário de embarque e desembarque, distância, número de passageiros, zonas de embarque e desembarque, forma de pagamento e cada parte da tarifa.
</p>
<p>
    O DuckDB é um banco analítico embutido com armazenamento colunar, então agregações sobre milhões de linhas levam frações de segundo. Por isso o conjunto é ótimo para praticar análise de verdade: séries temporais, distribuições, percentis e limpeza de dados.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>O diagrama mostra as tabelas do NYC Yellow Taxi e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados NYC Yellow Taxi">Diagrama ER do banco de dados NYC Yellow Taxi</object>
    </a>
{/if}

<h2>O que há no banco</h2>
<p>
    Todos os dados estão em uma tabela, <span class="sql">yellow_tripdata</span>. Todas as colunas aceitam NULL, e não há chaves nem restrições. <span class="sql">PULocationID</span> e <span class="sql">DOLocationID</span> são números de zonas de táxi da TLC. Algumas corridas têm horário de embarque fora de janeiro de 2024 e outras têm valores zerados ou negativos: dados reais precisam de limpeza, e alguns exercícios tratam exatamente disso.
</p>

<p>Quantos dados há nas tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">yellow_tripdata</span></td><td class="num">2.964.624</td><td>corridas dos táxis amarelos</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>{if $PlaygroundLink}Estas consultas mostram como os dados se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas mostram como os dados se relacionam.{/if}</p>

<p><strong>Duração da corrida</strong>: <span class="sql">date_diff</span> do DuckDB entre embarque e desembarque.</p>
<pre><code class="language-sql">SELECT tpep_pickup_datetime,
       date_diff('minute', tpep_pickup_datetime, tpep_dropoff_datetime) AS minutes,
       trip_distance, total_amount
FROM yellow_tripdata
WHERE tpep_pickup_datetime &gt;= '2024-01-01'
ORDER BY tpep_pickup_datetime
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>tpep_pickup_datetime</th><th>minutes</th><th>trip_distance</th><th>total_amount</th></tr>
        <tr><td>2024-01-01 00:00:00</td><td class="num">2</td><td class="num">0.3</td><td class="num">11.25</td></tr>
        <tr><td>2024-01-01 00:00:02</td><td class="num">4</td><td class="num">1.57</td><td class="num">16.32</td></tr>
        <tr><td>2024-01-01 00:00:03</td><td class="num">3</td><td class="num">0.5</td><td class="num">7.6</td></tr>
    </table>
</div>

<p><strong>Uma contagem rápida</strong>: o <span class="sql">GROUP BY ALL</span> do DuckDB agrupa por todas as colunas não agregadas.</p>
<pre><code class="language-sql">SELECT store_and_fwd_flag, COUNT(*) AS trips
FROM yellow_tripdata
GROUP BY ALL
ORDER BY trips DESC;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>store_and_fwd_flag</th><th>trips</th></tr>
        <tr><td>N</td><td class="num">2813126</td></tr>
        <tr><td>NULL</td><td class="num">140162</td></tr>
        <tr><td>Y</td><td class="num">11336</td></tr>
    </table>
</div>

<h2>Exercícios de SQL por tema</h2>
<p>
    Há {$TasksCount} exercícios com este conjunto de dados, de estatísticas gerais a séries temporais e verificações de qualidade. As soluções são verificadas automaticamente em um DuckDB real.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios do banco NYC Yellow Taxi:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do NYC Yellow Taxi →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o DuckDB para usar este conjunto de dados?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, escolha DuckDB.</p>
    <h3>De onde vêm os dados?</h3>
    <p>Dos dados abertos da Comissão de Táxis e Limusines de Nova York (TLC), publicados mensalmente em arquivos Parquet. Esta cópia traz as corridas dos táxis amarelos de janeiro de 2024.</p>
    <h3>Em que o SQL do DuckDB é diferente?</h3>
    <p>Ele é próximo do PostgreSQL, com extras para análise como <span class="sql">GROUP BY ALL</span>, <span class="sql">QUALIFY</span>, <span class="sql">date_diff</span> e funções de quantis.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o DuckDB para usar este conjunto de dados?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, escolha DuckDB."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "De onde vêm os dados?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Dos dados abertos da Comissão de Táxis e Limusines de Nova York (TLC), publicados mensalmente em arquivos Parquet. Esta cópia traz as corridas dos táxis amarelos de janeiro de 2024."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Em que o SQL do DuckDB é diferente?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Ele é próximo do PostgreSQL, com extras para análise como GROUP BY ALL, QUALIFY, date_diff e funções de quantis."{rdelim}{rdelim}
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
