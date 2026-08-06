<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>Sakila 数据库：表结构和模式概述</h2>
    <p>Sakila 是 MySQL 为学习和演示 SQL 及关系数据库管理系统 (RDBMS) 功能而设计的示例关系数据库。</p>
    <p>本页面展示了 Sakila 的表结构、关键列和在教育 SQL 查询中常用的约束。</p>
    <p>Sakila 数据库包含 15 个主要表，描述了 DVD 租赁公司的各个方面。</p>
    <p>
        <a href="/{$Lang}/erd/Sakila" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="在新窗口中打开 Sakila 数据库 ER 图">
            <img src="/images/erd_small_light.svg" alt="Sakila 数据库的 ER 图，显示表之间的关系" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Sakila 数据库的 ER 图
        </a>
    </p>
    <h3>表列表</h3>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>actor</span> - 演员表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>唯一记录标识符 (PK)</li>
            <li> <span class='sql'>first_name</span>演员的名字</li>
            <li> <span class='sql'>last_name</span>演员的姓氏</li>
            <li> <span class='sql'>last_update</span>最后更新时间</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">actor_id</th>
                <th scope="col">first_name</th>
                <th scope="col">last_name</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (actor_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span class='sql'>address</span> - 客户和员工地址。
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>address_id</span>唯一记录标识符 (PK)</li>
            <li> <span class='sql'>address</span>邮政地址</li>
            <li> <span class='sql'>address2</span>附加地址</li>
            <li> <span class='sql'>district</span>地区或区域</li>
            <li> <span class='sql'>city_id</span>城市标识符 (FK)</li>
            <li> <span class='sql'>postal_code</span>邮政编码</li>
            <li> <span class='sql'>phone</span>电话号码</li>
            <li> <span class='sql'>last_update</span>最后更新时间</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">address_id</th>
                <th scope="col">address</th>
                <th scope="col">address2</th>
                <th scope="col">district</th>
                <th scope="col">city_id</th>
                <th scope="col">postal_code</th>
                <th scope="col">phone</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>123 Main St</td>
                <td>[null]</td>
                <td>市中心</td>
                <td>1</td>
                <td>12345</td>
                <td>+1234567890</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (address_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (city_id) 参考 city(city_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span class='sql'>category</span> - 电影类别。
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>category_id</span>唯一记录标识符 (PK)</li>
            <li> <span class='sql'>name</span>类别名称</li>
            <li> <span class='sql'>last_update</span>最后更新时间</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">category_id</th>
                <th scope="col">name</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>动作</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (category_id)</li>
        </ul>    
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span class='sql'>city</span> - 城市表。
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>city_id</span>唯一记录标识符 (PK)</li>
            <li> <span class='sql'>city</span>城市名称</li>
            <li> <span class='sql'>country_id</span>国家标识符 (FK)</li>
            <li> <span class='sql'>last_update</span>最后更新时间</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">city_id</th>
                <th scope="col">city</th>
                <th scope="col">country_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>大都会</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (city_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (country_id) 参考 country(country_id)</li>
        </ul>
    </div>    
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span class='sql'>country</span> - 国家表。
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>country_id</span>唯一记录标识符 (PK)</li>
            <li> <span class='sql'>country</span>国家名称</li>
            <li> <span class='sql'>last_update</span>最后更新时间</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">country_id</th>
                <th scope="col">country</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>美国</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (country_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span class='sql'>customer</span> - 客户表。
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>唯一记录标识符 (PK)</li>
            <li> <span class='sql'>store_id</span>商店标识符 (FK)</li>
            <li> <span class='sql'>first_name</span>客户的名字</li>
            <li> <span class='sql'>last_name</span>客户的姓氏</li>
            <li> <span class='sql'>email</span>客户的电子邮件地址</li>
            <li> <span class='sql'>address_id</span>地址标识符 (FK)</li>
            <li> <span class='sql'>active</span>客户活动指示器 (0/1)</li>
            <li> <span class='sql'>create_date</span>客户添加到数据库的日期和时间</li>
            <li> <span class='sql'>last_update</span>最后更新时间</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">customer_id</th>
                <th scope="col">store_id</th>
                <th scope="col">first_name</th>
                <th scope="col">last_name</th>
                <th scope="col">email</th>
                <th scope="col">address_id</th>
                <th scope="col">active</th>
                <th scope="col">create_date</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>john.doe@example.com</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
        <ul class="table-columns">
            <li>主键，btree (customer_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (store_id) 参考 store(store_id)</li>
            <li>外键 (address_id) 参考 address(address_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span class='sql'>film</span> - 电影表。
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 13rem;">film_id</span>唯一记录标识符 (PK)</li>
            <li> <span class='sql' style="min-width: 13rem;">title</span>电影标题</li>
            <li> <span class='sql' style="min-width: 13rem;">description</span>电影的简要描述或情节</li>
            <li> <span class='sql' style="min-width: 13rem;">release_year</span>电影发行年份</li>
            <li> <span class='sql' style="min-width: 13rem;">language_id</span>电影语言的标识符 (FK)</li>
            <li> <span class='sql' style="min-width: 13rem;">original_language_id</span>原始语言的标识符，以防它被配音成新语言</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_duration</span>租赁期的天数</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_rate</span>租赁电影的费用，持续时间在 rental_duration 列中指定</li>
            <li> <span class='sql' style="min-width: 13rem;">length</span>电影长度（分钟）</li>
            <li> <span class='sql' style="min-width: 13rem;">replacement_cost</span>丢失或损坏光盘的罚款金额</li>
            <li> <span class='sql' style="min-width: 13rem;">rating</span>分配给电影的评级。可以是：G、PG、PG-13、R 或 NC-17</li>
            <li> <span class='sql' style="min-width: 13rem;">special_features</span>DVD 上包含的特殊功能列表。可以是零个或多个：预告片、评论、删减片段、幕后花絮</li>
            <li> <span class='sql' style="min-width: 13rem;">last_update</span>最后更新时间</li>
          </ul>
          <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">film_id</th>
                <th scope="col">title</th>
                <th scope="col">description</th>
                <th scope="col">release_year</th>
                <th scope="col">language_id</th>
                <th scope="col">original_language_id</th>
                <th scope="col">rental_duration</th>
                <th scope="col">rental_rate</th>
                <th scope="col">length</th>
                <th scope="col">replacement_cost</th>
                <th scope="col">rating</th>
                <th scope="col">special_features</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>电影标题</td>
                <td>电影的简要描述。</td>
                <td>2000</td>
                <td>1</td>
                <td>2</td>
                <td>5</td>
                <td>4.99</td>
                <td>120</td>
                <td>19.99</td>
                <td>PG-13</td>
                <td>预告片、评论</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
            <li>主键，btree (film_id)</li>
          </ul>
                    <ul class="table-columns">
                        <li>外键 (language_id) 参考 language(language_id)</li>
                        <li>外键 (original_language_id) 参考 language(language_id)</li>
                    </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span class='sql'>film_actor</span> - 演员与电影的关系。
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>演员的标识符 (FK)</li>
            <li> <span class='sql'>film_id</span>电影的标识符 (FK)</li>
            <li> <span class='sql'>last_update</span>最后更新时间</li> 
          </ul>
          <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                <th scope="col">actor_id</th>
                <th scope="col">film_id</th>
                <th scope="col">last_update</th>
              </tr>
                </thead>
                <tbody>
                    <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
                </tbody>
            </table>
          </div>
          <ul class="table-columns">
            <li>主键，btree (actor_id, film_id)</li>
                    </ul>
                    <ul class="table-columns">
                        <li>外键 (actor_id) 参考 actor(actor_id)</li>
                        <li>外键 (film_id) 参考 film(film