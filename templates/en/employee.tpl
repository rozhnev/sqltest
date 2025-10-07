<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Employee Database (Firebird)</h2>
    <p>
        Employee is a sample database that comes with the Firebird cross-platform database management system.
        You can use this database to explore Firebird SQL and other DBMS features.
    </p>
    <h3>Below is a list of this DB tables:</h3>

    <div class="accordion">
        <span><span class='sql'>COUNTRY</span> - countries table.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Name of the country.</li>
            <li><span class='sql'>CURRENCY</span>Currency used in the country.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>COUNTRY</th>
                    <th>CURRENCY</th>
                </tr>
                <tr>
                    <td>USA</td>
                    <td>Dollar</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>JOB</span> - company's staff schedule.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>Job code.</li>
            <li><span class='sql'>JOB_GRADE</span>Job grade.</li>
            <li><span class='sql'>JOB_COUNTRY</span>Country associated with the job.</li>
            <li><span class='sql'>JOB_TITLE</span>Job title.</li>
            <li><span class='sql'>MIN_SALARY</span>Minimum salary for the job.</li>
            <li><span class='sql'>MAX_SALARY</span>Maximum salary for the job.</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>Job requirements.</li>
            <li><span class='sql'>LANGUAGE_REQ</span>Language requirements.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>JOB_CODE</th>
                    <th>JOB_GRADE</th>
                    <th>JOB_COUNTRY</th>
                    <th>JOB_TITLE</th>
                    <th>MIN_SALARY</th>
                    <th>MAX_SALARY</th>
                    <th>JOB_REQUIREMENT</th>
                    <th>LANGUAGE_REQ</th>
                </tr>
                <tr>
                    <td>CEO</td>
                    <td>1</td>
                    <td>USA</td>
                    <td>Chief Executive Officer</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>No specific requirements.</td>
                    <td>[null]</td>
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
        <span><span class='sql'>DEPARTMENT</span> - company divisions.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Department number.</li>
            <li><span class='sql'>DEPARTMENT</span>Department name.</li>
            <li><span class='sql'>HEAD_DEPT</span>Head department (can be null).</li>
            <li><span class='sql'>MNGR_NO</span>Manager number.</li>
            <li><span class='sql'>BUDGET</span>Department budget.</li>
            <li><span class='sql'>LOCATION</span>Department location.</li>
            <li><span class='sql'>PHONE_NO</span>Phone number for the department.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>DEPT_NO</th>
                    <th>DEPARTMENT</th>
                    <th>HEAD_DEPT</th>
                    <th>MNGR_NO</th>
                    <th>BUDGET</th>
                    <th>LOCATION</th>
                    <th>PHONE_NO</th>
                </tr>
                <tr>
                    <td>000</td>
                    <td>Corporate Office</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>EMPLOYEE</span> - list of employees.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Employee number.</li>
            <li><span class='sql'>FIRST_NAME</span>First name of the employee.</li>
            <li><span class='sql'>LAST_NAME</span>Last name of the employee.</li>
            <li><span class='sql'>PHONE_EXT</span>Phone extension for the employee.</li>
            <li><span class='sql'>HIRE_DATE</span>Date of employee's hire.</li>
            <li><span class='sql'>DEPT_NO</span>Department number.</li>
            <li><span class='sql'>JOB_CODE</span>Job code for the employee.</li>
            <li><span class='sql'>JOB_GRADE</span>Job grade for the employee.</li>
            <li><span class='sql'>JOB_COUNTRY</span>Country associated with the employee's job.</li>
            <li><span class='sql'>SALARY</span>Salary of the employee.</li>
            <li><span class='sql'>FULL_NAME</span>Full name of the employee.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>FIRST_NAME</th>
                    <th>LAST_NAME</th>
                    <th>PHONE_EXT</th>
                    <th>HIRE_DATE</th>
                    <th>DEPT_NO</th>
                    <th>JOB_CODE</th>
                    <th>JOB_GRADE</th>
                    <th>JOB_COUNTRY</th>
                    <th>SALARY</th>
                    <th>FULL_NAME</th>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Robert</td>
                    <td>Nelson</td>
                    <td>250</td>
                    <td>1988-12-28 00:00:00</td>
                    <td>600</td>
                    <td>VP</td>
                    <td>2</td>
                    <td>USA</td>
                    <td>105900.00</td>
                    <td>Nelson, Robert</td>
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
        <span><span class='sql'>PROJECT</span> - list of projects.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>Project ID.</li>
            <li><span class='sql'>PROJ_NAME</span>Project name.</li>
            <li><span class='sql'>PROJ_DESC</span>Project description.</li>
            <li><span class='sql'>TEAM_LEADER</span>Team leader for the project.</li>
            <li><span class='sql'>PRODUCT</span>Product associated with the project.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>PROJ_ID</th>
                    <th>PROJ_NAME</th>
                    <th>PROJ_DESC</th>
                    <th>TEAM_LEADER</th>
                    <th>PRODUCT</th>
                </tr>
                <tr>
                    <td>VBASE</td>
                    <td>Video Database</td>
                    <td>Development of a video database management system for managing video distribution on demand.</td>
                    <td>45</td>
                    <td>software</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - employee-project mapping.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Employee number.</li>
            <li><span class='sql'>PROJ_ID</span>Project ID.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>PROJ_ID</th>
                </tr>
                <tr>
                    <td>144</td>
                    <td>DGPII</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - project budgets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>FISCAL_YEAR</span>Fiscal year.</li>
            <li><span class='sql'>PROJ_ID</span>Project ID.</li>
            <li><span class='sql'>DEPT_NO</span>Department number.</li>
            <li><span class='sql'>QUART_HEAD_CNT</span>Quarter headcount (can be null).</li>
            <li><span class='sql'>PROJECTED_BUDGET</span>Projected budget for the fiscal year.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>FISCAL_YEAR</th>
                    <th>PROJ_ID</th>
                    <th>DEPT_NO</th>
                    <th>QUART_HEAD_CNT</th>
                    <th>PROJECTED_BUDGET</th>
                </tr>
                <tr>
                    <td>1994</td>
                    <td>GUIDE</td>
                    <td>100</td>
                    <td>[null]</td>
                    <td>200000.00</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>SALARY_HISTORY</span> - history of employee salary changes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Employee number.</li>
            <li><span class='sql'>CHANGE_DATE</span>Date of salary change.</li>
            <li><span class='sql'>UPDATER_ID</span>Updater ID.</li>
            <li><span class='sql'>OLD_SALARY</span>Previous salary.</li>
            <li><span class='sql'>PERCENT_CHANGE</span>Percentage change in salary.</li>
            <li><span class='sql'>NEW_SALARY</span>New salary after the change.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>CHANGE_DATE</th>
                    <th>UPDATER_ID</th>
                    <th>OLD_SALARY</th>
                    <th>PERCENT_CHANGE</th>
                    <th>NEW_SALARY</th>
                </tr>
                <tr>
                    <td>28</td>
                    <td>1992-12-15 00:00:00</td>
                    <td>admin2</td>
                    <td>20000.00</td>
                    <td>10.000000</td>
                    <td>22000.000000</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>CUSTOMER</span> - company clients.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>CUST_NO</span>Customer number.</li>
            <li><span class='sql'>CUSTOMER</span>Customer name.</li>
            <li><span class='sql'>CONTACT_FIRST</span>First name of the contact person.</li>
            <li><span class='sql'>CONTACT_LAST</span>Last name of the contact person.</li>
            <li><span class='sql'>PHONE_NO</span>Phone number for the customer.</li>
            <li><span class='sql'>ADDRESS_LINE1</span> Address line 1.</li>
            <li><span class='sql'>ADDRESS_LINE2</span>Address line 2 (can be null).</li>
            <li><span class='sql'>CITY</span>City of the customer.</li>
            <li><span class='sql'>STATE_PROVINCE</span>State or province of the customer.</li>
            <li><span class='sql'>COUNTRY</span>Country of the customer.</li>
            <li><span class='sql'>POSTAL_CODE</span>Postal code of the customer.</li>
            <li><span class='sql'>ON_HOLD</span>On hold status (can be null).</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>CUST_NO</th>
                    <th>CUSTOMER</th>
                    <th>CONTACT_FIRST</th>
                    <th>CONTACT_LAST</th>
                    <th>PHONE_NO</th>
                    <th>ADDRESS_LINE1</th>
                    <th>ADDRESS_LINE2</th>
                    <th>CITY</th>
                    <th>STATE_PROVINCE</th>
                    <th>COUNTRY</th>
                    <th>POSTAL_CODE</th>
                    <th>ON_HOLD</th>
                </tr>
                <tr>
                    <td>1001</td>
                    <td>Signature Design</td>
                    <td>Dale J.</td>
                    <td>Little</td>
                    <td>(619) 530-2710</td>
                    <td>15500 Pacific Heights Blvd.</td>
                    <td>[null]</td>
                    <td>San Diego</td>
                    <td>CA</td>
                    <td>USA</td>
                    <td>92121</td>
                    <td>[null]</td>
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
    <span><span class='sql'>SALES</span> - list of sales.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PO_NUMBER</span>Purchase order number.</li>
            <li><span class='sql'>CUST_NO</span>Customer number associated with the order.</li>
            <li><span class='sql'>SALES_REP</span>Sales representative number.</li>
            <li><span class='sql'>ORDER_STATUS</span>Order status.</li>
            <li><span class='sql'>ORDER_DATE</span>Date of the order.</li>
            <li><span class='sql'>SHIP_DATE</span>Date of shipment.</li>
            <li><span class='sql'>DATE_NEEDED</span>Date needed (can be null).</li>
            <li><span class='sql'>PAID</span>Payment status.</li>
            <li><span class='sql'>QTY_ORDERED</span>Quantity ordered.</li>
            <li><span class='sql'>TOTAL_VALUE</span>Total value of the order.</li>
            <li><span class='sql'>DISCOUNT</span>Discount applied.</li>
            <li><span class='sql'>ITEM_TYPE</span>Type of item in the order.</li>
            <li><span class='sql'>AGED</span>Aged value.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>PO_NUMBER</th>
                    <th>CUST_NO</th>
                    <th>SALES_REP</th>
                    <th>ORDER_STATUS</th>
                    <th>ORDER_DATE</th>
                    <th>SHIP_DATE</th>
                    <th>DATE_NEEDED</th>
                    <th>PAID</th>
                    <th>QTY_ORDERED</th>
                    <th>TOTAL_VALUE</th>
                    <th>DISCOUNT</th>
                    <th>ITEM_TYPE</th>
                    <th>AGED</th>
                </tr>
                <tr>
                    <td>V91E0210</td>
                    <td>1004</td>
                    <td>11</td>
                    <td>shipped</td>
                    <td>1991-03-04 00:00:00</td>
                    <td>1991-03-05 00:00:00</td>
                    <td>[null]</td>
                    <td>y</td>
                    <td>10</td>
                    <td>5000.00</td>
                    <td>0.100000</td>
                    <td>hardware</td>
                    <td>1.000000000</td>
                </tr>
            </table>
        </div>
    </div>                            
    {if $User->showAd()}
        {* <div class="referal-add-block">
            <div id="yandex_rtb_R-A-4716552-7"></div>
            <a target="_blank" rel="nofollow" href="https://bywiola.com/g/u1k11fxms7fec845fb2fd629c4b097/?i=4">
                <img style="width: 100%;" border="0" src="https://ad.admitad.com/b/u1k11fxms7fec845fb2fd629c4b097/" alt="edX Many Geos"/>
            </a>
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