<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>员工数据库：表结构和概述</h2>
    <p>员工数据库（Firebird）是一个示例数据集，用于学习SQL并探索Firebird DBMS的功能。</p>
    <p>本页面描述了表结构、关键列和关系，以便进行实际的SQL查询。</p>
    <p>员工数据库包含9个主要表。</p>
    <p>
        <a href="/{$Lang}/erd/Employee" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="在新窗口中打开员工数据库ER图">
            <img src="/images/erd_small_light.svg" alt="员工数据库的ER图，显示表之间的关系" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            员工数据库的ER图
        </a>
    </p>
    <h3>表列表</h3>

    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>COUNTRY</span> - 国家表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>国家名称</li>
            <li><span class='sql'>CURRENCY</span>国家使用的货币</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">CURRENCY</th>
                </tr></thead><tbody><tr>
                    <td>美国</td>
                    <td>美元</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>JOB</span> - 公司员工排班。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>职位代码</li>
            <li><span class='sql'>JOB_GRADE</span>职位等级</li>
            <li><span class='sql'>JOB_COUNTRY</span>与职位相关的国家</li>
            <li><span class='sql'>JOB_TITLE</span>职位名称</li>
            <li><span class='sql'>MIN_SALARY</span>职位的最低工资</li>
            <li><span class='sql'>MAX_SALARY</span>职位的最高工资</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>职位要求</li>
            <li><span class='sql'>LANGUAGE_REQ</span>语言要求</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">JOB_CODE</th>
                    <th scope="col">JOB_GRADE</th>
                    <th scope="col">JOB_COUNTRY</th>
                    <th scope="col">JOB_TITLE</th>
                    <th scope="col">MIN_SALARY</th>
                    <th scope="col">MAX_SALARY</th>
                    <th scope="col">JOB_REQUIREMENT</th>
                    <th scope="col">LANGUAGE_REQ</th>
                </tr></thead><tbody><tr>
                    <td>CEO</td>
                    <td>1</td>
                    <td>美国</td>
                    <td>首席执行官</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>没有具体要求。</td>
                    <td>[null]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>外键 (JOB_COUNTRY) 参考 COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>DEPARTMENT</span> - 公司部门。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>部门编号</li>
            <li><span class='sql'>DEPARTMENT</span>部门名称</li>
            <li><span class='sql'>HEAD_DEPT</span>上级部门（可以为null）</li>
            <li><span class='sql'>MNGR_NO</span>经理编号</li>
            <li><span class='sql'>BUDGET</span>部门预算</li>
            <li><span class='sql'>LOCATION</span>部门位置</li>
            <li><span class='sql'>PHONE_NO</span>部门电话号码</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">DEPARTMENT</th>
                    <th scope="col">HEAD_DEPT</th>
                    <th scope="col">MNGR_NO</th>
                    <th scope="col">BUDGET</th>
                    <th scope="col">LOCATION</th>
                    <th scope="col">PHONE_NO</th>
                </tr></thead><tbody><tr>
                    <td>000</td>
                    <td>公司总部</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>蒙特雷</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>外键 (HEAD_DEPT) 参考 DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>EMPLOYEE</span> - 员工列表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>员工编号</li>
            <li><span class='sql'>FIRST_NAME</span>员工的名字</li>
            <li><span class='sql'>LAST_NAME</span>员工的姓氏</li>
            <li><span class='sql'>PHONE_EXT</span>员工的电话分机</li>
            <li><span class='sql'>HIRE_DATE</span>员工入职日期</li>
            <li><span class='sql'>DEPT_NO</span>部门编号</li>
            <li><span class='sql'>JOB_CODE</span>员工的职位代码</li>
            <li><span class='sql'>JOB_GRADE</span>员工的职位等级</li>
            <li><span class='sql'>JOB_COUNTRY</span>与员工职位相关的国家</li>
            <li><span class='sql'>SALARY</span>员工的工资</li>
            <li><span class='sql'>FULL_NAME</span>员工的全名</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">FIRST_NAME</th>
                    <th scope="col">LAST_NAME</th>
                    <th scope="col">PHONE_EXT</th>
                    <th scope="col">HIRE_DATE</th>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">JOB_CODE</th>
                    <th scope="col">JOB_GRADE</th>
                    <th scope="col">JOB_COUNTRY</th>
                    <th scope="col">SALARY</th>
                    <th scope="col">FULL_NAME</th>
                </tr></thead><tbody><tr>
                    <td>2</td>
                    <td>罗伯特</td>
                    <td>尼尔森</td>
                    <td>250</td>
                    <td>1988-12-28 00:00:00</td>
                    <td>600</td>
                    <td>VP</td>
                    <td>2</td>
                    <td>美国</td>
                    <td>105900.00</td>
                    <td>尼尔森，罗伯特</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>外键 (DEPT_NO) 参考 DEPARTMENT(DEPT_NO)</li>
            <li>外键 (JOB_CODE) 参考 JOB(JOB_CODE)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>PROJECT</span> - 项目列表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>项目ID</li>
            <li><span class='sql'>PROJ_NAME</span>项目名称</li>
            <li><span class='sql'>PROJ_DESC</span>项目描述</li>
            <li><span class='sql'>TEAM_LEADER</span>项目负责人</li>
            <li><span class='sql'>PRODUCT</span>与项目相关的产品</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">PROJ_ID</th>
                    <th scope="col">PROJ_NAME</th>
                    <th scope="col">PROJ_DESC</th>
                    <th scope="col">TEAM_LEADER</th>
                    <th scope="col">PRODUCT</th>
                </tr></thead><tbody><tr>
                    <td>VBASE</td>
                    <td>视频数据库</td>
                    <td>开发一个视频数据库管理系统，用于管理按需视频分发。</td>
                    <td>45</td>
                    <td>软件</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>外键 (TEAM_LEADER) 参考 EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - 员工与项目的映射。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>员工编号</li>
            <li><span class='sql'>PROJ_ID</span>项目ID</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">PROJ_ID</th>
                </tr></thead><tbody><tr>
                    <td>144</td>
                    <td>DGPII</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>外键 (EMP_NO) 参考 EMPLOYEE(EMP_NO)</li>
            <li>外键 (PROJ_ID) 参考 PROJECT(PROJ_ID)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - 项目预算。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>FISCAL_YEAR</span>财政年度</li>
            <li><span class='sql'>PROJ_ID</span>项目ID</li>
            <li><span class='sql'>DEPT_NO</span>部门编号</li>
            <li><span class='sql'>QUART_HEAD_CNT</span>季度人数（可以为null）</li>
            <li><span class='sql'>PROJECTED_BUDGET</span>财政年度的预计预算</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">FISCAL_YEAR</th>
                    <th scope="col">PROJ_ID</th>
                    <th scope="col">DEPT_NO</th>
                    <th scope="col">QUART_HEAD_CNT</th>
                    <th scope="col">PROJECTED_BUDGET</th>
                </tr></thead><tbody><tr>
                    <td>1994</td>
                    <td>GUIDE</td>
                    <td>100</td>
                    <td>[null]</td>
                    <td>200000.00</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>外键 (PROJ_ID) 参考 PROJECT(PROJ_ID)</li>
            <li>外键 (DEPT_NO) 参考 DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>SALARY_HISTORY</span> - 员工工资变动历史。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>员工编号</li>
            <li><span class='sql'>CHANGE_DATE</span>工资变动日期</li>
            <li><span class='sql'>UPDATER_ID</span>更新者ID</li>
            <li><span class='sql'>OLD_SALARY</span>之前的工资</li>
            <li><span class='sql'>PERCENT_CHANGE</span>工资变动百分比</li>
            <li><span class='sql'>NEW_SALARY</span>变动后的新工资</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">CHANGE_DATE</th>
                    <th scope="col">UPDATER_ID</th>
                    <th scope="col">OLD_SALARY</th>
                    <th scope="col">PERCENT_CHANGE</th>
                    <th scope="col">NEW_SALARY</th>
                </tr></thead><tbody><tr>
                    <td>28</td>
                    <td>1992-12-15 00:00:00</td>
                    <td>admin2</td>
                    <td>20000.00</td>
                    <td>10.000000</td>
                    <td>22000.000000</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>外键 (EMP_NO) 参考 EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>CUSTOMER</span> - 公司客户。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>CUST_NO</span>客户编号</li>
            <li><span class='sql'>CUSTOMER</span>客户名称</li>
            <li><span class='sql'>CONTACT_FIRST</span>联系人名字</li>
            <li><span class='sql'>CONTACT_LAST</span>联系人姓氏</li>
            <li><span class='sql'>PHONE_NO</span>客户电话号码</li>
            <li><span class='sql'>ADDRESS_LINE1</span> 地址行1</li>
            <li><span class='sql'>ADDRESS_LINE2</span>地址行2（可以为null）</li>
            <li><span class='sql'>CITY</span>客户所在城市</li>
            <li><span class='sql'>STATE_PROVINCE</span>客户所在州或省</li>
            <li><span class='sql'>COUNTRY</span>客户所在国家</li>
            <li><span class='sql'>POSTAL_CODE</span>客户邮政编码</li>
            <li><span class='sql'>ON_HOLD</span>暂停状态（可以为null）</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">CUSTOMER</th>
                    <th scope="col">CONTACT_FIRST</th>
                    <th scope="col">CONTACT_LAST</th>
                    <th scope="col">PHONE_NO</th>
                    <th scope="col">ADDRESS_LINE1</th>
                    <th scope="col">ADDRESS_LINE2</th>
                    <th scope="col">CITY</th>
                    <th scope="col">STATE_PROVINCE</th>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">POSTAL_CODE</th>
                    <th scope="col">ON_HOLD</th>
                </tr></thead><tbody><tr>
                    <td>1001</td>
                    <td>签名设计</td>
                    <td>戴尔·J.</td>
                    <td>小