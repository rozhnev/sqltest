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
            <img src="/images/erd_small_light.svg" alt="Diagrama ER do banco de dados University com relacionamentos entre tabelas" style="width: 90%;" loading="lazy" decoding="async">
            Diagrama ER do banco de dados University
        </a>
    </p>
    <h3>Lista de Tabelas</h3>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>semesters</span> - tabela de semestres acadêmicos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>semester_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>name</span>nome do semestre (ex.: 'Fall 2024')</li>
            <li><span class='sql'>academic_year</span>ano letivo (tipo YEAR)</li>
            <li><span class='sql'>term</span>tipo de período: Fall, Spring ou Summer (ENUM)</li>
            <li><span class='sql'>start_date</span>primeiro dia do semestre</li>
            <li><span class='sql'>end_date</span>último dia do semestre</li>
            <li><span class='sql'>is_active</span>indica se o semestre está ativo no momento (BOOLEAN)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>rooms</span> - salas de aula e laboratórios do campus.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>building</span>nome do edifício</li>
            <li><span class='sql'>room_number</span>número ou identificação da sala</li>
            <li><span class='sql'>capacity</span>número máximo de lugares (SMALLINT)</li>
            <li><span class='sql'>type</span>tipo de sala: Lecture, Lab, Seminar ou Conference (ENUM)</li>
            <li><span class='sql'>has_projector</span>indica se a sala possui projetor (BOOLEAN)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>scholarships</span> - bolsas de estudo disponíveis.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>name</span>nome da bolsa de estudo</li>
            <li><span class='sql'>amount</span>valor da bolsa (DECIMAL)</li>
            <li><span class='sql'>type</span>tipo de bolsa: Merit, Need-Based, Athletic ou Research (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>critérios de elegibilidade em JSON — ex.: <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>departments</span> - hierarquia de três níveis de departamentos (Faculdade → Departamento → Subdepartamento).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>name</span>nome do departamento</li>
            <li><span class='sql'>code</span>código abreviado do departamento</li>
            <li><span class='sql'>parent_id</span>identificador do departamento pai — FK autorreferenciada (nulável)</li>
            <li><span class='sql'>level</span>nível hierárquico: 1 = Faculdade, 2 = Departamento, 3 = Subdepartamento (TINYINT)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>faculty</span> - membros do corpo docente da universidade.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>first_name</span>primeiro nome do docente</li>
            <li><span class='sql'>last_name</span>sobrenome do docente</li>
            <li><span class='sql'>email</span>endereço de e-mail institucional</li>
            <li><span class='sql'>department_id</span>identificador do departamento (FK)</li>
            <li><span class='sql'>title</span>cargo acadêmico: Professor, Associate Professor, Assistant Professor, Lecturer ou Instructor (ENUM)</li>
            <li><span class='sql'>hire_date</span>data de contratação</li>
            <li><span class='sql'>office_hours</span>horários de atendimento semanais em JSON — ex.: <code>[{"day":"Mon","start":"10:00","end":"12:00"}]</code></li>
            <li><span class='sql'>bio</span>texto biográfico (TEXT)</li>
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
                        <td>[{"day":"Mon","start":"10:00","end":"12:00"},{"day":"Wed","start":"14:00","end":"16:00"}]</td>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>students</span> - estudantes matriculados.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>student_number</span>número de matrícula único do estudante (CHAR)</li>
            <li><span class='sql'>first_name</span>primeiro nome do estudante</li>
            <li><span class='sql'>last_name</span>sobrenome do estudante</li>
            <li><span class='sql'>email</span>endereço de e-mail do estudante</li>
            <li><span class='sql'>date_of_birth</span>data de nascimento do estudante</li>
            <li><span class='sql'>enrollment_date</span>data da primeira matrícula do estudante</li>
            <li><span class='sql'>status</span>situação acadêmica: Active, Inactive, Graduated ou Suspended (ENUM)</li>
            <li><span class='sql'>gpa</span>coeficiente de rendimento acumulado atual (DECIMAL)</li>
            <li><span class='sql'>contacts</span>contato de emergência e endereço em JSON</li>
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
                        <td>{"emergency":{"name":"Susan Miller","phone":"+15551234567"}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (student_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>courses</span> - catálogo de disciplinas com suporte a busca por texto completo e vetorial.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>code</span>código da disciplina (ex.: CS301)</li>
            <li><span class='sql'>title</span>título da disciplina</li>
            <li><span class='sql'>description</span>descrição detalhada da disciplina (TEXT, índice FULLTEXT)</li>
            <li><span class='sql'>credits</span>número de créditos (TINYINT)</li>
            <li><span class='sql'>department_id</span>identificador do departamento (FK)</li>
            <li><span class='sql'>is_active</span>indica se a disciplina está sendo oferecida no momento (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>embedding semântico de 1536 dimensões para busca por similaridade vetorial (VECTOR(1536))</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>course_prerequisites</span> - relações de pré-requisitos entre disciplinas (muitos-para-muitos autorreferenciada).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identificador da disciplina (FK)</li>
            <li><span class='sql'>prerequisite_id</span>identificador da disciplina pré-requisito (FK)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>sections</span> - turmas de disciplinas (uma oferta específica de uma disciplina em um semestre).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>course_id</span>identificador da disciplina (FK)</li>
            <li><span class='sql'>semester_id</span>identificador do semestre (FK)</li>
            <li><span class='sql'>faculty_id</span>identificador do professor responsável (FK)</li>
            <li><span class='sql'>room_id</span>identificador da sala alocada (FK)</li>
            <li><span class='sql'>capacity</span>número máximo de vagas (SMALLINT)</li>
            <li><span class='sql'>enrolled_count</span>número atual de estudantes matriculados (SMALLINT)</li>
            <li><span class='sql'>status</span>situação da turma: Open, Closed ou Cancelled (ENUM)</li>
            <li><span class='sql'>schedule</span>horários semanais das aulas em JSON — ex.: <code>[{"day":"Mon","start":"09:00","end":"10:30"}]</code></li>
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
                        <td>[{"day":"Mon","start":"09:00","end":"10:30"},{"day":"Wed","start":"09:00","end":"10:30"}]</td>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>enrollments</span> - matrículas de estudantes em turmas de disciplinas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>student_id</span>identificador do estudante (FK)</li>
            <li><span class='sql'>section_id</span>identificador da turma (FK)</li>
            <li><span class='sql'>enrolled_at</span>data e hora da matrícula (TIMESTAMP)</li>
            <li><span class='sql'>status</span>situação da matrícula: Enrolled, Dropped, Completed ou Withdrawn (ENUM)</li>
            <li><span class='sql'>grade</span>conceito final em letra (CHAR)</li>
            <li><span class='sql'>final_score</span>pontuação numérica calculada (DECIMAL)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>student_scholarships</span> - bolsas de estudo concedidas a estudantes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identificador do estudante (FK)</li>
            <li><span class='sql'>scholarship_id</span>identificador da bolsa de estudo (FK)</li>
            <li><span class='sql'>awarded_date</span>data em que a bolsa foi concedida</li>
            <li><span class='sql'>amount</span>valor efetivamente concedido, podendo diferir do valor base da bolsa (DECIMAL)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>research_projects</span> - projetos de pesquisa dos departamentos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>title</span>título do projeto</li>
            <li><span class='sql'>description</span>descrição do projeto (TEXT)</li>
            <li><span class='sql'>department_id</span>identificador do departamento (FK)</li>
            <li><span class='sql'>status</span>situação do projeto: Proposed, Active, Completed ou Cancelled (ENUM)</li>
            <li><span class='sql'>start_date</span>data de início do projeto</li>
            <li><span class='sql'>end_date</span>data de encerramento do projeto (nulável)</li>
            <li><span class='sql'>funding</span>fontes de financiamento em JSON — ex.: <code>[{"source":"NSF","amount":150000}]</code></li>
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
                        <td>[{"source":"NSF","amount":150000,"grant_id":"NSF-2023-042"}]</td>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>publications</span> - publicações científicas com suporte a busca por texto completo.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>title</span>título da publicação</li>
            <li><span class='sql'>abstract</span>resumo da publicação (MEDIUMTEXT, índice FULLTEXT)</li>
            <li><span class='sql'>journal</span>nome do periódico ou conferência</li>
            <li><span class='sql'>publication_year</span>ano de publicação (YEAR)</li>
            <li><span class='sql'>doi</span>Identificador de Objeto Digital (DOI)</li>
            <li><span class='sql' style="min-width: 11rem;">contribution_type</span>tipo de contribuição — um ou mais entre: Theoretical, Experimental, Review, Applied (SET)</li>
            <li><span class='sql'>project_id</span>identificador do projeto de pesquisa associado (FK, nulável)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>project_members</span> - participação de docentes e estudantes em projetos de pesquisa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>identificador do projeto de pesquisa (FK)</li>
            <li><span class='sql'>faculty_id</span>identificador do docente (FK, nulável)</li>
            <li><span class='sql'>student_id</span>identificador do estudante (FK, nulável)</li>
            <li><span class='sql'>role</span>papel do membro: PI, Co-PI, Researcher ou Assistant (ENUM)</li>
            <li><span class='sql'>join_date</span>data de ingresso no projeto</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>grade_events</span> - itens de avaliação individuais por matrícula (~120 000 linhas).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>identificador único do registro (BIGINT PK)</li>
            <li><span class='sql'>enrollment_id</span>identificador da matrícula (FK)</li>
            <li><span class='sql'>item_name</span>nome do item avaliado (ex.: 'Midterm Exam')</li>
            <li><span class='sql'>item_type</span>tipo de item: Homework, Quiz, Midterm, Final, Project ou Lab (ENUM)</li>
            <li><span class='sql'>score</span>pontuação obtida (DECIMAL)</li>
            <li><span class='sql'>max_score</span>pontuação máxima possível (DECIMAL)</li>
            <li><span class='sql'>weight</span>peso percentual na nota final (DECIMAL)</li>
            <li><span class='sql'>grader_id</span>docente responsável pela correção (FK)</li>
            <li><span class='sql'>created_at</span>data e hora do registro da nota (DATETIME)</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>audit_log</span> - histórico de alterações gerado por triggers (~60 000 linhas).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>identificador único do registro (BIGINT PK)</li>
            <li><span class='sql'>table_name</span>nome da tabela modificada</li>
            <li><span class='sql'>record_id</span>chave primária do registro modificado (BIGINT)</li>
            <li><span class='sql'>action</span>tipo de alteração: INSERT, UPDATE ou DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>data e hora da alteração (TIMESTAMP)</li>
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
                        <td>{"status":"Enrolled","final_score":null}</td>
                        <td>{"status":"Completed","final_score":93.50}</td>
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
            <li><span class='sql'>total_amount</span>valor total de bolsas recebidas</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da visão">
        <span><span class='sql'>v_publication_stats</span> - contagem de artigos por departamento por ano.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identificador do departamento</li>
            <li><span class='sql'>department_name</span>nome do departamento</li>
            <li><span class='sql'>publication_year</span>ano de publicação</li>
            <li><span class='sql'>paper_count</span>número de artigos publicados</li>
            <li><span class='sql'>journal_count</span>número de periódicos distintos</li>
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
