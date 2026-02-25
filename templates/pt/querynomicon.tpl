<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Querynomicon (SQLite)</h2>
    Base de dados compacta para aprender os fundamentos do SQL.
    <h3>Lista de Tabelas:</h3>
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
            <table class=""><tbody>
                <tr>
                    <th>ident</th>
                    <th>name</th>
                    <th>building</th>
                </tr>
                <tr>
                    <td>gen</td>
                    <td>Genetics</td>
                    <td>Chesson</td>
                </tr>
            </tbody></table>
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
            <table class=""><tbody>
                <tr>
                    <th>species</th>
                    <th>island</th>
                    <th>bill_length_mm</th>
                    <th>bill_depth_mm</th>
                    <th>flipper_length_mm</th>
                    <th>body_mass_g</th>
                    <th>sex</th>
                </tr>
                <tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>MALE</td>
                </tr>
            </tbody></table>
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
            <table class=""><tbody>
                <tr>
                    <th>species</th>
                    <th>island</th>
                    <th>bill_length_mm</th>
                    <th>bill_depth_mm</th>
                    <th>flipper_length_mm</th>
                    <th>body_mass_g</th>
                    <th>sex</th>
                </tr>
                <tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>MALE</td>
                </tr>
            </tbody></table>
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
            <table class=""><tbody>
                <tr>
                    <th>ident</th>
                    <th>personal</th>
                    <th>family</th>
                    <th>dept</th>
                    <th>age</th>
                </tr>
                <tr>
                    <td>7</td>
                    <td>Abram</td>
                    <td>Chokshi</td>
                    <td>gen</td>
                    <td>23</td>
                </tr>
            </tbody></table>
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
            <table class=""><tbody>
                <tr>
                    <th>ident</th>
                    <th>name</th>
                    <th>details</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>WY401</td>
                    <td>{"acquired": "2023-05-01"}</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Inphormex</td>
                    <td>{"acquired": "2021-07-15", "refurbished": "2023-10-22"}</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>AutoPlate 9000</td>
                    <td>{"note": "needs software update"}</td>
                </tr>
            </tbody></table>
            {/literal}
        </div>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div>
    {/if}
</div>