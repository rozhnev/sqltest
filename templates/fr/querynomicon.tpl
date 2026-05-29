<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Base de données Querynomicon : structure des tables et vue d'ensemble</h2>
    <p>Querynomicon (SQLite) est une base compacte conçue pour apprendre les fondamentaux SQL sur des exemples simples et lisibles.</p>
    <p>Cette page présente les tables, leurs colonnes principales et des exemples de lignes pour la pratique des requêtes.</p>
    <p>La base de données Querynomicon contient 5 tables principales.</p>
    <h3>Liste des tables</h3>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>department</span> - table des départements.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID du département</li>
            <li> <span class='sql'>name</span>Nom du département</li>
            <li> <span class='sql'>building</span>Nom du bâtiment</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
