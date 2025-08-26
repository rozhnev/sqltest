<div id="db-description" class="db-description">
    <h2>Banco de Dados Countries (PostGIS)</h2>
    <p>
        O banco de dados Countries foi projetado para análise geográfica e geopolítica. Ele contém informações espaciais sobre países e suas capitais, adequado para aplicações GIS e consultas espaciais.
    </p>
    <h3>Lista de Tabelas:</h3>
    <div class="accordion">
        <span><span class='sql'>countries</span> - lista de países com geometria.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identificador único do registro (PK).</li>
            <li><span class='sql'>name</span>nome do país.</li>
            <li><span class='sql'>border</span>geometria do país (MultiPolygon, SRID 4326).</li>
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
        <span><span class='sql'>capitals</span> - lista de capitais com localização.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identificador único do registro (PK).</li>
            <li><span class='sql'>name</span>nome da capital.</li>
            <li><span class='sql'>country_id</span>referência ao país (FK).</li>
            <li><span class='sql'>location</span>localização da capital (Point, SRID 4326).</li>
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