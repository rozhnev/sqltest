<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 13rem;
            display: inline-block;
        }
    </style>
    <h2>DuckDB yellow_tripdata Dataset</h2>
    <h3>About DuckDB</h3>
    <p><strong>DuckDB</strong> is an embedded analytical database designed for fast queries over local and application data.</p>
    <p>It supports SQL and runs inside an application without a separate server process. Columnar storage and query execution make DuckDB well suited for analyzing large datasets, aggregations, and processing CSV and Parquet files.</p>
    <p>In this playground, DuckDB is used to practice SQL with a taxi trip dataset.</p>
    <p><span class='sql'>yellow_tripdata</span> is a learning dataset containing New York City yellow taxi trips.</p>
    <p>The table is useful for practicing filtering, grouping, sorting, date operations, and aggregate calculations in DuckDB.</p>
    <p>All fields in this dataset allow <span class='sql'>NULL</span> values. No primary key or additional constraints are defined.</p>

    <h3>yellow_tripdata Table</h3>
    <div class="accordion" title="Click to expand, double-click to insert the table name into the editor">
        <span><span class='sql'>yellow_tripdata</span> - yellow taxi trips.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>VendorID</span> taxi service provider identifier.</li>
            <li><span class='sql'>tpep_pickup_datetime</span> passenger pickup date and time.</li>
            <li><span class='sql'>tpep_dropoff_datetime</span> passenger drop-off date and time.</li>
            <li><span class='sql'>passenger_count</span> number of passengers.</li>
            <li><span class='sql'>trip_distance</span> trip distance.</li>
            <li><span class='sql'>RatecodeID</span> rate code identifier.</li>
            <li><span class='sql'>store_and_fwd_flag</span> flag indicating that trip data was stored before forwarding.</li>
            <li><span class='sql'>PULocationID</span> pickup zone identifier.</li>
            <li><span class='sql'>DOLocationID</span> drop-off zone identifier.</li>
            <li><span class='sql'>payment_type</span> payment method identifier.</li>
            <li><span class='sql'>fare_amount</span> trip fare excluding additional charges.</li>
            <li><span class='sql'>extra</span> additional charges.</li>
            <li><span class='sql'>mta_tax</span> MTA tax.</li>
            <li><span class='sql'>tip_amount</span> tip amount.</li>
            <li><span class='sql'>tolls_amount</span> toll charges.</li>
            <li><span class='sql'>improvement_surcharge</span> transportation system improvement surcharge.</li>
            <li><span class='sql'>total_amount</span> total trip cost.</li>
            <li><span class='sql'>congestion_surcharge</span> congestion surcharge.</li>
            <li><span class='sql'>Airport_fee</span> airport fee.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <caption>yellow_tripdata table structure</caption>
                <thead><tr>
                    <th scope="col">Column name</th><th scope="col">Type</th><th scope="col">NULL</th><th scope="col">Key</th><th scope="col">Default</th><th scope="col">Extra</th>
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
