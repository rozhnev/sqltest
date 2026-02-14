<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>Base de données Sakila</h2>
    Sakila est une base de données d'exemple conçue par MySQL, spécifiquement créée pour l'apprentissage et la démonstration des capacités des systèmes de gestion de bases de données relationnelles (SGBDR).
    <p>
        <a class="button-erd" href="/{$Lang}/erd/Sakila" target="ERDWindow">
            Schéma ER de la base de données Sakila
        </a>
    </p>
    <p>La base de données Sakila contient 15 tables principales décrivant divers aspects d'une entreprise de location de DVD.</p>
    <h3>Liste des tables :</h3>
    <div class="accordion">
        <span><span class='sql'>actor</span> - table des acteurs.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>first_name</span>prénom de l'acteur</li>
            <li> <span class='sql'>last_name</span>nom de famille de l'acteur</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>actor_id</th>
                <th>first_name</th>
                <th>last_name</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (actor_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>address</span> - adresses des clients et du personnel.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>address_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>address</span>adresse postale</li>
            <li> <span class='sql'>address2</span>adresse complémentaire</li>
            <li> <span class='sql'>district</span>district ou région</li>
            <li> <span class='sql'>city_id</span>identifiant de la ville (FK)</li>
            <li> <span class='sql'>postal_code</span>code postal</li>
            <li> <span class='sql'>phone</span>numéro de téléphone</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>address_id</th>
                <th>address</th>
                <th>address2</th>
                <th>district</th>
                <th>city_id</th>
                <th>postal_code</th>
                <th>phone</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>123 Main St</td>
                <td>[null]</td>
                <td>Downtown</td>
                <td>1</td>
                <td>12345</td>
                <td>+1234567890</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (address_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>category</span> - catégories de films.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>category_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>name</span>nom de la catégorie</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>category_id</th>
                <th>name</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>Action</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (category_id)</li>
        </ul>    
    </div>
    <div class="accordion">
        <span class='sql'>city</span> - table des villes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>city_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>city</span>nom de la ville</li>
            <li> <span class='sql'>country_id</span>identifiant du pays (FK)</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>city_id</th>
                <th>city</th>
                <th>country_id</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>Metropolis</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (city_id)</li>
        </ul>
    </div>    
    <div class="accordion">
        <span class='sql'>country</span> - table des pays.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>country_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>country</span>nom du pays</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>country_id</th>
                <th>country</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>United States</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (country_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>customer</span> - table des clients.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>store_id</span>identifiant du magasin (FK)</li>
            <li> <span class='sql'>first_name</span>prénom du client</li>
            <li> <span class='sql'>last_name</span>nom de famille du client</li>
            <li> <span class='sql'>email</span>adresse e-mail du client</li>
            <li> <span class='sql'>address_id</span>identifiant de l'adresse (FK)</li>
            <li> <span class='sql'>active</span>indicateur d'activité du client (0/1)</li>
            <li> <span class='sql'>create_date</span>date et heure d'ajout du client dans la base</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>customer_id</th>
                <th>store_id</th>
                <th>first_name</th>
                <th>last_name</th>
                <th>email</th>
                <th>address_id</th>
                <th>active</th>
                <th>create_date</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>john.doe@example.com</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
          </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (customer_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>film</span> - liste des films dans la base de données.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 13rem;">film_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql' style="min-width: 13rem;">title</span>titre du film</li>
            <li> <span class='sql' style="min-width: 13rem;">description</span>brève description ou synopsis du film</li>
            <li> <span class='sql' style="min-width: 13rem;">release_year</span>année de sortie du film</li>
            <li> <span class='sql' style="min-width: 13rem;">language_id</span>identifiant de la langue du film (FK)</li>
            <li> <span class='sql' style="min-width: 13rem;">original_language_id</span>identifiant de la langue d'origine au cas où le film serait doublé</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_duration</span>durée de location en jours</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_rate</span>coût de location du film pour la durée spécifiée dans la colonne rental_duration</li>
            <li> <span class='sql' style="min-width: 13rem;">length</span>durée du film en minutes</li>
            <li> <span class='sql' style="min-width: 13rem;">replacement_cost</span>montant de la pénalité en cas de perte ou de dégradation du disque</li>
            <li> <span class='sql' style="min-width: 13rem;">rating</span>classement (rating) attribué au film. Peut être : G, PG, PG-13, R, ou NC-17</li>
            <li> <span class='sql' style="min-width: 13rem;">special_features</span>liste des bonus inclus sur le DVD. Peut inclure : Trailers, Commentaries, Deleted Scenes, Behind the Scenes</li>
            <li> <span class='sql' style="min-width: 13rem;">last_update</span>date et heure de la dernière mise à jour</li>
          </ul>
          <div class="table-wrapper">
            <table>
              <tr>
                <th>film_id</th>
                <th>title</th>
                <th>description</th>
                <th>release_year</th>
                <th>language_id</th>
                <th>original_language_id</th>
                <th>rental_duration</th>
                <th>rental_rate</th>
                <th>length</th>
                <th>replacement_cost</th>
                <th>rating</th>
                <th>special_features</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>Titre du Film</td>
                <td>Une brève description du film.</td>
                <td>2000</td>
                <td>1</td>
                <td>2</td>
                <td>5</td>
                <td>4.99</td>
                <td>120</td>
                <td>19.99</td>
                <td>PG-13</td>
                <td>Trailers, Commentaries</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
          </div>
          <ul class="table-columns">
            <li>PRIMARY KEY, btree (film_id)</li>
          </ul>
    </div>
    <div class="accordion">
        <span class='sql'>film_actor</span> - relation entre acteurs et films.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identifiant de l'acteur (FK)</li>
            <li> <span class='sql'>film_id</span>identifiant du film (FK)</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
          </ul>
          <div class="table-wrapper">
            <table>
              <tr>
                <th>actor_id</th>
                <th>film_id</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
          </div>
          <ul class="table-columns">
            <li>PRIMARY KEY, btree (actor_id, film_id)</li>
          </ul>      
    </div>
    <div class="accordion">
        <span class='sql'>film_category</span> - relation entre films et catégories.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>film_id</span>identifiant de chaque film (FK)</li>
            <li> <span class='sql'>category_id</span>identifiant de chaque catégorie (FK)</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
          </ul>
          <div class="table-wrapper">
            <table>
              <tr>
                <th>film_id</th>
                <th>category_id</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
          </div>
          <ul class="table-columns">
              <li>PRIMARY KEY, btree (film_id, category_id)</li>
          </ul>    
    </div>
    <div class="accordion">
        <span class='sql'>inventory</span> - exemplaires (stocks) dans la base de données.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>inventory_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li><span class='sql'>film_id</span>identifiant du film (FK)</li>
            <li><span class='sql'>store_id</span>identifiant du magasin où se trouve l'exemplaire (FK)</li>
            <li><span class='sql'>last_update</span>date et heure de la dernière mise à jour</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>inventory_id</th>
                    <th>film_id</th>
                    <th>store_id</th>
                    <th>last_update</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>23</td>
                    <td>2</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (inventory_id)</li>
        </ul>        
    </div>
    <div class="accordion">
        <span class='sql'>language</span> - langues des films.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>language_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>name</span>nom de la langue</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>language_id</th>
                    <th>name</th>
                    <th>last_update</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>English</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (language_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>payment</span> - paiements des clients.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">payment_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql' style="min-width: 8rem;">customer_id</span>identifiant du client (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">staff_id</span>identifiant du membre du personnel qui a reçu le paiement (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">rental_id</span>identifiant de l'enregistrement de location (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">amount</span>montant du paiement</li>
            <li> <span class='sql' style="min-width: 8rem;">payment_date</span>date et heure du paiement</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>date et heure de la dernière mise à jour</li>
        </ul>
        <div class="table-wrapper">
        <table>
            <tr>
                <th>payment_id</th>
                <th>customer_id</th>
                <th>staff_id</th>
                <th>rental_id</th>
                <th>amount</th>
                <th>payment_date</th>
                <th>last_update</th>
            </tr>
            <tr>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>4.99</td>
                <td>2023-01-01 12:13:14</td>
                <td>2023-01-01 12:14:15</td>
            </tr>
        </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (payment_id)</li>
        </ul>      
    </div>
    <div class="accordion">
        <span class='sql'>rental</span> - locations des clients.
    </div>
    <div class="panel">
        <ul class="table-columns">
        <li> <span class='sql'>rental_id</span>identifiant unique de l'enregistrement (PK)</li>
        <li> <span class='sql'>rental_date</span>date de début de location</li>
        <li> <span class='sql'>inventory_id</span>identifiant du disque (FK)</li>
        <li> <span class='sql'>customer_id</span>identifiant du client (FK)</li>
        <li> <span class='sql'>return_date</span>date de retour du film</li>
        <li> <span class='sql'>staff_id</span>id du membre du personnel ayant émis le disque (FK)</li>
        <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
        <table>
            <tr>
                <th>rental_id</th>
                <th>rental_date</th>
                <th>inventory_id</th>
                <th>customer_id</th>
                <th>return_date</th>
                <th>staff_id</th>
                <th>last_update</th>
            </tr>
            <tr>
                <td>1</td>
                <td>2023-01-01 16:15:21</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-10 09:12:36</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
            </tr>
        </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (rental_id)</li>
        </ul>    
    </div>
    <div class="accordion">
        <span class='sql'>staff</span> - personnel de l'entreprise.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>staff_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql'>first_name</span>prénom du membre du personnel</li>
            <li> <span class='sql'>last_name</span>nom de famille du membre du personnel</li>
            <li> <span class='sql'>address_id</span>identifiant de l'adresse (FK)</li>
            <li> <span class='sql'>picture</span>photo du membre du personnel</li>
            <li> <span class='sql'>email</span>adresse e-mail du membre du personnel</li>
            <li> <span class='sql'>store_id</span>clé étrangère référençant la table des magasins (FK)</li>
            <li> <span class='sql'>active</span>indicateur d'activité du membre du personnel (0/1)</li>
            <li> <span class='sql'>username</span>nom d'utilisateur pour la connexion au système</li>
            <li> <span class='sql'>password</span>mot de passe pour la connexion</li>
            <li> <span class='sql'>last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
        <table>
            <tr>
                <th>staff_id</th>
                <th>first_name</th>
                <th>last_name</th>
                <th>address_id</th>
                <th>picture</th>
                <th>email</th>
                <th>store_id</th>
                <th>active</th>
                <th>username</th>
                <th>password</th>
                <th>last_update</th>
            </tr>
            <tr>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>1</td>
                <td>[null]</td>
                <td>john.doe@example.com</td>
                <td>1</td>
                <td>1</td>
                <td>johndoe</td>
                <td>********</td>
                <td>2023-01-01 12:00:00</td>
            </tr>
        </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (staff_id)</li>
        </ul>        
    </div>
    <div class="accordion">
        <span class='sql'>store</span> - magasins de l'entreprise.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 11rem;">store_id</span>identifiant unique de l'enregistrement (PK)</li>
            <li> <span class='sql' style="min-width: 11rem;">manager_staff_id</span>identifiant du gérant du magasin (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">address_id</span>identifiant de l'adresse (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">last_update</span>date et heure de la dernière mise à jour</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                  <th>store_id</th>
                  <th>manager_staff_id</th>
                  <th>address_id</th>
                  <th>last_update</th>
              </tr>
              <tr>
                  <td>1</td>
                  <td>1</td>
                  <td>1</td>
                  <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (store_id)</li>
        </ul>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div>
    {/if}
</div>
