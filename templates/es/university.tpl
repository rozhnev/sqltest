<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    {* The landing page /es/database/university has its own intro: only the table list there *}
    {if ($Action|default:'') != 'database'}
    <h2>Base de Datos Universitaria: estructura de tablas y descripción del esquema</h2>
    <p>La base de datos universitaria es una moderna <strong>MariaDB 11.7+</strong> base de datos de ejemplo para aprender SQL — diseñada como un reemplazo rico en características para la clásica base de datos Sakila.</p>
    <p>Cubre todos los tipos de datos significativos de MariaDB, incluyendo <span class='sql'>VECTOR(1536)</span>, <span class='sql'>JSON</span>, <span class='sql'>SET</span>, y <span class='sql'>FULLTEXT</span> índices, está completamente normalizada a 3NF, y se entrega con suficientes datos tanto para ejercicios de principiantes como para consultas analíticas complejas.</p>
    <p>La base de datos universitaria contiene 16 tablas principales que describen la estructura académica de una universidad — departamentos, facultades, estudiantes, cursos, inscripciones, proyectos de investigación, y más.</p>
    <p>
        <a href="/{$Lang}/erd/University" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir diagrama ER de la base de datos universitaria en una nueva ventana">
            <img src="/images/erd_university_small.svg" alt="Diagrama ER compacto de la base de datos universitaria mostrando relaciones entre tablas" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Diagrama ER de la base de datos universitaria
        </a>
    </p>
    <p><a href="/{$Lang}/database/university">Más sobre la base de datos University: esquema, consultas de ejemplo y todos los ejercicios →</a></p>
    {/if}
    <h3>La lista de tablas</h3>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>semesters</span> - tabla de semestres académicos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>semester_id</span>identificador único del registro (PK, TINYINT)</li>
            <li><span class='sql'>term</span>tipo de término: Otoño, Primavera, o Verano (ENUM)</li>
            <li><span class='sql'>academic_year</span>año académico (YEAR)</li>
            <li><span class='sql'>name</span>nombre del semestre (por ejemplo, 'Otoño 2024')</li>
            <li><span class='sql'>start_date</span>primer día del semestre</li>
            <li><span class='sql'>end_date</span>último día del semestre</li>
            <li><span class='sql'>enroll_deadline</span>última fecha para la inscripción de estudiantes</li>
            <li><span class='sql'>is_active</span>si el semestre está actualmente activo (BOOLEAN)</li>
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
                        <td>Otoño</td>
                        <td>2024</td>
                        <td>Otoño 2024</td>
                        <td>2024-09-02</td>
                        <td>2024-12-20</td>
                        <td>2024-09-13</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (semester_id)</li>
            <li>CLAVE ÚNICA (term, academic_year)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>rooms</span> - aulas y laboratorios del campus.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>identificador único del registro (PK, SMALLINT)</li>
            <li><span class='sql'>building</span>nombre del edificio</li>
            <li><span class='sql'>room_number</span>número o etiqueta de la sala</li>
            <li><span class='sql'>capacity</span>número máximo de asientos (SMALLINT)</li>
            <li><span class='sql'>room_type</span>tipo de sala: conferencia, seminario, laboratorio, laboratorio de computación, o en línea (ENUM)</li>
            <li><span class='sql'>has_projector</span>si la sala tiene proyector (BOOLEAN)</li>
            <li><span class='sql'>has_video</span>si la sala tiene equipo de videoconferencia (BOOLEAN)</li>
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
                        <td>Salón de Ciencias</td>
                        <td>101</td>
                        <td>120</td>
                        <td>conferencia</td>
                        <td>1</td>
                        <td>0</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (room_id)</li>
            <li>CLAVE ÚNICA (building, room_number)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>scholarships</span> - becas y subvenciones disponibles.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>identificador único del registro (PK, SMALLINT)</li>
            <li><span class='sql'>name</span>nombre de la beca</li>
            <li><span class='sql'>amount</span>monto de la beca (DECIMAL)</li>
            <li><span class='sql'>frequency</span>frecuencia de la beca: única, anual, o por semestre (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>criterios de elegibilidad como JSON — por ejemplo, <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
            <li><span class='sql'>is_active</span>si la beca se ofrece actualmente (BOOLEAN)</li>
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
                        <td>Beca de Excelencia del Decano</td>
                        <td>5000.00</td>
                        <td>anual</td>
                        <td>{ldelim}"min_gpa": 3.8, "need_based": false, "majors": ["CS","Math"]{rdelim}</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>departments</span> - jerarquía de departamentos de tres niveles (Facultad → Departamento → Subdepartamento).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identificador único del registro (PK, TINYINT)</li>
            <li><span class='sql'>parent_id</span>identificador del departamento padre — FK autorreferencial (nullable)</li>
            <li><span class='sql'>code</span>código corto del departamento (CHAR)</li>
            <li><span class='sql'>name</span>nombre del departamento</li>
            <li><span class='sql'>level</span>nivel de jerarquía: 1 = Facultad, 2 = Departamento, 3 = Subdepartamento (TINYINT)</li>
            <li><span class='sql'>head_faculty_id</span>identificador del jefe del departamento (FK, nullable)</li>
            <li><span class='sql'>established</span>año en que se estableció el departamento (YEAR, nullable)</li>
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
                        <td>Facultad de Ingeniería</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1965</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (department_id)</li>
            <li>CLAVE ÚNICA (code)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (parent_id) REFERENCIAS departments(department_id)</li>
            <li>CLAVE FORÁNEA (head_faculty_id) REFERENCIAS faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>faculty</span> - personal académico y administrativo.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identificador único del registro (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identificador del departamento (FK)</li>
            <li><span class='sql'>first_name</span>nombre del miembro de la facultad</li>
            <li><span class='sql'>last_name</span>apellido del miembro de la facultad</li>
            <li><span class='sql'>email</span>dirección de correo electrónico institucional</li>
            <li><span class='sql'>phone</span>número de teléfono de la oficina (nullable)</li>
            <li><span class='sql'>rank</span>rango académico: Instructor, Profesor Asistente, Profesor Asociado, Profesor, o Emérito (ENUM)</li>
            <li><span class='sql'>hire_date</span>fecha de contratación</li>
            <li><span class='sql'>office</span>número o ubicación de la oficina (nullable)</li>
            <li><span class='sql'>office_hours</span>horario de oficina semanal como arreglo JSON — por ejemplo, <code>[{ldelim}"day":"Lun","start":"10:00","end":"12:00"{rdelim}]</code></li>
            <li><span class='sql'>bio</span>texto biográfico (TEXT, nullable)</li>
            <li><span class='sql'>is_active</span>si el miembro de la facultad está actualmente activo (BOOLEAN)</li>
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
                        <td>Profesor</td>
                        <td>2010-08-15</td>
                        <td>ENG-204</td>
                        <td>[{ldelim}"day":"Lun","start":"10:00","end":"12:00"{rdelim}]</td>
                        <td>Experto en sistemas distribuidos.</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (faculty_id)</li>
            <li>CLAVE ÚNICA (email)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (department_id) REFERENCIAS departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>students</span> - estudiantes registrados.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identificador único del registro (PK, INT)</li>
            <li><span class='sql'>department_id</span>identificador del departamento principal (FK)</li>
            <li><span class='sql'>student_number</span>número de identificación único del estudiante (CHAR, por ejemplo, 'S000123')</li>
            <li><span class='sql'>first_name</span>nombre del estudiante</li>
            <li><span class='sql'>last_name</span>apellido del estudiante</li>
            <li><span class='sql'>email</span>correo electrónico del estudiante</li>
            <li><span class='sql'>date_of_birth</span>fecha de nacimiento del estudiante</li>
            <li><span class='sql'>gender</span>género: M, F, NB, Other o Prefer not to say (ENUM, admite NULL)</li>
            <li><span class='sql'>enrollment_date</span>fecha de la primera matrícula del estudiante</li>
            <li><span class='sql'>expected_grad</span>año previsto de graduación (YEAR, admite NULL)</li>
            <li><span class='sql'>status</span>estado de matrícula: active, inactive, graduated, suspended o withdrawn (ENUM)</li>
            <li><span class='sql'>gpa</span>GPA acumulado 0.000–4.000, actualizado por un trigger (DECIMAL, admite NULL)</li>
            <li><span class='sql'>contacts</span>contacto de emergencia y dirección en JSON, por ejemplo, <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
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
            <li>CLAVE PRIMARIA, btree (student_id)</li>
            <li>CLAVE ÚNICA (student_number)</li>
            <li>CLAVE ÚNICA (email)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (department_id) REFERENCIAS departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>courses</span> - catálogo de cursos con búsqueda de texto completo y vectorial.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador único del registro (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identificador del departamento responsable (FK)</li>
            <li><span class='sql'>code</span>código del curso, por ejemplo, 'CS101' (CHAR)</li>
            <li><span class='sql'>title</span>título del curso</li>
            <li><span class='sql'>credits</span>número de créditos (TINYINT)</li>
            <li><span class='sql'>level</span>nivel académico: undergraduate, graduate o doctoral (ENUM)</li>
            <li><span class='sql'>description</span>descripción detallada del curso (TEXT, índice FULLTEXT junto con title)</li>
            <li><span class='sql'>is_active</span>si el curso se ofrece actualmente (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>embedding semántico de 1536 dimensiones para búsqueda por similitud vectorial (VECTOR(1536), admite NULL)</li>
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
            <li>CLAVE PRIMARIA, btree (course_id)</li>
            <li>CLAVE ÚNICA (code)</li>
            <li>FULLTEXT (title, description)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (department_id) REFERENCIAS departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>course_prerequisites</span> - requisitos previos de los cursos (relación muchos a muchos consigo misma).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador del curso (FK)</li>
            <li><span class='sql'>prerequisite_id</span>identificador del curso requisito previo (FK)</li>
            <li><span class='sql'>is_mandatory</span>si el requisito previo es obligatorio o recomendado (BOOLEAN)</li>
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
            <li>CLAVE PRIMARIA, btree (course_id, prerequisite_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (course_id) REFERENCIAS courses(course_id)</li>
            <li>CLAVE FORÁNEA (prerequisite_id) REFERENCIAS courses(course_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>sections</span> - una edición de un curso en un semestre concreto.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identificador único del registro (PK, INT)</li>
            <li><span class='sql'>course_id</span>identificador del curso (FK)</li>
            <li><span class='sql'>semester_id</span>identificador del semestre (FK)</li>
            <li><span class='sql'>faculty_id</span>identificador del profesor (FK)</li>
            <li><span class='sql'>room_id</span>identificador del aula asignada (FK, admite NULL: NULL para cursos totalmente en línea)</li>
            <li><span class='sql'>section_number</span>número de grupo dentro del curso y semestre (TINYINT)</li>
            <li><span class='sql'>delivery</span>modalidad: in-person, online o hybrid (ENUM)</li>
            <li><span class='sql'>max_capacity</span>número máximo de inscritos (SMALLINT)</li>
            <li><span class='sql'>status</span>estado del grupo: open, closed, cancelled o completed (ENUM)</li>
            <li><span class='sql'>schedule</span>horario semanal en JSON, por ejemplo, <code>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim}]</code></li>
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
            <li>CLAVE PRIMARIA, btree (section_id)</li>
            <li>CLAVE ÚNICA (course_id, semester_id, section_number)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (course_id) REFERENCIAS courses(course_id)</li>
            <li>CLAVE FORÁNEA (semester_id) REFERENCIAS semesters(semester_id)</li>
            <li>CLAVE FORÁNEA (faculty_id) REFERENCIAS faculty(faculty_id)</li>
            <li>CLAVE FORÁNEA (room_id) REFERENCIAS rooms(room_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>enrollments</span> - inscripciones de estudiantes en grupos de cursos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>identificador único del registro (PK, INT)</li>
            <li><span class='sql'>student_id</span>identificador del estudiante (FK)</li>
            <li><span class='sql'>section_id</span>identificador del grupo (FK)</li>
            <li><span class='sql'>enrolled_at</span>fecha y hora de la inscripción (TIMESTAMP)</li>
            <li><span class='sql'>status</span>estado de la inscripción: enrolled, dropped, completed, failed o incomplete (ENUM)</li>
            <li><span class='sql'>final_grade</span>calificación final en letras, por ejemplo, 'A', 'B+' (CHAR, admite NULL)</li>
            <li><span class='sql'>final_score</span>puntuación final 0.00–100.00 (DECIMAL, admite NULL)</li>
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
            <li>CLAVE PRIMARIA, btree (enrollment_id)</li>
            <li>CLAVE ÚNICA (student_id, section_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (student_id) REFERENCIAS students(student_id)</li>
            <li>CLAVE FORÁNEA (section_id) REFERENCIAS sections(section_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>student_scholarships</span> - becas concedidas a estudiantes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>award_id</span>identificador único del registro (PK, INT)</li>
            <li><span class='sql'>student_id</span>identificador del estudiante (FK)</li>
            <li><span class='sql'>scholarship_id</span>identificador de la beca (FK)</li>
            <li><span class='sql'>awarded_date</span>fecha de concesión de la beca</li>
            <li><span class='sql'>expires_date</span>fecha de vencimiento de la beca (admite NULL)</li>
            <li><span class='sql'>amount_awarded</span>importe concedido (DECIMAL)</li>
            <li><span class='sql'>notes</span>notas adicionales sobre la beca (TEXT, admite NULL)</li>
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
            <li>CLAVE PRIMARIA, btree (award_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (student_id) REFERENCIAS students(student_id)</li>
            <li>CLAVE FORÁNEA (scholarship_id) REFERENCIAS scholarships(scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>research_projects</span> - proyectos de investigación dirigidos por profesores.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>identificador único del registro (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identificador del departamento (FK)</li>
            <li><span class='sql'>lead_faculty_id</span>investigador principal (FK)</li>
            <li><span class='sql'>title</span>título del proyecto</li>
            <li><span class='sql'>abstract</span>descripción del proyecto (TEXT, admite NULL)</li>
            <li><span class='sql'>start_date</span>fecha de inicio del proyecto</li>
            <li><span class='sql'>end_date</span>fecha de finalización del proyecto (admite NULL)</li>
            <li><span class='sql'>status</span>estado del proyecto: proposed, active, completed o cancelled (ENUM)</li>
            <li><span class='sql'>funding</span>fuentes de financiación en JSON, por ejemplo, <code>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2024-001"{rdelim}]</code></li>
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
            <li>CLAVE PRIMARIA, btree (project_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (department_id) REFERENCIAS departments(department_id)</li>
            <li>CLAVE FORÁNEA (lead_faculty_id) REFERENCIAS faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>publications</span> - artículos de investigación con búsqueda de texto completo.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>identificador único del registro (PK, INT)</li>
            <li><span class='sql'>project_id</span>proyecto de investigación asociado (FK, admite NULL)</li>
            <li><span class='sql'>title</span>título de la publicación</li>
            <li><span class='sql'>abstract</span>resumen de la publicación (MEDIUMTEXT, índice FULLTEXT junto con title)</li>
            <li><span class='sql'>pub_year</span>año de publicación (YEAR)</li>
            <li><span class='sql'>venue</span>revista o congreso (admite NULL)</li>
            <li><span class='sql'>doi</span>Digital Object Identifier, DOI (admite NULL)</li>
            <li><span class='sql' style="min-width: 9rem;">keywords</span>palabras clave, una o varias de: AI, ML, Data Science, Networking, Security, Algorithms, Databases, HCI, Theory, Bioinformatics, Systems, Mathematics, Physics, Chemistry, Biology (SET)</li>
            <li><span class='sql'>citation_count</span>número de citas recibidas (INT)</li>
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
            <li>CLAVE PRIMARIA, btree (publication_id)</li>
            <li>CLAVE ÚNICA (doi)</li>
            <li>FULLTEXT (title, abstract)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (project_id) REFERENCIAS research_projects(project_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>project_members</span> - participación de profesores y estudiantes en proyectos de investigación.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>member_id</span>identificador único del registro (PK, INT)</li>
            <li><span class='sql'>project_id</span>identificador del proyecto de investigación (FK)</li>
            <li><span class='sql'>faculty_id</span>identificador del profesor (FK, admite NULL)</li>
            <li><span class='sql'>student_id</span>identificador del estudiante (FK, admite NULL)</li>
            <li><span class='sql'>role</span>rol del participante: Principal Investigator, Co-Investigator, Research Assistant, Graduate Student o Undergraduate Student (ENUM)</li>
            <li><span class='sql'>joined_date</span>fecha de incorporación al proyecto</li>
            <li><span class='sql'>left_date</span>fecha de salida del proyecto (admite NULL)</li>
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
            <li>CLAVE PRIMARIA, btree (member_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (project_id) REFERENCIAS research_projects(project_id)</li>
            <li>CLAVE FORÁNEA (faculty_id) REFERENCIAS faculty(faculty_id)</li>
            <li>CLAVE FORÁNEA (student_id) REFERENCIAS students(student_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>grade_events</span> - calificaciones individuales por inscripción (~120 000 filas).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>identificador único del registro (PK, BIGINT)</li>
            <li><span class='sql'>enrollment_id</span>identificador de la inscripción (FK)</li>
            <li><span class='sql'>item_name</span>nombre de la actividad evaluada, por ejemplo, 'Assignment 1', 'Midterm Exam'</li>
            <li><span class='sql'>item_type</span>tipo de actividad: assignment, quiz, midterm, final, project, participation o lab (ENUM)</li>
            <li><span class='sql'>score</span>puntos obtenidos (DECIMAL)</li>
            <li><span class='sql'>max_score</span>puntuación máxima posible, por defecto 100.00 (DECIMAL)</li>
            <li><span class='sql'>weight</span>peso en la nota final, por ejemplo, 0.1500 para el 15% (DECIMAL)</li>
            <li><span class='sql'>graded_at</span>fecha y hora en que se registró la calificación (DATETIME)</li>
            <li><span class='sql'>grader_id</span>profesor que calificó la actividad (FK, admite NULL)</li>
            <li><span class='sql'>feedback</span>comentarios del evaluador (TEXT, admite NULL)</li>
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
            <li>CLAVE PRIMARIA, btree (event_id)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (enrollment_id) REFERENCIAS enrollments(enrollment_id)</li>
            <li>CLAVE FORÁNEA (grader_id) REFERENCIAS faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>audit_log</span> - historial de cambios por fila generado por triggers (~60 000 filas).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>identificador único del registro (PK, BIGINT)</li>
            <li><span class='sql'>table_name</span>nombre de la tabla modificada</li>
            <li><span class='sql'>record_id</span>clave primaria del registro modificado (BIGINT)</li>
            <li><span class='sql'>action</span>tipo de cambio: INSERT, UPDATE o DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>fecha y hora del cambio (TIMESTAMP)</li>
            <li><span class='sql'>changed_by</span>usuario de la base de datos o contexto de la aplicación (admite NULL)</li>
            <li><span class='sql'>old_values</span>valores anteriores de las columnas en JSON (NULL para INSERT)</li>
            <li><span class='sql'>new_values</span>valores nuevos de las columnas en JSON (NULL para DELETE)</li>
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
            <li>CLAVE PRIMARIA, btree (log_id)</li>
        </ul>
    </div>
    <h3>Vistas</h3>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la vista en el editor">
        <span><span class='sql'>v_student_gpa</span> - GPA ponderado de cada estudiante por semestre.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identificador del estudiante</li>
            <li><span class='sql'>student_number</span>número de identificación único del estudiante</li>
            <li><span class='sql'>first_name</span>nombre del estudiante</li>
            <li><span class='sql'>last_name</span>apellido del estudiante</li>
            <li><span class='sql'>semester_id</span>identificador del semestre</li>
            <li><span class='sql'>semester_name</span>nombre del semestre</li>
            <li><span class='sql'>semester_gpa</span>GPA ponderado del semestre</li>
            <li><span class='sql'>credits_earned</span>créditos obtenidos en el semestre</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la vista en el editor">
        <span><span class='sql'>v_section_roster</span> - estudiantes inscritos con datos de contacto por grupo.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identificador del grupo</li>
            <li><span class='sql'>course_code</span>código del curso</li>
            <li><span class='sql'>course_title</span>título del curso</li>
            <li><span class='sql'>semester_name</span>nombre del semestre</li>
            <li><span class='sql'>student_id</span>identificador del estudiante</li>
            <li><span class='sql'>student_number</span>número de identificación único del estudiante</li>
            <li><span class='sql'>first_name</span>nombre del estudiante</li>
            <li><span class='sql'>last_name</span>apellido del estudiante</li>
            <li><span class='sql'>email</span>correo electrónico del estudiante</li>
            <li><span class='sql'>status</span>estado de la inscripción</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la vista en el editor">
        <span><span class='sql'>v_course_pass_rate</span> - porcentaje histórico de aprobados y suspensos y puntuación media por curso.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador del curso</li>
            <li><span class='sql'>code</span>código del curso</li>
            <li><span class='sql'>title</span>título del curso</li>
            <li><span class='sql'>semester_id</span>identificador del semestre</li>
            <li><span class='sql'>semester_name</span>nombre del semestre</li>
            <li><span class='sql'>total_enrolled</span>número total de estudiantes inscritos</li>
            <li><span class='sql'>passed</span>número de estudiantes aprobados</li>
            <li><span class='sql'>pass_rate</span>porcentaje de aprobados</li>
            <li><span class='sql'>avg_score</span>puntuación final media</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la vista en el editor">
        <span><span class='sql'>v_faculty_workload</span> - grupos impartidos y tasa de ocupación por profesor y semestre.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identificador del profesor</li>
            <li><span class='sql'>first_name</span>nombre del profesor</li>
            <li><span class='sql'>last_name</span>apellido del profesor</li>
            <li><span class='sql'>semester_id</span>identificador del semestre</li>
            <li><span class='sql'>semester_name</span>nombre del semestre</li>
            <li><span class='sql'>sections_taught</span>número de grupos impartidos</li>
            <li><span class='sql'>total_capacity</span>capacidad total de plazas en todos los grupos</li>
            <li><span class='sql'>total_enrolled</span>número total de estudiantes inscritos</li>
            <li><span class='sql'>fill_rate</span>tasa de ocupación en porcentaje</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la vista en el editor">
        <span><span class='sql'>v_top_scholars</span> - estudiantes ordenados por el importe total de becas recibidas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>rank_position</span>posición según el importe total de becas</li>
            <li><span class='sql'>student_id</span>identificador del estudiante</li>
            <li><span class='sql'>student_number</span>número de identificación único del estudiante</li>
            <li><span class='sql'>first_name</span>nombre del estudiante</li>
            <li><span class='sql'>last_name</span>apellido del estudiante</li>
            <li><span class='sql'>total_scholarships</span>número de becas recibidas</li>
            <li><span class='sql'>total_amount</span>suma de amount_awarded de todas las becas</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la vista en el editor">
        <span><span class='sql'>v_publication_stats</span> - número de artículos y citas por departamento y año.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identificador del departamento</li>
            <li><span class='sql'>department_name</span>nombre del departamento</li>
            <li><span class='sql'>pub_year</span>año de publicación</li>
            <li><span class='sql'>paper_count</span>número de artículos publicados</li>
            <li><span class='sql'>total_citations</span>número total de citas de todos los artículos</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la vista en el editor">
        <span><span class='sql'>v_prerequisite_tree</span> - requisitos previos directos de cada curso.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador del curso</li>
            <li><span class='sql'>course_code</span>código del curso</li>
            <li><span class='sql'>course_title</span>título del curso</li>
            <li><span class='sql'>prerequisite_id</span>identificador del curso requisito previo</li>
            <li><span class='sql'>prerequisite_code</span>código del curso requisito previo</li>
            <li><span class='sql'>prerequisite_title</span>título del curso requisito previo</li>
            <li><span class='sql'>is_mandatory</span>si el requisito previo es obligatorio o recomendado</li>
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
</div>
