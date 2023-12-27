<div class="db-description">
<h3>Sakila DB description</h3
Sakila is a sample database developed by MySQL, specifically designed to teach and demonstrate the capabilities of database management systems (DBMS) based on the relational model.
<p>
The Sakila database contains 16 main tables describing various aspects of a DVD rental company.
</p><p>
Below is a list of these tables:
</p>
<p>Table `actor`</p>
  <ul class="table-columns">
      <li> `actor_id` - Unique identifier for each actor.</li>
      <li> `first_name` - First name of the actor.</li>
      <li> `last_name` - Last name of the actor.</li>
      <li> `last_update` - Last modified timestamp of the record.</li> 
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
  <p>Table `film`</p>
  <ul class="table-columns">
    <li> `film_id` - Unique identifier for each film.</li>
    <li> `title` - Title of the film.</li>
    <li> `description` - Description of the film.</li>
    <li> `release_year` - Year the film was released.</li>
    <li> `language_id` - Foreign key referencing the language table.</li>
    <li> `original_language_id` - Foreign key referencing the language table.</li>
    <li> `rental_duration` - Rental duration in days.</li>
    <li> `rental_rate` - Rental rate.</li>
    <li> `length` - Duration of the film in minutes.</li>
    <li> `replacement_cost` - Replacement cost.</li>
    <li> `rating` - Film rating.</li>
    <li> `special_features` - Special features of the film.</li>
    <li> `last_update` - Last modified timestamp of the record.</li>
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
      <!-- Additional rows go here if applicable -->
    </table>
  </div>
  <p>Table `film_text`</p>
<ul class="table-columns">
  <li> `film_id` - Unique identifier for each film.</li>
  <li> `title` - Title of the film.</li>
  <li> `description` - Description of the film.</li>
</ul>
<div class="table-wrapper">
  <table>
    <tr>
      <th>film_id</th>
      <th>title</th>
      <th>description</th>
    </tr>
    <tr>
      <td>1</td>
      <td>Film Title</td>
      <td>A brief description of the film.</td>
    </tr>
    <!-- Additional rows go here if applicable -->
  </table>
</div>
  <p>Table `film_actor`</p>
  <ul class="table-columns">
    <li> `actor_id` - Unique identifier for actor.</li>
    <li> `film_id` - Unique identifier for film.</li>
    <li> `last_update` - Last modified timestamp of the record.</li>
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
      <!-- Additional rows go here if applicable -->
    </table>
  </div>
  <p>Table `customer`</p>
  <ul class="table-columns">
    <li> `customer_id` - Unique identifier for each customer.</li>
    <li> `store_id` - Foreign key referencing the store table.</li>
    <li> `first_name` - First name of the customer.</li>
    <li> `last_name` - Last name of the customer.</li>
    <li> `email` - Email address of the customer.</li>
    <li> `address_id` - Foreign key referencing the address table.</li>
    <li> `active` - Indicates whether the customer is active.</li>
    <li> `create_date` - Timestamp indicating when the customer was added to the database.</li>
    <li> `last_update` - Last modified timestamp of the record.</li>
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
        <td>true</td>
        <td>2023-01-01 12:00:00</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  <p>Table `address`</p>
  <ul class="table-columns">
    <li> `address_id` - Unique identifier for each address.</li>
    <li> `address` - Street address.</li>
    <li> `address` - Additional address.</li>
    <li> `district` - District or region.</li>
    <li> `city_id` - Foreign key referencing the city table.</li>
    <li> `postal_code` - Postal code.</li>
    <li> `phone` - Phone number.</li>
    <li> `last_update` - Last modified timestamp of the record.</li>
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
      <!-- Additional rows go here if applicable -->
    </table>
  </div>
  <!-- For City Table -->
<p>Table `city`</p>
<ul class="table-columns">
  <li> `city_id` - Unique identifier for each city.</li>
  <li> `city` - City name.</li>
  <li> `country_id` - Foreign key referencing the country table.</li>
  <li> `last_update` - Last modified timestamp of the record.</li>
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
    <!-- Additional rows go here if applicable -->
  </table>
</div>

<!-- For Country Table -->
<p>Table `country`</p>
<ul class="table-columns">
  <li> `country_id` - Unique identifier for each country.</li>
  <li> `country` - Country name.</li>
  <li> `last_update` - Last modified timestamp of the record.</li>
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
    <!-- Additional rows go here if applicable -->
  </table>
</div>

  <p>Table `category`</p>
<ul class="table-columns">
  <li> `category_id` - Unique identifier for each category.</li>
  <li> `name` - Name of the category.</li>
  <li> `last_update` - Last modified timestamp of the record.</li>
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
    <!-- Additional rows go here if applicable -->
  </table>
</div>
<p>Table `film_category`</p>
  <ul class="table-columns">
    <li> `film_id` - Unique identifier for each film.</li>
    <li> `category_id` - Unique identifier for each category.</li>
    <li> `last_update` - Last modified timestamp of the record.</li>
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
      <!-- Additional rows go here if applicable -->
    </table>
  </div>
<p>Table `language`</p>
  <ul class="table-columns">
      <li> `language_id` - Unique identifier for each language.</li>
      <li> `name` - Language name.</li>
      <li> `last_update` - Last modified timestamp of the record.</li> 
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
    <!-- For Staff Table -->
<p>Table `staff`</p>
<ul class="table-columns">
  <li> `staff_id` - Unique identifier for each staff member.</li>
  <li> `first_name` - First name of the staff member.</li>
  <li> `last_name` - Last name of the staff member.</li>
  <li> `address_id` - Foreign key referencing the address table.</li>
  <li> `picture` - Staff member picture.</li>
  <li> `email` - Email address of the staff member.</li>
  <li> `store_id` - Foreign key referencing the store table.</li>
  <li> `active` - Indicates whether the staff member is active.</li>
  <li> `username` - Username for login.</li>
  <li> `password` - Password for login.</li>
  <li> `last_update` - Last modified timestamp of the record.</li>
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
      <td>true</td>
      <td>johndoe</td>
      <td>********</td>
      <td>2023-01-01 12:00:00</td>
    </tr>
    <!-- Additional rows go here if applicable -->
  </table>
</div>
<!-- For Staff_List Table -->
<p>Table `staff_list`</p>
<ul class="table-columns">
  <li> `ID` - Unique identifier for each staff list entry.</li>
  <li> `name` - Staff member's name.</li>
  <li> `address` - Staff member's address.</li>
  <li> `zip code` - Staff member's zip code.</li>
  <li> `phone` - Staff member's phone number.</li>
  <li> `city` - Staff member's city.</li>
  <li> `country` - Staff member's country.</li>
  <li> `SID` - Foreign key referencing the staff table.</li>
</ul>
<div class="table-wrapper">
  <table>
    <tr>
      <th>ID</th>
      <th>name</th>
      <th>address</th>
      <th>zip code</th>
      <th>phone</th>
      <th>city</th>
      <th>country</th>
      <th>SID</th>
    </tr>
    <tr>
      <td>1</td>
      <td>John Doe</td>
      <td>123 Main St</td>
      <td>12345</td>
      <td>+1234567890</td>
      <td>Metropolis</td>
      <td>United States</td>
      <td>1</td>
    </tr>
    <!-- Additional rows go here if applicable -->
  </table>
</div>

<!-- For Store Table -->
<p>Table `store`</p>
<ul class="table-columns">
  <li> `store_id` - Unique identifier for each store.</li>
  <li> `manager_staff_id` - Foreign key referencing the staff table for the store manager.</li>
  <li> `address_id` - Foreign key referencing the address table.</li>
  <li> `last_update` - Last modified timestamp of the record.</li>
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
    <!-- Additional rows go here if applicable -->
  </table>
</div>
<!-- For Payment Table -->
<p>Table `payment`</p>
<ul class="table-columns">
  <li> `payment_id` - Unique identifier for each payment.</li>
  <li> `customer_id` - Foreign key referencing the customer table.</li>
  <li> `staff_id` - Foreign key referencing the staff table.</li>
  <li> `rental_id` - Foreign key referencing the rental table.</li>
  <li> `amount` - Payment amount.</li>
  <li> `payment_date` - Date of the payment.</li>
  <li> `last_update` - Last modified timestamp of the record.</li>
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
      <td>2023-01-01</td>
      <td>2023-01-01 12:00:00</td>
    </tr>
    <!-- Additional rows go here if applicable -->
  </table>
</div>

<!-- For Rental Table -->
<p>Table `rental`</p>
<ul class="table-columns">
  <li> `rental_id` - Unique identifier for each rental.</li>
  <li> `rental_date` - Date when the rental occurred.</li>
  <li> `inventory_id` - Foreign key referencing the inventory table.</li>
  <li> `customer_id` - Foreign key referencing the customer table.</li>
  <li> `return_date` - Date when the rental was returned.</li>
  <li> `staff_id` - Foreign key referencing the staff table.</li>
  <li> `last_update` - Last modified timestamp of the record.</li>
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
      <td>2023-01-01</td>
      <td>1</td>
      <td>1</td>
      <td>2023-01-10</td>
      <td>1</td>
      <td>2023-01-01 12:00:00</td>
    </tr>
    <!-- Additional rows go here if applicable -->
  </table>
</div>

</div>