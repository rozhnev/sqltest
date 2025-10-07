<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Querynomicon (SQLite)</h2>
    A compact database for learning the basics of SQL.
    <h3>The Querynomicon database contains tables:</h3>
    <div class="accordion">
        <span><span class='sql'>department</span> - table of departments.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Department ID.</li>
            <li> <span class='sql'>name</span>Department name.</li>
            <li> <span class='sql'>building</span>Building name.</li>
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
        <span><span class='sql'>little_penguins</span> - table of little penguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Penguin species.</li>
            <li> <span class='sql'>island</span>Island of residence.</li>
            <li> <span class='sql'>bill_length_mm</span>Bill length, mm.</li>
            <li> <span class='sql'>bill_depth_mm</span>Bill depth, mm.</li>
            <li> <span class='sql'>flipper_length_mm</span>Flipper length, mm.</li>
            <li> <span class='sql'>body_mass_g</span>Body mass, g.</li>
            <li> <span class='sql'>sex</span>Sex.</li>
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
        <span><span class='sql'>penguins</span> - table of penguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Penguin species.</li>
            <li> <span class='sql'>island</span>Island of residence.</li>
            <li> <span class='sql'>bill_length_mm</span>Bill length, mm.</li>
            <li> <span class='sql'>bill_depth_mm</span>Bill depth, mm.</li>
            <li> <span class='sql'>flipper_length_mm</span>Flipper length, mm.</li>
            <li> <span class='sql'>body_mass_g</span>Body mass, g.</li>
            <li> <span class='sql'>sex</span>Sex.</li>
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
        <span><span class='sql'>staff</span> - table of employees.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Employee number.</li>
            <li> <span class='sql'>personal</span>Employee first name.</li>
            <li> <span class='sql'>family</span>Employee last name.</li>
            <li> <span class='sql'>dept</span>Department.</li>
            <li> <span class='sql'>age</span>Age.</li>
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
        <span><span class='sql'>machine</span> - table of machines.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Machine ID.</li>
            <li> <span class='sql'>name</span>Machine name.</li>
            <li> <span class='sql'>details</span>JSON with details.</li>
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
        {* <div class="referal-add-block">
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div> *}

        <style>
            .banner-container {
                width: 100%;
                max-width: 728px; /* Common banner width (e.g., leaderboard) */
                background-color: #336699; /* Professional blue */
                color: #ffffff; /* White text */
                padding: 20px 30px;
                box-sizing: border-box;
                text-align: center;
                border-radius: 8px;
                border: 1px solid white;
                margin: 1rem 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                position: relative;
            }
            .banner-container a {
                text-decoration: none;
                color: inherit; /* Inherit white color */
                display: block; /* Make the whole banner clickable */
            }
            .banner-title {
                font-size: 2.2em; /* Larger font for the main title */
                font-weight: bold;
                margin-bottom: 10px;
                line-height: 1.2;
            }
            .banner-slogan {
                font-size: 1.1em;
                margin-bottom: 20px;
                opacity: 0.9;
            }
            .banner-button {
                display: inline-block;
                background-color: #ff9900; /* Vibrant orange for call to action */
                color: #333333; /* Dark text for contrast */
                padding: 12px 25px;
                border-radius: 5px;
                font-size: 1.0em;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }
            .banner-button:hover {
                background-color: #e68a00; /* Darker orange on hover */
            }

            /* Optional: Responsive adjustments */
            @media (max-width: 768px) {
                .banner-container {
                    max-width: 90%;
                    padding: 15px 20px;
                }
                .banner-title {
                    font-size: 1.8em;
                }
                .banner-slogan {
                    font-size: 1.0em;
                }
                .banner-button {
                    padding: 10px 20px;
                    font-size: 0.9em;
                }
            }
            @media (max-width: 480px) {
                .banner-title {
                    font-size: 1.5em;
                }
                .banner-slogan {
                    font-size: 0.9em;
                }
            }
        </style>
        <div class="banner-container">
            <a href="https://dbfrontiers.net/" target="_blank" rel="noopener noreferrer">
                <div class="banner-title">Database Frontiers</div>
                <div class="banner-slogan">Premier Conference for Database Professionals</div>
                <div class="banner-button">Learn More</div>
            </a>
        </div>

    {/if}
</div>