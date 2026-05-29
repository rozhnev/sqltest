<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de données Bookings : structure des tables et vue du schéma</h2>
    <p>La base Bookings (PostgreSQL) modélise les vols de compagnies aériennes entre différents aéroports et sert souvent de dataset d'entraînement SQL.</p>
    <p>Cette page présente la structure des tables, les colonnes clés et les contraintes utilisées dans des requêtes SQL analytiques et transactionnelles.</p>
    <p>La base de données Bookings contient 8 tables principales.</p>
    <p>
        <a href="/{$Lang}/erd/Bookings" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Ouvrir le schéma ER de la base Bookings dans une nouvelle fenêtre">
            <img src="/images/erd_small_light.svg" alt="Schéma ER de la base Bookings montrant les relations entre les tables" style="width: 90%;" loading="lazy" decoding="async">
            Schéma ER de la base de données Bookings
        </a>
    </p>
    <h3>Liste des tables</h3>
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
                <thead><tr><th scope="col"></th><th scope="col">aircraft_code</th><th scope="col">model</th><th scope="col">range</th></tr></thead><tbody><tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr></tbody>
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
                <thead><tr><th scope="col"></th><th scope="col">airport_code</th><th scope="col">airport_name</th><th scope="col">city</th><th scope="col">coordinates</th><th scope="col">timezone</th></tr></thead><tbody><tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr></tbody>
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
                <thead><tr><th scope="col"></th><th scope="col">ticket_no</th><th scope="col">flight_id</th><th scope="col">boarding_no</th><th scope="col">seat_no</th></tr></thead><tbody><tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr></tbody>
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
            <table class=""><thead><tr><th scope="col"></th><th scope="col">book_ref</th><th scope="col">book_date</th><th scope="col">total_amount</th></tr></thead><tbody><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
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
                </tr></thead><tbody><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>Scheduled</td><td>319</td><td></td><td></td></tr></tbody></table>
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
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">aircraft_code</th><th scope="col">seat_no</th><th scope="col">fare_conditions</th>
            </tr></thead><tbody><tr><td>1</td><td>319</td><td>2A</td><td>Business</td></tr></tbody></table>
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
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">ticket_no</th>
                <th scope="col">flight_id</th>
                <th scope="col">fare_conditions</th>
                <th scope="col">amount</th>
            </tr></thead><tbody><tr><td>1</td><td>0005432159776</td><td>30625</td><td>Business</td><td>42100.00</td></tr></tbody></table>
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
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">ticket_no</th>
                <th scope="col">book_ref</th>
                <th scope="col">passenger_id</th>
                <th scope="col">passenger_name</th>
                <th scope="col">contact_data</th></tr></thead><tbody><tr><td>1</td><td>0005432000987</td><td>06B046</td><td>8149 604011</td><td>VALERIY TIKHONOV</td><td>{"phone": "+70127117011"}</td></tr></tbody></table>
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
            {if $Book}
                <div class="book-card">
                    <a href="{{$Book.referral_link}}" target="_blank" style="text-decoration: none; color: var(--question-color);">
                        <div style="display: flex; flex-direction: row;     border: 1px solid var(--text-block-border-color);
color: var(--question-text);
border-radius: 6px; padding: 0.3em; width: 98%;">
                        <div  style = "width: 25%;">
                            <img style="width: 100%;" src="{{$Book.picture_link}}" alt="{{$Book.title|escape:"html"}}">
                        </div>
                        <div style="font-size: 1em;  width: 75%;  padding: 0 0.7em; font-weight: 100; height: 250px; overflow: auto;">
                            <div>{{$Book.title|escape:"html"}}</div>
                            <div style="font-size: small; padding-top: 0.5em;">{{$Book.description|escape:"html"}}</div>
                        </div>
                        </div>
                    </a>
                </div>
            {/if}
        </div>
    {/if}
</div>
