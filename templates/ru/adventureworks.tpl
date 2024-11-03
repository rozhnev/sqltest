<div id="db-description" class="db-description">
  {literal}
    <h2>База данных AdventureWorks (SQL Server)</h2>
    <p>База данных AdventureWorks — это образец базы данных, демонстрирующий возможности SQL Server. Он включает данные о
      вымышленной производственной компании.</p>
    <p><a style="font-size: small; color: var(--special-text-color);" href="/images/adventureworks" target="ERDWindow">ER диаграмма базы данных AdventureWorks</a></p>
    <p>Ниже приведен список этих таблиц:</p>
    <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
      <li><span class='sql' onclick="scrollInfoPanel('Address_table_description')">Address</span> - таблица адресов.</li>
      <li><span class='sql' onclick="scrollInfoPanel('Customer_table_description')">Customer</span> - таблица клиентов</li>
      <li><span class='sql' onclick="scrollInfoPanel('CustomerAddress_table_description')">CustomerAddress</span> - таблица отношений клиентов и адресов.</li>
      <li><span class='sql' onclick="scrollInfoPanel('Product_table_description')">Product</span> - таблица товаров.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductCategory_table_description')">ProductCategory</span> - таблица категорий товаров.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductDescription_table_description')">ProductDescription</span> - таблица описаний товаров.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductModel_table_description')">ProductModel</span> - таблица моделей товаров.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductModelProductDescription_table_description')">ProductModelProductDescription</span> - таблица описаний моделей товаров.</li>
      <li><span class='sql' onclick="scrollInfoPanel('SalesOrderDetail_table_description')">SalesOrderDetail</span> - таблица заказов.</li>
      <li><span class='sql' onclick="scrollInfoPanel('SalesOrderHeader_table_description')">SalesOrderHeader</span> - таблица деталей заказов.</li>
    </ul>
    <a href="https://book24.ru/r/vPcru?erid=LjN8K1JdK" target="_blank" style="text-decoration: none;">
      <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">
        <div  style = "width: 30%;">
            <img style="width: 100%;" src="//ndc.book24.ru/resize/410x590/pim/products/images/2a/23/018edf56-f466-7e54-b41e-7cd2a6b02a23.jpg" alt="Грабер Мартин: SQL.">
        </div>
        <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
            <div>Грабер Мартин: SQL</div>
            <div style="font-size: small; padding-top: 0.5em;">
            Классическая работа по SQL. Эта книга - отличный источник знаний для всех, кто программирует на SQL. 
            В книге дано подробное описание языка, поэтому от читателя не требуется никакой предварительной подготовки. Сопровождаемая практическими учебными материалами, книга представляет собой полное справочное руководство по SQL.
          </div>
        </div>
      </div>
    </a>
    <h3 id="Address_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>Address</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">AddressID</span> - уникальный идентификатор для каждого адреса.</li>
      <li> <span class="sql">AddressLine1</span> - первая строка адреса.</li>
      <li> <span class="sql">AddressLine2</span> - вторая строка адреса.</li>
      <li> <span class="sql">StateProvince</span> - город.</li>
      <li> <span class="sql">CountryRegion</span> - страна.</li>
      <li> <span class="sql">PostalCode</span> - почтовый индекс.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>AddressID</th>
            <th>AddressLine1</th>
            <th>AddressLine2</th>
            <th>City</th>
            <th>StateProvince</th>
            <th>CountryRegion</th>
            <th>PostalCode</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>9</td>
            <td>8713 Yosemite Ct.</td>
            <td>null</td>
            <td>Bothell</td>
            <td>Washington</td>
            <td>United States</td>
            <td>98011</td>
            <td>268AF621-76D7-4C78-9441-144FD139821A</td>
            <td>2006-07-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (AddressID)</li>
    </ul>
    <h3 id="Customer_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>Customer</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">CustomerID</span> - уникальный идентификатор для каждого клиента.</li>
      <li> <span class="sql">NameStyle</span> - 0 = Данные в FirstName и LastName хранятся в западном стиле (имя, фамилия). 1 = Восточный стиль (фамилия, имя) порядок.
      По умолчанию: 0.</li>
      <li> <span class="sql">Title</span> - обращение.</li>
      <li> <span class="sql">FirstName</span> - имя.</li>
      <li> <span class="sql">MiddleName</span> - второе имя.</li>
      <li> <span class="sql">LastName</span> - фамилия.</li>
      <li> <span class="sql">Suffix</span> - suffix.</li>
      <li> <span class="sql">CompanyName</span> - название компании.</li>
      <li> <span class="sql">SalesPerson</span> - SalesPerson.</li>
      <li> <span class="sql">EmailAddress</span> - E-mail.</li>
      <li> <span class="sql">Phone</span> - номер телефона.</li>
      <li> <span class="sql">PasswordHash</span> - хеш пароля.</li>
      <li> <span class="sql">PasswordSalt</span> - соль.</li>
      <li> <span class="sql">rowguid</span> - rowguid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>CustomerID</th>
            <th>NameStyle</th>
            <th>Title</th>
            <th>FirstName</th>
            <th>MiddleName</th>
            <th>LastName</th>
            <th>Suffix</th>
            <th>CompanyName</th>
            <th>SalesPerson</th>
            <th>EmailAddress</th>
            <th>Phone</th>
            <th>PasswordHash</th>
            <th>PasswordSalt</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>1</td>
            <td>0</td>
            <td>Mr.</td>
            <td>Orlando</td>
            <td>N.</td>
            <td>Gee</td>
            <td>[null]</td>
            <td>A Bike Store</td>
            <td>adventure-works\pamela0</td>
            <td>orlando0@adventure-works.com</td>
            <td>245-555-0173</td>
            <td>L/Rlwxzp4w7RWmEgXX+/A7cXaePEPcp+KwQhl2fJL7w=</td>
            <td>1KjXYs4=</td>
            <td>3F5AE95E-B87D-4AED-95B4-C3797AFCB74F</td>
            <td>2005-08-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (CustomerID)</li>
    </ul>
    <h3 id="CustomerAddress_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>CustomerAddress</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">CustomerID</span> - уникальный идентификатор клиента в таблице <span class="sql">Customer</span>.</li>
      <li> <span class="sql">AddressID</span> - уникальный идентификатор адреса в таблице <span class="sql">Address</span>.</li>
      <li> <span class="sql">AddressType</span> - тип адреса.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>CustomerID</th>
            <th>AddressID</th>
            <th>AddressType</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>29485</td>
            <td>1086</td>
            <td>Main Office</td>
            <td>16765338-DBE4-4421-B5E9-3836B9278E63</td>
            <td>2007-09-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (CustomerID, AddressID)</li>
    </ul>
    <h3 id="Product_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>Product</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">ProductID</span> - уникальный идентификатор для каждого товара.</li>
      <li> <span class="sql">Name</span> - наименование товара.</li>
      <li> <span class="sql">ProductNumber</span> - артикул.</li>
      <li> <span class="sql">Color</span> - цвет товара.</li>
      <li> <span class="sql">StandardCost</span> - цена товара.</li>
      <li> <span class="sql">ListPrice</span> - цена товара в каталоге.</li>
      <li> <span class="sql">Size</span> - размер товара.</li>
      <li> <span class="sql">Weight</span> - вес товара.</li>
      <li> <span class="sql">ProductCategoryID</span> - внешний ключ, указывающий на таблицу <span
          class="sql">ProductCategory</span> - определяет категорию товара.</li>
      <li> <span class="sql">ProductModelID</span> - внешний ключ, указывающий на таблицу <span
          class="sql">ProductModel</span> - определяет модель товара.</li>
      <li> <span class="sql">SellStartDate</span> - временная метка даты начала продаж.</li>
      <li> <span class="sql">SellEndDate</span> - временная метка даты окончания продаж.</li>
      <li> <span class="sql">DiscontinuedDate</span> - временная метка даты окончания продаж.</li>
      <li> <span class="sql">ThumbNailPhoto</span> - миниатюра фото товара.</li>
      <li> <span class="sql">ThumbnailPhotoFileName</span> - имя файла миниатюры фото.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>ProductID</th>
            <th>Name</th>
            <th>ProductNumber</th>
            <th>Color</th>
            <th>StandardCost</th>
            <th>ListPrice</th>
            <th>Size</th>
            <th>Weight</th>
            <th>ProductCategoryID</th>
            <th>ProductModelID</th>
            <th>SellStartDate</th>
            <th>SellEndDate</th>
            <th>DiscontinuedDate</th>
            <th>ThumbNailPhoto</th>
            <th>ThumbnailPhotoFileName</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>680</td>
            <td>HL Road Frame - Black, 58</td>
            <td>FR-R92B-58</td>
            <td>Black</td>
            <td>1059.3100</td>
            <td>1431.5000</td>
            <td>58</td>
            <td>1016.04</td>
            <td>18</td>
            <td>6</td>
            <td>2002-06-01 00:00:00.000</td>
            <td>[null]</td>
            <td>[null]</td>
            <td>[binary]</td>
            <td>no_image_available_small.gif</td>
            <td>43DD68D6-14A4-461F-9069-55309D90EA7E</td>
            <td>2008-03-11 10:01:36.827</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (ProductID, ProductCategoryID, ProductModelID)</li>
    </ul>
    <h3 id="ProductCategory_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>ProductCategory</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">ProductCategoryID</span> - уникальный идентификатор для каждой категории товара.</li>
      <li> <span class="sql">ParentProductCategoryID</span> - идентификатор родительской категории товара.</li>
      <li> <span class="sql">Name</span> - название категории товара.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>ProductCategoryID</th>
            <th>ParentProductCategoryID</th>
            <th>Name</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>1</td>
            <td>[null]</td>
            <td>Bikes</td>
            <td>CFBDA25C-DF71-47A7-B81B-64EE161AA37C</td>
            <td>2002-06-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (ProductCategoryID)</li>
    </ul>
    <h3 id="ProductDescription_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>ProductDescription</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">ProductDescriptionID</span> - уникальный идентификатор для каждого описания товара.</li>
      <li> <span class="sql">Description</span> - описание товара.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>ProductDescriptionID</th>
            <th>Description</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>4</td>
            <td>Aluminum alloy cups; large diameter spindle.</td>
            <td>DFEBA528-DA11-4650-9D86-CAFDA7294EB0</td>
            <td>2007-06-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (ProductDescriptionID)</li>
    </ul>
    <h3 id="ProductModel_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>ProductModel</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">ProductModelID</span> - уникальный идентификатор для каждой модели товара.</li>
      <li> <span class="sql">Name</span> - название модели товара.</li>
      <li> <span class="sql">CatalogDescription</span> - описание в формате XML.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>ProductModelID</th>
            <th>Name</th>
            <th>CatalogDescription</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>1</td>
            <td>Classic Vest</td>
            <td>[null]</td>
            <td>29321D47-1E4C-4AAC-887C-19634328C25E</td>
            <td>2007-06-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (ProductModelID)</li>
    </ul>
    <h3 id="ProductModelProductDescription_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>ProductModelProductDescription</span>
    </h3>
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">ProductModelID</span> - уникальный идентификатор клиента в таблице <span class="sql">ProductModel</span>.</li>
      <li> <span class="sql">ProductDescriptionID</span> - уникальный идентификатор адреса в таблице <span class="sql">ProductDescription</span>.</li>
      <li> <span class="sql">Culture</span> - языковой код в формате ISO.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>ProductModelID</th>
            <th>ProductDescriptionID</th>
            <th>Culture</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>1</td>
            <td>1199</td>
            <td>en</td>
            <td>4D00B649-027A-4F99-A380-F22A46EC8638</td>
            <td>2007-06-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (ProductModelID, ProductDescriptionID)</li>
    </ul>
    <h3 id="SalesOrderDetail_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>SalesOrderDetail</span>
    </h3>   
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">SalesOrderID</span> - внешний ключ, ссылающийся на таблицу <span class="sql">SalesOrderHeader</span>.</li>
      <li> <span class="sql">SalesOrderDetailID</span> - уникальный идентификатор строки.</li>
      <li> <span class="sql">OrderQty</span> - количество.</li>
      <li> <span class="sql">ProductID</span> - внешний ключ, ссылающийся на таблицу <span class="sql">Product</span>.</li>
      <li> <span class="sql">UnitPrice</span> - цена за единицу товара.</li>
      <li> <span class="sql">UnitPriceDiscount</span> - цена за единицу товара со скидкой.</li>
      <li> <span class="sql">LineTotal</span> - Итого.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>
    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>SalesOrderID</th>
            <th>SalesOrderDetailID</th>
            <th>OrderQty</th>
            <th>ProductID</th>
            <th>UnitPrice</th>
            <th>UnitPriceDiscount</th>
            <th>LineTotal</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>71774</td>
            <td>110562</td>
            <td>1</td>
            <td>836</td>
            <td>356.8980</td>
            <td>.0000</td>
            <td>356.898000</td>
            <td>E3A1994C-7A68-4CE8-96A3-77FDD3BBD730</td>
            <td>2008-06-01 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (SalesOrderID, SalesOrderDetailID, ProductID)</li>
    </ul>
    <h3 id="SalesOrderHeader_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Таблица <span class='sql'>SalesOrderHeader</span>
    </h3> 
    Колонки:
    <ul class="table-columns">
      <li> <span class="sql">SalesOrderID</span> - уникальный идентификатор заказа в таблице.</li>
      <li> <span class="sql">RevisionNumber</span> - номер ревизии.</li>
      <li> <span class="sql">OrderDate</span> - временная метка создания даты заказа.</li>
      <li> <span class="sql">DueDate</span> - временная метка даты оплаты заказа.</li>
      <li> <span class="sql">ShipDate</span> - временная метка даты отправки заказа.</li>
      <li> <span class="sql">Status</span> - статус заказа.</li>
      <li> <span class="sql">OnlineOrderFlag</span> - онлайн-заказ (да/нет).</li>
      <li> <span class="sql">SalesOrderNumber</span> - номер заказа.</li>
      <li> <span class="sql">PurchaseOrderNumber</span> - номер покупки.</li>
      <li> <span class="sql">AccountNumber</span> - номер счета.</li>
      <li> <span class="sql">CustomerID</span> - внешний ключ, ссылающийся на таблицу <span class="sql">Customer</span> -
        определяет клиента.</li>
      <li> <span class="sql">ShipToAddressID</span> - внешний ключ, ссылающийся на таблицу <span
          class="sql">Address</span> - определяет адрес доставки.</li>
      <li> <span class="sql">BillToAddressID</span> - внешний ключ, ссылающийся на таблицу <span
          class="sql">Address</span> - определяет адрес счета.</li>
      <li> <span class="sql">ShipMethod</span> - метод доставки.</li>
      <li> <span class="sql">CreditCardApprovalCode</span> - код подтверждения кредитной карты.</li>
      <li> <span class="sql">SubTotal</span> - промежуточный итог.</li>
      <li> <span class="sql">TaxAmt</span> - налоги.</li>
      <li> <span class="sql">Freight</span> - стоимость доставки.</li>
      <li> <span class="sql">TotalDue</span> - итого.</li>
      <li> <span class="sql">Comment</span> - комментарий.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - временная метка создания или последнего обновления строки.</li>
    </ul>

    <div class="table-wrapper">
      <table>
        <tbody>
          <tr>
            <th>SalesOrderID</th>
            <th>RevisionNumber</th>
            <th>OrderDate</th>
            <th>DueDate</th>
            <th>ShipDate</th>
            <th>Status</th>
            <th>OnlineOrderFlag</th>
            <th>SalesOrderNumber</th>
            <th>PurchaseOrderNumber</th>
            <th>AccountNumber</th>
            <th>CustomerID</th>
            <th>ShipToAddressID</th>
            <th>BillToAddressID</th>
            <th>ShipMethod</th>
            <th>CreditCardApprovalCode</th>
            <th>SubTotal</th>
            <th>TaxAmt</th>
            <th>Freight</th>
            <th>TotalDue</th>
            <th>Comment</th>
            <th>rowguid</th>
            <th>ModifiedDate</th>
          </tr>
          <tr>
            <td>71774</td>
            <td>2</td>
            <td>2008-06-01 00:00:00.000</td>
            <td>2008-06-13 00:00:00.000</td>
            <td>2008-06-08 00:00:00.000</td>
            <td>5</td>
            <td>0</td>
            <td>SO71774</td>
            <td>PO348186287</td>
            <td>10-4020-000609</td>
            <td>29847</td>
            <td>1092</td>
            <td>1092</td>
            <td>CARGO TRANSPORT 5</td>
            <td>[null]</td>
            <td>880.3484</td>
            <td>70.4279</td>
            <td>22.0087</td>
            <td>972.7850</td>
            <td>[null]</td>
            <td>89E42CDC-8506-48A2-B89B-EB3E64E3554E</td>
            <td>2008-06-08 00:00:00.000</td>
          </tr>
        </tbody>
      </table>
    </div>
    Индексы:
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (SalesOrderID, CustomerID, ShipToAddressID, BillToAddressID)</li>
    </ul>
  {/literal}
</div>