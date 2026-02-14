<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de données Employee (Firebird)</h2>
    <p>
        Employee est une base de données d'exemple fournie avec le système de gestion de base de données multiplateforme Firebird.
        Vous pouvez utiliser cette base de données pour explorer le SQL Firebird et d'autres fonctionnalités du SGBD.
    </p>
    <h3>Voici la liste des tables de cette base de données :</h3>

    <div class="accordion">
        <span><span class='sql'>COUNTRY</span> - table des pays.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Nom du pays</li>
            <li><span class='sql'>CURRENCY</span>Devise utilisée dans le pays</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>COUNTRY</th>
                    <th>CURRENCY</th>
                </tr>
                <tr>
                    <td>USA</td>
                    <td>Dollar</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>JOB_CODE</th>
                    <th>JOB_GRADE</th>
                    <th>JOB_COUNTRY</th>
                    <th>JOB_TITLE</th>
                    <th>MIN_SALARY</th>
                    <th>MAX_SALARY</th>
                    <th>JOB_REQUIREMENT</th>
                    <th>LANGUAGE_REQ</th>
                </tr>
                <tr>
                    <td>CEO</td>
                    <td>1</td>
                    <td>USA</td>
                    <td>Chief Executive Officer</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>Pas d'exigences spécifiques.</td>
                    <td>[null]</td>
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>DEPT_NO</th>
                    <th>DEPARTMENT</th>
                    <th>HEAD_DEPT</th>
                    <th>MNGR_NO</th>
                    <th>BUDGET</th>
                    <th>LOCATION</th>
                    <th>PHONE_NO</th>
                </tr>
                <tr>
                    <td>000</td>
                    <td>Corporate Office</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>FIRST_NAME</th>
                    <th>LAST_NAME</th>
                    <th>PHONE_EXT</th>
                    <th>HIRE_DATE</th>
                    <th>DEPT_NO</th>
                    <th>JOB_CODE</th>
                    <th>JOB_GRADE</th>
                    <th>JOB_COUNTRY</th>
                    <th>SALARY</th>
                    <th>FULL_NAME</th>
                </tr>
                <tr>
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
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>PROJ_ID</th>
                    <th>PROJ_NAME</th>
                    <th>PROJ_DESC</th>
                    <th>TEAM_LEADER</th>
                    <th>PRODUCT</th>
                </tr>
                <tr>
                    <td>VBASE</td>
                    <td>Video Database</td>
                    <td>Développement d'un système de gestion de base de données vidéo pour gérer la distribution vidéo à la demande.</td>
                    <td>45</td>
                    <td>software</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - affectation des employés aux projets.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Numéro de l'employé</li>
            <li><span class='sql'>PROJ_ID</span>ID du projet</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>PROJ_ID</th>
                </tr>
                <tr>
                    <td>144</td>
                    <td>DGPII</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>FISCAL_YEAR</th>
                    <th>PROJ_ID</th>
                    <th>DEPT_NO</th>
                    <th>QUART_HEAD_CNT</th>
                    <th>PROJECTED_BUDGET</th>
                </tr>
                <tr>
                    <td>1994</td>
                    <td>GUIDE</td>
                    <td>100</td>
                    <td>[null]</td>
                    <td>200000.00</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>CHANGE_DATE</th>
                    <th>UPDATER_ID</th>
                    <th>OLD_SALARY</th>
                    <th>PERCENT_CHANGE</th>
                    <th>NEW_SALARY</th>
                </tr>
                <tr>
                    <td>28</td>
                    <td>1992-12-15 00:00:00</td>
                    <td>admin2</td>
                    <td>20000.00</td>
                    <td>10.000000</td>
                    <td>22000.000000</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>CUST_NO</th>
                    <th>CUSTOMER</th>
                    <th>CONTACT_FIRST</th>
                    <th>CONTACT_LAST</th>
                    <th>PHONE_NO</th>
                    <th>ADDRESS_LINE1</th>
                    <th>ADDRESS_LINE2</th>
                    <th>CITY</th>
                    <th>STATE_PROVINCE</th>
                    <th>COUNTRY</th>
                    <th>POSTAL_CODE</th>
                    <th>ON_HOLD</th>
                </tr>
                <tr>
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
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
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
            <table>
                <tr>
                    <th>PO_NUMBER</th>
                    <th>CUST_NO</th>
                    <th>SALES_REP</th>
                    <th>ORDER_STATUS</th>
                    <th>ORDER_DATE</th>
                    <th>SHIP_DATE</th>
                    <th>DATE_NEEDED</th>
                    <th>PAID</th>
                    <th>QTY_ORDERED</th>
                    <th>TOTAL_VALUE</th>
                    <th>DISCOUNT</th>
                    <th>ITEM_TYPE</th>
                    <th>AGED</th>
                </tr>
                <tr>
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
                </tr>
            </table>
        </div>
    </div>                            
    {if $User->showAd()}
        <div class="referal-add-block">
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div>
    {/if}
</div>
