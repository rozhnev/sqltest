<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 13rem;
            display: inline-block;
        }
    </style>
    <h2>Jeu de données DuckDB yellow_tripdata</h2>
    <h3>À propos de DuckDB</h3>
    <p><strong>DuckDB</strong> est un SGBD analytique embarqué, conçu pour exécuter rapidement des requêtes sur des données locales et applicatives.</p>
    <p>Il prend en charge SQL et fonctionne dans l'application sans processus serveur séparé. Son stockage et son exécution en colonnes le rendent adapté à l'analyse de grands jeux de données, aux agrégations et au traitement de fichiers CSV et Parquet.</p>
    <p>Dans ce playground, DuckDB sert à pratiquer SQL avec un jeu de données consacré aux trajets en taxi.</p>
    <p><span class='sql'>yellow_tripdata</span> est un jeu de données pédagogique contenant des trajets de taxis jaunes de New York.</p>
    <p>Cette table permet de pratiquer le filtrage, le regroupement, le tri, les opérations sur les dates et les calculs d'agrégats dans DuckDB.</p>
    <p>Tous les champs de ce jeu de données acceptent la valeur <span class='sql'>NULL</span>. Aucune clé primaire ni contrainte supplémentaire n'est définie.</p>

    <h3>Table yellow_tripdata</h3>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour insérer le nom de la table dans l'éditeur">
        <span><span class='sql'>yellow_tripdata</span> - trajets en taxi jaune.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>VendorID</span> identifiant du fournisseur du service de taxi.</li>
            <li><span class='sql'>tpep_pickup_datetime</span> date et heure de prise en charge du passager.</li>
            <li><span class='sql'>tpep_dropoff_datetime</span> date et heure de dépose du passager.</li>
            <li><span class='sql'>passenger_count</span> nombre de passagers.</li>
            <li><span class='sql'>trip_distance</span> distance du trajet.</li>
            <li><span class='sql'>RatecodeID</span> identifiant du tarif.</li>
            <li><span class='sql'>store_and_fwd_flag</span> indique que les données du trajet ont été stockées avant leur transmission.</li>
            <li><span class='sql'>PULocationID</span> identifiant de la zone de prise en charge.</li>
            <li><span class='sql'>DOLocationID</span> identifiant de la zone de dépose.</li>
            <li><span class='sql'>payment_type</span> identifiant du mode de paiement.</li>
            <li><span class='sql'>fare_amount</span> prix du trajet hors frais supplémentaires.</li>
            <li><span class='sql'>extra</span> frais supplémentaires.</li>
            <li><span class='sql'>mta_tax</span> taxe MTA.</li>
            <li><span class='sql'>tip_amount</span> montant du pourboire.</li>
            <li><span class='sql'>tolls_amount</span> montant des péages.</li>
            <li><span class='sql'>improvement_surcharge</span> contribution à l'amélioration du réseau de transport.</li>
            <li><span class='sql'>total_amount</span> coût total du trajet.</li>
            <li><span class='sql'>congestion_surcharge</span> contribution pour la congestion.</li>
            <li><span class='sql'>Airport_fee</span> frais d'aéroport.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <caption>Structure de la table yellow_tripdata</caption>
                <thead><tr>
                    <th scope="col">Nom de la colonne</th><th scope="col">Type</th><th scope="col">NULL</th><th scope="col">Clé</th><th scope="col">Valeur par défaut</th><th scope="col">Informations supplémentaires</th>
                </tr></thead>
                <tbody>
                    <tr><td>VendorID</td><td>INTEGER</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>tpep_pickup_datetime</td><td>TIMESTAMP</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>tpep_dropoff_datetime</td><td>TIMESTAMP</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>passenger_count</td><td>BIGINT</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>trip_distance</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>RatecodeID</td><td>BIGINT</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>store_and_fwd_flag</td><td>VARCHAR</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>PULocationID</td><td>INTEGER</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>DOLocationID</td><td>INTEGER</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>payment_type</td><td>BIGINT</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>fare_amount</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>extra</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>mta_tax</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>tip_amount</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>tolls_amount</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>improvement_surcharge</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>total_amount</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>congestion_surcharge</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                    <tr><td>Airport_fee</td><td>DOUBLE</td><td>YES</td><td>[null]</td><td>[null]</td><td>[null]</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
