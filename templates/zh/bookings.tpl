<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>预订数据库：表结构和模式概述</h2>
    <p>预订数据库（PostgreSQL）建模了多个机场之间的航空公司航班，广泛用于SQL练习。</p>
    <p>此页面显示了典型分析和事务SQL查询中使用的表结构、关键列和约束。</p>
    <p>预订数据库包含8个主要表。</p>
    <p>
        <a href="/{$Lang}/erd/Bookings" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="在新窗口中打开预订数据库ER图">
            <img src="/images/erd_small_light.svg" alt="预订数据库的ER图，显示表之间的关系" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            预订数据库的ER图
        </a>
    </p>
    <h3>表列表</h3>
    {literal}
    <div class="accordion active">
        <span><span class='sql'>aircrafts_data</span> - 飞机表。</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>每架飞机的唯一代码</li>
            <li> <span class='sql'>model</span>飞机型号名称，英文和俄文以JSON格式表示</li>
            <li> <span class='sql'>range</span>飞机飞行范围，单位为公里</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (aircraft_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">aircraft_code</th><th scope="col">model</th><th scope="col">range</th></tr></thead><tbody><tr><td>1</td><td>773</td><td>{"en": "Boeing 777-300", "ru": "Боинг 777-300"}</td><td>11100</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>airports_data</span> - 机场表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>airport_code</span>每个机场的唯一代码</li>
            <li> <span class='sql'>airport_name</span>机场名称，英文和俄文以JSON格式表示</li>
            <li> <span class='sql'>city</span>机场所在城市，英文和俄文以JSON格式表示</li>
            <li> <span class='sql'>coordinates</span>机场坐标，格式为POINT（经度，纬度）</li>
            <li> <span class='sql'>timezone</span>机场时区名称</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (airport_code)</li>
        </ul>
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">airport_code</th><th scope="col">airport_name</th><th scope="col">city</th><th scope="col">coordinates</th><th scope="col">timezone</th></tr></thead><tbody><tr><td>1</td><td>YKS</td><td>{"en": "Yakutsk Airport", "ru": "Якутск"}</td><td>{"en": "Yakutsk", "ru": "Якутск"}</td><td>(129.77099609375,62.0932998657227)</td><td>Asia/Yakutsk</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>boarding_passes</span> - 登机牌表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>票号</li>
            <li> <span class='sql'>flight_id</span>航班标识符</li>
            <li> <span class='sql'>boarding_no</span>登机牌号码</li>
            <li> <span class='sql'>seat_no</span>座位号码</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (ticket_no, flight_id)</li>
            <li>唯一约束，btree (flight_id, boarding_no)</li>
            <li>唯一约束，btree (flight_id, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (ticket_no, flight_id) 参考 ticket_flights(ticket_no, flight_id)</li>
        </ul>        
        <div class="table-wrapper">
            <table class="">
                <thead><tr><th scope="col"></th><th scope="col">ticket_no</th><th scope="col">flight_id</th><th scope="col">boarding_no</th><th scope="col">seat_no</th></tr></thead><tbody><tr><td>1</td><td>0005435212351</td><td>30625</td><td>1</td><td>2D</td></tr></tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>bookings</span> - 预订表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>book_ref</span>预订号码</li>
            <li> <span class='sql'>book_date</span>预订日期</li>
            <li> <span class='sql'>total_amount</span>总预订费用</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (book_ref)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr><th scope="col"></th><th scope="col">book_ref</th><th scope="col">book_date</th><th scope="col">total_amount</th></tr></thead><tbody><tr><td>1</td><td>00000F</td><td>2017-07-05 00:12:00+00</td><td>265700.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>flights</span> - 航班表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">flight_id</span>航班ID</li>
            <li> <span class='sql' style="min-width: 12rem;">flight_no</span>航班号码</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_departure</span>计划出发时间</li>
            <li> <span class='sql' style="min-width: 12rem;">scheduled_arrival</span>计划到达时间</li>
            <li> <span class='sql' style="min-width: 12rem;">departure_airport</span>出发机场</li>
            <li> <span class='sql' style="min-width: 12rem;">arrival_airport</span>到达机场</li>
            <li> <span class='sql' style="min-width: 12rem;">status</span>航班状态</li>
            <li> <span class='sql' style="min-width: 12rem;">aircraft_code</span>飞机代码，IATA</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_departure</span>实际出发时间</li>
            <li> <span class='sql' style="min-width: 12rem;">actual_arrival</span>实际到达时间</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (flight_id)</li>
            <li>唯一约束，btree (flight_no, scheduled_departure)</li>
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
                </tr></thead><tbody><tr><td>1</td><td>1185</td><td>PG0134</td><td>2017-09-10 06:50:00+00</td><td>2017-09-10 11:55:00+00</td><td>DME</td><td>BTK</td><td>计划中</td><td>319</td><td></td><td></td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>seats</span> - 飞机座位表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>aircraft_code</span>飞机代码，IATA</li>
            <li> <span class='sql'>seat_no</span>座位号码</li>
            <li> <span class='sql'>fare_conditions</span>旅行舱位</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (aircraft_code, seat_no)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (aircraft_code) 参考 aircrafts(aircraft_code) ON DELETE CASCADE</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">aircraft_code</th><th scope="col">seat_no</th><th scope="col">fare_conditions</th>
            </tr></thead><tbody><tr><td>1</td><td>319</td><td>2A</td><td>商务舱</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>ticket_flights</span> - 票与航班的关系。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>票号</li>
            <li> <span class='sql'>flight_id</span>航班ID</li>
            <li> <span class='sql'>fare_conditions</span>旅行舱位</li>
            <li> <span class='sql'>amount</span>旅行费用</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (ticket_no, flight_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (flight_id) 参考 flights(flight_id)</li>
            <li>外键 (ticket_no) 参考 tickets(ticket_no)</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                <th scope="col"></th>
                <th scope="col">ticket_no</th>
                <th scope="col">flight_id</th>
                <th scope="col">fare_conditions</th>
                <th scope="col">amount</th>
            </tr></thead><tbody><tr><td>1</td><td>0005432159776</td><td>30625</td><td>商务舱</td><td>42100.00</td></tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>tickets</span> - 票表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ticket_no</span>票号</li>
            <li> <span class='sql'>book_ref</span>预订号码</li>
            <li> <span class='sql'>passenger_id</span>乘客ID</li>
            <li> <span class='sql'>passenger_name</span>乘客姓名</li>
            <li> <span class='sql'>contact_data</span>乘客联系信息</li>
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
            <li>主键，btree (ticket_no)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (book_ref) 参考 bookings(book_ref)</li>
        </ul>   
    </div>
    {/literal}
    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>