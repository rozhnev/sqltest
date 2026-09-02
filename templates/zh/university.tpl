<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>大学数据库：表结构和模式概述</h2>
    <p>大学数据库是一个现代的 <strong>MariaDB 11.7+</strong> 示例数据库，用于学习 SQL — 设计为经典 Sakila 数据库的功能丰富的替代品。</p>
    <p>它涵盖了所有重要的 MariaDB 数据类型，包括 <span class='sql'>VECTOR(1536)</span>、<span class='sql'>JSON</span>、<span class='sql'>SET</span> 和 <span class='sql'>FULLTEXT</span> 索引，完全标准化到 3NF，并提供足够的数据供初学者练习和复杂的分析查询。</p>
    <p>大学数据库包含 16 个主要表，描述大学的学术结构 — 系、教职员工、学生、课程、注册、研究项目等。</p>
    <p>
        <a href="/{$Lang}/erd/University" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="在新窗口中打开大学数据库 ER 图">
            <img src="/images/erd_university_small.svg" alt="显示大学数据库表关系的紧凑 ER 图" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            大学数据库的 ER 图
        </a>
    </p>
    <h3>表列表</h3>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>semesters</span> - 学术学期表。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>semester_id</span>唯一记录标识符 (PK, TINYINT)</li>
            <li><span class='sql'>term</span>学期类型：秋季、春季或夏季 (ENUM)</li>
            <li><span class='sql'>academic_year</span>学年 (YEAR)</li>
            <li><span class='sql'>name</span>学期名称 (例如 'Fall 2024')</li>
            <li><span class='sql'>start_date</span>学期的第一天</li>
            <li><span class='sql'>end_date</span>学期的最后一天</li>
            <li><span class='sql'>enroll_deadline</span>学生注册的最后日期</li>
            <li><span class='sql'>is_active</span>学期是否当前有效 (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">semester_id</th>
                        <th scope="col">term</th>
                        <th scope="col">academic_year</th>
                        <th scope="col">name</th>
                        <th scope="col">start_date</th>
                        <th scope="col">end_date</th>
                        <th scope="col">enroll_deadline</th>
                        <th scope="col">is_active</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>秋季</td>
                        <td>2024</td>
                        <td>2024 秋季</td>
                        <td>2024-09-02</td>
                        <td>2024-12-20</td>
                        <td>2024-09-13</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (semester_id)</li>
            <li>唯一键 (term, academic_year)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>rooms</span> - 校园教室和实验室。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>room_id</span>唯一记录标识符 (PK, SMALLINT)</li>
            <li><span class='sql'>building</span>建筑名称</li>
            <li><span class='sql'>room_number</span>房间号码或标签</li>
            <li><span class='sql'>capacity</span>最大座位数 (SMALLINT)</li>
            <li><span class='sql'>room_type</span>房间类型：讲座、研讨会、实验室、计算机实验室或在线 (ENUM)</li>
            <li><span class='sql'>has_projector</span>房间是否有投影仪 (BOOLEAN)</li>
            <li><span class='sql'>has_video</span>房间是否有视频会议设备 (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">room_id</th>
                        <th scope="col">building</th>
                        <th scope="col">room_number</th>
                        <th scope="col">capacity</th>
                        <th scope="col">room_type</th>
                        <th scope="col">has_projector</th>
                        <th scope="col">has_video</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>科学大楼</td>
                        <td>101</td>
                        <td>120</td>
                        <td>讲座</td>
                        <td>1</td>
                        <td>0</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (room_id)</li>
            <li>唯一键 (building, room_number)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>scholarships</span> - 可用奖学金和助学金。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>scholarship_id</span>唯一记录标识符 (PK, SMALLINT)</li>
            <li><span class='sql'>name</span>奖学金名称</li>
            <li><span class='sql'>amount</span>奖励金额 (DECIMAL)</li>
            <li><span class='sql'>frequency</span>奖励频率：一次性、年度或每学期 (ENUM)</li>
            <li><span class='sql' style="min-width: 10rem;">eligibility</span>资格标准作为 JSON — 例如 <code>{ldelim}"min_gpa": 3.5, "need_based": true{rdelim}</code></li>
            <li><span class='sql'>is_active</span>奖学金是否当前提供 (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">scholarship_id</th>
                        <th scope="col">name</th>
                        <th scope="col">amount</th>
                        <th scope="col">frequency</th>
                        <th scope="col">eligibility</th>
                        <th scope="col">is_active</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>院长优秀奖</td>
                        <td>5000.00</td>
                        <td>年度</td>
                        <td>{ldelim}"min_gpa": 3.8, "need_based": false, "majors": ["CS","Math"]{rdelim}</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>departments</span> - 三层部门层级 (学院 → 部门 → 子部门)。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>唯一记录标识符 (PK, TINYINT)</li>
            <li><span class='sql'>parent_id</span>父部门标识符 — 自引用外键 (可为空)</li>
            <li><span class='sql'>code</span>短部门代码 (CHAR)</li>
            <li><span class='sql'>name</span>部门名称</li>
            <li><span class='sql'>level</span>层级：1 = 学院，2 = 部门，3 = 子部门 (TINYINT)</li>
            <li><span class='sql'>head_faculty_id</span>部门负责人的标识符 (外键，可为空)</li>
            <li><span class='sql'>established</span>部门成立年份 (YEAR，可为空)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">department_id</th>
                        <th scope="col">parent_id</th>
                        <th scope="col">code</th>
                        <th scope="col">name</th>
                        <th scope="col">level</th>
                        <th scope="col">head_faculty_id</th>
                        <th scope="col">established</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>[null]</td>
                        <td>ENG</td>
                        <td>工程学院</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1965</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (department_id)</li>
            <li>唯一键 (code)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (parent_id) 参考 departments(department_id)</li>
            <li>外键 (head_faculty_id) 参考 faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>faculty</span> - 学术和行政人员。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>唯一记录标识符 (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>部门标识符 (外键)</li>
            <li><span class='sql'>first_name</span>教职员工的名字</li>
            <li><span class='sql'>last_name</span>教职员工的姓氏</li>
            <li><span class='sql'>email</span>机构电子邮件地址</li>
            <li><span class='sql'>phone</span>办公室电话号码 (可为空)</li>
            <li><span class='sql'>rank</span>学术职称：讲师、助理教授、副教授、教授或名誉教授 (ENUM)</li>
            <li><span class='sql'>hire_date</span>入职日期</li>
            <li><span class='sql'>office</span>办公室房间号码或位置 (可为空)</li>
            <li><span class='sql'>office_hours</span>每周办公时间作为 JSON 数组 — 例如 <code>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</code></li>
            <li><span class='sql'>bio</span>个人简介文本 (TEXT, 可为空)</li>
            <li><span class='sql'>is_active</span>教职员工是否当前有效 (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">faculty_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">phone</th>
                        <th scope="col">rank</th>
                        <th scope="col">hire_date</th>
                        <th scope="col">office</th>
                        <th scope="col">office_hours</th>
                        <th scope="col">bio</th>
                        <th scope="col">is_active</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>3</td>
                        <td>Alice</td>
                        <td>Carter</td>
                        <td>a.carter@university.edu</td>
                        <td>+15550100</td>
                        <td>教授</td>
                        <td>2010-08-15</td>
                        <td>ENG-204</td>
                        <td>[{ldelim}"day":"Mon","start":"10:00","end":"12:00"{rdelim}]</td>
                        <td>分布式系统专家。</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (faculty_id)</li>
            <li>唯一键 (email)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (department_id) 参考 departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>students</span> - 注册学生。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>唯一记录标识符 (PK, INT)</li>
            <li><span class='sql'>department_id</span>所属部门标识符 (外键)</li>
            <li><span class='sql'>student_number</span>唯一学生 ID 号码 (CHAR, 例如 'S000123')</li>
            <li><span class='sql'>first_name</span>学生的名字</li>
            <li><span class='sql'>last_name</span>学生的姓氏</li>
            <li><span class='sql'>email</span>学生的电子邮件地址</li>
            <li><span class='sql'>date_of_birth</span>学生的出生日期</li>
            <li><span class='sql'>gender</span>性别：M、F、NB、其他或不愿透露 (ENUM, 可为空)</li>
            <li><span class='sql'>enrollment_date</span>学生首次注册的日期</li>
            <li><span class='sql'>expected_grad</span>预计毕业年份 (YEAR, 可为空)</li>
            <li><span class='sql'>status</span>注册状态：有效、无效、已毕业、暂停或退学 (ENUM)</li>
            <li><span class='sql'>gpa</span>累计 GPA 0.000–4.000，由触发器维护 (DECIMAL, 可为空)</li>
            <li><span class='sql'>contacts</span>紧急联系人和地址作为 JSON — 例如 <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">student_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">date_of_birth</th>
                        <th scope="col">gender</th>
                        <th scope="col">enrollment_date</th>
                        <th scope="col">expected_grad</th>
                        <th scope="col">status</th>
                        <th scope="col">gpa</th>
                        <th scope="col">contacts</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>3</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>j.miller@student.edu</td>
                        <td>2002-04-23</td>
                        <td>M</td>
                        <td>2021-09-01</td>
                        <td>2025