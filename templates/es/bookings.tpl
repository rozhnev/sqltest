<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de Datos de Reservas: estructura de tabla y visión general del esquema</h2>
    <p>La base de datos de Reservas (PostgreSQL) modela vuelos de aerolíneas a través de múltiples aeropuertos y se utiliza ampliamente para la práctica de SQL.</p>
    <p>Esta página muestra la estructura de la tabla, las columnas clave y las restricciones utilizadas en consultas SQL analíticas y transaccionales típicas.</p>
    <p>La base de datos de Reservas contiene 8 tablas principales.</p>
    <p>
        <a href="/{$Lang}/erd/Bookings" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir diagrama ER de la base de datos de Reservas en una nueva ventana">
            <img src="/images/erd_small_light.svg" alt="Diagrama ER de la base de datos de Reservas mostrando relaciones de tablas" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Diagrama ER de la base de datos de Reservas
        </a>
    </p>
    <h3>La lista de tablas</h3>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - tabla de aeronaves.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Código único para cada aeronave</li>
            <li> <span class='sql'>model</span>Nombre del modelo de aeronave en inglés y ruso en formato JSON</li>
            <li> <span class='sql'>range</span>Rango de vuelo de la aeronave en kilómetros</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (aircraft_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">aircraft_code</th><th scope="col">model</th><th scope="col">range</th></tr></thead><tbody><tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>airports_data</span> - tabla de aeropuertos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>Código único para cada aeropuerto</li>
            <li> <span class='sql'>airport_name</span>Nombre del aeropuerto en inglés y ruso en formato JSON</li>
            <li> <span class='sql'>city</span>Ciudad del aeropuerto en inglés y ruso en formato JSON</li>
            <li> <span class='sql'>coordinates</span>Coordenadas del aeropuerto como PUNTO(longitud, latitud)</li>
            <li> <span class='sql'>timezone</span>Nombre de la zona horaria del aeropuerto</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (airport_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">airport_code</th><th scope="col">airport_name</th><th scope="col">city</th><th scope="col">coordinates</th><th scope="col">timezone</th></tr></thead><tbody><tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>boarding_passes</span> - tabla de tarjetas de embarque.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número de ticket</li>
            <li> <span class='sql'>flight_id</span>Identificador de vuelo</li>
            <li> <span class='sql'>boarding_no</span>Número de tarjeta de embarque</li>
            <li> <span class='sql'>seat_no</span>Número de asiento</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (ticket_no, flight_id)</li>
            <li>RESTRICCIÓN ÚNICA, btree (flight_id, boarding_no)</li>
            <li>RESTRICCIÓN ÚNICA, btree (flight_id, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (ticket_no, flight_id) REFERENCIAS ticket_flights(ticket_no, flight_id)</li>
        </ul>        
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">ticket_no</th><th scope="col">flight_id</th><th scope="col">boarding_no</th><th scope="col">seat_no</th></tr></thead><tbody><tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>bookings</span> - tabla de reservas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>Número de reserva</li>
            <li> <span class='sql'>book_date</span>Fecha de reserva</li>
            <li> <span class='sql'>total_amount</span>Costo total de la reserva</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (book_ref)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">book_ref</th><th scope="col">book_date</th><th scope="col">total_amount</th></tr></thead><tbody><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>flights</span> - tabla de vuelos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">flight_id</span>ID de vuelo</li>
            <li> <span class='sql' style="min-width: 12rem;">flight_no</span>Número de vuelo</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_departure</span>Hora de salida programada</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_arrival</span>Hora de llegada programada</li>
            <li> <span class='sql' style="min-width: 12rem;">departure_airport</span>Aeropuerto de salida</li>
            <li> <span class='sql' style="min-width: 12rem;">arrival_airport</span>Aeropuerto de llegada</li>
            <li> <span class='sql' style="min-width: 12rem;">status</span>Estado del vuelo</li>
            <li> <span class='sql' style="min-width: 12rem;">aircraft_code</span>Código de aeronave, IATA</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_departure</span>Hora de salida real</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_arrival</span>Hora de llegada real</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (flight_id)</li>
            <li>RESTRICCIÓN ÚNICA, btree (flight_no, scheduled_departure)</li>
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
                </tr></thead><tbody><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Programado</td><td>319</td><td></td><td></td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>seats</span> - tabla de asientos de aeronaves.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Código de aeronave, IATA</li>
            <li> <span class='sql'>seat_no</span>Número de asiento</li>
            <li> <span class='sql'>fare_conditions</span>Clase de viaje</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (aircraft_code, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (aircraft_code) REFERENCIAS aircrafts(aircraft_code) ON DELETE CASCADE</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">aircraft_code</th><th scope="col">seat_no</th><th scope="col">fare_conditions</th>
            </tr></thead><tbody><tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>ticket_flights</span> - relaciones de tickets a vuelos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número de ticket</li>
            <li> <span class='sql'>flight_id</span>ID de vuelo</li>
            <li> <span class='sql'>fare_conditions</span>Clase de viaje</li>
            <li> <span class='sql'>amount</span>Costo del viaje</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (ticket_no, flight_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (flight_id) REFERENCIAS flights(flight_id)</li>
            <li>CLAVE FORÁNEA (ticket_no) REFERENCIAS tickets(ticket_no)</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>tickets</span> - tabla de tickets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Número de ticket</li>
            <li> <span class='sql'>book_ref</span>Número de reserva</li>
            <li> <span class='sql'>passenger_id</span>ID de pasajero</li>
            <li> <span class='sql'>passenger_name</span>Nombre del pasajero</li>
            <li> <span class='sql'>contact_data</span>Información de contacto del pasajero</li>
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
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (ticket_no)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (book_ref) REFERENCIAS bookings(book_ref)</li>
        </ul>   
    </div>
    {/literal}
    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>