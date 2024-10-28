<div id="db-description" class="db-description">
    <h2>Banco de Dados Bookings (PostgreSQL)</h2>
    A área de assunto deste banco de dados é voos de companhias aéreas através de vários aeroportos.
    <p>
        <a style="font-size: small; color: var(--special-text-color);" href="/images/bookings" target="ERDWindow">Diagrama ER do banco de dados Bookings</a>
    </p>
    <p>O Banco de Dados Bookings contém 8 tabelas:</p>
    <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
      <li><span class='sql' onclick="scrollInfoPanel('aircrafts_data_table_description')">aircrafts_data</span> - tabela de aeronaves.</li>
      <li><span class='sql' onclick="scrollInfoPanel('airports_data_table_description')">airports_data</span> - tabela de aeroportos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('boarding_passes_table_description')">boarding_passes</span> - tabela de cartões de embarque.</li>
      <li><span class='sql' onclick="scrollInfoPanel('bookings_table_description')">bookings</span> - tabela de reservas.</li>
      <li><span class='sql' onclick="scrollInfoPanel('flights_table_description')">flights</span> - tabela de voos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('seats_table_description')">seats</span> - tabela de assentos de aeronaves.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ticket_flights_table_description')">ticket_flights</span> - tabela de relações entre bilhetes e voos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('tickets_table_description')">tickets</span> - tabela de bilhetes.</li>
    </ul>
    {if isset($Book)}
      <a href="{$Book.referral_link}" target="_blank" style="text-decoration: none;">
        <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">
          <div  style = "width: 30%;">
              <img style="width: 100%;" src="{$Book.picture_link}" alt="{$Book.title}">
          </div>
          <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
              <div>{$Book.title}</div>
              <div style="font-size: small; padding-top: 0.5em;">{$Book.description}</div>
          </div>
        </div>
      </a>
    {/if}
    {literal}
    <h3 id="aircrafts_data_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>aircrafts_data</span>
    </h3>
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>aircraft_code</span> - Código único para cada aeronave.</li>
        <li> <span class='sql'>model</span> - Nome do modelo da aeronave em inglês e russo no formato JSON.</li>
        <li> <span class='sql'>range</span> - Alcance de voo da aeronave em quilômetros.</li>
    </ul>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (aircraft_code)</li>
    </ul>
    <div class="table-wrapper">
        <table class="">
            <tbody>
                <tr><th></th><th>aircraft_code</th><th>model</th><th>range</th></tr>
                <tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr>
            </tbody>
        </table>
    </div>
    <h3 id="airports_data_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>airports_data</span>
    </h3>
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>airport_code</span> - Código único para cada aeroporto.</li>
        <li> <span class='sql'>airport_name</span> - Nome do aeroporto em inglês e russo no formato JSON.</li>
        <li> <span class='sql'>city</span> - Cidade do aeroporto em inglês e russo no formato JSON.</li>
        <li> <span class='sql'>coordinates</span> - Coordenadas do aeroporto como POINT(longitude, latitude).</li>
        <li> <span class='sql'>timezone</span> - Nome do fuso horário do aeroporto.</li>
    </ul>
    <div class="table-wrapper">
        <table class="">
            <tbody>
                <tr><th></th><th>airport_code</th><th>airport_name</th><th>city</th><th>coordinates</th><th>timezone</th></tr>
                <tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr>
            </tbody>
        </table>
    </div>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (airport_code)</li>
    </ul>
    <h3 id="boarding_passes_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>boarding_passes</span>
    </h3>    
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> - Número do bilhete.</li>
        <li> <span class='sql'>flight_id</span> - Identificador do voo.</li>
        <li> <span class='sql'>boarding_no</span> - Número do cartão de embarque.</li>
        <li> <span class='sql'>seat_no</span> - Número do assento.</li>
    </ul>
    <div class="table-wrapper">
        <table class="">
            <tbody>
                <tr><th></th><th>ticket_no</th><th>flight_id</th><th>boarding_no</th><th>seat_no</th></tr>
                <tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr>
            </tbody>
        </table>
    </div>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (ticket_no, flight_id)</li>
        <li>RESTRIÇÃO ÚNICA, btree (flight_id, boarding_no)</li>
        <li>RESTRIÇÃO ÚNICA, btree (flight_id, seat_no)</li>
    </ul>
    Restrições de chave estrangeira:
    <ul class="table-columns">
        <li>CHAVE ESTRANGEIRA (ticket_no, flight_id) REFERÊNCIAS ticket_flights(ticket_no, flight_id)</li>
    </ul>
    <h3 id="bookings_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>bookings</span>
    </h3>      
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>book_ref</span> - Número da reserva.</li>
        <li> <span class='sql'>book_date</span> - Data da reserva.</li>
        <li> <span class='sql'>total_amount</span> - Custo total da reserva.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
    </div>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (book_ref)</li>
    </ul>
    <h3 id="flights_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>flights</span>
    </h3>
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>flight_id</span> - ID do voo.</li>
        <li> <span class='sql'>flight_no</span> - Número do voo.</li>
        <li> <span class='sql'>scheduled_departure</span> - Horário programado de partida.</li>
        <li> <span class='sql'>scheduled_arrival</span> - Horário programado de chegada.</li>
        <li> <span class='sql'>departure_airport</span> - Aeroporto de partida.</li>
        <li> <span class='sql'>arrival_airport</span> - Aeroporto de chegada.</li>
        <li> <span class='sql'>status</span> - Status do voo.</li>
        <li> <span class='sql'>aircraft_code</span> - Código da aeronave, IATA.</li>
        <li> <span class='sql'>actual_departure</span> - Horário real de partida.</li>
        <li> <span class='sql'>actual_arrival</span> - Horário real de chegada.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody>
            <tr><th></th>
                <th>flight_id</th>
                <th>flight_no</th>
                <th>scheduled_departure</th>
                <th>scheduled_arrival</th>
                <th>departure_airport</th>
                <th>arrival_airport</th>
                <th>status</th>
                <th>aircraft_code</th>
                <th>actual_departure</th>
                <th>actual_arrival</th>
            </tr><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Scheduled</td><td>319</td><td></td><td></td></tr></tbody></table>
    </div>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (flight_id)</li>
        <li>RESTRIÇÃO ÚNICA, btree (flight_no, scheduled_departure)</li>
    </ul>
    <h3 id="seats_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>seats</span>
    </h3>
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>aircraft_code</span> - Código da aeronave, IATA.</li>
        <li> <span class='sql'>seat_no</span> - Número do assento.</li>
        <li> <span class='sql'>fare_conditions</span> - Classe de viagem.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr>
            <th></th>
            <th>aircraft_code</th><th>seat_no</th><th>fare_conditions</th>
        </tr>
        <tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
    </div>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (aircraft_code, seat_no)</li>
    </ul>
    Restrições de chave estrangeira:
    <ul class="table-columns">
        <li>CHAVE ESTRANGEIRA (aircraft_code) REFERÊNCIAS aircrafts(aircraft_code) ON DELETE CASCADE</li>
    </ul>
    <h3 id="ticket_flights_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>ticket_flights</span>
    </h3>
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> - Número do bilhete.</li>
        <li> <span class='sql'>flight_id</span> - ID do voo.</li>
        <li> <span class='sql'>fare_conditions</span> - Classe de viagem.</li>
        <li> <span class='sql'>amount</span> - Custo da viagem.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr>
            <th></th>
            <th>ticket_no</th>
            <th>flight_id</th>
            <th>fare_conditions</th>
            <th>amount</th>
        </tr><tr><td>1</td><td>0005432159776</td><td>30625</td><td>Business</td><td>42100.00</td></tr></tbody></table>
    </div>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (ticket_no, flight_id)</li>
    </ul>
    Restrições de chave estrangeira:
    <ul class="table-columns">
        <li>CHAVE ESTRANGEIRA (flight_id) REFERÊNCIAS flights(flight_id)</li>
        <li>CHAVE ESTRANGEIRA (ticket_no) REFERÊNCIAS tickets(ticket_no)</li>
    </ul>
    <h3 id="tickets_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>tickets</span>
    </h3>
    Colunas da tabela:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> - Número do bilhete.</li>
        <li> <span class='sql'>book_ref</span> - Número da reserva.</li>
        <li> <span class='sql'>passenger_id</span> - ID do passageiro.</li>
        <li> <span class='sql'>passenger_name</span> - Nome do passageiro.</li>
        <li> <span class='sql'>contact_data</span> - Informações de contato do passageiro.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr>
            <th></th>
            <th>ticket_no</th>
            <th>book_ref</th>
            <th>passenger_id</th>
            <th>passenger_name</th>
            <th>contact_data</th></tr>
            <tr><td>1</td><td>0005432000987</td><td>06B046</td><td>8149 604011</td><td>VALERIY TIKHONOV</td><td>{"phone": "+70127117011"}</td></tr></tbody></table>
    </div>
    Índices:
    <ul class="table-columns">
        <li>CHAVE PRIMÁRIA, btree (ticket_no)</li>
    </ul>
    Restrições de chave estrangeira:
    <ul class="table-columns">
        <li>CHAVE ESTRANGEIRA (book_ref) REFERÊNCIAS bookings(book_ref)</li>
    </ul>
    {/literal}
</div>