<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>База данных Bookings (PostgreSQL)</h2>
    Предметной областью этой базы данных являются рейсы авиакомпаний через различные аэропорты.
    <p>
        <a class="button-erd" href="/{$Lang}/erd/Bookings" target="ERDWindow">
            ER диаграмма базы данных Bookings
        </a>
    </p>
    <h3>База данных Bookings содержит 8 таблиц:</h3>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - таблица самолетов.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Уникальный код для каждого самолета.</li>
            <li> <span class='sql'>model</span>Название модели самолета на английском и русском языках в формате JSON.</li>
            <li> <span class='sql'>range</span>Дальность полета самолета в километрах.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>aircraft_code</th><th>model</th><th>range</th></tr><tr><td>1</td><td>773</td><td>{<br>"en": "Boeing 777-300",<br>"ru": "Боинг 777-300"<br>}</td><td>11100</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>airports_data</span> - таблица аэропортов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>Уникальный код для каждого аэропорта.</li>
            <li> <span class='sql'>airport_name</span>Название аэропорта на английском и русском языках в формате JSON.</li>
            <li> <span class='sql'>city</span>Город аэропорта на английском и русском языках в формате JSON.</li>
            <li> <span class='sql'>coordinates</span>Координаты аэропорта в виде POINT(долгота, широта).</li>
            <li> <span class='sql'>timezone</span>Название часового пояса аэропорта.</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <tbody>
                    <tr><th></th><th>airport_code</th><th>airport_name</th><th>city</th><th>coordinates</th><th>timezone</th></tr>
                    <tr><td>1</td><td>YKS</td><td>{<br>"en":&nbsp;"Yakutsk&nbsp;Airport",<br>"ru": "Якутск"<br>}</td><td>{<br>"en":&nbsp;"Yakutsk",<br>"ru":&nbsp;"Якутск"<br>}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (airport_code)</li>
        </ul>    
    </div>
    <div class="accordion">
        <span><span class='sql'>boarding_passes</span> - посадочные талоны.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Номер билета.</li>
            <li> <span class='sql'>flight_id</span>Идентификатор рейса.</li>
            <li> <span class='sql'>boarding_no</span>Номер посадочного талона.</li>
            <li> <span class='sql'>seat_no</span>Номер места.</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <tbody>
                    <tr><th></th><th>ticket_no</th><th>flight_id</th><th>boarding_no</th><th>seat_no</th></tr>
                    <tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr>
                </tbody>
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
    <div class="accordion">
        <span><span class='sql'>bookings</span> - бронирования билетов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>Номер бронирования.</li>
            <li> <span class='sql'>book_date</span>Дата бронирования.</li>
            <li> <span class='sql'>total_amount</span>Общая стоимость бронирования.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (book_ref)</li>
        </ul>    
    </div>
    <div class="accordion">
        <span><span class='sql'>flights</span> - таблица полётов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 10rem;">flight_id</span>Идентификатор рейса.</li>
            <li> <span class='sql'>flight_no</span>Номер рейса.</li>
            <li> <span class='sql'>scheduled_departure</span>Запланированное время отправления.</li>
            <li> <span class='sql'>scheduled_arrival</span>Запланированное время прибытия.</li>
            <li> <span class='sql'>departure_airport</span>Аэропорт вылета.</li>
            <li> <span class='sql'>arrival_airport</span>Аэропорт прибытия.</li>
            <li> <span class='sql'>status</span>Статус рейса.</li>
            <li> <span class='sql'>aircraft_code</span>Код самолета, IATA.</li>
            <li> <span class='sql'>actual_departure</span>Фактическое время отправления.</li>
            <li> <span class='sql'>actual_arrival</span>Фактическое время прибытия.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>flight_id</th><th>flight_no</th><th>scheduled_departure</th><th>scheduled_arrival</th><th>departure_airport</th><th>arrival_airport</th><th>status</th><th>aircraft_code</th><th>actual_departure</th><th>actual_arrival</th></tr><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Scheduled</td><td>319</td><td></td><td></td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (flight_id)</li>
            <li>UNIQUE CONSTRAINT, btree (flight_no, scheduled_departure)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>seats</span> - таблица мест в самолетах.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Код самолета, IATA.</li>
            <li> <span class='sql'>seat_no</span>Номер места.</li>
            <li> <span class='sql'>fare_conditions</span>Класс путешествия.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>aircraft_code</th><th>seat_no</th><th>fare_conditions</th></tr><tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (aircraft_code) REFERENCES aircrafts(aircraft_code) ON DELETE CASCADE</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>ticket_flights</span> - привязка билетов к рейсам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Номер билета.</li>
            <li> <span class='sql'>flight_id</span>Идентификатор рейса.</li>
            <li> <span class='sql'>fare_conditions</span>Класс путешествия.</li>
            <li> <span class='sql'>сумма</span>Стоимость поездки.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>ticket_no</th><th>flight_id</th><th>fare_conditions</th><th>amount</th></tr><tr><td>1</td><td>0005432159776</td><td>30625</td><td>Business</td><td>42100.00</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (flight_id) REFERENCES flights(flight_id)</li>
            <li>FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no)</li>
        </ul>    
    </div>
    <div class="accordion">
        <span><span class='sql'>tickets</span> - таблица билетов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Номер билета.</li>
            <li> <span class='sql'>book_ref</span>Номер бронирования.</li>
            <li> <span class='sql'>passenger_id</span>Идентификатор пассажира.</li>
            <li> <span class='sql'>passenger_name</span>Имя пассажира.</li>
            <li> <span class='sql'>contact_data</span>Контактная информация пассажира.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>ticket_no</th><th>book_ref</th><th>passenger_id</th><th>passenger_name</th><th>contact_data</th></tr><tr><td>1</td><td>0005432000987</td><td>06B046</td><td>8149 604011</td><td>VALERIY TIKHONOV</td><td>{<br>"phone":&nbsp;"+70127117011"<br>}</td></tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (book_ref) REFERENCES bookings(book_ref)</li>
        </ul>
    </div>
    {/literal}                         
    {if $User->showAd()}
        {* <div class="referal-add-block">
            <div id="yandex_rtb_R-A-4716552-7"></div>
            <!-- admitad.banner: 1x05fa2531fec845fb2f47ed6832c6 Atomic Heart [CPS] RU+CIS -->
            <a target="_blank" rel="nofollow" href="https://rzekl.com/g/1x05fa2531fec845fb2f47ed6832c6/?i=4&subid=TheCharmsSeaDepths&erid=2bL9aMPo2e49hMef4piUxbAuHR">
                <img style="width:100%;" border="0" src="https://aflink.ru/b/1x05fa2531fec845fb2f47ed6832c6/" alt="Atomic Heart [CPS] RU+CIS"/>
            </a>
            <!-- /admitad.banner -->
            <a target="_blank" rel="nofollow" href="https://thevospad.com/g/dhqiqt6h41fec845fb2f69bd3583e1/?i=4&subid=free-neuronetwork&erid=LatgBSdq6">
                <img style="width:100%;" border="0" src="https://aflink.ru/b/dhqiqt6h41fec845fb2f69bd3583e1/" alt="Netology"/>
            </a>
        </div> *}
        {include file="ru/developers_channel_ad.tpl"}
    {/if}
</div>