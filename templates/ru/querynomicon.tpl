<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Querynomicon (SQLite)</h2>
    Компактная база данных для изучения основ SQL.
    <h3>База данных Querynomicon содержит таблицы:</h3>
    <div class="accordion active">
        <span><span class='sql'>department</span> - таблица отделов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID отдела.</li>
            <li> <span class='sql'>name</span>Название отдела.</li>
            <li> <span class='sql'>building</span>Название здания.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody>
                <tr>
                    <th>ident</th>
                    <th>name</th>
                    <th>building</th>
                </tr>
                <tr>
                    <td>gen</td>
                    <td>Genetics</td>
                    <td>Chesson</td>
                </tr>
            </tbody></table>
        </div>
    </div>
    <div class="accordion active">
        <span><span class='sql'>little_penguins</span> - таблица малых пингвинов.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Вид пингвина.</li>
            <li> <span class='sql'>island</span> Остров проживания.</li>
            <li> <span class='sql'>bill_length_mm</span>Длина клюва, мм.</li>
            <li> <span class='sql'>bill_depth_mm</span>Глубина клюва, мм.</li>
            <li> <span class='sql'>flipper_length_mm</span>Длина плавника, мм.</li>
            <li> <span class='sql'>body_mass_g</span>Масса тела, гр.</li>
            <li> <span class='sql'>sex</span>Пол.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody>
                <tr>
                    <th>species</th>
                    <th>island</th>
                    <th>bill_length_mm</th>
                    <th>bill_depth_mm</th>
                    <th>flipper_length_mm</th>
                    <th>body_mass_g</th>
                    <th>sex</th>
                </tr>
                <tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>MALE</td>
                </tr>
            </tbody></table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>penguins</span> - таблица пингвинов.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Вид пингвина.</li>
            <li> <span class='sql'>island</span> Остров проживания.</li>
            <li> <span class='sql'>bill_length_mm</span>Длина клюва, мм.</li>
            <li> <span class='sql'>bill_depth_mm</span>Глубина клюва, мм.</li>
            <li> <span class='sql'>flipper_length_mm</span>Длина плавника, мм.</li>
            <li> <span class='sql'>body_mass_g</span>Масса тела, гр.</li>
            <li> <span class='sql'>sex</span>Пол.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody>
                <tr>
                    <th>species</th>
                    <th>island</th>
                    <th>bill_length_mm</th>
                    <th>bill_depth_mm</th>
                    <th>flipper_length_mm</th>
                    <th>body_mass_g</th>
                    <th>sex</th>
                </tr>
                <tr>
                    <td>Gentoo</td>
                    <td>Biscoe</td>
                    <td>52.1</td>
                    <td>17</td>
                    <td>230</td>
                    <td>5550</td>
                    <td>MALE</td>
                </tr>
            </tbody></table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>staff</span> - таблица сотрудников.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Номер сотрудника.</li>
            <li> <span class='sql'>personal</span>Имя сотрудника.</li>
            <li> <span class='sql'>family</span>Фамилия сотрудника.</li>
            <li> <span class='sql'>dept</span>Подразделение.</li>
            <li> <span class='sql'>age</span>Возраст.</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><tbody>
                <tr>
                    <th>ident</th>
                    <th>personal</th>
                    <th>family</th>
                    <th>dept</th>
                    <th>age</th>
                </tr>
                <tr>
                    <td>7</td>
                    <td>Abram</td>
                    <td>Chokshi</td>
                    <td>gen</td>
                    <td>23</td>
                </tr>
            </tbody></table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>machine</span> - таблица машин.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Идентификатор машины.</li>
            <li> <span class='sql'>name</span>Название машины.</li>
            <li> <span class='sql'>details</span>Информация о машине в формате JSON.</li>
        </ul>
        <div class="table-wrapper">
            {literal}
            <table class=""><tbody>
                <tr>
                    <th>ident</th>
                    <th>name</th>
                    <th>details</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>WY401</td>
                    <td>{"acquired": "2023-05-01"}</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Inphormex</td>
                    <td>{"acquired": "2021-07-15", "refurbished": "2023-10-22"}</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>AutoPlate 9000</td>
                    <td>{"note": "needs software update"}</td>
                </tr>
            </tbody></table>
            {/literal}
        </div>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            <div id="yandex_rtb_R-A-4716552-7"></div>
        </div>
    {/if}
</div>
