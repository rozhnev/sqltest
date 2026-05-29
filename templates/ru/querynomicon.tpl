<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 7rem;
        }
    </style>
    <h2>База данных Querynomicon: структура таблиц и обзор</h2>
    <p>Querynomicon (SQLite) - компактная учебная база данных для изучения основ SQL на простых и понятных примерах.</p>
    <p>На этой странице представлены таблицы, ключевые поля и примеры строк для практики SQL-запросов.</p>
    <p>База данных Querynomicon содержит 5 основных таблиц.</p>
    <h3>Список таблиц</h3>
    <div class="accordion active">
        <span><span class='sql'>department</span> - таблица отделов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID отдела</li>
            <li> <span class='sql'>name</span>Название отдела</li>
            <li> <span class='sql'>building</span>Название здания</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">name</th>
                    <th scope="col">building</th>
                </tr></thead><tbody><tr>
                    <td>gen</td>
                    <td>Genetics</td>
                    <td>Chesson</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>little_penguins</span> - таблица малых пингвинов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Вид пингвина</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span> Остров проживания</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Длина клюва, мм</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Глубина клюва, мм</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Длина плавника, мм</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Масса тела, гр</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Пол</li>
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
                    <td>MALE</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>penguins</span> - таблица пингвинов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Вид пингвина</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span> Остров проживания</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Длина клюва, мм</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Глубина клюва, мм</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Длина плавника, мм</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Масса тела, гр</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Пол</li>
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
                    <td>MALE</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>staff</span> - таблица сотрудников.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Номер сотрудника</li>
            <li> <span class='sql'>personal</span>Имя сотрудника</li>
            <li> <span class='sql'>family</span>Фамилия сотрудника</li>
            <li> <span class='sql'>dept</span>Подразделение</li>
            <li> <span class='sql'>age</span>Возраст</li>
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
    <div class="accordion" title="Нажмите для развертывания, двойной щелчок для вставки в редактор">
        <span><span class='sql'>machine</span> - таблица машин.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Идентификатор машины</li>
            <li> <span class='sql'>name</span>Название машины</li>
            <li> <span class='sql'>details</span>Информация о машине в формате JSON</li>
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
                    <td>{"note": "needs software update"}</td>
                </tr></tbody></table>
            {/literal}
        </div>
    </div>
</div>
