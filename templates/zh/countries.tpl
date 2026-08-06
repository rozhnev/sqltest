<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>国家数据库：表结构和地理空间概述</h2>
    <p>国家数据库（PostGIS）是一个用于地理和地理空间分析的示例数据集，使用SQL。</p>
    <p>它包括国家和首都的空间数据，以及纽约市的图层，如人口普查区、凶杀案、社区、街道和地铁站。</p>
    <p>国家数据库包含7个主要表。</p>
    <h3>表列表</h3>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>countries</span> - 包含几何形状的国家列表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>唯一记录标识符（主键）</li>
            <li><span class='sql'>name</span>国家名称</li>
            <li><span class='sql'>border</span>国家几何形状（MultiPolygon，SRID 4326）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">border</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>法国</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>capitals</span> - 包含位置的首都列表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>唯一记录标识符（主键）</li>
            <li><span class='sql'>name</span>首都名称</li>
            <li><span class='sql'>country_id</span>国家引用（外键）</li>
            <li><span class='sql'>location</span>首都位置（Point，SRID 4326）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">country_id</th>
                    <th scope="col">location</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>巴黎</td>
                    <td>1</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (id)</li>
            <li>外键 (country_id) 引用 countries(id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>nyc_census_blocks</span> - 纽约市的人口普查区及其人口数据。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>唯一记录标识符（主键）</li>
            <li><span class='sql'>blkid</span>人口普查区ID</li>
            <li><span class='sql'>popn_total</span>总人口</li>
            <li><span class='sql'>popn_white</span>白人人口</li>
            <li><span class='sql'>popn_black</span>黑人总人口</li>
            <li><span class='sql'>popn_nativ</span>本土人口</li>
            <li><span class='sql'>popn_asian</span>亚裔人口</li>
            <li><span class='sql'>popn_other</span>其他人口</li>
            <li><span class='sql'>boroname</span>区名</li>
            <li><span class='sql'>geom</span>人口普查区几何形状（MultiPolygon，SRID 4326）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">gid</th>
                    <th scope="col">blkid</th>
                    <th scope="col">popn_total</th>
                    <th scope="col">popn_white</th>
                    <th scope="col">popn_black</th>
                    <th scope="col">popn_nativ</th>
                    <th scope="col">popn_asian</th>
                    <th scope="col">popn_other</th>
                    <th scope="col">boroname</th>
                    <th scope="col">geom</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>360050001001000</td>
                    <td>1000</td>
                    <td>500</td>
                    <td>200</td>
                    <td>50</td>
                    <td>150</td>
                    <td>100</td>
                    <td>曼哈顿</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>nyc_homicides</span> - 纽约市的凶杀事件。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>唯一记录标识符（主键）</li>
            <li><span class='sql'>incident_d</span>事件日期</li>
            <li><span class='sql'>boroname</span>区名</li>
            <li><span class='sql'>num_victim</span>受害者人数</li>
            <li><span class='sql'>primary_mo</span>主要动机</li>
            <li><span class='sql'>id</span>事件ID</li>
            <li><span class='sql'>weapon</span>使用的武器</li>
            <li><span class='sql'>light_dark</span>光线或黑暗条件</li>
            <li><span class='sql'>year</span>事件年份</li>
            <li><span class='sql'>geom</span>事件位置（Point，SRID 4326）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">gid</th>
                    <th scope="col">incident_d</th>
                    <th scope="col">boroname</th>
                    <th scope="col">num_victim</th>
                    <th scope="col">primary_mo</th>
                    <th scope="col">id</th>
                    <th scope="col">weapon</th>
                    <th scope="col">light_dark</th>
                    <th scope="col">year</th>
                    <th scope="col">geom</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>2003-01-01</td>
                    <td>曼哈顿</td>
                    <td>1</td>
                    <td>未知</td>
                    <td>1</td>
                    <td>火器</td>
                    <td>D</td>
                    <td>2003</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>nyc_neighborhoods</span> - 纽约市的社区。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>唯一记录标识符（主键）</li>
            <li><span class='sql'>boroname</span>区名</li>
            <li><span class='sql'>name</span>社区名称</li>
            <li><span class='sql'>geom</span>社区几何形状（MultiPolygon，SRID 4326）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">gid</th>
                    <th scope="col">boroname</th>
                    <th scope="col">name</th>
                    <th scope="col">geom</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>曼哈顿</td>
                    <td>金融区</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>nyc_streets</span> - 纽约市的街道。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>唯一记录标识符（主键）</li>
            <li><span class='sql'>id</span>街道ID</li>
            <li><span class='sql'>name</span>街道名称</li>
            <li><span class='sql'>oneway</span>单行道指示</li>
            <li><span class='sql'>type</span>街道类型</li>
            <li><span class='sql'>geom</span>街道几何形状（LineString，SRID 4326）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">gid</th>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">oneway</th>
                    <th scope="col">type</th>
                    <th scope="col">geom</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>1</td>
                    <td>百老汇</td>
                    <td>否</td>
                    <td>大道</td>
                    <td>LineString(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>nyc_subway_stations</span> - 纽约市的地铁站。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>唯一记录标识符（主键）</li>
            <li><span class='sql'>objectid</span>对象ID</li>
            <li><span class='sql'>id</span>车站ID</li>
            <li><span class='sql'>name</span>车站名称</li>
            <li><span class='sql'>alt_name</span>替代名称</li>
            <li><span class='sql'>cross_st</span>交叉街道</li>
            <li><span class='sql'>long_name</span>长名称</li>
            <li><span class='sql'>label</span>标签</li>
            <li><span class='sql'>borough</span>区</li>
            <li><span class='sql'>nghbhd</span>社区</li>
            <li><span class='sql'>routes</span>路线</li>
            <li><span class='sql'>transfers</span>换乘</li>
            <li><span class='sql'>color</span>颜色</li>
            <li><span class='sql'>express</span>快车指示</li>
            <li><span class='sql'>closed</span>关闭指示</li>
            <li><span class='sql'>geom</span>车站位置（Point，SRID 4326）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">gid</th>
                    <th scope="col">objectid</th>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">alt_name</th>
                    <th scope="col">cross_st</th>
                    <th scope="col">long_name</th>
                    <th scope="col">label</th>
                    <th scope="col">borough</th>
                    <th scope="col">nghbhd</th>
                    <th scope="col">routes</th>
                    <th scope="col">transfers</th>
                    <th scope="col">color</th>
                    <th scope="col">express</th>
                    <th scope="col">closed</th>
                    <th scope="col">geom</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                    <td>时代广场</td>
                    <td>时代广场</td>
                    <td>第七大道</td>
                    <td>时代广场-42街</td>
                    <td>时代广场</td>
                    <td>曼哈顿</td>
                    <td>中城</td>
                    <td>1,2,3,7,A,C,E,N,Q,R,S,W</td>
                    <td>42街</td>
                    <td>红色</td>
                    <td>是</td>
                    <td>否</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (gid)</li>
        </ul>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>