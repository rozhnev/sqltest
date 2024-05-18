<div class="db-description">
    {literal}
    <h2>Bookings database</h2>
    The subject area of this database is airline flights through various airports.
    <p>
        <a style="font-size: small; color: var(--special-text-color);" href="/images/bookings" target="ERDWindow">ER diagram of the Bookings database</a>
    </p>
    <h3>Table <span class='sql'>aircrafts_data</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>aircraft_code</span> - Unique code for each aircraft.</li>
        <li> <span class='sql'>model</span> - Aircraft model name in English and Russian in JSON format.</li>
        <li> <span class='sql'>range</span> - Aircraft fly range in kilometers.</li>
    </ul>
    Indexes:
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
    <h3>Table <span class='sql'>airports_data</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>airport_code</span> - Unique code for each airport.</li>
        <li> <span class='sql'>airport_name</span> - Airport name in English and Russian in JSON format.</li>
        <li> <span class='sql'>city</span> - Airport city in English and Russian in JSON format.</li>
        <li> <span class='sql'>coordinates</span> - Airport coordinates as POINT(longitude, latitude).</li>
        <li> <span class='sql'>timezone</span> - Airport timezone name.</li>
    </ul>
    <div class="table-wrapper">
        <table class="">
            <tbody>
                <tr><th></th><th>airport_code</th><th>airport_name</th><th>city</th><th>coordinates</th><th>timezone</th></tr>
                <tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr>
            </tbody>
        </table>
    </div>
    Indexes:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (airport_code)</li>
    </ul>
    <h3>Table <span class='sql'>boarding_passes</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> - Ticket number.</li>
        <li> <span class='sql'>flight_id</span> - Flight identificator.</li>
        <li> <span class='sql'>boarding_no</span> - Boarding pass number.</li>
        <li> <span class='sql'>seat_no</span> - Seat number.</li>
    </ul>
    <div class="table-wrapper">
        <table class="">
            <tbody>
                <tr><th></th><th>ticket_no</th><th>flight_id</th><th>boarding_no</th><th>seat_no</th></tr>
                <tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr>
            </tbody>
        </table>
    </div>
    Indexes:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
        <li>UNIQUE CONSTRAINT, btree (flight_id, boarding_no)</li>
        <li>UNIQUE CONSTRAINT, btree (flight_id, seat_no)</li>
    </ul>
    Foreign-key constraints:
    <ul class="table-columns">
        <li>FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_flights(ticket_no, flight_id)</li>
    </ul>
    <h3>Table <span class='sql'>bookings</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>book_ref</span> - Booking number.</li>
        <li> <span class='sql'>book_date</span> - Booking date.</li>
        <li> <span class='sql'>total_amount</span> - Total booking cost.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
    </div>
    Indexes:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (book_ref)</li>
    </ul>
    <h3>Table <span class='sql'>flights</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>flight_id</span> - Flight ID.</li>
        <li> <span class='sql'>flight_no</span> - Flight number.</li>
        <li> <span class='sql'>scheduled_departure</span> - Scheduled departure time.</li>
        <li> <span class='sql'>scheduled_arrival</span> - Scheduled arrival time.</li>
        <li> <span class='sql'>departure_airport</span> - Airport of departure.</li>
        <li> <span class='sql'>arrival_airport</span> - Airport of arrival.</li>
        <li> <span class='sql'>status</span> - Flight status.</li>
        <li> <span class='sql'>aircraft_code</span> - Aircraft code, IATA.</li>
        <li> <span class='sql'>actual_departure</span> - Actual departure time.</li>
        <li> <span class='sql'>actual_arrival</span> - Actual arrival time.</li>
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
    Indexes:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (flight_id)</li>
        <li>UNIQUE CONSTRAINT, btree (flight_no, scheduled_departure)</li>
    </ul>
    <h3>Table <span class='sql'>seats</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>aircraft_code</span> - Aircraft code, IATA.</li>
        <li> <span class='sql'>seat_no</span> - Seat number.</li>
        <li> <span class='sql'>fare_conditions</span> - Travel class.</li>
    </ul>
    <div class="table-wrapper">
        <table class=""><tbody><tr>
            <th></th>
            <th>aircraft_code</th><th>seat_no</th><th>fare_conditions</th>
        </tr>
        <tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
    </div>
    Indexes:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (aircraft_code, seat_no)</li>
    </ul>
    Foreign-key constraints:
    <ul class="table-columns">
        <li>FOREIGN KEY (aircraft_code) REFERENCES aircrafts(aircraft_code) ON DELETE CASCADE</li>
    </ul>
    <h3>Table <span class='sql'>ticket_flights</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> - Ticket number.</li>
        <li> <span class='sql'>flight_id</span> - Flight ID.</li>
        <li> <span class='sql'>fare_conditions</span> - Travel class.</li>
        <li> <span class='sql'>amount</span> - Travel cost.</li>
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
    Indexes:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
    </ul>
    Foreign-key constraints:
    <ul class="table-columns">
        <li>FOREIGN KEY (flight_id) REFERENCES flights(flight_id)</li>
        <li>FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no)</li>
    </ul>
    <h3>Table <span class='sql'>tickets</span></h3>
    Table columns:
    <ul class="table-columns">
        <li> <span class='sql'>ticket_no</span> - Ticket number.</li>
        <li> <span class='sql'>book_ref</span> - Booking number.</li>
        <li> <span class='sql'>passenger_id</span> - Passenger ID.</li>
        <li> <span class='sql'>passenger_name</span> - Passenger name.</li>
        <li> <span class='sql'>contact_data</span> - Passenger contact information.</li>
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
    Indexes:
    <ul class="table-columns">
        <li>PRIMARY KEY, btree (ticket_no)</li>
    </ul>
    Foreign-key constraints:
    <ul class="table-columns">
        <li>FOREIGN KEY (book_ref) REFERENCES bookings(book_ref)</li>
    </ul>    
    {/literal}
</div>