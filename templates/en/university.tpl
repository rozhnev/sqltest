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
            <li><span class='sql'>semester_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>name</span>semester name (e.g. 'Fall 2024')</li>
            <li><span class='sql'>academic_year</span>academic year (YEAR type)</li>
            <li><span class='sql'>term</span>term type: Fall, Spring, or Summer (ENUM)</li>
            <li><span class='sql'>start_date</span>first day of the semester</li>
            <li><span class='sql'>end_date</span>last day of the semester</li>
            <li><span class='sql'>is_active</span>whether the semester is currently active (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">semester_id</th>
                        <th scope="col">name</th>
                        <th scope="col">academic_year</th>
                        <th scope="col">term</th>
                        <th scope="col">start_date</th>
                        <th scope="col">end_date</th>
                        <th scope="col">is_active</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Fall 2024</td>
                        <td>2024</td>
                        <td>Fall</td>
                        <td>2024-09-02</td>
                        <td>2024-12-20</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (semester_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>rooms</span> - campus classrooms and labs.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>building</span>building name</li>
            <li><span class='sql'>room_number</span>room number or label</li>
            <li><span class='sql'>capacity</span>maximum number of seats (SMALLINT)</li>
            <li><span class='sql'>type</span>room type: Lecture, Lab, Seminar, or Conference (ENUM)</li>
            <li><span class='sql'>has_projector</span>whether the room has a projector (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">room_id</th>
                        <th scope="col">building</th>
                        <th scope="col">room_number</th>
                        <th scope="col">capacity</th>
                        <th scope="col">type</th>
                        <th scope="col">has_projector</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Science Hall</td>
                        <td>101</td>
                        <td>120</td>
                        <td>Lecture</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (room_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>scholarships</span> - available scholarships.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>name</span>scholarship name</li>
            <li><span class='sql'>amount</span>award amount (DECIMAL)</li>
            <li><span class='sql'>type</span>scholarship type: Merit, Need-Based, Athletic, or Research (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>eligibility criteria as JSON — e.g. <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">scholarship_id</th>
                        <th scope="col">name</th>
                        <th scope="col">amount</th>
                        <th scope="col">type</th>
                        <th scope="col">eligibility</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Dean's Excellence Award</td>
                        <td>5000.00</td>
                        <td>Merit</td>
                        <td>{ldelim}"min_gpa": 3.8, "need_based": false, "majors": ["CS","Math"]{rdelim}</td>
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
            <li><span class='sql'>department_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>name</span>department name</li>
            <li><span class='sql'>code</span>short department code</li>
            <li><span class='sql'>parent_id</span>parent department identifier — self-referencing FK (nullable)</li>
            <li><span class='sql'>level</span>hierarchy level: 1 = Faculty, 2 = Department, 3 = Sub-department (TINYINT)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">department_id</th>
                        <th scope="col">name</th>
                        <th scope="col">code</th>
                        <th scope="col">parent_id</th>
                        <th scope="col">level</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Faculty of Engineering</td>
                        <td>ENG</td>
                        <td>[null]</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (department_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (parent_id) REFERENCES departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>faculty</span> - university faculty members.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>first_name</span>faculty member's first name</li>
            <li><span class='sql'>last_name</span>faculty member's last name</li>
            <li><span class='sql'>email</span>institutional email address</li>
            <li><span class='sql'>department_id</span>department identifier (FK)</li>
            <li><span class='sql'>title</span>academic rank: Professor, Associate Professor, Assistant Professor, Lecturer, or Instructor (ENUM)</li>
            <li><span class='sql'>hire_date</span>date of hire</li>
            <li><span class='sql'>office_hours</span>weekly office hours as JSON array — e.g. <code>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</code></li>
            <li><span class='sql'>bio</span>biographical text (TEXT)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">faculty_id</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">department_id</th>
                        <th scope="col">title</th>
                        <th scope="col">hire_date</th>
                        <th scope="col">office_hours</th>
                        <th scope="col">bio</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Alice</td>
                        <td>Carter</td>
                        <td>a.carter@university.edu</td>
                        <td>3</td>
                        <td>Professor</td>
                        <td>2010-08-15</td>
                        <td>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim},{ldelim}"day":"Wed","start":"14:00","end":"16:00"{rdelim}]</td>
                        <td>Expert in distributed systems and cloud computing.</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (faculty_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (department_id) REFERENCES departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>students</span> - enrolled students.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>student_number</span>unique student ID number (CHAR)</li>
            <li><span class='sql'>first_name</span>student's first name</li>
            <li><span class='sql'>last_name</span>student's last name</li>
            <li><span class='sql'>email</span>student's email address</li>
            <li><span class='sql'>date_of_birth</span>student's date of birth</li>
            <li><span class='sql'>enrollment_date</span>date the student was first enrolled</li>
            <li><span class='sql'>status</span>enrollment status: Active, Inactive, Graduated, or Suspended (ENUM)</li>
            <li><span class='sql'>gpa</span>current cumulative GPA (DECIMAL)</li>
            <li><span class='sql'>contacts</span>emergency contact and address as JSON</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">student_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">date_of_birth</th>
                        <th scope="col">enrollment_date</th>
                        <th scope="col">status</th>
                        <th scope="col">gpa</th>
                        <th scope="col">contacts</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>S2021001</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>j.miller@student.edu</td>
                        <td>2002-04-23</td>
                        <td>2021-09-01</td>
                        <td>Active</td>
                        <td>3.72</td>
                        <td>[{ldelim}"emergency":{ldelim}"name":"Susan Miller","phone":"+15551234567"{rdelim}{rdelim}]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (student_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>courses</span> - course catalog with full-text and vector search support.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>code</span>course code (e.g. CS301)</li>
            <li><span class='sql'>title</span>course title</li>
            <li><span class='sql'>description</span>detailed course description (TEXT, FULLTEXT index)</li>
            <li><span class='sql'>credits</span>number of credit hours (TINYINT)</li>
            <li><span class='sql'>department_id</span>department identifier (FK)</li>
            <li><span class='sql'>is_active</span>whether the course is currently offered (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>1536-dimension semantic embedding for vector similarity search (VECTOR(1536))</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">code</th>
                        <th scope="col">title</th>
                        <th scope="col">description</th>
                        <th scope="col">credits</th>
                        <th scope="col">department_id</th>
                        <th scope="col">is_active</th>
                        <th scope="col">embedding</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>Introduction to relational databases, SQL, and data modeling.</td>
                        <td>3</td>
                        <td>3</td>
                        <td>1</td>
                        <td>[0.023, -0.011, ...]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (course_id)</li>
            <li>FULLTEXT (description)</li>
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
            <li><span class='sql'>prerequisite_id</span>identifier of the prerequisite course (FK)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">prerequisite_id</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5</td>
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
        <span><span class='sql'>sections</span> - course sections (a specific offering of a course in a semester).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>course_id</span>course identifier (FK)</li>
            <li><span class='sql'>semester_id</span>semester identifier (FK)</li>
            <li><span class='sql'>faculty_id</span>instructor identifier (FK)</li>
            <li><span class='sql'>room_id</span>assigned room identifier (FK)</li>
            <li><span class='sql'>capacity</span>maximum enrollment (SMALLINT)</li>
            <li><span class='sql'>enrolled_count</span>current number of enrolled students (SMALLINT)</li>
            <li><span class='sql'>status</span>section status: Open, Closed, or Cancelled (ENUM)</li>
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
                        <th scope="col">capacity</th>
                        <th scope="col">enrolled_count</th>
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
                        <td>30</td>
                        <td>28</td>
                        <td>Open</td>
                        <td>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim},{ldelim}"day":"Wed","start":"09:00","end":"10:30"{rdelim}]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (section_id)</li>
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
            <li><span class='sql'>enrollment_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>student_id</span>student identifier (FK)</li>
            <li><span class='sql'>section_id</span>section identifier (FK)</li>
            <li><span class='sql'>enrolled_at</span>date and time of enrollment (TIMESTAMP)</li>
            <li><span class='sql'>status</span>enrollment status: Enrolled, Dropped, Completed, or Withdrawn (ENUM)</li>
            <li><span class='sql'>grade</span>final letter grade (CHAR)</li>
            <li><span class='sql'>final_score</span>computed numeric score (DECIMAL)</li>
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
                        <th scope="col">grade</th>
                        <th scope="col">final_score</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>2024-08-25 10:34:02</td>
                        <td>Completed</td>
                        <td>A</td>
                        <td>93.50</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (enrollment_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (student_id) REFERENCES students(student_id)</li>
            <li>FOREIGN KEY (section_id) REFERENCES sections(section_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>student_scholarships</span> - scholarships awarded to students.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>student identifier (FK)</li>
            <li><span class='sql'>scholarship_id</span>scholarship identifier (FK)</li>
            <li><span class='sql'>awarded_date</span>date the scholarship was awarded</li>
            <li><span class='sql'>amount</span>actual awarded amount, may differ from the base scholarship amount (DECIMAL)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">student_id</th>
                        <th scope="col">scholarship_id</th>
                        <th scope="col">awarded_date</th>
                        <th scope="col">amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>2024-09-01</td>
                        <td>5000.00</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (student_id, scholarship_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (student_id) REFERENCES students(student_id)</li>
            <li>FOREIGN KEY (scholarship_id) REFERENCES scholarships(scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>research_projects</span> - department research projects.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>title</span>project title</li>
            <li><span class='sql'>description</span>project description (TEXT)</li>
            <li><span class='sql'>department_id</span>department identifier (FK)</li>
            <li><span class='sql'>status</span>project status: Proposed, Active, Completed, or Cancelled (ENUM)</li>
            <li><span class='sql'>start_date</span>project start date</li>
            <li><span class='sql'>end_date</span>project end date (nullable)</li>
            <li><span class='sql'>funding</span>funding sources as JSON — e.g. <code>[{ldelim}"source":"NSF","amount":150000{rdelim}]</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">project_id</th>
                        <th scope="col">title</th>
                        <th scope="col">description</th>
                        <th scope="col">department_id</th>
                        <th scope="col">status</th>
                        <th scope="col">start_date</th>
                        <th scope="col">end_date</th>
                        <th scope="col">funding</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>AI-Assisted Drug Discovery</td>
                        <td>Using machine learning models to identify candidate molecules.</td>
                        <td>5</td>
                        <td>Active</td>
                        <td>2023-01-15</td>
                        <td>[null]</td>
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
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>publications</span> - research publications with full-text search support.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>title</span>publication title</li>
            <li><span class='sql'>abstract</span>publication abstract (MEDIUMTEXT, FULLTEXT index)</li>
            <li><span class='sql'>journal</span>journal or conference name</li>
            <li><span class='sql'>publication_year</span>year of publication (YEAR)</li>
            <li><span class='sql'>doi</span>Digital Object Identifier</li>
            <li><span class='sql' style="min-width: 11rem;">contribution_type</span>type of contribution — one or more of: Theoretical, Experimental, Review, Applied (SET)</li>
            <li><span class='sql'>project_id</span>associated research project identifier (FK, nullable)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">publication_id</th>
                        <th scope="col">title</th>
                        <th scope="col">abstract</th>
                        <th scope="col">journal</th>
                        <th scope="col">publication_year</th>
                        <th scope="col">doi</th>
                        <th scope="col">contribution_type</th>
                        <th scope="col">project_id</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Deep Learning for Molecular Screening</td>
                        <td>We present a transformer-based architecture for high-throughput virtual screening...</td>
                        <td>Nature Machine Intelligence</td>
                        <td>2024</td>
                        <td>10.1038/s42256-024-00001-1</td>
                        <td>Theoretical,Experimental</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (publication_id)</li>
            <li>FULLTEXT (abstract)</li>
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
            <li><span class='sql'>project_id</span>research project identifier (FK)</li>
            <li><span class='sql'>faculty_id</span>faculty member identifier (FK, nullable)</li>
            <li><span class='sql'>student_id</span>student identifier (FK, nullable)</li>
            <li><span class='sql'>role</span>member role: PI, Co-PI, Researcher, or Assistant (ENUM)</li>
            <li><span class='sql'>join_date</span>date the member joined the project</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">project_id</th>
                        <th scope="col">faculty_id</th>
                        <th scope="col">student_id</th>
                        <th scope="col">role</th>
                        <th scope="col">join_date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>[null]</td>
                        <td>PI</td>
                        <td>2023-01-15</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (project_id, faculty_id, student_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (project_id) REFERENCES research_projects(project_id)</li>
            <li>FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)</li>
            <li>FOREIGN KEY (student_id) REFERENCES students(student_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>grade_events</span> - individual graded items per enrollment (~120 000 rows).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>unique record identifier (BIGINT PK)</li>
            <li><span class='sql'>enrollment_id</span>enrollment identifier (FK)</li>
            <li><span class='sql'>item_name</span>name of the graded item (e.g. 'Midterm Exam')</li>
            <li><span class='sql'>item_type</span>item type: Homework, Quiz, Midterm, Final, Project, or Lab (ENUM)</li>
            <li><span class='sql'>score</span>score received (DECIMAL)</li>
            <li><span class='sql'>max_score</span>maximum possible score (DECIMAL)</li>
            <li><span class='sql'>weight</span>percentage weight toward final grade (DECIMAL)</li>
            <li><span class='sql'>grader_id</span>faculty member who graded the item (FK)</li>
            <li><span class='sql'>created_at</span>date and time the grade was recorded (DATETIME)</li>
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
                        <th scope="col">grader_id</th>
                        <th scope="col">created_at</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>Midterm Exam</td>
                        <td>Midterm</td>
                        <td>87.00</td>
                        <td>100.00</td>
                        <td>30.00</td>
                        <td>1</td>
                        <td>2024-10-18 14:22:00</td>
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
        <span><span class='sql'>audit_log</span> - trigger-generated change history (~60 000 rows).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>unique record identifier (BIGINT PK)</li>
            <li><span class='sql'>table_name</span>name of the modified table</li>
            <li><span class='sql'>record_id</span>primary key of the modified record (BIGINT)</li>
            <li><span class='sql'>action</span>type of change: INSERT, UPDATE, or DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>date and time of the change (TIMESTAMP)</li>
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
                        <td>[{ldelim}"status":"Enrolled","final_score":null{rdelim}]</td>
                        <td>[{ldelim}"status":"Completed","final_score":93.50{rdelim}]</td>
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
                        <td>S2021001</td>
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
                        <td>S2021001</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>j.miller@student.edu</td>
                        <td>Enrolled</td>
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
            <li><span class='sql'>total_scholarships</span>number of scholarships awarded</li>
            <li><span class='sql'>total_amount</span>total scholarship funding received</li>
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
                        <td>S2021001</td>
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
        <span><span class='sql'>v_publication_stats</span> - paper count per department per year.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>department identifier</li>
            <li><span class='sql'>department_name</span>department name</li>
            <li><span class='sql'>publication_year</span>year of publication</li>
            <li><span class='sql'>paper_count</span>number of papers published</li>
            <li><span class='sql'>journal_count</span>number of distinct journals</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">department_id</th>
                        <th scope="col">department_name</th>
                        <th scope="col">publication_year</th>
                        <th scope="col">paper_count</th>
                        <th scope="col">journal_count</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>3</td>
                        <td>Computer Science</td>
                        <td>2024</td>
                        <td>12</td>
                        <td>8</td>
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
