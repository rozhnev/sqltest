<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 6rem;
        }
    </style>
    <h2>Querynomicon (SQLite)</h2>
    Компактная база данных для изучения основ SQL.
    <h3>База данных Querynomicon содержит таблицы:</h3>
    <div class="accordion active">
        <span><span class='sql'>little_penguins</span> - таблица малых пингвинов.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Вид пингвина.</li>
            <li> <span class='sql'>island</span> — Остров проживания.</li>
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
            <li> <span class='sql'>island</span> — Остров проживания.</li>
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
    {if $User->showAd()}
        <div class="referal-add-block">
            <a href="https://book24.ru/r/MdRZN?erid=LjN8JzJBX" target="_blank" style="text-decoration: none; display: flex; ">
                <div  style = "width: 30%;">
                    <img style="width: 100%;" src="//ndc.book24.ru/resize/820x1180/pim/products/images/97/d1/01907881-ff4d-78d9-ac6a-7021d02597d1.jpg" alt="SQL: быстрое погружение.">
                </div>
                <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                    <div>Шилдс Уолтер: SQL: быстрое погружение.</div>
                    <div style="font-size: small; padding-top: 0.5em;">
                        Книга «SQL: быстрое погружение» идеальна для всех, кто ищет новые перспективы карьерного роста; для разработчиков, которые хотят расширить свои навыки и знания в программировании; для любого человека, даже без опыта, кто хочет воспользоваться возможностями будущего, в котором будут править данные.
                    </div>
                </div>
            </a>
        </div>
    {/if}
</div>
