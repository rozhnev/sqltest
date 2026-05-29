<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>Base de données Sakila : structure et description des tables</h2>
    <p>Sakila est une base de données relationnelle d'exemple conçue par MySQL pour l'apprentissage et la démonstration des capacités SQL et des systèmes de gestion de bases de données (SGBDR).</p>
    <p>Cette page présente la structure des tables Sakila, les colonnes principales et les clés utilisées dans les requêtes SQL pédagogiques.</p>
    <p>La base de données Sakila contient 15 tables principales décrivant divers aspects d'une entreprise de location de DVD.</p>
    <p>
        <a href="/{$Lang}/erd/Sakila" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Ouvrir le schéma ER de la base de données Sakila dans une nouvelle fenêtre">
            <img src="/images/erd_small_light.svg" alt="Schéma ER de la base de données Sakila avec les relations entre les tables" style="width: 90%;" loading="lazy" decoding="async">
            Schéma ER de la base de données Sakila
        </a>
    </p>
    <h3>Liste des tables</h3>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                                <caption>Exemple de structure de la table actor</caption>
                                <thead>
                                    <tr>
                                        <th scope="col">actor_id</th>
                                        <th scope="col">first_name</th>
                                        <th scope="col">last_name</th>
                                        <th scope="col">last_update</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>John</td>
                                        <td>Doe</td>
                                        <td>2023-01-01 12:00:00</td>
                                    </tr>
                                </tbody>
                        </table>
                </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (actor_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">address_id</th>
                <th scope="col">address</th>
                <th scope="col">address2</th>
                <th scope="col">district</th>
                <th scope="col">city_id</th>
                <th scope="col">postal_code</th>
                <th scope="col">phone</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (address_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (city_id) REFERENCES city(city_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">category_id</th>
                <th scope="col">name</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>Action</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (category_id)</li>
        </ul>    
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">city_id</th>
                <th scope="col">city</th>
                <th scope="col">country_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>Metropolis</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (city_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (country_id) REFERENCES country(country_id)</li>
        </ul>
    </div>    
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">country_id</th>
                <th scope="col">country</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>United States</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (country_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">customer_id</th>
                <th scope="col">store_id</th>
                <th scope="col">first_name</th>
                <th scope="col">last_name</th>
                <th scope="col">email</th>
                <th scope="col">address_id</th>
                <th scope="col">active</th>
                <th scope="col">create_date</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
          </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (customer_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (store_id) REFERENCES store(store_id)</li>
            <li>FOREIGN KEY (address_id) REFERENCES address(address_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">film_id</th>
                <th scope="col">title</th>
                <th scope="col">description</th>
                <th scope="col">release_year</th>
                <th scope="col">language_id</th>
                <th scope="col">original_language_id</th>
                <th scope="col">rental_duration</th>
                <th scope="col">rental_rate</th>
                <th scope="col">length</th>
                <th scope="col">replacement_cost</th>
                <th scope="col">rating</th>
                <th scope="col">special_features</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
            <li>PRIMARY KEY, btree (film_id)</li>
          </ul>
                    <ul class="table-columns">
                        <li>FOREIGN KEY (language_id) REFERENCES language(language_id)</li>
                        <li>FOREIGN KEY (original_language_id) REFERENCES language(language_id)</li>
                    </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">actor_id</th>
                <th scope="col">film_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
            <li>PRIMARY KEY, btree (actor_id, film_id)</li>
                    </ul>
                    <ul class="table-columns">
                        <li>FOREIGN KEY (actor_id) REFERENCES actor(actor_id)</li>
                        <li>FOREIGN KEY (film_id) REFERENCES film(film_id)</li>
                    </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">film_id</th>
                <th scope="col">category_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
              <li>PRIMARY KEY, btree (film_id, category_id)</li>
          </ul>
          <ul class="table-columns">
              <li>FOREIGN KEY (film_id) REFERENCES film(film_id)</li>
              <li>FOREIGN KEY (category_id) REFERENCES category(category_id)</li>
          </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                    <th scope="col">inventory_id</th>
                    <th scope="col">film_id</th>
                    <th scope="col">store_id</th>
                    <th scope="col">last_update</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>1</td>
                    <td>23</td>
                    <td>2</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (inventory_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (film_id) REFERENCES film(film_id)</li>
            <li>FOREIGN KEY (store_id) REFERENCES store(store_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                    <th scope="col">language_id</th>
                    <th scope="col">name</th>
                    <th scope="col">last_update</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>1</td>
                    <td>English</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (language_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">payment_id</th>
                <th scope="col">customer_id</th>
                <th scope="col">staff_id</th>
                <th scope="col">rental_id</th>
                <th scope="col">amount</th>
                <th scope="col">payment_date</th>
                <th scope="col">last_update</th>
            </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>4.99</td>
                <td>2023-01-01 12:13:14</td>
                <td>2023-01-01 12:14:15</td>
            </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (payment_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (customer_id) REFERENCES customer(customer_id)</li>
            <li>FOREIGN KEY (staff_id) REFERENCES staff(staff_id)</li>
            <li>FOREIGN KEY (rental_id) REFERENCES rental(rental_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">rental_id</th>
                <th scope="col">rental_date</th>
                <th scope="col">inventory_id</th>
                <th scope="col">customer_id</th>
                <th scope="col">return_date</th>
                <th scope="col">staff_id</th>
                <th scope="col">last_update</th>
            </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>2023-01-01 16:15:21</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-10 09:12:36</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
            </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (rental_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)</li>
            <li>FOREIGN KEY (customer_id) REFERENCES customer(customer_id)</li>
            <li>FOREIGN KEY (staff_id) REFERENCES staff(staff_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                <th scope="col">staff_id</th>
                <th scope="col">first_name</th>
                <th scope="col">last_name</th>
                <th scope="col">address_id</th>
                <th scope="col">picture</th>
                <th scope="col">email</th>
                <th scope="col">store_id</th>
                <th scope="col">active</th>
                <th scope="col">username</th>
                <th scope="col">password</th>
                <th scope="col">last_update</th>
            </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (staff_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (address_id) REFERENCES address(address_id)</li>
            <li>FOREIGN KEY (store_id) REFERENCES store(store_id)</li>
        </ul>
    </div>
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
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
                <thead>
                    <tr>
                  <th scope="col">store_id</th>
                  <th scope="col">manager_staff_id</th>
                  <th scope="col">address_id</th>
                  <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                  <td>1</td>
                  <td>1</td>
                  <td>1</td>
                  <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (store_id)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (manager_staff_id) REFERENCES staff(staff_id)</li>
            <li>FOREIGN KEY (address_id) REFERENCES address(address_id)</li>
        </ul>
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
