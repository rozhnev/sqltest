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
         <style>
            /* Base styles for the container */
            .talkpal-ad-container {
                width: 250px; /* Fixed width as requested */
                height: 360px; /* Fixed height as requested */
                background-color: #F0F2F5; /* Light grey, often a neutral background on tech sites. ADJUST THIS to match sqltest.online background! */
                border: 1px solid #C0C0C0; /* Soft border. ADJUST THIS to match sqltest.online border/divider color! */
                border-radius: 8px; /* Slightly rounded corners */
                overflow: hidden; /* Ensure content stays within bounds */
                font-family: Arial, sans-serif; /* Common web font. ADJUST THIS if sqltest.online uses a specific font! */
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Distribute space between elements */
                align-items: center;
                box-sizing: border-box; /* Include padding in width/height */
                text-decoration: none; /* Remove underline from the link */
                color: inherit; /* Inherit color for text */
                transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; /* Smooth hover effects */
            }

            .talkpal-ad-container:hover {
                transform: translateY(-3px); /* Slightly lift on hover */
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); /* Subtle shadow on hover */
            }

            /* Logo styling */
            .talkpal-ad-logo {
                max-width: 80%; /* Ensure logo fits */
                max-height: 80px; /* Limit logo height */
                height: auto;
                display: block; /* Remove extra space below image */
                margin-bottom: 15px; /* Space below logo */
            }

            /* Text styling */
            .talkpal-ad-text {
                font-size: 18px; /* Slightly larger heading */
                font-weight: bold;
                color: #333333; /* Dark grey text. ADJUST THIS to match sqltest.online text color! */
                margin-bottom: 10px; /* Space below heading */
                line-height: 1.3;
            }

            .talkpal-ad-subtext {
                font-size: 14px;
                color: #555555; /* Slightly lighter text. ADJUST THIS! */
                line-height: 1.4;
                margin-bottom: 20px; /* Space above button */
            }

            /* Call to action button styling */
            .talkpal-ad-button {
                display: inline-block;
                background-color: #007bff; /* A common "call to action" blue. ADJUST THIS to match sqltest.online primary button color or a complementary accent! */
                color: #ffffff; /* White text on button */
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none; /* Remove underline */
                transition: background-color 0.2s ease-in-out;
                margin-top: auto; /* Push button to the bottom */
            }

            .talkpal-ad-button:hover {
                background-color: #0056b3; /* Darker shade on hover */
            }
        </style>

        <div style="display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; margin-top: 1rem;">
            <a href="https://www.jdoqocy.com/click-101541078-17083149" target="_blank" class="talkpal-ad-container">
                <img src="https://www.ftjcfx.com/image-101541078-17083149" width="250" height="360" alt="" border="0"/>
            </a>
            <a href="https://talkpal.ai/" target="_blank" class="talkpal-ad-container" style="padding: 15px 10px;">
                <img src="https://files.talkpal.ai/landing_images/talkpal-text-logo.svg" alt="Talkpal AI Logo" class="talkpal-ad-logo">
                <div class="talkpal-ad-text">The fun and effective way to learn a language with AI!</div>
                <div class="talkpal-ad-subtext">Practice speaking, listening & writing.</div>
                <span class="talkpal-ad-button">Start Learning Now</span>
            </a>
        </div>
    {/if}
</div>