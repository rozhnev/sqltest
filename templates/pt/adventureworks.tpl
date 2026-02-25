<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>AdventureWorks Database (SQL Server)</h2>
    <p>O Banco de Dados AdventureWorks é um banco de dados de amostra que demonstra as capacidades do SQL Server. Ele inclui dados sobre uma empresa de manufatura fictícia.</p>
    <p>
        <a href="/{$Lang}/erd/AdventureWorks" target="ERDWindow" style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
            <img src="/images/erd_small_light.jpg" alt="Diagrama ER do Banco de Dados AdventureWorks" style="width: 90%;">
            Diagrama ER - AdventureWorks
        </a>
    </p>
    <h3>Lista das tabelas:</h3>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>Address</span> - Tabela de endereços.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">AddressID</span>um identificador único para cada endereço</li>
            <li> <span class="sql">AddressLine1</span>a primeira linha do endereço</li>
            <li> <span class="sql">AddressLine2</span>a segunda linha do endereço</li>
            <li> <span class="sql">City</span>cidade</li>
            <li> <span class="sql">StateProvince</span>estado ou província</li>
            <li> <span class="sql">CountryRegion</span>país</li>
            <li> <span class="sql">PostalCode</span>código postal</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>Customer</span> - Tabela de clientes.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>um identificador único para cada cliente</li>
            <li> <span class="sql">NameStyle</span>0 = Os dados em FirstName e LastName são armazenados no estilo ocidental (primeiro nome, sobrenome). 1 = Estilo oriental (sobrenome, primeiro nome). Padrão: 0</li>
            <li> <span class="sql">Title</span>título</li>
            <li> <span class="sql">FirstName</span>nome</li>
            <li> <span class="sql">MiddleName</span>nome do meio</li>
            <li> <span class="sql">LastName</span>sobrenome</li>
            <li> <span class="sql">Suffix</span>sufixo</li>
            <li> <span class="sql">CompanyName</span>nome da empresa</li>
            <li> <span class="sql">SalesPerson</span>vendedor</li>
            <li> <span class="sql">EmailAddress</span>e-mail</li>
            <li> <span class="sql">Phone</span>número de telefone</li>
            <li> <span class="sql">PasswordHash</span>hash da senha</li>
            <li> <span class="sql">PasswordSalt</span>salt</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>CustomerAddress</span> - Tabela de relações entre clientes e endereços.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>identificador do cliente na tabela Customer</li>
            <li> <span class="sql">AddressID</span>identificador do endereço na tabela Address</li>
            <li> <span class="sql">AddressType</span>tipo de endereço</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>Product</span> - Tabela de produtos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductID</span>um identificador único para cada produto</li>
            <li> <span class="sql">Name</span>nome do produto</li>
            <li> <span class="sql">ProductNumber</span>número do artigo</li>
            <li> <span class="sql">Color</span>cor do produto</li>
            <li> <span class="sql">StandardCost</span>preço do produto</li>
            <li> <span class="sql">ListPrice</span>preço do produto no catálogo</li>
            <li> <span class="sql">Size</span>tamanho do produto</li>
            <li> <span class="sql">Weight</span>peso do produto</li>
            <li> <span class="sql">ProductCategoryID</span>chave estrangeira que aponta para a tabela ProductCategory - define a categoria do produto</li>
            <li> <span class="sql">ProductModelID</span>chave estrangeira que aponta para a tabela ProductModel -
              define o modelo do produto</li>
            <li> <span class="sql">SellStartDate</span>data e hora do início das vendas</li>
            <li> <span class="sql">SellEndDate</span>data e hora do fim das vendas</li>
            <li> <span class="sql">DiscontinuedDate</span>data e hora da descontinuação</li>
            <li> <span class="sql">ThumbNailPhoto</span>miniatura da foto do produto</li>
            <li> <span class="sql">ThumbnailPhotoFileName</span>nome do arquivo da miniatura da foto</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>ProductCategory</span> - Tabela de categorias de produtos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 13rem;">ProductCategoryID</span>um identificador único para cada categoria de produto</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ParentProductCategoryID</span>ID da categoria de produto pai</li>
            <li> <span class="sql" style="min-width: 13rem;">Name</span>nome da categoria de produto</li>
            <li> <span class="sql" style="min-width: 13rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 13rem;">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>ProductDescription</span> - Tabela de descrições de produtos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 13rem;">ProductDescriptionID</span>um ID único para cada descrição de produto</li>
            <li> <span class="sql" style="min-width: 13rem;">Description</span>descrição do produto</li>
            <li> <span class="sql" style="min-width: 13rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 13rem;">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>ProductModel</span> - Tabela de modelos de produtos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>um ID único para cada modelo de produto</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>nome do modelo de produto</li>
            <li> <span class="sql" style="min-width: 12rem;">CatalogDescription</span>descrição em formato XML</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>ProductModelProductDescription</span> - Tabela de relações entre modelos de produtos e descrições de produtos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">ProductModelID</span>identificador do modelo de produto na tabela ProductModel</li>
            <li> <span class="sql" style="min-width: 14rem;">ProductDescriptionID</span>ID da descrição do produto na tabela ProductDescription</li>
            <li> <span class="sql">Culture</span>código do idioma no formato ISO</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>SalesOrderDetail</span> - Tabela de detalhes de pedidos de venda de produtos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderID</span>chave estrangeira referenciando a tabela SalesOrderHeader</li>
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderDetailID</span>um identificador único do registro na tabela</li>
            <li> <span class="sql" style="min-width: 12rem;">OrderQty</span>quantidade</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductID</span>uma chave estrangeira referenciando a tabela Product</li>
            <li> <span class="sql" style="min-width: 12rem;">UnitPrice</span>preço por unidade de mercadoria</li>
            <li> <span class="sql" style="min-width: 12rem;">UnitPriceDiscount</span>preço por unidade de produto com desconto</li>
            <li> <span class="sql" style="min-width: 12rem;">LineTotal</span>Total</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>data de criação/atualização</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql table-name-icon'>SalesOrderHeader</span> - Tabela de cabeçalhos de pedidos de venda de produtos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 13rem;">SalesOrderID</span>um identificador único do registro na tabela</li>
            <li> <span class="sql" style="min-width: 13rem;">RevisionNumber</span>número da revisão</li>
            <li> <span class="sql" style="min-width: 13rem;">OrderDate</span>data e hora da criação do pedido</li>
            <li> <span class="sql" style="min-width: 13rem;">DueDate</span>data e hora do vencimento do pedido</li>
            <li> <span class="sql" style="min-width: 13rem;">ShipDate</span>data e hora do envio do pedido</li>
            <li> <span class="sql" style="min-width: 13rem;">Status</span>status do pedido</li>
            <li> <span class="sql" style="min-width: 13rem;">OnlineOrderFlag</span>pedido online (sim/não)</li>
            <li> <span class="sql" style="min-width: 13rem;">SalesOrderNumber</span>número do pedido</li>
            <li> <span class="sql" style="min-width: 13rem;">PurchaseOrderNumber</span>número da compra</li>
            <li> <span class="sql" style="min-width: 13rem;">AccountNumber</span>número da conta</li>
            <li> <span class="sql" style="min-width: 13rem;">CustomerID</span>chave estrangeira referenciando a tabela Customer -
              define o cliente</li>
            <li> <span class="sql" style="min-width: 13rem;">ShipToAddressID</span>chave estrangeira referenciando a tabela Address -
              define o endereço de entrega</li>
            <li> <span class="sql" style="min-width: 13rem;">BillToAddressID</span>chave estrangeira referenciando a tabela Address -
              define o endereço de cobrança</li>
            <li> <span class="sql" style="min-width: 13rem;">ShipMethod</span>método de entrega</li>
            <li> <span class="sql" style="min-width: 14rem;">CreditCardApprovalCode</span>código de aprovação do cartão de crédito</li>
            <li> <span class="sql" style="min-width: 13rem;">SubTotal</span>subtotal</li>
            <li> <span class="sql" style="min-width: 13rem;">TaxAmt</span>impostos</li>
            <li> <span class="sql" style="min-width: 13rem;">Freight</span>custo de entrega</li>
            <li> <span class="sql" style="min-width: 13rem;">TotalDue</span>total</li>
            <li> <span class="sql" style="min-width: 13rem;">Comment</span>comentário</li>
            <li> <span class="sql" style="min-width: 13rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 13rem;">ModifiedDate</span>data de criação/atualização</li>
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