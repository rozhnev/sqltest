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
            <li><span class='sql'>semester_id</span>identifiant unique de l'enregistrement (PK, TINYINT)</li>
            <li><span class='sql'>term</span>type de période : Fall, Spring ou Summer (ENUM)</li>
            <li><span class='sql'>academic_year</span>année académique (type YEAR)</li>
            <li><span class='sql'>name</span>nom du semestre (ex. 'Fall 2024')</li>
            <li><span class='sql'>start_date</span>premier jour du semestre</li>
            <li><span class='sql'>end_date</span>dernier jour du semestre</li>
            <li><span class='sql'>enroll_deadline</span>dernière date pour l'inscription des étudiants</li>
            <li><span class='sql'>is_active</span>indique si le semestre est actuellement en cours (BOOLEAN)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>rooms</span> - salles de cours et laboratoires du campus.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>identifiant unique de l'enregistrement (PK, SMALLINT)</li>
            <li><span class='sql'>building</span>nom du bâtiment</li>
            <li><span class='sql'>room_number</span>numéro ou étiquette de la salle</li>
            <li><span class='sql'>capacity</span>nombre maximum de places (SMALLINT)</li>
            <li><span class='sql'>room_type</span>type de salle : lecture, seminar, lab, computer_lab ou online (ENUM)</li>
            <li><span class='sql'>has_projector</span>indique si la salle est équipée d'un projecteur (BOOLEAN)</li>
            <li><span class='sql'>has_video</span>indique si la salle est équipée d'un système de vidéoconférence (BOOLEAN)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>scholarships</span> - bourses disponibles.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>identifiant unique de l'enregistrement (PK, SMALLINT)</li>
            <li><span class='sql'>name</span>nom de la bourse</li>
            <li><span class='sql'>amount</span>montant de la récompense (DECIMAL)</li>
            <li><span class='sql'>frequency</span>fréquence d'attribution : one-time, annual ou per-semester (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>critères d'éligibilité au format JSON — ex. <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
            <li><span class='sql'>is_active</span>indique si la bourse est actuellement proposée (BOOLEAN)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>departments</span> - hiérarchie de départements à trois niveaux (Faculté → Département → Sous-département).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identifiant unique de l'enregistrement (PK, TINYINT)</li>
            <li><span class='sql'>parent_id</span>identifiant du département parent — FK auto-référençante (nullable)</li>
            <li><span class='sql'>code</span>code court du département (CHAR)</li>
            <li><span class='sql'>name</span>nom du département</li>
            <li><span class='sql'>level</span>niveau hiérarchique : 1 = Faculté, 2 = Département, 3 = Sous-département (TINYINT)</li>
            <li><span class='sql'>head_faculty_id</span>identifiant du responsable du département (FK, nullable)</li>
            <li><span class='sql'>established</span>année de création du département (YEAR, nullable)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>faculty</span> - membres du corps enseignant de l'université.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>identifiant unique de l'enregistrement (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identifiant du département (FK)</li>
            <li><span class='sql'>first_name</span>prénom du membre du corps enseignant</li>
            <li><span class='sql'>last_name</span>nom de famille du membre du corps enseignant</li>
            <li><span class='sql'>email</span>adresse e-mail institutionnelle</li>
            <li><span class='sql'>phone</span>numéro de téléphone du bureau (nullable)</li>
            <li><span class='sql'>rank</span>rang académique : Instructor, Assistant Professor, Associate Professor, Professor ou Emeritus (ENUM)</li>
            <li><span class='sql'>hire_date</span>date d'embauche</li>
            <li><span class='sql'>office</span>numéro de bureau ou emplacement (nullable)</li>
            <li><span class='sql'>office_hours</span>heures de permanence hebdomadaires au format tableau JSON — ex. <code>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</code></li>
            <li><span class='sql'>bio</span>texte biographique (TEXT, nullable)</li>
            <li><span class='sql'>is_active</span>indique si le membre du corps enseignant est actuellement en activité (BOOLEAN)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>students</span> - étudiants inscrits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>identifiant unique de l'enregistrement (PK, INT)</li>
            <li><span class='sql'>department_id</span>identifiant du département d'appartenance (FK)</li>
            <li><span class='sql'>student_number</span>numéro d'étudiant unique (CHAR, ex. 'S000123')</li>
            <li><span class='sql'>first_name</span>prénom de l'étudiant</li>
            <li><span class='sql'>last_name</span>nom de famille de l'étudiant</li>
            <li><span class='sql'>email</span>adresse e-mail de l'étudiant</li>
            <li><span class='sql'>date_of_birth</span>date de naissance de l'étudiant</li>
            <li><span class='sql'>gender</span>genre : M, F, NB, Other ou Prefer not to say (ENUM, nullable)</li>
            <li><span class='sql'>enrollment_date</span>date de la première inscription de l'étudiant</li>
            <li><span class='sql'>expected_grad</span>année de diplôme prévue (YEAR, nullable)</li>
            <li><span class='sql'>status</span>statut d'inscription : active, inactive, graduated, suspended ou withdrawn (ENUM)</li>
            <li><span class='sql'>gpa</span>moyenne générale cumulative 0,000–4,000, maintenue par déclencheur (DECIMAL, nullable)</li>
            <li><span class='sql'>contacts</span>contact d'urgence et adresse au format JSON — ex. <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>courses</span> - catalogue des cours avec prise en charge de la recherche plein texte et vectorielle.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identifiant unique de l'enregistrement (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identifiant du département propriétaire (FK)</li>
            <li><span class='sql'>code</span>code du cours, ex. 'CS101' (CHAR)</li>
            <li><span class='sql'>title</span>intitulé du cours</li>
            <li><span class='sql'>credits</span>nombre de crédits (TINYINT)</li>
            <li><span class='sql'>level</span>niveau académique : undergraduate, graduate ou doctoral (ENUM)</li>
            <li><span class='sql'>description</span>description détaillée du cours (TEXT, index FULLTEXT avec title)</li>
            <li><span class='sql'>is_active</span>indique si le cours est actuellement proposé (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>embedding sémantique de 1536 dimensions pour la recherche par similarité vectorielle (VECTOR(1536), nullable)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>course_prerequisites</span> - relations de prérequis entre cours (many-to-many auto-référençante).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>identifiant du cours (FK)</li>
            <li><span class='sql'>prerequisite_id</span>identifiant du cours prérequis obligatoire (FK)</li>
            <li><span class='sql'>is_mandatory</span>indique si le prérequis est obligatoire ou recommandé (BOOLEAN)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>sections</span> - groupes de cours (une offre spécifique d'un cours au cours d'un semestre).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>identifiant unique de l'enregistrement (PK, INT)</li>
            <li><span class='sql'>course_id</span>identifiant du cours (FK)</li>
            <li><span class='sql'>semester_id</span>identifiant du semestre (FK)</li>
            <li><span class='sql'>faculty_id</span>identifiant de l'enseignant (FK)</li>
            <li><span class='sql'>room_id</span>identifiant de la salle attribuée (FK, nullable — NULL pour les cours entièrement en ligne)</li>
            <li><span class='sql'>section_number</span>numéro du groupe au sein du cours et du semestre (TINYINT)</li>
            <li><span class='sql'>delivery</span>mode d'enseignement : in-person, online ou hybrid (ENUM)</li>
            <li><span class='sql'>max_capacity</span>nombre maximum d'inscriptions (SMALLINT)</li>
            <li><span class='sql'>status</span>statut du groupe : open, closed, cancelled ou completed (ENUM)</li>
            <li><span class='sql'>schedule</span>horaires hebdomadaires au format JSON — ex. <code>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim}]</code></li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>enrollments</span> - inscriptions des étudiants aux groupes de cours.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>identifiant unique de l'enregistrement (PK, INT)</li>
            <li><span class='sql'>student_id</span>identifiant de l'étudiant (FK)</li>
            <li><span class='sql'>section_id</span>identifiant du groupe (FK)</li>
            <li><span class='sql'>enrolled_at</span>date et heure de l'inscription (TIMESTAMP)</li>
            <li><span class='sql'>status</span>statut d'inscription : enrolled, dropped, completed, failed ou incomplete (ENUM)</li>
            <li><span class='sql'>final_grade</span>note finale en lettre, ex. 'A', 'B+' (CHAR, nullable)</li>
            <li><span class='sql'>final_score</span>score numérique final 0,00–100,00 (DECIMAL, nullable)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>student_scholarships</span> - bourses attribuées aux étudiants.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>award_id</span>identifiant unique de l'enregistrement (PK, INT)</li>
            <li><span class='sql'>student_id</span>identifiant de l'étudiant (FK)</li>
            <li><span class='sql'>scholarship_id</span>identifiant de la bourse (FK)</li>
            <li><span class='sql'>awarded_date</span>date d'attribution de la bourse</li>
            <li><span class='sql'>expires_date</span>date d'expiration de la récompense (nullable)</li>
            <li><span class='sql'>amount_awarded</span>montant réellement attribué (DECIMAL)</li>
            <li><span class='sql'>notes</span>notes supplémentaires sur la récompense (TEXT, nullable)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>research_projects</span> - projets de recherche des départements.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>identifiant unique de l'enregistrement (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>identifiant du département (FK)</li>
            <li><span class='sql'>lead_faculty_id</span>investigateur principal (FK)</li>
            <li><span class='sql'>title</span>titre du projet</li>
            <li><span class='sql'>abstract</span>description du projet (TEXT, nullable)</li>
            <li><span class='sql'>start_date</span>date de début du projet</li>
            <li><span class='sql'>end_date</span>date de fin du projet (nullable)</li>
            <li><span class='sql'>status</span>statut du projet : proposed, active, completed ou cancelled (ENUM)</li>
            <li><span class='sql'>funding</span>sources de financement au format JSON — ex. <code>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2024-001"{rdelim}]</code></li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>publications</span> - publications de recherche avec prise en charge de la recherche plein texte.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>identifiant unique de l'enregistrement (PK, INT)</li>
            <li><span class='sql'>project_id</span>projet de recherche associé (FK, nullable)</li>
            <li><span class='sql'>title</span>titre de la publication</li>
            <li><span class='sql'>abstract</span>résumé de la publication (MEDIUMTEXT, index FULLTEXT avec title)</li>
            <li><span class='sql'>pub_year</span>année de publication (YEAR)</li>
            <li><span class='sql'>venue</span>nom du journal ou de la conférence (nullable)</li>
            <li><span class='sql'>doi</span>identifiant numérique d'objet DOI (nullable)</li>
            <li><span class='sql' style="min-width: 9rem;">keywords</span>mots-clés — une ou plusieurs valeurs parmi : AI, ML, Data Science, Networking, Security, Algorithms, Databases, HCI, Theory, Bioinformatics, Systems, Mathematics, Physics, Chemistry, Biology (SET)</li>
            <li><span class='sql'>citation_count</span>nombre de citations reçues (INT)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>project_members</span> - participation des enseignants et des étudiants aux projets de recherche.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>member_id</span>identifiant unique de l'enregistrement (PK, INT)</li>
            <li><span class='sql'>project_id</span>identifiant du projet de recherche (FK)</li>
            <li><span class='sql'>faculty_id</span>identifiant du membre du corps enseignant (FK, nullable)</li>
            <li><span class='sql'>student_id</span>identifiant de l'étudiant (FK, nullable)</li>
            <li><span class='sql'>role</span>rôle du membre : Principal Investigator, Co-Investigator, Research Assistant, Graduate Student ou Undergraduate Student (ENUM)</li>
            <li><span class='sql'>joined_date</span>date d'intégration du membre au projet</li>
            <li><span class='sql'>left_date</span>date de départ du membre du projet (nullable)</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>grade_events</span> - éléments d'évaluation individuels par inscription (~120 000 lignes).</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>identifiant unique de l'enregistrement (PK, BIGINT)</li>
            <li><span class='sql'>enrollment_id</span>identifiant de l'inscription (FK)</li>
            <li><span class='sql'>item_name</span>nom de l'élément évalué, ex. 'Assignment 1', 'Midterm Exam'</li>
            <li><span class='sql'>item_type</span>type d'élément : assignment, quiz, midterm, final, project, participation ou lab (ENUM)</li>
            <li><span class='sql'>score</span>note obtenue (DECIMAL)</li>
            <li><span class='sql'>max_score</span>note maximale possible, défaut 100,00 (DECIMAL)</li>
            <li><span class='sql'>weight</span>fraction de la note finale, ex. 0,1500 pour 15% (DECIMAL)</li>
            <li><span class='sql'>graded_at</span>date et heure d'enregistrement de la note (DATETIME)</li>
            <li><span class='sql'>grader_id</span>membre du corps enseignant ayant noté l'élément (FK, nullable)</li>
            <li><span class='sql'>feedback</span>texte de retour de l'évaluateur (TEXT, nullable)</li>
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
                        <td>Bonne analyse, revoir la section 3.</td>
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
            <li><span class='sql'>log_id</span>identifiant unique de l'enregistrement (PK, BIGINT)</li>
            <li><span class='sql'>table_name</span>nom de la table modifiée</li>
            <li><span class='sql'>record_id</span>clé primaire de l'enregistrement modifié (BIGINT)</li>
            <li><span class='sql'>action</span>type de modification : INSERT, UPDATE ou DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>date et heure de la modification (TIMESTAMP)</li>
            <li><span class='sql'>changed_by</span>utilisateur de la base de données ou contexte applicatif (nullable)</li>
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
            <li><span class='sql'>total_amount</span>montant total de amount_awarded sur toutes les bourses</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue">
        <span><span class='sql'>v_publication_stats</span> - nombre d'articles et citations par département et par année.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>identifiant du département</li>
            <li><span class='sql'>department_name</span>nom du département</li>
            <li><span class='sql'>pub_year</span>année de publication</li>
            <li><span class='sql'>paper_count</span>nombre d'articles publiés</li>
            <li><span class='sql'>total_citations</span>nombre total de citations sur tous les articles</li>
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
            <li><span class='sql'>is_mandatory</span>indique si le prérequis est obligatoire ou recommandé</li>
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
