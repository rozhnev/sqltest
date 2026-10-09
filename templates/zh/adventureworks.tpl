<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    {* The landing page /zh/database/adventureworks has its own intro: only the table list there *}
    {if ($Action|default:'') != 'database'}
    <h2>AdventureWorks 数据库：表结构和模式概述</h2>
    <p>AdventureWorks 数据库 (SQL Server) 是一个示例数据集，模拟了一个虚构制造公司的业务流程。</p>
    <p>本页面展示了表结构、关键列和用于实际 SQL 学习和查询练习的关系。</p>
    <p>AdventureWorks 数据库包含 10 个主要表。</p>
    <p>
        <a href="/{$Lang}/erd/AdventureWorks" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="在新窗口中打开 AdventureWorks ER 图">
            <img src="/images/erd_small_light.svg" alt="AdventureWorks 数据库的 ER 图，显示表关系" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            AdventureWorks 数据库 ER 图
        </a>
    </p>
    <p><a href="/{$Lang}/database/adventureworks">了解更多 AdventureWorks 数据库：模式、示例查询和全部练习 →</a></p>
    {/if}
    <h3>表列表</h3>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>Address</span> - 地址表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">AddressID</span>每个地址的唯一标识符 (PK)</li>
            <li> <span class="sql">AddressLine1</span>地址的第一行</li>
            <li> <span class="sql">AddressLine2</span>地址的第二行</li>
            <li> <span class="sql">City</span>城市</li>
            <li> <span class="sql">StateProvince</span>州或省</li>
            <li> <span class="sql">CountryRegion</span>国家</li>
            <li> <span class="sql">PostalCode</span>邮政编码</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (AddressID)</li>
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
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>Customer</span> - 客户表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>每个客户的唯一标识符 (PK)</li>
            <li> <span class="sql">NameStyle</span>0 = FirstName 和 LastName 的数据以西方风格（名，姓）顺序存储。1 = 东方风格（姓，名）顺序。默认：0</li>
            <li> <span class="sql">Title</span>称谓</li>
            <li> <span class="sql">FirstName</span>名字</li>
            <li> <span class="sql">MiddleName</span>中间名</li>
            <li> <span class="sql">LastName</span>姓</li>
            <li> <span class="sql">Suffix</span>后缀</li>
            <li> <span class="sql">CompanyName</span>公司名称</li>
            <li> <span class="sql">SalesPerson</span>销售人员</li>
            <li> <span class="sql">EmailAddress</span>电子邮件</li>
            <li> <span class="sql">Phone</span>电话号码</li>
            <li> <span class="sql">PasswordHash</span>密码哈希</li>
            <li> <span class="sql">PasswordSalt</span>盐</li>
            <li> <span class="sql">rowguid</span>rowguid</li>
            <li> <span class="sql">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (CustomerID)</li>
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
                  <td>先生</td>
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
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>CustomerAddress</span> - 客户与地址的关系。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql">CustomerID</span>客户在 Customer 表中的标识符</li>
            <li> <span class="sql">AddressID</span>地址在 Address 表中的标识符</li>
            <li> <span class="sql">AddressType</span>地址类型</li>
            <li> <span class="sql">rowguid</span>guid</li>
            <li> <span class="sql">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (CustomerID, AddressID)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (CustomerID) 参考 Customer(CustomerID)</li>
            <li>外键 (AddressID) 参考 Address(AddressID)</li>
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
                    <td>主办公室</td>
                    <td>16765338-DBE4-4421-B5E9-3836B9278E63</td>
                    <td>2007-09-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>Product</span> - 产品表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">ProductID</span>每个产品的唯一标识符 (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>产品名称</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductNumber</span>商品编号</li>
            <li> <span class="sql" style="min-width: 12rem;">Color</span>产品颜色</li>
            <li> <span class="sql" style="min-width: 12rem;">StandardCost</span>产品价格</li>
            <li> <span class="sql" style="min-width: 12rem;">ListPrice</span>产品在目录中的价格</li>
            <li> <span class="sql" style="min-width: 12rem;">Size</span>产品尺寸</li>
            <li> <span class="sql" style="min-width: 12rem;">Weight</span>产品重量</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductCategoryID</span>指向 ProductCategory 表的外键</li>
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>指向 ProductModel 表的外键</li>
            <li> <span class="sql" style="min-width: 12rem;">SellStartDate</span>销售开始日期的时间戳</li>
            <li> <span class="sql" style="min-width: 12rem;">SellEndDate</span>销售结束日期的时间戳</li>
            <li> <span class="sql" style="min-width: 12rem;">DiscontinuedDate</span>停止销售日期的时间戳</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbNailPhoto</span>产品缩略图</li>
            <li> <span class="sql" style="min-width: 12rem;">ThumbnailPhotoFileName</span><br>缩略图文件名</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (ProductID, ProductCategoryID, ProductModelID)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (ProductCategoryID) 参考 ProductCategory(ProductCategoryID)</li>
            <li>外键 (ProductModelID) 参考 ProductModel(ProductModelID)</li>
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
                  <td>黑色</td>
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
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>ProductCategory</span> - 产品类别表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14.5rem;">ProductCategoryID</span>每个产品类别的唯一标识符 (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ParentProductCategoryID</span>父产品类别的 ID</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Name</span>产品类别名称</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (ProductCategoryID)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (ParentProductCategoryID) 参考 ProductCategory(ProductCategoryID)</li>
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
                    <td>自行车</td>
                    <td>CFBDA25C-DF71-47A7-B81B-64EE161AA37C</td>
                    <td>2002-06-01 00:00:00.000</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>ProductDescription</span> - 产品描述表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14.5rem;">ProductDescriptionID</span>记录的唯一标识符 (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Description</span>产品描述</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (ProductDescriptionID)</li>
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
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>ProductModel</span> - 产品型号表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">ProductModelID</span>每条记录的唯一标识符 (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">Name</span>产品型号名称</li>
            <li> <span class="sql" style="min-width: 12rem;">CatalogDescription</span>XML 格式的描述</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (ProductModelID)</li>
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
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>ProductModelProductDescription</span> - 产品型号描述表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 14rem;">ProductModelID</span>ProductModel 表中的型号标识符</li>
            <li> <span class="sql" style="min-width: 14rem;">ProductDescriptionID</span>ProductDescription 表中的描述标识符</li>
            <li> <span class="sql" style="min-width: 14rem;">Culture</span>ISO 格式的语言代码</li>
            <li> <span class="sql" style="min-width: 14rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14rem;">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (ProductModelID, ProductDescriptionID)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (ProductModelID) 参考 ProductModel(ProductModelID)</li>
            <li>外键 (ProductDescriptionID) 参考 ProductDescription(ProductDescriptionID)</li>
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
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>SalesOrderDetail</span> - 销售订单明细表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
        <li> <span class="sql" style="min-width: 12rem;">SalesOrderID</span>引用 SalesOrderHeader 表的外键</li>
        <li> <span class="sql" style="min-width: 12rem;">SalesOrderDetailID</span>表中记录的唯一标识符</li>
        <li> <span class="sql" style="min-width: 12rem;">OrderQty</span>数量</li>
        <li> <span class="sql" style="min-width: 12rem;">ProductID</span>引用 Product 表的外键</li>
        <li> <span class="sql" style="min-width: 12rem;">UnitPrice</span>单价</li>
        <li> <span class="sql" style="min-width: 12rem;">UnitPriceDiscount</span>单价折扣</li>
        <li> <span class="sql" style="min-width: 12rem;">LineTotal</span>行合计金额</li>
        <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
        <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (SalesOrderID, SalesOrderDetailID, ProductID)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (SalesOrderID) 参考 SalesOrderHeader(SalesOrderID)</li>
            <li>外键 (ProductID) 参考 Product(ProductID)</li>
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
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>SalesOrderHeader</span> - 产品销售订单。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderID</span>表中记录的唯一标识符 (PK)</li>
            <li> <span class="sql" style="min-width: 12rem;">RevisionNumber</span>修订号</li>
            <li> <span class="sql" style="min-width: 12rem;">OrderDate</span>订单创建日期</li>
            <li> <span class="sql" style="min-width: 12rem;">DueDate</span>订单付款到期日期</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipDate</span>订单发货日期</li>
            <li> <span class="sql" style="min-width: 12rem;">Status</span>订单状态</li>
            <li> <span class="sql" style="min-width: 12rem;">OnlineOrderFlag</span>在线订单（是/否）</li>
            <li> <span class="sql" style="min-width: 12rem;">SalesOrderNumber</span>订单号</li>
            <li> <span class="sql" style="min-width: 12rem;">PurchaseOrderNumber</span>采购订单号</li>
            <li> <span class="sql" style="min-width: 12rem;">AccountNumber</span>账号</li>
            <li> <span class="sql" style="min-width: 12rem;">CustomerID</span>引用 Customer 表的外键</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipToAddressID</span>引用 Address 表的外键，表示收货地址</li>
            <li> <span class="sql" style="min-width: 12rem;">BillToAddressID</span>引用 Address 表的外键，表示账单地址</li>
            <li> <span class="sql" style="min-width: 12rem;">ShipMethod</span>配送方式</li>
            <li> <span class="sql" style="min-width: 12rem;">CreditCardApprovalCode</span><br>信用卡授权码</li>
            <li> <span class="sql" style="min-width: 12rem;">SubTotal</span>小计</li>
            <li> <span class="sql" style="min-width: 12rem;">TaxAmt</span>税额</li>
            <li> <span class="sql" style="min-width: 12rem;">Freight</span>运费</li>
            <li> <span class="sql" style="min-width: 12rem;">TotalDue</span>总计</li>
            <li> <span class="sql" style="min-width: 12rem;">Comment</span>备注</li>
            <li> <span class="sql" style="min-width: 12rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 12rem;">ModifiedDate</span>行创建或最后更新的时间戳</li>
        </ul>
        <ul class="table-columns">
            <li>主键，btree (SalesOrderID, CustomerID, ShipToAddressID, BillToAddressID)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (CustomerID) 参考 Customer(CustomerID)</li>
            <li>外键 (ShipToAddressID) 参考 Address(AddressID)</li>
            <li>外键 (BillToAddressID) 参考 Address(AddressID)</li>
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