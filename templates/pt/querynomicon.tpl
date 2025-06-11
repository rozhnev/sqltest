<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 9rem;
        }
    </style>
    <h2>Querynomicon (SQLite)</h2>
    Base de dados compacta para aprender os fundamentos do SQL.
    <h3>A base de dados Querynomicon contém tabelas:</h3>
    <div class="accordion active">
        <span><span class='sql'>departments</span> - tabela de departamentos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>ID do departamento.</li>
            <li> <span class='sql'>name</span>Nome do departamento.</li>
            <li> <span class='sql'>building</span>Nome do prédio.</li>
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
        <span><span class='sql'>little_penguins</span> - tabela de pequenos pinguins.</span>
    </div>
    <div class="panel active">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Espécie de pinguim.</li>
            <li> <span class='sql'>island</span>Ilha de residência.</li>
            <li> <span class='sql'>bill_length_mm</span>Comprimento do bico, mm.</li>
            <li> <span class='sql'>bill_depth_mm</span>Profundidade do bico, mm.</li>
            <li> <span class='sql'>flipper_length_mm</span>Comprimento da nadadeira, mm.</li>
            <li> <span class='sql'>body_mass_g</span>Massa corporal, g.</li>
            <li> <span class='sql'>sex</span>Sexo.</li>
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
        <span><span class='sql'>penguins</span> - tabela de pinguins.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>species</span>Espécie de pinguim.</li>
            <li> <span class='sql'>island</span>Ilha de residência.</li>
            <li> <span class='sql'>bill_length_mm</span>Comprimento do bico, mm.</li>
            <li> <span class='sql'>bill_depth_mm</span>Profundidade do bico, mm.</li>
            <li> <span class='sql'>flipper_length_mm</span>Comprimento da nadadeira, mm.</li>
            <li> <span class='sql'>body_mass_g</span>Massa corporal, g.</li>
            <li> <span class='sql'>sex</span>Sexo.</li>
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
        <span><span class='sql'>staff</span> - tabela de funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>ident</span>Número do funcionário.</li>
            <li> <span class='sql'>personal</span>Nome do funcionário.</li>
            <li> <span class='sql'>family</span>Sobrenome do funcionário.</li>
            <li> <span class='sql'>dept</span>Departamento.</li>
            <li> <span class='sql'>age</span>Idade.</li>
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
        {if isset($Book)}
            <div class="referal-add-block">
                <a id="crse:uTqLw0ABEe2G8Are2MuL1Q" 
                    href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AuTqLw0ABEe2G8Are2MuL1Q&u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fsql-practical-introduction-for-querying-databases&intsrc=PUI2_9419" 
                    target="_blank"
                    style="
                        display: block;
                        max-width: 48%;
                        height: 200px;
                        background: url('https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/34/3819b0a78a424a82ede83dc0cfad4f/Querying-Databases-with-SQL.jpg?auto=format%2Ccompress&dpr=1&w=200&h=200&fit=crop') no-repeat;
                    "
                    >
                    <div style="
                            background: white;
                            color: black;
                            margin: 5px;
                            padding: 3px;
                            border-radius: 3px;
                            opacity: 75%;
                            max-width: 88%;
                    ">
                        SQL: A Practical Introduction for Querying Databases
                    </div>
                </a>
                <a id="spzn:child~RXPU-mWaEeunahLL3oLBRQ" 
                    href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3Achild%7ERXPU-mWaEeunahLL3oLBRQ&u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fdata-science-fundamentals-python-sql&intsrc=PUI2_9419"
                    target="_blank"
                    style="
                        display: block;
                        max-width: 48%;
                        height: 200px;
                        background: url('https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/bd/0202c87e244d30bdecd889bd2719ae/DataScienceFundamentalsPythonSQL.png?auto=format%2Ccompress&dpr=1&w=200&h=200&fit=crop') no-repeat;
                    "
                    >
                    <div style="
                            background: white;
                            color: black;
                            margin: 5px;
                            padding: 3px;
                            border-radius: 3px;
                            opacity: 75%;
                            max-width: 88%;
                    ">
                        Data Science Fundamentals with Python and SQL
                    </div>
                </a>
            </div>
        {/if}
    {/if}
</div>