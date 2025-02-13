<div id="db-description" class="db-description">
  <h2>Sakila Database (MySQL)</h2>
  Sakila is a sample database developed by MySQL, specifically designed to teach and demonstrate the capabilities of database management systems (DBMS) based on the relational model.
  <p>
      <a class="button-erd" href="/{$Lang}/erd/Sakila" target="ERDWindow">
        Sakila DB ER diagram
      </a>
  </p>
  The Sakila database contains 15 main tables describing various aspects of a DVD rental company.
  <h3>Below is a list of these tables:</h3>
  <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
    <li><span class='sql' onclick="scrollInfoPanel('actor_table_description')">actor</span> - table of actors.</li>
    <li><span class='sql' onclick="scrollInfoPanel('address_table_description')">address</span> - table of customer and staff addresses</li>
    <li><span class='sql' onclick="scrollInfoPanel('category_table_description')">category</span> - table of films categories.</li>
    <li><span class='sql' onclick="scrollInfoPanel('city_table_description')">city</span> - table of cities.</li>
    <li><span class='sql' onclick="scrollInfoPanel('country_table_description')">country</span> - table of countries.</li>
    <li><span class='sql' onclick="scrollInfoPanel('customer_table_description')">customer</span> - table of customers in Sakila database.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_table_description')">film</span> - table of films in Sakila database.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_actor_table_description')">film_actor</span> - actors to films relation table.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_category_table_description')">film_category</span> - films to categories relation table.</li>
    <li><span class='sql' onclick="scrollInfoPanel('inventory_table_description')">inventory</span> - table of items in Sakila database.</li>
    <li><span class='sql' onclick="scrollInfoPanel('language_table_description')">language</span> - table of films languages.</li>
    <li><span class='sql' onclick="scrollInfoPanel('payment_table_description')">payment</span> - table of customers payments.</li>
    <li><span class='sql' onclick="scrollInfoPanel('rental_table_description')">rental</span> - table of customers rentals.</li>
    <li><span class='sql' onclick="scrollInfoPanel('staff_table_description')">staff</span> - table of company staff.</li>
    <li><span class='sql' onclick="scrollInfoPanel('store_table_description')">store</span> - table of company stories.</li>
  </ul>
  {if $User->showAd()}
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
          <img style="width: 90%;" border="0" src="https://ad.admitad.com/b/u1k11fxms7fec845fb2fd629c4b097/" alt="edX Many Geos"/>
      </a>
  {/if}
  <h3 id="actor_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>actor</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>actor_id</span> - Unique identifier for each actor.</li>
    <li> <span class='sql'>first_name</span> - First name of the actor.</li>
    <li> <span class='sql'>last_name</span> - Last name of the actor.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li> 
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (actor_id)</li>
  </ul>
  <h3 id="address_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>address</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>address_id</span> - Unique identifier for each address.</li>
    <li> <span class='sql'>address</span> - Street address.</li>
    <li> <span class='sql'>address2</span> - Additional address.</li>
    <li> <span class='sql'>district</span> - District or region.</li>
    <li> <span class='sql'>city_id</span> - Foreign key referencing the city table.</li>
    <li> <span class='sql'>postal_code</span> - Postal code.</li>
    <li> <span class='sql'>phone</span> - Phone number.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (address_id)</li>
  </ul>
  <h3 id="category_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>category</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>category_id</span> - Unique identifier for each category.</li>
    <li> <span class='sql'>name</span> - Name of the category.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (category_id)</li>
  </ul>
  <h3 id="city_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>city</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>city_id</span> - Unique identifier for each city.</li>
    <li> <span class='sql'>city</span> - City name.</li>
    <li> <span class='sql'>country_id</span> - Foreign key referencing the country table.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (city_id)</li>
  </ul>
  <h3 id="country_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>country</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>country_id</span> - Unique identifier for each country.</li>
    <li> <span class='sql'>country</span> - Country name.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (country_id)</li>
  </ul>
  <h3 id="customer_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>customer</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>customer_id</span> - Unique identifier for each customer.</li>
    <li> <span class='sql'>store_id</span> - Foreign key referencing the store table.</li>
    <li> <span class='sql'>first_name</span> - First name of the customer.</li>
    <li> <span class='sql'>last_name</span> - Last name of the customer.</li>
    <li> <span class='sql'>email</span> - Email address of the customer.</li>
    <li> <span class='sql'>address_id</span> - Foreign key referencing the address table.</li>
    <li> <span class='sql'>active</span> - Indicates whether the customer is active (0/1).</li>
    <li> <span class='sql'>create_date</span> - Timestamp indicating when the customer was added to the database.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (customer_id)</li>
  </ul>
  <h3 id="film_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>film</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>film_id</span> - Unique identifier for each film.</li>
    <li> <span class='sql'>title</span> - The title of the film.</li>
    <li> <span class='sql'>description</span> - A short description or plot summary of the film.</li>
    <li> <span class='sql'>release_year</span> - The year in which the movie was released.</li>
    <li> <span class='sql'>language_id</span> - Foreign key referencing the language table; identifies the language of the film.</li>
    <li> <span class='sql'>original_language_id</span> - A foreign key pointing at the language table; identifies the original language of the film. Used when a film has been dubbed into a new language.</li>
    <li> <span class='sql'>rental_duration</span> - The length of the rental period, in days.</li>
    <li> <span class='sql'>rental_rate</span> - The cost to rent the film for the period specified in the rental_duration column.</li>
    <li> <span class='sql'>length</span> - Duration of the film, in minutes.</li>
    <li> <span class='sql'>replacement_cost</span> - The amount charged to the customer if the film is not returned or is returned in a damaged state.</li>
    <li> <span class='sql'>rating</span> - The rating assigned to the film. Can be one of: G, PG, PG-13, R, or NC-17.</li>
    <li> <span class='sql'>special_features</span> - Lists which common special features are included on the DVD. Can be zero or more of: Trailers, Commentaries, Deleted Scenes, Behind the Scenes.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (film_id)</li>
  </ul>
  <h3 id="film_actor_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>film_actor</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>actor_id</span> - Unique identifier for actor.</li>
    <li> <span class='sql'>film_id</span> - Unique identifier for film.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (actor_id, film_id)</li>
  </ul>
  <h3 id="film_category_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>film_category</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>film_id</span> - Unique identifier for each film.</li>
    <li> <span class='sql'>category_id</span> - Unique identifier for each category.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
      <li>PRIMARY KEY, btree (film_id, category_id)</li>
  </ul>
  <h3 id="inventory_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>inventory</span>
  </h3>
  Table columns: <ul class="table-columns">
      <li><span class='sql'>inventory_id</span> - Unique identifier for each inventory item.</li>
      <li><span class='sql'>film_id</span> - Unique identifier for each film in the inventory.</li>
      <li><span class='sql'>store_id</span> - Unique identifier for the store where the inventory item is located.</li>
      <li><span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (inventory_id)</li>
  </ul>
  <h3 id="language_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>language</span>
  </h3>
  Table columns: <ul class="table-columns">
      <li> <span class='sql'>language_id</span> - Unique identifier for each language.</li>
      <li> <span class='sql'>name</span> - Language name.</li>
      <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li> 
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (language_id)</li>
  </ul>
  <h3 id="payment_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>payment</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>payment_id</span> - Unique identifier for each payment.</li>
    <li> <span class='sql'>customer_id</span> - Foreign key referencing the customer table.</li>
    <li> <span class='sql'>staff_id</span> - Foreign key referencing the staff table.</li>
    <li> <span class='sql'>rental_id</span> - Foreign key referencing the rental table.</li>
    <li> <span class='sql'>amount</span> - Payment amount.</li>
    <li> <span class='sql'>payment_date</span> - Date of the payment.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (payment_id)</li>
  </ul>
  <h3 id="rental_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>rental</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>rental_id</span> - Unique identifier for each rental.</li>
    <li> <span class='sql'>rental_date</span> - Date when the rental occurred.</li>
    <li> <span class='sql'>inventory_id</span> - Foreign key referencing the inventory table.</li>
    <li> <span class='sql'>customer_id</span> - Foreign key referencing the customer table.</li>
    <li> <span class='sql'>return_date</span> - Date when the rental was returned.</li>
    <li> <span class='sql'>staff_id</span> - Foreign key referencing the staff table.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (rental_id)</li>
  </ul>
  <h3 id="staff_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>staff</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>staff_id</span> - Unique identifier for each staff member.</li>
    <li> <span class='sql'>first_name</span> - First name of the staff member.</li>
    <li> <span class='sql'>last_name</span> - Last name of the staff member.</li>
    <li> <span class='sql'>address_id</span> - Foreign key referencing the address table.</li>
    <li> <span class='sql'>picture</span> - Staff member picture.</li>
    <li> <span class='sql'>email</span> - Email address of the staff member.</li>
    <li> <span class='sql'>store_id</span> - Foreign key referencing the store table.</li>
    <li> <span class='sql'>active</span> - Indicates whether the staff member is active (0/1).</li>
    <li> <span class='sql'>username</span> - Username for login.</li>
    <li> <span class='sql'>password</span> - Password for login.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (staff_id)</li>
  </ul>
  <h3 id="store_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Table <span class='sql'>store</span>
  </h3>
  Table columns: <ul class="table-columns">
    <li> <span class='sql'>store_id</span> - Unique identifier for each store.</li>
    <li> <span class='sql'>manager_staff_id</span> - Foreign key referencing the staff table for the store manager.</li>
    <li> <span class='sql'>address_id</span> - Foreign key referencing the address table.</li>
    <li> <span class='sql'>last_update</span> - When the row was created or most recently updated.</li>
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
  Indexes:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (store_id)</li>
  </ul>
</div>
