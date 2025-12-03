<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>База данных Countries (PostGIS)</h2>
    <p>
        База данных Countries является примером базы данных PostGIS, предназначенной для географического и геопространственного анализа. Она включает пространственную информацию о странах, столицах и данных Нью-Йорка, таких как переписные блоки, убийства, районы, улицы и станции метро, подходящих для ГИС-приложений и пространственных запросов.
    </p>
    <h3>Список таблиц:</h3>
    <div class="accordion">
        <span><span class='sql'>countries</span> — список стран с геометрией.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>уникальный идентификатор записи (PK)</li>
            <li><span class='sql'>name</span>название страны</li>
            <li><span class='sql'>border</span>геометрия страны (MultiPolygon, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>border</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Франция</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>capitals</span> — список столиц с координатами.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>уникальный идентификатор записи (PK)</li>
            <li><span class='sql'>name</span>название столицы</li>
            <li><span class='sql'>country_id</span>ссылка на страну (FK)</li>
            <li><span class='sql'>location</span>координаты столицы (Point, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>country_id</th>
                    <th>location</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Париж</td>
                    <td>1</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (id)</li>
            <li>FOREIGN KEY (country_id) REFERENCES countries(id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>nyc_census_blocks</span> — демография блоков переписи Нью-Йорка.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>уникальный идентификатор записи (PK)</li>
            <li><span class='sql'>blkid</span>ID переписного блока</li>
            <li><span class='sql'>popn_total</span>общая численность населения</li>
            <li><span class='sql'>popn_white</span>численность белого населения</li>
            <li><span class='sql'>popn_black</span>численность черного населения</li>
            <li><span class='sql'>popn_nativ</span>численность коренного населения</li>
            <li><span class='sql'>popn_asian</span>численность азиатского населения</li>
            <li><span class='sql'>popn_other</span>численность другого населения</li>
            <li><span class='sql'>boroname</span>название района</li>
            <li><span class='sql'>geom</span>геометрия переписного блока (MultiPolygon, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>gid</th>
                    <th>blkid</th>
                    <th>popn_total</th>
                    <th>popn_white</th>
                    <th>popn_black</th>
                    <th>popn_nativ</th>
                    <th>popn_asian</th>
                    <th>popn_other</th>
                    <th>boroname</th>
                    <th>geom</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>360050001001000</td>
                    <td>1000</td>
                    <td>500</td>
                    <td>200</td>
                    <td>50</td>
                    <td>150</td>
                    <td>100</td>
                    <td>Манхэттен</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>nyc_homicides</span> — инциденты убийств в Нью-Йорке.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>уникальный идентификатор записи (PK)</li>
            <li><span class='sql'>incident_d</span>дата инцидента</li>
            <li><span class='sql'>boroname</span>название района</li>
            <li><span class='sql'>num_victim</span>число жертв</li>
            <li><span class='sql'>primary_mo</span>основной мотив</li>
            <li><span class='sql'>id</span>ID инцидента</li>
            <li><span class='sql'>weapon</span>использованное оружие</li>
            <li><span class='sql'>light_dark</span>условие света или темноты</li>
            <li><span class='sql'>year</span>год инцидента</li>
            <li><span class='sql'>geom</span>местоположение инцидента (Point, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>gid</th>
                    <th>incident_d</th>
                    <th>boroname</th>
                    <th>num_victim</th>
                    <th>primary_mo</th>
                    <th>id</th>
                    <th>weapon</th>
                    <th>light_dark</th>
                    <th>year</th>
                    <th>geom</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>2003-01-01</td>
                    <td>Манхэттен</td>
                    <td>1</td>
                    <td>Неизвестно</td>
                    <td>1</td>
                    <td>Огнестрельное</td>
                    <td>D</td>
                    <td>2003</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>nyc_neighborhoods</span> — районы Нью-Йорка.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>уникальный идентификатор записи (PK)</li>
            <li><span class='sql'>boroname</span>название района</li>
            <li><span class='sql'>name</span>название района</li>
            <li><span class='sql'>geom</span>геометрия района (MultiPolygon, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>gid</th>
                    <th>boroname</th>
                    <th>name</th>
                    <th>geom</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Манхэттен</td>
                    <td>Финансовый район</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>nyc_streets</span> — улицы Нью-Йорка.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>уникальный идентификатор записи (PK)</li>
            <li><span class='sql'>id</span>ID улицы</li>
            <li><span class='sql'>name</span>название улицы</li>
            <li><span class='sql'>oneway</span>индикатор одностороннего движения</li>
            <li><span class='sql'>type</span>тип улицы</li>
            <li><span class='sql'>geom</span>геометрия улицы (LineString, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>gid</th>
                    <th>id</th>
                    <th>name</th>
                    <th>oneway</th>
                    <th>type</th>
                    <th>geom</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>Бродвей</td>
                    <td>NO</td>
                    <td>avenue</td>
                    <td>LineString(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion">
        <span><span class='sql'>nyc_subway_stations</span> — станции метро Нью-Йорка.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>уникальный идентификатор записи (PK)</li>
            <li><span class='sql'>objectid</span>ID объекта</li>
            <li><span class='sql'>id</span>ID станции</li>
            <li><span class='sql'>name</span>название станции</li>
            <li><span class='sql'>alt_name</span>альтернативное название</li>
            <li><span class='sql'>cross_st</span>перекрестная улица</li>
            <li><span class='sql'>long_name</span>длинное название</li>
            <li><span class='sql'>label</span>метка</li>
            <li><span class='sql'>borough</span>район</li>
            <li><span class='sql'>nghbhd</span>район</li>
            <li><span class='sql'>routes</span>маршруты</li>
            <li><span class='sql'>transfers</span>пересадки</li>
            <li><span class='sql'>color</span>цвет</li>
            <li><span class='sql'>express</span>индикатор экспресса</li>
            <li><span class='sql'>closed</span>индикатор закрытия</li>
            <li><span class='sql'>geom</span>местоположение станции (Point, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>gid</th>
                    <th>objectid</th>
                    <th>id</th>
                    <th>name</th>
                    <th>alt_name</th>
                    <th>cross_st</th>
                    <th>long_name</th>
                    <th>label</th>
                    <th>borough</th>
                    <th>nghbhd</th>
                    <th>routes</th>
                    <th>transfers</th>
                    <th>color</th>
                    <th>express</th>
                    <th>closed</th>
                    <th>geom</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                    <td>Таймс-сквер</td>
                    <td>Times Sq</td>
                    <td>7th Ave</td>
                    <td>Times Square-42nd Street</td>
                    <td>Times Sq</td>
                    <td>Манхэттен</td>
                    <td>Midtown</td>
                    <td>1,2,3,7,A,C,E,N,Q,R,S,W</td>
                    <td>42nd St</td>
                    <td>Красный</td>
                    <td>Да</td>
                    <td>Нет</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            <div id="yandex_rtb_R-A-4716552-7"></div>
        </div>
        {* {include file="ru/developers_channel_ad.tpl"} *}
    {/if}
</div>