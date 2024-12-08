<div id="db-description" class="db-description">
    <h2>Querynomicon (SQLite)</h2>
    Компактная база данных для изучения основ SQL.
    <p>База данных Bookings содержит таблицы:</p>
    <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
        <li><span class='sql' onclick="scrollInfoPanel('little_penguins_table_description')">little_penguins</span> - таблица малых пингвинов.</li>
        <li><span class='sql' onclick="scrollInfoPanel('penguins_table_description')">penguins</span> - таблица пингвинов.</li>
    </ul>
    <h3 id="little_penguins_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
            <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
            </svg>
        </span>
        Таблица <span class='sql'>little_penguins</span>
    </h3>
    Колонки: 
    <ul class="table-columns">
        <li> <span class='sql'>species</span> – Вид пингвина.</li>
        <li> <span class='sql'>island</span> — Остров проживания.</li>
        <li> <span class='sql'>bill_length_mm</span> – Длина клюва, мм.</li>
        <li> <span class='sql'>bill_depth_mm</span> – Глубина клюва, мм.</li>
        <li> <span class='sql'>flipper_length_mm</span> – Длина плавника, мм.</li>
        <li> <span class='sql'>body_mass_g</span> – Масса тела, гр.</li>
        <li> <span class='sql'>sex</span> – Пол.</li>
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
    <h3 id="penguins_table_description">
        <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Scroll up">
            <svg height="15" width="15" style="">
            <polygon points="8,1 15,14 1,14" fill="white"/>
            </svg>
        </span>
        Таблица <span class='sql'>penguins</span>
    </h3>
    Колонки: 
    <ul class="table-columns">
        <li> <span class='sql'>species</span> – Вид пингвина.</li>
        <li> <span class='sql'>island</span> — Остров проживания.</li>
        <li> <span class='sql'>bill_length_mm</span> – Длина клюва, мм.</li>
        <li> <span class='sql'>bill_depth_mm</span> – Глубина клюва, мм.</li>
        <li> <span class='sql'>flipper_length_mm</span> – Длина плавника, мм.</li>
        <li> <span class='sql'>body_mass_g</span> – Масса тела, гр.</li>
        <li> <span class='sql'>sex</span> – Пол.</li>
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
