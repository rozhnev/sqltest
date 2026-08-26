<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 13rem;
            display: inline-block;
        }
    </style>
    <h2>Набор данных DuckDB yellow_tripdata</h2>
    <h3>О DuckDB</h3>
    <p><strong>DuckDB</strong> - встраиваемая аналитическая СУБД, предназначенная для быстрых запросов к локальным и прикладным данным.</p>
    <p>Она поддерживает SQL и работает внутри приложения без отдельного серверного процесса. Колоночное хранение и выполнение запросов делают DuckDB удобной для анализа больших наборов данных, агрегаций и обработки файлов CSV и Parquet.</p>
    <p>В этом playground DuckDB используется для практики SQL на примере набора данных о поездках такси.</p>
    <p><span class='sql'>yellow_tripdata</span> - учебный набор данных о поездках на жёлтых такси Нью-Йорка.</p>
    <p>Таблица подходит для практики фильтрации, группировки, сортировки, работы с датами и расчёта агрегатных показателей в DuckDB.</p>
    <p>Все поля в наборе допускают значение <span class='sql'>NULL</span>. Первичный ключ и дополнительные ограничения не заданы.</p>

    <h3>Таблица yellow_tripdata</h3>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени таблицы в редактор">
        <span><span class='sql'>yellow_tripdata</span> - поездки на жёлтых такси.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>VendorID</span> идентификатор поставщика сервиса такси.</li>
            <li><span class='sql'>tpep_pickup_datetime</span> дата и время посадки пассажира.</li>
            <li><span class='sql'>tpep_dropoff_datetime</span> дата и время высадки пассажира.</li>
            <li><span class='sql'>passenger_count</span> количество пассажиров.</li>
            <li><span class='sql'>trip_distance</span> расстояние поездки.</li>
            <li><span class='sql'>RatecodeID</span> идентификатор тарифного плана.</li>
            <li><span class='sql'>store_and_fwd_flag</span> признак хранения данных поездки перед отправкой.</li>
            <li><span class='sql'>PULocationID</span> идентификатор зоны посадки.</li>
            <li><span class='sql'>DOLocationID</span> идентификатор зоны высадки.</li>
            <li><span class='sql'>payment_type</span> идентификатор способа оплаты.</li>
            <li><span class='sql'>fare_amount</span> стоимость поездки без дополнительных сборов.</li>
            <li><span class='sql'>extra</span> дополнительные сборы.</li>
            <li><span class='sql'>mta_tax</span> налог MTA.</li>
            <li><span class='sql'>tip_amount</span> сумма чаевых.</li>
            <li><span class='sql'>tolls_amount</span> сумма платежей за платные дороги.</li>
            <li><span class='sql'>improvement_surcharge</span> сбор на улучшение транспортной системы.</li>
            <li><span class='sql'>total_amount</span> итоговая стоимость поездки.</li>
            <li><span class='sql'>congestion_surcharge</span> сбор за дорожную загруженность.</li>
            <li><span class='sql'>Airport_fee</span> сбор аэропорта.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <caption>Структура таблицы yellow_tripdata</caption>
                <thead>
                    <tr>
                        <th scope="col">Имя столбца</th>
                        <th scope="col">Тип</th>
                        <th scope="col">NULL</th>
                        <th scope="col">Ключ</th>
                        <th scope="col">По умолчанию</th>
                        <th scope="col">Дополнительно</th>
                    </tr>
                </thead>
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