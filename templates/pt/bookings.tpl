<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Banco de Dados Bookings (PostgreSQL)</h2>
    A área de assunto deste banco de dados é voos de companhias aéreas através de vários aeroportos.
    <p>
        <a class="button-erd" href="/{$Lang}/erd/Bookings" target="ERDWindow">
            Diagrama ER do banco de dados Bookings
        </a>
    </p>
    <h3>O Banco de Dados Bookings contém 8 tabelas:</h3>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - tabela de aeronaves.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Código único para cada aeronave.</li>
            <li> <span class='sql'>model</span>Nome do modelo da aeronave em inglês e russo no formato JSON.</li>
            <li> <span class='sql'>range</span>Alcance de voo da aeronave em quilômetros.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <tbody>
                    <tr><th></th><th>aircraft_code</th><th>model</th><th>range</th></tr>
                    <tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>airports_data</span> - tabela de aeroportos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>Código único para cada aeroporto.</li>
            <li> <span class='sql'>airport_name</span>Nome do aeroporto em inglês e russo no formato JSON.</li>
            <li> <span class='sql'>city</span>Cidade do aeroporto em inglês e russo no formato JSON.</li>
            <li> <span class='sql'>coordinates</span>Coordenadas do aeroporto como POINT(longitude, latitude).</li>
            <li> <span class='sql'>timezone</span>Nome do fuso horário do aeroporto.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (airport_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <tbody>
                    <tr><th></th><th>airport_code</th><th>airport_name</th><th>city</th><th>coordinates</th><th>timezone</th></tr>
                    <tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>boarding_passes</span> - tabela de cartões de embarque.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número do bilhete.</li>
            <li> <span class='sql'>flight_id</span>Identificador do voo.</li>
            <li> <span class='sql'>boarding_no</span>Número do cartão de embarque.</li>
            <li> <span class='sql'>seat_no</span>Número do assento.</li>
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
                <tbody>
                    <tr><th></th><th>ticket_no</th><th>flight_id</th><th>boarding_no</th><th>seat_no</th></tr>
                    <tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>bookings</span> - tabela de reservas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>Número da reserva.</li>
            <li> <span class='sql'>book_date</span>Data da reserva.</li>
            <li> <span class='sql'>total_amount</span>Custo total da reserva.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (book_ref)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>flights</span> - tabela de voos</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>flight_id</span>ID do voo.</li>
            <li> <span class='sql'>flight_no</span>Número do voo.</li>
            <li> <span class='sql'>scheduled_departure</span>Horário programado de partida.</li>
            <li> <span class='sql'>scheduled_arrival</span>Horário programado de chegada.</li>
            <li> <span class='sql'>departure_airport</span>Aeroporto de partida.</li>
            <li> <span class='sql'>arrival_airport</span>Aeroporto de chegada.</li>
            <li> <span class='sql'>status</span>Status do voo.</li>
            <li> <span class='sql'>aircraft_code</span>Código da aeronave, IATA.</li>
            <li> <span class='sql'>actual_departure</span>Horário real de partida.</li>
            <li> <span class='sql'>actual_arrival</span>Horário real de chegada.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (flight_id)</li>
            <li>UNIQUE KEY, btree (flight_no, scheduled_departure)</li>
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
    </div>
    <div class="accordion">
        <span><span class='sql'>seats</span> - tabela de assentos de aeronaves.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Código da aeronave, IATA.</li>
            <li> <span class='sql'>seat_no</span>Número do assento.</li>
            <li> <span class='sql'>fare_conditions</span>Classe de viagem.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (aircraft_code) REFERÊNCIAS aircrafts(aircraft_code) ON DELETE CASCADE</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr>
                <th></th>
                <th>aircraft_code</th><th>seat_no</th><th>fare_conditions</th>
            </tr>
            <tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>ticket_flights</span> - relações entre bilhetes e voos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número do bilhete.</li>
            <li> <span class='sql'>flight_id</span>ID do voo.</li>
            <li> <span class='sql'>fare_conditions</span>Classe de viagem.</li>
            <li> <span class='sql'>amount</span>Custo da viagem.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (flight_id) REFERÊNCIAS flights(flight_id)</li>
            <li>FOREIGN KEY (ticket_no) REFERÊNCIAS tickets(ticket_no)</li>
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
    </div>
    <div class="accordion">
        <span><span class='sql'>tickets</span> - tabela de bilhetes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número do bilhete.</li>
            <li> <span class='sql'>book_ref</span>Número da reserva.</li>
            <li> <span class='sql'>passenger_id</span>ID do passageiro.</li>
            <li> <span class='sql'>passenger_name</span>Nome do passageiro.</li>
            <li> <span class='sql'>contact_data</span>Informações de contato do passageiro.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (book_ref) REFERÊNCIAS bookings(book_ref)</li>
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
    </div>
    {/literal}
    {if $User->showAd()}
        {if isset($Book)}
            <div class="referal-add-block">
                <a id="crse:uTqLw0ABEe2G8Are2MuL1Q" 
                    href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AuTqLw0ABEe2G8Are2MuL1Q&u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fsql-practical-introduction-for-querying-databases&intsrc=PUI2_9419" 
                    target="_blank"
                    style="
                        display: block;
                        max-width: 48%;
                        height: 200px;
                        background: url('https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/34/3819b0a78a424a82ede83dc0cfad4f/Querying-Databases-with-SQL.jpg?auto=format%2Ccompress&dpr=1&w=200&h=200&fit=crop') no-repeat;
                    "
                    >
                    <div style="
                            background: white;
                            color: black;
                            margin: 5px;
                            padding: 3px;
                            border-radius: 3px;
                            opacity: 75%;
                            max-width: 88%;
                    ">
                        SQL: A Practical Introduction for Querying Databases
                    </div>
                </a>
                <a id="spzn:child~RXPU-mWaEeunahLL3oLBRQ" 
                    href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3Achild%7ERXPU-mWaEeunahLL3oLBRQ&u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fdata-science-fundamentals-python-sql&intsrc=PUI2_9419"
                    target="_blank"
                    style="
                        display: block;
                        max-width: 48%;
                        height: 200px;
                        background: url('https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/bd/0202c87e244d30bdecd889bd2719ae/DataScienceFundamentalsPythonSQL.png?auto=format%2Ccompress&dpr=1&w=200&h=200&fit=crop') no-repeat;
                    "
                    >
                    <div style="
                            background: white;
                            color: black;
                            margin: 5px;
                            padding: 3px;
                            border-radius: 3px;
                            opacity: 75%;
                            max-width: 88%;
                    ">
                        Data Science Fundamentals with Python and SQL
                    </div>
                </a>
            </div>
        {/if}
    {/if}
</div>