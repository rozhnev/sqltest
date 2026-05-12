<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h1>Countries Database: table structure and geospatial overview</h1>
    <p>The Countries database (PostGIS) is a sample dataset for geographic and geospatial analysis with SQL.</p>
    <p>It includes spatial data for countries and capitals, plus New York City layers such as census blocks, homicides, neighborhoods, streets, and subway stations.</p>
    <p>The Countries database contains 7 main tables.</p>
    <h2>List of tables</h2>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>countries</span> - list of countries with geometry.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>unique record identifier (PK)</li>
            <li><span class='sql'>name</span>country name</li>
            <li><span class='sql'>border</span>country geometry (MultiPolygon, SRID 4326)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>capitals</span> - list of capitals with location.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>unique record identifier (PK)</li>
            <li><span class='sql'>name</span>capital name</li>
            <li><span class='sql'>country_id</span>reference to country (FK)</li>
            <li><span class='sql'>location</span>capital location (Point, SRID 4326)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>nyc_census_blocks</span> - New York City census blocks with demographic data.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>unique record identifier (PK)</li>
            <li><span class='sql'>blkid</span>census block ID</li>
            <li><span class='sql'>popn_total</span>total population</li>
            <li><span class='sql'>popn_white</span>white population</li>
            <li><span class='sql'>popn_black</span>black population</li>
            <li><span class='sql'>popn_nativ</span>native population</li>
            <li><span class='sql'>popn_asian</span>asian population</li>
            <li><span class='sql'>popn_other</span>other population</li>
            <li><span class='sql'>boroname</span>borough name</li>
            <li><span class='sql'>geom</span>census block geometry (MultiPolygon, SRID 4326)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>nyc_homicides</span> - New York City homicide incidents.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>unique record identifier (PK)</li>
            <li><span class='sql'>incident_d</span>incident date</li>
            <li><span class='sql'>boroname</span>borough name</li>
            <li><span class='sql'>num_victim</span>number of victims</li>
            <li><span class='sql'>primary_mo</span>primary motive</li>
            <li><span class='sql'>id</span>incident ID</li>
            <li><span class='sql'>weapon</span>weapon used</li>
            <li><span class='sql'>light_dark</span>light or dark condition</li>
            <li><span class='sql'>year</span>year of incident</li>
            <li><span class='sql'>geom</span>incident location (Point, SRID 4326)</li>
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
                    <td>Unknown</td>
                    <td>1</td>
                    <td>Firearm</td>
                    <td>D</td>
                    <td>2003</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>nyc_neighborhoods</span> - New York City neighborhoods.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>unique record identifier (PK)</li>
            <li><span class='sql'>boroname</span>borough name</li>
            <li><span class='sql'>name</span>neighborhood name</li>
            <li><span class='sql'>geom</span>neighborhood geometry (MultiPolygon, SRID 4326)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>nyc_streets</span> - New York City streets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>unique record identifier (PK)</li>
            <li><span class='sql'>id</span>street ID</li>
            <li><span class='sql'>name</span>street name</li>
            <li><span class='sql'>oneway</span>one-way indicator</li>
            <li><span class='sql'>type</span>street type</li>
            <li><span class='sql'>geom</span>street geometry (LineString, SRID 4326)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>nyc_subway_stations</span> - New York City subway stations.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>unique record identifier (PK)</li>
            <li><span class='sql'>objectid</span>object ID</li>
            <li><span class='sql'>id</span>station ID</li>
            <li><span class='sql'>name</span>station name</li>
            <li><span class='sql'>alt_name</span>alternative name</li>
            <li><span class='sql'>cross_st</span>cross street</li>
            <li><span class='sql'>long_name</span>long name</li>
            <li><span class='sql'>label</span>label</li>
            <li><span class='sql'>borough</span>borough</li>
            <li><span class='sql'>nghbhd</span>neighborhood</li>
            <li><span class='sql'>routes</span>routes</li>
            <li><span class='sql'>transfers</span>transfers</li>
            <li><span class='sql'>color</span>color</li>
            <li><span class='sql'>express</span>express indicator</li>
            <li><span class='sql'>closed</span>closed indicator</li>
            <li><span class='sql'>geom</span>station location (Point, SRID 4326)</li>
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
                    <td>Red</td>
                    <td>Yes</td>
                    <td>No</td>
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