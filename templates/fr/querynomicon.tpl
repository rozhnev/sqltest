<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Querynomicon (SQLite)</h2>
    Une base de données compacte pour apprendre les bases du SQL.
    <h3>La base de données Querynomicon contient les tables suivantes :</h3>
    <div class="accordion">
        <span><span class='sql'>department</span> - table des départements.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID du département</li>
            <li> <span class='sql'>name</span>Nom du département</li>
            <li> <span class='sql'>building</span>Nom du bâtiment</li>
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
    <div class="accordion">
        <span><span class='sql'>little_penguins</span> - table des petits pingouins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Espèce de pingouin</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>Île de résidence</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Longueur du bec, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Épaisseur du bec, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Longueur de l'aileron, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Masse corporelle, g</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Sexe</li>
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
        <span><span class='sql'>penguins</span> - table des pingouins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Espèce de pingouin</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>Île de résidence</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Longueur du bec, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Épaisseur du bec, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Longueur de l'aileron, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Masse corporelle, g</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Sexe</li>
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
        <span><span class='sql'>staff</span> - table des employés.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Numéro de l'employé</li>
            <li> <span class='sql'>personal</span>Prénom de l'employé</li>
            <li> <span class='sql'>family</span>Nom de famille de l'employé</li>
            <li> <span class='sql'>dept</span>Département</li>
            <li> <span class='sql'>age</span>Âge</li>
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
    <div class="accordion">
        <span><span class='sql'>machine</span> - table des machines.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Identifiant de la machine</li>
            <li> <span class='sql'>name</span>Nom de la machine</li>
            <li> <span class='sql'>details</span>JSON avec détails</li>
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
