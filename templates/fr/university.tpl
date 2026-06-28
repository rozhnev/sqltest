<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>Base de données University : structure et description des tables</h2>
    <p>University DB est une base de données d'exemple moderne pour <strong>MariaDB 11.7+</strong> conçue pour l'apprentissage du SQL — pensée comme un remplacement riche en fonctionnalités de la base de données classique Sakila.</p>
    <p>Elle couvre tous les types de données significatifs de MariaDB, notamment <span class='sql'>VECTOR(1536)</span>, <span class='sql'>JSON</span>, <span class='sql'>SET</span> et les index <span class='sql'>FULLTEXT</span>, est entièrement normalisée en 3FN et contient suffisamment de données pour les exercices débutants comme pour les requêtes analytiques complexes.</p>
    <p>La base de données University contient 16 tables principales décrivant la structure académique d'une université : départements, corps enseignant, étudiants, cours, inscriptions, projets de recherche, et bien plus encore.</p>
    <p>
        <a href="/{$Lang}/erd/University" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Ouvrir le schéma ER de la base de données University dans une nouvelle fenêtre">
            <img src="/images/erd_small_light.svg" alt="Schéma ER de la base de données University avec les relations entre les tables" style="width: 90%;" loading="lazy" decoding="async">
            Schéma ER de la base de données University
        </a>
    </p>
    <h3>Liste des tables</h3>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>semesters</span> - table des semestres académiques.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>semester_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>name</span>nom du semestre (ex. 'Fall 2024')</li>
            <li><span class='sql'>academic_year</span>année académique (type YEAR)</li>
            <li><span class='sql'>term</span>type de période : Fall, Spring ou Summer (ENUM)</li>
            <li><span class='sql'>start_date</span>premier jour du semestre</li>
            <li><span class='sql'>end_date</span>dernier jour du semestre</li>
            <li><span class='sql'>is_active</span>indique si le semestre est actuellement en cours (BOOLEAN)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>rooms</span> - salles de cours et laboratoires du campus.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>building</span>nom du bâtiment</li>
            <li><span class='sql'>room_number</span>numéro ou étiquette de la salle</li>
            <li><span class='sql'>capacity</span>nombre maximum de places (SMALLINT)</li>
            <li><span class='sql'>type</span>type de salle : Lecture, Lab, Seminar ou Conference (ENUM)</li>
            <li><span class='sql'>has_projector</span>indique si la salle est équipée d'un projecteur (BOOLEAN)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>scholarships</span> - bourses disponibles.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>name</span>nom de la bourse</li>
            <li><span class='sql'>amount</span>montant de la récompense (DECIMAL)</li>
            <li><span class='sql'>type</span>type de bourse : Merit, Need-Based, Athletic ou Research (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>critères d'éligibilité au format JSON — ex. <code>{"min_gpa": 3.5, "need_based": true}</code></li>
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
                        <td>{"min_gpa": 3.8, "need_based": false, "majors": ["CS","Math"]}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>departments</span> - hiérarchie de départements à trois niveaux (Faculté → Département → Sous-département).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>name</span>nom du département</li>
            <li><span class='sql'>code</span>code court du département</li>
            <li><span class='sql'>parent_id</span>identifiant du département parent — FK auto-référençante (nullable)</li>
            <li><span class='sql'>level</span>niveau hiérarchique : 1 = Faculté, 2 = Département, 3 = Sous-département (TINYINT)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>faculty</span> - membres du corps enseignant de l'université.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>first_name</span>prénom du membre du corps enseignant</li>
            <li><span class='sql'>last_name</span>nom de famille du membre du corps enseignant</li>
            <li><span class='sql'>email</span>adresse e-mail institutionnelle</li>
            <li><span class='sql'>department_id</span>identifiant du département (FK)</li>
            <li><span class='sql'>title</span>rang académique : Professor, Associate Professor, Assistant Professor, Lecturer ou Instructor (ENUM)</li>
            <li><span class='sql'>hire_date</span>date d'embauche</li>
            <li><span class='sql'>office_hours</span>heures de permanence hebdomadaires au format tableau JSON — ex. <code>[{"day":"Mon","start":"10:00","end":"12:00"}]</code></li>
            <li><span class='sql'>bio</span>texte biographique (TEXT)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>students</span> - étudiants inscrits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>student_number</span>numéro d'étudiant unique (CHAR)</li>
            <li><span class='sql'>first_name</span>prénom de l'étudiant</li>
            <li><span class='sql'>last_name</span>nom de famille de l'étudiant</li>
            <li><span class='sql'>email</span>adresse e-mail de l'étudiant</li>
            <li><span class='sql'>date_of_birth</span>date de naissance de l'étudiant</li>
            <li><span class='sql'>enrollment_date</span>date de la première inscription de l'étudiant</li>
            <li><span class='sql'>status</span>statut d'inscription : Active, Inactive, Graduated ou Suspended (ENUM)</li>
            <li><span class='sql'>gpa</span>moyenne générale cumulative actuelle (DECIMAL)</li>
            <li><span class='sql'>contacts</span>contact d'urgence et adresse au format JSON</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>courses</span> - catalogue des cours avec prise en charge de la recherche plein texte et vectorielle.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>code</span>code du cours (ex. CS301)</li>
            <li><span class='sql'>title</span>intitulé du cours</li>
            <li><span class='sql'>description</span>description détaillée du cours (TEXT, index FULLTEXT)</li>
            <li><span class='sql'>credits</span>nombre de crédits (TINYINT)</li>
            <li><span class='sql'>department_id</span>identifiant du département (FK)</li>
            <li><span class='sql'>is_active</span>indique si le cours est actuellement proposé (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>embedding sémantique de 1536 dimensions pour la recherche par similarité vectorielle (VECTOR(1536))</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>course_prerequisites</span> - relations de prérequis entre cours (many-to-many auto-référençante).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identifiant du cours (FK)</li>
            <li><span class='sql'>prerequisite_id</span>identifiant du cours prérequis (FK)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>sections</span> - groupes de cours (une offre spécifique d'un cours au cours d'un semestre).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>course_id</span>identifiant du cours (FK)</li>
            <li><span class='sql'>semester_id</span>identifiant du semestre (FK)</li>
            <li><span class='sql'>faculty_id</span>identifiant de l'enseignant (FK)</li>
            <li><span class='sql'>room_id</span>identifiant de la salle attribuée (FK)</li>
            <li><span class='sql'>capacity</span>nombre maximum d'inscriptions (SMALLINT)</li>
            <li><span class='sql'>enrolled_count</span>nombre actuel d'étudiants inscrits (SMALLINT)</li>
            <li><span class='sql'>status</span>statut du groupe : Open, Closed ou Cancelled (ENUM)</li>
            <li><span class='sql'>schedule</span>horaires hebdomadaires au format JSON — ex. <code>[{"day":"Mon","start":"09:00","end":"10:30"}]</code></li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>enrollments</span> - inscriptions des étudiants aux groupes de cours.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>student_id</span>identifiant de l'étudiant (FK)</li>
            <li><span class='sql'>section_id</span>identifiant du groupe (FK)</li>
            <li><span class='sql'>enrolled_at</span>date et heure de l'inscription (TIMESTAMP)</li>
            <li><span class='sql'>status</span>statut d'inscription : Enrolled, Dropped, Completed ou Withdrawn (ENUM)</li>
            <li><span class='sql'>grade</span>note finale en lettre (CHAR)</li>
            <li><span class='sql'>final_score</span>score numérique calculé (DECIMAL)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>student_scholarships</span> - bourses attribuées aux étudiants.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identifiant de l'étudiant (FK)</li>
            <li><span class='sql'>scholarship_id</span>identifiant de la bourse (FK)</li>
            <li><span class='sql'>awarded_date</span>date d'attribution de la bourse</li>
            <li><span class='sql'>amount</span>montant réellement attribué, peut différer du montant de base de la bourse (DECIMAL)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>research_projects</span> - projets de recherche des départements.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>title</span>titre du projet</li>
            <li><span class='sql'>description</span>description du projet (TEXT)</li>
            <li><span class='sql'>department_id</span>identifiant du département (FK)</li>
            <li><span class='sql'>status</span>statut du projet : Proposed, Active, Completed ou Cancelled (ENUM)</li>
            <li><span class='sql'>start_date</span>date de début du projet</li>
            <li><span class='sql'>end_date</span>date de fin du projet (nullable)</li>
            <li><span class='sql'>funding</span>sources de financement au format JSON — ex. <code>[{"source":"NSF","amount":150000}]</code></li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>publications</span> - publications de recherche avec prise en charge de la recherche plein texte.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>title</span>titre de la publication</li>
            <li><span class='sql'>abstract</span>résumé de la publication (MEDIUMTEXT, index FULLTEXT)</li>
            <li><span class='sql'>journal</span>nom du journal ou de la conférence</li>
            <li><span class='sql'>publication_year</span>année de publication (YEAR)</li>
            <li><span class='sql'>doi</span>identifiant numérique d'objet (DOI)</li>
            <li><span class='sql' style="min-width: 11rem;">contribution_type</span>type de contribution — une ou plusieurs valeurs parmi : Theoretical, Experimental, Review, Applied (SET)</li>
            <li><span class='sql'>project_id</span>identifiant du projet de recherche associé (FK, nullable)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>project_members</span> - participation des enseignants et des étudiants aux projets de recherche.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>identifiant du projet de recherche (FK)</li>
            <li><span class='sql'>faculty_id</span>identifiant du membre du corps enseignant (FK, nullable)</li>
            <li><span class='sql'>student_id</span>identifiant de l'étudiant (FK, nullable)</li>
            <li><span class='sql'>role</span>rôle du membre : PI, Co-PI, Researcher ou Assistant (ENUM)</li>
            <li><span class='sql'>join_date</span>date d'intégration du membre au projet</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>grade_events</span> - éléments d'évaluation individuels par inscription (~120 000 lignes).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>identifiant unique de l'enregistrement (BIGINT PK)</li>
            <li><span class='sql'>enrollment_id</span>identifiant de l'inscription (FK)</li>
            <li><span class='sql'>item_name</span>nom de l'élément évalué (ex. 'Midterm Exam')</li>
            <li><span class='sql'>item_type</span>type d'élément : Homework, Quiz, Midterm, Final, Project ou Lab (ENUM)</li>
            <li><span class='sql'>score</span>note obtenue (DECIMAL)</li>
            <li><span class='sql'>max_score</span>note maximale possible (DECIMAL)</li>
            <li><span class='sql'>weight</span>pondération en pourcentage dans la note finale (DECIMAL)</li>
            <li><span class='sql'>grader_id</span>membre du corps enseignant ayant noté l'élément (FK)</li>
            <li><span class='sql'>created_at</span>date et heure d'enregistrement de la note (DATETIME)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>audit_log</span> - historique des modifications généré par déclencheurs (~60 000 lignes).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>identifiant unique de l'enregistrement (BIGINT PK)</li>
            <li><span class='sql'>table_name</span>nom de la table modifiée</li>
            <li><span class='sql'>record_id</span>clé primaire de l'enregistrement modifié (BIGINT)</li>
            <li><span class='sql'>action</span>type de modification : INSERT, UPDATE ou DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>date et heure de la modification (TIMESTAMP)</li>
            <li><span class='sql'>old_values</span>valeurs précédentes des colonnes au format JSON (null pour INSERT)</li>
            <li><span class='sql'>new_values</span>nouvelles valeurs des colonnes au format JSON (null pour DELETE)</li>
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
    <h3>Vues</h3>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_student_gpa</span> - moyenne pondérée par étudiant et par semestre.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identifiant de l'étudiant</li>
            <li><span class='sql'>student_number</span>numéro d'étudiant unique</li>
            <li><span class='sql'>first_name</span>prénom de l'étudiant</li>
            <li><span class='sql'>last_name</span>nom de famille de l'étudiant</li>
            <li><span class='sql'>semester_id</span>identifiant du semestre</li>
            <li><span class='sql'>semester_name</span>nom du semestre</li>
            <li><span class='sql'>semester_gpa</span>moyenne pondérée du semestre</li>
            <li><span class='sql'>credits_earned</span>crédits obtenus au cours du semestre</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_section_roster</span> - étudiants inscrits avec coordonnées par groupe de cours.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identifiant du groupe</li>
            <li><span class='sql'>course_code</span>code du cours</li>
            <li><span class='sql'>course_title</span>intitulé du cours</li>
            <li><span class='sql'>semester_name</span>nom du semestre</li>
            <li><span class='sql'>student_id</span>identifiant de l'étudiant</li>
            <li><span class='sql'>student_number</span>numéro d'étudiant unique</li>
            <li><span class='sql'>first_name</span>prénom de l'étudiant</li>
            <li><span class='sql'>last_name</span>nom de famille de l'étudiant</li>
            <li><span class='sql'>email</span>adresse e-mail de l'étudiant</li>
            <li><span class='sql'>status</span>statut d'inscription</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_course_pass_rate</span> - taux de réussite/échec historique et score moyen par cours.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identifiant du cours</li>
            <li><span class='sql'>code</span>code du cours</li>
            <li><span class='sql'>title</span>intitulé du cours</li>
            <li><span class='sql'>semester_id</span>identifiant du semestre</li>
            <li><span class='sql'>semester_name</span>nom du semestre</li>
            <li><span class='sql'>total_enrolled</span>nombre total d'étudiants inscrits</li>
            <li><span class='sql'>passed</span>nombre d'étudiants ayant réussi</li>
            <li><span class='sql'>pass_rate</span>taux de réussite en pourcentage</li>
            <li><span class='sql'>avg_score</span>score final moyen</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_faculty_workload</span> - groupes enseignés et taux de remplissage par enseignant et par semestre.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identifiant du membre du corps enseignant</li>
            <li><span class='sql'>first_name</span>prénom du membre du corps enseignant</li>
            <li><span class='sql'>last_name</span>nom de famille du membre du corps enseignant</li>
            <li><span class='sql'>semester_id</span>identifiant du semestre</li>
            <li><span class='sql'>semester_name</span>nom du semestre</li>
            <li><span class='sql'>sections_taught</span>nombre de groupes enseignés</li>
            <li><span class='sql'>total_capacity</span>capacité totale en places sur tous les groupes</li>
            <li><span class='sql'>total_enrolled</span>nombre total d'étudiants inscrits</li>
            <li><span class='sql'>fill_rate</span>taux de remplissage en pourcentage</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_top_scholars</span> - étudiants classés par montant total de bourses reçues.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>rank_position</span>classement par montant total de bourses</li>
            <li><span class='sql'>student_id</span>identifiant de l'étudiant</li>
            <li><span class='sql'>student_number</span>numéro d'étudiant unique</li>
            <li><span class='sql'>first_name</span>prénom de l'étudiant</li>
            <li><span class='sql'>last_name</span>nom de famille de l'étudiant</li>
            <li><span class='sql'>total_scholarships</span>nombre de bourses attribuées</li>
            <li><span class='sql'>total_amount</span>montant total de financement par bourses reçu</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_publication_stats</span> - nombre d'articles par département et par année.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identifiant du département</li>
            <li><span class='sql'>department_name</span>nom du département</li>
            <li><span class='sql'>publication_year</span>année de publication</li>
            <li><span class='sql'>paper_count</span>nombre d'articles publiés</li>
            <li><span class='sql'>journal_count</span>nombre de journaux distincts</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_prerequisite_tree</span> - prérequis directs pour chaque cours.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identifiant du cours</li>
            <li><span class='sql'>course_code</span>code du cours</li>
            <li><span class='sql'>course_title</span>intitulé du cours</li>
            <li><span class='sql'>prerequisite_id</span>identifiant du cours prérequis</li>
            <li><span class='sql'>prerequisite_code</span>code du cours prérequis</li>
            <li><span class='sql'>prerequisite_title</span>intitulé du cours prérequis</li>
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
