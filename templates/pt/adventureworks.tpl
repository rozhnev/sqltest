<div id="db-description" class="db-description">
    <h2>AdventureWorks Database (SQL Server)</h2>
    <p>O Banco de Dados AdventureWorks é um banco de dados de amostra que demonstra as capacidades do SQL Server. Ele inclui dados sobre uma empresa de manufatura fictícia.</p>
    <p>
        <a  class="button erd" href="/{$Lang}/erd/AdventureWorks" target="ERDWindow">
            Diagrama ER do Banco de Dados AdventureWorks
        </a>
    </p>
    <p>A seguir, uma lista das tabelas:</p>
    <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
      <li><span class='sql' onclick="scrollInfoPanel('Address_table_description')">Address</span> - Tabela de endereços.</li>
      <li><span class='sql' onclick="scrollInfoPanel('Customer_table_description')">Customer</span> - Tabela de clientes.</li>
      <li><span class='sql' onclick="scrollInfoPanel('CustomerAddress_table_description')">CustomerAddress</span> - Tabela de relações entre clientes e endereços.</li>
      <li><span class='sql' onclick="scrollInfoPanel('Product_table_description')">Product</span> - Tabela de produtos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductCategory_table_description')">ProductCategory</span> - Tabela de categorias de produtos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductDescription_table_description')">ProductDescription</span> - Tabela de descrições de produtos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductModel_table_description')">ProductModel</span> - Tabela de modelos de produtos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('ProductModelProductDescription_table_description')">ProductModelProductDescription</span> - Tabela de relações entre modelos de produtos e descrições de produtos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('SalesOrderDetail_table_description')">SalesOrderDetail</span> - Tabela de detalhes de pedidos de venda de produtos.</li>
      <li><span class='sql' onclick="scrollInfoPanel('SalesOrderHeader_table_description')">SalesOrderHeader</span> - Tabela de cabeçalhos de pedidos de venda de produtos.</li>
    </ul>
    {if isset($Book)}
      <a href="{$Book.referral_link}" target="_blank" style="text-decoration: none;">
        <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">
          <div  style = "width: 30%;">
              <img style="width: 100%;" src="{$Book.picture_link}" alt="{$Book.title}">
          </div>
          <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
              <div>{$Book.title}</div>
              <div style="font-size: small; padding-top: 0.5em;">{$Book.description}</div>
          </div>
        </div>
      </a>
    {/if}
    <h3 id="Address_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>Address</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">AddressID</span> - um identificador único para cada endereço.</li>
      <li> <span class="sql">AddressLine1</span> - a primeira linha do endereço.</li>
      <li> <span class="sql">AddressLine2</span> - a segunda linha do endereço.</li>
      <li> <span class="sql">StateProvince</span> - cidade.</li>
      <li> <span class="sql">CountryRegion</span> - país.</li>
      <li> <span class="sql">PostalCode</span> - código postal.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (AddressID)</li>
    </ul>
    <h3 id="Customer_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>Customer</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">CustomerID</span> - um identificador único para cada cliente.</li>
      <li> <span class="sql">NameStyle</span> - 0 = Os dados em FirstName e LastName são armazenados no estilo ocidental (primeiro nome, sobrenome). 1 = Estilo oriental (sobrenome, primeiro nome).
Padrão: 0.</li>
      <li> <span class="sql">Title</span> - título.</li>
      <li> <span class="sql">FirstName</span> - nome.</li>
      <li> <span class="sql">MiddleName</span> - nome do meio.</li>
      <li> <span class="sql">LastName</span> - sobrenome.</li>
      <li> <span class="sql">Suffix</span> - sufixo.</li>
      <li> <span class="sql">CompanyName</span> - nome da empresa.</li>
      <li> <span class="sql">SalesPerson</span> - vendedor.</li>
      <li> <span class="sql">EmailAddress</span> - e-mail.</li>
      <li> <span class="sql">Phone</span> - número de telefone.</li>
      <li> <span class="sql">PasswordHash</span> - hash da senha.</li>
      <li> <span class="sql">PasswordSalt</span> - salt.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (CustomerID)</li>
    </ul>
    <h3 id="CustomerAddress_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>CustomerAddress</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">CustomerID</span> - identificador único do cliente na tabela <span class="sql">Customer</span>.</li>
      <li> <span class="sql">AddressID</span> - identificador único do endereço na tabela <span class="sql">Address</span>.</li>
      <li> <span class="sql">AddressType</span> - tipo de endereço.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (CustomerID, AddressID)</li>
    </ul>
    <h3 id="Product_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>Product</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">ProductID</span> - um identificador único para cada produto.</li>
      <li> <span class="sql">Name</span> - nome do produto.</li>
      <li> <span class="sql">ProductNumber</span> - número do artigo.</li>
      <li> <span class="sql">Color</span> - cor do produto.</li>
      <li> <span class="sql">StandardCost</span> - preço do produto.</li>
      <li> <span class="sql">ListPrice</span> - preço do produto no catálogo.</li>
      <li> <span class="sql">Size</span> - tamanho do produto.</li>
      <li> <span class="sql">Weight</span> - peso do produto.</li>
      <li> <span class="sql">ProductCategoryID</span> - chave estrangeira que aponta para a tabela <span
          class="sql">ProductCategory</span> - define a categoria do produto.</li>
      <li> <span class="sql">ProductModelID</span> - chave estrangeira que aponta para a tabela <span class="sql">ProductModel</span> -
        define o modelo do produto.</li>
      <li> <span class="sql">SellStartDate</span> - data e hora do início das vendas.</li>
      <li> <span class="sql">SellEndDate</span> - data e hora do fim das vendas.</li>
      <li> <span class="sql">DiscontinuedDate</span> - data e hora da descontinuação.</li>
      <li> <span class="sql">ThumbNailPhoto</span> - miniatura da foto do produto.</li>
      <li> <span class="sql">ThumbnailPhotoFileName</span> - nome do arquivo da miniatura da foto.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (ProductID, ProductCategoryID, ProductModelID)</li>
    </ul>
    <h3 id="ProductCategory_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>ProductCategory</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">ProductCategoryID</span> - um identificador único para cada categoria de produto.</li>
      <li> <span class="sql">ParentProductCategoryID</span> - identificador da categoria de produto pai.</li>
      <li> <span class="sql">Name</span> - nome da categoria de produto.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (ProductCategoryID)</li>
    </ul>
    <h3 id="ProductDescription_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>ProductDescription</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">ProductDescriptionID</span> - um identificador único para cada descrição de produto.</li>
      <li> <span class="sql">Description</span> - descrição do produto.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (ProductDescriptionID)</li>
    </ul>
    <h3 id="ProductModel_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>ProductModel</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">ProductModelID</span> - um identificador único para cada modelo de produto.</li>
      <li> <span class="sql">Name</span> - nome do modelo de produto.</li>
      <li> <span class="sql">CatalogDescription</span> - descrição em formato XML.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (ProductModelID)</li>
    </ul>
    <h3 id="ProductModelProductDescription_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>ProductModelProductDescription</span>
    </h3>
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">ProductModelID</span> - identificador único do modelo de produto na tabela <span class="sql">ProductModel</span>.</li>
      <li> <span class="sql">ProductDescriptionID</span> - identificador único da descrição do produto na tabela <span class="sql">ProductDescription</span>.</li>
      <li> <span class="sql">Culture</span> - código do idioma no formato ISO.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (ProductModelID, ProductDescriptionID)</li>
    </ul>
    <h3 id="SalesOrderDetail_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>SalesOrderDetail</span>
    </h3>    
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">SalesOrderID</span> - chave estrangeira referenciando a tabela <span class="sql">SalesOrderHeader</span>.</li>
      <li> <span class="sql">SalesOrderDetailID</span> - um identificador único do registro na tabela.</li>
      <li> <span class="sql">OrderQty</span> - quantidade.</li>
      <li> <span class="sql">ProductID</span> - uma chave estrangeira referenciando a tabela <span class="sql">Product</span>.
      </li>
      <li> <span class="sql">UnitPrice</span> - preço por unidade de mercadoria.</li>
      <li> <span class="sql">UnitPriceDiscount</span> - preço por unidade de produto com desconto.</li>
      <li> <span class="sql">LineTotal</span> - Total.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (SalesOrderID, SalesOrderDetailID, ProductID)</li>
    </ul>
    <h3 id="SalesOrderHeader_table_description">
      <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
        <svg height="15" width="15" style="">
          <polygon points="8,1 15,14 1,14" fill="white"/>
        </svg>
      </span>
      Tabela <span class='sql'>SalesOrderHeader</span>
    </h3>        
    Colunas:
    <ul class="table-columns">
      <li> <span class="sql">SalesOrderID</span> - um identificador único do registro na tabela.</li>
      <li> <span class="sql">RevisionNumber</span> - número da revisão.</li>
      <li> <span class="sql">OrderDate</span> - data e hora da criação do pedido.</li>
      <li> <span class="sql">DueDate</span> - data e hora do vencimento do pedido.</li>
      <li> <span class="sql">ShipDate</span> - data e hora do envio do pedido.</li>
      <li> <span class="sql">Status</span> - status do pedido.</li>
      <li> <span class="sql">OnlineOrderFlag</span> - pedido online (sim/não).</li>
      <li> <span class="sql">SalesOrderNumber</span> - número do pedido.</li>
      <li> <span class="sql">PurchaseOrderNumber</span> - número da compra.</li>
      <li> <span class="sql">AccountNumber</span> - número da conta.</li>
      <li> <span class="sql">CustomerID</span> - chave estrangeira referenciando a tabela <span class="sql">Customer</span> -
        define o cliente.</li>
      <li> <span class="sql">ShipToAddressID</span> - chave estrangeira referenciando a tabela <span class="sql">Address</span> -
        define o endereço de entrega.</li>
      <li> <span class="sql">BillToAddressID</span> - chave estrangeira referenciando a tabela <span class="sql">Address</span> -
        define o endereço de cobrança.</li>
      <li> <span class="sql">ShipMethod</span> - método de entrega.</li>
      <li> <span class="sql">CreditCardApprovalCode</span> - código de aprovação do cartão de crédito.</li>
      <li> <span class="sql">SubTotal</span> - subtotal.</li>
      <li> <span class="sql">TaxAmt</span> - impostos.</li>
      <li> <span class="sql">Freight</span> - custo de entrega.</li>
      <li> <span class="sql">TotalDue</span> - total.</li>
      <li> <span class="sql">Comment</span> - comentário.</li>
      <li> <span class="sql">rowguid</span> - guid.</li>
      <li> <span class="sql">ModifiedDate</span> - data e hora da criação ou última atualização da linha.</li>
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
    Índices:
    <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (SalesOrderID, CustomerID, ShipToAddressID, BillToAddressID)</li>
    </ul>
</div>