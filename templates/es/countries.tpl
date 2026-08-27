<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>Base de Datos de Países: estructura de tabla y visión geoespacial</h2>
    <p>La base de datos de Países (PostGIS) es un conjunto de datos de muestra para análisis geográfico y geoespacial con SQL.</p>
    <p>Incluye datos espaciales para países y capitales, además de capas de la ciudad de Nueva York como bloques de censo, homicidios, barrios, calles y estaciones de metro.</p>
    <p>La base de datos de Países contiene 7 tablas principales.</p>
    <h3>Lista de tablas</h3>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>countries</span> - lista de países con geometría.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identificador único de registro (PK)</li>
            <li><span class='sql'>name</span>nombre del país</li>
            <li><span class='sql'>border</span>geometría del país (MultiPolygon, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">border</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>Francia</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>capitals</span> - lista de capitales con ubicación.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identificador único de registro (PK)</li>
            <li><span class='sql'>name</span>nombre de la capital</li>
            <li><span class='sql'>country_id</span>referencia al país (FK)</li>
            <li><span class='sql'>location</span>ubicación de la capital (Point, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">country_id</th>
                    <th scope="col">location</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>París</td>
                    <td>1</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (id)</li>
            <li>CLAVE FORÁNEA (country_id) REFERENCIAS countries(id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>nyc_census_blocks</span> - bloques de censo de la ciudad de Nueva York con datos demográficos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único de registro (PK)</li>
            <li><span class='sql'>blkid</span>ID del bloque de censo</li>
            <li><span class='sql'>popn_total</span>población total</li>
            <li><span class='sql'>popn_white</span>población blanca</li>
            <li><span class='sql'>popn_black</span>población negra</li>
            <li><span class='sql'>popn_nativ</span>población nativa</li>
            <li><span class='sql'>popn_asian</span>población asiática</li>
            <li><span class='sql'>popn_other</span>otra población</li>
            <li><span class='sql'>boroname</span>nombre del barrio</li>
            <li><span class='sql'>geom</span>geometría del bloque de censo (MultiPolygon, SRID 4326)</li>
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
                    <td>Manhattan</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>nyc_homicides</span> - incidentes de homicidio en la ciudad de Nueva York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único de registro (PK)</li>
            <li><span class='sql'>incident_d</span>fecha del incidente</li>
            <li><span class='sql'>boroname</span>nombre del barrio</li>
            <li><span class='sql'>num_victim</span>número de víctimas</li>
            <li><span class='sql'>primary_mo</span>motivo principal</li>
            <li><span class='sql'>id</span>ID del incidente</li>
            <li><span class='sql'>weapon</span>arma utilizada</li>
            <li><span class='sql'>light_dark</span>condición de luz o oscuridad</li>
            <li><span class='sql'>year</span>año del incidente</li>
            <li><span class='sql'>geom</span>ubicación del incidente (Point, SRID 4326)</li>
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
                    <td>Manhattan</td>
                    <td>1</td>
                    <td>Desconocido</td>
                    <td>1</td>
                    <td>Arma de fuego</td>
                    <td>D</td>
                    <td>2003</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>nyc_neighborhoods</span> - barrios de la ciudad de Nueva York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único de registro (PK)</li>
            <li><span class='sql'>boroname</span>nombre del barrio</li>
            <li><span class='sql'>name</span>nombre del barrio</li>
            <li><span class='sql'>geom</span>geometría del barrio (MultiPolygon, SRID 4326)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">gid</th>
                    <th scope="col">boroname</th>
                    <th scope="col">name</th>
                    <th scope="col">geom</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>Manhattan</td>
                    <td>Distrito Financiero</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>nyc_streets</span> - calles de la ciudad de Nueva York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único de registro (PK)</li>
            <li><span class='sql'>id</span>ID de la calle</li>
            <li><span class='sql'>name</span>nombre de la calle</li>
            <li><span class='sql'>oneway</span>indicador de sentido único</li>
            <li><span class='sql'>type</span>tipo de calle</li>
            <li><span class='sql'>geom</span>geometría de la calle (LineString, SRID 4326)</li>
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
                    <td>Broadway</td>
                    <td>NO</td>
                    <td>avenida</td>
                    <td>LineString(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>nyc_subway_stations</span> - estaciones de metro de la ciudad de Nueva York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único de registro (PK)</li>
            <li><span class='sql'>objectid</span>ID del objeto</li>
            <li><span class='sql'>id</span>ID de la estación</li>
            <li><span class='sql'>name</span>nombre de la estación</li>
            <li><span class='sql'>alt_name</span>nombre alternativo</li>
            <li><span class='sql'>cross_st</span>calle cruzada</li>
            <li><span class='sql'>long_name</span>nombre largo</li>
            <li><span class='sql'>label</span>etiqueta</li>
            <li><span class='sql'>borough</span>barrio</li>
            <li><span class='sql'>nghbhd</span>vecindario</li>
            <li><span class='sql'>routes</span>rutas</li>
            <li><span class='sql'>transfers</span>transferencias</li>
            <li><span class='sql'>color</span>color</li>
            <li><span class='sql'>express</span>indicador de expreso</li>
            <li><span class='sql'>closed</span>indicador de cerrado</li>
            <li><span class='sql'>geom</span>ubicación de la estación (Point, SRID 4326)</li>
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
                    <td>Times Square</td>
                    <td>Times Sq</td>
                    <td>7th Ave</td>
                    <td>Times Square-42nd Street</td>
                    <td>Times Sq</td>
                    <td>Manhattan</td>
                    <td>Midtown</td>
                    <td>1,2,3,7,A,C,E,N,Q,R,S,W</td>
                    <td>42nd St</td>
                    <td>Rojo</td>
                    <td>Sí</td>
                    <td>No</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (gid)</li>
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