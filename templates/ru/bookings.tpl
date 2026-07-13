<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>База данных Bookings: структура таблиц и обзор схемы</h2>
    <p>База Bookings (PostgreSQL) моделирует рейсы авиакомпаний между разными аэропортами и часто используется для практики SQL.</p>
    <p>На этой странице показаны структура таблиц, ключевые поля и ограничения, используемые в аналитических и транзакционных SQL-запросах.</p>
    <p>База данных Bookings содержит 8 основных таблиц.</p>
    <p>
        <a href="/{$Lang}/erd/Bookings" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Открыть ER-диаграмму базы Bookings в новом окне">
            <img src="/images/erd_small_light.svg" alt="ER-диаграмма базы Bookings со связями между таблицами" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            ER диаграмма базы данных Bookings
        </a>
    </p>
    <h3>Список таблиц</h3>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - таблица самолетов.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Уникальный код для каждого самолета</li>
            <li> <span class='sql'>model</span>Название модели самолета на английском и русском языках в формате JSON</li>
            <li> <span class='sql'>range</span>Дальность полета самолета в километрах</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">aircraft_code</th><th scope="col">model</th><th scope="col">range</th></tr></thead><tbody><tr><td>1</td><td>773</td><td>{<br>"en": "Boeing 777-300",<br>"ru": "Боинг 777-300"<br>}</td><td>11100</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>airports_data</span> - таблица аэропортов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>Уникальный код для каждого аэропорта</li>
            <li> <span class='sql'>airport_name</span>Название аэропорта на английском и русском языках в формате JSON</li>
            <li> <span class='sql'>city</span>Город аэропорта на английском и русском языках в формате JSON</li>
            <li> <span class='sql'>coordinates</span>Координаты аэропорта в виде POINT(долгота, широта)</li>
            <li> <span class='sql'>timezone</span>Название часового пояса аэропорта</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">airport_code</th><th scope="col">airport_name</th><th scope="col">city</th><th scope="col">coordinates</th><th scope="col">timezone</th></tr></thead><tbody><tr><td>1</td><td>YKS</td><td>{<br>"en":&nbsp;"Yakutsk&nbsp;Airport",<br>"ru": "Якутск"<br>}</td><td>{<br>"en":&nbsp;"Yakutsk",<br>"ru":&nbsp;"Якутск"<br>}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr></tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (airport_code)</li>
        </ul>    
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>boarding_passes</span> - посадочные талоны.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Номер билета</li>
            <li> <span class='sql'>flight_id</span>Идентификатор рейса</li>
            <li> <span class='sql'>boarding_no</span>Номер посадочного талона</li>
            <li> <span class='sql'>seat_no</span>Номер места</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">ticket_no</th><th scope="col">flight_id</th><th scope="col">boarding_no</th><th scope="col">seat_no</th></tr></thead><tbody><tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr></tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
            <li>UNIQUE CONSTRAINT, btree (flight_id, boarding_no)</li>
            <li>UNIQUE CONSTRAINT, btree (flight_id, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_flights(ticket_no, flight_id)</li>
        </ul>    
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>bookings</span> - бронирования билетов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>Номер бронирования</li>
            <li> <span class='sql'>book_date</span>Дата бронирования</li>
            <li> <span class='sql'>total_amount</span>Общая стоимость бронирования</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">book_ref</th><th scope="col">book_date</th><th scope="col">total_amount</th></tr></thead><tbody><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (book_ref)</li>
        </ul>    
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>flights</span> - таблица полётов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">flight_id</span>Идентификатор рейса</li>
            <li> <span class='sql' style="min-width: 12rem;">flight_no</span>Номер рейса</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_departure</span>Запланированное время отправления</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_arrival</span>Запланированное время прибытия</li>
            <li> <span class='sql' style="min-width: 12rem;">departure_airport</span>Аэропорт вылета</li>
            <li> <span class='sql' style="min-width: 12rem;">arrival_airport</span>Аэропорт прибытия</li>
            <li> <span class='sql' style="min-width: 12rem;">status</span>Статус рейса</li>
            <li> <span class='sql' style="min-width: 12rem;">aircraft_code</span>Код самолета, IATA</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_departure</span>Фактическое время отправления</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_arrival</span>Фактическое время прибытия</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">flight_id</th><th scope="col">flight_no</th><th scope="col">scheduled_departure</th><th scope="col">scheduled_arrival</th><th scope="col">departure_airport</th><th scope="col">arrival_airport</th><th scope="col">status</th><th scope="col">aircraft_code</th><th scope="col">actual_departure</th><th scope="col">actual_arrival</th></tr></thead><tbody><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Scheduled</td><td>319</td><td></td><td></td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (flight_id)</li>
            <li>UNIQUE CONSTRAINT, btree (flight_no, scheduled_departure)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>seats</span> - таблица мест в самолетах.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Код самолета, IATA</li>
            <li> <span class='sql'>seat_no</span>Номер места</li>
            <li> <span class='sql'>fare_conditions</span>Класс путешествия</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">aircraft_code</th><th scope="col">seat_no</th><th scope="col">fare_conditions</th></tr></thead><tbody><tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (aircraft_code) REFERENCES aircrafts(aircraft_code) ON DELETE CASCADE</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>ticket_flights</span> - привязка билетов к рейсам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Номер билета</li>
            <li> <span class='sql'>flight_id</span>Идентификатор рейса</li>
            <li> <span class='sql'>fare_conditions</span>Класс путешествия</li>
            <li> <span class='sql'>amount</span>Стоимость поездки</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">ticket_no</th><th scope="col">flight_id</th><th scope="col">fare_conditions</th><th scope="col">amount</th></tr></thead><tbody><tr><td>1</td><td>0005432159776</td><td>30625</td><td>Business</td><td>42100.00</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (flight_id) REFERENCES flights(flight_id)</li>
            <li>FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no)</li>
        </ul>    
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>tickets</span> - таблица билетов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Номер билета</li>
            <li> <span class='sql'>book_ref</span>Номер бронирования</li>
            <li> <span class='sql'>passenger_id</span>Идентификатор пассажира</li>
            <li> <span class='sql'>passenger_name</span>Имя пассажира</li>
            <li> <span class='sql'>contact_data</span>Контактная информация пассажира</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">ticket_no</th><th scope="col">book_ref</th><th scope="col">passenger_id</th><th scope="col">passenger_name</th><th scope="col">contact_data</th></tr></thead><tbody><tr><td>1</td><td>0005432000987</td><td>06B046</td><td>8149 604011</td><td>VALERIY TIKHONOV</td><td>{<br>"phone":&nbsp;"+70127117011"<br>}</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (book_ref) REFERENCES bookings(book_ref)</li>
        </ul>
    </div>
    {/literal}                         
</div>