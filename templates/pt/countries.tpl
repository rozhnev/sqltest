<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>Banco de Dados Countries: estrutura das tabelas e visão geoespacial</h2>
    <p>O banco Countries (PostGIS) é um conjunto de dados de exemplo para análise geográfica e geoespacial com SQL.</p>
    <p>Ele inclui dados espaciais de países e capitais, além de camadas de Nova York: blocos censitários, homicídios, bairros, ruas e estações de metrô.</p>
    <p>O Banco de Dados Countries contém 7 tabelas principais.</p>
    <h3>Lista de tabelas</h3>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>countries</span> - lista de países com geometria.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>name</span>nome do país</li>
            <li><span class='sql'>border</span>geometria do país (MultiPolygon, SRID 4326)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
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
                    <td>Desconhecido</td>
                    <td>1</td>
                    <td>Arma de fogo</td>
                    <td>D</td>
                    <td>2003</td>
                    <td>Point(...) [SRID=4326]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (gid)</li>
        </ul>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
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
                    <td>Vermelho</td>
                    <td>Sim</td>
                    <td>Não</td>
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