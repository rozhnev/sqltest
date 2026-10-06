{* Текст лендинга /ru/database/university (Controller::database(), оболочка database.tpl).
   Числа строк и результаты запросов проверены на базе песочницы mariadb118_university. *}
<h1>База данных University (MariaDB): схема, таблицы и SQL-задачи</h1>
<p class="db-lead">
    University — учебная база MariaDB об университете: факультеты, преподаватели, студенты, курсы, учебные группы, записи на курсы, оценки и научная работа.
    На SQLtest.online с ней можно работать прямо в браузере: решать задачи с автоматической проверкой и писать свои запросы в песочнице, ничего не устанавливая.
</p>

<ul class="db-stats">
    <li><strong>16</strong> таблиц и 7 представлений</li>
    <li><strong>2 000</strong> студентов</li>
    <li><strong>24 981</strong> запись на курсы</li>
    <li><strong>{$TasksCount}</strong> SQL-задачи</li>
</ul>

<div class="db-actions">
    {if $AllTasksLink}
        <a class="button green" href="{$AllTasksLink}">Решать задачи по University</a>
    {/if}
    {if $PlaygroundLink}
        <a class="button blue" href="{$PlaygroundLink}">Открыть University в песочнице</a>
    {/if}
</div>

<h2>Что такое University</h2>
<p>
    University — современная учебная база для MariaDB 11, задуманная как более богатая альтернатива классической Sakila. Она нормализована до третьей нормальной формы и использует многие типы данных MariaDB: JSON, ENUM и SET, полнотекстовые индексы и столбцы VECTOR для эмбеддингов.
</p>
<p>
    Данных достаточно для настоящей аналитики: около 25 тысяч записей на курсы, 300 тысяч оценок и журнал изменений больше чем на полмиллиона строк. При этом предметная область знакома каждому, кто учился в вузе.
</p>

{if $ErdImage}
    <h2>ER-диаграмма</h2>
    <p>Диаграмма показывает таблицы University и связи между ними по внешним ключам. Нажмите, чтобы открыть её в полном размере.</p>
    <a class="db-erd" href="{$ErdLink}" target="ERDWindow" rel="noopener">
        {* <object>, not <img>: the SVG takes its styles from /css/erd.css (xml-stylesheet), which an <img> doesn't load *}
        <object data="{$ErdImage}" type="image/svg+xml" width="1920" height="1320" aria-label="ER-диаграмма базы данных University">ER-диаграмма базы данных University</object>
    </a>
{/if}

<h2>Из чего состоит база</h2>
<p>Таблицы делятся на три группы.</p>
<div class="db-groups">
    <div>
        <h3>Люди и структура</h3>
        <p><span class="sql">departments</span> (дерево), <span class="sql">faculty</span>, <span class="sql">students</span> и <span class="sql">rooms</span>.</p>
    </div>
    <div>
        <h3>Учёба</h3>
        <p><span class="sql">courses</span> с <span class="sql">course_prerequisites</span>, <span class="sql">semesters</span>, <span class="sql">sections</span>, <span class="sql">enrollments</span> и <span class="sql">grade_events</span>.</p>
    </div>
    <div>
        <h3>Наука и деньги</h3>
        <p><span class="sql">research_projects</span>, <span class="sql">project_members</span>, <span class="sql">publications</span>, <span class="sql">scholarships</span> и <span class="sql">student_scholarships</span>, а также <span class="sql">audit_log</span>.</p>
    </div>
</div>
<p>
    Главное, что стоит запомнить: студент записывается не на курс, а на группу — конкретный поток курса в семестре. Поэтому путь от студента к курсу такой: <span class="sql">enrollments</span> → <span class="sql">sections</span> → <span class="sql">courses</span>. Семь представлений, например <span class="sql">v_student_gpa</span> и <span class="sql">v_course_pass_rate</span>, содержат готовые отчёты.
</p>

<p>Сколько данных в таблицах:</p>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>Таблица</th><th>Строк</th><th>Что хранит</th></tr>
        <tr><td><span class="sql">students</span></td><td class="num">2 000</td><td>студенты</td></tr>
        <tr><td><span class="sql">faculty</span></td><td class="num">250</td><td>преподаватели</td></tr>
        <tr><td><span class="sql">departments</span></td><td class="num">25</td><td>факультеты и кафедры</td></tr>
        <tr><td><span class="sql">courses</span></td><td class="num">116</td><td>курсы</td></tr>
        <tr><td><span class="sql">course_prerequisites</span></td><td class="num">49</td><td>обязательные предшествующие курсы</td></tr>
        <tr><td><span class="sql">semesters</span></td><td class="num">20</td><td>семестры</td></tr>
        <tr><td><span class="sql">sections</span></td><td class="num">1 715</td><td>учебные группы курса в семестре</td></tr>
        <tr><td><span class="sql">rooms</span></td><td class="num">48</td><td>аудитории</td></tr>
        <tr><td><span class="sql">enrollments</span></td><td class="num">24 981</td><td>записи на курсы</td></tr>
        <tr><td><span class="sql">grade_events</span></td><td class="num">307 081</td><td>оценки за задания и экзамены</td></tr>
        <tr><td><span class="sql">research_projects</span></td><td class="num">200</td><td>научные проекты</td></tr>
        <tr><td><span class="sql">project_members</span></td><td class="num">876</td><td>участники проектов</td></tr>
        <tr><td><span class="sql">publications</span></td><td class="num">500</td><td>публикации</td></tr>
        <tr><td><span class="sql">scholarships</span></td><td class="num">20</td><td>стипендии</td></tr>
        <tr><td><span class="sql">student_scholarships</span></td><td class="num">773</td><td>назначенные стипендии</td></tr>
        <tr><td><span class="sql">audit_log</span></td><td class="num">664 124</td><td>журнал изменений</td></tr>
    </table>
</div>

<h2>Структура таблиц</h2>
<p>Нажмите на таблицу, чтобы увидеть её столбцы, пример строки и ключи.</p>
<div class="db-tables">
    {include file="{$Lang}/{$DB}.tpl"}
</div>

<h2>Примеры запросов</h2>
<p>{if $PlaygroundLink}Эти запросы показывают, как связаны данные. Скопируйте любой и запустите в <a href="{$PlaygroundLink}">песочнице</a>.{else}Эти запросы показывают, как связаны данные.{/if}</p>

<p><strong>Студент, курс и оценка</strong> — от записи через группу к курсу и семестру:</p>
<pre><code class="language-sql">SELECT s.first_name, s.last_name, c.code, sem.name AS semester, e.final_grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN sections sec ON sec.section_id = e.section_id
JOIN courses c ON c.course_id = sec.course_id
JOIN semesters sem ON sem.semester_id = sec.semester_id
WHERE e.final_grade IS NOT NULL
ORDER BY e.enrollment_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>code</th><th>semester</th><th>final_grade</th></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH111</td><td>Fall 2024</td><td>B+</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>NURS102</td><td>Fall 2024</td><td>B</td></tr>
        <tr><td>Alexis</td><td>Collier</td><td>MATH106</td><td>Summer 2024</td><td>B</td></tr>
    </table>
</div>

<p><strong>Часы приёма из JSON</strong> — значение из JSON-столбца через <span class="sql">JSON_VALUE</span>:</p>
<pre><code class="language-sql">SELECT first_name, last_name,
       JSON_VALUE(office_hours, '$[0].day') AS day,
       JSON_VALUE(office_hours, '$[0].start') AS starts_at
FROM faculty
ORDER BY faculty_id
LIMIT 3;</code></pre>
<div class="db-scroll">
    <table class="db-rows">
        <tr><th>first_name</th><th>last_name</th><th>day</th><th>starts_at</th></tr>
        <tr><td>Danielle</td><td>Johnson</td><td>Tue</td><td>09:00</td></tr>
        <tr><td>Jason</td><td>Hahn</td><td>Fri</td><td>08:00</td></tr>
        <tr><td>Kathleen</td><td>Cannon</td><td>Fri</td><td>08:00</td></tr>
    </table>
</div>

<h2>SQL-задачи по темам</h2>
<p>
    Задач на базе University пока немного — {$TasksCount}, но их число растёт. Решение проверяется автоматически на настоящей MariaDB.
    Число справа — количество задач в теме, цветные метки — диапазон сложности.
</p>
{include file='database_topics.tpl'}

{if $StartTasks}
    <h2>С чего начать</h2>
    <p>Первые задачи по базе University:</p>
    {include file='database_start_tasks.tpl'}
    {if $AllTasksLink}
        <p><a href="{$AllTasksLink}">Все задачи по University →</a></p>
    {/if}
{/if}

<section class="db-faq">
    <h2>Частые вопросы</h2>
    <h3>Нужно ли устанавливать MariaDB, чтобы работать с University?</h3>
    <p>Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице University доступна в MariaDB 11.8.</p>
    <h3>Какие возможности MariaDB в ней используются?</h3>
    <p>Столбцы JSON, типы ENUM и SET, полнотекстовые индексы, столбцы VECTOR для эмбеддингов, представления и иерархия факультетов для рекурсивных запросов.</p>
    <h3>Можно ли изменять данные?</h3>
    <p>В песочнице база доступна только для чтения, чтобы у всех были одинаковые данные. Чтобы потренировать INSERT, UPDATE и DELETE на своих таблицах, выберите в песочнице обычную версию MariaDB.</p>
</section>
<script type="application/ld+json">
{ldelim}
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
        {ldelim}"@type": "Question", "name": "Нужно ли устанавливать MariaDB, чтобы работать с University?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Нет. Задачи и песочница на SQLtest.online выполняют запросы на сервере, достаточно браузера. В песочнице University доступна в MariaDB 11.8."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Какие возможности MariaDB в ней используются?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "Столбцы JSON, типы ENUM и SET, полнотекстовые индексы, столбцы VECTOR для эмбеддингов, представления и иерархия факультетов для рекурсивных запросов."{rdelim}{rdelim},
        {ldelim}"@type": "Question", "name": "Можно ли изменять данные?", "acceptedAnswer": {ldelim}"@type": "Answer", "text": "В песочнице база доступна только для чтения, чтобы у всех были одинаковые данные. Чтобы потренировать INSERT, UPDATE и DELETE на своих таблицах, выберите в песочнице обычную версию MariaDB."{rdelim}{rdelim}
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
