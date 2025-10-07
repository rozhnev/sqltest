<div id="db-description" class="db-description">
    <h2>База данных Countries (PostGIS)</h2>
    <p>
        База данных Countries предназначена для географического и геополитического анализа. Она содержит пространственную информацию о странах и их столицах, подходит для ГИС-приложений и пространственных запросов.
    </p>
    <h3>Список таблиц:</h3>
    <div class="accordion">
        <span><span class='sql'>countries</span> — список стран с геометрией.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>уникальный идентификатор записи (PK).</li>
            <li><span class='sql'>name</span>название страны.</li>
            <li><span class='sql'>border</span>геометрия страны (MultiPolygon, SRID 4326).</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>geom</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>France</td>
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
            <li><span class='sql'>id</span>уникальный идентификатор записи (PK).</li>
            <li><span class='sql'>name</span>название столицы.</li>
            <li><span class='sql'>country_id</span>ссылка на страну (FK).</li>
            <li><span class='sql'>location</span>координаты столицы (Point, SRID 4326).</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>country_id</th>
                    <th>geom</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Paris</td>
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
    {if $User->showAd()}
        {* <div class="referal-add-block">
            <div id="yandex_rtb_R-A-4716552-7"></div>
        </div> *}
        {include file="ru/developers_channel_ad.tpl"}
    {/if}
</div>