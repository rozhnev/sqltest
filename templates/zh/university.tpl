<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    {* The landing page /zh/database/university has its own intro: only the table list there *}
    {if ($Action|default:'') != 'database'}
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
    <p><a href="/{$Lang}/database/university">了解更多 University 数据库：模式、示例查询和全部练习 →</a></p>
    {/if}
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
            <li><span class='sql'>department_id</span>所属院系标识符 (FK)</li>
            <li><span class='sql'>student_number</span>唯一学号 (CHAR，例如 'S000123')</li>
            <li><span class='sql'>first_name</span>学生的名字</li>
            <li><span class='sql'>last_name</span>学生的姓氏</li>
            <li><span class='sql'>email</span>学生的电子邮件地址</li>
            <li><span class='sql'>date_of_birth</span>学生的出生日期</li>
            <li><span class='sql'>gender</span>性别：M、F、NB、Other 或 Prefer not to say (ENUM，可为空)</li>
            <li><span class='sql'>enrollment_date</span>学生首次入学日期</li>
            <li><span class='sql'>expected_grad</span>预计毕业年份 (YEAR，可为空)</li>
            <li><span class='sql'>status</span>学籍状态：active、inactive、graduated、suspended 或 withdrawn (ENUM)</li>
            <li><span class='sql'>gpa</span>累计 GPA 0.000–4.000，由触发器维护 (DECIMAL，可为空)</li>
            <li><span class='sql'>contacts</span>紧急联系人和地址（JSON），例如 <code>{ldelim}"emergency":{ldelim}"name":"Jane Doe","phone":"+1-555-0100"{rdelim}{rdelim}</code></li>
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
                        <td>2025</td>
                        <td>active</td>
                        <td>3.720</td>
                        <td>{ldelim}"emergency":{ldelim}"name":"Susan Miller","phone":"+1-555-0100"{rdelim}{rdelim}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (student_id)</li>
            <li>唯一键 (student_number)</li>
            <li>唯一键 (email)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (department_id) 参考 departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>courses</span> - 支持全文和向量搜索的课程目录。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>唯一记录标识符 (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>开课院系标识符 (FK)</li>
            <li><span class='sql'>code</span>课程代码，例如 'CS101' (CHAR)</li>
            <li><span class='sql'>title</span>课程名称</li>
            <li><span class='sql'>credits</span>学分数 (TINYINT)</li>
            <li><span class='sql'>level</span>学术层次：undergraduate、graduate 或 doctoral (ENUM)</li>
            <li><span class='sql'>description</span>详细课程描述 (TEXT，与 title 共同建立 FULLTEXT 索引)</li>
            <li><span class='sql'>is_active</span>课程当前是否开设 (BOOLEAN)</li>
            <li><span class='sql'>embedding</span>用于向量相似度搜索的 1536 维语义嵌入 (VECTOR(1536)，可为空)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">code</th>
                        <th scope="col">title</th>
                        <th scope="col">credits</th>
                        <th scope="col">level</th>
                        <th scope="col">description</th>
                        <th scope="col">is_active</th>
                        <th scope="col">embedding</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>3</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>3</td>
                        <td>undergraduate</td>
                        <td>Introduction to relational databases, SQL, and data modeling.</td>
                        <td>1</td>
                        <td>[0.023, -0.011, ...]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (course_id)</li>
            <li>唯一键 (code)</li>
            <li>FULLTEXT (title, description)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (department_id) 参考 departments(department_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>course_prerequisites</span> - 课程先修关系（自引用多对多）。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>课程标识符 (FK)</li>
            <li><span class='sql'>prerequisite_id</span>先修课程标识符 (FK)</li>
            <li><span class='sql'>is_mandatory</span>先修课程是必修还是推荐 (BOOLEAN)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">prerequisite_id</th>
                        <th scope="col">is_mandatory</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5</td>
                        <td>1</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (course_id, prerequisite_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (course_id) 参考 courses(course_id)</li>
            <li>外键 (prerequisite_id) 参考 courses(course_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>sections</span> - 某学期开设的一个课程班。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>唯一记录标识符 (PK, INT)</li>
            <li><span class='sql'>course_id</span>课程标识符 (FK)</li>
            <li><span class='sql'>semester_id</span>学期标识符 (FK)</li>
            <li><span class='sql'>faculty_id</span>授课教师标识符 (FK)</li>
            <li><span class='sql'>room_id</span>分配的教室标识符 (FK，可为空——完全在线时为 NULL)</li>
            <li><span class='sql'>section_number</span>课程/学期内的班号 (TINYINT)</li>
            <li><span class='sql'>delivery</span>授课方式：in-person、online 或 hybrid (ENUM)</li>
            <li><span class='sql'>max_capacity</span>最大选课人数 (SMALLINT)</li>
            <li><span class='sql'>status</span>课程班状态：open、closed、cancelled 或 completed (ENUM)</li>
            <li><span class='sql'>schedule</span>每周上课时间（JSON），例如 <code>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim}]</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">section_id</th>
                        <th scope="col">course_id</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">faculty_id</th>
                        <th scope="col">room_id</th>
                        <th scope="col">section_number</th>
                        <th scope="col">delivery</th>
                        <th scope="col">max_capacity</th>
                        <th scope="col">status</th>
                        <th scope="col">schedule</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>in-person</td>
                        <td>30</td>
                        <td>open</td>
                        <td>[{ldelim}"day":"Mon","start":"09:00","end":"10:30"{rdelim},{ldelim}"day":"Wed","start":"09:00","end":"10:30"{rdelim}]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (section_id)</li>
            <li>唯一键 (course_id, semester_id, section_number)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (course_id) 参考 courses(course_id)</li>
            <li>外键 (semester_id) 参考 semesters(semester_id)</li>
            <li>外键 (faculty_id) 参考 faculty(faculty_id)</li>
            <li>外键 (room_id) 参考 rooms(room_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>enrollments</span> - 学生选课记录。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>enrollment_id</span>唯一记录标识符 (PK, INT)</li>
            <li><span class='sql'>student_id</span>学生标识符 (FK)</li>
            <li><span class='sql'>section_id</span>课程班标识符 (FK)</li>
            <li><span class='sql'>enrolled_at</span>选课日期和时间 (TIMESTAMP)</li>
            <li><span class='sql'>status</span>选课状态：enrolled、dropped、completed、failed 或 incomplete (ENUM)</li>
            <li><span class='sql'>final_grade</span>最终字母成绩，例如 'A'、'B+' (CHAR，可为空)</li>
            <li><span class='sql'>final_score</span>最终分数 0.00–100.00 (DECIMAL，可为空)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">enrollment_id</th>
                        <th scope="col">student_id</th>
                        <th scope="col">section_id</th>
                        <th scope="col">enrolled_at</th>
                        <th scope="col">status</th>
                        <th scope="col">final_grade</th>
                        <th scope="col">final_score</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>2024-08-25 10:34:02</td>
                        <td>completed</td>
                        <td>A</td>
                        <td>93.50</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (enrollment_id)</li>
            <li>唯一键 (student_id, section_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (student_id) 参考 students(student_id)</li>
            <li>外键 (section_id) 参考 sections(section_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>student_scholarships</span> - 授予学生的奖学金。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>award_id</span>唯一记录标识符 (PK, INT)</li>
            <li><span class='sql'>student_id</span>学生标识符 (FK)</li>
            <li><span class='sql'>scholarship_id</span>奖学金标识符 (FK)</li>
            <li><span class='sql'>awarded_date</span>奖学金授予日期</li>
            <li><span class='sql'>expires_date</span>奖学金到期日期（可为空）</li>
            <li><span class='sql'>amount_awarded</span>实际授予金额 (DECIMAL)</li>
            <li><span class='sql'>notes</span>关于奖学金的附加说明 (TEXT，可为空)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">award_id</th>
                        <th scope="col">student_id</th>
                        <th scope="col">scholarship_id</th>
                        <th scope="col">awarded_date</th>
                        <th scope="col">expires_date</th>
                        <th scope="col">amount_awarded</th>
                        <th scope="col">notes</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>2024-09-01</td>
                        <td>2025-08-31</td>
                        <td>5000.00</td>
                        <td>[null]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (award_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (student_id) 参考 students(student_id)</li>
            <li>外键 (scholarship_id) 参考 scholarships(scholarship_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>research_projects</span> - 教师主导的科研项目。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>project_id</span>唯一记录标识符 (PK, SMALLINT)</li>
            <li><span class='sql'>department_id</span>院系标识符 (FK)</li>
            <li><span class='sql'>lead_faculty_id</span>项目负责人 (FK)</li>
            <li><span class='sql'>title</span>项目名称</li>
            <li><span class='sql'>abstract</span>项目描述 (TEXT，可为空)</li>
            <li><span class='sql'>start_date</span>项目开始日期</li>
            <li><span class='sql'>end_date</span>项目结束日期（可为空）</li>
            <li><span class='sql'>status</span>项目状态：proposed、active、completed 或 cancelled (ENUM)</li>
            <li><span class='sql'>funding</span>资金来源（JSON），例如 <code>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2024-001"{rdelim}]</code></li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">project_id</th>
                        <th scope="col">department_id</th>
                        <th scope="col">lead_faculty_id</th>
                        <th scope="col">title</th>
                        <th scope="col">abstract</th>
                        <th scope="col">start_date</th>
                        <th scope="col">end_date</th>
                        <th scope="col">status</th>
                        <th scope="col">funding</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>5</td>
                        <td>1</td>
                        <td>AI-Assisted Drug Discovery</td>
                        <td>Using machine learning to identify candidate molecules.</td>
                        <td>2023-01-15</td>
                        <td>[null]</td>
                        <td>active</td>
                        <td>[{ldelim}"source":"NSF","amount":150000,"grant_id":"NSF-2023-042"{rdelim}]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (project_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (department_id) 参考 departments(department_id)</li>
            <li>外键 (lead_faculty_id) 参考 faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>publications</span> - 支持全文搜索的科研论文。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>publication_id</span>唯一记录标识符 (PK, INT)</li>
            <li><span class='sql'>project_id</span>关联的科研项目 (FK，可为空)</li>
            <li><span class='sql'>title</span>论文标题</li>
            <li><span class='sql'>abstract</span>论文摘要 (MEDIUMTEXT，与 title 共同建立 FULLTEXT 索引)</li>
            <li><span class='sql'>pub_year</span>发表年份 (YEAR)</li>
            <li><span class='sql'>venue</span>期刊或会议名称（可为空）</li>
            <li><span class='sql'>doi</span>数字对象标识符 DOI（可为空）</li>
            <li><span class='sql' style="min-width: 9rem;">keywords</span>关键词标签，可取以下一个或多个值：AI、ML、Data Science、Networking、Security、Algorithms、Databases、HCI、Theory、Bioinformatics、Systems、Mathematics、Physics、Chemistry、Biology (SET)</li>
            <li><span class='sql'>citation_count</span>被引用次数 (INT)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">publication_id</th>
                        <th scope="col">project_id</th>
                        <th scope="col">title</th>
                        <th scope="col">abstract</th>
                        <th scope="col">pub_year</th>
                        <th scope="col">venue</th>
                        <th scope="col">doi</th>
                        <th scope="col">keywords</th>
                        <th scope="col">citation_count</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>Deep Learning for Molecular Screening</td>
                        <td>We present a transformer-based architecture for virtual screening...</td>
                        <td>2024</td>
                        <td>Nature Machine Intelligence</td>
                        <td>10.1038/s42256-024-00001-1</td>
                        <td>AI,ML,Bioinformatics</td>
                        <td>12</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (publication_id)</li>
            <li>唯一键 (doi)</li>
            <li>FULLTEXT (title, abstract)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (project_id) 参考 research_projects(project_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>project_members</span> - 教师和学生参与科研项目的记录。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>member_id</span>唯一记录标识符 (PK, INT)</li>
            <li><span class='sql'>project_id</span>科研项目标识符 (FK)</li>
            <li><span class='sql'>faculty_id</span>教师标识符 (FK，可为空)</li>
            <li><span class='sql'>student_id</span>学生标识符 (FK，可为空)</li>
            <li><span class='sql'>role</span>成员角色：Principal Investigator、Co-Investigator、Research Assistant、Graduate Student 或 Undergraduate Student (ENUM)</li>
            <li><span class='sql'>joined_date</span>成员加入项目的日期</li>
            <li><span class='sql'>left_date</span>成员离开项目的日期（可为空）</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">member_id</th>
                        <th scope="col">project_id</th>
                        <th scope="col">faculty_id</th>
                        <th scope="col">student_id</th>
                        <th scope="col">role</th>
                        <th scope="col">joined_date</th>
                        <th scope="col">left_date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td>[null]</td>
                        <td>Principal Investigator</td>
                        <td>2023-01-15</td>
                        <td>[null]</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (member_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (project_id) 参考 research_projects(project_id)</li>
            <li>外键 (faculty_id) 参考 faculty(faculty_id)</li>
            <li>外键 (student_id) 参考 students(student_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>grade_events</span> - 每条选课记录的单项评分（约 120 000 行）。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>event_id</span>唯一记录标识符 (PK, BIGINT)</li>
            <li><span class='sql'>enrollment_id</span>选课记录标识符 (FK)</li>
            <li><span class='sql'>item_name</span>评分项名称，例如 'Assignment 1'、'Midterm Exam'</li>
            <li><span class='sql'>item_type</span>评分项类型：assignment、quiz、midterm、final、project、participation 或 lab (ENUM)</li>
            <li><span class='sql'>score</span>得分 (DECIMAL)</li>
            <li><span class='sql'>max_score</span>满分，默认 100.00 (DECIMAL)</li>
            <li><span class='sql'>weight</span>占最终成绩的比例，例如 0.1500 表示 15% (DECIMAL)</li>
            <li><span class='sql'>graded_at</span>成绩录入日期和时间 (DATETIME)</li>
            <li><span class='sql'>grader_id</span>评分教师 (FK，可为空)</li>
            <li><span class='sql'>feedback</span>评分教师的反馈 (TEXT，可为空)</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">event_id</th>
                        <th scope="col">enrollment_id</th>
                        <th scope="col">item_name</th>
                        <th scope="col">item_type</th>
                        <th scope="col">score</th>
                        <th scope="col">max_score</th>
                        <th scope="col">weight</th>
                        <th scope="col">graded_at</th>
                        <th scope="col">grader_id</th>
                        <th scope="col">feedback</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>Midterm Exam</td>
                        <td>midterm</td>
                        <td>87.00</td>
                        <td>100.00</td>
                        <td>0.3000</td>
                        <td>2024-10-18 14:22:00</td>
                        <td>1</td>
                        <td>Good analysis, review section 3.</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (event_id)</li>
        </ul>
        <ul class="table-columns">
            <li>外键 (enrollment_id) 参考 enrollments(enrollment_id)</li>
            <li>外键 (grader_id) 参考 faculty(faculty_id)</li>
        </ul>
    </div>
    <div class="accordion" title="点击展开，双击将表名粘贴到编辑器中">
        <span><span class='sql'>audit_log</span> - 由触发器生成的行级变更历史（约 60 000 行）。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>log_id</span>唯一记录标识符 (PK, BIGINT)</li>
            <li><span class='sql'>table_name</span>被修改的表名</li>
            <li><span class='sql'>record_id</span>被修改记录的主键 (BIGINT)</li>
            <li><span class='sql'>action</span>变更类型：INSERT、UPDATE 或 DELETE (ENUM)</li>
            <li><span class='sql'>changed_at</span>变更日期和时间 (TIMESTAMP)</li>
            <li><span class='sql'>changed_by</span>数据库用户或应用上下文（可为空）</li>
            <li><span class='sql'>old_values</span>变更前的列值（JSON，INSERT 时为 NULL）</li>
            <li><span class='sql'>new_values</span>变更后的列值（JSON，DELETE 时为 NULL）</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">log_id</th>
                        <th scope="col">table_name</th>
                        <th scope="col">record_id</th>
                        <th scope="col">action</th>
                        <th scope="col">changed_at</th>
                        <th scope="col">changed_by</th>
                        <th scope="col">old_values</th>
                        <th scope="col">new_values</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>enrollments</td>
                        <td>1</td>
                        <td>UPDATE</td>
                        <td>2024-12-21 09:05:33</td>
                        <td>app_user</td>
                        <td>{ldelim}"status":"enrolled","final_score":null{rdelim}</td>
                        <td>{ldelim}"status":"completed","final_score":93.50{rdelim}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <ul class="table-columns">
            <li>主键，btree (log_id)</li>
        </ul>
    </div>
    <h3>视图</h3>
    <div class="accordion" title="点击展开，双击将视图名粘贴到编辑器中">
        <span><span class='sql'>v_student_gpa</span> - 每名学生每学期的加权 GPA。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>student_id</span>学生标识符</li>
            <li><span class='sql'>student_number</span>唯一学号</li>
            <li><span class='sql'>first_name</span>学生的名字</li>
            <li><span class='sql'>last_name</span>学生的姓氏</li>
            <li><span class='sql'>semester_id</span>学期标识符</li>
            <li><span class='sql'>semester_name</span>学期名称</li>
            <li><span class='sql'>semester_gpa</span>本学期加权 GPA</li>
            <li><span class='sql'>credits_earned</span>本学期获得的学分</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">student_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">semester_gpa</th>
                        <th scope="col">credits_earned</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>1</td>
                        <td>Fall 2024</td>
                        <td>3.72</td>
                        <td>15</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将视图名粘贴到编辑器中">
        <span><span class='sql'>v_section_roster</span> - 各课程班的选课学生及联系方式。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>section_id</span>课程班标识符</li>
            <li><span class='sql'>course_code</span>课程代码</li>
            <li><span class='sql'>course_title</span>课程名称</li>
            <li><span class='sql'>semester_name</span>学期名称</li>
            <li><span class='sql'>student_id</span>学生标识符</li>
            <li><span class='sql'>student_number</span>唯一学号</li>
            <li><span class='sql'>first_name</span>学生的名字</li>
            <li><span class='sql'>last_name</span>学生的姓氏</li>
            <li><span class='sql'>email</span>学生的电子邮件地址</li>
            <li><span class='sql'>status</span>选课状态</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">section_id</th>
                        <th scope="col">course_code</th>
                        <th scope="col">course_title</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">student_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">email</th>
                        <th scope="col">status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>Fall 2024</td>
                        <td>1</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>j.miller@student.edu</td>
                        <td>enrolled</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将视图名粘贴到编辑器中">
        <span><span class='sql'>v_course_pass_rate</span> - 各课程的历史通过率和平均分。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>课程标识符</li>
            <li><span class='sql'>code</span>课程代码</li>
            <li><span class='sql'>title</span>课程名称</li>
            <li><span class='sql'>semester_id</span>学期标识符</li>
            <li><span class='sql'>semester_name</span>学期名称</li>
            <li><span class='sql'>total_enrolled</span>选课学生总数</li>
            <li><span class='sql'>passed</span>通过的学生人数</li>
            <li><span class='sql'>pass_rate</span>通过率（百分比）</li>
            <li><span class='sql'>avg_score</span>平均最终分数</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">code</th>
                        <th scope="col">title</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">total_enrolled</th>
                        <th scope="col">passed</th>
                        <th scope="col">pass_rate</th>
                        <th scope="col">avg_score</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>1</td>
                        <td>Fall 2024</td>
                        <td>28</td>
                        <td>25</td>
                        <td>89.29</td>
                        <td>81.40</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将视图名粘贴到编辑器中">
        <span><span class='sql'>v_faculty_workload</span> - 每位教师每学期的授课班数和满员率。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>faculty_id</span>教师标识符</li>
            <li><span class='sql'>first_name</span>教师的名字</li>
            <li><span class='sql'>last_name</span>教师的姓氏</li>
            <li><span class='sql'>semester_id</span>学期标识符</li>
            <li><span class='sql'>semester_name</span>学期名称</li>
            <li><span class='sql'>sections_taught</span>授课班数</li>
            <li><span class='sql'>total_capacity</span>所有课程班的总容量</li>
            <li><span class='sql'>total_enrolled</span>选课学生总数</li>
            <li><span class='sql'>fill_rate</span>满员率（百分比）</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">faculty_id</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">semester_id</th>
                        <th scope="col">semester_name</th>
                        <th scope="col">sections_taught</th>
                        <th scope="col">total_capacity</th>
                        <th scope="col">total_enrolled</th>
                        <th scope="col">fill_rate</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Alice</td>
                        <td>Carter</td>
                        <td>1</td>
                        <td>Fall 2024</td>
                        <td>3</td>
                        <td>90</td>
                        <td>82</td>
                        <td>91.11</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将视图名粘贴到编辑器中">
        <span><span class='sql'>v_top_scholars</span> - 按获得奖学金总额排名的学生。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>rank_position</span>按奖学金总额的排名</li>
            <li><span class='sql'>student_id</span>学生标识符</li>
            <li><span class='sql'>student_number</span>唯一学号</li>
            <li><span class='sql'>first_name</span>学生的名字</li>
            <li><span class='sql'>last_name</span>学生的姓氏</li>
            <li><span class='sql'>total_scholarships</span>获得奖学金的次数</li>
            <li><span class='sql'>total_amount</span>所有奖学金 amount_awarded 的总和</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">rank_position</th>
                        <th scope="col">student_id</th>
                        <th scope="col">student_number</th>
                        <th scope="col">first_name</th>
                        <th scope="col">last_name</th>
                        <th scope="col">total_scholarships</th>
                        <th scope="col">total_amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1</td>
                        <td>S000123</td>
                        <td>James</td>
                        <td>Miller</td>
                        <td>2</td>
                        <td>8500.00</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将视图名粘贴到编辑器中">
        <span><span class='sql'>v_publication_stats</span> - 各院系每年的论文数和引用数。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>department_id</span>院系标识符</li>
            <li><span class='sql'>department_name</span>院系名称</li>
            <li><span class='sql'>pub_year</span>发表年份</li>
            <li><span class='sql'>paper_count</span>发表论文数</li>
            <li><span class='sql'>total_citations</span>所有论文的总引用数</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">department_id</th>
                        <th scope="col">department_name</th>
                        <th scope="col">pub_year</th>
                        <th scope="col">paper_count</th>
                        <th scope="col">total_citations</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>3</td>
                        <td>Computer Science</td>
                        <td>2024</td>
                        <td>12</td>
                        <td>87</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="accordion" title="点击展开，双击将视图名粘贴到编辑器中">
        <span><span class='sql'>v_prerequisite_tree</span> - 每门课程的直接先修课程。</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>course_id</span>课程标识符</li>
            <li><span class='sql'>course_code</span>课程代码</li>
            <li><span class='sql'>course_title</span>课程名称</li>
            <li><span class='sql'>prerequisite_id</span>先修课程标识符</li>
            <li><span class='sql'>prerequisite_code</span>先修课程代码</li>
            <li><span class='sql'>prerequisite_title</span>先修课程名称</li>
            <li><span class='sql'>is_mandatory</span>先修课程是必修还是推荐</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th scope="col">course_id</th>
                        <th scope="col">course_code</th>
                        <th scope="col">course_title</th>
                        <th scope="col">prerequisite_id</th>
                        <th scope="col">prerequisite_code</th>
                        <th scope="col">prerequisite_title</th>
                        <th scope="col">is_mandatory</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5</td>
                        <td>CS401</td>
                        <td>Advanced Database Systems</td>
                        <td>1</td>
                        <td>CS301</td>
                        <td>Database Systems</td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
