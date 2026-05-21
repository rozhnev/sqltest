<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h1>Banco de Dados Bookings: estrutura das tabelas e visão do esquema</h1>
    <p>O banco Bookings (PostgreSQL) modela voos de companhias aéreas entre diferentes aeroportos e é amplamente usado para prática de SQL.</p>
    <p>Esta página apresenta a estrutura das tabelas, colunas-chave e restrições usadas em consultas SQL analíticas e transacionais.</p>
    <p>O Banco de Dados Bookings contém 8 tabelas principais.</p>
    <p>
        <a href="/{$Lang}/erd/Bookings" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir o diagrama ER do banco Bookings em uma nova janela">
            <img src="/images/erd_small_light.svg" alt="Diagrama ER do banco Bookings mostrando relacionamentos entre tabelas" style="width: 90%;" loading="lazy" decoding="async">
            Diagrama ER do banco de dados Bookings
        </a>
    </p>
    <h2>Lista de tabelas</h2>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - tabela de aeronaves.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Código único para cada aeronave</li>
            <li> <span class='sql'>model</span>Nome do modelo da aeronave em inglês e russo no formato JSON</li>
            <li> <span class='sql'>range</span>Alcance de voo da aeronave em quilômetros</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">aircraft_code</th><th scope="col">model</th><th scope="col">range</th></tr></thead><tbody><tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>airports_data</span> - tabela de aeroportos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>Código único para cada aeroporto</li>
            <li> <span class='sql'>airport_name</span>Nome do aeroporto em inglês e russo no formato JSON</li>
            <li> <span class='sql'>city</span>Cidade do aeroporto em inglês e russo no formato JSON</li>
            <li> <span class='sql'>coordinates</span>Coordenadas do aeroporto como POINT(longitude, latitude)</li>
            <li> <span class='sql'>timezone</span>Nome do fuso horário do aeroporto</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (airport_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">airport_code</th><th scope="col">airport_name</th><th scope="col">city</th><th scope="col">coordinates</th><th scope="col">timezone</th></tr></thead><tbody><tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>boarding_passes</span> - tabela de cartões de embarque.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número do bilhete</li>
            <li> <span class='sql'>flight_id</span>Identificador do voo</li>
            <li> <span class='sql'>boarding_no</span>Número do cartão de embarque</li>
            <li> <span class='sql'>seat_no</span>Número do assento</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
            <li>UNIQUE KEY, btree (flight_id, boarding_no)</li>
            <li>UNIQUE KEY, btree (flight_id, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (ticket_no, flight_id) REFERÊNCIAS ticket_flights(ticket_no, flight_id)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">ticket_no</th><th scope="col">flight_id</th><th scope="col">boarding_no</th><th scope="col">seat_no</th></tr></thead><tbody><tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>bookings</span> - tabela de reservas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>Número da reserva</li>
            <li> <span class='sql'>book_date</span>Data da reserva</li>
            <li> <span class='sql'>total_amount</span>Custo total da reserva</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (book_ref)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">book_ref</th><th scope="col">book_date</th><th scope="col">total_amount</th></tr></thead><tbody><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>flights</span> - tabela de voos</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">flight_id</span>ID do voo</li>
            <li> <span class='sql' style="min-width: 12rem;">flight_no</span>Número do voo</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_departure</span>Horário programado de partida</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_arrival</span>Horário programado de chegada</li>
            <li> <span class='sql' style="min-width: 12rem;">departure_airport</span>Aeroporto de partida</li>
            <li> <span class='sql' style="min-width: 12rem;">arrival_airport</span>Aeroporto de chegada</li>
            <li> <span class='sql' style="min-width: 12rem;">status</span>Status do voo</li>
            <li> <span class='sql' style="min-width: 12rem;">aircraft_code</span>Código da aeronave, IATA</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_departure</span>Horário real de partida</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_arrival</span>Horário real de chegada</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (flight_id)</li>
            <li>UNIQUE KEY, btree (flight_no, scheduled_departure)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th>
                    <th scope="col">flight_id</th>
                    <th scope="col">flight_no</th>
                    <th scope="col">scheduled_departure</th>
                    <th scope="col">scheduled_arrival</th>
                    <th scope="col">departure_airport</th>
                    <th scope="col">arrival_airport</th>
                    <th scope="col">status</th>
                    <th scope="col">aircraft_code</th>
                    <th scope="col">actual_departure</th>
                    <th scope="col">actual_arrival</th>
                </tr></thead><tbody><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Scheduled</td><td>319</td><td></td><td></td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>seats</span> - tabela de assentos de aeronaves.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Código da aeronave, IATA</li>
            <li> <span class='sql'>seat_no</span>Número do assento</li>
            <li> <span class='sql'>fare_conditions</span>Classe de viagem</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (aircraft_code) REFERÊNCIAS aircrafts(aircraft_code) ON DELETE CASCADE</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">aircraft_code</th><th scope="col">seat_no</th><th scope="col">fare_conditions</th>
            </tr></thead><tbody><tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>ticket_flights</span> - relações entre bilhetes e voos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número do bilhete</li>
            <li> <span class='sql'>flight_id</span>ID do voo</li>
            <li> <span class='sql'>fare_conditions</span>Classe de viagem</li>
            <li> <span class='sql'>amount</span>Custo da viagem</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (flight_id) REFERÊNCIAS flights(flight_id)</li>
            <li>FOREIGN KEY (ticket_no) REFERÊNCIAS tickets(ticket_no)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">ticket_no</th>
                <th scope="col">flight_id</th>
                <th scope="col">fare_conditions</th>
                <th scope="col">amount</th>
            </tr></thead><tbody><tr><td>1</td><td>0005432159776</td><td>30625</td><td>Business</td><td>42100.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>tickets</span> - tabela de bilhetes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número do bilhete</li>
            <li> <span class='sql'>book_ref</span>Número da reserva</li>
            <li> <span class='sql'>passenger_id</span>ID do passageiro</li>
            <li> <span class='sql'>passenger_name</span>Nome do passageiro</li>
            <li> <span class='sql'>contact_data</span>Informações de contato do passageiro</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (book_ref) REFERÊNCIAS bookings(book_ref)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">ticket_no</th>
                <th scope="col">book_ref</th>
                <th scope="col">passenger_id</th>
                <th scope="col">passenger_name</th>
                <th scope="col">contact_data</th></tr></thead><tbody><tr><td>1</td><td>0005432000987</td><td>06B046</td><td>8149 604011</td><td>VALERIY TIKHONOV</td><td>{"phone": "+70127117011"}</td></tr></tbody></table>
        </div>
    </div>
    {/literal}
    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                <div class="book-card">
                    <a href="{{$Book.referral_link}}" target="_blank" style="text-decoration: none; color: var(--question-color);">
                        <div style="display: flex; flex-direction: row;     border: 1px solid var(--text-block-border-color);
color: var(--question-text);
border-radius: 6px; padding: 0.3em; width: 98%;">
                        <div  style = "width: 25%;">
                            <img style="width: 100%;" src="{{$Book.picture_link}}" alt="{{$Book.title|escape:"html"}}">
                        </div>
                        <div style="font-size: 1em;  width: 75%;  padding: 0 0.7em; font-weight: 100; height: 250px; overflow: auto;">
                            <div>{{$Book.title|escape:"html"}}</div>
                            <div style="font-size: small; padding-top: 0.5em;">{{$Book.description|escape:"html"}}</div>
                        </div>
                        </div>
                    </a>
                </div>
            {/if}
        </div>
    {/if}    
</div>