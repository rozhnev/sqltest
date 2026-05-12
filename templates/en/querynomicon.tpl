<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h1>Querynomicon Database: table structure and overview</h1>
    <p>Querynomicon (SQLite) is a compact training database for learning SQL fundamentals with clear and simple examples.</p>
    <p>This page presents the tables, key columns, and sample rows for hands-on SQL practice.</p>
    <p>The Querynomicon database contains 5 main tables.</p>
    <h2>List of tables</h2>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>department</span> - table of departments.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Department ID</li>
            <li> <span class='sql'>name</span>Department name</li>
            <li> <span class='sql'>building</span>Building name</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>little_penguins</span> - table of little penguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Penguin species</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>Island of residence</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Bill length, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Bill depth, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Flipper length, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Body mass, g</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Sex</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>penguins</span> - table of penguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Penguin species</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>Island of residence</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Bill length, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Bill depth, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Flipper length, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Body mass, g</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Sex</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>staff</span> - table of employees.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Employee number</li>
            <li> <span class='sql'>personal</span>Employee first name</li>
            <li> <span class='sql'>family</span>Employee last name</li>
            <li> <span class='sql'>dept</span>Department</li>
            <li> <span class='sql'>age</span>Age</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>machine</span> - table of machines.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Machine ID</li>
            <li> <span class='sql'>name</span>Machine name</li>
            <li> <span class='sql'>details</span>JSON with details</li>
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