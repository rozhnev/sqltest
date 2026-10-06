{* Texto da página /pt/database/countries (Controller::database(), estrutura database.tpl).
   Contagens de linhas e resultados verificados no banco do playground psql17postgis. *}
<h1>Banco de dados Countries (PostGIS): tabelas espaciais e exercícios de SQL</h1>
<p class="db-lead">
    Countries é um banco PostGIS para aprender SQL espacial: países e capitais do mundo, além de camadas de Nova York com setores censitários, bairros, ruas e estações de metrô.
    No SQLtest.online você consulta o banco direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>7</strong> tabelas espaciais</li>
    <li><strong>246</strong> países</li>
    <li><strong>491</strong> estações de metrô</li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no Countries</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o Countries no playground</a>
    {/if}
</div>

<h2>O que é o Countries</h2>
<p>
    PostGIS é a extensão do PostgreSQL que acrescenta tipos geométricos e centenas de funções espaciais: distâncias, áreas, interseções, transformações de coordenadas. Este banco permite experimentá-las com dados conhecidos.
</p>
<p>
    As tabelas de Nova York vêm do conhecido workshop "Introduction to PostGIS", e as tabelas do mundo trazem as fronteiras dos países e as capitais. Juntas, elas cobrem pontos, linhas e polígonos em dois sistemas de coordenadas.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>O diagrama mostra as tabelas do Countries e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados Countries">Diagrama ER do banco de dados Countries</object>
    </a>
{/if}

<h2>O que há no banco</h2>
<p>As tabelas se dividem em dois grupos.</p>
<div class="db-groups">
    <div>
        <h3>Mundo</h3>
        <p><span class="sql">countries</span> com polígonos de fronteira e <span class="sql">capitals</span> com pontos, ambas em SRID 4326 (longitude e latitude).</p>
    </div>
    <div>
        <h3>Nova York</h3>
        <p><span class="sql">nyc_census_blocks</span>, <span class="sql">nyc_neighborhoods</span>, <span class="sql">nyc_streets</span>, <span class="sql">nyc_subway_stations</span> e <span class="sql">nyc_homicides</span>, em SRID 26918 (UTM zona 18N, metros).</p>
    </div>
</div>
<p>
    O ponto principal: as tabelas do mundo guardam graus, e as de Nova York guardam metros. Distâncias e áreas nas camadas de Nova York saem diretamente em metros; nas tabelas do mundo, converta para <span class="sql">geography</span> ou transforme a geometria antes.
</p>

<p>Quantos dados há nas tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">countries</span></td><td class="num">246</td><td>países e suas fronteiras</td></tr>
        <tr><td><span class="sql">capitals</span></td><td class="num">192</td><td>capitais</td></tr>
        <tr><td><span class="sql">nyc_census_blocks</span></td><td class="num">38.794</td><td>setores censitários com população</td></tr>
        <tr><td><span class="sql">nyc_neighborhoods</span></td><td class="num">129</td><td>bairros</td></tr>
        <tr><td><span class="sql">nyc_streets</span></td><td class="num">19.091</td><td>ruas</td></tr>
        <tr><td><span class="sql">nyc_subway_stations</span></td><td class="num">491</td><td>estações de metrô</td></tr>
        <tr><td><span class="sql">nyc_homicides</span></td><td class="num">3.982</td><td>homicídios</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>{if $PlaygroundLink}Estas consultas mostram como os dados se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas mostram como os dados se relacionam.{/if}</p>

<p><strong>Uma capital dentro do seu país</strong>: coordenadas do ponto com <span class="sql">ST_X</span> / <span class="sql">ST_Y</span> e verificação espacial com <span class="sql">ST_Contains</span>.</p>
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

<p><strong>Estações de metrô e seu SRID</strong>: as camadas de Nova York usam a projeção 26918.</p>
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

<h2>Exercícios de SQL por tema</h2>
<p>
    Há {$TasksCount} exercícios de PostGIS neste banco: distâncias, áreas, comprimentos, conversões para texto e JSON e junções espaciais. As soluções são verificadas automaticamente em um PostgreSQL real com PostGIS.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios do banco Countries:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do Countries →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o PostGIS para usar este banco?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, escolha PostgreSQL 17 + PostGIS WorkShop.</p>
    <h3>O que é um SRID?</h3>
    <p>Um identificador de sistema de referência espacial: indica em qual sistema estão as coordenadas. 4326 é longitude e latitude em graus (WGS 84); 26918 é UTM zona 18N em metros, usado para Nova York.</p>
    <h3>De onde vêm as tabelas de Nova York?</h3>
    <p>Do conjunto de dados do workshop "Introduction to PostGIS", publicado em postgis.net, um ponto de partida comum para aprender PostGIS.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o PostGIS para usar este banco?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, escolha PostgreSQL 17 + PostGIS WorkShop."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "O que é um SRID?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Um identificador de sistema de referência espacial: indica em qual sistema estão as coordenadas. 4326 é longitude e latitude em graus (WGS 84); 26918 é UTM zona 18N em metros, usado para Nova York."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "De onde vêm as tabelas de Nova York?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Do conjunto de dados do workshop \"Introduction to PostGIS\", publicado em postgis.net, um ponto de partida comum para aprender PostGIS."{rdelim}{rdelim}
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
