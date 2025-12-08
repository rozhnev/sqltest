<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>Banco de Dados Countries (PostGIS)</h2>
    <p>
        O banco de dados Countries é um banco de dados de exemplo PostGIS projetado para análise geográfica e geoespacial. Ele inclui informações espaciais sobre países, capitais e dados da cidade de Nova York, como blocos censitários, homicídios, bairros, ruas e estações de metrô, adequado para aplicações GIS e consultas espaciais.
    </p>
    <h3>Lista de Tabelas:</h3>
    <div class="accordion">
        <span><span class='sql'>countries</span> - lista de países com geometria.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>name</span>nome do país</li>
            <li><span class='sql'>border</span>geometria do país (MultiPolygon, SRID 4326)</li>
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
        <span><span class='sql'>capitals</span> - lista de capitais com localização.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>name</span>nome da capital</li>
            <li><span class='sql'>country_id</span>referência ao país (FK)</li>
            <li><span class='sql'>location</span>localização da capital (Point, SRID 4326)</li>
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
        <span><span class='sql'>nyc_census_blocks</span> - blocos censitários de Nova York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único do registro (PK)</li>
            <li><span class='sql'>blkid</span>ID do bloco censitário</li>
            <li><span class='sql'>popn_total</span>população total</li>
            <li><span class='sql'>popn_white</span>população branca</li>
            <li><span class='sql'>popn_black</span>população negra</li>
            <li><span class='sql'>popn_nativ</span>população nativa</li>
            <li><span class='sql'>popn_asian</span>população asiática</li>
            <li><span class='sql'>popn_other</span>outra população</li>
            <li><span class='sql'>boroname</span>nome do bairro</li>
            <li><span class='sql'>geom</span>geometria do bloco censitário (MultiPolygon, SRID 4326)</li>
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
        <span><span class='sql'>nyc_homicides</span> - incidentes de homicídio na cidade de Nova York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único do registro (PK)</li>
            <li><span class='sql'>incident_d</span>data do incidente</li>
            <li><span class='sql'>boroname</span>nome do bairro</li>
            <li><span class='sql'>num_victim</span>número de vítimas</li>
            <li><span class='sql'>primary_mo</span>motivo principal</li>
            <li><span class='sql'>id</span>ID do incidente</li>
            <li><span class='sql'>weapon</span>arma usada</li>
            <li><span class='sql'>light_dark</span>condição de luz ou escuro</li>
            <li><span class='sql'>year</span>ano do incidente</li>
            <li><span class='sql'>geom</span>localização do incidente (Point, SRID 4326)</li>
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
                    <td>Desconhecido</td>
                    <td>1</td>
                    <td>Arma de fogo</td>
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
        <span><span class='sql'>nyc_neighborhoods</span> - bairros da cidade de Nova York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único do registro (PK)</li>
            <li><span class='sql'>boroname</span>nome do bairro</li>
            <li><span class='sql'>name</span>nome do bairro</li>
            <li><span class='sql'>geom</span>geometria do bairro (MultiPolygon, SRID 4326)</li>
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
        <span><span class='sql'>nyc_streets</span> - ruas da cidade de Nova York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único do registro (PK)</li>
            <li><span class='sql'>id</span>ID da rua</li>
            <li><span class='sql'>name</span>nome da rua</li>
            <li><span class='sql'>oneway</span>indicador de mão única</li>
            <li><span class='sql'>type</span>tipo de rua</li>
            <li><span class='sql'>geom</span>geometria da rua (LineString, SRID 4326)</li>
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
        <span><span class='sql'>nyc_subway_stations</span> - estações de metrô da cidade de Nova York.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>gid</span>identificador único do registro (PK)</li>
            <li><span class='sql'>objectid</span>ID do objeto</li>
            <li><span class='sql'>id</span>ID da estação</li>
            <li><span class='sql'>name</span>nome da estação</li>
            <li><span class='sql'>alt_name</span>nome alternativo</li>
            <li><span class='sql'>cross_st</span>rua transversal</li>
            <li><span class='sql'>long_name</span>nome longo</li>
            <li><span class='sql'>label</span>rótulo</li>
            <li><span class='sql'>borough</span>bairro</li>
            <li><span class='sql'>nghbhd</span>bairro</li>
            <li><span class='sql'>routes</span>rotas</li>
            <li><span class='sql'>transfers</span>transferências</li>
            <li><span class='sql'>color</span>cor</li>
            <li><span class='sql'>express</span>indicador expresso</li>
            <li><span class='sql'>closed</span>indicador fechado</li>
            <li><span class='sql'>geom</span>localização da estação (Point, SRID 4326)</li>
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
                    <td>Vermelho</td>
                    <td>Sim</td>
                    <td>Não</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    {if $User->showAd()}
        <div style="display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; margin-top: 1rem;">
            <a href="https://www.jdoqocy.com/click-101541078-17083149" target="_blank" class="talkpal-ad-container">
                <img src="https://www.ftjcfx.com/image-101541078-17083149" width="250" height="360" alt="Contabo.com" style="max-width: 100%; height: auto;" border="0"/>
            </a>
            <a href="https://www.anrdoezrs.net/click-101561323-17139054?url=https%3A%2F%2Ftalkpal.ai%2Fget-started%2Fpt-pt" target="_blank" class="talkpal-ad-container" style="padding: 15px 10px;">
                <img src="https://www.awltovhc.com/image-101561323-17139054" width="1" height="1" border="0"/>
                <img src="https://files.talkpal.ai/landing_images/talkpal-text-logo.svg" alt="Talkpal AI Logo" class="talkpal-ad-logo">
                <div class="talkpal-ad-text">A forma divertida e eficaz de aprender um idioma com IA!</div>
                <div class="talkpal-ad-subtext">Pratique fala, escuta e escrita.</div>
                <span class="talkpal-ad-button">Comece a aprender agora</span>
            </a>
        </div>
    {/if}
</div>