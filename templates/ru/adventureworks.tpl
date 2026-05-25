<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h1>База данных AdventureWorks: структура таблиц и обзор схемы</h1>
    <p>База AdventureWorks (SQL Server) - это учебный набор данных, моделирующий бизнес-процессы вымышленной производственной компании.</p>
    <p>На этой странице показаны структура таблиц, ключевые поля и связи, которые используются при изучении и практике SQL.</p>
    <p>База данных AdventureWorks содержит 10 основных таблиц.</p>
    <p>
        <a href="/{$Lang}/erd/AdventureWorks" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Открыть ER-диаграмму базы AdventureWorks в новом окне">
                        <img src="/images/erd_small_light.svg" alt="ER-диаграмма базы AdventureWorks со связями между таблицами" style="width: 90%;" loading="lazy" decoding="async">
            ER диаграмма базы данных AdventureWorks
        </a>
    </p>
    <h2>Список таблиц</h2>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>Address</span> - таблица адресов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">AddressID</span>уникальный идентификатор записи (ПК)</li>
            <li> <span class="sql">AddressLine1</span>первая строка адреса</li>
            <li> <span class="sql">AddressLine2</span>вторая строка адреса</li>
            <li> <span class="sql">City</span>город</li>
            <li> <span class="sql">StateProvince</span>штат или провинция</li>
            <li> <span class="sql">CountryRegion</span>страна</li>
            <li> <span class="sql">PostalCode</span>почтовый индекс</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>временная метка создания или последнего обновления строки</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (AddressID)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">AddressID</th>
                    <th scope="col">AddressLine1</th>
                    <th scope="col">AddressLine2</th>
                    <th scope="col">City</th>
                    <th scope="col">StateProvince</th>
                    <th scope="col">CountryRegion</th>
                    <th scope="col">PostalCode</th>
                    <th scope="col">rowguid</th>
                    <th scope="col">ModifiedDate</th>
                </tr></thead><tbody><tr>
                    <td>9</td>
                    <td>8713 Yosemite Ct.</td>
                    <td>null</td>
                    <td>Bothell</td>
                    <td>Washington</td>
                    <td>United States</td>
                    <td>98011</td>
                    <td>268AF621-76D7-4C78-9441-144FD139821A</td>
                    <td>2006-07-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>Customer</span> - таблица клиентов.</span>
    </div>
    <div class="panel">
    <ul class="table-columns">
      <li> <span class="sql">CustomerID</span>уникальный идентификатор записи (ПК)</li>
      <li> <span class="sql">NameStyle</span>0 = Данные в FirstName и LastName хранятся в западном стиле (имя, фамилия). 1 = Восточный стиль (фамилия, имя) порядок.
      По умолчанию: 0</li>
      <li> <span class="sql">Title</span>обращение</li>
      <li> <span class="sql">FirstName</span>имя</li>
      <li> <span class="sql">MiddleName</span>второе имя</li>
      <li> <span class="sql">LastName</span>фамилия</li>
      <li> <span class="sql">Suffix</span>суффикс</li>
      <li> <span class="sql">CompanyName</span>название компании</li>
      <li> <span class="sql">SalesPerson</span>контактная персона</li>
      <li> <span class="sql">EmailAddress</span>E-mail</li>
      <li> <span class="sql">Phone</span>номер телефона</li>
      <li> <span class="sql">PasswordHash</span>хеш пароля</li>
      <li> <span class="sql">PasswordSalt</span>соль</li>
      <li> <span class="sql">rowguid</span>rowguid</li>
      <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения</li>
    </ul>
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (CustomerID)</li>
    </ul>
    <div class="table-wrapper">
      <table><thead><tr>
            <th scope="col">CustomerID</th>
            <th scope="col">NameStyle</th>
            <th scope="col">Title</th>
            <th scope="col">FirstName</th>
            <th scope="col">MiddleName</th>
            <th scope="col">LastName</th>
            <th scope="col">Suffix</th>
            <th scope="col">CompanyName</th>
            <th scope="col">SalesPerson</th>
            <th scope="col">EmailAddress</th>
            <th scope="col">Phone</th>
            <th scope="col">PasswordHash</th>
            <th scope="col">PasswordSalt</th>
            <th scope="col">rowguid</th>
            <th scope="col">ModifiedDate</th>
          </tr></thead><tbody><tr>
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
          </tr></tbody></table>
    </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>CustomerAddress</span> - таблица связи клиентов и адресов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>уникальный идентификатор записи (ПК)</li>
            <li> <span class="sql">AddressID</span>идентификатор адреса в таблице Address</li>
            <li> <span class="sql">AddressType</span>тип адреса</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (CustomerID, AddressID)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)</li>
            <li>FOREIGN KEY (AddressID) REFERENCES Address(AddressID)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">CustomerID</th>
                    <th scope="col">AddressID</th>
                    <th scope="col">AddressType</th>
                    <th scope="col">rowguid</th>
                    <th scope="col">ModifiedDate</th>
                </tr></thead><tbody><tr>
                    <td>29485</td>
                    <td>1086</td>
                    <td>Main Office</td>
                    <td>16765338-DBE4-4421-B5E9-3836B9278E63</td>
                    <td>2007-09-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>Product</span> - таблица товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 11rem;">ProductID</span>уникальный идентификатор записи (ПК)</li>
            <li> <span class="sql" style="min-width: 11rem;">Name</span>наименование товара</li>
            <li> <span class="sql" style="min-width: 11rem;">ProductNumber</span>артикул</li>
            <li> <span class="sql" style="min-width: 11rem;">Color</span>цвет товара</li>
            <li> <span class="sql" style="min-width: 11rem;">StandardCost</span>цена товара</li>
            <li> <span class="sql" style="min-width: 11rem;">ListPrice</span>цена товара в каталоге</li>
            <li> <span class="sql" style="min-width: 11rem;">Size</span>размер товара</li>
            <li> <span class="sql" style="min-width: 11rem;">Weight</span>вес товара</li>
            <li> <span class="sql" style="min-width: 11rem;">ProductCategoryID</span>идентификатор категории товара</li>
            <li> <span class="sql" style="min-width: 11rem;">ProductModelID</span>идентификатор модели товара</li>
            <li> <span class="sql" style="min-width: 11rem;">SellStartDate</span>временная метка даты начала продаж</li>
            <li> <span class="sql" style="min-width: 11rem;">SellEndDate</span>временная метка даты окончания продаж</li>
            <li> <span class="sql" style="min-width: 11rem;">DiscontinuedDate</span>временная метка даты окончания продаж</li>
            <li> <span class="sql" style="min-width: 11rem;">ThumbNailPhoto</span>миниатюра фото товара</li>
            <li> <span class="sql" style="min-width: 14rem;">ThumbnailPhotoFileName</span>имя файла мини фото</li>
            <li> <span class="sql" style="min-width: 11rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 11rem;">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductID, ProductCategoryID, ProductModelID)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID)</li>
            <li>FOREIGN KEY (ProductModelID) REFERENCES ProductModel(ProductModelID)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                  <th scope="col">ProductID</th>
                  <th scope="col">Name</th>
                  <th scope="col">ProductNumber</th>
                  <th scope="col">Color</th>
                  <th scope="col">StandardCost</th>
                  <th scope="col">ListPrice</th>
                  <th scope="col">Size</th>
                  <th scope="col">Weight</th>
                  <th scope="col">ProductCategoryID</th>
                  <th scope="col">ProductModelID</th>
                  <th scope="col">SellStartDate</th>
                  <th scope="col">SellEndDate</th>
                  <th scope="col">DiscontinuedDate</th>
                  <th scope="col">ThumbNailPhoto</th>
                  <th scope="col">ThumbnailPhotoFileName</th>
                  <th scope="col">rowguid</th>
                  <th scope="col">ModifiedDate</th>
                </tr></thead><tbody><tr>
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
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>ProductCategory</span> - категории товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14.5rem;">ProductCategoryID</span>уникальный идентификатор записи (ПК)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ParentProductCategoryID</span>ID родительской категории</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Name</span>название категории товара</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductCategoryID)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (ParentProductCategoryID) REFERENCES ProductCategory(ProductCategoryID)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">ProductCategoryID</th>
                    <th scope="col">ParentProductCategoryID</th>
                    <th scope="col">Name</th>
                    <th scope="col">rowguid</th>
                    <th scope="col">ModifiedDate</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>[null]</td>
                    <td>Bikes</td>
                    <td>CFBDA25C-DF71-47A7-B81B-64EE161AA37C</td>
                    <td>2002-06-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>ProductDescription</span> - описание товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14rem;">ProductDescriptionID</span>уникальный идентификатор записи (ПК)</li>
            <li> <span class="sql" style="min-width: 14rem;">Description</span>описание товара</li>
            <li> <span class="sql" style="min-width: 14rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14rem;">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductDescriptionID)</li>
        </ul>
        <div class="table-wrapper">
          <table><thead><tr>
                  <th scope="col">ProductDescriptionID</th>
                  <th scope="col">Description</th>
                  <th scope="col">rowguid</th>
                  <th scope="col">ModifiedDate</th>
              </tr></thead><tbody><tr>
                  <td>4</td>
                  <td>Aluminum alloy cups; large diameter spindle.</td>
                  <td>DFEBA528-DA11-4650-9D86-CAFDA7294EB0</td>
                  <td>2007-06-01 00:00:00.000</td>
              </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>ProductModel</span> - модели товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>уникальный идентификатор записи (ПК)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>название модели товара</li>
            <li> <span class="sql" style="min-width: 12rem;">CatalogDescription</span>описание в формате XML</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductModelID)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">ProductModelID</th>
                    <th scope="col">Name</th>
                    <th scope="col">CatalogDescription</th>
                    <th scope="col">rowguid</th>
                    <th scope="col">ModifiedDate</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>Classic Vest</td>
                    <td>[null]</td>
                    <td>29321D47-1E4C-4AAC-887C-19634328C25E</td>
                    <td>2007-06-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>ProductModelProductDescription</span> - описание моделей товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 13rem;">ProductModelID</span>идентификатор товара</li>
            <li> <span class="sql" style="min-width: 13rem;">ProductDescriptionID</span>ID описания товара</li>
            <li> <span class="sql" style="min-width: 13rem;">Culture</span>языковой код в формате ISO</li>
            <li> <span class="sql" style="min-width: 13rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 13rem;">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductModelID, ProductDescriptionID)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (ProductModelID) REFERENCES ProductModel(ProductModelID)</li>
            <li>FOREIGN KEY (ProductDescriptionID) REFERENCES ProductDescription(ProductDescriptionID)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">ProductModelID</th>
                    <th scope="col">ProductDescriptionID</th>
                    <th scope="col">Culture</th>
                    <th scope="col">rowguid</th>
                    <th scope="col">ModifiedDate</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>1199</td>
                    <td>en</td>
                    <td>4D00B649-027A-4F99-A380-F22A46EC8638</td>
                    <td>2007-06-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>SalesOrderDetail</span> - детали заказов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 13rem;">SalesOrderID</span>идентификатор заказа</li>
            <li> <span class="sql" style="min-width: 13rem;">SalesOrderDetailID</span>уникальный ID строки</li>
            <li> <span class="sql" style="min-width: 13rem;">OrderQty</span>количество</li>
            <li> <span class="sql" style="min-width: 13rem;">ProductID</span>идентификатор товара.</li>
            <li> <span class="sql" style="min-width: 13rem;">UnitPrice</span>цена за единицу товара</li>
            <li> <span class="sql" style="min-width: 13rem;">UnitPriceDiscount</span>цена за единицу товара со скидкой</li>
            <li> <span class="sql" style="min-width: 13rem;">LineTotal</span>Итого</li>
            <li> <span class="sql" style="min-width: 13rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 13rem;">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (SalesOrderID, SalesOrderDetailID, ProductID)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (SalesOrderID) REFERENCES SalesOrderHeader(SalesOrderID)</li>
            <li>FOREIGN KEY (ProductID) REFERENCES Product(ProductID)</li>
        </ul>
        <div class="table-wrapper">
          <table><thead><tr>
                  <th scope="col">SalesOrderID</th>
                  <th scope="col">SalesOrderDetailID</th>
                  <th scope="col">OrderQty</th>
                  <th scope="col">ProductID</th>
                  <th scope="col">UnitPrice</th>
                  <th scope="col">UnitPriceDiscount</th>
                  <th scope="col">LineTotal</th>
                  <th scope="col">rowguid</th>
                  <th scope="col">ModifiedDate</th>
              </tr></thead><tbody><tr>
                  <td>71774</td>
                  <td>110562</td>
                  <td>1</td>
                  <td>836</td>
                  <td>356.8980</td>
                  <td>.0000</td>
                  <td>356.898000</td>
                  <td>E3A1994C-7A68-4CE8-96A3-77FDD3BBD730</td>
                  <td>2008-06-01 00:00:00.000</td>
              </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>SalesOrderHeader</span> - заказы.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 13rem;">SalesOrderID</span>уникальный идентификатор записи (ПК)</li>
            <li> <span class="sql" style="min-width: 13rem;">RevisionNumber</span>номер ревизии</li>
            <li> <span class="sql" style="min-width: 13rem;">OrderDate</span>временная метка создания даты заказа</li>
            <li> <span class="sql" style="min-width: 13rem;">DueDate</span>временная метка даты оплаты заказа</li>
            <li> <span class="sql" style="min-width: 13rem;">ShipDate</span>временная метка даты отправки заказа</li>
            <li> <span class="sql" style="min-width: 13rem;">Status</span>статус заказа</li>
            <li> <span class="sql" style="min-width: 13rem;">OnlineOrderFlag</span>онлайн-заказ (да/нет)</li>
            <li> <span class="sql" style="min-width: 13rem;">SalesOrderNumber</span>номер заказа</li>
            <li> <span class="sql" style="min-width: 13rem;">PurchaseOrderNumber</span>номер покупки</li>
            <li> <span class="sql" style="min-width: 13rem;">AccountNumber</span>номер счета</li>
            <li> <span class="sql" style="min-width: 13rem;">CustomerID</span>идентификатор клиента</li>
            <li> <span class="sql" style="min-width: 13rem;">ShipToAddressID</span>идентификатор адреса доставки</li>
            <li> <span class="sql" style="min-width: 13rem;">BillToAddressID</span>идентификатор адреса для выставления счёта счета</li>
            <li> <span class="sql" style="min-width: 13rem;">ShipMethod</span>метод доставки</li>
            <li> <span class="sql" style="min-width: 13rem;">CreditCardApprovalCode</span><br>код подтверждения кредитной карты</li>
            <li> <span class="sql" style="min-width: 13rem;">SubTotal</span>промежуточный итог</li>
            <li> <span class="sql" style="min-width: 13rem;">TaxAmt</span>налоги</li>
            <li> <span class="sql" style="min-width: 13rem;">Freight</span>стоимость доставки</li>
            <li> <span class="sql" style="min-width: 13rem;">TotalDue</span>итого</li>
            <li> <span class="sql" style="min-width: 13rem;">Comment</span>комментарий</li>
            <li> <span class="sql" style="min-width: 13rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 13rem;">ModifiedDate</span>дата и время последнего изменения</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (SalesOrderID, CustomerID, ShipToAddressID, BillToAddressID)</li>
        </ul>
        <ul class="table-columns">
            <li>FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)</li>
            <li>FOREIGN KEY (ShipToAddressID) REFERENCES Address(AddressID)</li>
            <li>FOREIGN KEY (BillToAddressID) REFERENCES Address(AddressID)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">SalesOrderID</th>
                    <th scope="col">RevisionNumber</th>
                    <th scope="col">OrderDate</th>
                    <th scope="col">DueDate</th>
                    <th scope="col">ShipDate</th>
                    <th scope="col">Status</th>
                    <th scope="col">OnlineOrderFlag</th>
                    <th scope="col">SalesOrderNumber</th>
                    <th scope="col">PurchaseOrderNumber</th>
                    <th scope="col">AccountNumber</th>
                    <th scope="col">CustomerID</th>
                    <th scope="col">ShipToAddressID</th>
                    <th scope="col">BillToAddressID</th>
                    <th scope="col">ShipMethod</th>
                    <th scope="col">CreditCardApprovalCode</th>
                    <th scope="col">SubTotal</th>
                    <th scope="col">TaxAmt</th>
                    <th scope="col">Freight</th>
                    <th scope="col">TotalDue</th>
                    <th scope="col">Comment</th>
                    <th scope="col">rowguid</th>
                    <th scope="col">ModifiedDate</th>
                </tr></thead><tbody><tr>
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
                </tr></tbody></table>
        </div>
    </div>

</div>