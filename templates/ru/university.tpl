<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>База данных University: описание таблиц и структуры</h2>
    <p>University DB — это современная учебная база данных <strong>MariaDB 11.7+</strong> для изучения SQL, разработанная как многофункциональная замена классической базы данных Sakila.</p>
    <p>Она охватывает все значимые типы данных MariaDB, включая <span class='sql'>VECTOR(1536)</span>, <span class='sql'>JSON</span>, <span class='sql'>SET</span> и индексы <span class='sql'>FULLTEXT</span>, полностью нормализована до 3НФ и содержит достаточно данных как для начальных упражнений, так и для сложных аналитических запросов.</p>
    <p>База данных University содержит 16 основных таблиц, описывающих академическую структуру университета — кафедры, преподавателей, студентов, курсы, записи на курсы, научные проекты и многое другое.</p>
    <p>
        <a href="/{$Lang}/erd/University" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Открыть ER-диаграмму базы данных University в новом окне">
            <img src="/images/erd_small_light.svg" alt="ER-диаграмма базы данных University со связями между таблицами" style="width: 90%;" loading="lazy" decoding="async">
            ER диаграмма базы данных University
        </a>
    </p>
    <h3>Список таблиц</h3>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>semesters</span> - таблица учебных семестров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>semester_id</span>уникальный идентификатор записи (ПК, TINYINT)</li>
            <li><span class='sql'>term</span>тип периода: Fall, Spring или Summer (ENUM)</li>
            <li><span class='sql'>academic_year</span>учебный год (тип YEAR)</li>
            <li><span class='sql'>name</span>название семестра (например, 'Fall 2024')</li>
            <li><span class='sql'>start_date</span>первый день семестра</li>
            <li><span class='sql'>end_date</span>последний день семестра</li>
            <li><span class='sql'>enroll_deadline</span>последний день записи студентов на курсы</li>
            <li><span class='sql'>is_active</span>является ли семестр текущим (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">semester_id</th>
                        <th scope="col">term</th>
                        <th scope="col">academic_year</th>
                        <th scope="col">name</th>
                        <th scope="col">start_date</th>
                        <th scope="col">end_date</th>
                        <th scope="col">enroll_deadline</th>
                        <th scope="col">is_active</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Fall</td>
                        <td>2024</td>
                        <td>Fall 2024</td>
                        <td>2024-09-02</td>
                        <td>2024-12-20</td>
                        <td>2024-09-13</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (semester_id)</li>
            <li>UNIQUE KEY (term, academic_year)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>rooms</span> - аудитории и лаборатории кампуса.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>уникальный идентификатор записи (ПК, SMALLINT)</li>
            <li><span class='sql'>building</span>название корпуса</li>
            <li><span class='sql'>room_number</span>номер или обозначение аудитории</li>
            <li><span class='sql'>capacity</span>максимальное количество мест (SMALLINT)</li>
            <li><span class='sql'>room_type</span>тип аудитории: lecture, seminar, lab, computer_lab или online (ENUM)</li>
            <li><span class='sql'>has_projector</span>наличие проектора в аудитории (BOOLEAN)</li>
            <li><span class='sql'>has_video</span>наличие оборудования для видеоконференций (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">room_id</th>
                        <th scope="col">building</th>
                        <th scope="col">room_number</th>
                        <th scope="col">capacity</th>
                        <th scope="col">room_type</th>
                        <th scope="col">has_projector</th>
                        <th scope="col">has_video</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Science Hall</td>
                        <td>101</td>
                        <td>120</td>
                        <td>lecture</td>
                        <td>1</td>
                        <td>0</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (room_id)</li>
            <li>UNIQUE KEY (building, room_number)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>scholarships</span> - доступные стипендии.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>уникальный идентификатор записи (ПК, SMALLINT)</li>
            <li><span class='sql'>name</span>название стипендии</li>
            <li><span class='sql'>amount</span>размер выплаты (DECIMAL)</li>
            <li><span class='sql'>frequency</span>периодичность выплаты: one-time, annual или per-semester (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>критерии допуска в формате JSON — например, <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
            <li><span class='sql'>is_active</span>предоставляется ли стипендия в настоящее время (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">scholarship_id</th>
                        <th scope="col">name</th>
                        <th scope="col">amount</th>
                        <th scope="col">frequency</th>
                        <th scope="col">eligibility</th>
                        <th scope="col">is_active</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Dean's Excellence Award</td>
                        <td>5000.00</td>
                        <td>annual</td>
                        <td>{ldelim}"min_gpa": 3.8, "need_based": false, "majors": ["CS","Math"]{rdelim}</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>departments</span> - трёхуровневая иерархия подразделений (Факультет → Кафедра → Подразделение).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>уникальный идентификатор записи (ПК, TINYINT)</li>
            <li><span class='sql'>parent_id</span>идентификатор родительского подразделения — самоссылающийся ВК (допускает NULL)</li>
            <li><span class='sql'>code</span>краткий код подразделения (CHAR)</li>
            <li><span class='sql'>name</span>название подразделения</li>
            <li><span class='sql'>level</span>уровень иерархии: 1 = Факультет, 2 = Кафедра, 3 = Подразделение (TINYINT)</li>
            <li><span class='sql'>head_faculty_id</span>идентификатор заведующего кафедрой (ВК, допускает NULL)</li>
            <li><span class='sql'>established</span>год основания подразделения (YEAR, допускает NULL)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">department_id</th>
                        <th scope="col">parent_id</th>
                        <th scope="col">code</th>
                        <th scope="col">name</th>
                        <th scope="col">level</th>
                        <th scope="col">head_faculty_id</th>
                        <th scope="col">established</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>[null]</td>
                        <td>ENG</td>
                        <td>Faculty of Engineering</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1965</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (department_id)</li>
            <li>UNIQUE KEY (code)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (parent_id) REFERENCES departments(department_id)</li>
            <li>FOREIGN KEY (head_faculty_id) REFERENCES faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>faculty</span> - преподаватели университета.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>уникальный идентификатор записи (ПК, SMALLINT)</li>
            <li><span class='sql'>department_id</span>идентификатор кафедры (ВК)</li>
            <li><span class='sql'>first_name</span>имя преподавателя</li>
            <li><span class='sql'>last_name</span>фамилия преподавателя</li>
            <li><span class='sql'>email</span>институциональный адрес электронной почты</li>
            <li><span class='sql'>phone</span>рабочий номер телефона (допускает NULL)</li>
            <li><span class='sql'>rank</span>учёное звание: Instructor, Assistant Professor, Associate Professor, Professor или Emeritus (ENUM)</li>
            <li><span class='sql'>hire_date</span>дата приёма на работу</li>
            <li><span class='sql'>office</span>номер или местоположение кабинета (допускает NULL)</li>
            <li><span class='sql'>office_hours</span>еженедельные часы приёма в формате JSON-массива — например, <code>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</code></li>
            <li><span class='sql'>bio</span>биографический текст (TEXT, допускает NULL)</li>
            <li><span class='sql'>is_active</span>является ли преподаватель действующим сотрудником (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">faculty_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">phone</th>
                        <th scope="col">rank</th>
                        <th scope="col">hire_date</th>
                        <th scope="col">office</th>
                        <th scope="col">office_hours</th>
                        <th scope="col">bio</th>
                        <th scope="col">is_active</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>3</td>
                        <td>Alice</td>
                        <td>Carter</td>
                        <td>a.carter@university.edu</td>
                        <td>+15550100</td>
                        <td>Professor</td>
                        <td>2010-08-15</td>
                        <td>ENG-204</td>
                        <td>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</td>
                        <td>Expert in distributed systems.</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (faculty_id)</li>
            <li>UNIQUE KEY (email)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (department_id) REFERENCES departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>students</span> - зачисленные студенты.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>уникальный идентификатор записи (ПК, INT)</li>
            <li><span class='sql'>department_id</span>идентификатор основной кафедры студента (ВК)</li>
            <li><span class='sql'>student_number</span>уникальный номер студенческого билета (CHAR, например, 'S000123')</li>
            <li><span class='sql'>first_name</span>имя студента</li>
            <li><span class='sql'>last_name</span>фамилия студента</li>
            <li><span class='sql'>email</span>адрес электронной почты студента</li>
            <li><span class='sql'>date_of_birth</span>дата рождения студента</li>
            <li><span class='sql'>gender</span>пол: M, F, NB, Other или Prefer not to say (ENUM, допускает NULL)</li>
            <li><span class='sql'>enrollment_date</span>дата первичного зачисления студента</li>
            <li><span class='sql'>expected_grad</span>ожидаемый год окончания обучения (YEAR, допускает NULL)</li>
            <li><span class='sql'>status</span>статус зачисления: active, inactive, graduated, suspended или withdrawn (ENUM)</li>
            <li><span class='sql'>gpa</span>текущий накопленный средний балл 0.000–4.000, поддерживается триггером (DECIMAL, допускает NULL)</li>
            <li><span class='sql'>contacts</span>контакт для экстренной связи и адрес в формате JSON — например, <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">student_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">date_of_birth</th>
                        <th scope="col">gender</th>
                        <th scope="col">enrollment_date</th>
                        <th scope="col">expected_grad</th>
                        <th scope="col">status</th>
                        <th scope="col">gpa</th>
                        <th scope="col">contacts</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>3</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>j.miller@student.edu</td>
                        <td>2002-04-23</td>
                        <td>M</td>
                        <td>2021-09-01</td>
                        <td>2025</td>
                        <td>active</td>
                        <td>3.720</td>
                        <td>{ldelim}"emergency":{ldelim}"name":"Susan Miller","phone":"+1-555-0100"{rdelim}{rdelim}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (student_id)</li>
            <li>UNIQUE KEY (student_number)</li>
            <li>UNIQUE KEY (email)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (department_id) REFERENCES departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>courses</span> - каталог курсов с поддержкой полнотекстового и векторного поиска.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>уникальный идентификатор записи (ПК, SMALLINT)</li>
            <li><span class='sql'>department_id</span>идентификатор кафедры (ВК)</li>
            <li><span class='sql'>code</span>код курса, например, 'CS101' (CHAR)</li>
            <li><span class='sql'>title</span>название курса</li>
            <li><span class='sql'>credits</span>количество кредитных часов (TINYINT)</li>
            <li><span class='sql'>level</span>академический уровень: undergraduate, graduate или doctoral (ENUM)</li>
            <li><span class='sql'>description</span>подробное описание курса (TEXT, индекс FULLTEXT вместе с title)</li>
            <li><span class='sql'>is_active</span>преподаётся ли курс в настоящее время (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>1536-мерное семантическое эмбеддинг-представление для векторного поиска по сходству (VECTOR(1536), допускает NULL)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">code</th>
                        <th scope="col">title</th>
                        <th scope="col">credits</th>
                        <th scope="col">level</th>
                        <th scope="col">description</th>
                        <th scope="col">is_active</th>
                        <th scope="col">embedding</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>3</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>3</td>
                        <td>undergraduate</td>
                        <td>Introduction to relational databases, SQL, and data modeling.</td>
                        <td>1</td>
                        <td>[0.023, -0.011, ...]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (course_id)</li>
            <li>UNIQUE KEY (code)</li>
            <li>FULLTEXT (title, description)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (department_id) REFERENCES departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>course_prerequisites</span> - связи предварительных требований к курсам (самоссылающаяся связь многие-ко-многим).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>идентификатор курса (ВК)</li>
            <li><span class='sql'>prerequisite_id</span>идентификатор курса-prerequisite (ВК)</li>
            <li><span class='sql'>is_mandatory</span>является ли предварительный курс обязательным или рекомендуемым (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">prerequisite_id</th>
                        <th scope="col">is_mandatory</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5</td>
                        <td>1</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (course_id, prerequisite_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (course_id) REFERENCES courses(course_id)</li>
            <li>FOREIGN KEY (prerequisite_id) REFERENCES courses(course_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>sections</span> - секции курсов (конкретное проведение курса в рамках семестра).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>уникальный идентификатор записи (ПК, INT)</li>
            <li><span class='sql'>course_id</span>идентификатор курса (ВК)</li>
            <li><span class='sql'>semester_id</span>идентификатор семестра (ВК)</li>
            <li><span class='sql'>faculty_id</span>идентификатор преподавателя (ВК)</li>
            <li><span class='sql'>room_id</span>идентификатор назначенной аудитории (ВК, допускает NULL — для полностью онлайн-секций)</li>
            <li><span class='sql'>section_number</span>номер секции в рамках курса и семестра (TINYINT)</li>
            <li><span class='sql'>delivery</span>формат проведения: in-person, online или hybrid (ENUM)</li>
            <li><span class='sql'>max_capacity</span>максимальное количество записавшихся студентов (SMALLINT)</li>
            <li><span class='sql'>status</span>статус секции: open, closed, cancelled или completed (ENUM)</li>
            <li><span class='sql'>schedule</span>еженедельное расписание занятий в формате JSON — например, <code>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim}]</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">section_id</th>
                        <th scope="col">course_id</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">faculty_id</th>
                        <th scope="col">room_id</th>
                        <th scope="col">section_number</th>
                        <th scope="col">delivery</th>
                        <th scope="col">max_capacity</th>
                        <th scope="col">status</th>
                        <th scope="col">schedule</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>in-person</td>
                        <td>30</td>
                        <td>open</td>
                        <td>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim},{ldelim}"day":"Wed","start":"09:00","end":"10:30"{rdelim}]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (section_id)</li>
            <li>UNIQUE KEY (course_id, semester_id, section_number)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (course_id) REFERENCES courses(course_id)</li>
            <li>FOREIGN KEY (semester_id) REFERENCES semesters(semester_id)</li>
            <li>FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)</li>
            <li>FOREIGN KEY (room_id) REFERENCES rooms(room_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>enrollments</span> - записи студентов на секции курсов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>уникальный идентификатор записи (ПК, INT)</li>
            <li><span class='sql'>student_id</span>идентификатор студента (ВК)</li>
            <li><span class='sql'>section_id</span>идентификатор секции (ВК)</li>
            <li><span class='sql'>enrolled_at</span>дата и время зачисления (TIMESTAMP)</li>
            <li><span class='sql'>status</span>статус зачисления: enrolled, dropped, completed, failed или incomplete (ENUM)</li>
            <li><span class='sql'>final_grade</span>итоговая буквенная оценка, например, 'A', 'B+' (CHAR, допускает NULL)</li>
            <li><span class='sql'>final_score</span>итоговый числовой балл 0.00–100.00 (DECIMAL, допускает NULL)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">enrollment_id</th>
                        <th scope="col">student_id</th>
                        <th scope="col">section_id</th>
                        <th scope="col">enrolled_at</th>
                        <th scope="col">status</th>
                        <th scope="col">final_grade</th>
                        <th scope="col">final_score</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>2024-08-25 10:34:02</td>
                        <td>completed</td>
                        <td>A</td>
                        <td>93.50</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (enrollment_id)</li>
            <li>UNIQUE KEY (student_id, section_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (student_id) REFERENCES students(student_id)</li>
            <li>FOREIGN KEY (section_id) REFERENCES sections(section_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>student_scholarships</span> - стипендии, назначенные студентам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>award_id</span>уникальный идентификатор записи (ПК, INT)</li>
            <li><span class='sql'>student_id</span>идентификатор студента (ВК)</li>
            <li><span class='sql'>scholarship_id</span>идентификатор стипендии (ВК)</li>
            <li><span class='sql'>awarded_date</span>дата назначения стипендии</li>
            <li><span class='sql'>expires_date</span>дата истечения срока действия награды (допускает NULL)</li>
            <li><span class='sql'>amount_awarded</span>фактически выплаченная сумма (DECIMAL)</li>
            <li><span class='sql'>notes</span>дополнительные примечания к награде (TEXT, допускает NULL)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">award_id</th>
                        <th scope="col">student_id</th>
                        <th scope="col">scholarship_id</th>
                        <th scope="col">awarded_date</th>
                        <th scope="col">expires_date</th>
                        <th scope="col">amount_awarded</th>
                        <th scope="col">notes</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>2024-09-01</td>
                        <td>2025-08-31</td>
                        <td>5000.00</td>
                        <td>[null]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (award_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (student_id) REFERENCES students(student_id)</li>
            <li>FOREIGN KEY (scholarship_id) REFERENCES scholarships(scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>research_projects</span> - научно-исследовательские проекты кафедр.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>уникальный идентификатор записи (ПК, SMALLINT)</li>
            <li><span class='sql'>department_id</span>идентификатор кафедры (ВК)</li>
            <li><span class='sql'>lead_faculty_id</span>главный исследователь проекта (ВК)</li>
            <li><span class='sql'>title</span>название проекта</li>
            <li><span class='sql'>abstract</span>аннотация проекта (TEXT, допускает NULL)</li>
            <li><span class='sql'>start_date</span>дата начала проекта</li>
            <li><span class='sql'>end_date</span>дата окончания проекта (допускает NULL)</li>
            <li><span class='sql'>status</span>статус проекта: proposed, active, completed или cancelled (ENUM)</li>
            <li><span class='sql'>funding</span>источники финансирования в формате JSON — например, <code>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2024-001"{rdelim}]</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">project_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">lead_faculty_id</th>
                        <th scope="col">title</th>
                        <th scope="col">abstract</th>
                        <th scope="col">start_date</th>
                        <th scope="col">end_date</th>
                        <th scope="col">status</th>
                        <th scope="col">funding</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>5</td>
                        <td>1</td>
                        <td>AI-Assisted Drug Discovery</td>
                        <td>Using machine learning to identify candidate molecules.</td>
                        <td>2023-01-15</td>
                        <td>[null]</td>
                        <td>active</td>
                        <td>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2023-042"{rdelim}]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (project_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (department_id) REFERENCES departments(department_id)</li>
            <li>FOREIGN KEY (lead_faculty_id) REFERENCES faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>publications</span> - научные публикации с поддержкой полнотекстового поиска.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>уникальный идентификатор записи (ПК, INT)</li>
            <li><span class='sql'>project_id</span>идентификатор связанного научного проекта (ВК, допускает NULL)</li>
            <li><span class='sql'>title</span>название публикации</li>
            <li><span class='sql'>abstract</span>аннотация публикации (MEDIUMTEXT, индекс FULLTEXT вместе с title)</li>
            <li><span class='sql'>pub_year</span>год публикации (YEAR)</li>
            <li><span class='sql'>venue</span>название журнала или конференции (допускает NULL)</li>
            <li><span class='sql'>doi</span>цифровой идентификатор объекта (DOI, допускает NULL)</li>
            <li><span class='sql' style="min-width: 9rem;">keywords</span>ключевые теги — одно или несколько значений: AI, ML, Data Science, Networking, Security, Algorithms, Databases, HCI, Theory, Bioinformatics, Systems, Mathematics, Physics, Chemistry, Biology (SET)</li>
            <li><span class='sql'>citation_count</span>количество полученных цитирований (INT)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">publication_id</th>
                        <th scope="col">project_id</th>
                        <th scope="col">title</th>
                        <th scope="col">abstract</th>
                        <th scope="col">pub_year</th>
                        <th scope="col">venue</th>
                        <th scope="col">doi</th>
                        <th scope="col">keywords</th>
                        <th scope="col">citation_count</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>Deep Learning for Molecular Screening</td>
                        <td>We present a transformer-based architecture for virtual screening...</td>
                        <td>2024</td>
                        <td>Nature Machine Intelligence</td>
                        <td>10.1038/s42256-024-00001-1</td>
                        <td>AI,ML,Bioinformatics</td>
                        <td>12</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (publication_id)</li>
            <li>UNIQUE KEY (doi)</li>
            <li>FULLTEXT (title, abstract)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (project_id) REFERENCES research_projects(project_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>project_members</span> - участие преподавателей и студентов в научных проектах.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>member_id</span>уникальный идентификатор записи (ПК, INT)</li>
            <li><span class='sql'>project_id</span>идентификатор научного проекта (ВК)</li>
            <li><span class='sql'>faculty_id</span>идентификатор преподавателя (ВК, допускает NULL)</li>
            <li><span class='sql'>student_id</span>идентификатор студента (ВК, допускает NULL)</li>
            <li><span class='sql'>role</span>роль участника: Principal Investigator, Co-Investigator, Research Assistant, Graduate Student или Undergraduate Student (ENUM)</li>
            <li><span class='sql'>joined_date</span>дата вступления участника в проект</li>
            <li><span class='sql'>left_date</span>дата выхода участника из проекта (допускает NULL)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">member_id</th>
                        <th scope="col">project_id</th>
                        <th scope="col">faculty_id</th>
                        <th scope="col">student_id</th>
                        <th scope="col">role</th>
                        <th scope="col">joined_date</th>
                        <th scope="col">left_date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>[null]</td>
                        <td>Principal Investigator</td>
                        <td>2023-01-15</td>
                        <td>[null]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (member_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (project_id) REFERENCES research_projects(project_id)</li>
            <li>FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)</li>
            <li>FOREIGN KEY (student_id) REFERENCES students(student_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>grade_events</span> - отдельные оцениваемые элементы по каждому зачислению (~120 000 строк).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>уникальный идентификатор записи (ПК, BIGINT)</li>
            <li><span class='sql'>enrollment_id</span>идентификатор записи о зачислении (ВК)</li>
            <li><span class='sql'>item_name</span>название оцениваемого элемента (например, 'Assignment 1', 'Midterm Exam')</li>
            <li><span class='sql'>item_type</span>тип элемента: assignment, quiz, midterm, final, project, participation или lab (ENUM)</li>
            <li><span class='sql'>score</span>полученный балл (DECIMAL)</li>
            <li><span class='sql'>max_score</span>максимально возможный балл, по умолчанию 100.00 (DECIMAL)</li>
            <li><span class='sql'>weight</span>доля итоговой оценки, например, 0.1500 означает 15% (DECIMAL)</li>
            <li><span class='sql'>graded_at</span>дата и время фиксации оценки (DATETIME)</li>
            <li><span class='sql'>grader_id</span>преподаватель, выставивший оценку (ВК, допускает NULL)</li>
            <li><span class='sql'>feedback</span>текст обратной связи от проверяющего (TEXT, допускает NULL)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">event_id</th>
                        <th scope="col">enrollment_id</th>
                        <th scope="col">item_name</th>
                        <th scope="col">item_type</th>
                        <th scope="col">score</th>
                        <th scope="col">max_score</th>
                        <th scope="col">weight</th>
                        <th scope="col">graded_at</th>
                        <th scope="col">grader_id</th>
                        <th scope="col">feedback</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>Midterm Exam</td>
                        <td>midterm</td>
                        <td>87.00</td>
                        <td>100.00</td>
                        <td>0.3000</td>
                        <td>2024-10-18 14:22:00</td>
                        <td>1</td>
                        <td>Хороший анализ, повторите раздел 3.</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (event_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)</li>
            <li>FOREIGN KEY (grader_id) REFERENCES faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>audit_log</span> - история изменений, генерируемая триггерами (~60 000 строк).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>уникальный идентификатор записи (ПК, BIGINT)</li>
            <li><span class='sql'>table_name</span>название изменённой таблицы</li>
            <li><span class='sql'>record_id</span>первичный ключ изменённой записи (BIGINT)</li>
            <li><span class='sql'>action</span>тип изменения: INSERT, UPDATE или DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>дата и время изменения (TIMESTAMP)</li>
            <li><span class='sql'>changed_by</span>пользователь базы данных или контекст приложения (допускает NULL)</li>
            <li><span class='sql'>old_values</span>предыдущие значения столбцов в формате JSON (null для INSERT)</li>
            <li><span class='sql'>new_values</span>новые значения столбцов в формате JSON (null для DELETE)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">log_id</th>
                        <th scope="col">table_name</th>
                        <th scope="col">record_id</th>
                        <th scope="col">action</th>
                        <th scope="col">changed_at</th>
                        <th scope="col">changed_by</th>
                        <th scope="col">old_values</th>
                        <th scope="col">new_values</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>enrollments</td>
                        <td>1</td>
                        <td>UPDATE</td>
                        <td>2024-12-21 09:05:33</td>
                        <td>app_user</td>
                        <td>{ldelim}"status":"enrolled","final_score":null{rdelim}</td>
                        <td>{ldelim}"status":"completed","final_score":93.50{rdelim}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (log_id)</li>
        </ul>
    </div>
    <h3>Представления</h3>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>v_student_gpa</span> - взвешенный средний балл студента по семестрам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>идентификатор студента</li>
            <li><span class='sql'>student_number</span>уникальный номер студенческого билета</li>
            <li><span class='sql'>first_name</span>имя студента</li>
            <li><span class='sql'>last_name</span>фамилия студента</li>
            <li><span class='sql'>semester_id</span>идентификатор семестра</li>
            <li><span class='sql'>semester_name</span>название семестра</li>
            <li><span class='sql'>semester_gpa</span>взвешенный средний балл за семестр</li>
            <li><span class='sql'>credits_earned</span>кредитные часы, заработанные в семестре</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">student_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">semester_gpa</th>
                        <th scope="col">credits_earned</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>1</td>
                        <td>Fall 2024</td>
                        <td>3.72</td>
                        <td>15</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>v_section_roster</span> - список зачисленных студентов с контактными данными по секции.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>идентификатор секции</li>
            <li><span class='sql'>course_code</span>код курса</li>
            <li><span class='sql'>course_title</span>название курса</li>
            <li><span class='sql'>semester_name</span>название семестра</li>
            <li><span class='sql'>student_id</span>идентификатор студента</li>
            <li><span class='sql'>student_number</span>уникальный номер студенческого билета</li>
            <li><span class='sql'>first_name</span>имя студента</li>
            <li><span class='sql'>last_name</span>фамилия студента</li>
            <li><span class='sql'>email</span>адрес электронной почты студента</li>
            <li><span class='sql'>status</span>статус зачисления</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">section_id</th>
                        <th scope="col">course_code</th>
                        <th scope="col">course_title</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">student_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>Fall 2024</td>
                        <td>1</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>j.miller@student.edu</td>
                        <td>enrolled</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>v_course_pass_rate</span> - исторический процент успеваемости и средний балл по курсам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>идентификатор курса</li>
            <li><span class='sql'>code</span>код курса</li>
            <li><span class='sql'>title</span>название курса</li>
            <li><span class='sql'>semester_id</span>идентификатор семестра</li>
            <li><span class='sql'>semester_name</span>название семестра</li>
            <li><span class='sql'>total_enrolled</span>общее количество записавшихся студентов</li>
            <li><span class='sql'>passed</span>количество студентов, успешно сдавших курс</li>
            <li><span class='sql'>pass_rate</span>процент успеваемости</li>
            <li><span class='sql'>avg_score</span>средний итоговый балл</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">code</th>
                        <th scope="col">title</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">total_enrolled</th>
                        <th scope="col">passed</th>
                        <th scope="col">pass_rate</th>
                        <th scope="col">avg_score</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>1</td>
                        <td>Fall 2024</td>
                        <td>28</td>
                        <td>25</td>
                        <td>89.29</td>
                        <td>81.40</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>v_faculty_workload</span> - количество проведённых секций и процент заполненности по преподавателям за семестр.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>идентификатор преподавателя</li>
            <li><span class='sql'>first_name</span>имя преподавателя</li>
            <li><span class='sql'>last_name</span>фамилия преподавателя</li>
            <li><span class='sql'>semester_id</span>идентификатор семестра</li>
            <li><span class='sql'>semester_name</span>название семестра</li>
            <li><span class='sql'>sections_taught</span>количество проведённых секций</li>
            <li><span class='sql'>total_capacity</span>суммарная вместимость по всем секциям</li>
            <li><span class='sql'>total_enrolled</span>общее количество записавшихся студентов</li>
            <li><span class='sql'>fill_rate</span>процент заполненности</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">faculty_id</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">sections_taught</th>
                        <th scope="col">total_capacity</th>
                        <th scope="col">total_enrolled</th>
                        <th scope="col">fill_rate</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Alice</td>
                        <td>Carter</td>
                        <td>1</td>
                        <td>Fall 2024</td>
                        <td>3</td>
                        <td>90</td>
                        <td>82</td>
                        <td>91.11</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>v_top_scholars</span> - студенты, ранжированные по общей сумме полученных стипендий.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>rank_position</span>место в рейтинге по суммарной сумме стипендий</li>
            <li><span class='sql'>student_id</span>идентификатор студента</li>
            <li><span class='sql'>student_number</span>уникальный номер студенческого билета</li>
            <li><span class='sql'>first_name</span>имя студента</li>
            <li><span class='sql'>last_name</span>фамилия студента</li>
            <li><span class='sql'>total_scholarships</span>количество назначенных стипендий</li>
            <li><span class='sql'>total_amount</span>суммарная сумма по полю amount_awarded по всем стипендиям</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">rank_position</th>
                        <th scope="col">student_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">total_scholarships</th>
                        <th scope="col">total_amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>2</td>
                        <td>8500.00</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>v_publication_stats</span> - количество публикаций и цитирований по кафедрам и годам.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>идентификатор кафедры</li>
            <li><span class='sql'>department_name</span>название кафедры</li>
            <li><span class='sql'>pub_year</span>год публикации</li>
            <li><span class='sql'>paper_count</span>количество опубликованных статей</li>
            <li><span class='sql'>total_citations</span>суммарное количество цитирований по всем статьям</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">department_id</th>
                        <th scope="col">department_name</th>
                        <th scope="col">pub_year</th>
                        <th scope="col">paper_count</th>
                        <th scope="col">total_citations</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>3</td>
                        <td>Computer Science</td>
                        <td>2024</td>
                        <td>12</td>
                        <td>87</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки имени представления в редактор">
        <span><span class='sql'>v_prerequisite_tree</span> - непосредственные предварительные требования для каждого курса.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>идентификатор курса</li>
            <li><span class='sql'>course_code</span>код курса</li>
            <li><span class='sql'>course_title</span>название курса</li>
            <li><span class='sql'>prerequisite_id</span>идентификатор курса-prerequisite</li>
            <li><span class='sql'>prerequisite_code</span>код курса-prerequisite</li>
            <li><span class='sql'>prerequisite_title</span>название курса-prerequisite</li>
            <li><span class='sql'>is_mandatory</span>является ли предварительный курс обязательным или рекомендуемым</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">course_code</th>
                        <th scope="col">course_title</th>
                        <th scope="col">prerequisite_id</th>
                        <th scope="col">prerequisite_code</th>
                        <th scope="col">prerequisite_title</th>
                        <th scope="col">is_mandatory</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5</td>
                        <td>CS401</td>
                        <td>Advanced Database Systems</td>
                        <td>1</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
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
