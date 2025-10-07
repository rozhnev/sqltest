<div id="db-description" class="db-description">
  <style>
      .table-columns span {
          min-width: 6rem;
      }
  </style>
  <h2>База данных Sakila (MySQL)</h2>
  Sakila - это пример базы данных, разработанный компанией MySQL, специально созданный для обучения и демонстрации возможностей систем управления базами данных (СУБД) на основе реляционной модели.
  <p>
      <a class="button-erd" href="/{$Lang}/erd/Sakila" target="ERDWindow">
          ER диаграмма базы данных Sakila
      </a>
  </p>
  <p>База данных Sakila содержит 15 основных таблиц, описывающих различные аспекты компании по прокату DVD-дисков.</p>
  <h3>Список таблиц:</h3>
  <div class="accordion">
      <span><span class='sql'>actor</span> - таблица актеров.</span>
  </div>
  <div class="panel">
      <ul class="table-columns" >
          <li> <span class='sql'>actor_id</span>уникальный идентификатор записи (ПК).</li>
          <li> <span class='sql'>first_name</span>имя актера.</li>
          <li> <span class='sql'>last_name</span>фамилия актера.</li>
          <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>address</span> - адреса клиентов и сотрудников.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>address_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>address</span>почтовый адрес.</li>
            <li> <span class='sql'>address2</span>дополнительный адрес.</li>
            <li> <span class='sql'>district</span>район или регион.</li>
            <li> <span class='sql'>city_id</span>идентификатор городов (ВК).</li>
            <li> <span class='sql'>postal_code</span>почтовый индекс.</li>
            <li> <span class='sql'>phone</span>номер телефона.</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>category</span> - категории фильмов
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>category_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>name</span>название категории.</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>city</span> - таблица городов
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>city_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>city</span>название города.</li>
            <li> <span class='sql'>country_id</span>идентификатор страны (ВК).</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>country</span> - таблица стран
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>country_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>country</span>название страны.</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>customer</span> - таблица клиентов
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>store_id</span>идентификатор магазина (ВК).</li>
            <li> <span class='sql'>first_name</span>имя клиента.</li>
            <li> <span class='sql'>last_name</span>фамилия клиента.</li>
            <li> <span class='sql'>email</span>адрес электронной почты клиента.</li>
            <li> <span class='sql'>address_id</span>идентификатор адреса (ВК).</li>
            <li> <span class='sql'>active</span>идикатор активности клиента (0/1).</li>
            <li> <span class='sql'>create_date</span>дата и время добавления клиента в базу данных.</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>film</span> - таблица фильмов
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 10rem;">film_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql' style="min-width: 10rem;">title</span>название фильма.</li>
            <li> <span class='sql' style="min-width: 10rem;">description</span>краткое описание или сюжет фильма.</li>
            <li> <span class='sql' style="min-width: 10rem;">release_year</span>год выхода фильма.</li>
            <li> <span class='sql' style="min-width: 10rem;">language_id</span>идентификатор языка фильма (ВК).</li>
            <li> <span class='sql' style="min-width: 10rem;">original_language_id</span>идентификатор языка оригинала фильма в случае, если фильм дублирован на новый язык.</li>
            <li> <span class='sql' style="min-width: 10rem;">rental_duration</span>продолжительность периода аренды в днях.</li>
            <li> <span class='sql' style="min-width: 10rem;">rental_rate</span>стоимость проката фильма на период, указанный в столбце rental_duration.</li>
            <li> <span class='sql' style="min-width: 10rem;">length</span>продолжительность фильма в минутах.</li>
            <li> <span class='sql' style="min-width: 10rem;">replacement_cost</span>сумма штрафа за утерю или порчу диска.</li>
            <li> <span class='sql' style="min-width: 10rem;">rating</span>рейтинг, присвоенный фильму. Может быть одним из: G, PG, PG-13, R или NC-17.</li>
            <li> <span class='sql' style="min-width: 10rem;">special_features</span>список общих специальных функций, включенных в DVD. Может быть ноль или более: трейлеры, комментарии, удаленные сцены, за кадром.</li>
            <li> <span class='sql' style="min-width: 10rem;">last_update</span>дата и время последнего изменения.</li>
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
        <span class='sql'>film_actor</span> - отношение актеров и фильмов
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>идентификатор актера (ВК).</li>
            <li> <span class='sql'>film_id</span>идентификатор фильма (ВК).</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>film_category</span> - отношение фильмов к категориям
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>film_id</span>идентификатор фильма (ВК).</li>
            <li> <span class='sql'>category_id</span>идентификатор категории (ВК).</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>inventory</span> - список дисков в филиалах компании
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>inventory_id</span>уникальный идентификатор записи (ПК).</li>
            <li><span class='sql'>film_id</span>идентификатор фильма (ВК).</li>
            <li><span class='sql'>store_id</span>идентификатор филиала, в котором находится диск (ВК).</li>
            <li><span class='sql'>last_update</span>дата и время последнего изменения.</li>
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
        <span class='sql'>language</span> - языки фильмов
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>language_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>name</span>название языка.</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>payment</span> - платежи клиентов
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">payment_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql' style="min-width: 8rem;">customer_id</span>идентификатор клиента (ВК).</li>
            <li> <span class='sql' style="min-width: 8rem;">staff_id</span>идентификатор персонала принявшего платёж (ВК).</li>
            <li> <span class='sql' style="min-width: 8rem;">rental_id</span>идентификатор записи аренды (ВК).</li>
            <li> <span class='sql' style="min-width: 8rem;">amount</span>сумма платежа.</li>
            <li> <span class='sql' style="min-width: 8rem;">payment_date</span>дата и время платежа.</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>rental</span> - таблица аренды дисков
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>rental_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>rental_date</span>дата начала аренды.</li>
            <li> <span class='sql'>inventory_id</span>идентификатор диска (ВК).</li>
            <li> <span class='sql'>customer_id</span>идентификатор клиента (ВК).</li>
            <li> <span class='sql'>return_date</span>дата возврата фильма.</li>
            <li> <span class='sql'>staff_id</span>идентификатор персонала выдавшего диск (ВК).</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>staff</span> - сотрудники компании
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>staff_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql'>first_name</span>имя сотрудника.</li>
            <li> <span class='sql'>last_name</span>фамилия сотрудника.</li>
            <li> <span class='sql'>address_id</span>идентификатор адреса (ВК).</li>
            <li> <span class='sql'>picture</span>фотография сотрудника.</li>
            <li> <span class='sql'>email</span>адрес электронной почты сотрудника.</li>
            <li> <span class='sql'>store_id</span>внешний ключ, ссылающийся на таблицу магазина (ВК).</li>
            <li> <span class='sql'>active</span>идикатор активности сотрудника (0/1).</li>
            <li> <span class='sql'>username</span>имя пользователя для входа в систему.</li>
            <li> <span class='sql'>password</span>пароль для входа.</li>
            <li> <span class='sql'>last_update</span>дата и время последнего изменения.</li> 
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
        <span class='sql'>store</span> - филиалы компании
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">store_id</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class='sql' style="min-width: 8rem;">manager_staff_id</span>идентификатор менеджера магазина (ВК).</li>
            <li> <span class='sql' style="min-width: 8rem;">address_id</span>идентификатор адреса (ВК).</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>дата и время последнего изменения.</li> 
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
        {* <div class="referal-add-block">
            <div id="yandex_rtb_R-A-4716552-7"></div>
            <!-- admitad.banner: zgiqkhys12fec845fb2f47ed6832c6 Atomic Heart [CPS] RU+CIS -->
            <a target="_blank" rel="nofollow" href="https://rzekl.com/g/zgiqkhys12fec845fb2f47ed6832c6/?i=4&subid=InstinctOfExtermination&erid=5jtCeReNwxHpfQTGQG2GywH">
                <img style="width:100%;" border="0" src="https://aflink.ru/b/zgiqkhys12fec845fb2f47ed6832c6/" alt="Atomic Heart [CPS] RU+CIS"/>
            </a>
            <!-- /admitad.banner -->
            <a target="_blank" rel="nofollow" href="https://thevospad.com/g/go2e1mhf52fec845fb2f69bd3583e1/?i=4&subid=analyst-from-zero&erid=LatgC6bAt">
                <img style="width:100%;" border="0" src="https://aflink.ru/b/go2e1mhf52fec845fb2f69bd3583e1/" alt="Netology"/>
            </a>
        </div> *}
        {include file="ru/developers_channel_ad.tpl"}
    {/if}
</div>
