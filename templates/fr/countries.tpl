<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>Base de données Countries (PostGIS)</h2>
    <p>
        La base de données Countries est une base de données d'exemple PostGIS conçue pour l'analyse de données géographiques et géospatiales. Elle comprend des informations spatiales sur les pays, les capitales et des données sur la ville de New York telles que les blocs de recensement, les homicides, les quartiers, les rues et les stations de métro, adaptées aux applications SIG et aux requêtes spatiales.
    </p>
    <h3>Liste des tables :</h3>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>countries</span> - liste des pays avec géométrie.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>name</span>nom du pays</li>
            <li><span class='sql'>border</span>géométrie du pays (MultiPolygon, SRID 4326)</li>
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
                    <td>France</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>capitals</span> - liste des capitales avec emplacement.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>name</span>nom de la capitale</li>
            <li><span class='sql'>country_id</span>référence au pays (FK)</li>
            <li><span class='sql'>location</span>emplacement de la capitale (Point, SRID 4326)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>nyc_census_blocks</span> - blocs de recensement de la ville de New York avec données démographiques.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>blkid</span>identifiant du bloc de recensement</li>
            <li><span class='sql'>popn_total</span>population totale</li>
            <li><span class='sql'>popn_white</span>population blanche</li>
            <li><span class='sql'>popn_black</span>population noire</li>
            <li><span class='sql'>popn_nativ</span>population autochtone</li>
            <li><span class='sql'>popn_asian</span>population asiatique</li>
            <li><span class='sql'>popn_other</span>autre population</li>
            <li><span class='sql'>boroname</span>nom de l'arrondissement (borough)</li>
            <li><span class='sql'>geom</span>géométrie du bloc de recensement (MultiPolygon, SRID 4326)</li>
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
                    <td>Manhattan</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>nyc_homicides</span> - incidents d'homicides dans la ville de New York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>incident_d</span>date de l'incident</li>
            <li><span class='sql'>boroname</span>nom de l'arrondissement</li>
            <li><span class='sql'>num_victim</span>nombre de victimes</li>
            <li><span class='sql'>primary_mo</span>mobile principal</li>
            <li><span class='sql'>id</span>identifiant de l'incident</li>
            <li><span class='sql'>weapon</span>arme utilisée</li>
            <li><span class='sql'>light_dark</span>condition de luminosité (jour/nuit)</li>
            <li><span class='sql'>year</span>année de l'incident</li>
            <li><span class='sql'>geom</span>emplacement de l'incident (Point, SRID 4326)</li>
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
                    <td>Manhattan</td>
                    <td>1</td>
                    <td>Inconnu</td>
                    <td>1</td>
                    <td>Arme à feu</td>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>nyc_neighborhoods</span> - quartiers de la ville de New York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>boroname</span>nom de l'arrondissement</li>
            <li><span class='sql'>name</span>nom du quartier</li>
            <li><span class='sql'>geom</span>géométrie du quartier (MultiPolygon, SRID 4326)</li>
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
                    <td>Manhattan</td>
                    <td>Financial District</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>nyc_streets</span> - rues de la ville de New York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>id</span>identifiant de la rue</li>
            <li><span class='sql'>name</span>nom de la rue</li>
            <li><span class='sql'>oneway</span>indicateur de sens unique</li>
            <li><span class='sql'>type</span>type de rue</li>
            <li><span class='sql'>geom</span>géométrie de la rue (LineString, SRID 4326)</li>
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
                    <td>Broadway</td>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>nyc_subway_stations</span> - stations de métro de la ville de New York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>objectid</span>identifiant d'objet</li>
            <li><span class='sql'>id</span>identifiant de la station</li>
            <li><span class='sql'>name</span>nom de la station</li>
            <li><span class='sql'>alt_name</span>nom alternatif</li>
            <li><span class='sql'>cross_st</span>rue transversale</li>
            <li><span class='sql'>long_name</span>nom long</li>
            <li><span class='sql'>label</span>étiquette</li>
            <li><span class='sql'>borough</span>arrondissement</li>
            <li><span class='sql'>nghbhd</span>quartier</li>
            <li><span class='sql'>routes</span>lignes</li>
            <li><span class='sql'>transfers</span>correspondances</li>
            <li><span class='sql'>color</span>couleur</li>
            <li><span class='sql'>express</span>indicateur express</li>
            <li><span class='sql'>closed</span>indicateur de fermeture</li>
            <li><span class='sql'>geom</span>emplacement de la station (Point, SRID 4326)</li>
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
                    <td>Times Square</td>
                    <td>Times Sq</td>
                    <td>7th Ave</td>
                    <td>Times Square-42nd Street</td>
                    <td>Times Sq</td>
                    <td>Manhattan</td>
                    <td>Midtown</td>
                    <td>1,2,3,7,A,C,E,N,Q,R,S,W</td>
                    <td>42nd St</td>
                    <td>Rouge</td>
                    <td>Oui</td>
                    <td>Non</td>
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
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div>
    {/if}
</div>
