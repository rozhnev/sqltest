<div class="db-description">
<h3>Описание базы данных Sakila</h3>
Sakila - это пример базы данных, разработанный компанией MySQL, специально созданный для обучения и демонстрации возможностей систем управления базами данных (СУБД) на основе реляционной модели.
<p>
База данных Sakila содержит 16 основных таблиц, описывающих различные аспекты компании по прокату DVD-дисков.
</p><p>
Ниже приведен список этих таблиц:
</p>
<p>Таблица `actor`</p>
<ul class="table-columns">
    <li> `actor_id` - уникальный идентификатор для каждого актера.</li>
    <li> `first_name` - имя актера.</li>
    <li> `last_name` - фамилия актера.</li>
    <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
<p>Таблица `film`</p>
  <ul class="table-columns">
     <li> `film_id` – уникальный идентификатор каждого фильма.</li>
     <li> `title` — название фильма.</li>
     <li> `description` – краткое описание или сюжет фильма.</li>
     <li> `release_year` — год выхода фильма.</li>
     <li> `language_id` — внешний ключ, ссылающийся на таблицу `language` - определяет язык фильма.</li>
     <li> `original_language_id` — внешний ключ, указывающий на таблицу `language` - определяет язык оригинала фильма. Используется, когда фильм дублирован на новый язык.</li>
     <li> `rental_duration` — продолжительность периода аренды в днях.</li>
     <li> `rental_rate` — стоимость проката фильма на период, указанный в столбце rental_duration.</li>
     <li> `length` — продолжительность фильма в минутах.</li>
     <li> `replacement_cost` — сумма, взимаемая с покупателя, если пленка не возвращена или возвращена в поврежденном состоянии.</li>
     <li> `rating` — рейтинг, присвоенный фильму. Может быть одним из: G, PG, PG-13, R или NC-17.</li>
     <li> `special_features` — список общих специальных функций, включенных в DVD. Может быть ноль или более: трейлеры, комментарии, удаленные сцены, за кадром.</li>
     <li> `last_update` — временная метка создания или последнего обновления строки.</li>
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
  <!-- For Film_Text Table -->
<p>Таблица `film_text`</p>
<ul class="table-columns">
<li> `film_id` – уникальный идентификатор каждого фильма.</li>
   <li> `title` - название фильма.</li>
   <li> `description` - описание фильма.</li>
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
  <p>Таблица `film_actor`</p>
<ul class="table-columns">
  <li> `actor_id` – уникальный идентификатор актера.</li>
  <li> `film_id` – уникальный идентификатор фильма.</li>
  <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
<p>Таблица `customer`</p>
  <ul class="table-columns">
    <li> `customer_id` – уникальный идентификатор для каждого клиента.</li>
    <li> `store_id` - внешний ключ, ссылающийся на таблицу магазина.</li>
    <li> `first_name` – имя клиента.</li>
    <li> `last_name` – фамилия клиента.</li>
    <li> `email` – адрес электронной почты клиента.</li>
    <li> `address_id` - внешний ключ, ссылающийся на таблицу адресов.</li>
    <li> `active` – указывает, активен ли клиент.</li>
    <li> `create_date` - временная метка, указывающая, когда клиент был добавлен в базу данных.</li>
    <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
  <p>Таблица `address`</p>
  <ul class="table-columns">
    <li> `address_id` - уникальный идентификатор для каждого адреса.</li>
    <li> `address` – почтовый адрес.</li>
    <li> `address2` – дополнительный адрес.</li>
    <li> `район` – район или регион.</li>
    <li> `city_id` - внешний ключ, ссылающийся на таблицу городов.</li>
    <li> `postal_code` – почтовый индекс.</li>
    <li> `phone` – номер телефона.</li>
    <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
<p>Таблица `city`</p>
<ul class="table-columns">
<li> `city_id` – уникальный идентификатор для каждого города.</li>
   <li> `city` - название города.</li>
   <li> `country_id` - внешний ключ, ссылающийся на таблицу стран.</li>
  <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
<p>Таблица `country`</p>
<ul class="table-columns">
<li> `country_id` – уникальный идентификатор для каждой страны.</li>
   <li> `country` – название страны.</li>
  <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
  <p>Таблица `category`</p>
  <ul class="table-columns">
  <li> `category_id` – уникальный идентификатор для каждой категории.</li>
  <li> `name` - название категории.</li>
    <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
  <p>Таблица `film_category`</p>
    <ul class="table-columns">
    <li> `film_id` – уникальный идентификатор каждого фильма.</li>
    <li> `category_id` – уникальный идентификатор для каждой категории.</li>
      <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
  <p>Таблица `language`</p>
  <ul class="table-columns">
      <li> `language_id` - уникальный идентификатор для каждого языка.</li>
      <li> `name` - название языка.</li>
      <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
<p>Таблица `staff`</p>
<ul class="table-columns">
<li> `staff_id` – уникальный идентификатор каждого сотрудника.</li>
   <li> `first_name` – имя сотрудника.</li>
   <li> `last_name` - фамилия сотрудника.</li>
   <li> `address_id` - внешний ключ, ссылающийся на таблицу адресов.</li>
   <li> `picture` – изображение сотрудника.</li>
   <li> `email` - адрес электронной почты сотрудника.</li>
   <li> `store_id` - внешний ключ, ссылающийся на таблицу магазина.</li>
   <li> `active` – указывает, активен ли сотрудник.</li>
   <li> `username` - имя пользователя для входа в систему.</li>
   <li> `password` - пароль для входа.</li>
  <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
<p>Таблица `staff_list`</p>
<ul class="table-columns">
<li> `ID` – уникальный идентификатор для каждой записи в списке сотрудников.</li>
   <li> `name` – имя сотрудника.</li>
   <li> `address` – адрес сотрудника.</li>
   <li> `zip code` – почтовый индекс сотрудника.</li>
   <li> `phone` – номер телефона сотрудника.</li>
   <li> `city` - город сотрудника.</li>
   <li> `country` – страна сотрудника.</li>
   <li> `SID` – внешний ключ, ссылающийся на таблицу персонала.</li>
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
<p>Таблица `store`</p>
<ul class="table-columns">
<li> `store_id` – уникальный идентификатор каждого магазина.</li>
   <li> `manager_staff_id` - внешний ключ, ссылающийся на таблицу персонала менеджера магазина.</li>
   <li> `address_id` - внешний ключ, ссылающийся на таблицу адресов.</li>
  <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
<p>Таблица `payment`</p>
<ul class="table-columns">
  <li> `payment_id` – уникальный идентификатор для каждого платежа.</li>
  <li> `customer_id` - внешний ключ, ссылающийся на таблицу клиентов.</li>
  <li> `staff_id` - внешний ключ, ссылающийся на таблицу персонала.</li>
  <li> `rental_id` - внешний ключ, ссылающийся на таблицу аренды.</li>
  <li> `amount` – сумма платежа.</li>
  <li> `payment_date` – дата платежа.</li>
  <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
    <!-- Additional rows go here if applicable -->
  </table>
</div>
<p>Таблица `inventory`</p>
<ul class="table-columns">
     <li>`inventory_id` – уникальный идентификатор для каждого элемента.</li>
     <li>`film_id` – уникальный идентификатор каждого фильма в таблице.</li>
     <li>`store_id` – уникальный идентификатор магазина, в котором находится товар.</li>
     <li>`last_update` — временная метка последнего изменения записи.</li>
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
    <!-- Add more rows as needed -->
    </table>
</div>
<!-- For Rental Table -->
<p>Таблица `rental`</p>
<ul class="table-columns">
<li> `rental_id` – уникальный идентификатор для каждой аренды.</li>
   <li> `rental_date` – дата, когда произошла аренда.</li>
   <li> `inventory_id` - внешний ключ, ссылающийся на таблицу инвентаризации.</li>
   <li> `customer_id` - внешний ключ, ссылающийся на таблицу клиентов.</li>
   <li> `return_date` – дата возврата взятого напрокат имущества.</li>
   <li> `staff_id` - внешний ключ, ссылающийся на таблицу персонала.</li>
  <li> `last_update` - временная метка создания или последнего обновления строки.</li> 
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
    <!-- Additional rows go here if applicable -->
  </table>
</div>

</div>