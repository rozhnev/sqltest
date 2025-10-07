<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Bookings Database (PostgreSQL)</h2>
    The subject area of this database is airline flights through various airports.
    <p>
        <a class="button-erd" href="/{$Lang}/erd/Bookings" target="ERDWindow">
            ER diagram of the Bookings database
        </a>
    </p>
    <h3>The Bookings Database contains 8 tables:</h3>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - table of aircrafts.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Unique code for each aircraft.</li>
            <li> <span class='sql'>model</span>Aircraft model name in English and Russian in JSON format.</li>
            <li> <span class='sql'>range</span>Aircraft fly range in kilometers.</li>
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
        <span><span class='sql'>airports_data</span> - table of airports.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>Unique code for each airport.</li>
            <li> <span class='sql'>airport_name</span>Airport name in English and Russian in JSON format.</li>
            <li> <span class='sql'>city</span>Airport city in English and Russian in JSON format.</li>
            <li> <span class='sql'>coordinates</span>Airport coordinates as POINT(longitude, latitude).</li>
            <li> <span class='sql'>timezone</span>Airport timezone name.</li>
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
        <span><span class='sql'>boarding_passes</span> - table of boarding passes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Ticket number.</li>
            <li> <span class='sql'>flight_id</span>Flight identificator.</li>
            <li> <span class='sql'>boarding_no</span>Boarding pass number.</li>
            <li> <span class='sql'>seat_no</span>Seat number.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
            <li>UNIQUE CONSTRAINT, btree (flight_id, boarding_no)</li>
            <li>UNIQUE CONSTRAINT, btree (flight_id, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_flights(ticket_no, flight_id)</li>
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
        <span><span class='sql'>bookings</span> - table of bookings.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>Booking number.</li>
            <li> <span class='sql'>book_date</span>Booking date.</li>
            <li> <span class='sql'>total_amount</span>Total booking cost.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (book_ref)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>flights</span> - table of flights.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>flight_id</span>Flight ID.</li>
            <li> <span class='sql'>flight_no</span>Flight number.</li>
            <li> <span class='sql'>scheduled_departure</span>Scheduled departure time.</li>
            <li> <span class='sql'>scheduled_arrival</span>Scheduled arrival time.</li>
            <li> <span class='sql'>departure_airport</span>Airport of departure.</li>
            <li> <span class='sql'>arrival_airport</span>Airport of arrival.</li>
            <li> <span class='sql'>status</span>Flight status.</li>
            <li> <span class='sql'>aircraft_code</span>Aircraft code, IATA.</li>
            <li> <span class='sql'>actual_departure</span>Actual departure time.</li>
            <li> <span class='sql'>actual_arrival</span>Actual arrival time.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (flight_id)</li>
            <li>UNIQUE CONSTRAINT, btree (flight_no, scheduled_departure)</li>
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
        <span><span class='sql'>seats</span> - table of aircraft seats.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Aircraft code, IATA.</li>
            <li> <span class='sql'>seat_no</span>Seat number.</li>
            <li> <span class='sql'>fare_conditions</span>Travel class.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (aircraft_code, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (aircraft_code) REFERENCES aircrafts(aircraft_code) ON DELETE CASCADE</li>
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
        <span><span class='sql'>ticket_flights</span> - ticket to flights relations.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Ticket number.</li>
            <li> <span class='sql'>flight_id</span>Flight ID.</li>
            <li> <span class='sql'>fare_conditions</span>Travel class.</li>
            <li> <span class='sql'>amount</span>Travel cost.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ticket_no, flight_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (flight_id) REFERENCES flights(flight_id)</li>
            <li>FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no)</li>
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
        <span><span class='sql'>tickets</span> - table of tickets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Ticket number.</li>
            <li> <span class='sql'>book_ref</span>Booking number.</li>
            <li> <span class='sql'>passenger_id</span>Passenger ID.</li>
            <li> <span class='sql'>passenger_name</span>Passenger name.</li>
            <li> <span class='sql'>contact_data</span>Passenger contact information.</li>
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
        <a id="spzn:child~SlXhnSS5RzWS8wv-b82-Pw" 
            href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3Achild%7ESlXhnSS5RzWS8wv-b82-Pw&u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fbi-foundations-sql-etl-data-warehouse&intsrc=PUI2_9419"            target="_blank"
            style="
                display: block;
                max-width: 48%;
                height: 200px;
                background: url('https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/27/a156f51493441cb45d0a9ec83b22f9/ETL-Specialization-1200x1200.jpg?auto=format%2Ccompress&dpr=1&w=200&h=200&fit=crop') no-repeat;
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
    </div> *}
    <style>
            .banner-container {
                width: 100%;
                max-width: 728px; /* Common banner width (e.g., leaderboard) */
                background-color: #336699; /* Professional blue */
                color: #ffffff; /* White text */
                padding: 20px 30px;
                box-sizing: border-box;
                text-align: center;
                border-radius: 8px;
                border: 1px solid white;
                margin: 1rem 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                position: relative;
            }
            .banner-container a {
                text-decoration: none;
                color: inherit; /* Inherit white color */
                display: block; /* Make the whole banner clickable */
            }
            .banner-title {
                font-size: 2.2em; /* Larger font for the main title */
                font-weight: bold;
                margin-bottom: 10px;
                line-height: 1.2;
            }
            .banner-slogan {
                font-size: 1.1em;
                margin-bottom: 20px;
                opacity: 0.9;
            }
            .banner-button {
                display: inline-block;
                background-color: #ff9900; /* Vibrant orange for call to action */
                color: #333333; /* Dark text for contrast */
                padding: 12px 25px;
                border-radius: 5px;
                font-size: 1.0em;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }
            .banner-button:hover {
                background-color: #e68a00; /* Darker orange on hover */
            }

            /* Optional: Responsive adjustments */
            @media (max-width: 768px) {
                .banner-container {
                    max-width: 90%;
                    padding: 15px 20px;
                }
                .banner-title {
                    font-size: 1.8em;
                }
                .banner-slogan {
                    font-size: 1.0em;
                }
                .banner-button {
                    padding: 10px 20px;
                    font-size: 0.9em;
                }
            }
            @media (max-width: 480px) {
                .banner-title {
                    font-size: 1.5em;
                }
                .banner-slogan {
                    font-size: 0.9em;
                }
            }
        </style>
        <div class="banner-container">
            <a href="https://dbfrontiers.net/" target="_blank" rel="noopener noreferrer">
                <div class="banner-title">Database Frontiers</div>
                <div class="banner-slogan">Premier Conference for Database Professionals</div>
                <div class="banner-button">Learn More</div>
            </a>
        </div>
    {/if}
</div>