<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
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
            <li><span class='sql'>department_id</span>identificador del departamento de origen (FK)</li>
            <li><span class='sql'>student_number</span>número de identificación único del estudiante (CHAR, por ejemplo, 'S000123')</li>
            <li><span class='sql'>first_name</span>nombre del estudiante</li>
            <li><span class='sql'>last_name</span>apellido del estudiante</li>
            <li><span class='sql'>email</span>dirección de correo electrónico del estudiante</li>
            <li><span class='sql'>date_of_birth</span>fecha de nacimiento del estudiante</li>
            <li><span class='sql'>gender</span>género: M, F, NB, Otro, o Prefiero no decir (ENUM, nullable)</li>
            <li><span class='sql'>enrollment_date</span>fecha en que el estudiante fue inscrito por primera vez</li>
            <li><span class='sql'>expected_grad</span>año de graduación esperado (YEAR, nullable)</li>
            <li><span class='sql'>status</span>estado de inscripción: activo, inactivo, graduado, suspendido, o retirado (ENUM)</li>
            <li><span class='sql'>gpa</span>promedio acumulativo de GPA 0.000–4.000, mantenido por trigger (DECIMAL, nullable)</li>
            <li><span class='sql'>contacts</span>contacto de emergencia y dirección como JSON — por ejemplo, <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
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
                        <th scope="