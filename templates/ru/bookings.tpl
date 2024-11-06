<div id="db-description" class="db-description">
    <h2>База данных Bookings (PostgreSQL)</h2>
    Предметной областью этой базы данных являются рейсы авиакомпаний через различные аэропорты.
    <p>
        <a style="font-size: small; color: var(--special-text-color);" href="/images/bookings" target="ERDWindow">ER диаграмма базы данных Bookings</a>
    </p>
    <p>База данных Bookings содержит 8 таблиц:</p>
    <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
      <li><span class='sql' onclick="scrollInfoPanel('aircrafts_data_table_description')">aircrafts_data</span> - таблица самолетов.</li>
      <li><span class='sql' onclick="scrollInfoPanel('airports_data_table_description')">airports_data</span> - таблица аэропортов.</li>
      <li><span class='sql' onclick="scrollInfoPanel('boarding_passes_table_description')">boarding_passes</span> - таблица посадочных талонов.</li>
      <li><span class='sql' onclick="scrollInfoPanel('bookings_table_description')">bookings</span> - таблица бронирований.</li>
      <li><span class='sql' onclick="scrollInfoPanel('flights_table_description')">flights</span> - таблица рейсов.</li>
      <li><span class='sql' onclick="scrollInfoPanel('seats_table_description')">seats</span> - таблица мест в самолетах.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ticket_flights_table_description')">ticket_flights</span> - таблица связей билетов с рейсами.</li>
      <li><span class='sql' onclick="scrollInfoPanel('tickets_table_description')">tickets</span> - таблица билетов.</li>
    </ul>
    {assign var=add_id value=0|mt_rand:4}
    {if $add_id > 2}
      <a href="https://book24.ru/r/iuZxo?erid=LjN8KKn37" target="_blank" style="text-decoration: none;">
        <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">

          <div  style = "width: 30%;">
              <img style="width: 100%;" src="//ndc.book24.ru/resize/410x590/pim/products/images/6f/0f/018ee0c1-cb86-72ca-be63-928004a76f0f.jpg" alt="PostgreSQL Основы языка SQL : учебное пособие">
          </div>
          <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
              <div>Моргунов Евгений Павлович: PostgreSQL Основы языка SQL.</div>
              <div style="font-size: small; padding-top: 0.5em;">
                  Учебно-практическое пособие охватывает первую, базовую, часть учебного курса по языку SQL, созданного при участии российской компании Postgres Professional. 
                  Учебный материал излагается в расчете на использование СУБД PostgreSQL. 
              </div>
          </div>
        </div>
      </a>
    {else}
      <div style="display: flex; flex-direction: row; gap:5px; border: 1px solid white; padding: 0.3em; width: 98%;">
        <!-- admitad.banner: zba3p9bv14fec845fb2faf541d880b Hexlet.io -->
            <a target="_blank" rel="nofollow" href="https://dhwnh.com/g/zba3p9bv14fec845fb2faf541d880b/?i=4&subid=python-dev&erid=LatgBe2JB">
                <img style="width:100%;" border="0" src="https://aflink.ru/b/zba3p9bv14fec845fb2faf541d880b/" alt="Hexlet.io"/>
            </a>
        <!-- /admitad.banner -->
        <!-- admitad.banner: v76ghfjtdsfec845fb2fa804937a48 Читай-город -->
            <a target="_blank" rel="nofollow" href="https://kjuzv.com/g/v76ghfjtdsfec845fb2fa804937a48/?i=4&subid=200-200&erid=LatgBYH9b">
                <img style="width:100%;" border="0" src="https://aflink.ru/b/v76ghfjtdsfec845fb2fa804937a48/" alt="Читай-город"/>
            </a>
        <!-- /admitad.banner -->
      </div>
    {/if}
    {literal}
    <h3 id="aircrafts_data_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>aircrafts_data</span>
    </h3>
    Колонки: 
    <ul class="table-columns">
        <li> <span class='sql'>aircraft_code</span> – Уникальный код для каждого самолета.</li>
        <li> <span class='sql'>model</span> — Название модели самолета на английском и русском языках в формате JSON.</li>
        <li> <span class='sql'>range</span> – Дальность полета самолета в километрах.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>aircraft_code</th><th>model</th><th>range</th></tr><tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr></tbody></table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (aircraft_code)</li>
    </ul>
    <h3 id="airports_data_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>airports_data</span>
    </h3>
    Колонки: 
    <ul class="table-columns">
        <li> <span class='sql'>airport_code</span> – Уникальный код для каждого аэропорта.</li>
        <li> <span class='sql'>airport_name</span> — Название аэропорта на английском и русском языках в формате JSON.</li>
        <li> <span class='sql'>city</span> — Город аэропорта на английском и русском языках в формате JSON.</li>
        <li> <span class='sql'>coordinates</span> – Координаты аэропорта в виде POINT(долгота, широта).</li>
        <li> <span class='sql'>timezone</span> – Название часового пояса аэропорта.</li>
     </ul>
    <div class="table-wrapper">
        <table class="">
            <tbody>
                <tr><th></th><th>airport_code</th><th>airport_name</th><th>city</th><th>coordinates</th><th>timezone</th></tr>
                <tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr>
            </tbody>
        </table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (airport_code)</li>
    </ul>
    <h3 id="boarding_passes_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>boarding_passes</span>
    </h3> 
    Колонки:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> - Номер билета.</li>
        <li> <span class='sql'>flight_id</span> - Идентификатор рейса.</li>
        <li> <span class='sql'>boarding_no</span> - Номер посадочного талона.</li>
        <li> <span class='sql'>seat_no</span> - Номер места.</li>
    </ul>
    <div class="table-wrapper">
        <table class="">
            <tbody>
                <tr><th></th><th>ticket_no</th><th>flight_id</th><th>boarding_no</th><th>seat_no</th></tr>
                <tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr>
            </tbody>
        </table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
        <li>UNIQUE CONSTRAINT, btree (flight_id, boarding_no)</li>
        <li>UNIQUE CONSTRAINT, btree (flight_id, seat_no)</li>
    </ul>
    Ограничения внешнего ключа:
    <ul class="table-columns">
        <li>FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_flights(ticket_no, flight_id)</li>
    </ul>
    <h3 id="bookings_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>bookings</span>
    </h3>   
    Колонки:
    <ul class="table-columns">
        <li> <span class='sql'>book_ref</span> – Номер бронирования.</li>
        <li> <span class='sql'>book_date</span> – Дата бронирования.</li>
        <li> <span class='sql'>total_amount</span> – Общая стоимость бронирования.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (book_ref)</li>
    </ul>
    <h3 id="flights_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>flights</span>
    </h3>
    Колонки:
    <ul class="table-columns">
    <li> <span class='sql'>flight_id</span> – Идентификатор рейса.</li>
        <li> <span class='sql'>flight_no</span> – Номер рейса.</li>
        <li> <span class='sql'>scheduled_departure</span> – Запланированное время отправления.</li>
        <li> <span class='sql'>scheduled_arrival</span> – Запланированное время прибытия.</li>
        <li> <span class='sql'>departure_airport</span> – Аэропорт вылета.</li>
        <li> <span class='sql'>arrival_airport</span> – Аэропорт прибытия.</li>
        <li> <span class='sql'>status</span> – Статус рейса.</li>
        <li> <span class='sql'>aircraft_code</span> – Код самолета, IATA.</li>
        <li> <span class='sql'>actual_departure</span> – Фактическое время отправления.</li>
        <li> <span class='sql'>actual_arrival</span> – Фактическое время прибытия.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>flight_id</th><th>flight_no</th><th>scheduled_departure</th><th>scheduled_arrival</th><th>departure_airport</th><th>arrival_airport</th><th>status</th><th>aircraft_code</th><th>actual_departure</th><th>actual_arrival</th></tr><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Scheduled</td><td>319</td><td></td><td></td></tr></tbody></table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (flight_id)</li>
        <li>UNIQUE CONSTRAINT, btree (flight_no, scheduled_departure)</li>
    </ul>
    <h3 id="seats_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>seats</span>
    </h3>
    Колонки:
    <ul class="table-columns">
        <li> <span class='sql'>aircraft_code</span> – Код самолета, IATA.</li>
        <li> <span class='sql'>seat_no</span> – Номер места.</li>
        <li> <span class='sql'>fare_conditions</span> – Класс путешествия.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>aircraft_code</th><th>seat_no</th><th>fare_conditions</th></tr><tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (aircraft_code, seat_no)</li>
    </ul>
    Ограничения внешнего ключа:
    <ul class="table-columns">
        <li>FOREIGN KEY (aircraft_code) REFERENCES aircrafts(aircraft_code) ON DELETE CASCADE</li>
    </ul>
    <h3 id="ticket_flights_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>ticket_flights</span>
    </h3>
    Колонки:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> – Номер билета.</li>
        <li> <span class='sql'>flight_id</span> – Идентификатор рейса.</li>
        <li> <span class='sql'>fare_conditions</span> – Класс путешествия.</li>
        <li> <span class='sql'>сумма</span> – Стоимость поездки.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>ticket_no</th><th>flight_id</th><th>fare_conditions</th><th>amount</th></tr><tr><td>1</td><td>0005432159776</td><td>30625</td><td>Business</td><td>42100.00</td></tr></tbody></table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
    </ul>
    Ограничения внешнего ключа:
    <ul class="table-columns">
        <li>FOREIGN KEY (flight_id) REFERENCES flights(flight_id)</li>
        <li>FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no)</li>
    </ul>
    <h3 id="tickets_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>tickets</span>
    </h3>
    Колонки:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> – Номер билета.</li>
        <li> <span class='sql'>book_ref</span> – Номер бронирования.</li>
        <li> <span class='sql'>passenger_id</span> – Идентификатор пассажира.</li>
        <li> <span class='sql'>passenger_name</span> – Имя пассажира.</li>
        <li> <span class='sql'>contact_data</span> – Контактная информация пассажира.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>ticket_no</th><th>book_ref</th><th>passenger_id</th><th>passenger_name</th><th>contact_data</th></tr><tr><td>1</td><td>0005432000987</td><td>06B046</td><td>8149 604011</td><td>VALERIY TIKHONOV</td><td>{"phone": "+70127117011"}</td></tr></tbody></table>
    </div>
    Индексы:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (ticket_no)</li>
    </ul>
    Ограничения внешнего ключа:
    <ul class="table-columns">
        <li>FOREIGN KEY (book_ref) REFERENCES bookings(book_ref)</li>
    </ul>
    {/literal}
</div>