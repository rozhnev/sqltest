<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
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
            <li> <span class="sql" style="min-width: 14.5rem;">ProductDescriptionID</span>记录的唯一 ID (PK)</li>
            <li> <span class="sql" style="min-width: 14.5rem;">Description</span>产品描述</li>
            <li> <span class="sql" style="min-width: 14.5rem;">rowguid</span>guid</li>
            <li> <span class="sql" style="min-width: 14.5rem;">ModifiedDate</span>行创建或最后更新的时间戳