<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>Countries Database (PostGIS)</h2>
    <p>
        The Countries database is a PostGIS sample database designed for geographic and geospatial data analysis. It includes spatial information about countries, capitals, and New York City data such as census blocks, homicides, neighborhoods, streets, and subway stations, suitable for GIS applications and spatial queries.
    </p>
    <h3>Table List:</h3>
    <div class="accordion">
        <span><span class='sql'>countries</span> - list of countries with geometry.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>unique record identifier (PK)</li>
            <li><span class='sql'>name</span>country name</li>
            <li><span class='sql'>border</span>country geometry (MultiPolygon, SRID 4326)</li>
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
    <div class="accordion">
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
    <div class="accordion">
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
    <div class="accordion">
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
                    <td>Unknown</td>
                    <td>1</td>
                    <td>Firearm</td>
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
    <div class="accordion">
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
    <div class="accordion">
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
                    <td>Red</td>
                    <td>Yes</td>
                    <td>No</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    {if $User->showAd()}
        <div id="yandex_rtb_R-A-4716552-2" style="margin-top: 1rem;"></div>
        {* <div style="display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; margin-top: 1rem;">
            <a href="https://www.jdoqocy.com/click-101541078-17083149" target="_blank" class="talkpal-ad-container">
                <img src="https://www.ftjcfx.com/image-101541078-17083149" width="250" height="360" alt="Contabo.com" style="max-width: 100%; height: auto;" border="0"/>
            </a>
            <a href="https://www.tkqlhce.com/click-101561323-17139054" target="_blank" class="talkpal-ad-container" style="padding: 15px 10px;">
                <img src="https://www.awltovhc.com/image-101561323-17139054" width="1" height="1" border="0"/>
                <img src="https://files.talkpal.ai/landing_images/talkpal-text-logo.svg" alt="Talkpal AI Logo" class="talkpal-ad-logo">
                <div class="talkpal-ad-text">The fun and effective way to learn a language with AI!</div>
                <div class="talkpal-ad-subtext">Practice speaking, listening & writing.</div>
                <span class="talkpal-ad-button">Start Learning Now</span>
            </a>
        </div> *}
    {/if}
</div>