<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de datos AdventureWorks: estructura de tablas y descripción del esquema</h2>
    <p>La base de datos AdventureWorks (SQL Server) es un conjunto de datos de muestra que modela los procesos comerciales de una empresa de fabricación ficticia.</p>
    <p>Esta página presenta la estructura de las tablas, las columnas clave y las relaciones utilizadas para el aprendizaje práctico de SQL y la práctica de consultas.</p>
    <p>La base de datos AdventureWorks contiene 10 tablas principales.</p>
    <p>
        <a href="/{$Lang}/erd/AdventureWorks" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir el diagrama ER de AdventureWorks en una nueva ventana">
            <img src="/images/erd_small_light.svg" alt="Diagrama ER de la base de datos AdventureWorks que muestra las relaciones entre tablas" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Diagrama ER de la base de datos AdventureWorks
        </a>
    </p>
    <h3>Lista de tablas</h3>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>Address</span> - tabla de direcciones.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">AddressID</span>identificador único para cada dirección (PK)</li>
            <li> <span class="sql">AddressLine1</span>la primera línea de la dirección</li>
            <li> <span class="sql">AddressLine2</span>la segunda línea de la dirección</li>
            <li> <span class="sql">City</span>ciudad</li>
            <li> <span class="sql">StateProvince</span>estado o provincia</li>
            <li> <span class="sql">CountryRegion</span>país</li>
            <li> <span class="sql">PostalCode</span>código postal</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>marca de tiempo de la creación de la fila o la última actualización</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (AddressID)</li>
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
                    <td>Estados Unidos</td>
                    <td>98011</td>
                    <td>268AF621-76D7-4C78-9441-144FD139821A</td>
                    <td>2006-07-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>Customer</span> - tabla de clientes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>identificador único para cada cliente (PK)</li>
            <li> <span class="sql">NameStyle</span>0 = Los datos en FirstName y LastName se almacenan en estilo occidental (nombre, apellido). 1 = Estilo oriental (apellido, nombre). Predeterminado: 0</li>
            <li> <span class="sql">Title</span>título</li>
            <li> <span class="sql">FirstName</span>nombre</li>
            <li> <span class="sql">MiddleName</span>segundo nombre</li>
            <li> <span class="sql">LastName</span>apellido</li>
            <li> <span class="sql">Suffix</span>sufijo</li>
            <li> <span class="sql">CompanyName</span>nombre de la empresa</li>
            <li> <span class="sql">SalesPerson</span>Vendedor</li>
            <li> <span class="sql">EmailAddress</span>correo electrónico</li>
            <li> <span class="sql">Phone</span>número de teléfono</li>
            <li> <span class="sql">PasswordHash</span>hash de contraseña</li>
            <li> <span class="sql">PasswordSalt</span>sal</li>
            <li> <span class="sql">rowguid</span>rowguid</li>
            <li> <span class="sql">ModifiedDate</span>marca de tiempo de la creación de la fila o la última actualización</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (CustomerID)</li>
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
                  <td>Sr.</td>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>CustomerAddress</span> - relaciones entre clientes y direcciones.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>identificador del cliente en la tabla Customer</li>
            <li> <span class="sql">AddressID</span>identificador de la dirección en la tabla Address</li>
            <li> <span class="sql">AddressType</span>tipo de dirección</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>marca de tiempo de la creación de la fila o la última actualización</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (CustomerID, AddressID)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (CustomerID) REFERENCIAS Customer(CustomerID)</li>
            <li>CLAVE FORÁNEA (AddressID) REFERENCIAS Address(AddressID)</li>
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
                    <td>Oficina Principal</td>
                    <td>16765338-DBE4-4421-B5E9-3836B9278E63</td>
                    <td>2007-09-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>Product</span> - tabla de productos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">ProductID</span>identificador único para cada producto (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>nombre del producto</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductNumber</span>número de artículo</li>
            <li> <span class="sql" style="min-width: 12rem;">Color</span>color del producto</li>
            <li> <span class="sql" style="min-width: 12rem;">StandardCost</span>precio del producto</li>
            <li> <span class="sql" style="min-width: 12rem;">ListPrice</span>precio del producto en el catálogo</li>
            <li> <span class="sql" style="min-width: 12rem;">Size</span>tamaño del producto</li>
            <li> <span class="sql" style="min-width: 12rem;">Weight</span>peso del producto</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductCategoryID</span>clave foránea que apunta a la tabla ProductCategory</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>clave foránea que apunta a la tabla ProductModel</li>
            <li> <span class="sql" style="min-width: 12rem;">SellStartDate</span>marca de tiempo de la fecha de inicio de ventas</li>
            <li> <span class="sql" style="min-width: 12rem;">SellEndDate</span>marca de tiempo de la fecha de finalización de ventas</li>
            <li> <span class="sql" style="min-width: 12rem;">DiscontinuedDate</span>marca de tiempo de la fecha de finalización de ventas</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbNailPhoto</span>foto en miniatura del producto</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbnailPhotoFileName</span><br>nombre del archivo de la foto en miniatura</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>marca de tiempo de la creación de la fila o la última actualización</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (ProductID, ProductCategoryID, ProductModelID)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (ProductCategoryID) REFERENCIAS ProductCategory(ProductCategoryID)</li>
            <li>CLAVE FORÁNEA (ProductModelID) REFERENCIAS ProductModel(ProductModelID)</li>
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
                  <td>Negro</td>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>ProductCategory</span> - tabla de categorías de productos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14.5rem;">ProductCategoryID</span>identificador único para cada categoría de producto (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ParentProductCategoryID</span>ID de la categoría de producto padre</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Name</span>nombre de la categoría de producto</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>marca de tiempo de la creación de la fila o la última actualización</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE PRIMARIA, btree (ProductCategoryID)</li>
        </ul>
        <ul class="table-columns">
            <li>CLAVE FORÁNEA (ParentProductCategoryID) REFERENCIAS ProductCategory(ProductCategoryID)</li>
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
                    <td>Bicicletas</td>
                    <td>CFBDA25C-DF71-47A7-B81B-64EE161AA37C</td>
                    <td>2002-06-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql