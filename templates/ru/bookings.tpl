<div class="db-description">
    {literal}
    <h3>Описание базы данных Bookings</h3>
    Предметной областью этой базы данных являются рейсы авиакомпаний через различные аэропорты.
    <p>
        <a style="font-size: small; color: var(--special-text-color);" href="/images/bookings" target="ERDWindow">ER диаграмма базы данных Bookings</a>
    </p>
    <p>Таблица <span class='sql'>aircrafts_data</span></p>
    <ul class="table-columns">
        <li> <span class='sql'>aircraft_code</span> – Уникальный код для каждого самолета.</li>
        <li> <span class='sql'>model</span> — Название модели самолета на английском и русском языках в формате JSON.</li>
        <li> <span class='sql'>range</span> – Дальность полета самолета в километрах.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>aircraft_code</th><th>model</th><th>range</th></tr><tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr></tbody></table>
    </div>
    <p>Таблица <span class='sql'>airports_data</span></p>
    <ul class="table-columns">
         <li> <span class='sql'>airport_code</span> – Уникальный код для каждого аэропорта.</li>
         <li> <span class='sql'>airport_name</span> — Название аэропорта на английском и русском языках в формате JSON.</li>
         <li> <span class='sql'>city</span> — Город аэропорта на английском и русском языках в формате JSON.</li>
         <li> <span class='sql'>coordinates</span> – Координаты аэропорта в виде POINT(широта, долгота).</li>
         <li> <span class='sql'>timezone</span> – Название часового пояса аэропорта.</li>
     </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>airport_code</th><th>airport_name</th><th>city</th><th>coordinates</th><th>timezone</th></tr><tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr></tbody></table>
    </div>
    <p>Таблица <span class='sql'>boarding_passes</span></p>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>ticket_no</th><th>flight_id</th><th>boarding_no</th><th>seat_no</th></tr><tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr></tbody></table>
    </div>
    <p>Таблица <span class='sql'>bookings</span></p>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
    </div>
    <p>Таблица <span class='sql'>flights</span></p>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>flight_id</th><th>flight_no</th><th>scheduled_departure</th><th>scheduled_arrival</th><th>departure_airport</th><th>arrival_airport</th><th>status</th><th>aircraft_code</th><th>actual_departure</th><th>actual_arrival</th></tr><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Scheduled</td><td>319</td><td></td><td></td></tr></tbody></table>
    </div>
    <p>Таблица <span class='sql'>seats</span></p>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>aircraft_code</th><th>seat_no</th><th>fare_conditions</th></tr><tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
    </div>
    <p>Таблица <span class='sql'>ticket_flights</span></p>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>ticket_no</th><th>flight_id</th><th>fare_conditions</th><th>amount</th></tr><tr><td>1</td><td>0005432159776</td><td>30625</td><td>Business</td><td>42100.00</td></tr></tbody></table>
    </div>
    <p>Таблица <span class='sql'>tickets</span></p>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>ticket_no</th><th>book_ref</th><th>passenger_id</th><th>passenger_name</th><th>contact_data</th></tr><tr><td>1</td><td>0005432000987</td><td>06B046</td><td>8149 604011</td><td>VALERIY TIKHONOV</td><td>{"phone": "+70127117011"}</td></tr></tbody></table>
    </div>    
    {/literal}
</div>