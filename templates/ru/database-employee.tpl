{* Текст лендинга /ru/database/employee (Controller::database(), оболочка database.tpl).
   Числа строк и результаты запросов проверены на базе песочницы firebird4_employee. *}
<h1>База данных Employee (Firebird): схема, таблицы и SQL-задачи</h1>
<p class="db-lead">
    Employee — учебная база, которая поставляется вместе с Firebird: сотрудники, отделы, должности, проекты, клиенты и продажи небольшой компании.
    На SQLtest.online с ней можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>10</strong> таблиц и 1 представление</li>
    <li><strong>42</strong> сотрудника</li>
    <li><strong>21</strong> отдел</li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по Employee</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть Employee в песочнице</a>
    {/if}
</div>

<h2>Что такое Employee</h2>
<p>
    Employee — классическая учебная база Firebird, доставшаяся от InterBase. Она описывает небольшую международную компанию: дерево отделов, сотрудников и историю зарплат, проекты с бюджетами и продажи клиентам.
</p>
<p>
    База небольшая, поэтому результаты легко проверить глазами, но связи в ней интересные: иерархия отделов, составной внешний ключ от сотрудника к должности и связь «многие ко многим» между сотрудниками и проектами. Заодно на ней удобно освоить диалект SQL Firebird.
</p>

{if $ErdImage}
    <h2>ER-диаграмма</h2>
    <p>Диаграмма показывает таблицы Employee и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных Employee">ER-диаграмма базы данных Employee</object>
    </a>
{/if}

<h2>Из чего состоит база</h2>
<p>Таблицы делятся на три группы.</p>
<div class="db-groups">
    <div>
        <h3>Персонал</h3>
        <p><span class="sql">EMPLOYEE</span>, <span class="sql">DEPARTMENT</span> (у каждого отдела есть вышестоящий), <span class="sql">JOB</span> и <span class="sql">SALARY_HISTORY</span>.</p>
    </div>
    <div>
        <h3>Проекты</h3>
        <p><span class="sql">PROJECT</span>, таблица связей <span class="sql">EMPLOYEE_PROJECT</span> и годовые бюджеты в <span class="sql">PROJ_DEPT_BUDGET</span>.</p>
    </div>
    <div>
        <h3>Продажи</h3>
        <p><span class="sql">CUSTOMER</span>, <span class="sql">SALES</span> (заказы) и <span class="sql">COUNTRY</span> с валютами.</p>
    </div>
</div>
<p>
    Главное, что стоит запомнить: должность определяется сразу тремя столбцами (код, разряд и страна), поэтому соединение <span class="sql">EMPLOYEE</span> с <span class="sql">JOB</span> требует всех трёх. Представление <span class="sql">PHONE_LIST</span> объединяет сотрудников с телефонами их отделов.
</p>

<p>Сколько данных в таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">EMPLOYEE</span></td><td class="num">42</td><td>сотрудники</td></tr>
        <tr><td><span class="sql">DEPARTMENT</span></td><td class="num">21</td><td>отделы</td></tr>
        <tr><td><span class="sql">JOB</span></td><td class="num">31</td><td>должности и вилки зарплат</td></tr>
        <tr><td><span class="sql">SALARY_HISTORY</span></td><td class="num">49</td><td>изменения зарплат</td></tr>
        <tr><td><span class="sql">PROJECT</span></td><td class="num">6</td><td>проекты</td></tr>
        <tr><td><span class="sql">EMPLOYEE_PROJECT</span></td><td class="num">28</td><td>сотрудники ↔ проекты</td></tr>
        <tr><td><span class="sql">PROJ_DEPT_BUDGET</span></td><td class="num">24</td><td>бюджеты проектов по отделам и годам</td></tr>
        <tr><td><span class="sql">CUSTOMER</span></td><td class="num">15</td><td>клиенты</td></tr>
        <tr><td><span class="sql">SALES</span></td><td class="num">33</td><td>заказы</td></tr>
        <tr><td><span class="sql">COUNTRY</span></td><td class="num">16</td><td>страны и валюты</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>{if $PlaygroundLink}Эти запросы показывают, как связаны данные. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.{else}Эти запросы показывают, как связаны данные.{/if}</p>

<p><strong>Сотрудник, отдел и должность</strong> — соединение по составному ключу из трёх столбцов:</p>
<pre><code class="language-sql">SELECT FIRST 3 e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT, j.JOB_TITLE
FROM EMPLOYEE e
JOIN DEPARTMENT d ON d.DEPT_NO = e.DEPT_NO
JOIN JOB j ON j.JOB_CODE = e.JOB_CODE
          AND j.JOB_GRADE = e.JOB_GRADE
          AND j.JOB_COUNTRY = e.JOB_COUNTRY
ORDER BY e.EMP_NO;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>FIRST_NAME</th><th>LAST_NAME</th><th>DEPARTMENT</th><th>JOB_TITLE</th></tr>
        <tr><td>Robert</td><td>Nelson</td><td>Engineering</td><td>Vice President</td></tr>
        <tr><td>Bruce</td><td>Young</td><td>Software Development</td><td>Engineer</td></tr>
        <tr><td>Kim</td><td>Lambert</td><td>Field Office: East Coast</td><td>Engineer</td></tr>
    </table>
</div>

<p><strong>Заказы и клиенты</strong> — в Firebird число строк ограничивают через <span class="sql">FIRST n</span>:</p>
<pre><code class="language-sql">SELECT FIRST 3 s.PO_NUMBER, c.CUSTOMER, s.ORDER_DATE, s.TOTAL_VALUE
FROM SALES s
JOIN CUSTOMER c ON c.CUST_NO = s.CUST_NO
ORDER BY s.ORDER_DATE;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>PO_NUMBER</th><th>CUSTOMER</th><th>ORDER_DATE</th><th>TOTAL_VALUE</th></tr>
        <tr><td>V91E0210</td><td>Central Bank</td><td>1991-03-04 00:00:00</td><td class="num">5000.00</td></tr>
        <tr><td>V92J1003</td><td>MPM Corporation</td><td>1992-07-26 00:00:00</td><td class="num">2985.00</td></tr>
        <tr><td>V92E0340</td><td>Central Bank</td><td>1992-10-15 00:00:00</td><td class="num">70000.00</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач на базе Employee: {$TasksCount} — от простых выборок до оконных функций и изменения данных. Решение проверяется автоматически на настоящем Firebird.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи по базе Employee:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по Employee →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать Firebird, чтобы работать с Employee?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице Employee доступна в Firebird 4.0.</p>
    <h3>Откуда взялась база Employee?</h3>
    <p>Она поставляется с Firebird как пример базы данных (employee.fdb) и ведёт историю ещё от InterBase — предшественника Firebird.</p>
    <h3>Чем отличается SQL в Firebird?</h3>
    <p>Большая часть стандартного SQL работает как обычно. Первое, с чем вы столкнётесь: <span class="sql">FIRST n</span> / <span class="sql">SKIP n</span> или <span class="sql">FETCH FIRST n ROWS ONLY</span> для ограничения строк и имена объектов в верхнем регистре.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать Firebird, чтобы работать с Employee?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице Employee доступна в Firebird 4.0."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Откуда взялась база Employee?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Она поставляется с Firebird как пример базы данных (employee.fdb) и ведёт историю ещё от InterBase — предшественника Firebird."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Чем отличается SQL в Firebird?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Большая часть стандартного SQL работает как обычно. Первое, с чем вы столкнётесь: FIRST n / SKIP n или FETCH FIRST n ROWS ONLY для ограничения строк и имена объектов в верхнем регистре."{rdelim}{rdelim}
    ]
{rdelim}
</script>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Начать решать задачи</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть песочницу</a>
    {/if}
</div>
