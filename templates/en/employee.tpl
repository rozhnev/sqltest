<div class="db-description">
    <h3>Employee Database (Firebird) description</h3>
    <p>
    Below is a list of these tables:
    </p>
    <p>Table: COUNTRIES</p>
    <ul class="table-columns">
        <li>COUNTRY - Name of the country.</li>
        <li>CURRENCY - Currency used in the country.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: JOB</p>
    <ul class="table-columns">
        <li>JOB_CODE - Job code.</li>
        <li>JOB_GRADE - Job grade.</li>
        <li>JOB_COUNTRY - Country associated with the job.</li>
        <li>JOB_TITLE - Job title.</li>
        <li>MIN_SALARY - Minimum salary for the job.</li>
        <li>MAX_SALARY - Maximum salary for the job.</li>
        <li>JOB_REQUIREMENT - Job requirements.</li>
        <li>LANGUAGE_REQ - Language requirements.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: DEPARTMENT</p>
    <ul class="table-columns">
        <li>DEPT_NO - Department number.</li>
        <li>DEPARTMENT - Department name.</li>
        <li>HEAD_DEPT - Head department (can be null).</li>
        <li>MNGR_NO - Manager number.</li>
        <li>BUDGET - Department budget.</li>
        <li>LOCATION - Department location.</li>
        <li>PHONE_NO - Phone number for the department.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: EMPLOYEE</p>
    <ul class="table-columns">
        <li>EMP_NO - Employee number.</li>
        <li>FIRST_NAME - First name of the employee.</li>
        <li>LAST_NAME - Last name of the employee.</li>
        <li>PHONE_EXT - Phone extension for the employee.</li>
        <li>HIRE_DATE - Date of employee's hire.</li>
        <li>DEPT_NO - Department number.</li>
        <li>JOB_CODE - Job code for the employee.</li>
        <li>JOB_GRADE - Job grade for the employee.</li>
        <li>JOB_COUNTRY - Country associated with the employee's job.</li>
        <li>SALARY - Salary of the employee.</li>
        <li>FULL_NAME - Full name of the employee.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: PROJECT</p>
    <ul class="table-columns">
        <li>PROJ_ID - Project ID.</li>
        <li>PROJ_NAME - Project name.</li>
        <li>PROJ_DESC - Project description.</li>
        <li>TEAM_LEADER - Team leader for the project.</li>
        <li>PRODUCT - Product associated with the project.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: EMPLOYEE_PROJECT</p>
    <ul class="table-columns">
        <li>EMP_NO - Employee number.</li>
        <li>PROJ_ID - Project ID.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: PROJ_DEPT_BUDGET</p>
    <ul class="table-columns">
        <li>FISCAL_YEAR - Fiscal year.</li>
        <li>PROJ_ID - Project ID.</li>
        <li>DEPT_NO - Department number.</li>
        <li>QUART_HEAD_CNT - Quarter headcount (can be null).</li>
        <li>PROJECTED_BUDGET - Projected budget for the fiscal year.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: SALARY_HISTORY</p>
    <ul class="table-columns">
        <li>EMP_NO - Employee number.</li>
        <li>CHANGE_DATE - Date of salary change.</li>
        <li>UPDATER_ID - Updater ID.</li>
        <li>OLD_SALARY - Previous salary.</li>
        <li>PERCENT_CHANGE - Percentage change in salary.</li>
        <li>NEW_SALARY - New salary after the change.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: CUSTOMER</p>
    <ul class="table-columns">
        <li>CUST_NO - Customer number.</li>
        <li>CUSTOMER - Customer name.</li>
        <li>CONTACT_FIRST - First name of the contact person.</li>
        <li>CONTACT_LAST - Last name of the contact person.</li>
        <li>PHONE_NO - Phone number for the customer.</li>
        <li>ADDRESS_LINE1 - Address line 1.</li>
        <li>ADDRESS_LINE2 - Address line 2 (can be null).</li>
        <li>CITY - City of the customer.</li>
        <li>STATE_PROVINCE - State or province of the customer.</li>
        <li>COUNTRY - Country of the customer.</li>
        <li>POSTAL_CODE - Postal code of the customer.</li>
        <li>ON_HOLD - On hold status (can be null).</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
    <p>Table: SALES_ORDER</p>
    <ul class="table-columns">
        <li>PO_NUMBER - Purchase order number.</li>
        <li>CUST_NO - Customer number associated with the order.</li>
        <li>SALES_REP - Sales representative number.</li>
        <li>ORDER_STATUS - Order status.</li>
        <li>ORDER_DATE - Date of the order.</li>
        <li>SHIP_DATE - Date of shipment.</li>
        <li>DATE_NEEDED - Date needed (can be null).</li>
        <li>PAID - Payment status.</li>
        <li>QTY_ORDERED - Quantity ordered.</li>
        <li>TOTAL_VALUE - Total value of the order.</li>
        <li>DISCOUNT - Discount applied.</li>
        <li>ITEM_TYPE - Type of item in the order.</li>
        <li>AGED - Aged value.</li>
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
            <!-- Add more rows as needed -->
        </table>
    </div>
</div>
