<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de données Bookings (PostgreSQL)</h2>
    Le domaine de cette base de données est le transport aérien via divers aéroports. La base de données Bookings contient 8 tables.
    <p>
        <a href="/{$Lang}/erd/Bookings" target="ERDWindow" style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
            <img src="/images/erd_small_light.jpg" alt="Schéma ER de la base de données Bookings" style="width: 90%;">
            Schéma ER de la base de données Bookings
        </a>
    </p>
    <h3>Liste des tables :</h3>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - table des avions.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Code unique pour chaque avion</li>
            <li> <span class='sql'>model</span>Nom du modèle d'avion en anglais et en russe au format JSON</li>
            <li> <span class='sql'>range</span>Autonomie de l'avion en kilomètres</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>airports_data</span> - table des aéroports.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>Code unique pour chaque aéroport</li>
            <li> <span class='sql'>airport_name</span>Nom de l'aéroport en anglais et en russe au format JSON</li>
            <li> <span class='sql'>city</span>Ville de l'aéroport en anglais et en russe au format JSON</li>
            <li> <span class='sql'>coordinates</span>Coordonnées de l'aéroport au format POINT(longitude, latitude)</li>
            <li> <span class='sql'>timezone</span>Fuseau horaire de l'aéroport</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>boarding_passes</span> - table des cartes d'embarquement.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Numéro de billet</li>
            <li> <span class='sql'>flight_id</span>Identifiant du vol</li>
            <li> <span class='sql'>boarding_no</span>Numéro de carte d'embarquement</li>
            <li> <span class='sql'>seat_no</span>Numéro de siège</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>bookings</span> - table des réservations.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>Numéro de réservation</li>
            <li> <span class='sql'>book_date</span>Date de réservation</li>
            <li> <span class='sql'>total_amount</span>Coût total de la réservation</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (book_ref)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody><tr><th></th><th>book_ref</th><th>book_date</th><th>total_amount</th></tr><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>flights</span> - table des vols.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">flight_id</span>ID de vol</li>
            <li> <span class='sql' style="min-width: 12rem;">flight_no</span>Numéro de vol</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_departure</span>Heure de départ prévue</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_arrival</span>Heure d'arrivée prévue</li>
            <li> <span class='sql' style="min-width: 12rem;">departure_airport</span>Aéroport de départ</li>
            <li> <span class='sql' style="min-width: 12rem;">arrival_airport</span>Aéroport d'arrivée</li>
            <li> <span class='sql' style="min-width: 12rem;">status</span>Statut du vol</li>
            <li> <span class='sql' style="min-width: 12rem;">aircraft_code</span>Code avion (IATA)</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_departure</span>Heure de départ réelle</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_arrival</span>Heure d'arrivée réelle</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>seats</span> - table des sièges d'avions.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>Code avion (IATA)</li>
            <li> <span class='sql'>seat_no</span>Numéro de siège</li>
            <li> <span class='sql'>fare_conditions</span>Classe de voyage</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>ticket_flights</span> - relations entre billets et vols.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Numéro de billet</li>
            <li> <span class='sql'>flight_id</span>ID de vol</li>
            <li> <span class='sql'>fare_conditions</span>Classe de voyage</li>
            <li> <span class='sql'>amount</span>Coût du voyage</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>tickets</span> - table des billets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>Numéro de billet</li>
            <li> <span class='sql'>book_ref</span>Numéro de réservation</li>
            <li> <span class='sql'>passenger_id</span>Identifiant du passager</li>
            <li> <span class='sql'>passenger_name</span>Nom du passager</li>
            <li> <span class='sql'>contact_data</span>Informations de contact du passager</li>
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
        <div class="referal-add-block">
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div>
    {/if}
</div>
