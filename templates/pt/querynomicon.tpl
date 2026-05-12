<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h1>Banco de Dados Querynomicon: estrutura das tabelas e visão geral</h1>
    <p>Querynomicon (SQLite) é uma base compacta criada para aprender os fundamentos de SQL com exemplos simples e diretos.</p>
    <p>Esta página apresenta as tabelas, suas colunas principais e amostras de dados para praticar consultas SQL.</p>
    <p>O Banco de Dados Querynomicon contém 5 tabelas principais.</p>
    <h2>Lista de tabelas</h2>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>department</span> - tabela de departamentos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID do departamento</li>
            <li> <span class='sql'>name</span>Nome do departamento</li>
            <li> <span class='sql'>building</span>Nome do prédio</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">name</th>
                    <th scope="col">building</th>
                </tr></thead><tbody><tr>
                    <td>gen</td>
                    <td>Genetics</td>
                    <td>Chesson</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>little_penguins</span> - tabela de pequenos pinguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Espécie de pinguim</li>
            <li> <span class='sql'>island</span>Ilha de residência</li>
            <li> <span class='sql'>bill_length_mm</span>Comprimento do bico, mm</li>
            <li> <span class='sql'>bill_depth_mm</span>Profundidade do bico, mm</li>
            <li> <span class='sql'>flipper_length_mm</span>Comprimento da nadadeira, mm</li>
            <li> <span class='sql'>body_mass_g</span>Massa corporal, g</li>
            <li> <span class='sql'>sex</span>Sexo</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">species</th>
                    <th scope="col">island</th>
                    <th scope="col">bill_length_mm</th>
                    <th scope="col">bill_depth_mm</th>
                    <th scope="col">flipper_length_mm</th>
                    <th scope="col">body_mass_g</th>
                    <th scope="col">sex</th>
                </tr></thead><tbody><tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>MALE</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>penguins</span> - tabela de pinguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Espécie de pinguim</li>
            <li> <span class='sql'>island</span>Ilha de residência</li>
            <li> <span class='sql'>bill_length_mm</span>Comprimento do bico, mm</li>
            <li> <span class='sql'>bill_depth_mm</span>Profundidade do bico, mm</li>
            <li> <span class='sql'>flipper_length_mm</span>Comprimento da nadadeira, mm</li>
            <li> <span class='sql'>body_mass_g</span>Massa corporal, g</li>
            <li> <span class='sql'>sex</span>Sexo</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">species</th>
                    <th scope="col">island</th>
                    <th scope="col">bill_length_mm</th>
                    <th scope="col">bill_depth_mm</th>
                    <th scope="col">flipper_length_mm</th>
                    <th scope="col">body_mass_g</th>
                    <th scope="col">sex</th>
                </tr></thead><tbody><tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>MALE</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>staff</span> - tabela de funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Número do funcionário</li>
            <li> <span class='sql'>personal</span>Nome do funcionário</li>
            <li> <span class='sql'>family</span>Sobrenome do funcionário</li>
            <li> <span class='sql'>dept</span>Departamento</li>
            <li> <span class='sql'>age</span>Idade</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">personal</th>
                    <th scope="col">family</th>
                    <th scope="col">dept</th>
                    <th scope="col">age</th>
                </tr></thead><tbody><tr>
                    <td>7</td>
                    <td>Abram</td>
                    <td>Chokshi</td>
                    <td>gen</td>
                    <td>23</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>machine</span> - tabela de máquinas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID da máquina</li>
            <li> <span class='sql'>name</span>Nome da máquina</li>
            <li> <span class='sql'>details</span>JSON com detalhes</li>
        </ul>
        <div class="table-wrapper">
            {literal}
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">name</th>
                    <th scope="col">details</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>WY401</td>
                    <td>{"acquired": "2023-05-01"}</td>
                </tr><tr>
                    <td>2</td>
                    <td>Inphormex</td>
                    <td>{"acquired": "2021-07-15", "refurbished": "2023-10-22"}</td>
                </tr><tr>
                    <td>3</td>
                    <td>AutoPlate 9000</td>
                    <td>{"note": "needs software update"}</td>
                </tr></tbody></table>
            {/literal}
        </div>
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