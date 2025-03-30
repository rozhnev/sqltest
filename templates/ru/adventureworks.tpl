<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>База данных AdventureWorks (SQL Server)</h2>
    <p>База данных AdventureWorks — это образец базы данных, демонстрирующий возможности SQL Server. Он включает данные о
      вымышленной производственной компании.</p>
    <p>
        <a  class="button-erd" href="/{$Lang}/erd/AdventureWorks" target="ERDWindow">
            ER диаграмма базы данных AdventureWorks
        </a>
    </p>
    <h3>База данных содержит 10 таблиц:</h3>
    <div class="accordion">
        <span><span class='sql'>Address</span> - таблица адресов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">AddressID</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class="sql">AddressLine1</span>первая строка адреса.</li>
            <li> <span class="sql">AddressLine2</span>вторая строка адреса.</li>
            <li> <span class="sql">City</span>город.</li>
            <li> <span class="sql">StateProvince</span>штат или провинция.</li>
            <li> <span class="sql">CountryRegion</span>страна.</li>
            <li> <span class="sql">PostalCode</span>почтовый индекс.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>временная метка создания или последнего обновления строки.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (AddressID)</li>
        </ul>
        <div class="table-wrapper">
            <table>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>Customer</span> - таблица клиентов.</span>
    </div>
    <div class="panel">
    <ul class="table-columns">
      <li> <span class="sql">CustomerID</span>уникальный идентификатор записи (ПК).</li>
      <li> <span class="sql">NameStyle</span>0 = Данные в FirstName и LastName хранятся в западном стиле (имя, фамилия). 1 = Восточный стиль (фамилия, имя) порядок.
      По умолчанию: 0.</li>
      <li> <span class="sql">Title</span>обращение.</li>
      <li> <span class="sql">FirstName</span>имя.</li>
      <li> <span class="sql">MiddleName</span>второе имя.</li>
      <li> <span class="sql">LastName</span>фамилия.</li>
      <li> <span class="sql">Suffix</span>суффикс.</li>
      <li> <span class="sql">CompanyName</span>название компании.</li>
      <li> <span class="sql">SalesPerson</span>контактная персона.</li>
      <li> <span class="sql">EmailAddress</span>E-mail.</li>
      <li> <span class="sql">Phone</span>номер телефона.</li>
      <li> <span class="sql">PasswordHash</span>хеш пароля.</li>
      <li> <span class="sql">PasswordSalt</span>соль.</li>
      <li> <span class="sql">rowguid</span>rowguid.</li>
      <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
    </ul>
    <ul class="table-columns">
      <li>PRIMARY KEY, btree (CustomerID)</li>
    </ul>
    <div class="table-wrapper">
      <table>
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
      </table>
    </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>CustomerAddress</span> - таблица связи клиентов и адресов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class="sql">AddressID</span>идентификатор адреса в таблице Address.</li>
            <li> <span class="sql">AddressType</span>тип адреса.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (CustomerID, AddressID)</li>
        </ul>
        <div class="table-wrapper">
            <table>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>Product</span> - таблица товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductID</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class="sql">Name</span>наименование товара.</li>
            <li> <span class="sql">ProductNumber</span>артикул.</li>
            <li> <span class="sql">Color</span>цвет товара.</li>
            <li> <span class="sql">StandardCost</span>цена товара.</li>
            <li> <span class="sql">ListPrice</span>цена товара в каталоге.</li>
            <li> <span class="sql">Size</span>размер товара.</li>
            <li> <span class="sql">Weight</span>вес товара.</li>
            <li> <span class="sql">ProductCategoryID</span>идентификатор категории товара.</li>
            <li> <span class="sql">ProductModelID</span>идентификатор модели товара.</li>
            <li> <span class="sql">SellStartDate</span>временная метка даты начала продаж.</li>
            <li> <span class="sql">SellEndDate</span>временная метка даты окончания продаж.</li>
            <li> <span class="sql">DiscontinuedDate</span>временная метка даты окончания продаж.</li>
            <li> <span class="sql">ThumbNailPhoto</span>миниатюра фото товара.</li>
            <li> <span class="sql">ThumbnailPhotoFileName</span><br>имя файла миниатюры фото.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductID, ProductCategoryID, ProductModelID)</li>
        </ul>
        <div class="table-wrapper">
            <table>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>ProductCategory</span> - категории товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductCategoryID</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class="sql">ParentProductCategoryID</span><br>идентификатор родительской категории товара.</li>
            <li> <span class="sql">Name</span>название категории товара.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductCategoryID)</li>
        </ul>
        <div class="table-wrapper">
            <table>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>ProductDescription</span> - описание товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductDescriptionID</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class="sql">Description</span>описание товара.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductDescriptionID)</li>
        </ul>
        <div class="table-wrapper">
          <table>
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
          </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>ProductModel</span> - модели товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductModelID</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class="sql">Name</span>название модели товара.</li>
            <li> <span class="sql">CatalogDescription</span>описание в формате XML.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductModelID)</li>
        </ul>
        <div class="table-wrapper">
            <table>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>ProductModelProductDescription</span> - описание моделей товаров.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductModelID</span>идентификатор товара.</li>
            <li> <span class="sql">ProductDescriptionID</span>идентификатор описания товара.</li>
            <li> <span class="sql">Culture</span>языковой код в формате ISO.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (ProductModelID, ProductDescriptionID)</li>
        </ul>
        <div class="table-wrapper">
            <table>
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
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>SalesOrderDetail</span> - детали заказов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">SalesOrderID</span>идентификатор заказа.</li>
            <li> <span class="sql">SalesOrderDetailID</span>уникальный идентификатор строки.</li>
            <li> <span class="sql">OrderQty</span>количество.</li>
            <li> <span class="sql">ProductID</span>идентификатор товара..</li>
            <li> <span class="sql">UnitPrice</span>цена за единицу товара.</li>
            <li> <span class="sql">UnitPriceDiscount</span>цена за единицу товара со скидкой.</li>
            <li> <span class="sql">LineTotal</span>Итого.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (SalesOrderID, SalesOrderDetailID, ProductID)</li>
        </ul>
        <div class="table-wrapper">
          <table>
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
          </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>SalesOrderHeader</span> - заказы.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">SalesOrderID</span>уникальный идентификатор записи (ПК).</li>
            <li> <span class="sql">RevisionNumber</span>номер ревизии.</li>
            <li> <span class="sql">OrderDate</span>временная метка создания даты заказа.</li>
            <li> <span class="sql">DueDate</span>временная метка даты оплаты заказа.</li>
            <li> <span class="sql">ShipDate</span>временная метка даты отправки заказа.</li>
            <li> <span class="sql">Status</span>статус заказа.</li>
            <li> <span class="sql">OnlineOrderFlag</span>онлайн-заказ (да/нет).</li>
            <li> <span class="sql">SalesOrderNumber</span>номер заказа.</li>
            <li> <span class="sql">PurchaseOrderNumber</span>номер покупки.</li>
            <li> <span class="sql">AccountNumber</span>номер счета.</li>
            <li> <span class="sql">CustomerID</span>идентификатор клиента.</li>
            <li> <span class="sql">ShipToAddressID</span>идентификатор адреса доставки.</li>
            <li> <span class="sql">BillToAddressID</span>идентификатор адреса для выставления счёта счета.</li>
            <li> <span class="sql">ShipMethod</span>метод доставки.</li>
            <li> <span class="sql">CreditCardApprovalCode</span><br>код подтверждения кредитной карты.</li>
            <li> <span class="sql">SubTotal</span>промежуточный итог.</li>
            <li> <span class="sql">TaxAmt</span>налоги.</li>
            <li> <span class="sql">Freight</span>стоимость доставки.</li>
            <li> <span class="sql">TotalDue</span>итого.</li>
            <li> <span class="sql">Comment</span>комментарий.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>дата и время последнего изменения.</li>
        </ul>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (SalesOrderID, CustomerID, ShipToAddressID, BillToAddressID)</li>
        </ul>
        <div class="table-wrapper">
            <table>
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
            </table>
        </div>
    </div>

    {if $User->showAd()}
        {assign var=add_id value=0|mt_rand:4}
        <div class="referal-add-block">
            {if $add_id > 2}
                {* <a href="https://book24.ru/r/vPcru?erid=LjN8K1JdK" target="_blank" style="text-decoration: none; display: flex;">
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
                </a> *}
                {* <a target="_blank" rel="nofollow" href="https://naiawork.com/g/63cmm8j9f5fec845fb2f5e445e6c7b/?i=4&subid=sql-from-zero&erid=LatgBvCNw">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/63cmm8j9f5fec845fb2f5e445e6c7b/" alt="Productstar"/>
                </a> *}
                <a target="_blank" rel="nofollow" href="https://dhwnh.com/g/jnv1nobkwkfec845fb2f42f9f2178b/?i=4&erid=2VSb5x8kCDv">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/jnv1nobkwkfec845fb2f42f9f2178b/" alt="Puzzle Movies"/>
                </a>
                <a target="_blank" rel="nofollow" href="https://thevospad.com/g/go2e1mhf52fec845fb2f69bd3583e1/?i=4&subid=analyst-from-zero&erid=LatgC6bAt">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/go2e1mhf52fec845fb2f69bd3583e1/" alt="Netology"/>
                </a>
            {else}
                <a target="_blank" rel="nofollow" href="https://ewwhk.com/g/brl8jkz38efec845fb2f0d79a64861/?i=4&subid=domains&erid=5jtCeReNwxHpfQTGR3xQ4Jh">
                    <img style="width:83.3%;" border="0" src="https://aflink.ru/b/brl8jkz38efec845fb2f0d79a64861/" alt="REG.RU"/>
                </a>
                <a target="_blank" rel="nofollow" href="https://thevospad.com/g/dhqiqt6h41fec845fb2f69bd3583e1/?i=4&subid=free-neuronetwork&erid=LatgBSdq6">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/dhqiqt6h41fec845fb2f69bd3583e1/" alt="Netology"/>
                </a>
            {/if}
        </div>
    {/if}
    {literal}

  
   

  {/literal}
</div>