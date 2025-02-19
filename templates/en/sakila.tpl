<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 6rem;
        }
    </style>
    <h2>Sakila Database (MySQL)</h2>
    Sakila is an example database designed by MySQL, specifically created for learning and demonstrating the capabilities of relational database management systems (RDBMS).
    <p>
        <a class="button-erd" href="/{$Lang}/erd/Sakila" target="ERDWindow">
            ER diagram of the Sakila database
        </a>
    </p>
    <p>The Sakila database contains 15 main tables describing various aspects of a DVD rental company.</p>
    <h3>Table List:</h3>
    <div class="accordion">
        <span><span class='sql'>actor</span> - actor table.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>unique record identifier (PK).</li>
            <li> <span class='sql'>first_name</span>actor's first name.</li>
            <li> <span class='sql'>last_name</span>actor's last name.</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>address</span> - customer and staff addresses.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>address_id</span>unique record identifier (PK).</li>
            <li> <span class='sql'>address</span>postal address.</li>
            <li> <span class='sql'>address2</span>additional address.</li>
            <li> <span class='sql'>district</span>district or region.</li>
            <li> <span class='sql'>city_id</span>city identifier (FK).</li>
            <li> <span class='sql'>postal_code</span>postal code.</li>
            <li> <span class='sql'>phone</span>phone number.</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>category</span> - film categories.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>category_id</span>unique record identifier (PK).</li>
            <li> <span class='sql'>name</span>category name.</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>city</span> - city table.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>city_id</span>unique record identifier (PK).</li>
            <li> <span class='sql'>city</span>city name.</li>
            <li> <span class='sql'>country_id</span>country identifier (FK).</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>country</span> - country table.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>country_id</span>unique record identifier (PK).</li>
            <li> <span class='sql'>country</span>country name.</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>customer</span> - customer table.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>unique record identifier (PK).</li>
            <li> <span class='sql'>store_id</span>store identifier (FK).</li>
            <li> <span class='sql'>first_name</span>customer's first name.</li>
            <li> <span class='sql'>last_name</span>customer's last name.</li>
            <li> <span class='sql'>email</span>customer's email address.</li>
            <li> <span class='sql'>address_id</span>address identifier (FK).</li>
            <li> <span class='sql'>active</span>customer activity indicator (0/1).</li>
            <li> <span class='sql'>create_date</span>date and time the customer was added to the database.</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>film</span> - list of films in Sakila database.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 10rem;">film_id</span>unique record identifier (PK).</li>
            <li> <span class='sql' style="min-width: 10rem;">title</span>film title.</li>
            <li> <span class='sql' style="min-width: 10rem;">description</span>brief description or plot of the film.</li>
            <li> <span class='sql' style="min-width: 10rem;">release_year</span>year the film was released.</li>
            <li> <span class='sql' style="min-width: 10rem;">language_id</span>identifier of the film's language (FK).</li>
            <li> <span class='sql' style="min-width: 10rem;">original_language_id</span>identifier of the original language of the film in case it is dubbed into a new language.</li>
            <li> <span class='sql' style="min-width: 10rem;">rental_duration</span>duration of rental period in days.</li>
            <li> <span class='sql' style="min-width: 10rem;">rental_rate</span>cost of renting the film for the duration specified in the rental_duration column.</li>
            <li> <span class='sql' style="min-width: 10rem;">length</span>length of the film in minutes.</li>
            <li> <span class='sql' style="min-width: 10rem;">replacement_cost</span>amount of penalty for loss or damage of the disc.</li>
            <li> <span class='sql' style="min-width: 10rem;">rating</span>rating assigned to the film. Can be one of: G, PG, PG-13, R, or NC-17.</li>
            <li> <span class='sql' style="min-width: 10rem;">special_features</span>list of special features included on the DVD. Can be zero or more of: Trailers, Commentaries, Deleted Scenes, Behind the Scenes.</li>
            <li> <span class='sql' style="min-width: 10rem;">last_update</span>date and time of last update.</li>
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
            </table>
          </div>
          <ul class="table-columns">
            <li>PRIMARY KEY, btree (film_id)</li>
          </ul>
    </div>
    <div class="accordion">
        <span class='sql'>film_actor</span> - actors to films relation.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identifier for actor (FK).</li>
            <li> <span class='sql'>film_id</span>identifier for film (FK).</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>film_category</span> - films to categories relation.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>film_id</span>identifier for each film (FK).</li>
            <li> <span class='sql'>category_id</span>identifier for each category (FK).</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>inventory</span> - items in Sakila database.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>inventory_id</span>unique record identifier (PK).</li>
            <li><span class='sql'>film_id</span>identifier of the film (FK).</li>
            <li><span class='sql'>store_id</span>identifier of the store where the inventory is located (FK).</li>
            <li><span class='sql'>last_update</span>date and time of last update.</li>
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
        <span class='sql'>language</span> - films languages.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>unique record identifier (PK).</li>
            <li> <span class='sql'>name</span>language name.</li>
            <li> <span class='sql'>last_update</span>date and time of last update.</li> 
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
        <span class='sql'>payment</span> - customers payments.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">payment_id</span>unique identifier of the record (PK).</li>
            <li> <span class='sql' style="min-width: 8rem;">customer_id</span>identifier of the customer (FK).</li>
            <li> <span class='sql' style="min-width: 8rem;">staff_id</span>identifier of the staff member who received the payment (FK).</li>
            <li> <span class='sql' style="min-width: 8rem;">rental_id</span>identifier of the rental record (FK).</li>
            <li> <span class='sql' style="min-width: 8rem;">amount</span>payment amount.</li>
            <li> <span class='sql' style="min-width: 8rem;">payment_date</span>date and time of the payment.</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>date and time of the last update.</li>
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
        <span class='sql'>rental</span> - customers rentals.
    </div>
    <div class="panel">
        <ul class="table-columns">
        <li> <span class='sql'>rental_id</span>unique identifier of the record (PK).</li>
        <li> <span class='sql'>rental_date</span>rental start date.</li>
        <li> <span class='sql'>inventory_id</span>identifier of the disk (FK).</li>
        <li> <span class='sql'>customer_id</span>identifier of the customer (FK).</li>
        <li> <span class='sql'>return_date</span>date of returning the film.</li>
        <li> <span class='sql'>staff_id</span>identifier of the staff member who issued the disk (FK).</li>
        <li> <span class='sql'>last_update</span>date and time of the last update.</li> 
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
        <span class='sql'>staff</span> - company staff.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>staff_id</span>unique identifier of the record (PK).</li>
            <li> <span class='sql'>first_name</span>first name of the staff member.</li>
            <li> <span class='sql'>last_name</span>last name of the staff member.</li>
            <li> <span class='sql'>address_id</span>identifier of the address (FK).</li>
            <li> <span class='sql'>picture</span>photo of the staff member.</li>
            <li> <span class='sql'>email</span>email address of the staff member.</li>
            <li> <span class='sql'>store_id</span>foreign key referencing the store table (FK).</li>
            <li> <span class='sql'>active</span>indicator of staff member's activity (0/1).</li>
            <li> <span class='sql'>username</span>username for system login.</li>
            <li> <span class='sql'>password</span>password for login.</li>
            <li> <span class='sql'>last_update</span>date and time of the last update.</li> 
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
        <span class='sql'>store</span> - company stories.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">store_id</span>unique identifier of the record (PK).</li>
            <li> <span class='sql' style="min-width: 8rem;">manager_staff_id</span>identifier of the store manager (FK).</li>
            <li> <span class='sql' style="min-width: 8rem;">address_id</span>identifier of the address (FK).</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>date and time of the last update.</li> 
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
            {* <a href="https://amzn.to/4dVmPhJ" target="_blank" style="text-decoration: none;">
            <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">
                <div  style = "width: 30%;">
                    <img style="width: 100%;" src="/images/sql-in-10-minutes-by-ben-forta.jpg" alt="SQL in 10 Minutes a Day by Ben Forta">
                </div>
                <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                    <div>SQL in 10 Minutes a Day by Ben Forta</div>
                    <div style="font-size: small; padding-top: 0.5em;">
                    Whether you're an application developer, database administrator, web application designer, mobile app developer, or Microsoft Office users, a good working knowledge of SQL is an important part of interacting with databases. And Sams Teach Yourself SQL in 10 Minutes offers the straightforward, practical answers you need to help you do your job. 
                    </div>
                </div>
            </div>
            </a> *}
            <a target="_blank" rel="nofollow" href="https://bywiola.com/g/u1k11fxms7fec845fb2fd629c4b097/?i=4">
                <img style="width: 100%;" border="0" src="https://ad.admitad.com/b/u1k11fxms7fec845fb2fd629c4b097/" alt="edX Many Geos"/>
            </a>
        </div>
    {/if}
</div>