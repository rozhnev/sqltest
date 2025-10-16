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
        <style>
            /* Base styles for the container */
            .talkpal-ad-container {
                width: 250px; /* Fixed width as requested */
                height: 360px; /* Fixed height as requested */
                background-color: #F0F2F5; /* Light grey, often a neutral background on tech sites. ADJUST THIS to match sqltest.online background! */
                border: 1px solid #C0C0C0; /* Soft border. ADJUST THIS to match sqltest.online border/divider color! */
                border-radius: 8px; /* Slightly rounded corners */
                overflow: hidden; /* Ensure content stays within bounds */
                font-family: Arial, sans-serif; /* Common web font. ADJUST THIS if sqltest.online uses a specific font! */
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Distribute space between elements */
                align-items: center;
                box-sizing: border-box; /* Include padding in width/height */
                text-decoration: none; /* Remove underline from the link */
                color: inherit; /* Inherit color for text */
                transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; /* Smooth hover effects */
            }

            .talkpal-ad-container:hover {
                transform: translateY(-3px); /* Slightly lift on hover */
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); /* Subtle shadow on hover */
            }

            /* Logo styling */
            .talkpal-ad-logo {
                max-width: 80%; /* Ensure logo fits */
                max-height: 80px; /* Limit logo height */
                height: auto;
                display: block; /* Remove extra space below image */
                margin-bottom: 15px; /* Space below logo */
            }

            /* Text styling */
            .talkpal-ad-text {
                font-size: 18px; /* Slightly larger heading */
                font-weight: bold;
                color: #333333; /* Dark grey text. ADJUST THIS to match sqltest.online text color! */
                margin-bottom: 10px; /* Space below heading */
                line-height: 1.3;
            }

            .talkpal-ad-subtext {
                font-size: 14px;
                color: #555555; /* Slightly lighter text. ADJUST THIS! */
                line-height: 1.4;
                margin-bottom: 20px; /* Space above button */
            }

            /* Call to action button styling */
            .talkpal-ad-button {
                display: inline-block;
                background-color: #007bff; /* A common "call to action" blue. ADJUST THIS to match sqltest.online primary button color or a complementary accent! */
                color: #ffffff; /* White text on button */
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none; /* Remove underline */
                transition: background-color 0.2s ease-in-out;
                margin-top: auto; /* Push button to the bottom */
            }

            .talkpal-ad-button:hover {
                background-color: #0056b3; /* Darker shade on hover */
            }
        </style>

        <div style="display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; margin-top: 1rem;">
            <a href="https://talkpal.ai/" target="_blank" class="talkpal-ad-container" style="padding: 15px 10px;">
                <img src="https://files.talkpal.ai/landing_images/talkpal-text-logo.svg" alt="Talkpal AI Logo" class="talkpal-ad-logo">
                <div class="talkpal-ad-text">The fun and effective way to learn a language with AI!</div>
                <div class="talkpal-ad-subtext">Practice speaking, listening & writing.</div>
                <span class="talkpal-ad-button">Start Learning Now</span>
            </a>
            <a href="https://www.jdoqocy.com/click-101541078-17083149" target="_blank" class="talkpal-ad-container">
                <img src="https://www.ftjcfx.com/image-101541078-17083149" width="250" height="360" alt="" border="0"/>
            </a>
        </div>
    {/if}
</div>