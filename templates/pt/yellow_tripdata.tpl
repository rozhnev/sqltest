<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 13rem;
            display: inline-block;
        }
    </style>
    <h2>Conjunto de dados DuckDB yellow_tripdata</h2>
    <h3>Sobre o DuckDB</h3>
    <p>O <strong>DuckDB</strong> é um SGBD analítico incorporado, projetado para consultas rápidas em dados locais e de aplicações.</p>
    <p>Ele oferece suporte a SQL e funciona dentro da aplicação sem um processo de servidor separado. O armazenamento e a execução em colunas tornam o DuckDB adequado para analisar grandes conjuntos de dados, realizar agregações e processar arquivos CSV e Parquet.</p>
    <p>Neste playground, o DuckDB é usado para praticar SQL com um conjunto de dados de viagens de táxi.</p>
    <p><span class='sql'>yellow_tripdata</span> é um conjunto de dados educacional com viagens de táxis amarelos de Nova York.</p>
    <p>A tabela é adequada para praticar filtragem, agrupamento, ordenação, operações com datas e cálculos agregados no DuckDB.</p>
    <p>Todos os campos deste conjunto aceitam o valor <span class='sql'>NULL</span>. Não há chave primária nem restrições adicionais definidas.</p>

    <h3>Tabela yellow_tripdata</h3>
    <div class="accordion" title="Clique para expandir; clique duas vezes para inserir o nome da tabela no editor">
        <span><span class='sql'>yellow_tripdata</span> - viagens de táxi amarelo.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>VendorID</span> identificador do fornecedor do serviço de táxi.</li>
            <li><span class='sql'>tpep_pickup_datetime</span> data e hora do embarque do passageiro.</li>
            <li><span class='sql'>tpep_dropoff_datetime</span> data e hora do desembarque do passageiro.</li>
            <li><span class='sql'>passenger_count</span> número de passageiros.</li>
            <li><span class='sql'>trip_distance</span> distância da viagem.</li>
            <li><span class='sql'>RatecodeID</span> identificador do código tarifário.</li>
            <li><span class='sql'>store_and_fwd_flag</span> indica que os dados da viagem foram armazenados antes do envio.</li>
            <li><span class='sql'>PULocationID</span> identificador da zona de embarque.</li>
            <li><span class='sql'>DOLocationID</span> identificador da zona de desembarque.</li>
            <li><span class='sql'>payment_type</span> identificador do método de pagamento.</li>
            <li><span class='sql'>fare_amount</span> valor da viagem sem cobranças adicionais.</li>
            <li><span class='sql'>extra</span> cobranças adicionais.</li>
            <li><span class='sql'>mta_tax</span> imposto MTA.</li>
            <li><span class='sql'>tip_amount</span> valor da gorjeta.</li>
            <li><span class='sql'>tolls_amount</span> valor dos pedágios.</li>
            <li><span class='sql'>improvement_surcharge</span> taxa para melhoria do sistema de transporte.</li>
            <li><span class='sql'>total_amount</span> custo total da viagem.</li>
            <li><span class='sql'>congestion_surcharge</span> taxa de congestionamento.</li>
            <li><span class='sql'>Airport_fee</span> taxa aeroportuária.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <caption>Estrutura da tabela yellow_tripdata</caption>
                <thead><tr>
                    <th scope="col">Nome da coluna</th><th scope="col">Tipo</th><th scope="col">NULL</th><th scope="col">Chave</th><th scope="col">Padrão</th><th scope="col">Extra</th>
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
