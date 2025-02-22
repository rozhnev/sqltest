<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Querynomicon (SQLite)</h2>
    Base de dados compacta para aprender os fundamentos do SQL.
    <h3>A base de dados Querynomicon contém tabelas:</h3>
    <div class="accordion active">
        <span><span class='sql'>little_penguins</span> - tabela de pequenos pinguins.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Espécie de pinguim.</li>
            <li> <span class='sql'>island</span>Ilha de residência.</li>
            <li> <span class='sql'>bill_length_mm</span>Comprimento do bico, mm.</li>
            <li> <span class='sql'>bill_depth_mm</span>Profundidade do bico, mm.</li>
            <li> <span class='sql'>flipper_length_mm</span>Comprimento da nadadeira, mm.</li>
            <li> <span class='sql'>body_mass_g</span>Massa corporal, g.</li>
            <li> <span class='sql'>sex</span>Sexo.</li>
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
    <div class="accordion">
        <span><span class='sql'>penguins</span> - tabela de pinguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Espécie de pinguim.</li>
            <li> <span class='sql'>island</span>Ilha de residência.</li>
            <li> <span class='sql'>bill_length_mm</span>Comprimento do bico, mm.</li>
            <li> <span class='sql'>bill_depth_mm</span>Profundidade do bico, mm.</li>
            <li> <span class='sql'>flipper_length_mm</span>Comprimento da nadadeira, mm.</li>
            <li> <span class='sql'>body_mass_g</span>Massa corporal, g.</li>
            <li> <span class='sql'>sex</span>Sexo.</li>
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
    <div class="accordion">
        <span><span class='sql'>staff</span> - tabela de funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Número do funcionário.</li>
            <li> <span class='sql'>personal</span>Nome do funcionário.</li>
            <li> <span class='sql'>family</span>Sobrenome do funcionário.</li>
            <li> <span class='sql'>dept</span>Departamento.</li>
            <li> <span class='sql'>age</span>Idade.</li>
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
    {if $User->showAd()}
        {if isset($Book)}
            <div class="referal-add-block">
                <a href="{$Book.referral_link}" target="_blank" style="text-decoration: none;">
                    <div style="display: flex; flex-direction: row; padding: 0.3em; width: 100%;">
                        <div  style = "width: 30%;">
                            <img style="width: 100%;" src="{$Book.picture_link}" alt="{$Book.title}">
                        </div>
                        <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                            <div>{$Book.title}</div>
                            <div style="font-size: small; padding-top: 0.5em;">{$Book.description}</div>
                        </div>
                    </div>
                </a>
            </div>
        {/if}
    {/if}
</div>