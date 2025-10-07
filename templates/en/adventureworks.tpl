<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>AdventureWorks Database (SQL Server)</h2>
    <p>
        The AdventureWorks Database is a sample database that demonstrates the capabilities of SQL Server. It includes data
        about fictional manufacturing company.
    </p>
    <p>
        <a  class="button-erd" href="/{$Lang}/erd/AdventureWorks" target="ERDWindow">
            AdventureWorks DB ER diagram
        </a>
    </p>
    <h3>The following is a list of DB tables:</h3>
    <div class="accordion">
        <span><span class='sql'>Address</span> - table of addresses.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">AddressID</span>a unique identifier for each address (PK).</li>
            <li> <span class="sql">AddressLine1</span>the first line of the address.</li>
            <li> <span class="sql">AddressLine2</span>the second line of the address.</li>
            <li> <span class="sql">City</span>city.</li>
            <li> <span class="sql">StateProvince</span>state or province.</li>
            <li> <span class="sql">CountryRegion</span>country.</li>
            <li> <span class="sql">PostalCode</span>postal code.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>Customer</span> - table of customers.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>a unique identifier for each customer (PK).</li>
            <li> <span class="sql">NameStyle</span>0 = The data in FirstName and LastName are stored in western style (first name, last name) order. 1 = Eastern style (last name, first name) order. Default: 0.</li>
            <li> <span class="sql">Title</span>title.</li>
            <li> <span class="sql">FirstName</span>name.</li>
            <li> <span class="sql">MiddleName</span>middle name.</li>
            <li> <span class="sql">LastName</span>last name.</li>
            <li> <span class="sql">Suffix</span>suffix.</li>
            <li> <span class="sql">CompanyName</span>company name.</li>
            <li> <span class="sql">SalesPerson</span>SalesPerson.</li>
            <li> <span class="sql">EmailAddress</span>E-mail.</li>
            <li> <span class="sql">Phone</span>phone number.</li>
            <li> <span class="sql">PasswordHash</span>password hash.</li>
            <li> <span class="sql">PasswordSalt</span>salt.</li>
            <li> <span class="sql">rowguid</span>rowguid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>CustomerAddress</span> - customer to address relations.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>identifier of client in the Customer table.</li>
            <li> <span class="sql">AddressID</span>identifier of address in the Address table.</li>
            <li> <span class="sql">AddressType</span>address type.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>Product</span> - table of products.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductID</span>a unique identifier for each product (PK).</li>
            <li> <span class="sql">Name</span>product name.</li>
            <li> <span class="sql">ProductNumber</span>article number.</li>
            <li> <span class="sql">Color</span>product color.</li>
            <li> <span class="sql">StandardCost</span>product price.</li>
            <li> <span class="sql">ListPrice</span>product price in the catalogue.</li>
            <li> <span class="sql">Size</span>product size.</li>
            <li> <span class="sql">Weight</span>product weight.</li>
            <li> <span class="sql">ProductCategoryID</span>foreign key pointing to ProductCategory table.</li>
            <li> <span class="sql">ProductModelID</span>foreign key pointing to ProductModel table.</li>
            <li> <span class="sql">SellStartDate</span>timestamp of the sales start date.</li>
            <li> <span class="sql">SellEndDate</span>timestamp of the sales end date.</li>
            <li> <span class="sql">DiscontinuedDate</span>timestamp of the sales end date.</li>
            <li> <span class="sql">ThumbNailPhoto</span>thumbnail photo of the product.</li>
            <li> <span class="sql">ThumbnailPhotoFileName</span><br>name of the photo thumbnail file.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>ProductCategory</span> - table of product categories.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductCategoryID</span>a unique identifier for each product category (PK).</li>
            <li> <span class="sql">ParentProductCategoryID</span><br>identifier of the parent product category.</li>
            <li> <span class="sql">Name</span>name of the product category.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>ProductDescription</span> - table of product descriptions.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductDescriptionID</span>a unique identifier for record (PK).</li>
            <li> <span class="sql">Description</span>product description.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>ProductModel</span> - table of product models.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductModelID</span>a unique identifier for each product model (PK).</li>
            <li> <span class="sql">Name</span>name of the product model.</li>
            <li> <span class="sql">CatalogDescription</span>description in XML format.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>ProductModelProductDescription</span> - table of product models descriptions.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductModelID</span>identifier of client in the ProductModel table.</li>
            <li> <span class="sql">ProductDescriptionID</span>identifier of address in the ProductDescription table.</li>
            <li> <span class="sql">Culture</span>language code in ISO format.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>SalesOrderDetail</span> - table of sales orders details.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
        <li> <span class="sql">SalesOrderID</span>foreign key referencing the SalesOrderHeader table.</li>
        <li> <span class="sql">SalesOrderDetailID</span>a unique identifier of record in the table.</li>
        <li> <span class="sql">OrderQty</span>quantity.</li>
        <li> <span class="sql">ProductID</span>a foreign key referencing the Product table.</li>
        <li> <span class="sql">UnitPrice</span>price per unit of goods.</li>
        <li> <span class="sql">UnitPriceDiscount</span>price per unit of product with a discount.</li>
        <li> <span class="sql">LineTotal</span>total amount by line.</li>
        <li> <span class="sql">rowguid</span>guid.</li>
        <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
        <span><span class='sql'>SalesOrderHeader</span> - product sales orders.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">SalesOrderID</span>a unique identifier of record in the table (PK).</li>
            <li> <span class="sql">RevisionNumber</span>revision number.</li>
            <li> <span class="sql">OrderDate</span>timestamp for creating the order date.</li>
            <li> <span class="sql">DueDate</span>timestamp of the order payment date.</li>
            <li> <span class="sql">ShipDate</span>timestamp of the date the order was shipped.</li>
            <li> <span class="sql">Status</span>order status.</li>
            <li> <span class="sql">OnlineOrderFlag</span>online order (yes/no).</li>
            <li> <span class="sql">SalesOrderNumber</span>order number.</li>
            <li> <span class="sql">PurchaseOrderNumber</span>purchase number.</li>
            <li> <span class="sql">AccountNumber</span>account number.</li>
            <li> <span class="sql">CustomerID</span>foreign key referencing the Customer table.</li>
            <li> <span class="sql">ShipToAddressID</span>foreign key referencing the Address table defines the delivery address.</li>
            <li> <span class="sql">BillToAddressID</span>foreign key referencing the Address table defines the account address.</li>
            <li> <span class="sql">ShipMethod</span>delivery method.</li>
            <li> <span class="sql">CreditCardApprovalCode</span><br>credit card confirmation code.</li>
            <li> <span class="sql">SubTotal</span>subtotal.</li>
            <li> <span class="sql">TaxAmt</span>taxes.</li>
            <li> <span class="sql">Freight</span>delivery cost.</li>
            <li> <span class="sql">TotalDue</span>total.</li>
            <li> <span class="sql">Comment</span>comment.</li>
            <li> <span class="sql">rowguid</span>guid.</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update.</li>
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
      {* <div class="referal-add-block">
            <a id="spzn:child~SlXhnSS5RzWS8wv-b82-Pw" 
                href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3Achild%7ESlXhnSS5RzWS8wv-b82-Pw&u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fbi-foundations-sql-etl-data-warehouse&intsrc=PUI2_9419"            target="_blank"
                style="
                    display: block;
                    max-width: 48%;
                    height: 200px;
                    background: url('https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/27/a156f51493441cb45d0a9ec83b22f9/ETL-Specialization-1200x1200.jpg?auto=format%2Ccompress&dpr=1&w=200&h=200&fit=crop') no-repeat;
                "
                >
                <div style="
                        background: white;
                        color: black;
                        margin: 5px;
                        padding: 3px;
                        border-radius: 3px;
                        opacity: 75%;
                        max-width: 88%;
                ">
                    SQL: A Practical Introduction for Querying Databases
                </div>
                <a id="spzn:child~RXPU-mWaEeunahLL3oLBRQ" 
                    href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3Achild%7ERXPU-mWaEeunahLL3oLBRQ&u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fdata-science-fundamentals-python-sql&intsrc=PUI2_9419"
                    target="_blank"
                    style="
                        display: block;
                        max-width: 48%;
                        height: 200px;
                        background: url('https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/bd/0202c87e244d30bdecd889bd2719ae/DataScienceFundamentalsPythonSQL.png?auto=format%2Ccompress&dpr=1&w=200&h=200&fit=crop') no-repeat;
                    "
                    >
                    <div style="
                            background: white;
                            color: black;
                            margin: 5px;
                            padding: 3px;
                            border-radius: 3px;
                            opacity: 75%;
                            max-width: 88%;
                    ">
                        Data Science Fundamentals with Python and SQL
                    </div>
                </a>
            </a>
      </div> *}
      <style>
            .banner-container {
                width: 100%;
                max-width: 728px; /* Common banner width (e.g., leaderboard) */
                background-color: #336699; /* Professional blue */
                color: #ffffff; /* White text */
                padding: 20px 30px;
                box-sizing: border-box;
                text-align: center;
                border-radius: 8px;
                border: 1px solid white;
                margin: 1rem 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                position: relative;
            }
            .banner-container a {
                text-decoration: none;
                color: inherit; /* Inherit white color */
                display: block; /* Make the whole banner clickable */
            }
            .banner-title {
                font-size: 2.2em; /* Larger font for the main title */
                font-weight: bold;
                margin-bottom: 10px;
                line-height: 1.2;
            }
            .banner-slogan {
                font-size: 1.1em;
                margin-bottom: 20px;
                opacity: 0.9;
            }
            .banner-button {
                display: inline-block;
                background-color: #ff9900; /* Vibrant orange for call to action */
                color: #333333; /* Dark text for contrast */
                padding: 12px 25px;
                border-radius: 5px;
                font-size: 1.0em;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }
            .banner-button:hover {
                background-color: #e68a00; /* Darker orange on hover */
            }

            /* Optional: Responsive adjustments */
            @media (max-width: 768px) {
                .banner-container {
                    max-width: 90%;
                    padding: 15px 20px;
                }
                .banner-title {
                    font-size: 1.8em;
                }
                .banner-slogan {
                    font-size: 1.0em;
                }
                .banner-button {
                    padding: 10px 20px;
                    font-size: 0.9em;
                }
            }
            @media (max-width: 480px) {
                .banner-title {
                    font-size: 1.5em;
                }
                .banner-slogan {
                    font-size: 0.9em;
                }
            }
        </style>
        <div class="banner-container">
            <a href="https://dbfrontiers.net/" target="_blank" rel="noopener noreferrer">
                <div class="banner-title">Database Frontiers</div>
                <div class="banner-slogan">Premier Conference for Database Professionals</div>
                <div class="banner-button">Learn More</div>
            </a>
        </div>
  {/if}
</div>