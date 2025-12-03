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
            <li> <span class="sql">AddressID</span>unique identifier for each address (PK)</li>
            <li> <span class="sql">AddressLine1</span>the first line of the address</li>
            <li> <span class="sql">AddressLine2</span>the second line of the address</li>
            <li> <span class="sql">City</span>city</li>
            <li> <span class="sql">StateProvince</span>state or province</li>
            <li> <span class="sql">CountryRegion</span>country</li>
            <li> <span class="sql">PostalCode</span>postal code</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql">CustomerID</span>unique identifier for each customer (PK)</li>
            <li> <span class="sql">NameStyle</span>0 = The data in FirstName and LastName are stored in western style (first name, last name) order. 1 = Eastern style (last name, first name) order. Default: 0</li>
            <li> <span class="sql">Title</span>title</li>
            <li> <span class="sql">FirstName</span>name</li>
            <li> <span class="sql">MiddleName</span>middle name</li>
            <li> <span class="sql">LastName</span>last name</li>
            <li> <span class="sql">Suffix</span>suffix</li>
            <li> <span class="sql">CompanyName</span>company name</li>
            <li> <span class="sql">SalesPerson</span>SalesPerson</li>
            <li> <span class="sql">EmailAddress</span>E-mail</li>
            <li> <span class="sql">Phone</span>phone number</li>
            <li> <span class="sql">PasswordHash</span>password hash</li>
            <li> <span class="sql">PasswordSalt</span>salt</li>
            <li> <span class="sql">rowguid</span>rowguid</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql">CustomerID</span>identifier of client in the Customer table</li>
            <li> <span class="sql">AddressID</span>identifier of address in the Address table</li>
            <li> <span class="sql">AddressType</span>address type</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql" style="min-width: 12rem;">ProductID</span>unique identifier for each product (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>product name</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductNumber</span>article number</li>
            <li> <span class="sql" style="min-width: 12rem;">Color</span>product color</li>
            <li> <span class="sql" style="min-width: 12rem;">StandardCost</span>product price</li>
            <li> <span class="sql" style="min-width: 12rem;">ListPrice</span>product price in the catalogue</li>
            <li> <span class="sql" style="min-width: 12rem;">Size</span>product size</li>
            <li> <span class="sql" style="min-width: 12rem;">Weight</span>product weight</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductCategoryID</span>foreign key pointing to ProductCategory table</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>foreign key pointing to ProductModel table</li>
            <li> <span class="sql" style="min-width: 12rem;">SellStartDate</span>timestamp of the sales start date</li>
            <li> <span class="sql" style="min-width: 12rem;">SellEndDate</span>timestamp of the sales end date</li>
            <li> <span class="sql" style="min-width: 12rem;">DiscontinuedDate</span>timestamp of the sales end date</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbNailPhoto</span>thumbnail photo of the product</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbnailPhotoFileName</span><br>name of the photo thumbnail file</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql" style="min-width: 14.5rem;">ProductCategoryID</span>unique identifier for each product category (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ParentProductCategoryID</span>ID of the parent product category</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Name</span>name of the product category</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql" style="min-width: 14.5rem;">ProductDescriptionID</span>unique ID for record (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Description</span>product description</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>unique ID for each record (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>name of the product model</li>
            <li> <span class="sql" style="min-width: 12rem;">CatalogDescription</span>description in XML format</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql" style="min-width: 14rem;">ProductModelID</span>ID of client in the ProductModel table</li>
            <li> <span class="sql" style="min-width: 14rem;">ProductDescriptionID</span>ID of address in the ProductDescription table</li>
            <li> <span class="sql" style="min-width: 14rem;">Culture</span>language code in ISO format</li>
            <li> <span class="sql" style="min-width: 14rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14rem;">ModifiedDate</span>timestamp of row creation or last update</li>
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
        <li> <span class="sql" style="min-width: 12rem;">SalesOrderID</span>foreign key referencing the SalesOrderHeader table</li>
        <li> <span class="sql" style="min-width: 12rem;">SalesOrderDetailID</span>unique identifier of record in the table</li>
        <li> <span class="sql" style="min-width: 12rem;">OrderQty</span>quantity</li>
        <li> <span class="sql" style="min-width: 12rem;">ProductID</span>a foreign key referencing the Product table</li>
        <li> <span class="sql" style="min-width: 12rem;">UnitPrice</span>price per unit of goods</li>
        <li> <span class="sql" style="min-width: 12rem;">UnitPriceDiscount</span>price per unit of product with a discount</li>
        <li> <span class="sql" style="min-width: 12rem;">LineTotal</span>total amount by line</li>
        <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
        <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>timestamp of row creation or last update</li>
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
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderID</span>unique identifier of record in the table (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">RevisionNumber</span>revision number</li>
            <li> <span class="sql" style="min-width: 12rem;">OrderDate</span>timestamp for creating the order date</li>
            <li> <span class="sql" style="min-width: 12rem;">DueDate</span>timestamp of the order payment date</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipDate</span>timestamp of the date the order was shipped</li>
            <li> <span class="sql" style="min-width: 12rem;">Status</span>order status</li>
            <li> <span class="sql" style="min-width: 12rem;">OnlineOrderFlag</span>online order (yes/no)</li>
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderNumber</span>order number</li>
            <li> <span class="sql" style="min-width: 12rem;">PurchaseOrderNumber</span>purchase number</li>
            <li> <span class="sql" style="min-width: 12rem;">AccountNumber</span>account number</li>
            <li> <span class="sql" style="min-width: 12rem;">CustomerID</span>foreign key referencing the Customer table</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipToAddressID</span>foreign key referencing the Address table defines the delivery address</li>
            <li> <span class="sql" style="min-width: 12rem;">BillToAddressID</span>foreign key referencing the Address table defines the account address</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipMethod</span>delivery method</li>
            <li> <span class="sql" style="min-width: 12rem;">CreditCardApprovalCode</span><br>credit card confirmation code</li>
            <li> <span class="sql" style="min-width: 12rem;">SubTotal</span>subtotal</li>
            <li> <span class="sql" style="min-width: 12rem;">TaxAmt</span>taxes</li>
            <li> <span class="sql" style="min-width: 12rem;">Freight</span>delivery cost</li>
            <li> <span class="sql" style="min-width: 12rem;">TotalDue</span>total</li>
            <li> <span class="sql" style="min-width: 12rem;">Comment</span>comment</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>timestamp of row creation or last update</li>
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
        <style>
            /* Base styles for the container */
            .talkpal-ad-container {
                width: 250px; /* Fixed width as requested */
                height: 360px; /* Fixed height as requested */
                background-color: #F0F2F5; /* Light grey, often a neutral background on tech sites. ADJUST THIS to match sqltest.online background! */
                border: 1px solid #C0C0C0; /* Soft border. ADJUST THIS to match sqltest.online border/divider color! */
                border-radius: 8px; /* Slightly rounded corners */
                overflow: hidden; /* Ensure content stays within bounds */
                font-family: Arial, sans-serif; /* Common web font. ADJUST THIS if sqltest.online uses a specific font! */
                text-align: center;
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Distribute space between elements */
                align-items: center;
                box-sizing: border-box; /* Include padding in width/height */
                text-decoration: none; /* Remove underline from the link */
                color: inherit; /* Inherit color for text */
                transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; /* Smooth hover effects */
            }

            .talkpal-ad-container:hover {
                transform: translateY(-3px); /* Slightly lift on hover */
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); /* Subtle shadow on hover */
            }

            /* Logo styling */
            .talkpal-ad-logo {
                max-width: 80%; /* Ensure logo fits */
                max-height: 80px; /* Limit logo height */
                height: auto;
                display: block; /* Remove extra space below image */
                margin-bottom: 15px; /* Space below logo */
            }

            /* Text styling */
            .talkpal-ad-text {
                font-size: 18px; /* Slightly larger heading */
                font-weight: bold;
                color: #333333; /* Dark grey text. ADJUST THIS to match sqltest.online text color! */
                margin-bottom: 10px; /* Space below heading */
                line-height: 1.3;
            }

            .talkpal-ad-subtext {
                font-size: 14px;
                color: #555555; /* Slightly lighter text. ADJUST THIS! */
                line-height: 1.4;
                margin-bottom: 20px; /* Space above button */
            }

            /* Call to action button styling */
            .talkpal-ad-button {
                display: inline-block;
                background-color: #007bff; /* A common "call to action" blue. ADJUST THIS to match sqltest.online primary button color or a complementary accent! */
                color: #ffffff; /* White text on button */
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                text-decoration: none; /* Remove underline */
                transition: background-color 0.2s ease-in-out;
                margin-top: auto; /* Push button to the bottom */
            }

            .talkpal-ad-button:hover {
                background-color: #0056b3; /* Darker shade on hover */
            }
        </style>

        <div style="display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; margin-top: 1rem;">
            <a href="https://www.jdoqocy.com/click-101541078-17083149" target="_blank" class="talkpal-ad-container">
                <img src="https://www.ftjcfx.com/image-101541078-17083149" width="250" height="360" alt="" border="0"/>
            </a>
            <a href="https://www.tkqlhce.com/click-101561323-17139054" target="_blank" class="talkpal-ad-container" style="padding: 15px 10px;">
                <img src="https://www.awltovhc.com/image-101561323-17139054" width="1" height="1" border="0"/>
                <img src="https://files.talkpal.ai/landing_images/talkpal-text-logo.svg" alt="Talkpal AI Logo" class="talkpal-ad-logo">
                <div class="talkpal-ad-text">The fun and effective way to learn a language with AI!</div>
                <div class="talkpal-ad-subtext">Practice speaking, listening & writing.</div>
                <span class="talkpal-ad-button">Start Learning Now</span>
            </a>
        </div>
  {/if}
</div>