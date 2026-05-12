<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h1>База данных Employee: структура таблиц и обзор</h1>
    <p>База Employee (Firebird) - это учебный набор данных, который используется для изучения SQL и возможностей СУБД Firebird.</p>
    <p>На этой странице описаны структура таблиц, ключевые поля и связи, полезные для практических SQL-запросов.</p>
    <p>База данных Employee содержит 9 основных таблиц.</p>
    <h2>Список таблиц</h2>

    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>COUNTRY</span> - таблица стран.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Название страны</li>
            <li><span class='sql'>CURRENCY</span>Валюта, используемая в стране</li>
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
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>JOB</span> - штатное расписание компании.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql' style="min-width: 10rem;">JOB_CODE</span>Код работы</li>
            <li><span class='sql' style="min-width: 10rem;">JOB_GRADE</span>Категория работы</li>
            <li><span class='sql' style="min-width: 10rem;">JOB_COUNTRY</span>Страна, связанная с работой</li>
            <li><span class='sql' style="min-width: 10rem;">JOB_TITLE</span>Название работы</li>
            <li><span class='sql' style="min-width: 10rem;">MIN_SALARY</span>Минимальная зарплата по работе</li>
            <li><span class='sql' style="min-width: 10rem;">MAX_SALARY</span>Максимальная зарплата по работе</li>
            <li><span class='sql' style="min-width: 10rem;">JOB_REQUIREMENT</span>Требования к работе</li>
            <li><span class='sql' style="min-width: 10rem;">LANGUAGE_REQ</span>Требования к языку</li>
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
                    <td>Генеральный директор</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>Нет специфических требований.</td>
                    <td>[null]</td>
                </tr></tbody></table>
        </div>    
        <ul class="table-columns">
            <li>FOREIGN KEY (JOB_COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>DEPARTMENT</span> - подразделения компании.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Номер отдела</li>
            <li><span class='sql'>DEPARTMENT</span>Название отдела</li>
            <li><span class='sql'>HEAD_DEPT</span>Главный отдел (может быть null)</li>
            <li><span class='sql'>MNGR_NO</span>Номер менеджера</li>
            <li><span class='sql'>BUDGET</span>Бюджет отдела</li>
            <li><span class='sql'>LOCATION</span>Местоположение отдела</li>
            <li><span class='sql'>PHONE_NO</span>Телефонный номер отдела</li>
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
                    <td>Корпоративный офис</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>Монтерей</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (HEAD_DEPT) REFERENCES DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>EMPLOYEE</span> - список сотрудников.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Номер сотрудника</li>
            <li><span class='sql'>FIRST_NAME</span>Имя сотрудника</li>
            <li><span class='sql'>LAST_NAME</span>Фамилия сотрудника</li>
            <li><span class='sql'>PHONE_EXT</span>Номер телефона сотрудника</li>
            <li><span class='sql'>HIRE_DATE</span>Дата приема на работу</li>
            <li><span class='sql'>DEPT_NO</span>Номер отдела</li>
            <li><span class='sql'>JOB_CODE</span>Код должности сотрудника</li>
            <li><span class='sql'>JOB_GRADE</span>Категория должности сотрудника</li>
            <li><span class='sql'>JOB_COUNTRY</span>Страна, связанная с должностью сотрудника</li>
            <li><span class='sql'>SALARY</span>Заработная плата сотрудника</li>
            <li><span class='sql'>FULL_NAME</span>Полное имя сотрудника</li>
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
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>PROJECT</span> - список проектов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>Идентификатор проекта</li>
            <li><span class='sql'>PROJ_NAME</span>Название проекта</li>
            <li><span class='sql'>PROJ_DESC</span>Описание проекта</li>
            <li><span class='sql'>TEAM_LEADER</span>Руководитель проекта</li>
            <li><span class='sql'>PRODUCT</span>Продукт, связанный с проектом</li>
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
                    <td>Разработка системы управления видео базой данных для управления видео распределением по запросу.</td>
                    <td>45</td>
                    <td>software</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (TEAM_LEADER) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - сотрудники по проектам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Номер сотрудника</li>
            <li><span class='sql'>PROJ_ID</span>Идентификатор проекта</li>
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
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - бюджет проектов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql' style="min-width: 10rem;">FISCAL_YEAR</span>Фискальный год</li>
            <li><span class='sql' style="min-width: 10rem;">PROJ_ID</span>Идентификатор проекта</li>
            <li><span class='sql' style="min-width: 10rem;">DEPT_NO</span>Номер отдела</li>
            <li><span class='sql' style="min-width: 10rem;">QUART_HEAD_CNT</span>Количество сотрудников в отделе за квартал (может быть null)</li>
            <li><span class='sql' style="min-width: 10rem;">PROJECTED_BUDGET</span>Проектируемый бюджет на фискальный год</li>
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
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>SALARY_HISTORY</span> - изменения зарплаты.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql' style="min-width: 10rem;">EMP_NO</span>Номер сотрудника</li>
            <li><span class='sql' style="min-width: 10rem;">CHANGE_DATE</span>Дата изменения заработной платы</li>
            <li><span class='sql' style="min-width: 10rem;">UPDATER_ID</span>Идентификатор обновляющего</li>
            <li><span class='sql' style="min-width: 10rem;">OLD_SALARY</span>Предыдущая заработная плата</li>
            <li><span class='sql' style="min-width: 10rem;">PERCENT_CHANGE</span>Процентное изменение заработной платы</li>
            <li><span class='sql' style="min-width: 10rem;">NEW_SALARY</span>Новая заработная плата после изменения</li>
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
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>CUSTOMER</span> - клиенты компании.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql' style="min-width: 10rem;">CUST_NO</span>Номер клиента</li>
            <li><span class='sql' style="min-width: 10rem;">CUSTOMER</span>Название клиента</li>
            <li><span class='sql' style="min-width: 10rem;">CONTACT_FIRST</span>Имя контактного лица</li>
            <li><span class='sql' style="min-width: 10rem;">CONTACT_LAST</span>Фамилия контактного лица</li>
            <li><span class='sql' style="min-width: 10rem;">PHONE_NO</span>Номер телефона клиента</li>
            <li><span class='sql' style="min-width: 10rem;">ADDRESS_LINE1</span>Адрес, строка 1</li>
            <li><span class='sql' style="min-width: 10rem;">ADDRESS_LINE2</span>Адрес, строка 2 (может быть null)</li>
            <li><span class='sql' style="min-width: 10rem;">CITY</span>Город клиента</li>
            <li><span class='sql' style="min-width: 10rem;">STATE_PROVINCE</span>Штат или провинция клиента</li>
            <li><span class='sql' style="min-width: 10rem;">COUNTRY</span>Страна клиента</li>
            <li><span class='sql' style="min-width: 10rem;">POSTAL_CODE</span>Почтовый индекс клиента</li>
            <li><span class='sql' style="min-width: 10rem;">ON_HOLD</span>Статус "На удержании" (может быть null)</li>
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
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>SALES</span> - таблица продаж.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PO_NUMBER</span>Номер заказа</li>
            <li><span class='sql'>CUST_NO</span>Номер клиента, связанный с заказом</li>
            <li><span class='sql'>SALES_REP</span>Номер представителя по продажам</li>
            <li><span class='sql'>ORDER_STATUS</span>Статус заказа</li>
            <li><span class='sql'>ORDER_DATE</span>Дата заказа</li>
            <li><span class='sql'>SHIP_DATE</span>Дата отгрузки</li>
            <li><span class='sql'>DATE_NEEDED</span>Требуемая дата (может быть null)</li>
            <li><span class='sql'>PAID</span>Статус оплаты</li>
            <li><span class='sql'>QTY_ORDERED</span>Заказанное количество</li>
            <li><span class='sql'>TOTAL_VALUE</span>Общая стоимость заказа</li>
            <li><span class='sql'>DISCOUNT</span>Примененная скидка</li>
            <li><span class='sql'>ITEM_TYPE</span>Тип товара в заказе</li>
            <li><span class='sql'>AGED</span>Значение старения</li>
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
    <h3>Ниже приведен список представлений этой БД:</h3>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>PHONE_LIST</span> - представление со списком телефонов сотрудников.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Номер сотрудника</li>
            <li><span class='sql'>FIRST_NAME</span>Имя сотрудника</li>
            <li><span class='sql'>LAST_NAME</span>Фамилия сотрудника</li>
            <li><span class='sql'>PHONE_EXT</span>Добавочный номер сотрудника</li>
            <li><span class='sql'>LOCATION</span>Местоположение отдела</li>
            <li><span class='sql'>PHONE_NO</span>Телефонный номер отдела</li>
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
            <div id="yandex_rtb_R-A-4716552-7"></div>
        </div>
    {/if}
</div>