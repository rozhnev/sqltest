<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Base de datos Querynomicon: estructura de tablas y resumen</h2>
    <p>Querynomicon (SQLite) es una base de datos de entrenamiento compacta para aprender los fundamentos de SQL con ejemplos claros y simples.</p>
    <p>Esta página presenta las tablas, columnas clave y filas de muestra para la práctica práctica de SQL.</p>
    <p>La base de datos Querynomicon contiene 5 tablas principales.</p>
    <h3>Lista de tablas</h3>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>department</span> - tabla de departamentos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID del departamento</li>
            <li> <span class='sql'>name</span>Nombre del departamento</li>
            <li> <span class='sql'>building</span>Nombre del edificio</li>
        </ul>
        <div class="table-wrapper">
            <table class=""><thead><tr>
                    <th scope="col">ident</th>
                    <th scope="col">name</th>
                    <th scope="col">building</th>
                </tr></thead><tbody><tr>
                    <td>gen</td>
                    <td>Genética</td>
                    <td>Chesson</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>little_penguins</span> - tabla de pingüinos pequeños.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Especie de pingüino</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>Isla de residencia</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Longitud del pico, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Profundidad del pico, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Longitud de la aleta, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Masa corporal, g</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Sexo</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>penguins</span> - tabla de pingüinos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 12rem;">species</span>Especie de pingüino</li>
            <li> <span class='sql' style="min-width: 12rem;">island</span>Isla de residencia</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_length_mm</span>Longitud del pico, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">bill_depth_mm</span>Profundidad del pico, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">flipper_length_mm</span>Longitud de la aleta, mm</li>
            <li> <span class='sql' style="min-width: 12rem;">body_mass_g</span>Masa corporal, g</li>
            <li> <span class='sql' style="min-width: 12rem;">sex</span>Sexo</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>staff</span> - tabla de empleados.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Número de empleado</li>
            <li> <span class='sql'>personal</span>Nombre del empleado</li>
            <li> <span class='sql'>family</span>Apellido del empleado</li>
            <li> <span class='sql'>dept</span>Departamento</li>
            <li> <span class='sql'>age</span>Edad</li>
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
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>machine</span> - tabla de máquinas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID de la máquina</li>
            <li> <span class='sql'>name</span>Nombre de la máquina</li>
            <li> <span class='sql'>details</span>JSON con detalles</li>
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
                    <td>{"note": "necesita actualización de software"}</td>
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