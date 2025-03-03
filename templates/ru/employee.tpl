<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>База данных Employee (Firebird)</h2>
    <p>
        Employee - это образец базы данных, которая поставляется с кроссплатформенной системой управления базами данных Firebird. 
        Вы можете использовать эту базу данных для изучения возможностей Firebird SQL и других функций СУБД. 
    </p>
    <h3>Список таблиц:</h3>

    <div class="accordion">
        <span><span class='sql'>COUNTRY</span> - таблица стран.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Название страны.</li>
            <li><span class='sql'>CURRENCY</span>Валюта, используемая в стране.</li>
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
        <span><span class='sql'>JOB</span> - штатное расписание компании.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>Код работы.</li>
            <li><span class='sql'>JOB_GRADE</span>Категория работы.</li>
            <li><span class='sql'>JOB_COUNTRY</span>Страна, связанная с работой.</li>
            <li><span class='sql'>JOB_TITLE</span>Название работы.</li>
            <li><span class='sql'>MIN_SALARY</span>Минимальная зарплата по работе.</li>
            <li><span class='sql'>MAX_SALARY</span>Максимальная зарплата по работе.</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>Требования к работе.</li>
            <li><span class='sql'>LANGUAGE_REQ</span>Требования к языку.</li>
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
            </table>
        </div>    
    </div>
    <div class="accordion">
        <span><span class='sql'>DEPARTMENT</span> - подразделения компании.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Номер отдела.</li>
            <li><span class='sql'>DEPARTMENT</span>Название отдела.</li>
            <li><span class='sql'>HEAD_DEPT</span>Главный отдел (может быть null).</li>
            <li><span class='sql'>MNGR_NO</span>Номер менеджера.</li>
            <li><span class='sql'>BUDGET</span>Бюджет отдела.</li>
            <li><span class='sql'>LOCATION</span>Местоположение отдела.</li>
            <li><span class='sql'>PHONE_NO</span>Телефонный номер отдела.</li>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>EMPLOYEE</span> - список сотрудников.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Номер сотрудника.</li>
            <li><span class='sql'>FIRST_NAME</span>Имя сотрудника.</li>
            <li><span class='sql'>LAST_NAME</span>Фамилия сотрудника.</li>
            <li><span class='sql'>PHONE_EXT</span>Номер телефона сотрудника.</li>
            <li><span class='sql'>HIRE_DATE</span>Дата приема на работу.</li>
            <li><span class='sql'>DEPT_NO</span>Номер отдела.</li>
            <li><span class='sql'>JOB_CODE</span>Код должности сотрудника.</li>
            <li><span class='sql'>JOB_GRADE</span>Категория должности сотрудника.</li>
            <li><span class='sql'>JOB_COUNTRY</span>Страна, связанная с должностью сотрудника.</li>
            <li><span class='sql'>SALARY</span>Заработная плата сотрудника.</li>
            <li><span class='sql'>FULL_NAME</span>Полное имя сотрудника.</li>
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
        <span><span class='sql'>PROJECT</span> - список проектов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>Идентификатор проекта.</li>
            <li><span class='sql'>PROJ_NAME</span>Название проекта.</li>
            <li><span class='sql'>PROJ_DESC</span>Описание проекта.</li>
            <li><span class='sql'>TEAM_LEADER</span>Руководитель проекта.</li>
            <li><span class='sql'>PRODUCT</span>Продукт, связанный с проектом.</li>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - сотрудники по проектам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Номер сотрудника.</li>
            <li><span class='sql'>PROJ_ID</span>Идентификатор проекта.</li>
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
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - бюджет проектов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>FISCAL_YEAR</span>Фискальный год.</li>
            <li><span class='sql'>PROJ_ID</span>Идентификатор проекта.</li>
            <li><span class='sql'>DEPT_NO</span>Номер отдела.</li>
            <li><span class='sql'>QUART_HEAD_CNT</span>Количество сотрудников в отделе за квартал (может быть null).</li>
            <li><span class='sql'>PROJECTED_BUDGET</span>Проектируемый бюджет на фискальный год.</li>
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
        <span><span class='sql'>SALARY_HISTORY</span> - изменения зарплаты сотрудиков.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Номер сотрудника.</li>
            <li><span class='sql'>CHANGE_DATE</span>Дата изменения заработной платы.</li>
            <li><span class='sql'>UPDATER_ID</span>Идентификатор обновляющего.</li>
            <li><span class='sql'>OLD_SALARY</span>Предыдущая заработная плата.</li>
            <li><span class='sql'>PERCENT_CHANGE</span>Процентное изменение заработной платы.</li>
            <li><span class='sql'>NEW_SALARY</span>Новая заработная плата после изменения.</li>
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
        <span><span class='sql'>CUSTOMER</span> - клиенты компании.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>CUST_NO</span>Номер клиента.</li>
            <li><span class='sql'>CUSTOMER</span>Название клиента.</li>
            <li><span class='sql'>CONTACT_FIRST</span>Имя контактного лица.</li>
            <li><span class='sql'>CONTACT_LAST</span>Фамилия контактного лица.</li>
            <li><span class='sql'>PHONE_NO</span>Номер телефона клиента.</li>
            <li><span class='sql'>ADDRESS_LINE1</span>Адрес, строка 1.</li>
            <li><span class='sql'>ADDRESS_LINE2</span>Адрес, строка 2 (может быть null).</li>
            <li><span class='sql'>CITY</span>Город клиента.</li>
            <li><span class='sql'>STATE_PROVINCE</span>Штат или провинция клиента.</li>
            <li><span class='sql'>COUNTRY</span>Страна клиента.</li>
            <li><span class='sql'>POSTAL_CODE</span>Почтовый индекс клиента.</li>
            <li><span class='sql'>ON_HOLD</span>Статус "На удержании" (может быть null).</li>
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
        <span><span class='sql'>SALES</span> - список сотрудиков.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PO_NUMBER</span>Номер заказа.</li>
            <li><span class='sql'>CUST_NO</span>Номер клиента, связанный с заказом.</li>
            <li><span class='sql'>SALES_REP</span>Номер представителя по продажам.</li>
            <li><span class='sql'>ORDER_STATUS</span>Статус заказа.</li>
            <li><span class='sql'>ORDER_DATE</span>Дата заказа.</li>
            <li><span class='sql'>SHIP_DATE</span>Дата отгрузки.</li>
            <li><span class='sql'>DATE_NEEDED</span>Требуемая дата (может быть null).</li>
            <li><span class='sql'>PAID</span>Статус оплаты.</li>
            <li><span class='sql'>QTY_ORDERED</span>Заказанное количество.</li>
            <li><span class='sql'>TOTAL_VALUE</span>Общая стоимость заказа.</li>
            <li><span class='sql'>DISCOUNT</span>Примененная скидка.</li>
            <li><span class='sql'>ITEM_TYPE</span>Тип товара в заказе.</li>
            <li><span class='sql'>AGED</span>Значение старения.</li>
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
        {assign var=add_id value=0|mt_rand:4}
        <div class="referal-add-block">
            {if $add_id > 2}
                {* <a href="https://book24.ru/r/RaSLq?erid=LjN8KWDe6" target="_blank" style="text-decoration: none; display: flex; ">
                    <div  style = "width: 30%;">
                        <img style="width: 100%;" src="//ndc.book24.ru/resize/410x590/pim/products/images/fa/ba/018ee5fc-fe2e-7df9-b671-01280c60faba.jpg" alt="PostgreSQL Основы языка SQL : учебное пособие">
                    </div>
                    <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                        <div>Танимура Кэти: SQL для анализа данных.</div>
                        <div style="font-size: small; padding-top: 0.5em;">
                            В книге рассказывается о возможностях SQL применительно к анализу данных, сравниваются различные типы баз данных, описаны методы подготовки данных для анализа. 
                            Рассказано о типах данных, структуре SQL-запросов, профилировнии, структурировании и очистке данных. Описаны методы анализа временных рядов, трендов, приведены примеры анализа данных с учетом сезонности. 
                            Отдельные главы посвящены когортному анализу, текстовому анализу, выявлению и обработке аномалий, анализу результатов экспериментов и А/В-тестирования. Описано создание сложных наборов данных, комбинирование методов анализа. 
                            Приведены практические примеры анализа воронки продаж и потребительской корзины.
                        </div>
                    </div>
                </a> *}
                <a target="_blank" rel="nofollow" href="https://ujhjj.com/g/2fm4vusamufec845fb2f0da0172cef/?i=4&subid=sql&erid=LatgBVMfa">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/2fm4vusamufec845fb2f0da0172cef/" alt="Skillfactory.ru"/>
                </a>
                <a target="_blank" rel="nofollow" href="https://dhwnh.com/g/8gb84134qdfec845fb2faf541d880b/?i=4&subid=new-year&erid=LatgBjjaY">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/8gb84134qdfec845fb2faf541d880b/" alt="Hexlet.io"/>
                </a>
            {else}
                <a target="_blank" rel="nofollow" href="https://dhwnh.com/g/sggtutr216fec845fb2faf541d880b/?i=4&subid=analytic-prof&erid=LatgBqBgQ">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/sggtutr216fec845fb2faf541d880b/" alt="Hexlet.io"/>
                </a>
                <a target="_blank" rel="nofollow" href="https://ewwhk.com/g/brl8jkz38efec845fb2f0d79a64861/?i=4&subid=domains&erid=5jtCeReNwxHpfQTGR3xQ4Jh">
                    <img style="width:83.3%;" border="0" src="https://aflink.ru/b/brl8jkz38efec845fb2f0d79a64861/" alt="REG.RU"/>
                </a>
            {/if}
        </div>
    {/if}
</div>