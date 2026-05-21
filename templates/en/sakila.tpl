<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h1>Sakila Database: table structure and schema overview</h1>
    <p>Sakila is a sample relational database designed by MySQL for learning and demonstrating SQL and relational database management system (RDBMS) capabilities.</p>
    <p>This page presents Sakila table structure, key columns, and constraints commonly used in educational SQL queries.</p>
    <p>The Sakila database contains 15 main tables describing various aspects of a DVD rental company.</p>
    <p>
        <a href="/{$Lang}/erd/Sakila" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Open Sakila database ER diagram in a new window">
            <img src="/images/erd_small_light.svg" alt="ER diagram of the Sakila database showing table relationships" style="width: 90%;" loading="lazy" decoding="async">
            ER diagram of the Sakila database
        </a>
    </p>
    <h2>The list of tables</h2>
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span><span class='sql'>actor</span> - actor table.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>unique record identifier (PK)</li>
            <li> <span class='sql'>first_name</span>actor's first name</li>
            <li> <span class='sql'>last_name</span>actor's last name</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
        </ul>
        <div class="table-wrapper">
            <table>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>address</span> - customer and staff addresses.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>address_id</span>unique record identifier (PK)</li>
            <li> <span class='sql'>address</span>postal address</li>
            <li> <span class='sql'>address2</span>additional address</li>
            <li> <span class='sql'>district</span>district or region</li>
            <li> <span class='sql'>city_id</span>city identifier (FK)</li>
            <li> <span class='sql'>postal_code</span>postal code</li>
            <li> <span class='sql'>phone</span>phone number</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>category</span> - film categories.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>category_id</span>unique record identifier (PK)</li>
            <li> <span class='sql'>name</span>category name</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>city</span> - city table.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>city_id</span>unique record identifier (PK)</li>
            <li> <span class='sql'>city</span>city name</li>
            <li> <span class='sql'>country_id</span>country identifier (FK)</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>country</span> - country table.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>country_id</span>unique record identifier (PK)</li>
            <li> <span class='sql'>country</span>country name</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>customer</span> - customer table.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>unique record identifier (PK)</li>
            <li> <span class='sql'>store_id</span>store identifier (FK)</li>
            <li> <span class='sql'>first_name</span>customer's first name</li>
            <li> <span class='sql'>last_name</span>customer's last name</li>
            <li> <span class='sql'>email</span>customer's email address</li>
            <li> <span class='sql'>address_id</span>address identifier (FK)</li>
            <li> <span class='sql'>active</span>customer activity indicator (0/1)</li>
            <li> <span class='sql'>create_date</span>date and time the customer was added to the database</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>film</span> - table of films.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 13rem;">film_id</span>unique record identifier (PK)</li>
            <li> <span class='sql' style="min-width: 13rem;">title</span>film title</li>
            <li> <span class='sql' style="min-width: 13rem;">description</span>brief description or plot of the film</li>
            <li> <span class='sql' style="min-width: 13rem;">release_year</span>year the film was released</li>
            <li> <span class='sql' style="min-width: 13rem;">language_id</span>identifier of the film's language (FK)</li>
            <li> <span class='sql' style="min-width: 13rem;">original_language_id</span>identifier of the original language of the film in case it is dubbed into a new language</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_duration</span>duration of rental period in days</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_rate</span>cost of renting the film for the duration specified in the rental_duration column</li>
            <li> <span class='sql' style="min-width: 13rem;">length</span>length of the film in minutes</li>
            <li> <span class='sql' style="min-width: 13rem;">replacement_cost</span>amount of penalty for loss or damage of the disc</li>
            <li> <span class='sql' style="min-width: 13rem;">rating</span>rating assigned to the film. Can be one of: G, PG, PG-13, R, or NC-17</li>
            <li> <span class='sql' style="min-width: 13rem;">special_features</span>list of special features included on the DVD. Can be zero or more of: Trailers, Commentaries, Deleted Scenes, Behind the Scenes</li>
            <li> <span class='sql' style="min-width: 13rem;">last_update</span>date and time of last update</li>
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
                <td>Film Title</td>
                <td>A brief description of the film.</td>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>film_actor</span> - actors to films relation.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identifier for actor (FK)</li>
            <li> <span class='sql'>film_id</span>identifier for film (FK)</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>film_category</span> - films to categories relation.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>film_id</span>identifier for each film (FK)</li>
            <li> <span class='sql'>category_id</span>identifier for each category (FK)</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>inventory</span> - table of items.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>inventory_id</span>unique record identifier (PK)</li>
            <li><span class='sql'>film_id</span>identifier of the film (FK)</li>
            <li><span class='sql'>store_id</span>identifier of the store where the inventory is located (FK)</li>
            <li><span class='sql'>last_update</span>date and time of last update</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>language</span> - films languages.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>language_id</span>unique record identifier (PK)</li>
            <li> <span class='sql'>name</span>language name</li>
            <li> <span class='sql'>last_update</span>date and time of last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>payment</span> - customers payments.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">payment_id</span>unique identifier of the record (PK)</li>
            <li> <span class='sql' style="min-width: 8rem;">customer_id</span>identifier of the customer (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">staff_id</span>identifier of the staff member who received the payment (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">rental_id</span>identifier of the rental record (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">amount</span>payment amount</li>
            <li> <span class='sql' style="min-width: 8rem;">payment_date</span>date and time of the payment</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>date and time of the last update</li>
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>rental</span> - customers rentals.
    </div>
    <div class="panel">
        <ul class="table-columns">
        <li> <span class='sql'>rental_id</span>unique identifier of the record (PK)</li>
        <li> <span class='sql'>rental_date</span>rental start date</li>
        <li> <span class='sql'>inventory_id</span>identifier of the disk (FK)</li>
        <li> <span class='sql'>customer_id</span>identifier of the customer (FK)</li>
        <li> <span class='sql'>return_date</span>date of returning the film</li>
        <li> <span class='sql'>staff_id</span>id of the staff member issued the disk (FK)</li>
        <li> <span class='sql'>last_update</span>date and time of the last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>staff</span> - company staff.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>staff_id</span>unique identifier of the record (PK)</li>
            <li> <span class='sql'>first_name</span>first name of the staff member</li>
            <li> <span class='sql'>last_name</span>last name of the staff member</li>
            <li> <span class='sql'>address_id</span>identifier of the address (FK)</li>
            <li> <span class='sql'>picture</span>photo of the staff member</li>
            <li> <span class='sql'>email</span>email address of the staff member</li>
            <li> <span class='sql'>store_id</span>foreign key referencing the store table (FK)</li>
            <li> <span class='sql'>active</span>indicator of staff member's activity (0/1)</li>
            <li> <span class='sql'>username</span>username for system login</li>
            <li> <span class='sql'>password</span>password for login</li>
            <li> <span class='sql'>last_update</span>date and time of the last update</li> 
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
    <div class="accordion" title="Click to expand, double-click to paste table name into the editor">
        <span class='sql'>store</span> - company stories.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 11rem;">store_id</span>unique identifier of the record (PK)</li>
            <li> <span class='sql' style="min-width: 11rem;">manager_staff_id</span>identifier of the store manager (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">address_id</span>identifier of the address (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">last_update</span>date and time of the last update</li> 
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
