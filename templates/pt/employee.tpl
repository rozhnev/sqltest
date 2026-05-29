<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
        }
    </style>
    <h2>Banco de Dados Employee: estrutura das tabelas e visão geral</h2>
    <p>O banco Employee (Firebird) é um conjunto de dados de exemplo usado para estudar SQL e explorar recursos do SGBD Firebird.</p>
    <p>Esta página descreve a estrutura das tabelas, colunas-chave e relacionamentos úteis em consultas SQL práticas.</p>
    <p>O Banco de Dados Employee contém 9 tabelas principais.</p>
    <p>
        <a href="/{$Lang}/erd/Employee" target="ERDWindow" rel="noopener noreferrer" style="display: flex; flex-direction: column; align-items: center; gap: 4px;" aria-label="Abrir o diagrama ER do banco Employee em uma nova janela">
            <img src="/images/erd_small_light.svg" alt="Diagrama ER do banco Employee mostrando relacionamentos entre tabelas" style="width: 90%;" loading="lazy" decoding="async">
            Diagrama ER do banco Employee
        </a>
    </p>
    <h3>Lista de tabelas</h3>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>COUNTRY</span> - tabela de países.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>COUNTRY</span>Nome do país</li>
            <li><span class='sql'>CURRENCY</span>Moeda usada no país</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">CURRENCY</th>
                </tr></thead><tbody><tr>
                    <td>USA</td>
                    <td>Dollar</td>
                </tr></tbody></table>
        </div>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>JOB</span> - horário de trabalho da empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>JOB_CODE</span>Código do trabalho</li>
            <li><span class='sql'>JOB_GRADE</span>Grau do trabalho</li>
            <li><span class='sql'>JOB_COUNTRY</span>País associado ao trabalho</li>
            <li><span class='sql'>JOB_TITLE</span>Título do trabalho</li>
            <li><span class='sql'>MIN_SALARY</span>Salário mínimo para o trabalho</li>
            <li><span class='sql'>MAX_SALARY</span>Salário máximo para o trabalho</li>
            <li><span class='sql'>JOB_REQUIREMENT</span>Requisitos do trabalho</li>
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
                    <td>Chief Executive Officer</td>
                    <td>130000.00</td>
                    <td>250000.00</td>
                    <td>No specific requirements.</td>
                    <td>[null]</td>
                </tr></tbody></table>
        </div>    
        <ul class="table-columns">
            <li>FOREIGN KEY (JOB_COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>DEPARTMENT</span> - divisões da empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>DEPT_NO</span>Número do departamento</li>
            <li><span class='sql'>DEPARTMENT</span>Nome do departamento</li>
            <li><span class='sql'>HEAD_DEPT</span>Departamento principal (pode ser nulo)</li>
            <li><span class='sql'>MNGR_NO</span>Número do gerente</li>
            <li><span class='sql'>BUDGET</span>Orçamento do departamento</li>
            <li><span class='sql'>LOCATION</span>Localização do departamento</li>
            <li><span class='sql'>PHONE_NO</span>Número de telefone do departamento</li>
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
                    <td>Corporate Office</td>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>EMPLOYEE</span> - lista de funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número do funcionário</li>
            <li><span class='sql'>FIRST_NAME</span>Primeiro nome do funcionário</li>
            <li><span class='sql'>LAST_NAME</span>Sobrenome do funcionário</li>
            <li><span class='sql'>PHONE_EXT</span>Ramal do telefone do funcionário</li>
            <li><span class='sql'>HIRE_DATE</span>Data de contratação do funcionário</li>
            <li><span class='sql'>DEPT_NO</span>Número do departamento</li>
            <li><span class='sql'>JOB_CODE</span>Código do trabalho do funcionário</li>
            <li><span class='sql'>JOB_GRADE</span>Grau do trabalho do funcionário</li>
            <li><span class='sql'>JOB_COUNTRY</span>País associado ao trabalho do funcionário</li>
            <li><span class='sql'>SALARY</span>Salário do funcionário</li>
            <li><span class='sql'>FULL_NAME</span>Nome completo do funcionário</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>PROJECT</span> - lista de projetos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PROJ_ID</span>ID do projeto</li>
            <li><span class='sql'>PROJ_NAME</span>Nome do projeto</li>
            <li><span class='sql'>PROJ_DESC</span>Descrição do projeto</li>
            <li><span class='sql'>TEAM_LEADER</span>Líder da equipe do projeto</li>
            <li><span class='sql'>PRODUCT</span>Produto associado ao projeto</li>
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
                    <td>Video Database</td>
                    <td>Development of a video database management system for managing video distribution on demand.</td>
                    <td>45</td>
                    <td>software</td>
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (TEAM_LEADER) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>EMPLOYEE_PROJECT</span> - funcionários em projetos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número do funcionário</li>
            <li><span class='sql'>PROJ_ID</span>ID do projeto</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>PROJ_DEPT_BUDGET</span> - orçamentos de projetos.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql' style="min-width: 11rem;">FISCAL_YEAR</span>Ano fiscal</li>
            <li><span class='sql' style="min-width: 11rem;">PROJ_ID</span>ID do projeto</li>
            <li><span class='sql' style="min-width: 11rem;">DEPT_NO</span>Número do departamento</li>
            <li><span class='sql' style="min-width: 11rem;">QUART_HEAD_CNT</span>Contagem de cabeças do trimestre (pode ser nulo)</li>
            <li><span class='sql' style="min-width: 11rem;">PROJECTED_BUDGET</span>Orçamento projetado para o ano fiscal</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>SALARY_HISTORY</span> - histórico salarial dos funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql' style="min-width: 11rem;">EMP_NO</span>Número do funcionário</li>
            <li><span class='sql' style="min-width: 11rem;">CHANGE_DATE</span>Data da mudança salarial</li>
            <li><span class='sql' style="min-width: 11rem;">UPDATER_ID</span>ID do atualizador</li>
            <li><span class='sql' style="min-width: 11rem;">OLD_SALARY</span>Salário anterior</li>
            <li><span class='sql' style="min-width: 11rem;">PERCENT_CHANGE</span>Percentual de mudança no salário</li>
            <li><span class='sql' style="min-width: 11rem;">NEW_SALARY</span>Novo salário após a mudança</li>
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
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>CUSTOMER</span> - clientes da empresa.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql' style="min-width: 11rem;">CUST_NO</span>Número do cliente</li>
            <li><span class='sql' style="min-width: 11rem;">CUSTOMER</span>Nome do cliente</li>
            <li><span class='sql' style="min-width: 11rem;">CONTACT_FIRST</span>Primeiro nome da pessoa de contato</li>
            <li><span class='sql' style="min-width: 11rem;">CONTACT_LAST</span>Sobrenome da pessoa de contato</li>
            <li><span class='sql' style="min-width: 11rem;">PHONE_NO</span>Número de telefone do cliente</li>
            <li><span class='sql' style="min-width: 11rem;">ADDRESS_LINE1</span>Linha de endereço 1</li>
            <li><span class='sql' style="min-width: 11rem;">ADDRESS_LINE2</span>Linha de endereço 2 (pode ser nulo)</li>
            <li><span class='sql' style="min-width: 11rem;">CITY</span>Cidade do cliente</li>
            <li><span class='sql' style="min-width: 11rem;">STATE_PROVINCE</span>Estado ou província do cliente</li>
            <li><span class='sql' style="min-width: 11rem;">COUNTRY</span>País do cliente</li>
            <li><span class='sql' style="min-width: 11rem;">POSTAL_CODE</span>Código postal do cliente</li>
            <li><span class='sql' style="min-width: 11rem;">ON_HOLD</span>Status de espera (pode ser nulo)</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">CUSTOMER</th>
                    <th scope="col">CONTACT_FIRST</th>
                    <th scope="col">CONTACT_LAST</th>
                    <th scope="col">PHONE_NO</th>
                    <th scope="col">ADDRESS_LINE1</th>
                    <th scope="col">ADDRESS_LINE2</th>
                    <th scope="col">CITY</th>
                    <th scope="col">STATE_PROVINCE</th>
                    <th scope="col">COUNTRY</th>
                    <th scope="col">POSTAL_CODE</th>
                    <th scope="col">ON_HOLD</th>
                </tr></thead><tbody><tr>
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
                </tr></tbody></table>
        </div>    
        <ul class="table-columns">
            <li>FOREIGN KEY (COUNTRY) REFERENCES COUNTRY(COUNTRY)</li>
        </ul>
    </div>
    <div class="accordion" title="Clique para expandir, duplo clique para colar nome da tabela">
        <span><span class='sql'>SALES</span> - lista de vendas.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>PO_NUMBER</span>Número do pedido de compra</li>
            <li><span class='sql'>CUST_NO</span>Número do cliente associado ao pedido</li>
            <li><span class='sql'>SALES_REP</span>Número do representante de vendas</li>
            <li><span class='sql'>ORDER_STATUS</span>Status do pedido</li>
            <li><span class='sql'>ORDER_DATE</span>Data do pedido</li>
            <li><span class='sql'>SHIP_DATE</span>Data de envio</li>
            <li><span class='sql'>DATE_NEEDED</span>Data necessária (pode ser nulo)</li>
            <li><span class='sql'>PAID</span>Status de pagamento</li>
            <li><span class='sql'>QTY_ORDERED</span>Quantidade pedida</li>
            <li><span class='sql'>TOTAL_VALUE</span>Valor total do pedido</li>
            <li><span class='sql'>DISCOUNT</span>Desconto aplicado</li>
            <li><span class='sql'>ITEM_TYPE</span>Tipo de item no pedido</li>
            <li><span class='sql'>AGED</span>Valor envelhecido</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">PO_NUMBER</th>
                    <th scope="col">CUST_NO</th>
                    <th scope="col">SALES_REP</th>
                    <th scope="col">ORDER_STATUS</th>
                    <th scope="col">ORDER_DATE</th>
                    <th scope="col">SHIP_DATE</th>
                    <th scope="col">DATE_NEEDED</th>
                    <th scope="col">PAID</th>
                    <th scope="col">QTY_ORDERED</th>
                    <th scope="col">TOTAL_VALUE</th>
                    <th scope="col">DISCOUNT</th>
                    <th scope="col">ITEM_TYPE</th>
                    <th scope="col">AGED</th>
                </tr></thead><tbody><tr>
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
                </tr></tbody></table>
        </div>
        <ul class="table-columns">
            <li>FOREIGN KEY (CUST_NO) REFERENCES CUSTOMER(CUST_NO)</li>
            <li>FOREIGN KEY (SALES_REP) REFERENCES EMPLOYEE(EMP_NO)</li>
        </ul>
    </div>
    <h3>Abaixo está a lista de views deste banco de dados:</h3>
    <div class="accordion" title="Clique para expandir, dê um clique duplo para colar o nome da view no editor">
        <span><span class='sql'>PHONE_LIST</span> - view com a lista de telefones dos funcionários.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>EMP_NO</span>Número do funcionário</li>
            <li><span class='sql'>FIRST_NAME</span>Primeiro nome do funcionário</li>
            <li><span class='sql'>LAST_NAME</span>Sobrenome do funcionário</li>
            <li><span class='sql'>PHONE_EXT</span>Ramal do telefone do funcionário</li>
            <li><span class='sql'>LOCATION</span>Localização do departamento</li>
            <li><span class='sql'>PHONE_NO</span>Número de telefone do departamento</li>
        </ul>
        <div class="table-wrapper">
            <table><thead><tr>
                    <th scope="col">EMP_NO</th>
                    <th scope="col">FIRST_NAME</th>
                    <th scope="col">LAST_NAME</th>
                    <th scope="col">PHONE_EXT</th>
                    <th scope="col">LOCATION</th>
                    <th scope="col">PHONE_NO</th>
                </tr></thead><tbody><tr>
                    <td>2</td>
                    <td>Robert</td>
                    <td>Nelson</td>
                    <td>250</td>
                    <td>Monterey</td>
                    <td>(408) 555-1234</td>
                </tr></tbody></table>
        </div>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            {if $Book}
                <div class="book-card">
                    <a href="{{$Book.referral_link}}" target="_blank" style="text-decoration: none; color: var(--question-color);">
                        <div style="display: flex; flex-direction: row;     border: 1px solid var(--text-block-border-color);
color: var(--question-text);
border-radius: 6px; padding: 0.3em; width: 98%;">
                        <div  style = "width: 25%;">
                            <img style="width: 100%;" src="{{$Book.picture_link}}" alt="{{$Book.title|escape:"html"}}">
                        </div>
                        <div style="font-size: 1em;  width: 75%;  padding: 0 0.7em; font-weight: 100; height: 250px; overflow: auto;">
                            <div>{{$Book.title|escape:"html"}}</div>
                            <div style="font-size: small; padding-top: 0.5em;">{{$Book.description|escape:"html"}}</div>
                        </div>
                        </div>
                    </a>
                </div>
            {else}
                <a href="https://www.kqzyfj.com/86104kjspjr6878CE9F9G68E9B9898" target="_blank">
                    <img src="https://www.awltovhc.com/60106z15u-yJLKLPRMSMTJLRMOMLML" alt="" style="border: 0; width: 100%;"/>
                </a>
            {/if}
        </div>
    {/if}
</div>