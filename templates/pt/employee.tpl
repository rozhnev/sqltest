<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 10rem;
        }
    </style>
    <h2>Banco de Dados de Funcionários (Firebird)</h2>
    <p>
        Employee é um banco de dados de exemplo que acompanha o sistema de gerenciamento de banco de dados Firebird multiplataforma.
        Você pode usar este banco de dados para explorar o Firebird SQL e outros recursos do DBMS.
    </p>
    <h3>Abaixo está uma lista das tabelas deste banco de dados:</h3>

    <div class="accordion">
        <span><span class='sql'>COUNTRY</span> - tabela de países.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Nome do país.</li>
            <li><span class='sql'>CURRENCY</span>Moeda usada no país.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>COUNTRY</th>
                    <th>CURRENCY</th>
                </tr>
                <tr>
                    <td>USA</td>
                    <td>Dollar</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>JOB</span> - horário de trabalho da empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>Código do trabalho.</li>
            <li><span class='sql'>JOB_GRADE</span>Grau do trabalho.</li>
            <li><span class='sql'>JOB_COUNTRY</span>País associado ao trabalho.</li>
            <li><span class='sql'>JOB_TITLE</span>Título do trabalho.</li>
            <li><span class='sql'>MIN_SALARY</span>Salário mínimo para o trabalho.</li>
            <li><span class='sql'>MAX_SALARY</span>Salário máximo para o trabalho.</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>Requisitos do trabalho.</li>
            <li><span class='sql'>LANGUAGE_REQ</span>Requisitos de idioma.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>JOB_CODE</th>
                    <th>JOB_GRADE</th>
                    <th>JOB_COUNTRY</th>
                    <th>JOB_TITLE</th>
                    <th>MIN_SALARY</th>
                    <th>MAX_SALARY</th>
                    <th>JOB_REQUIREMENT</th>
                    <th>LANGUAGE_REQ</th>
                </tr>
                <tr>
                    <td>CEO</td>
                    <td>1</td>
                    <td>USA</td>
                    <td>Chief Executive Officer</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>No specific requirements.</td>
                    <td>[null]</td>
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
        <span><span class='sql'>DEPARTMENT</span> - divisões da empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Número do departamento.</li>
            <li><span class='sql'>DEPARTMENT</span>Nome do departamento.</li>
            <li><span class='sql'>HEAD_DEPT</span>Departamento principal (pode ser nulo).</li>
            <li><span class='sql'>MNGR_NO</span>Número do gerente.</li>
            <li><span class='sql'>BUDGET</span>Orçamento do departamento.</li>
            <li><span class='sql'>LOCATION</span>Localização do departamento.</li>
            <li><span class='sql'>PHONE_NO</span>Número de telefone do departamento.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>DEPT_NO</th>
                    <th>DEPARTMENT</th>
                    <th>HEAD_DEPT</th>
                    <th>MNGR_NO</th>
                    <th>BUDGET</th>
                    <th>LOCATION</th>
                    <th>PHONE_NO</th>
                </tr>
                <tr>
                    <td>000</td>
                    <td>Corporate Office</td>
                    <td>[null]</td>
                    <td>105</td>
                    <td>1000000.00</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>EMPLOYEE</span> - lista de funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número do funcionário.</li>
            <li><span class='sql'>FIRST_NAME</span>Primeiro nome do funcionário.</li>
            <li><span class='sql'>LAST_NAME</span>Sobrenome do funcionário.</li>
            <li><span class='sql'>PHONE_EXT</span>Ramal do telefone do funcionário.</li>
            <li><span class='sql'>HIRE_DATE</span>Data de contratação do funcionário.</li>
            <li><span class='sql'>DEPT_NO</span>Número do departamento.</li>
            <li><span class='sql'>JOB_CODE</span>Código do trabalho do funcionário.</li>
            <li><span class='sql'>JOB_GRADE</span>Grau do trabalho do funcionário.</li>
            <li><span class='sql'>JOB_COUNTRY</span>País associado ao trabalho do funcionário.</li>
            <li><span class='sql'>SALARY</span>Salário do funcionário.</li>
            <li><span class='sql'>FULL_NAME</span>Nome completo do funcionário.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>FIRST_NAME</th>
                    <th>LAST_NAME</th>
                    <th>PHONE_EXT</th>
                    <th>HIRE_DATE</th>
                    <th>DEPT_NO</th>
                    <th>JOB_CODE</th>
                    <th>JOB_GRADE</th>
                    <th>JOB_COUNTRY</th>
                    <th>SALARY</th>
                    <th>FULL_NAME</th>
                </tr>
                <tr>
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
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
        <span><span class='sql'>PROJECT</span> - lista de projetos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>ID do projeto.</li>
            <li><span class='sql'>PROJ_NAME</span>Nome do projeto.</li>
            <li><span class='sql'>PROJ_DESC</span>Descrição do projeto.</li>
            <li><span class='sql'>TEAM_LEADER</span>Líder da equipe do projeto.</li>
            <li><span class='sql'>PRODUCT</span>Produto associado ao projeto.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>PROJ_ID</th>
                    <th>PROJ_NAME</th>
                    <th>PROJ_DESC</th>
                    <th>TEAM_LEADER</th>
                    <th>PRODUCT</th>
                </tr>
                <tr>
                    <td>VBASE</td>
                    <td>Video Database</td>
                    <td>Development of a video database management system for managing video distribution on demand.</td>
                    <td>45</td>
                    <td>software</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - distribuição de funcionários em projetos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número do funcionário.</li>
            <li><span class='sql'>PROJ_ID</span>ID do projeto.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>PROJ_ID</th>
                </tr>
                <tr>
                    <td>144</td>
                    <td>DGPII</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - orçamentos de projetos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>FISCAL_YEAR</span>Ano fiscal.</li>
            <li><span class='sql'>PROJ_ID</span>ID do projeto.</li>
            <li><span class='sql'>DEPT_NO</span>Número do departamento.</li>
            <li><span class='sql'>QUART_HEAD_CNT</span>Contagem de cabeças do trimestre (pode ser nulo).</li>
            <li><span class='sql'>PROJECTED_BUDGET</span>Orçamento projetado para o ano fiscal.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>FISCAL_YEAR</th>
                    <th>PROJ_ID</th>
                    <th>DEPT_NO</th>
                    <th>QUART_HEAD_CNT</th>
                    <th>PROJECTED_BUDGET</th>
                </tr>
                <tr>
                    <td>1994</td>
                    <td>GUIDE</td>
                    <td>100</td>
                    <td>[null]</td>
                    <td>200000.00</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>SALARY_HISTORY</span> - histórico de mudanças salariais dos funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número do funcionário.</li>
            <li><span class='sql'>CHANGE_DATE</span>Data da mudança salarial.</li>
            <li><span class='sql'>UPDATER_ID</span>ID do atualizador.</li>
            <li><span class='sql'>OLD_SALARY</span>Salário anterior.</li>
            <li><span class='sql'>PERCENT_CHANGE</span>Percentual de mudança no salário.</li>
            <li><span class='sql'>NEW_SALARY</span>Novo salário após a mudança.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>EMP_NO</th>
                    <th>CHANGE_DATE</th>
                    <th>UPDATER_ID</th>
                    <th>OLD_SALARY</th>
                    <th>PERCENT_CHANGE</th>
                    <th>NEW_SALARY</th>
                </tr>
                <tr>
                    <td>28</td>
                    <td>1992-12-15 00:00:00</td>
                    <td>admin2</td>
                    <td>20000.00</td>
                    <td>10.000000</td>
                    <td>22000.000000</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="accordion">
        <span><span class='sql'>CUSTOMER</span> - clientes da empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>CUST_NO</span>Número do cliente.</li>
            <li><span class='sql'>CUSTOMER</span>Nome do cliente.</li>
            <li><span class='sql'>CONTACT_FIRST</span>Primeiro nome da pessoa de contato.</li>
            <li><span class='sql'>CONTACT_LAST</span>Sobrenome da pessoa de contato.</li>
            <li><span class='sql'>PHONE_NO</span>Número de telefone do cliente.</li>
            <li><span class='sql'>ADDRESS_LINE1</span>Linha de endereço 1.</li>
            <li><span class='sql'>ADDRESS_LINE2</span>Linha de endereço 2 (pode ser nulo).</li>
            <li><span class='sql'>CITY</span>Cidade do cliente.</li>
            <li><span class='sql'>STATE_PROVINCE</span>Estado ou província do cliente.</li>
            <li><span class='sql'>COUNTRY</span>País do cliente.</li>
            <li><span class='sql'>POSTAL_CODE</span>Código postal do cliente.</li>
            <li><span class='sql'>ON_HOLD</span>Status de espera (pode ser nulo).</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>CUST_NO</th>
                    <th>CUSTOMER</th>
                    <th>CONTACT_FIRST</th>
                    <th>CONTACT_LAST</th>
                    <th>PHONE_NO</th>
                    <th>ADDRESS_LINE1</th>
                    <th>ADDRESS_LINE2</th>
                    <th>CITY</th>
                    <th>STATE_PROVINCE</th>
                    <th>COUNTRY</th>
                    <th>POSTAL_CODE</th>
                    <th>ON_HOLD</th>
                </tr>
                <tr>
                    <td>1001</td>
                    <td>Signature Design</td>
                    <td>Dale J.</td>
                    <td>Little</td>
                    <td>(619) 530-2710</td>
                    <td>15500 Pacific Heights Blvd.</td>
                    <td>[null]</td>
                    <td>San Diego</td>
                    <td>CA</td>
                    <td>USA</td>
                    <td>92121</td>
                    <td>[null]</td>
                </tr>
            </table>
        </div>    
    </div>
    <div class="accordion">
        <span><span class='sql'>SALES</span> - lista de vendas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PO_NUMBER</span>Número do pedido de compra.</li>
            <li><span class='sql'>CUST_NO</span>Número do cliente associado ao pedido.</li>
            <li><span class='sql'>SALES_REP</span>Número do representante de vendas.</li>
            <li><span class='sql'>ORDER_STATUS</span>Status do pedido.</li>
            <li><span class='sql'>ORDER_DATE</span>Data do pedido.</li>
            <li><span class='sql'>SHIP_DATE</span>Data de envio.</li>
            <li><span class='sql'>DATE_NEEDED</span>Data necessária (pode ser nulo).</li>
            <li><span class='sql'>PAID</span>Status de pagamento.</li>
            <li><span class='sql'>QTY_ORDERED</span>Quantidade pedida.</li>
            <li><span class='sql'>TOTAL_VALUE</span>Valor total do pedido.</li>
            <li><span class='sql'>DISCOUNT</span>Desconto aplicado.</li>
            <li><span class='sql'>ITEM_TYPE</span>Tipo de item no pedido.</li>
            <li><span class='sql'>AGED</span>Valor envelhecido.</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>PO_NUMBER</th>
                    <th>CUST_NO</th>
                    <th>SALES_REP</th>
                    <th>ORDER_STATUS</th>
                    <th>ORDER_DATE</th>
                    <th>SHIP_DATE</th>
                    <th>DATE_NEEDED</th>
                    <th>PAID</th>
                    <th>QTY_ORDERED</th>
                    <th>TOTAL_VALUE</th>
                    <th>DISCOUNT</th>
                    <th>ITEM_TYPE</th>
                    <th>AGED</th>
                </tr>
                <tr>
                    <td>V91E0210</td>
                    <td>1004</td>
                    <td>11</td>
                    <td>shipped</td>
                    <td>1991-03-04 00:00:00</td>
                    <td>1991-03-05 00:00:00</td>
                    <td>[null]</td>
                    <td>y</td>
                    <td>10</td>
                    <td>5000.00</td>
                    <td>0.100000</td>
                    <td>hardware</td>
                    <td>1.000000000</td>
                </tr>
            </table>
        </div>
    </div>                            
    {if $User->showAd()}
        {assign var=add_id value=0|mt_rand:4}
        <div class="referal-add-block">
            {if $add_id > 2}
                {* <a href="https://book24.ru/r/RaSLq?erid=LjN8KWDe6" target="_blank" style="text-decoration: none; display: flex; ">
                    <div  style = "width: 30%;">
                        <img style="width: 100%;" src="//ndc.book24.ru/resize/410x590/pim/products/images/fa/ba/018ee5fc-fe2e-7df9-b671-01280c60faba.jpg" alt="PostgreSQL Основы языка SQL : учебное пособие">
                    </div>
                    <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                        <div>Танимура Кэти: SQL для анализа данных.</div>
                        <div style="font-size: small; padding-top: 0.5em;">
                            В книге рассказывается о возможностях SQL применительно к анализу данных, сравниваются различные типы баз данных, описаны методы подготовки данных для анализа. 
                            Рассказано о типах данных, структуре SQL-запросов, профилировнии, структурировании и очистке данных. Описаны методы анализа временных рядов, трендов, приведены примеры анализа данных с учетом сезонности. 
                            Отдельные главы посвящены когортному анализу, текстовому анализу, выявлению и обработке аномалий, анализу результатов экспериментов и А/В-тестирования. Описано создание сложных наборов данных, комбинирование методов анализа. 
                            Приведены практические примеры анализа воронки продаж и потребительской корзины.
                        </div>
                    </div>
                </a> *}
                <a target="_blank" rel="nofollow" href="https://ujhjj.com/g/2fm4vusamufec845fb2f0da0172cef/?i=4&subid=sql&erid=LatgBVMfa">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/2fm4vusamufec845fb2f0da0172cef/" alt="Skillfactory.ru"/>
                </a>
                <a target="_blank" rel="nofollow" href="https://dhwnh.com/g/8gb84134qdfec845fb2faf541d880b/?i=4&subid=new-year&erid=LatgBjjaY">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/8gb84134qdfec845fb2faf541d880b/" alt="Hexlet.io"/>
                </a>
            {else}
                <a target="_blank" rel="nofollow" href="https://dhwnh.com/g/sggtutr216fec845fb2faf541d880b/?i=4&subid=analytic-prof&erid=LatgBqBgQ">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/sggtutr216fec845fb2faf541d880b/" alt="Hexlet.io"/>
                </a>
                {* <a target="_blank" rel="nofollow" href="https://bywiola.com/g/fiu7it8s2hfec845fb2f3b8a152381/?i=4&subid=data-enginere&erid=LatgBaH44">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/fiu7it8s2hfec845fb2f3b8a152381/" alt="Karpov.courses"/>
                </a> *}
                <a target="_blank" rel="nofollow" href="https://bywiola.com/g/vvs19xth4pfec845fb2f3b8a152381/?i=4&subid=analyst-ny&erid=2VSb5xzvfBn">
                    <img style="width:100%;" border="0" src="https://aflink.ru/b/vvs19xth4pfec845fb2f3b8a152381/" alt="Karpov.courses"/>
                </a>
            {/if}
        </div>
    {/if}
</div>