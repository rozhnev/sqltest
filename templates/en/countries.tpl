<div id="db-description" class="db-description">
    <h2>Countries Database (PostGIS)</h2>
    <p>
        The Countries database is designed for geographic and geopolitical data analysis. It contains spatial information about countries and their capitals, suitable for GIS applications and spatial queries.
    </p>
    <h3>Table List:</h3>
    <div class="accordion">
        <span><span class='sql'>countries</span> - list of countries with geometry.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>unique record identifier (PK).</li>
            <li><span class='sql'>name</span>country name.</li>
            <li><span class='sql'>geom</span>country geometry (MultiPolygon, SRID 4326).</li>
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
        <span><span class='sql'>capitals</span> - list of capitals with location.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>unique record identifier (PK).</li>
            <li><span class='sql'>name</span>capital name.</li>
            <li><span class='sql'>country_id</span>reference to country (FK).</li>
            <li><span class='sql'>geom</span>capital location (Point, SRID 4326).</li>
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
        <div class="referal-add-block">
            <div id="yandex_rtb_R-A-4716552-7"></div>
        </div>
    {/if}
</div>