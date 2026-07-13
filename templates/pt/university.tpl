<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>Banco de Dados University: estrutura e descrição das tabelas</h2>
    <p>University DB é um banco de dados de exemplo moderno para <strong>MariaDB 11.7+</strong> desenvolvido para aprendizado de SQL — criado como um substituto rico em recursos do clássico banco de dados Sakila.</p>
    <p>Ele abrange todos os principais tipos de dados do MariaDB, incluindo <span class='sql'>VECTOR(1536)</span>, <span class='sql'>JSON</span>, <span class='sql'>SET</span> e índices <span class='sql'>FULLTEXT</span>, está totalmente normalizado na 3FN e contém dados suficientes para exercícios de iniciantes e consultas analíticas complexas.</p>
    <p>O banco de dados University contém 16 tabelas principais descrevendo a estrutura acadêmica de uma universidade — departamentos, corpo docente, estudantes, disciplinas, matrículas, projetos de pesquisa e muito mais.</p>
    <p>
        <a href="/{$Lang}/erd/University" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir o diagrama ER do banco de dados University em uma nova janela">
            <img src="/images/erd_small_light.svg" alt="Diagrama ER do banco de dados University com relacionamentos entre tabelas" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Diagrama ER do banco de dados University
        </a>
    </p>
    <h3>Lista de Tabelas</h3>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>semesters</span> - tabela de semestres acadêmicos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>semester_id</span>identificador único do registro (PK, TINYINT)</li>
            <li><span class='sql'>term</span>tipo de período: Fall, Spring ou Summer (ENUM)</li>
            <li><span class='sql'>academic_year</span>ano letivo (tipo YEAR)</li>
            <li><span class='sql'>name</span>nome do semestre (ex.: 'Fall 2024')</li>
            <li><span class='sql'>start_date</span>primeiro dia do semestre</li>
            <li><span class='sql'>end_date</span>último dia do semestre</li>
            <li><span class='sql'>enroll_deadline</span>último dia para matrícula de estudantes</li>
            <li><span class='sql'>is_active</span>indica se o semestre está ativo no momento (BOOLEAN)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>rooms</span> - salas de aula e laboratórios do campus.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>identificador único do registro (PK, SMALLINT)</li>
            <li><span class='sql'>building</span>nome do edifício</li>
            <li><span class='sql'>room_number</span>número ou identificação da sala</li>
            <li><span class='sql'>capacity</span>número máximo de lugares (SMALLINT)</li>
            <li><span class='sql'>room_type</span>tipo de sala: lecture, seminar, lab, computer_lab ou online (ENUM)</li>
            <li><span class='sql'>has_projector</span>indica se a sala possui projetor (BOOLEAN)</li>
            <li><span class='sql'>has_video</span>indica se a sala possui equipamento de videoconferência (BOOLEAN)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>scholarships</span> - bolsas de estudo disponíveis.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>identificador único do registro (PK, SMALLINT)</li>
            <li><span class='sql'>name</span>nome da bolsa de estudo</li>
            <li><span class='sql'>amount</span>valor da bolsa (DECIMAL)</li>
            <li><span class='sql'>frequency</span>frequência de concessão: one-time, annual ou per-semester (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>critérios de elegibilidade em JSON — ex.: <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
            <li><span class='sql'>is_active</span>indica se a bolsa está sendo oferecida no momento (BOOLEAN)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>departments</span> - hierarquia de três níveis de departamentos (Faculdade → Departamento → Subdepartamento).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identificador único do registro (PK, TINYINT)</li>
            <li><span class='sql'>parent_id</span>identificador do departamento pai — FK autorreferenciada (nulável)</li>
            <li><span class='sql'>code</span>código abreviado do departamento (CHAR)</li>
            <li><span class='sql'>name</span>nome do departamento</li>
            <li><span class='sql'>level</span>nível hierárquico: 1 = Faculdade, 2 = Departamento, 3 = Subdepartamento (TINYINT)</li>
            <li><span class='sql'>head_faculty_id</span>identificador do chefe do departamento (FK, nulável)</li>
            <li><span class='sql'>established</span>ano de fundação do departamento (YEAR, nulável)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>faculty</span> - membros do corpo docente da universidade.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identificador único do registro (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identificador do departamento (FK)</li>
            <li><span class='sql'>first_name</span>primeiro nome do docente</li>
            <li><span class='sql'>last_name</span>sobrenome do docente</li>
            <li><span class='sql'>email</span>endereço de e-mail institucional</li>
            <li><span class='sql'>phone</span>número de telefone do escritório (nulável)</li>
            <li><span class='sql'>rank</span>cargo acadêmico: Instructor, Assistant Professor, Associate Professor, Professor ou Emeritus (ENUM)</li>
            <li><span class='sql'>hire_date</span>data de contratação</li>
            <li><span class='sql'>office</span>número ou localização da sala do docente (nulável)</li>
            <li><span class='sql'>office_hours</span>horários de atendimento semanais em JSON — ex.: <code>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</code></li>
            <li><span class='sql'>bio</span>texto biográfico (TEXT, nulável)</li>
            <li><span class='sql'>is_active</span>indica se o docente está ativo no momento (BOOLEAN)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>students</span> - estudantes matriculados.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identificador único do registro (PK, INT)</li>
            <li><span class='sql'>department_id</span>identificador do departamento de origem (FK)</li>
            <li><span class='sql'>student_number</span>número de matrícula único do estudante (CHAR, ex.: 'S000123')</li>
            <li><span class='sql'>first_name</span>primeiro nome do estudante</li>
            <li><span class='sql'>last_name</span>sobrenome do estudante</li>
            <li><span class='sql'>email</span>endereço de e-mail do estudante</li>
            <li><span class='sql'>date_of_birth</span>data de nascimento do estudante</li>
            <li><span class='sql'>gender</span>gênero: M, F, NB, Other ou Prefer not to say (ENUM, nulável)</li>
            <li><span class='sql'>enrollment_date</span>data da primeira matrícula do estudante</li>
            <li><span class='sql'>expected_grad</span>ano previsto de formatura (YEAR, nulável)</li>
            <li><span class='sql'>status</span>situação acadêmica: active, inactive, graduated, suspended ou withdrawn (ENUM)</li>
            <li><span class='sql'>gpa</span>coeficiente de rendimento acumulado 0.000–4.000, mantido por trigger (DECIMAL, nulável)</li>
            <li><span class='sql'>contacts</span>contato de emergência e endereço em JSON — ex.: <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>courses</span> - catálogo de disciplinas com suporte a busca por texto completo e vetorial.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador único do registro (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identificador do departamento responsável (FK)</li>
            <li><span class='sql'>code</span>código da disciplina (ex.: 'CS101') (CHAR)</li>
            <li><span class='sql'>title</span>título da disciplina</li>
            <li><span class='sql'>credits</span>número de créditos (TINYINT)</li>
            <li><span class='sql'>level</span>nível acadêmico: undergraduate, graduate ou doctoral (ENUM)</li>
            <li><span class='sql'>description</span>descrição detalhada da disciplina (TEXT, índice FULLTEXT com title)</li>
            <li><span class='sql'>is_active</span>indica se a disciplina está sendo oferecida no momento (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>embedding semântico de 1536 dimensões para busca por similaridade vetorial (VECTOR(1536), nulável)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>course_prerequisites</span> - relações de pré-requisitos entre disciplinas (muitos-para-muitos autorreferenciada).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador da disciplina (FK)</li>
            <li><span class='sql'>prerequisite_id</span>identificador da disciplina pré-requisito (FK)</li>
            <li><span class='sql'>is_mandatory</span>indica se o pré-requisito é obrigatório ou recomendado (BOOLEAN)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>sections</span> - turmas de disciplinas (uma oferta específica de uma disciplina em um semestre).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identificador único do registro (PK, INT)</li>
            <li><span class='sql'>course_id</span>identificador da disciplina (FK)</li>
            <li><span class='sql'>semester_id</span>identificador do semestre (FK)</li>
            <li><span class='sql'>faculty_id</span>identificador do professor responsável (FK)</li>
            <li><span class='sql'>room_id</span>identificador da sala alocada (FK, nulável — NULL para turmas totalmente online)</li>
            <li><span class='sql'>section_number</span>número da turma dentro da disciplina/semestre (TINYINT)</li>
            <li><span class='sql'>delivery</span>modalidade de ensino: in-person, online ou hybrid (ENUM)</li>
            <li><span class='sql'>max_capacity</span>número máximo de vagas (SMALLINT)</li>
            <li><span class='sql'>status</span>situação da turma: open, closed, cancelled ou completed (ENUM)</li>
            <li><span class='sql'>schedule</span>horários semanais das aulas em JSON — ex.: <code>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim}]</code></li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>enrollments</span> - matrículas de estudantes em turmas de disciplinas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>identificador único do registro (PK, INT)</li>
            <li><span class='sql'>student_id</span>identificador do estudante (FK)</li>
            <li><span class='sql'>section_id</span>identificador da turma (FK)</li>
            <li><span class='sql'>enrolled_at</span>data e hora da matrícula (TIMESTAMP)</li>
            <li><span class='sql'>status</span>situação da matrícula: enrolled, dropped, completed, failed ou incomplete (ENUM)</li>
            <li><span class='sql'>final_grade</span>conceito final em letra, ex.: 'A', 'B+' (CHAR, nulável)</li>
            <li><span class='sql'>final_score</span>pontuação numérica final 0.00–100.00 (DECIMAL, nulável)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>student_scholarships</span> - bolsas de estudo concedidas a estudantes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>award_id</span>identificador único do registro (PK, INT)</li>
            <li><span class='sql'>student_id</span>identificador do estudante (FK)</li>
            <li><span class='sql'>scholarship_id</span>identificador da bolsa de estudo (FK)</li>
            <li><span class='sql'>awarded_date</span>data em que a bolsa foi concedida</li>
            <li><span class='sql'>expires_date</span>data de expiração do prêmio (nulável)</li>
            <li><span class='sql'>amount_awarded</span>valor efetivamente concedido (DECIMAL)</li>
            <li><span class='sql'>notes</span>observações adicionais sobre o prêmio (TEXT, nulável)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>research_projects</span> - projetos de pesquisa dos departamentos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>identificador único do registro (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identificador do departamento (FK)</li>
            <li><span class='sql'>lead_faculty_id</span>investigador principal do projeto (FK)</li>
            <li><span class='sql'>title</span>título do projeto</li>
            <li><span class='sql'>abstract</span>descrição do projeto (TEXT, nulável)</li>
            <li><span class='sql'>start_date</span>data de início do projeto</li>
            <li><span class='sql'>end_date</span>data de encerramento do projeto (nulável)</li>
            <li><span class='sql'>status</span>situação do projeto: proposed, active, completed ou cancelled (ENUM)</li>
            <li><span class='sql'>funding</span>fontes de financiamento em JSON — ex.: <code>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2024-001"{rdelim}]</code></li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>publications</span> - publicações científicas com suporte a busca por texto completo.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>identificador único do registro (PK, INT)</li>
            <li><span class='sql'>project_id</span>projeto de pesquisa associado (FK, nulável)</li>
            <li><span class='sql'>title</span>título da publicação</li>
            <li><span class='sql'>abstract</span>resumo da publicação (MEDIUMTEXT, índice FULLTEXT com title)</li>
            <li><span class='sql'>pub_year</span>ano de publicação (YEAR)</li>
            <li><span class='sql'>venue</span>nome do periódico ou conferência (nulável)</li>
            <li><span class='sql'>doi</span>Identificador de Objeto Digital (DOI, nulável)</li>
            <li><span class='sql' style="min-width: 9rem;">keywords</span>palavras-chave — uma ou mais entre: AI, ML, Data Science, Networking, Security, Algorithms, Databases, HCI, Theory, Bioinformatics, Systems, Mathematics, Physics, Chemistry, Biology (SET)</li>
            <li><span class='sql'>citation_count</span>número de citações recebidas (INT)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>project_members</span> - participação de docentes e estudantes em projetos de pesquisa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>member_id</span>identificador único do registro (PK, INT)</li>
            <li><span class='sql'>project_id</span>identificador do projeto de pesquisa (FK)</li>
            <li><span class='sql'>faculty_id</span>identificador do docente (FK, nulável)</li>
            <li><span class='sql'>student_id</span>identificador do estudante (FK, nulável)</li>
            <li><span class='sql'>role</span>papel do membro: Principal Investigator, Co-Investigator, Research Assistant, Graduate Student ou Undergraduate Student (ENUM)</li>
            <li><span class='sql'>joined_date</span>data de ingresso no projeto</li>
            <li><span class='sql'>left_date</span>data de saída do projeto (nulável)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>grade_events</span> - itens de avaliação individuais por matrícula (~120 000 linhas).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>identificador único do registro (PK, BIGINT)</li>
            <li><span class='sql'>enrollment_id</span>identificador da matrícula (FK)</li>
            <li><span class='sql'>item_name</span>nome do item avaliado (ex.: 'Assignment 1', 'Midterm Exam')</li>
            <li><span class='sql'>item_type</span>tipo de item: assignment, quiz, midterm, final, project, participation ou lab (ENUM)</li>
            <li><span class='sql'>score</span>pontuação obtida (DECIMAL)</li>
            <li><span class='sql'>max_score</span>pontuação máxima possível, padrão 100.00 (DECIMAL)</li>
            <li><span class='sql'>weight</span>fração da nota final, ex.: 0.1500 para 15% (DECIMAL)</li>
            <li><span class='sql'>graded_at</span>data e hora do registro da nota (DATETIME)</li>
            <li><span class='sql'>grader_id</span>docente responsável pela correção (FK, nulável)</li>
            <li><span class='sql'>feedback</span>texto de feedback do avaliador (TEXT, nulável)</li>
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
                        <td>Boa análise, revisar a seção 3.</td>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>audit_log</span> - histórico de alterações gerado por triggers (~60 000 linhas).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>identificador único do registro (PK, BIGINT)</li>
            <li><span class='sql'>table_name</span>nome da tabela modificada</li>
            <li><span class='sql'>record_id</span>chave primária do registro modificado (BIGINT)</li>
            <li><span class='sql'>action</span>tipo de alteração: INSERT, UPDATE ou DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>data e hora da alteração (TIMESTAMP)</li>
            <li><span class='sql'>changed_by</span>usuário do banco de dados ou contexto da aplicação (nulável)</li>
            <li><span class='sql'>old_values</span>valores anteriores das colunas em JSON (null para INSERT)</li>
            <li><span class='sql'>new_values</span>novos valores das colunas em JSON (null para DELETE)</li>
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
    <h3>Visões</h3>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_student_gpa</span> - GPA ponderado por estudante por semestre.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identificador do estudante</li>
            <li><span class='sql'>student_number</span>número de matrícula único do estudante</li>
            <li><span class='sql'>first_name</span>primeiro nome do estudante</li>
            <li><span class='sql'>last_name</span>sobrenome do estudante</li>
            <li><span class='sql'>semester_id</span>identificador do semestre</li>
            <li><span class='sql'>semester_name</span>nome do semestre</li>
            <li><span class='sql'>semester_gpa</span>GPA ponderado do semestre</li>
            <li><span class='sql'>credits_earned</span>créditos obtidos no semestre</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_section_roster</span> - estudantes matriculados com informações de contato por turma.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identificador da turma</li>
            <li><span class='sql'>course_code</span>código da disciplina</li>
            <li><span class='sql'>course_title</span>título da disciplina</li>
            <li><span class='sql'>semester_name</span>nome do semestre</li>
            <li><span class='sql'>student_id</span>identificador do estudante</li>
            <li><span class='sql'>student_number</span>número de matrícula único do estudante</li>
            <li><span class='sql'>first_name</span>primeiro nome do estudante</li>
            <li><span class='sql'>last_name</span>sobrenome do estudante</li>
            <li><span class='sql'>email</span>endereço de e-mail do estudante</li>
            <li><span class='sql'>status</span>situação da matrícula</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_course_pass_rate</span> - percentual histórico de aprovação/reprovação e nota média por disciplina.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador da disciplina</li>
            <li><span class='sql'>code</span>código da disciplina</li>
            <li><span class='sql'>title</span>título da disciplina</li>
            <li><span class='sql'>semester_id</span>identificador do semestre</li>
            <li><span class='sql'>semester_name</span>nome do semestre</li>
            <li><span class='sql'>total_enrolled</span>total de estudantes matriculados</li>
            <li><span class='sql'>passed</span>número de estudantes aprovados</li>
            <li><span class='sql'>pass_rate</span>taxa de aprovação em percentual</li>
            <li><span class='sql'>avg_score</span>nota final média</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_faculty_workload</span> - turmas ministradas e taxa de ocupação por docente por semestre.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identificador do docente</li>
            <li><span class='sql'>first_name</span>primeiro nome do docente</li>
            <li><span class='sql'>last_name</span>sobrenome do docente</li>
            <li><span class='sql'>semester_id</span>identificador do semestre</li>
            <li><span class='sql'>semester_name</span>nome do semestre</li>
            <li><span class='sql'>sections_taught</span>número de turmas ministradas</li>
            <li><span class='sql'>total_capacity</span>capacidade total de vagas em todas as turmas</li>
            <li><span class='sql'>total_enrolled</span>total de estudantes matriculados</li>
            <li><span class='sql'>fill_rate</span>taxa de ocupação em percentual</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_top_scholars</span> - estudantes classificados pelo total de bolsas recebidas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>rank_position</span>posição no ranking por valor total de bolsas</li>
            <li><span class='sql'>student_id</span>identificador do estudante</li>
            <li><span class='sql'>student_number</span>número de matrícula único do estudante</li>
            <li><span class='sql'>first_name</span>primeiro nome do estudante</li>
            <li><span class='sql'>last_name</span>sobrenome do estudante</li>
            <li><span class='sql'>total_scholarships</span>número de bolsas concedidas</li>
            <li><span class='sql'>total_amount</span>valor total de amount_awarded em todas as bolsas</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_publication_stats</span> - contagem de artigos e citações por departamento por ano.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identificador do departamento</li>
            <li><span class='sql'>department_name</span>nome do departamento</li>
            <li><span class='sql'>pub_year</span>ano de publicação</li>
            <li><span class='sql'>paper_count</span>número de artigos publicados</li>
            <li><span class='sql'>total_citations</span>total de citações de todos os artigos</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_prerequisite_tree</span> - pré-requisitos diretos de cada disciplina.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador da disciplina</li>
            <li><span class='sql'>course_code</span>código da disciplina</li>
            <li><span class='sql'>course_title</span>título da disciplina</li>
            <li><span class='sql'>prerequisite_id</span>identificador da disciplina pré-requisito</li>
            <li><span class='sql'>prerequisite_code</span>código da disciplina pré-requisito</li>
            <li><span class='sql'>prerequisite_title</span>título da disciplina pré-requisito</li>
            <li><span class='sql'>is_mandatory</span>indica se o pré-requisito é obrigatório ou recomendado</li>
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
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>
