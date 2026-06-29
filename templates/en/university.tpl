<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>University Database: table structure and schema overview</h2>
    <p>University DB is a modern <strong>MariaDB 11.7+</strong> sample database for learning SQL — designed as a feature-rich replacement for the classic Sakila database.</p>
    <p>It covers all significant MariaDB datatypes including <span class='sql'>VECTOR(1536)</span>, <span class='sql'>JSON</span>, <span class='sql'>SET</span>, and <span class='sql'>FULLTEXT</span> indexes, is fully normalized to 3NF, and ships with enough data for both beginner exercises and complex analytical queries.</p>
    <p>The University database contains 16 main tables describing a university's academic structure — departments, faculty, students, courses, enrollments, research projects, and more.</p>
    <p>
        <a href="/{$Lang}/erd/University" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Open University database ER diagram in a new window">
            <img src="/images/erd_small_light.svg" alt="ER diagram of the University database showing table relationships" style="width: 90%;" loading="lazy" decoding="async">
            ER diagram of the University database
        </a>
    </p>
    <h3>The list of tables</h3>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>semesters</span> - academic semester table.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>semester_id</span>unique record identifier (PK, TINYINT)</li>
            <li><span class='sql'>term</span>term type: Fall, Spring, or Summer (ENUM)</li>
            <li><span class='sql'>academic_year</span>academic year (YEAR)</li>
            <li><span class='sql'>name</span>semester name (e.g. 'Fall 2024')</li>
            <li><span class='sql'>start_date</span>first day of the semester</li>
            <li><span class='sql'>end_date</span>last day of the semester</li>
            <li><span class='sql'>enroll_deadline</span>last date for student enrollment</li>
            <li><span class='sql'>is_active</span>whether the semester is currently active (BOOLEAN)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>rooms</span> - campus classrooms and labs.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>unique record identifier (PK, SMALLINT)</li>
            <li><span class='sql'>building</span>building name</li>
            <li><span class='sql'>room_number</span>room number or label</li>
            <li><span class='sql'>capacity</span>maximum number of seats (SMALLINT)</li>
            <li><span class='sql'>room_type</span>room type: lecture, seminar, lab, computer_lab, or online (ENUM)</li>
            <li><span class='sql'>has_projector</span>whether the room has a projector (BOOLEAN)</li>
            <li><span class='sql'>has_video</span>whether the room has video conferencing equipment (BOOLEAN)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>scholarships</span> - available scholarships and grants.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>unique record identifier (PK, SMALLINT)</li>
            <li><span class='sql'>name</span>scholarship name</li>
            <li><span class='sql'>amount</span>award amount (DECIMAL)</li>
            <li><span class='sql'>frequency</span>award frequency: one-time, annual, or per-semester (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>eligibility criteria as JSON — e.g. <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
            <li><span class='sql'>is_active</span>whether the scholarship is currently offered (BOOLEAN)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>departments</span> - three-level department hierarchy (Faculty → Department → Sub-department).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>unique record identifier (PK, TINYINT)</li>
            <li><span class='sql'>parent_id</span>parent department identifier — self-referencing FK (nullable)</li>
            <li><span class='sql'>code</span>short department code (CHAR)</li>
            <li><span class='sql'>name</span>department name</li>
            <li><span class='sql'>level</span>hierarchy level: 1 = Faculty, 2 = Department, 3 = Sub-department (TINYINT)</li>
            <li><span class='sql'>head_faculty_id</span>identifier of the department head (FK, nullable)</li>
            <li><span class='sql'>established</span>year the department was established (YEAR, nullable)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>faculty</span> - academic and administrative staff.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>unique record identifier (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>department identifier (FK)</li>
            <li><span class='sql'>first_name</span>faculty member's first name</li>
            <li><span class='sql'>last_name</span>faculty member's last name</li>
            <li><span class='sql'>email</span>institutional email address</li>
            <li><span class='sql'>phone</span>office phone number (nullable)</li>
            <li><span class='sql'>rank</span>academic rank: Instructor, Assistant Professor, Associate Professor, Professor, or Emeritus (ENUM)</li>
            <li><span class='sql'>hire_date</span>date of hire</li>
            <li><span class='sql'>office</span>office room number or location (nullable)</li>
            <li><span class='sql'>office_hours</span>weekly office hours as JSON array — e.g. <code>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</code></li>
            <li><span class='sql'>bio</span>biographical text (TEXT, nullable)</li>
            <li><span class='sql'>is_active</span>whether the faculty member is currently active (BOOLEAN)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>students</span> - registered students.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>unique record identifier (PK, INT)</li>
            <li><span class='sql'>department_id</span>home department identifier (FK)</li>
            <li><span class='sql'>student_number</span>unique student ID number (CHAR, e.g. 'S000123')</li>
            <li><span class='sql'>first_name</span>student's first name</li>
            <li><span class='sql'>last_name</span>student's last name</li>
            <li><span class='sql'>email</span>student's email address</li>
            <li><span class='sql'>date_of_birth</span>student's date of birth</li>
            <li><span class='sql'>gender</span>gender: M, F, NB, Other, or Prefer not to say (ENUM, nullable)</li>
            <li><span class='sql'>enrollment_date</span>date the student was first enrolled</li>
            <li><span class='sql'>expected_grad</span>expected graduation year (YEAR, nullable)</li>
            <li><span class='sql'>status</span>enrollment status: active, inactive, graduated, suspended, or withdrawn (ENUM)</li>
            <li><span class='sql'>gpa</span>cumulative GPA 0.000–4.000, maintained by trigger (DECIMAL, nullable)</li>
            <li><span class='sql'>contacts</span>emergency contact and address as JSON — e.g. <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>courses</span> - course catalog with full-text and vector search support.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>unique record identifier (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>owning department identifier (FK)</li>
            <li><span class='sql'>code</span>course code, e.g. 'CS101' (CHAR)</li>
            <li><span class='sql'>title</span>course title</li>
            <li><span class='sql'>credits</span>number of credit hours (TINYINT)</li>
            <li><span class='sql'>level</span>academic level: undergraduate, graduate, or doctoral (ENUM)</li>
            <li><span class='sql'>description</span>detailed course description (TEXT, FULLTEXT index with title)</li>
            <li><span class='sql'>is_active</span>whether the course is currently offered (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>1536-dimension semantic embedding for vector similarity search (VECTOR(1536), nullable)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>course_prerequisites</span> - course prerequisite relations (self-referencing many-to-many).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identifier of the course (FK)</li>
            <li><span class='sql'>prerequisite_id</span>identifier of the required prerequisite course (FK)</li>
            <li><span class='sql'>is_mandatory</span>whether the prerequisite is mandatory or recommended (BOOLEAN)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>sections</span> - one offering of a course in a given semester.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>unique record identifier (PK, INT)</li>
            <li><span class='sql'>course_id</span>course identifier (FK)</li>
            <li><span class='sql'>semester_id</span>semester identifier (FK)</li>
            <li><span class='sql'>faculty_id</span>instructor identifier (FK)</li>
            <li><span class='sql'>room_id</span>assigned room identifier (FK, nullable — NULL for fully online)</li>
            <li><span class='sql'>section_number</span>section number within the course/semester (TINYINT)</li>
            <li><span class='sql'>delivery</span>delivery mode: in-person, online, or hybrid (ENUM)</li>
            <li><span class='sql'>max_capacity</span>maximum enrollment (SMALLINT)</li>
            <li><span class='sql'>status</span>section status: open, closed, cancelled, or completed (ENUM)</li>
            <li><span class='sql'>schedule</span>weekly meeting times as JSON — e.g. <code>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim}]</code></li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>enrollments</span> - student enrollments in course sections.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>unique record identifier (PK, INT)</li>
            <li><span class='sql'>student_id</span>student identifier (FK)</li>
            <li><span class='sql'>section_id</span>section identifier (FK)</li>
            <li><span class='sql'>enrolled_at</span>date and time of enrollment (TIMESTAMP)</li>
            <li><span class='sql'>status</span>enrollment status: enrolled, dropped, completed, failed, or incomplete (ENUM)</li>
            <li><span class='sql'>final_grade</span>final letter grade, e.g. 'A', 'B+' (CHAR, nullable)</li>
            <li><span class='sql'>final_score</span>final numeric score 0.00–100.00 (DECIMAL, nullable)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>student_scholarships</span> - scholarship awards granted to students.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>award_id</span>unique record identifier (PK, INT)</li>
            <li><span class='sql'>student_id</span>student identifier (FK)</li>
            <li><span class='sql'>scholarship_id</span>scholarship identifier (FK)</li>
            <li><span class='sql'>awarded_date</span>date the scholarship was awarded</li>
            <li><span class='sql'>expires_date</span>date the award expires (nullable)</li>
            <li><span class='sql'>amount_awarded</span>actual awarded amount (DECIMAL)</li>
            <li><span class='sql'>notes</span>additional notes about the award (TEXT, nullable)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>research_projects</span> - faculty-led research initiatives.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>unique record identifier (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>department identifier (FK)</li>
            <li><span class='sql'>lead_faculty_id</span>principal investigator (FK)</li>
            <li><span class='sql'>title</span>project title</li>
            <li><span class='sql'>abstract</span>project description (TEXT, nullable)</li>
            <li><span class='sql'>start_date</span>project start date</li>
            <li><span class='sql'>end_date</span>project end date (nullable)</li>
            <li><span class='sql'>status</span>project status: proposed, active, completed, or cancelled (ENUM)</li>
            <li><span class='sql'>funding</span>funding sources as JSON — e.g. <code>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2024-001"{rdelim}]</code></li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>publications</span> - research papers with full-text search support.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>unique record identifier (PK, INT)</li>
            <li><span class='sql'>project_id</span>associated research project (FK, nullable)</li>
            <li><span class='sql'>title</span>publication title</li>
            <li><span class='sql'>abstract</span>publication abstract (MEDIUMTEXT, FULLTEXT index with title)</li>
            <li><span class='sql'>pub_year</span>year of publication (YEAR)</li>
            <li><span class='sql'>venue</span>journal name or conference (nullable)</li>
            <li><span class='sql'>doi</span>Digital Object Identifier (nullable)</li>
            <li><span class='sql' style="min-width: 9rem;">keywords</span>keyword tags — one or more of: AI, ML, Data Science, Networking, Security, Algorithms, Databases, HCI, Theory, Bioinformatics, Systems, Mathematics, Physics, Chemistry, Biology (SET)</li>
            <li><span class='sql'>citation_count</span>number of citations received (INT)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>project_members</span> - faculty and student participation in research projects.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>member_id</span>unique record identifier (PK, INT)</li>
            <li><span class='sql'>project_id</span>research project identifier (FK)</li>
            <li><span class='sql'>faculty_id</span>faculty member identifier (FK, nullable)</li>
            <li><span class='sql'>student_id</span>student identifier (FK, nullable)</li>
            <li><span class='sql'>role</span>member role: Principal Investigator, Co-Investigator, Research Assistant, Graduate Student, or Undergraduate Student (ENUM)</li>
            <li><span class='sql'>joined_date</span>date the member joined the project</li>
            <li><span class='sql'>left_date</span>date the member left the project (nullable)</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>grade_events</span> - individual scored items per enrollment (~120 000 rows).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>unique record identifier (PK, BIGINT)</li>
            <li><span class='sql'>enrollment_id</span>enrollment identifier (FK)</li>
            <li><span class='sql'>item_name</span>name of the graded item, e.g. 'Assignment 1', 'Midterm Exam'</li>
            <li><span class='sql'>item_type</span>item type: assignment, quiz, midterm, final, project, participation, or lab (ENUM)</li>
            <li><span class='sql'>score</span>achieved points (DECIMAL)</li>
            <li><span class='sql'>max_score</span>maximum possible points, default 100.00 (DECIMAL)</li>
            <li><span class='sql'>weight</span>fraction of the final grade, e.g. 0.1500 for 15% (DECIMAL)</li>
            <li><span class='sql'>graded_at</span>date and time the grade was recorded (DATETIME)</li>
            <li><span class='sql'>grader_id</span>faculty member who graded the item (FK, nullable)</li>
            <li><span class='sql'>feedback</span>grader's feedback text (TEXT, nullable)</li>
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
                        <td>Good analysis, review section 3.</td>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>audit_log</span> - trigger-generated row-level change history (~60 000 rows).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>unique record identifier (PK, BIGINT)</li>
            <li><span class='sql'>table_name</span>name of the modified table</li>
            <li><span class='sql'>record_id</span>primary key of the modified record (BIGINT)</li>
            <li><span class='sql'>action</span>type of change: INSERT, UPDATE, or DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>date and time of the change (TIMESTAMP)</li>
            <li><span class='sql'>changed_by</span>database user or application context (nullable)</li>
            <li><span class='sql'>old_values</span>previous column values as JSON (null for INSERT)</li>
            <li><span class='sql'>new_values</span>new column values as JSON (null for DELETE)</li>
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
    <h3>Views</h3>
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>v_student_gpa</span> - weighted GPA per student per semester.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>student identifier</li>
            <li><span class='sql'>student_number</span>unique student ID number</li>
            <li><span class='sql'>first_name</span>student's first name</li>
            <li><span class='sql'>last_name</span>student's last name</li>
            <li><span class='sql'>semester_id</span>semester identifier</li>
            <li><span class='sql'>semester_name</span>semester name</li>
            <li><span class='sql'>semester_gpa</span>weighted GPA for the semester</li>
            <li><span class='sql'>credits_earned</span>credit hours earned in the semester</li>
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
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>v_section_roster</span> - enrolled students with contact info per section.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>section identifier</li>
            <li><span class='sql'>course_code</span>course code</li>
            <li><span class='sql'>course_title</span>course title</li>
            <li><span class='sql'>semester_name</span>semester name</li>
            <li><span class='sql'>student_id</span>student identifier</li>
            <li><span class='sql'>student_number</span>unique student ID number</li>
            <li><span class='sql'>first_name</span>student's first name</li>
            <li><span class='sql'>last_name</span>student's last name</li>
            <li><span class='sql'>email</span>student's email address</li>
            <li><span class='sql'>status</span>enrollment status</li>
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
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>v_course_pass_rate</span> - historical pass/fail percentage and average score per course.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>course identifier</li>
            <li><span class='sql'>code</span>course code</li>
            <li><span class='sql'>title</span>course title</li>
            <li><span class='sql'>semester_id</span>semester identifier</li>
            <li><span class='sql'>semester_name</span>semester name</li>
            <li><span class='sql'>total_enrolled</span>total number of students enrolled</li>
            <li><span class='sql'>passed</span>number of students who passed</li>
            <li><span class='sql'>pass_rate</span>pass rate as a percentage</li>
            <li><span class='sql'>avg_score</span>average final score</li>
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
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>v_faculty_workload</span> - sections taught and fill rate per faculty member per semester.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>faculty member identifier</li>
            <li><span class='sql'>first_name</span>faculty member's first name</li>
            <li><span class='sql'>last_name</span>faculty member's last name</li>
            <li><span class='sql'>semester_id</span>semester identifier</li>
            <li><span class='sql'>semester_name</span>semester name</li>
            <li><span class='sql'>sections_taught</span>number of sections taught</li>
            <li><span class='sql'>total_capacity</span>total seat capacity across all sections</li>
            <li><span class='sql'>total_enrolled</span>total number of enrolled students</li>
            <li><span class='sql'>fill_rate</span>fill rate as a percentage</li>
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
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>v_top_scholars</span> - students ranked by total scholarship funding received.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>rank_position</span>rank by total scholarship amount</li>
            <li><span class='sql'>student_id</span>student identifier</li>
            <li><span class='sql'>student_number</span>unique student ID number</li>
            <li><span class='sql'>first_name</span>student's first name</li>
            <li><span class='sql'>last_name</span>student's last name</li>
            <li><span class='sql'>total_scholarships</span>number of scholarship awards</li>
            <li><span class='sql'>total_amount</span>total amount_awarded across all scholarships</li>
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
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>v_publication_stats</span> - paper count and citations per department per year.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>department identifier</li>
            <li><span class='sql'>department_name</span>department name</li>
            <li><span class='sql'>pub_year</span>year of publication</li>
            <li><span class='sql'>paper_count</span>number of papers published</li>
            <li><span class='sql'>total_citations</span>total citation count across all papers</li>
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
    <div class="accordion" title="Click to expand, double-click to paste view name into the editor">
        <span><span class='sql'>v_prerequisite_tree</span> - direct prerequisites for every course.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>course identifier</li>
            <li><span class='sql'>course_code</span>course code</li>
            <li><span class='sql'>course_title</span>course title</li>
            <li><span class='sql'>prerequisite_id</span>prerequisite course identifier</li>
            <li><span class='sql'>prerequisite_code</span>prerequisite course code</li>
            <li><span class='sql'>prerequisite_title</span>prerequisite course title</li>
            <li><span class='sql'>is_mandatory</span>whether the prerequisite is mandatory or recommended</li>
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
