<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Base de Datos de Empleados: estructura de la tabla y resumen</h2>
    <p>La base de datos de Empleados (Firebird) es un conjunto de datos de muestra utilizado para aprender SQL y explorar las capacidades del sistema de gestión de bases de datos Firebird.</p>
    <p>Esta página describe la estructura de la tabla, las columnas clave y las relaciones para consultas SQL prácticas.</p>
    <p>La base de datos de Empleados contiene 9 tablas principales.</p>
    <p>
        <a href="/{$Lang}/erd/Employee" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir el diagrama ER de la base de datos de Empleados en una nueva ventana">
            <img src="/images/erd_small_light.svg" alt="Diagrama ER de la base de datos de Empleados mostrando relaciones de tablas" width="1080" height="360" style="width: 90%; height: auto;" loading="lazy" decoding="async">
            Diagrama ER de la base de datos de Empleados
        </a>
    </p>
    <h3>Lista de tablas</h3>

    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>COUNTRY</span> - tabla de países.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Nombre del país</li>
            <li><span class='sql'>CURRENCY</span>Moneda utilizada en el país</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">CURRENCY</th>
                </tr></thead><tbody><tr>
                    <td>USA</td>
                    <td>Dólar</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>JOB</span> - horario del personal de la empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>Código de trabajo</li>
            <li><span class='sql'>JOB_GRADE</span>Grado de trabajo</li>
            <li><span class='sql'>JOB_COUNTRY</span>País asociado con el trabajo</li>
            <li><span class='sql'>JOB_TITLE</span>Título del trabajo</li>
            <li><span class='sql'>MIN_SALARY</span>Sueldo mínimo para el trabajo</li>
            <li><span class='sql'>MAX_SALARY</span>Sueldo máximo para el trabajo</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>Requisitos del trabajo</li>
            <li><span class='sql'>LANGUAGE_REQ</span>Requisitos de idioma</li>
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
                    <td>USA</td>
                    <td>Director Ejecutivo</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>No hay requisitos específicos.</td>
                    <td>[null]</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (JOB_COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>DEPARTMENT</span> - divisiones de la empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Número de departamento</li>
            <li><span class='sql'>DEPARTMENT</span>Nombre del departamento</li>
            <li><span class='sql'>HEAD_DEPT</span>Departamento principal (puede ser nulo)</li>
            <li><span class='sql'>MNGR_NO</span>Número de gerente</li>
            <li><span class='sql'>BUDGET</span>Presupuesto del departamento</li>
            <li><span class='sql'>LOCATION</span>Ubicación del departamento</li>
            <li><span class='sql'>PHONE_NO</span>Número de teléfono del departamento</li>
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
                    <td>Oficina Corporativa</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (HEAD_DEPT) REFERENCES DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>EMPLOYEE</span> - lista de empleados.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número de empleado</li>
            <li><span class='sql'>FIRST_NAME</span>Nombre del empleado</li>
            <li><span class='sql'>LAST_NAME</span>Apellido del empleado</li>
            <li><span class='sql'>PHONE_EXT</span>Extensión telefónica del empleado</li>
            <li><span class='sql'>HIRE_DATE</span>Fecha de contratación del empleado</li>
            <li><span class='sql'>DEPT_NO</span>Número de departamento</li>
            <li><span class='sql'>JOB_CODE</span>Código de trabajo del empleado</li>
            <li><span class='sql'>JOB_GRADE</span>Grado de trabajo del empleado</li>
            <li><span class='sql'>JOB_COUNTRY</span>País asociado con el trabajo del empleado</li>
            <li><span class='sql'>SALARY</span>Sueldo del empleado</li>
            <li><span class='sql'>FULL_NAME</span>Nombre completo del empleado</li>
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
                    <td>Robert</td>
                    <td>Nelson</td>
                    <td>250</td>
                    <td>1988-12-28 00:00:00</td>
                    <td>600</td>
                    <td>VP</td>
                    <td>2</td>
                    <td>USA</td>
                    <td>105900.00</td>
                    <td>Nelson, Robert</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)</li>
            <li>FOREIGN KEY (JOB_CODE) REFERENCES JOB(JOB_CODE)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>PROJECT</span> - lista de proyectos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>ID del proyecto</li>
            <li><span class='sql'>PROJ_NAME</span>Nombre del proyecto</li>
            <li><span class='sql'>PROJ_DESC</span>Descripción del proyecto</li>
            <li><span class='sql'>TEAM_LEADER</span>Líder del equipo para el proyecto</li>
            <li><span class='sql'>PRODUCT</span>Producto asociado con el proyecto</li>
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
                    <td>Base de Datos de Video</td>
                    <td>Desarrollo de un sistema de gestión de base de datos de video para gestionar la distribución de video bajo demanda.</td>
                    <td>45</td>
                    <td>software</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (TEAM_LEADER) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - mapeo de empleado-proyecto.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número de empleado</li>
            <li><span class='sql'>PROJ_ID</span>ID del proyecto</li>
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
            <li>FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)</li>
            <li>FOREIGN KEY (PROJ_ID) REFERENCES PROJECT(PROJ_ID)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - presupuestos de proyectos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>FISCAL_YEAR</span>Año fiscal</li>
            <li><span class='sql'>PROJ_ID</span>ID del proyecto</li>
            <li><span class='sql'>DEPT_NO</span>Número de departamento</li>
            <li><span class='sql'>QUART_HEAD_CNT</span>Conteo de cabezas del trimestre (puede ser nulo)</li>
            <li><span class='sql'>PROJECTED_BUDGET</span>Presupuesto proyectado para el año fiscal</li>
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
            <li>FOREIGN KEY (PROJ_ID) REFERENCES PROJECT(PROJ_ID)</li>
            <li>FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENT(DEPT_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>SALARY_HISTORY</span> - historial de cambios salariales de los empleados.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número de empleado</li>
            <li><span class='sql'>CHANGE_DATE</span>Fecha de cambio de salario</li>
            <li><span class='sql'>UPDATER_ID</span>ID del actualizador</li>
            <li><span class='sql'>OLD_SALARY</span>Salario anterior</li>
            <li><span class='sql'>PERCENT_CHANGE</span>Porcentaje de cambio en el salario</li>
            <li><span class='sql'>NEW_SALARY</span>Nuevo salario después del cambio</li>
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
            <li>FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Haga clic para expandir, haga doble clic para pegar el nombre de la tabla en el editor">
        <span><span class='sql'>CUSTOMER</span> - clientes de la empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>CUST_NO</span>Número de cliente</li>
            <li><span class='sql'>CUSTOMER</span>Nombre del cliente</li>
            <li><span class='sql'>CONTACT_FIRST</span>Nombre de la persona de contacto</li>
            <li><span class='sql'>CONTACT_LAST</span>Apellido de la persona de contacto</li>
            <li><span class='sql'>PHONE_NO</span>Número de teléfono del cliente</li>
            <li><span class='sql'>ADDRESS_LINE1</span>Línea de dirección 1</li>
            <li><span class='sql'>ADDRESS_LINE2</span>Línea de dirección 2 (puede ser nulo)</li>
            <li><span class='sql'>CITY</span>Ciudad del cliente</li>
            <li><span class='sql'>STATE_PROVINCE</span>Estado o provincia del cliente</li>
            <li><span class='sql'>COUNTRY</span>País del cliente</li>
            <li><span class='sql'>POSTAL_CODE</span>Código postal del cliente</li>
            <li><span class='sql'>ON_HOLD</span>Estado en espera (puede ser nulo)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">