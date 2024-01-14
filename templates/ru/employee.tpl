<div class="db-description">
    <h3>Описание базы данных Employee (Firebird)</h3>
    <p>
        Ниже приведен список этих таблиц:
    </p>
    <p>Таблица: COUNTRIES</p>
    <ul class="table-columns">
        <li>COUNTRY - Название страны.</li>
        <li>CURRENCY - Валюта, используемая в стране.</li>
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
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: JOB</p>
    <ul class="table-columns">
        <li>JOB_CODE - Код работы.</li>
        <li>JOB_GRADE - Категория работы.</li>
        <li>JOB_COUNTRY - Страна, связанная с работой.</li>
        <li>JOB_TITLE - Название работы.</li>
        <li>MIN_SALARY - Минимальная зарплата по работе.</li>
        <li>MAX_SALARY - Максимальная зарплата по работе.</li>
        <li>JOB_REQUIREMENT - Требования к работе.</li>
        <li>LANGUAGE_REQ - Требования к языку.</li>
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
                <td>Генеральный директор</td>
                <td>130000.00</td>
                <td>250000.00</td>
                <td>Нет специфических требований.</td>
                <td>[null]</td>
            </tr>
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: DEPARTMENT</p>
    <ul class="table-columns">
        <li>DEPT_NO - Номер отдела.</li>
        <li>DEPARTMENT - Название отдела.</li>
        <li>HEAD_DEPT - Главный отдел (может быть null).</li>
        <li>MNGR_NO - Номер менеджера.</li>
        <li>BUDGET - Бюджет отдела.</li>
        <li>LOCATION - Местоположение отдела.</li>
        <li>PHONE_NO - Телефонный номер отдела.</li>
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
                <td>Корпоративный офис</td>
                <td>[null]</td>
                <td>105</td>
                <td>1000000.00</td>
                <td>Монтерей</td>
                <td>(408) 555-1234</td>
            </tr>
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: EMPLOYEE</p>
    <ul class="table-columns">
        <li>EMP_NO - Номер сотрудника.</li>
        <li>FIRST_NAME - Имя сотрудника.</li>
        <li>LAST_NAME - Фамилия сотрудника.</li>
        <li>PHONE_EXT - Номер телефона сотрудника.</li>
        <li>HIRE_DATE - Дата приема на работу.</li>
        <li>DEPT_NO - Номер отдела.</li>
        <li>JOB_CODE - Код должности сотрудника.</li>
        <li>JOB_GRADE - Категория должности сотрудника.</li>
        <li>JOB_COUNTRY - Страна, связанная с должностью сотрудника.</li>
        <li>SALARY - Заработная плата сотрудника.</li>
        <li>FULL_NAME - Полное имя сотрудника.</li>
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
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: PROJECT</p>
    <ul class="table-columns">
        <li>PROJ_ID - Идентификатор проекта.</li>
        <li>PROJ_NAME - Название проекта.</li>
        <li>PROJ_DESC - Описание проекта.</li>
        <li>TEAM_LEADER - Руководитель проекта.</li>
        <li>PRODUCT - Продукт, связанный с проектом.</li>
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
                <td>Разработка системы управления видео базой данных для управления видео распределением по запросу.</td>
                <td>45</td>
                <td>software</td>
            </tr>
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: EMPLOYEE_PROJECT</p>
    <ul class="table-columns">
        <li>EMP_NO - Номер сотрудника.</li>
        <li>PROJ_ID - Идентификатор проекта.</li>
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
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: PROJ_DEPT_BUDGET</p>
    <ul class="table-columns">
        <li>FISCAL_YEAR - Фискальный год.</li>
        <li>PROJ_ID - Идентификатор проекта.</li>
        <li>DEPT_NO - Номер отдела.</li>
        <li>QUART_HEAD_CNT - Количество сотрудников в отделе за квартал (может быть null).</li>
        <li>PROJECTED_BUDGET - Проектируемый бюджет на фискальный год.</li>
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
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: SALARY_HISTORY</p>
    <ul class="table-columns">
        <li>EMP_NO - Номер сотрудника.</li>
        <li>CHANGE_DATE - Дата изменения заработной платы.</li>
        <li>UPDATER_ID - Идентификатор обновляющего.</li>
        <li>OLD_SALARY - Предыдущая заработная плата.</li>
        <li>PERCENT_CHANGE - Процентное изменение заработной платы.</li>
        <li>NEW_SALARY - Новая заработная плата после изменения.</li>
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
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: CUSTOMER</p>
    <ul class="table-columns">
        <li>CUST_NO - Номер клиента.</li>
        <li>CUSTOMER - Название клиента.</li>
        <li>CONTACT_FIRST - Имя контактного лица.</li>
        <li>CONTACT_LAST - Фамилия контактного лица.</li>
        <li>PHONE_NO - Номер телефона клиента.</li>
        <li>ADDRESS_LINE1 - Адрес, строка 1.</li>
        <li>ADDRESS_LINE2 - Адрес, строка 2 (может быть null).</li>
        <li>CITY - Город клиента.</li>
        <li>STATE_PROVINCE - Штат или провинция клиента.</li>
        <li>COUNTRY - Страна клиента.</li>
        <li>POSTAL_CODE - Почтовый индекс клиента.</li>
        <li>ON_HOLD - Статус "На удержании" (может быть null).</li>
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
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
    <p>Таблица: SALES_ORDER</p>
    <ul class="table-columns">
        <li>PO_NUMBER - Номер заказа.</li>
        <li>CUST_NO - Номер клиента, связанный с заказом.</li>
        <li>SALES_REP - Номер представителя по продажам.</li>
        <li>ORDER_STATUS - Статус заказа.</li>
        <li>ORDER_DATE - Дата заказа.</li>
        <li>SHIP_DATE - Дата отгрузки.</li>
        <li>DATE_NEEDED - Требуемая дата (может быть null).</li>
        <li>PAID - Статус оплаты.</li>
        <li>QTY_ORDERED - Заказанное количество.</li>
        <li>TOTAL_VALUE - Общая стоимость заказа.</li>
        <li>DISCOUNT - Примененная скидка.</li>
        <li>ITEM_TYPE - Тип товара в заказе.</li>
        <li>AGED - Значение старения.</li>
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
            <!-- Добавьте больше строк по мере необходимости -->
        </table>
    </div>
</div>