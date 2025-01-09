<div id="db-description" class="db-description">
    <h2>Employee Database (Firebird)</h2>
    <p>
     Employee is a sample database that comes with the Firebird cross-platform database management system.
     You can use this database to explore Firebird SQL and other DBMS features.
    </p>
    <p>Below is a list of this DB tables:</p>
    <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
      <li><span class='sql' onclick="scrollInfoPanel('COUNTRY_table_description')">COUNTRY</span> - table of countries.</li>
      <li><span class='sql' onclick="scrollInfoPanel('JOB_table_description')">JOB</span> - table of jobs.</li>
      <li><span class='sql' onclick="scrollInfoPanel('DEPARTMENT_table_description')">DEPARTMENT</span> - table of departments.</li>
      <li><span class='sql' onclick="scrollInfoPanel('EMPLOYEE_table_description')">EMPLOYEE</span> - table of employees.</li>
      <li><span class='sql' onclick="scrollInfoPanel('PROJECT_table_description')">PROJECT</span> - table of projects.</li>
      <li><span class='sql' onclick="scrollInfoPanel('EMPLOYEE_PROJECT_table_description')">EMPLOYEE_PROJECT</span> - table of employee to project relations.</li>
      <li><span class='sql' onclick="scrollInfoPanel('PROJ_DEPT_BUDGET_table_description')">PROJ_DEPT_BUDGET</span> - table of project budgets.</li>
      <li><span class='sql' onclick="scrollInfoPanel('SALARY_HISTORY_table_description')">SALARY_HISTORY</span> - table of employees salary changes history.</li>
      <li><span class='sql' onclick="scrollInfoPanel('CUSTOMER_table_description')">CUSTOMER</span> - table of customers.</li>
      <li><span class='sql' onclick="scrollInfoPanel('SALES_table_description')">SALES</span> - table of sales.</li>
    </ul>
    {if $User.show_ad}
        {* <a href="https://amzn.to/4dVmPhJ" target="_blank" style="text-decoration: none;">
          <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">
            <div  style = "width: 30%;">
                <img style="width: 100%;" src="/images/sql-in-10-minutes-by-ben-forta.jpg" alt="SQL in 10 Minutes a Day by Ben Forta">
            </div>
            <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                <div>SQL in 10 Minutes a Day by Ben Forta</div>
                <div style="font-size: small; padding-top: 0.5em;">
                Whether you're an application developer, database administrator, web application designer, mobile app developer, or Microsoft Office users, a good working knowledge of SQL is an important part of interacting with databases. And Sams Teach Yourself SQL in 10 Minutes offers the straightforward, practical answers you need to help you do your job. 
                </div>
            </div>
          </div>
        </a> *}
        <a target="_blank" rel="nofollow" href="https://bywiola.com/g/u1k11fxms7fec845fb2fd629c4b097/?i=4">
            <img style="width: 90%;" border="0" src="https://ad.admitad.com/b/u1k11fxms7fec845fb2fd629c4b097/" alt="edX Many Geos"/>
        </a>
    {/if}
    <h3 id="COUNTRY_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Table <span class='sql'>COUNTRY</span>
    </h3>
    Table columns: 
    <ul class="table-columns">
        <li><span class='sql'>COUNTRY</span> - Name of the country.</li>
        <li><span class='sql'>CURRENCY</span> - Currency used in the country.</li>
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
    <h3 id="JOB_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>JOB</span>
    </h3>
    Table columns: 
    <ul class="table-columns">
        <li><span class='sql'>JOB_CODE</span> - Job code.</li>
        <li><span class='sql'>JOB_GRADE</span> - Job grade.</li>
        <li><span class='sql'>JOB_COUNTRY</span> - Country associated with the job.</li>
        <li><span class='sql'>JOB_TITLE</span> - Job title.</li>
        <li><span class='sql'>MIN_SALARY</span> - Minimum salary for the job.</li>
        <li><span class='sql'>MAX_SALARY</span> - Maximum salary for the job.</li>
        <li><span class='sql'>JOB_REQUIREMENT</span> - Job requirements.</li>
        <li><span class='sql'>LANGUAGE_REQ</span> - Language requirements.</li>
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
    <h3 id="DEPARTMENT_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>DEPARTMENT</span>
    </h3>
    Table columns: 
    <ul class="table-columns">
        <li><span class='sql'>DEPT_NO</span> - Department number.</li>
        <li><span class='sql'>DEPARTMENT</span> - Department name.</li>
        <li><span class='sql'>HEAD_DEPT</span> - Head department (can be null).</li>
        <li><span class='sql'>MNGR_NO</span> - Manager number.</li>
        <li><span class='sql'>BUDGET</span> - Department budget.</li>
        <li><span class='sql'>LOCATION</span> - Department location.</li>
        <li><span class='sql'>PHONE_NO</span> - Phone number for the department.</li>
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
                <td>Corporate Headquarters</td>
                <td>[null]</td>
                <td>105</td>
                <td>1000000.00</td>
                <td>Monterey</td>
                <td>(408) 555-1234</td>
            </tr>
        </table>
    </div>
    <h3 id="EMPLOYEE_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>EMPLOYEE</span>
    </h3>
    Table columns: 
    <ul class="table-columns">
        <li><span class='sql'>EMP_NO</span> - Employee number.</li>
        <li><span class='sql'>FIRST_NAME</span> - First name of the employee.</li>
        <li><span class='sql'>LAST_NAME</span> - Last name of the employee.</li>
        <li><span class='sql'>PHONE_EXT</span> - Phone extension for the employee.</li>
        <li><span class='sql'>HIRE_DATE</span> - Date of employee's hire.</li>
        <li><span class='sql'>DEPT_NO</span> - Department number.</li>
        <li><span class='sql'>JOB_CODE</span> - Job code for the employee.</li>
        <li><span class='sql'>JOB_GRADE</span> - Job grade for the employee.</li>
        <li><span class='sql'>JOB_COUNTRY</span> - Country associated with the employee's job.</li>
        <li><span class='sql'>SALARY</span> - Salary of the employee.</li>
        <li><span class='sql'>FULL_NAME</span> - Full name of the employee.</li>
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
    <h3 id="PROJECT_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>PROJECT</span>
    </h3>
    Table columns: 
    <ul class="table-columns">
        <li><span class='sql'>PROJ_ID</span> - Project ID.</li>
        <li><span class='sql'>PROJ_NAME</span> - Project name.</li>
        <li><span class='sql'>PROJ_DESC</span> - Project description.</li>
        <li><span class='sql'>TEAM_LEADER</span> - Team leader for the project.</li>
        <li><span class='sql'>PRODUCT</span> - Product associated with the project.</li>
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
                <td>Design a video database management system for controlling on-demand video distribution.</td>
                <td>45</td>
                <td>software</td>
            </tr>
        </table>
    </div>
    <h3 id="EMPLOYEE_PROJECT_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>EMPLOYEE_PROJECT</span>
    </h3>
    Table columns: 
    <ul class="table-columns">
        <li><span class='sql'>EMP_NO</span> - Employee number.</li>
        <li><span class='sql'>PROJ_ID</span> - Project ID.</li>
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
    <h3 id="PROJ_DEPT_BUDGET_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>PROJ_DEPT_BUDGET</span>
    </h3>
    Table columns: <ul class="table-columns">
        <li><span class='sql'>FISCAL_YEAR</span> - Fiscal year.</li>
        <li><span class='sql'>PROJ_ID</span> - Project ID.</li>
        <li><span class='sql'>DEPT_NO</span> - Department number.</li>
        <li><span class='sql'>QUART_HEAD_CNT</span> - Quarter headcount (can be null).</li>
        <li><span class='sql'>PROJECTED_BUDGET</span> - Projected budget for the fiscal year.</li>
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
    <h3 id="SALARY_HISTORY_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>SALARY_HISTORY</span>
    </h3>
    Table columns: <ul class="table-columns">
        <li><span class='sql'>EMP_NO</span> - Employee number.</li>
        <li><span class='sql'>CHANGE_DATE</span> - Date of salary change.</li>
        <li><span class='sql'>UPDATER_ID</span> - Updater ID.</li>
        <li><span class='sql'>OLD_SALARY</span> - Previous salary.</li>
        <li><span class='sql'>PERCENT_CHANGE</span> - Percentage change in salary.</li>
        <li><span class='sql'>NEW_SALARY</span> - New salary after the change.</li>
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
    <h3 id="CUSTOMER_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>CUSTOMER</span>
    </h3>     
    Table columns: <ul class="table-columns">
        <li><span class='sql'>CUST_NO</span> - Customer number.</li>
        <li><span class='sql'>CUSTOMER</span> - Customer name.</li>
        <li><span class='sql'>CONTACT_FIRST</span> - First name of the contact person.</li>
        <li><span class='sql'>CONTACT_LAST</span> - Last name of the contact person.</li>
        <li><span class='sql'>PHONE_NO</span> - Phone number for the customer.</li>
        <li><span class='sql'>ADDRESS_LINE1</span> - Address line 1.</li>
        <li><span class='sql'>ADDRESS_LINE2</span> - Address line 2 (can be null).</li>
        <li><span class='sql'>CITY</span> - City of the customer.</li>
        <li><span class='sql'>STATE_PROVINCE</span> - State or province of the customer.</li>
        <li><span class='sql'>COUNTRY</span> - Country of the customer.</li>
        <li><span class='sql'>POSTAL_CODE</span> - Postal code of the customer.</li>
        <li><span class='sql'>ON_HOLD</span> - On hold status (can be null).</li>
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
    <h3 id="SALES_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
        </span>
        Table <span class='sql'>SALES</span>
    </h3>
    Table columns: <ul class="table-columns">
        <li><span class='sql'>PO_NUMBER</span> - Purchase order number.</li>
        <li><span class='sql'>CUST_NO</span> - Customer number associated with the order.</li>
        <li><span class='sql'>SALES_REP</span> - Sales representative number.</li>
        <li><span class='sql'>ORDER_STATUS</span> - Order status.</li>
        <li><span class='sql'>ORDER_DATE</span> - Date of the order.</li>
        <li><span class='sql'>SHIP_DATE</span> - Date of shipment.</li>
        <li><span class='sql'>DATE_NEEDED</span> - Date needed (can be null).</li>
        <li><span class='sql'>PAID</span> - Payment status.</li>
        <li><span class='sql'>QTY_ORDERED</span> - Quantity ordered.</li>
        <li><span class='sql'>TOTAL_VALUE</span> - Total value of the order.</li>
        <li><span class='sql'>DISCOUNT</span> - Discount applied.</li>
        <li><span class='sql'>ITEM_TYPE</span> - Type of item in the order.</li>
        <li><span class='sql'>AGED</span> - Aged value.</li>
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
