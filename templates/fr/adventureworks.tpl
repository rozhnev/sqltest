<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de données AdventureWorks (SQL Server)</h2>
    <p>
        La base de données AdventureWorks est une base de données d'exemple qui démontre les capacités de SQL Server. Elle comprend des données
        sur une entreprise de fabrication fictive.
    </p>
    <p>
        <a href="/{$Lang}/erd/AdventureWorks" target="ERDWindow" style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
            <img src="/images/erd_small_light.jpg" alt="Schéma ER de la base de données AdventureWorks" style="width: 90%;">
            Schéma ER AdventureWorks
        </a>
    </p>
    <h3>Tables de la base de données :</h3>

    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>Address</span> - table des adresses.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">AddressID</span>identifiant unique pour chaque adresse (PK)</li>
            <li> <span class="sql">AddressLine1</span>première ligne de l'adresse</li>
            <li> <span class="sql">AddressLine2</span>deuxième ligne de l'adresse</li>
            <li> <span class="sql">City</span>ville</li>
            <li> <span class="sql">StateProvince</span>état ou province</li>
            <li> <span class="sql">CountryRegion</span>pays</li>
            <li> <span class="sql">PostalCode</span>code postal</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>Customer</span> - table des clients.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>identifiant unique pour chaque client (PK)</li>
            <li> <span class="sql">NameStyle</span>0 = Les données dans FirstName et LastName sont stockées au format occidental (prénom, nom). 1 = Format oriental (nom, prénom). Par défaut : 0</li>
            <li> <span class="sql">Title</span>titre</li>
            <li> <span class="sql">FirstName</span>prénom</li>
            <li> <span class="sql">MiddleName</span>deuxième prénom</li>
            <li> <span class="sql">LastName</span>nom de famille</li>
            <li> <span class="sql">Suffix</span>suffixe</li>
            <li> <span class="sql">CompanyName</span>nom de l'entreprise</li>
            <li> <span class="sql">SalesPerson</span>commercial</li>
            <li> <span class="sql">EmailAddress</span>e-mail</li>
            <li> <span class="sql">Phone</span>numéro de téléphone</li>
            <li> <span class="sql">PasswordHash</span>hash du mot de passe</li>
            <li> <span class="sql">PasswordSalt</span>sel du mot de passe</li>
            <li> <span class="sql">rowguid</span>rowguid</li>
            <li> <span class="sql">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>CustomerAddress</span> - relations entre clients et adresses.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>identifiant du client dans la table Customer</li>
            <li> <span class="sql">AddressID</span>identifiant de l'adresse dans la table Address</li>
            <li> <span class="sql">AddressType</span>type d'adresse</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>Product</span> - table des produits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">ProductID</span>identifiant unique pour chaque produit (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>nom du produit</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductNumber</span>numéro d'article</li>
            <li> <span class="sql" style="min-width: 12rem;">Color</span>couleur du produit</li>
            <li> <span class="sql" style="min-width: 12rem;">StandardCost</span>coût de fabrication du produit</li>
            <li> <span class="sql" style="min-width: 12rem;">ListPrice</span>prix du produit au catalogue</li>
            <li> <span class="sql" style="min-width: 12rem;">Size</span>taille du produit</li>
            <li> <span class="sql" style="min-width: 12rem;">Weight</span>poids du produit</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductCategoryID</span>clé étrangère pointant vers la table ProductCategory</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>clé étrangère pointant vers la table ProductModel</li>
            <li> <span class="sql" style="min-width: 12rem;">SellStartDate</span>horodatage de la date de début de vente</li>
            <li> <span class="sql" style="min-width: 12rem;">SellEndDate</span>horodatage de la date de fin de vente</li>
            <li> <span class="sql" style="min-width: 12rem;">DiscontinuedDate</span>horodatage de la date d'arrêt de vente</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbNailPhoto</span>photo miniature du produit</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbnailPhotoFileName</span><br>nom du fichier de la photo miniature</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>ProductCategory</span> - table des catégories de produits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14.5rem;">ProductCategoryID</span>identifiant unique pour chaque catégorie de produit (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ParentProductCategoryID</span>identifiant de la catégorie de produit parente</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Name</span>nom de la catégorie de produit</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>ProductDescription</span> - table des descriptions de produits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14.5rem;">ProductDescriptionID</span>identifiant unique pour l'enregistrement (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Description</span>description du produit</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>ProductModel</span> - table des modèles de produits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>identifiant unique pour chaque enregistrement (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>nom du modèle de produit</li>
            <li> <span class="sql" style="min-width: 12rem;">CatalogDescription</span>description au format XML</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>ProductModelProductDescription</span> - table des descriptions des modèles de produits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14rem;">ProductModelID</span>identifiant du produit dans la table ProductModel</li>
            <li> <span class="sql" style="min-width: 14rem;">ProductDescriptionID</span>identifiant de la description dans la table ProductDescription</li>
            <li> <span class="sql" style="min-width: 14rem;">Culture</span>code de langue au format ISO</li>
            <li> <span class="sql" style="min-width: 14rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14rem;">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>SalesOrderDetail</span> - table des détails des commandes de vente.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
        <li> <span class="sql" style="min-width: 12rem;">SalesOrderID</span>clé étrangère référençant la table SalesOrderHeader</li>
        <li> <span class="sql" style="min-width: 12rem;">SalesOrderDetailID</span>identifiant unique de l'enregistrement dans la table</li>
        <li> <span class="sql" style="min-width: 12rem;">OrderQty</span>quantité</li>
        <li> <span class="sql" style="min-width: 12rem;">ProductID</span>clé étrangère référençant la table Product</li>
        <li> <span class="sql" style="min-width: 12rem;">UnitPrice</span>prix unitaire des marchandises</li>
        <li> <span class="sql" style="min-width: 12rem;">UnitPriceDiscount</span>prix unitaire du produit avec remise</li>
        <li> <span class="sql" style="min-width: 12rem;">LineTotal</span>montant total par ligne</li>
        <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
        <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
    <div class="accordion" title="Cliquez pour développer, double-cliquez pour coller le nom de la table">
        <span><span class='sql'>SalesOrderHeader</span> - commandes de vente de produits.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderID</span>identifiant unique de l'enregistrement dans la table (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">RevisionNumber</span>numéro de révision</li>
            <li> <span class="sql" style="min-width: 12rem;">OrderDate</span>horodatage de la date de création de la commande</li>
            <li> <span class="sql" style="min-width: 12rem;">DueDate</span>horodatage de la date d'échéance de paiement de la commande</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipDate</span>horodatage de la date d'expédition de la commande</li>
            <li> <span class="sql" style="min-width: 12rem;">Status</span>statut de la commande</li>
            <li> <span class="sql" style="min-width: 12rem;">OnlineOrderFlag</span>commande en ligne (oui/non)</li>
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderNumber</span>numéro de commande</li>
            <li> <span class="sql" style="min-width: 12rem;">PurchaseOrderNumber</span>numéro d'achat</li>
            <li> <span class="sql" style="min-width: 12rem;">AccountNumber</span>numéro de compte</li>
            <li> <span class="sql" style="min-width: 12rem;">CustomerID</span>clé étrangère référençant la table Customer</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipToAddressID</span>clé étrangère référençant la table Address définissant l'adresse de livraison</li>
            <li> <span class="sql" style="min-width: 12rem;">BillToAddressID</span>clé étrangère référençant la table Address définissant l'adresse de facturation</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipMethod</span>méthode d'expédition</li>
            <li> <span class="sql" style="min-width: 12rem;">CreditCardApprovalCode</span><br>code de confirmation de carte de crédit</li>
            <li> <span class="sql" style="min-width: 12rem;">SubTotal</span>sous-total</li>
            <li> <span class="sql" style="min-width: 12rem;">TaxAmt</span>taxes</li>
            <li> <span class="sql" style="min-width: 12rem;">Freight</span>coût de livraison</li>
            <li> <span class="sql" style="min-width: 12rem;">TotalDue</span>total</li>
            <li> <span class="sql" style="min-width: 12rem;">Comment</span>commentaire</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>horodatage de la création ou de la dernière mise à jour de la ligne</li>
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
        <div class="referal-add-block">
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div>
    {/if}
</div>
