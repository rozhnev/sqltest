<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Querynomicon 数据库：表结构和概述</h2>
    <p>Querynomicon (SQLite) 是一个紧凑的训练数据库，用于学习 SQL 基础知识，提供清晰简单的示例。</p>
    <p>本页面展示了表格、关键列和示例行，以便进行实际的 SQL 练习。</p>
    <p>Querynomicon 数据库包含 5 个主要表。</p>
    <h3>表格列表</h3>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>department</span> - 部门表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>部门 ID</li>
            <li> <span class='sql'>name</span>部门名称</li>
            <li> <span class='sql'>building</span>建筑名称</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">name</th>
                    <th scope="col">building</th>
                </tr></thead><tbody><tr>
                    <td>gen</td>
                    <td>遗传学</td>
                    <td>Chesson</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>little_penguins</span> - 小企鹅表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>企鹅种类</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>居住岛屿</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>喙长，毫米</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>喙深，毫米</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>鳍长，毫米</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>体重，克</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>性别</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">species</th>
                    <th scope="col">island</th>
                    <th scope="col">bill_length_mm</th>
                    <th scope="col">bill_depth_mm</th>
                    <th scope="col">flipper_length_mm</th>
                    <th scope="col">body_mass_g</th>
                    <th scope="col">sex</th>
                </tr></thead><tbody><tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>雄性</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>penguins</span> - 企鹅表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>企鹅种类</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>居住岛屿</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>喙长，毫米</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>喙深，毫米</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>鳍长，毫米</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>体重，克</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>性别</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">species</th>
                    <th scope="col">island</th>
                    <th scope="col">bill_length_mm</th>
                    <th scope="col">bill_depth_mm</th>
                    <th scope="col">flipper_length_mm</th>
                    <th scope="col">body_mass_g</th>
                    <th scope="col">sex</th>
                </tr></thead><tbody><tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>雄性</td>
                </tr></tbody></table>
        </div>
    </div>    
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>staff</span> - 员工表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>员工编号</li>
            <li> <span class='sql'>personal</span>员工名字</li>
            <li> <span class='sql'>family</span>员工姓氏</li>
            <li> <span class='sql'>dept</span>部门</li>
            <li> <span class='sql'>age</span>年龄</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">personal</th>
                    <th scope="col">family</th>
                    <th scope="col">dept</th>
                    <th scope="col">age</th>
                </tr></thead><tbody><tr>
                    <td>7</td>
                    <td>Abram</td>
                    <td>Chokshi</td>
                    <td>gen</td>
                    <td>23</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>machine</span> - 机器表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>机器 ID</li>
            <li> <span class='sql'>name</span>机器名称</li>
            <li> <span class='sql'>details</span>包含详细信息的 JSON</li>
        </ul>
        <div class="table-wrapper">
            {literal}
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">name</th>
                    <th scope="col">details</th>
                </tr></thead><tbody><tr>
                    <td>1</td>
                    <td>WY401</td>
                    <td>{"acquired": "2023-05-01"}</td>
                </tr><tr>
                    <td>2</td>
                    <td>Inphormex</td>
                    <td>{"acquired": "2021-07-15", "refurbished": "2023-10-22"}</td>
                </tr><tr>
                    <td>3</td>
                    <td>AutoPlate 9000</td>
                    <td>{"note": "需要软件更新"}</td>
                </tr></tbody></table>
            {/literal}
        </div>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>