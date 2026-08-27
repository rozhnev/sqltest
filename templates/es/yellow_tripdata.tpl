<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 13rem;
            display: inline-block;
        }
    </style>
    <h2>Conjunto de datos yellow_tripdata de DuckDB</h2>
    <h3>Acerca de DuckDB</h3>
    <p><strong>DuckDB</strong> es una base de datos analítica embebida diseñada para consultas rápidas sobre datos locales y de aplicaciones.</p>
    <p>Soporta SQL y se ejecuta dentro de una aplicación sin un proceso de servidor separado. El almacenamiento columnar y la ejecución de consultas hacen que DuckDB sea adecuado para analizar grandes conjuntos de datos, agregaciones y procesar archivos CSV y Parquet.</p>
    <p>En este entorno, DuckDB se utiliza para practicar SQL con un conjunto de datos de viajes en taxi.</p>
    <p><span class='sql'>yellow_tripdata</span> es un conjunto de datos de aprendizaje que contiene viajes en taxi amarillo de la ciudad de Nueva York.</p>
    <p>La tabla es útil para practicar filtrado, agrupamiento, ordenamiento, operaciones de fecha y cálculos agregados en DuckDB.</p>
    <p>Todos los campos en este conjunto de datos permiten valores <span class='sql'>NULL</span>. No se definen claves primarias ni restricciones adicionales.</p>

    <h3>Tabla yellow_tripdata</h3>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para insertar el nombre de la tabla en el editor">
        <span><span class='sql'>yellow_tripdata</span> - viajes en taxi amarillo.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>VendorID</span> identificador del proveedor de servicio de taxi.</li>
            <li><span class='sql'>tpep_pickup_datetime</span> fecha y hora de recogida del pasajero.</li>
            <li><span class='sql'>tpep_dropoff_datetime</span> fecha y hora de entrega del pasajero.</li>
            <li><span class='sql'>passenger_count</span> número de pasajeros.</li>
            <li><span class='sql'>trip_distance</span> distancia del viaje.</li>
            <li><span class='sql'>RatecodeID</span> identificador del código de tarifa.</li>
            <li><span class='sql'>store_and_fwd_flag</span> indicador que indica que los datos del viaje fueron almacenados antes de ser enviados.</li>
            <li><span class='sql'>PULocationID</span> identificador de la zona de recogida.</li>
            <li><span class='sql'>DOLocationID</span> identificador de la zona de entrega.</li>
            <li><span class='sql'>payment_type</span> identificador del método de pago.</li>
            <li><span class='sql'>fare_amount</span> tarifa del viaje excluyendo cargos adicionales.</li>
            <li><span class='sql'>extra</span> cargos adicionales.</li>
            <li><span class='sql'>mta_tax</span> impuesto MTA.</li>
            <li><span class='sql'>tip_amount</span> monto de la propina.</li>
            <li><span class='sql'>tolls_amount</span> cargos de peaje.</li>
            <li><span class='sql'>improvement_surcharge</span> recargo por mejora del sistema de transporte.</li>
            <li><span class='sql'>total_amount</span> costo total del viaje.</li>
            <li><span class='sql'>congestion_surcharge</span> recargo por congestión.</li>
            <li><span class='sql'>Airport_fee</span> tarifa de aeropuerto.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <caption>estructura de la tabla yellow_tripdata</caption>
                <thead><tr>
                    <th scope="col">Nombre de columna</th><th scope="col">Tipo</th><th scope="col">NULL</th><th scope="col">Clave</th><th scope="col">Por defecto</th><th scope="col">Extra</th>
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