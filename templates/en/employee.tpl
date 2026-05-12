<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h1>Employee Database: table structure and overview</h1>
    <p>The Employee database (Firebird) is a sample dataset used to learn SQL and explore Firebird DBMS capabilities.</p>
    <p>This page describes table structure, key columns, and relationships for practical SQL querying.</p>
    <p>The Employee database contains 9 main tables.</p>
    <h2>List of tables</h2>

    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>COUNTRY</span> - countries table.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Name of the country</li>
            <li><span class='sql'>CURRENCY</span>Currency used in the country</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">CURRENCY</th>
                </tr></thead><tbody><tr>
                    <td>USA</td>
                    <td>Dollar</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>JOB</span> - company's staff schedule.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>Job code</li>
            <li><span class='sql'>JOB_GRADE</span>Job grade</li>
            <li><span class='sql'>JOB_COUNTRY</span>Country associated with the job</li>
            <li><span class='sql'>JOB_TITLE</span>Job title</li>
            <li><span class='sql'>MIN_SALARY</span>Minimum salary for the job</li>
            <li><span class='sql'>MAX_SALARY</span>Maximum salary for the job</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>Job requirements</li>
            <li><span class='sql'>LANGUAGE_REQ</span>Language requirements</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">JOB_CODE</th>
                    <th scope="col">JOB_GRADE</th>
                    <th scope="col">JOB_COUNTRY</th>
                    <th scope="col">JOB_TITLE</th>
                    <th scope="col">MIN_SALARY</th>
                    <th scope="col">MAX_SALARY</th>
                    <th scope="col">JOB_REQUIREMENT</th>
                    <th scope="col">LANGUAGE_REQ</th>
                </tr></thead><tbody><tr>
                    <td>CEO</td>
                    <td>1</td>
                    <td>USA</td>
                    <td>Chief Executive Officer</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>No specific requirements.</td>
                    <td>[null]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (JOB_COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>DEPARTMENT</span> - company divisions.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Department number</li>
            <li><span class='sql'>DEPARTMENT</span>Department name</li>
            <li><span class='sql'>HEAD_DEPT</span>Head department (can be null)</li>
            <li><span class='sql'>MNGR_NO</span>Manager number</li>
            <li><span class='sql'>BUDGET</span>Department budget</li>
            <li><span class='sql'>LOCATION</span>Department location</li>
            <li><span class='sql'>PHONE_NO</span>Phone number for the department</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">DEPARTMENT</th>
                    <th scope="col">HEAD_DEPT</th>
                    <th scope="col">MNGR_NO</th>
                    <th scope="col">BUDGET</th>
                    <th scope="col">LOCATION</th>
                    <th scope="col">PHONE_NO</th>
                </tr></thead><tbody><tr>
                    <td>000</td>
                    <td>Corporate Office</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (HEAD_DEPT) REFERENCES DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>EMPLOYEE</span> - list of employees.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Employee number</li>
            <li><span class='sql'>FIRST_NAME</span>First name of the employee</li>
            <li><span class='sql'>LAST_NAME</span>Last name of the employee</li>
            <li><span class='sql'>PHONE_EXT</span>Phone extension for the employee</li>
            <li><span class='sql'>HIRE_DATE</span>Date of employee's hire</li>
            <li><span class='sql'>DEPT_NO</span>Department number</li>
            <li><span class='sql'>JOB_CODE</span>Job code for the employee</li>
            <li><span class='sql'>JOB_GRADE</span>Job grade for the employee</li>
            <li><span class='sql'>JOB_COUNTRY</span>Country associated with the employee's job</li>
            <li><span class='sql'>SALARY</span>Salary of the employee</li>
            <li><span class='sql'>FULL_NAME</span>Full name of the employee</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">FIRST_NAME</th>
                    <th scope="col">LAST_NAME</th>
                    <th scope="col">PHONE_EXT</th>
                    <th scope="col">HIRE_DATE</th>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">JOB_CODE</th>
                    <th scope="col">JOB_GRADE</th>
                    <th scope="col">JOB_COUNTRY</th>
                    <th scope="col">SALARY</th>
                    <th scope="col">FULL_NAME</th>
                </tr></thead><tbody><tr>
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
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)</li>
            <li>FOREIGN KEY (JOB_CODE) REFERENCES JOB(JOB_CODE)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>PROJECT</span> - list of projects.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>Project ID</li>
            <li><span class='sql'>PROJ_NAME</span>Project name</li>
            <li><span class='sql'>PROJ_DESC</span>Project description</li>
            <li><span class='sql'>TEAM_LEADER</span>Team leader for the project</li>
            <li><span class='sql'>PRODUCT</span>Product associated with the project</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">PROJ_ID</th>
                    <th scope="col">PROJ_NAME</th>
                    <th scope="col">PROJ_DESC</th>
                    <th scope="col">TEAM_LEADER</th>
                    <th scope="col">PRODUCT</th>
                </tr></thead><tbody><tr>
                    <td>VBASE</td>
                    <td>Video Database</td>
                    <td>Development of a video database management system for managing video distribution on demand.</td>
                    <td>45</td>
                    <td>software</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (TEAM_LEADER) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - employee-project mapping.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Employee number</li>
            <li><span class='sql'>PROJ_ID</span>Project ID</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">PROJ_ID</th>
                </tr></thead><tbody><tr>
                    <td>144</td>
                    <td>DGPII</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)</li>
            <li>FOREIGN KEY (PROJ_ID) REFERENCES PROJECT(PROJ_ID)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - project budgets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>FISCAL_YEAR</span>Fiscal year</li>
            <li><span class='sql'>PROJ_ID</span>Project ID</li>
            <li><span class='sql'>DEPT_NO</span>Department number</li>
            <li><span class='sql'>QUART_HEAD_CNT</span>Quarter headcount (can be null)</li>
            <li><span class='sql'>PROJECTED_BUDGET</span>Projected budget for the fiscal year</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">FISCAL_YEAR</th>
                    <th scope="col">PROJ_ID</th>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">QUART_HEAD_CNT</th>
                    <th scope="col">PROJECTED_BUDGET</th>
                </tr></thead><tbody><tr>
                    <td>1994</td>
                    <td>GUIDE</td>
                    <td>100</td>
                    <td>[null]</td>
                    <td>200000.00</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (PROJ_ID) REFERENCES PROJECT(PROJ_ID)</li>
            <li>FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>SALARY_HISTORY</span> - history of employee salary changes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Employee number</li>
            <li><span class='sql'>CHANGE_DATE</span>Date of salary change</li>
            <li><span class='sql'>UPDATER_ID</span>Updater ID</li>
            <li><span class='sql'>OLD_SALARY</span>Previous salary</li>
            <li><span class='sql'>PERCENT_CHANGE</span>Percentage change in salary</li>
            <li><span class='sql'>NEW_SALARY</span>New salary after the change</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">CHANGE_DATE</th>
                    <th scope="col">UPDATER_ID</th>
                    <th scope="col">OLD_SALARY</th>
                    <th scope="col">PERCENT_CHANGE</th>
                    <th scope="col">NEW_SALARY</th>
                </tr></thead><tbody><tr>
                    <td>28</td>
                    <td>1992-12-15 00:00:00</td>
                    <td>admin2</td>
                    <td>20000.00</td>
                    <td>10.000000</td>
                    <td>22000.000000</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>CUSTOMER</span> - company clients.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>CUST_NO</span>Customer number</li>
            <li><span class='sql'>CUSTOMER</span>Customer name</li>
            <li><span class='sql'>CONTACT_FIRST</span>First name of the contact person</li>
            <li><span class='sql'>CONTACT_LAST</span>Last name of the contact person</li>
            <li><span class='sql'>PHONE_NO</span>Phone number for the customer</li>
            <li><span class='sql'>ADDRESS_LINE1</span> Address line 1</li>
            <li><span class='sql'>ADDRESS_LINE2</span>Address line 2 (can be null)</li>
            <li><span class='sql'>CITY</span>City of the customer</li>
            <li><span class='sql'>STATE_PROVINCE</span>State or province of the customer</li>
            <li><span class='sql'>COUNTRY</span>Country of the customer</li>
            <li><span class='sql'>POSTAL_CODE</span>Postal code of the customer</li>
            <li><span class='sql'>ON_HOLD</span>On hold status (can be null)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">CUSTOMER</th>
                    <th scope="col">CONTACT_FIRST</th>
                    <th scope="col">CONTACT_LAST</th>
                    <th scope="col">PHONE_NO</th>
                    <th scope="col">ADDRESS_LINE1</th>
                    <th scope="col">ADDRESS_LINE2</th>
                    <th scope="col">CITY</th>
                    <th scope="col">STATE_PROVINCE</th>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">POSTAL_CODE</th>
                    <th scope="col">ON_HOLD</th>
                </tr></thead><tbody><tr>
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
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
    <span><span class='sql'>SALES</span> - list of sales.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PO_NUMBER</span>Purchase order number</li>
            <li><span class='sql'>CUST_NO</span>Customer number associated with the order</li>
            <li><span class='sql'>SALES_REP</span>Sales representative number</li>
            <li><span class='sql'>ORDER_STATUS</span>Order status</li>
            <li><span class='sql'>ORDER_DATE</span>Date of the order</li>
            <li><span class='sql'>SHIP_DATE</span>Date of shipment</li>
            <li><span class='sql'>DATE_NEEDED</span>Date needed (can be null)</li>
            <li><span class='sql'>PAID</span>Payment status</li>
            <li><span class='sql'>QTY_ORDERED</span>Quantity ordered</li>
            <li><span class='sql'>TOTAL_VALUE</span>Total value of the order</li>
            <li><span class='sql'>DISCOUNT</span>Discount applied</li>
            <li><span class='sql'>ITEM_TYPE</span>Type of item in the order</li>
            <li><span class='sql'>AGED</span>Aged value</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">PO_NUMBER</th>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">SALES_REP</th>
                    <th scope="col">ORDER_STATUS</th>
                    <th scope="col">ORDER_DATE</th>
                    <th scope="col">SHIP_DATE</th>
                    <th scope="col">DATE_NEEDED</th>
                    <th scope="col">PAID</th>
                    <th scope="col">QTY_ORDERED</th>
                    <th scope="col">TOTAL_VALUE</th>
                    <th scope="col">DISCOUNT</th>
                    <th scope="col">ITEM_TYPE</th>
                    <th scope="col">AGED</th>
                </tr></thead><tbody><tr>
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
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (CUST_NO) REFERENCES CUSTOMER(CUST_NO)</li>
            <li>FOREIGN KEY (SALES_REP) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <h3>Below is a list of this DB views:</h3>
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>PHONE_LIST</span> - employee phone list view.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Employee number</li>
            <li><span class='sql'>FIRST_NAME</span>First name of the employee</li>
            <li><span class='sql'>LAST_NAME</span>Last name of the employee</li>
            <li><span class='sql'>PHONE_EXT</span>Phone extension for the employee</li>
            <li><span class='sql'>LOCATION</span>Department location</li>
            <li><span class='sql'>PHONE_NO</span>Department phone number</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">FIRST_NAME</th>
                    <th scope="col">LAST_NAME</th>
                    <th scope="col">PHONE_EXT</th>
                    <th scope="col">LOCATION</th>
                    <th scope="col">PHONE_NO</th>
                </tr></thead><tbody><tr>
                    <td>2</td>
                    <td>Robert</td>
                    <td>Nelson</td>
                    <td>250</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
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