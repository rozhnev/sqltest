<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h1>Base de données AdventureWorks : structure des tables et vue du schéma</h1>
    <p>La base AdventureWorks (SQL Server) est un jeu de données d'exemple qui modélise les processus métier d'une entreprise manufacturière fictive.</p>
    <p>Cette page présente la structure des tables, les colonnes clés et les relations utiles pour apprendre et pratiquer SQL.</p>
    <p>La base de données AdventureWorks contient 10 tables principales.</p>
    <p>
        <a href="/{$Lang}/erd/AdventureWorks" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Ouvrir le schéma ER de la base AdventureWorks dans une nouvelle fenêtre">
            <img src="/images/erd_small_light.jpg" alt="Schéma ER de la base AdventureWorks montrant les relations entre les tables" style="width: 90%;" loading="lazy" decoding="async">
            Schéma ER AdventureWorks
        </a>
    </p>
    <h2>Liste des tables</h2>

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

    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                <div class="book-card">
                    <a href="{{$Book.referral_link}}" target="_blank" style="text-decoration: none; color: var(--question-color);">
                        <div style="display: flex; flex-direction: row;     border: 1px solid var(--text-block-border-color);
color: var(--question-text);
border-radius: 6px; padding: 0.3em; width: 98%;">
                        <div  style = "width: 25%;">
                            <img style="width: 100%;" src="{{$Book.picture_link}}" alt="{{$Book.title|escape:"html"}}">
                        </div>
                        <div style="font-size: 1em;  width: 75%;  padding: 0 0.7em; font-weight: 100; height: 250px; overflow: auto;">
                            <div>{{$Book.title|escape:"html"}}</div>
                            <div style="font-size: small; padding-top: 0.5em;">{{$Book.description|escape:"html"}}</div>
                        </div>
                        </div>
                    </a>
                </div>
            {/if}
        </div>
    {/if}
</div>
