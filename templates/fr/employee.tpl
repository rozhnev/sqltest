<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de données Employee : structure des tables et vue d'ensemble</h2>
    <p>La base Employee (Firebird) est un jeu de données d'exemple utilisé pour apprendre SQL et explorer les fonctionnalités du SGBD Firebird.</p>
    <p>Cette page décrit la structure des tables, les colonnes clés et les relations utiles pour des requêtes SQL pratiques.</p>
    <p>La base de données Employee contient 9 tables principales.</p>
    <p>
        <a href="/{$Lang}/erd/Employee" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Ouvrir le diagramme ER de la base Employee dans une nouvelle fenêtre">
            <img src="/images/erd_small_light.svg" alt="Schéma ER de la base Employee montrant les relations entre les tables" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Schéma ER de la base Employee
        </a>
    </p>
    <h3>Liste des tables</h3>

    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>COUNTRY</span> - table des pays.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Nom du pays</li>
            <li><span class='sql'>CURRENCY</span>Devise utilisée dans le pays</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">CURRENCY</th>
                </tr></thead><tbody><tr>
                    <td>USA</td>
                    <td>Dollar</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>JOB</span> - grille des postes de l'entreprise.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>Code du poste</li>
            <li><span class='sql'>JOB_GRADE</span>Niveau du poste</li>
            <li><span class='sql'>JOB_COUNTRY</span>Pays associé au poste</li>
            <li><span class='sql'>JOB_TITLE</span>Intitulé du poste</li>
            <li><span class='sql'>MIN_SALARY</span>Salaire minimum pour le poste</li>
            <li><span class='sql'>MAX_SALARY</span>Salaire maximum pour le poste</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>Exigences du poste</li>
            <li><span class='sql'>LANGUAGE_REQ</span>Exigences linguistiques</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">JOB_CODE</th>
                    <th scope="col">JOB_GRADE</th>
                    <th scope="col">JOB_COUNTRY</th>
                    <th scope="col">JOB_TITLE</th>
                    <th scope="col">MIN_SALARY</th>
                    <th scope="col">MAX_SALARY</th>
                    <th scope="col">JOB_REQUIREMENT</th>
                    <th scope="col">LANGUAGE_REQ</th>
                </tr></thead><tbody><tr>
                    <td>CEO</td>
                    <td>1</td>
                    <td>USA</td>
                    <td>Chief Executive Officer</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>Pas d'exigences spécifiques.</td>
                    <td>[null]</td>
                </tr></tbody></table>
        </div>    
        <ul class="table-columns">
            <li>FOREIGN KEY (JOB_COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>DEPARTMENT</span> - divisions de l'entreprise.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Numéro du département</li>
            <li><span class='sql'>DEPARTMENT</span>Nom du département</li>
            <li><span class='sql'>HEAD_DEPT</span>Département parent (peut être null)</li>
            <li><span class='sql'>MNGR_NO</span>Numéro du manager</li>
            <li><span class='sql'>BUDGET</span>Budget du département</li>
            <li><span class='sql'>LOCATION</span>Localisation du département</li>
            <li><span class='sql'>PHONE_NO</span>Numéro de téléphone du département</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">DEPARTMENT</th>
                    <th scope="col">HEAD_DEPT</th>
                    <th scope="col">MNGR_NO</th>
                    <th scope="col">BUDGET</th>
                    <th scope="col">LOCATION</th>
                    <th scope="col">PHONE_NO</th>
                </tr></thead><tbody><tr>
                    <td>000</td>
                    <td>Corporate Office</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (HEAD_DEPT) REFERENCES DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>EMPLOYEE</span> - liste des employés.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Numéro de l'employé</li>
            <li><span class='sql'>FIRST_NAME</span>Prénom de l'employé</li>
            <li><span class='sql'>LAST_NAME</span>Nom de famille de l'employé</li>
            <li><span class='sql'>PHONE_EXT</span>Poste téléphonique de l'employé</li>
            <li><span class='sql'>HIRE_DATE</span>Date d'embauche de l'employé</li>
            <li><span class='sql'>DEPT_NO</span>Numéro du département</li>
            <li><span class='sql'>JOB_CODE</span>Code du poste de l'employé</li>
            <li><span class='sql'>JOB_GRADE</span>Niveau du poste de l'employé</li>
            <li><span class='sql'>JOB_COUNTRY</span>Pays associé au poste de l'employé</li>
            <li><span class='sql'>SALARY</span>Salaire de l'employé</li>
            <li><span class='sql'>FULL_NAME</span>Nom complet de l'employé</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">FIRST_NAME</th>
                    <th scope="col">LAST_NAME</th>
                    <th scope="col">PHONE_EXT</th>
                    <th scope="col">HIRE_DATE</th>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">JOB_CODE</th>
                    <th scope="col">JOB_GRADE</th>
                    <th scope="col">JOB_COUNTRY</th>
                    <th scope="col">SALARY</th>
                    <th scope="col">FULL_NAME</th>
                </tr></thead><tbody><tr>
                    <td>2</td>
                    <td>Robert</td>
                    <td>Nelson</td>
                    <td>250</td>
                    <td>1988-12-28 00:00:00</td>
                    <td>600</td>
                    <td>VP</td>
                    <td>2</td>
                    <td>USA</td>
                    <td>105900.00</td>
                    <td>Nelson, Robert</td>
                </tr></tbody></table>
        </div>    
        <ul class="table-columns">
            <li>FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)</li>
            <li>FOREIGN KEY (JOB_CODE) REFERENCES JOB(JOB_CODE)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>PROJECT</span> - liste des projets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>ID du projet</li>
            <li><span class='sql'>PROJ_NAME</span>Nom du projet</li>
            <li><span class='sql'>PROJ_DESC</span>Description du projet</li>
            <li><span class='sql'>TEAM_LEADER</span>Chef d'équipe pour le projet</li>
            <li><span class='sql'>PRODUCT</span>Produit associé au projet</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">PROJ_ID</th>
                    <th scope="col">PROJ_NAME</th>
                    <th scope="col">PROJ_DESC</th>
                    <th scope="col">TEAM_LEADER</th>
                    <th scope="col">PRODUCT</th>
                </tr></thead><tbody><tr>
                    <td>VBASE</td>
                    <td>Video Database</td>
                    <td>Développement d'un système de gestion de base de données vidéo pour gérer la distribution vidéo à la demande.</td>
                    <td>45</td>
                    <td>software</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (TEAM_LEADER) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - affectation des employés aux projets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Numéro de l'employé</li>
            <li><span class='sql'>PROJ_ID</span>ID du projet</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">PROJ_ID</th>
                </tr></thead><tbody><tr>
                    <td>144</td>
                    <td>DGPII</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)</li>
            <li>FOREIGN KEY (PROJ_ID) REFERENCES PROJECT(PROJ_ID)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - budgets des projets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>FISCAL_YEAR</span>Année fiscale</li>
            <li><span class='sql'>PROJ_ID</span>ID du projet</li>
            <li><span class='sql'>DEPT_NO</span>Numéro du département</li>
            <li><span class='sql'>QUART_HEAD_CNT</span>Effectif trimestriel (peut être null)</li>
            <li><span class='sql'>PROJECTED_BUDGET</span>Budget prévisionnel pour l'année fiscale</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">FISCAL_YEAR</th>
                    <th scope="col">PROJ_ID</th>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">QUART_HEAD_CNT</th>
                    <th scope="col">PROJECTED_BUDGET</th>
                </tr></thead><tbody><tr>
                    <td>1994</td>
                    <td>GUIDE</td>
                    <td>100</td>
                    <td>[null]</td>
                    <td>200000.00</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (PROJ_ID) REFERENCES PROJECT(PROJ_ID)</li>
            <li>FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>SALARY_HISTORY</span> - historique des changements de salaire des employés.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Numéro de l'employé</li>
            <li><span class='sql'>CHANGE_DATE</span>Date du changement de salaire</li>
            <li><span class='sql'>UPDATER_ID</span>Identifiant de la personne effectuant la mise à jour</li>
            <li><span class='sql'>OLD_SALARY</span>Salaire précédent</li>
            <li><span class='sql'>PERCENT_CHANGE</span>Pourcentage de changement de salaire</li>
            <li><span class='sql'>NEW_SALARY</span>Nouveau salaire après le changement</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">CHANGE_DATE</th>
                    <th scope="col">UPDATER_ID</th>
                    <th scope="col">OLD_SALARY</th>
                    <th scope="col">PERCENT_CHANGE</th>
                    <th scope="col">NEW_SALARY</th>
                </tr></thead><tbody><tr>
                    <td>28</td>
                    <td>1992-12-15 00:00:00</td>
                    <td>admin2</td>
                    <td>20000.00</td>
                    <td>10.000000</td>
                    <td>22000.000000</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>CUSTOMER</span> - clients de l'entreprise.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>CUST_NO</span>Numéro du client</li>
            <li><span class='sql'>CUSTOMER</span>Nom du client</li>
            <li><span class='sql'>CONTACT_FIRST</span>Prénom de la personne de contact</li>
            <li><span class='sql'>CONTACT_LAST</span>Nom de famille de la personne de contact</li>
            <li><span class='sql'>PHONE_NO</span>Numéro de téléphone du client</li>
            <li><span class='sql'>ADDRESS_LINE1</span> Adresse ligne 1</li>
            <li><span class='sql'>ADDRESS_LINE2</span>Adresse ligne 2 (peut être null)</li>
            <li><span class='sql'>CITY</span>Ville du client</li>
            <li><span class='sql'>STATE_PROVINCE</span>État ou province du client</li>
            <li><span class='sql'>COUNTRY</span>Pays du client</li>
            <li><span class='sql'>POSTAL_CODE</span>Code postal du client</li>
            <li><span class='sql'>ON_HOLD</span>Statut "en attente" (peut être null)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">CUSTOMER</th>
                    <th scope="col">CONTACT_FIRST</th>
                    <th scope="col">CONTACT_LAST</th>
                    <th scope="col">PHONE_NO</th>
                    <th scope="col">ADDRESS_LINE1</th>
                    <th scope="col">ADDRESS_LINE2</th>
                    <th scope="col">CITY</th>
                    <th scope="col">STATE_PROVINCE</th>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">POSTAL_CODE</th>
                    <th scope="col">ON_HOLD</th>
                </tr></thead><tbody><tr>
                    <td>1001</td>
                    <td>Signature Design</td>
                    <td>Dale J.</td>
                    <td>Little</td>
                    <td>(619) 530-2710</td>
                    <td>15500 Pacific Heights Blvd.</td>
                    <td>[null]</td>
                    <td>San Diego</td>
                    <td>CA</td>
                    <td>USA</td>
                    <td>92121</td>
                    <td>[null]</td>
                </tr></tbody></table>
        </div>    
        <ul class="table-columns">
            <li>FOREIGN KEY (COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
    <span><span class='sql'>SALES</span> - liste des ventes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PO_NUMBER</span>Numéro du bon de commande</li>
            <li><span class='sql'>CUST_NO</span>Numéro du client associé à la commande</li>
            <li><span class='sql'>SALES_REP</span>Numéro du représentant commercial</li>
            <li><span class='sql'>ORDER_STATUS</span>Statut de la commande</li>
            <li><span class='sql'>ORDER_DATE</span>Date de la commande</li>
            <li><span class='sql'>SHIP_DATE</span>Date d'expédition</li>
            <li><span class='sql'>DATE_NEEDED</span>Date limite souhaitée (peut être null)</li>
            <li><span class='sql'>PAID</span>Statut de paiement</li>
            <li><span class='sql'>QTY_ORDERED</span>Quantité commandée</li>
            <li><span class='sql'>TOTAL_VALUE</span>Valeur totale de la commande</li>
            <li><span class='sql'>DISCOUNT</span>Remise appliquée</li>
            <li><span class='sql'>ITEM_TYPE</span>Type d'article dans la commande</li>
            <li><span class='sql'>AGED</span>Valeur d'ancienneté</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">PO_NUMBER</th>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">SALES_REP</th>
                    <th scope="col">ORDER_STATUS</th>
                    <th scope="col">ORDER_DATE</th>
                    <th scope="col">SHIP_DATE</th>
                    <th scope="col">DATE_NEEDED</th>
                    <th scope="col">PAID</th>
                    <th scope="col">QTY_ORDERED</th>
                    <th scope="col">TOTAL_VALUE</th>
                    <th scope="col">DISCOUNT</th>
                    <th scope="col">ITEM_TYPE</th>
                    <th scope="col">AGED</th>
                </tr></thead><tbody><tr>
                    <td>V91E0210</td>
                    <td>1004</td>
                    <td>11</td>
                    <td>shipped</td>
                    <td>1991-03-04 00:00:00</td>
                    <td>1991-03-05 00:00:00</td>
                    <td>[null]</td>
                    <td>y</td>
                    <td>10</td>
                    <td>5000.00</td>
                    <td>0.100000</td>
                    <td>hardware</td>
                    <td>1.000000000</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (CUST_NO) REFERENCES CUSTOMER(CUST_NO)</li>
            <li>FOREIGN KEY (SALES_REP) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <h3>Voici la liste des vues de cette base de données :</h3>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la vue dans l'éditeur">
        <span><span class='sql'>PHONE_LIST</span> - vue de la liste téléphonique des employés.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Numéro de l'employé</li>
            <li><span class='sql'>FIRST_NAME</span>Prénom de l'employé</li>
            <li><span class='sql'>LAST_NAME</span>Nom de famille de l'employé</li>
            <li><span class='sql'>PHONE_EXT</span>Poste téléphonique de l'employé</li>
            <li><span class='sql'>LOCATION</span>Emplacement du département</li>
            <li><span class='sql'>PHONE_NO</span>Numéro de téléphone du département</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">FIRST_NAME</th>
                    <th scope="col">LAST_NAME</th>
                    <th scope="col">PHONE_EXT</th>
                    <th scope="col">LOCATION</th>
                    <th scope="col">PHONE_NO</th>
                </tr></thead><tbody><tr>
                    <td>2</td>
                    <td>Robert</td>
                    <td>Nelson</td>
                    <td>250</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
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
