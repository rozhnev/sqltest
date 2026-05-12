<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h1>Base de données Countries : structure des tables et vue géospatiale</h1>
    <p>La base Countries (PostGIS) est un jeu de données d'exemple pour l'analyse géographique et géospatiale avec SQL.</p>
    <p>Elle contient des données spatiales sur les pays et les capitales, ainsi que des couches de New York : blocs de recensement, homicides, quartiers, rues et stations de métro.</p>
    <p>La base de données Countries contient 7 tables principales.</p>
    <h2>Liste des tables</h2>
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
            <table><thead><tr>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">border</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>France</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
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
            <table><thead><tr>
                    <th scope="col">id</th>
                    <th scope="col">name</th>
                    <th scope="col">country_id</th>
                    <th scope="col">location</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>Paris</td>
                    <td>1</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
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
                    <td>Inconnu</td>
                    <td>1</td>
                    <td>Arme à feu</td>
                    <td>D</td>
                    <td>2003</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
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
            <table><thead><tr>
                    <th scope="col">gid</th>
                    <th scope="col">boroname</th>
                    <th scope="col">name</th>
                    <th scope="col">geom</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>Manhattan</td>
                    <td>Financial District</td>
                    <td>MultiPolygon(...) [SRID=4326]</td>
                </tr></tbody></table>
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
                    <td>avenue</td>
                    <td>LineString(...) [SRID=4326]</td>
                </tr></tbody></table>
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
                    <td>Rouge</td>
                    <td>Oui</td>
                    <td>Non</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                <div class="book-card">
                    <a href="{{$Book.referral_link}}" target="_blank" style="text-decoration: none; color: var(--question-color);">
                        <div style="display: flex; flex-direction: row;     border: 1px solid var(--text-block-border-color);
color: var(--question-text);
border-radius: 6px; padding: 0.3em; width: 98%;">
                        <div  style = "width: 25%;">
                            <img style="width: 100%;" src="{{$Book.picture_link}}" alt="{{$Book.title|escape:"html"}}">
                        </div>
                        <div style="font-size: 1em;  width: 75%;  padding: 0 0.7em; font-weight: 100; height: 250px; overflow: auto;">
                            <div>{{$Book.title|escape:"html"}}</div>
                            <div style="font-size: small; padding-top: 0.5em;">{{$Book.description|escape:"html"}}</div>
                        </div>
                        </div>
                    </a>
                </div>
            {/if}
        </div>
    {/if}
</div>
