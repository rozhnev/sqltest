<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 13rem;
            display: inline-block;
        }
    </style>
    <h2>DuckDB yellow_tripdata 数据集</h2>
    <h3>关于 DuckDB</h3>
    <p><strong>DuckDB</strong> 是一款嵌入式分析型数据库，适用于对本地数据和应用数据执行快速查询。</p>
    <p>它支持 SQL，可以直接运行在应用程序中，无需单独的服务器进程。DuckDB 采用列式存储和执行方式，非常适合分析大型数据集、进行聚合计算以及处理 CSV 和 Parquet 文件。</p>
    <p>在本 playground 中，DuckDB 用于通过出租车行程数据集练习 SQL。</p>
    <p><span class='sql'>yellow_tripdata</span> 是一个包含纽约市黄色出租车行程的学习数据集。</p>
    <p>该表适合练习筛选、分组、排序、日期操作以及在 DuckDB 中进行聚合计算。</p>
    <p>此数据集中的所有字段都允许使用 <span class='sql'>NULL</span> 值。未定义主键或其他约束。</p>

    <h3>yellow_tripdata 表</h3>
    <div class="accordion" title="点击展开，双击将表名插入编辑器">
        <span><span class='sql'>yellow_tripdata</span> - 黄色出租车行程。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>VendorID</span> 出租车服务供应商标识符。</li>
            <li><span class='sql'>tpep_pickup_datetime</span> 乘客上车的日期和时间。</li>
            <li><span class='sql'>tpep_dropoff_datetime</span> 乘客下车的日期和时间。</li>
            <li><span class='sql'>passenger_count</span> 乘客数量。</li>
            <li><span class='sql'>trip_distance</span> 行程距离。</li>
            <li><span class='sql'>RatecodeID</span> 费率代码标识符。</li>
            <li><span class='sql'>store_and_fwd_flag</span> 表示行程数据是否在转发前被暂存。</li>
            <li><span class='sql'>PULocationID</span> 上车区域标识符。</li>
            <li><span class='sql'>DOLocationID</span> 下车区域标识符。</li>
            <li><span class='sql'>payment_type</span> 付款方式标识符。</li>
            <li><span class='sql'>fare_amount</span> 不含额外费用的行程费用。</li>
            <li><span class='sql'>extra</span> 额外费用。</li>
            <li><span class='sql'>mta_tax</span> MTA 税费。</li>
            <li><span class='sql'>tip_amount</span> 小费金额。</li>
            <li><span class='sql'>tolls_amount</span> 通行费金额。</li>
            <li><span class='sql'>improvement_surcharge</span> 交通系统改善附加费。</li>
            <li><span class='sql'>total_amount</span> 行程总费用。</li>
            <li><span class='sql'>congestion_surcharge</span> 拥堵附加费。</li>
            <li><span class='sql'>Airport_fee</span> 机场费用。</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <caption>yellow_tripdata 表结构</caption>
                <thead><tr>
                    <th scope="col">列名</th><th scope="col">类型</th><th scope="col">NULL</th><th scope="col">键</th><th scope="col">默认值</th><th scope="col">其他</th>
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
