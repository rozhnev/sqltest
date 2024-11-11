<div id="db-description" class="db-description">
  <h2>База данных Sakila (MySQL)</h2>
  <p><a style="font-size: small; color: var(--special-text-color);" href="/images/sakila" target="ERDWindow">ER диаграмма базы данных Sakila</a></p>
  Sakila - это пример базы данных, разработанный компанией MySQL, специально созданный для обучения и демонстрации возможностей систем управления базами данных (СУБД) на основе реляционной модели.
  <p>База данных Sakila содержит 15 основных таблиц, описывающих различные аспекты компании по прокату DVD-дисков.</p>
  <p>Ниже приведен список этих таблиц:</p>
  <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
    <li><span class='sql' onclick="scrollInfoPanel('actor_table_description')">actor</span> - таблица актеров.</li>
    <li><span class='sql' onclick="scrollInfoPanel('address_table_description')">address</span> - таблица адресов клиентов и сотрудников.</li>
    <li><span class='sql' onclick="scrollInfoPanel('category_table_description')">category</span> - таблица категорий фильмов.</li>
    <li><span class='sql' onclick="scrollInfoPanel('city_table_description')">city</span> - таблица городов.</li>
    <li><span class='sql' onclick="scrollInfoPanel('country_table_description')">country</span> - таблица стран.</li>
    <li><span class='sql' onclick="scrollInfoPanel('customer_table_description')">customer</span> - таблица клиентов в базе данных Sakila.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_table_description')">film</span> - таблица фильмов в базе данных Sakila.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_actor_table_description')">film_actor</span> - таблица связи актеров и фильмов.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_category_table_description')">film_category</span> - таблица связи фильмов и категорий.</li>
    <li><span class='sql' onclick="scrollInfoPanel('inventory_table_description')">inventory</span> - таблица товаров в базе данных Sakila.</li>
    <li><span class='sql' onclick="scrollInfoPanel('language_table_description')">language</span> - таблица языков фильмов.</li>
    <li><span class='sql' onclick="scrollInfoPanel('payment_table_description')">payment</span> - таблица платежей клиентов.</li>
    <li><span class='sql' onclick="scrollInfoPanel('rental_table_description')">rental</span> - таблица аренды клиентов.</li>
    <li><span class='sql' onclick="scrollInfoPanel('staff_table_description')">staff</span> - таблица сотрудников компании.</li>
    <li><span class='sql' onclick="scrollInfoPanel('store_table_description')">store</span> - таблица магазинов компании.</li>
  </ul>
  {assign var=add_id value=0|mt_rand:4}
  <div class="referal-add-block">
      {if $add_id > 2}
          <a href="https://book24.ru/r/MdRZN?erid=LjN8JzJBX" target="_blank" style="text-decoration: none; display: flex; ">
              <div  style = "width: 30%;">
                  <img style="width: 100%;" src="//ndc.book24.ru/resize/820x1180/pim/products/images/97/d1/01907881-ff4d-78d9-ac6a-7021d02597d1.jpg" alt="SQL: быстрое погружение.">
              </div>
              <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                  <div>Шилдс Уолтер: SQL: быстрое погружение.</div>
                  <div style="font-size: small; padding-top: 0.5em;">
                    Книга «SQL: быстрое погружение» идеальна для всех, кто ищет новые перспективы карьерного роста; для разработчиков, которые хотят расширить свои навыки и знания в программировании; для любого человека, даже без опыта, кто хочет воспользоваться возможностями будущего, в котором будут править данные.
                  </div>
              </div>
          </a>
      {else}
            <a target="_blank" rel="nofollow" href="https://bywiola.com/g/gdhe8x00bcfec845fb2f3b8a152381/?i=4&subid=sql-simulator&erid=2VSb5yk92kp">
              <img style="width:100%;" border="0" src="https://aflink.ru/b/gdhe8x00bcfec845fb2f3b8a152381/" alt="Karpov.courses"/>
            </a>
            <a target="_blank" rel="nofollow" href="https://thevospad.com/g/urkrefnghhfec845fb2f69bd3583e1/?i=4&subid=free-sql-simulator&erid=LatgC8wYQ">
              <img style="width:100%;" border="0" src="https://aflink.ru/b/urkrefnghhfec845fb2f69bd3583e1/" alt="Netology"/>
            </a>
      {/if}
  </div>
  <h3 id="actor_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>actor</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>actor_id</span> - уникальный идентификатор для каждого актера.</li>
    <li> <span class='sql'>first_name</span> - имя актера.</li>
    <li> <span class='sql'>last_name</span> - фамилия актера.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (actor_id)</li>
  </ul>
  <h3 id="address_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>address</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>address_id</span> - уникальный идентификатор для каждого адреса.</li>
    <li> <span class='sql'>address</span> – почтовый адрес.</li>
    <li> <span class='sql'>address2</span> – дополнительный адрес.</li>
    <li> <span class='sql'>district</span> – район или регион.</li>
    <li> <span class='sql'>city_id</span> - внешний ключ, ссылающийся на таблицу городов.</li>
    <li> <span class='sql'>postal_code</span> – почтовый индекс.</li>
    <li> <span class='sql'>phone</span> – номер телефона.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (address_id)</li>
  </ul>
  <h3 id="category_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>category</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>category_id</span> – уникальный идентификатор для каждой категории.</li>
    <li> <span class='sql'>name</span> - название категории.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (category_id)</li>
  </ul>
  <h3 id="city_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>city</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>city_id</span> – уникальный идентификатор для каждого города.</li>
    <li> <span class='sql'>city</span> - название города.</li>
    <li> <span class='sql'>country_id</span> - внешний ключ, ссылающийся на таблицу стран.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (city_id)</li>
  </ul>
  <h3 id="country_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>country</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>country_id</span> – уникальный идентификатор для каждой страны.</li>
    <li> <span class='sql'>country</span> – название страны.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (country_id)</li>
  </ul>
  <h3 id="customer_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>customer</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>customer_id</span> – уникальный идентификатор для каждого клиента.</li>
    <li> <span class='sql'>store_id</span> - внешний ключ, ссылающийся на таблицу магазина.</li>
    <li> <span class='sql'>first_name</span> – имя клиента.</li>
    <li> <span class='sql'>last_name</span> – фамилия клиента.</li>
    <li> <span class='sql'>email</span> – адрес электронной почты клиента.</li>
    <li> <span class='sql'>address_id</span> - внешний ключ, ссылающийся на таблицу адресов.</li>
    <li> <span class='sql'>active</span> – указывает, активен ли клиент.</li>
    <li> <span class='sql'>create_date</span> - временная метка, указывающая, когда клиент был добавлен в базу данных.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (customer_id)</li>
  </ul>
  <h3 id="film_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>film</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>film_id</span> – уникальный идентификатор каждого фильма.</li>
    <li> <span class='sql'>title</span> — название фильма.</li>
    <li> <span class='sql'>description</span> – краткое описание или сюжет фильма.</li>
    <li> <span class='sql'>release_year</span> — год выхода фильма.</li>
    <li> <span class='sql'>language_id</span> — внешний ключ, ссылающийся на таблицу <span class='sql'>language</span> - определяет язык фильма.</li>
    <li> <span class='sql'>original_language_id</span> — внешний ключ, указывающий на таблицу <span class='sql'>language</span> - определяет язык оригинала фильма. Используется, когда фильм дублирован на новый язык.</li>
    <li> <span class='sql'>rental_duration</span> — продолжительность периода аренды в днях.</li>
    <li> <span class='sql'>rental_rate</span> — стоимость проката фильма на период, указанный в столбце rental_duration.</li>
    <li> <span class='sql'>length</span> — продолжительность фильма в минутах.</li>
    <li> <span class='sql'>replacement_cost</span> — сумма, взимаемая с покупателя, если пленка не возвращена или возвращена в поврежденном состоянии.</li>
    <li> <span class='sql'>rating</span> — рейтинг, присвоенный фильму. Может быть одним из: G, PG, PG-13, R или NC-17.</li>
    <li> <span class='sql'>special_features</span> — список общих специальных функций, включенных в DVD. Может быть ноль или более: трейлеры, комментарии, удаленные сцены, за кадром.</li>
    <li> <span class='sql'>last_update</span> — временная метка создания или последнего обновления строки.</li>
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
  Индексы:
  <ul class="table-columns">
      <li>PRIMARY KEY, btree (film_id)</li>
  </ul>
  <h3 id="film_actor_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>film_actor</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>actor_id</span> – уникальный идентификатор актера.</li>
    <li> <span class='sql'>film_id</span> – уникальный идентификатор фильма.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (actor_id, film_id)</li>
  </ul>
  <h3 id="film_category_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>film_category</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>film_id</span> – уникальный идентификатор каждого фильма.</li>
    <li> <span class='sql'>category_id</span> – уникальный идентификатор для каждой категории.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (film_id, category_id)</li>
  </ul>
  <h3 id="inventory_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>inventory</span>
  </h3>
  Колонки: <ul class="table-columns">
      <li><span class='sql'>inventory_id</span> – уникальный идентификатор для каждого элемента.</li>
      <li><span class='sql'>film_id</span> – уникальный идентификатор каждого фильма в таблице.</li>
      <li><span class='sql'>store_id</span> – уникальный идентификатор магазина, в котором находится товар.</li>
      <li><span class='sql'>last_update</span> — временная метка последнего изменения записи.</li>
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (inventory_id)</li>
  </ul>
  <h3 id="language_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>language</span>
  </h3>
  Колонки: <ul class="table-columns">
      <li> <span class='sql'>language_id</span> - уникальный идентификатор для каждого языка.</li>
      <li> <span class='sql'>name</span> - название языка.</li>
      <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (language_id)</li>
  </ul>
  <h3 id="payment_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>payment</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>payment_id</span> – уникальный идентификатор для каждого платежа.</li>
    <li> <span class='sql'>customer_id</span> - внешний ключ, ссылающийся на таблицу клиентов.</li>
    <li> <span class='sql'>staff_id</span> - внешний ключ, ссылающийся на таблицу персонала.</li>
    <li> <span class='sql'>rental_id</span> - внешний ключ, ссылающийся на таблицу аренды.</li>
    <li> <span class='sql'>amount</span> – сумма платежа.</li>
    <li> <span class='sql'>payment_date</span> – дата платежа.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (payment_id)</li>
  </ul>
  <h3 id="rental_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>rental</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>rental_id</span> – уникальный идентификатор для каждой аренды.</li>
    <li> <span class='sql'>rental_date</span> – дата, когда произошла аренда.</li>
    <li> <span class='sql'>inventory_id</span> - внешний ключ, ссылающийся на таблицу инвентаризации.</li>
    <li> <span class='sql'>customer_id</span> - внешний ключ, ссылающийся на таблицу клиентов.</li>
    <li> <span class='sql'>return_date</span> – дата возврата взятого напрокат имущества.</li>
    <li> <span class='sql'>staff_id</span> - внешний ключ, ссылающийся на таблицу персонала.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (rental_id)</li>
  </ul>
  <h3 id="staff_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>staff</span>
  </h3>
  Колонки: <ul class="table-columns">
  <li> <span class='sql'>staff_id</span> – уникальный идентификатор каждого сотрудника.</li>
    <li> <span class='sql'>first_name</span> – имя сотрудника.</li>
    <li> <span class='sql'>last_name</span> - фамилия сотрудника.</li>
    <li> <span class='sql'>address_id</span> - внешний ключ, ссылающийся на таблицу адресов.</li>
    <li> <span class='sql'>picture</span> – изображение сотрудника.</li>
    <li> <span class='sql'>email</span> - адрес электронной почты сотрудника.</li>
    <li> <span class='sql'>store_id</span> - внешний ключ, ссылающийся на таблицу магазина.</li>
    <li> <span class='sql'>active</span> – указывает, активен ли сотрудник.</li>
    <li> <span class='sql'>username</span> - имя пользователя для входа в систему.</li>
    <li> <span class='sql'>password</span> - пароль для входа.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
    </table>
  </div>
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (staff_id)</li>
  </ul>
  <h3 id="store_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Таблица <span class='sql'>store</span>
  </h3>
  Колонки: <ul class="table-columns">
    <li> <span class='sql'>store_id</span> – уникальный идентификатор каждого магазина.</li>
    <li> <span class='sql'>manager_staff_id</span> - внешний ключ, ссылающийся на таблицу персонала менеджера магазина.</li>
    <li> <span class='sql'>address_id</span> - внешний ключ, ссылающийся на таблицу адресов.</li>
    <li> <span class='sql'>last_update</span> - временная метка создания или последнего обновления строки.</li> 
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
  Индексы:
  <ul class="table-columns">
    <li>PRIMARY KEY, btree (store_id)</li>
  </ul>
</div>
