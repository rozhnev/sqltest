{* Texto da página /pt/database/bookings (Controller::database(), estrutura database.tpl).
   Contagens de linhas e resultados verificados no banco do playground psql18demo. *}
<h1>Banco de dados Bookings: esquema de companhia aérea, tabelas e exercícios de SQL</h1>
<p class="db-lead">
    Bookings é o banco de demonstração do PostgreSQL sobre uma companhia aérea: voos entre 104 aeroportos, reservas, bilhetes e cartões de embarque.
    No SQLtest.online você consulta o banco direto no navegador: resolve exercícios com correção automática e executa suas próprias consultas no playground, sem instalar nada.
</p>

<ul class="db-stats">
    <li><strong>8</strong> tabelas e 4 views</li>
    <li><strong>33.121</strong> voos</li>
    <li><strong>1.045.726</strong> trechos de bilhetes</li>
    <li><strong>{$TasksCount}</strong> exercícios de SQL</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Resolver exercícios no Bookings</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Abrir o Bookings no playground</a>
    {/if}
</div>

<h2>O que é o Bookings</h2>
<p>
    Bookings é o banco de demonstração que a Postgres Professional publica para o aprendizado de PostgreSQL. Ele modela os voos de uma companhia aérea russa: rotas, aeronaves e seus mapas de assentos, reservas, bilhetes e cartões de embarque.
</p>
<p>
    Esta cópia contém voos de julho a setembro de 2017. Os nomes de aeroportos e aeronaves ficam em JSONB, em inglês e russo, e as coordenadas dos aeroportos usam o tipo <span class="sql">point</span>. Por isso o banco é bom para praticar recursos específicos do PostgreSQL, JOINs e análises em tabelas grandes.
</p>

{if $ErdImage}
    <h2>Diagrama ER</h2>
    <p>O diagrama mostra as tabelas do Bookings e as chaves estrangeiras entre elas. Clique para abrir em tamanho real.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="Diagrama ER do banco de dados Bookings">Diagrama ER do banco de dados Bookings</object>
    </a>
{/if}

<h2>O que há no banco</h2>
<p>As tabelas se dividem em dois grupos.</p>
<div class="db-groups">
    <div>
        <h3>Dados de referência</h3>
        <p><span class="sql">airports_data</span>, <span class="sql">aircrafts_data</span> e <span class="sql">seats</span>: o mapa de assentos de cada modelo de aeronave.</p>
    </div>
    <div>
        <h3>Vendas e voos</h3>
        <p><span class="sql">bookings</span> → <span class="sql">tickets</span> → <span class="sql">ticket_flights</span> ← <span class="sql">flights</span>, além de <span class="sql">boarding_passes</span>, emitidos no check-in.</p>
    </div>
</div>
<p>
    O ponto principal: uma reserva pode incluir vários passageiros, e um bilhete pode cobrir vários voos. A ligação entre bilhetes e voos é <span class="sql">ticket_flights</span>, a maior tabela. As views <span class="sql">aircrafts</span>, <span class="sql">airports</span>, <span class="sql">flights_v</span> e <span class="sql">routes</span> mostram os mesmos dados de forma mais amigável.
</p>

<p>Quantos dados há nas tabelas:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Tabela</th><th>Linhas</th><th>Conteúdo</th></tr>
        <tr><td><span class="sql">bookings</span></td><td class="num">262.788</td><td>reservas</td></tr>
        <tr><td><span class="sql">tickets</span></td><td class="num">366.733</td><td>bilhetes, um por passageiro</td></tr>
        <tr><td><span class="sql">ticket_flights</span></td><td class="num">1.045.726</td><td>trechos de voo dos bilhetes</td></tr>
        <tr><td><span class="sql">boarding_passes</span></td><td class="num">579.686</td><td>cartões de embarque</td></tr>
        <tr><td><span class="sql">flights</span></td><td class="num">33.121</td><td>voos programados e realizados</td></tr>
        <tr><td><span class="sql">airports_data</span></td><td class="num">104</td><td>aeroportos</td></tr>
        <tr><td><span class="sql">aircrafts_data</span></td><td class="num">9</td><td>modelos de aeronaves</td></tr>
        <tr><td><span class="sql">seats</span></td><td class="num">1.339</td><td>assentos por modelo de aeronave</td></tr>
    </table>
</div>

<h2>Estrutura das tabelas</h2>
<p>Clique em uma tabela para ver suas colunas, uma linha de exemplo e as chaves.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Exemplos de consultas</h2>
<p>{if $PlaygroundLink}Estas consultas mostram como os dados se relacionam. Copie qualquer uma e execute no <a href="{$PlaygroundLink}">playground</a>.{else}Estas consultas mostram como os dados se relacionam.{/if}</p>

<p><strong>Um bilhete e sua reserva</strong>: o passageiro e o valor da reserva.</p>
<pre><code class="language-sql">SELECT t.ticket_no, t.passenger_name, b.book_date, b.total_amount
FROM tickets t
JOIN bookings b ON b.book_ref = t.book_ref
ORDER BY t.ticket_no
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>passenger_name</th><th>book_date</th><th>total_amount</th></tr>
        <tr><td class="num">0005432000987</td><td>VALERIY TIKHONOV</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000988</td><td>EVGENIYA ALEKSEEVA</td><td>2017-07-05 17:19:00+00</td><td class="num">12400.00</td></tr>
        <tr><td class="num">0005432000989</td><td>ARTUR GERASIMOV</td><td>2017-06-28 22:55:00+00</td><td class="num">24700.00</td></tr>
    </table>
</div>

<p><strong>Um voo e sua aeronave</strong>: o nome em inglês lido de uma coluna JSONB com <span class="sql">-&gt;&gt;</span>.</p>
<pre><code class="language-sql">SELECT f.flight_no, f.departure_airport, f.arrival_airport,
       a.model -&gt;&gt; 'en' AS aircraft
FROM flights f
JOIN aircrafts_data a ON a.aircraft_code = f.aircraft_code
ORDER BY f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>flight_no</th><th>departure_airport</th><th>arrival_airport</th><th>aircraft</th></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0404</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
        <tr><td>PG0405</td><td>DME</td><td>LED</td><td>Airbus A321-200</td></tr>
    </table>
</div>

<p><strong>Tarifa e assento</strong>: do trecho do bilhete ao voo e ao cartão de embarque. O LEFT JOIN mantém os trechos sem cartão.</p>
<pre><code class="language-sql">SELECT tf.ticket_no, f.flight_no, tf.fare_conditions, tf.amount, bp.seat_no
FROM ticket_flights tf
JOIN flights f ON f.flight_id = tf.flight_id
LEFT JOIN boarding_passes bp
       ON bp.ticket_no = tf.ticket_no AND bp.flight_id = tf.flight_id
ORDER BY tf.ticket_no, f.flight_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>ticket_no</th><th>flight_no</th><th>fare_conditions</th><th>amount</th><th>seat_no</th></tr>
        <tr><td class="num">0005432000987</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>7A</td></tr>
        <tr><td class="num">0005432000988</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>10E</td></tr>
        <tr><td class="num">0005432000989</td><td>PG0242</td><td>Economy</td><td class="num">6200.00</td><td>18E</td></tr>
    </table>
</div>

<h2>Exercícios de SQL por tema</h2>
<p>
    Há {$TasksCount} exercícios no banco Bookings, de consultas simples a análises sobre um milhão de linhas. As soluções são verificadas automaticamente em um PostgreSQL real.
    O número à direita é a quantidade de exercícios do tema; os pontos coloridos mostram a faixa de dificuldade.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>Por onde começar</h2>
    <p>Os primeiros exercícios do banco Bookings:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Todos os exercícios do Bookings →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Perguntas frequentes</h2>
    <h3>Preciso instalar o PostgreSQL para usar o Bookings?</h3>
    <p>Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o Bookings está disponível no PostgreSQL 18.</p>
    <h3>Onde baixar o banco de demonstração Bookings?</h3>
    <p>A Postgres Professional o publica em vários tamanhos no seu site, junto com a descrição do esquema.</p>
    <h3>Por que alguns nomes aparecem entre chaves?</h3>
    <p>Os nomes de aeroportos, cidades e aeronaves são objetos JSONB com valores em inglês e russo. Use <span class="sql">-&gt;&gt; 'en'</span> para obter o texto em inglês ou consulte as views, que escolhem um idioma.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Preciso instalar o PostgreSQL para usar o Bookings?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Não. Os exercícios e o playground do SQLtest.online executam as consultas nos nossos servidores, então basta um navegador. No playground, o Bookings está disponível no PostgreSQL 18."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Onde baixar o banco de demonstração Bookings?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "A Postgres Professional o publica em vários tamanhos no seu site, junto com a descrição do esquema."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Por que alguns nomes aparecem entre chaves?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Os nomes de aeroportos, cidades e aeronaves são objetos JSONB com valores em inglês e russo. Use -&gt;&gt; 'en' para obter o texto em inglês ou consulte as views, que escolhem um idioma."{rdelim}{rdelim}
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
