<div id="db-description" class="db-description">
    <style>
        .table-columns span {
            min-width: 8rem;
            display: inline-block;
        }
    </style>
    <h2>Banco de Dados Sakila</h2>
    Sakila é um banco de dados de exemplo projetado pelo MySQL, criado especificamente para aprendizado e demonstração das capacidades dos sistemas de gerenciamento de banco de dados relacionais (RDBMS).
    <p>
        <a class="button-erd" href="/{$Lang}/erd/Sakila" target="ERDWindow">
            Diagrama ER do banco de dados Sakila
        </a>
    </p>
    <p>O banco de dados Sakila contém 15 tabelas principais descrevendo vários aspectos de uma empresa de locação de DVDs.</p>
    <h3>Lista de Tabelas:</h3>
    <div class="accordion">
        <span><span class='sql'>actor</span> - tabela de atores.</span>
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>first_name</span>primeiro nome do ator</li>
            <li> <span class='sql'>last_name</span>sobrenome do ator</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>actor_id</th>
                <th>first_name</th>
                <th>last_name</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (actor_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>address</span> - endereços de clientes e funcionários.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>address_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>address</span>endereço postal</li>
            <li> <span class='sql'>address2</span>endereço adicional</li>
            <li> <span class='sql'>district</span>distrito ou região</li>
            <li> <span class='sql'>city_id</span>identificador da cidade (FK)</li>
            <li> <span class='sql'>postal_code</span>código postal</li>
            <li> <span class='sql'>phone</span>número de telefone</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>address_id</th>
                <th>address</th>
                <th>address2</th>
                <th>district</th>
                <th>city_id</th>
                <th>postal_code</th>
                <th>phone</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>123 Main St</td>
                <td>[null]</td>
                <td>Downtown</td>
                <td>1</td>
                <td>12345</td>
                <td>+1234567890</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (address_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>category</span> - categorias de filmes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>category_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>name</span>nome da categoria</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>category_id</th>
                <th>name</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>Action</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (category_id)</li>
        </ul>    
    </div>
    <div class="accordion">
        <span class='sql'>city</span> - tabela de cidades.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>city_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>city</span>nome da cidade</li>
            <li> <span class='sql'>country_id</span>identificador do país (FK)</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>city_id</th>
                <th>city</th>
                <th>country_id</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>Metropolis</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (city_id)</li>
        </ul>
    </div>    
    <div class="accordion">
        <span class='sql'>country</span> - tabela de países.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>country_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>country</span>nome do país</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>country_id</th>
                <th>country</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>United States</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (country_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>customer</span> - tabela de clientes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>customer_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>store_id</span>identificador da loja (FK)</li>
            <li> <span class='sql'>first_name</span>primeiro nome do cliente</li>
            <li> <span class='sql'>last_name</span>sobrenome do cliente</li>
            <li> <span class='sql'>email</span>endereço de e-mail do cliente</li>
            <li> <span class='sql'>address_id</span>identificador do endereço (FK)</li>
            <li> <span class='sql'>active</span>indicador de atividade do cliente (0/1)</li>
            <li> <span class='sql'>create_date</span>data e hora em que o cliente foi adicionado ao banco de dados</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>customer_id</th>
                <th>store_id</th>
                <th>first_name</th>
                <th>last_name</th>
                <th>email</th>
                <th>address_id</th>
                <th>active</th>
                <th>create_date</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>john.doe@example.com</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
          </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (customer_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>film</span> - lista de filmes no banco de dados.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 13rem;">film_id</span>id único do registro (PK)</li>
            <li> <span class='sql' style="min-width: 13rem;">title</span>título do filme</li>
            <li> <span class='sql' style="min-width: 13rem;">description</span>breve descrição ou enredo do filme</li>
            <li> <span class='sql' style="min-width: 13rem;">release_year</span>ano em que o filme foi lançado</li>
            <li> <span class='sql' style="min-width: 13rem;">language_id</span>identificador do idioma do filme (FK)</li>
            <li> <span class='sql' style="min-width: 13rem;">original_language_id</span>id do idioma original do filme, caso seja dublado em um novo idioma</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_duration</span>duração do período de aluguel em dias</li>
            <li> <span class='sql' style="min-width: 13rem;">rental_rate</span>custo do aluguel do filme pelo período especificado na coluna duracao_aluguel</li>
            <li> <span class='sql' style="min-width: 13rem;">length</span>duração do filme em minutos</li>
            <li> <span class='sql' style="min-width: 13rem;">replacement_cost</span>valor da penalidade por perda ou dano do disco</li>
            <li> <span class='sql' style="min-width: 13rem;">rating</span>classificação atribuída ao filme. Pode ser um dos seguintes: G, PG, PG-13, R ou NC-17</li>
            <li> <span class='sql' style="min-width: 13rem;">special_features</span>lista de recursos especiais incluídos no DVD. Pode ser nenhum ou mais dos seguintes: Trailers, Comentários, Cenas Excluídas, Por Trás das Cenas</li>
            <li> <span class='sql' style="min-width: 13rem;">last_update</span>data e hora da última atualização</li>
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                <th>film_id</th>
                <th>title</th>
                <th>description</th>
                <th>release_year</th>
                <th>language_id</th>
                <th>original_language_id</th>
                <th>rental_duration</th>
                <th>rental_rate</th>
                <th>length</th>
                <th>replacement_cost</th>
                <th>rating</th>
                <th>special_features</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>Film Title</td>
                <td>A brief description of the film.</td>
                <td>2000</td>
                <td>1</td>
                <td>2</td>
                <td>5</td>
                <td>4.99</td>
                <td>120</td>
                <td>19.99</td>
                <td>PG-13</td>
                <td>Trailers, Commentaries</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (film_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>film_actor</span> - relação entre atores e filmes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>actor_id</span>identificador do ator (FK)</li>
            <li> <span class='sql'>film_id</span>identificador do filme (FK)</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>actor_id</th>
                    <th>film_id</th>
                    <th>last_update</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>1</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (actor_id, film_id)</li>
        </ul>      
    </div>
    <div class="accordion">
        <span class='sql'>film_category</span> - relação entre filmes e categorias.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>film_id</span>identificador de cada filme (FK)</li>
            <li> <span class='sql'>category_id</span>identificador de cada categoria (FK)</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
          </ul>
          <div class="table-wrapper">
            <table>
              <tr>
                <th>film_id</th>
                <th>category_id</th>
                <th>last_update</th>
              </tr>
              <tr>
                <td>1</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
          </div>
          <ul class="table-columns">
              <li>PRIMARY KEY, btree (film_id, category_id)</li>
          </ul>    
    </div>
    <div class="accordion">
        <span class='sql'>inventory</span> - itens no banco de dados.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li><span class='sql'>inventory_id</span>identificador único do registro (PK)</li>
            <li><span class='sql'>film_id</span>identificador do filme (FK)</li>
            <li><span class='sql'>store_id</span>id da loja onde o inventário está localizado (FK)</li>
            <li><span class='sql'>last_update</span>data e hora da última atualização</li>
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>inventory_id</th>
                    <th>film_id</th>
                    <th>store_id</th>
                    <th>last_update</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>23</td>
                    <td>2</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (inventory_id)</li>
        </ul>        
    </div>
    <div class="accordion">
        <span class='sql'>language</span> - idiomas dos filmes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>language_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>nome</span>nome do idioma</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>language_id</th>
                    <th>name</th>
                    <th>last_update</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>English</td>
                    <td>2023-01-01 12:00:00</td>
                </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (language_id)</li>
        </ul>
    </div>
    <div class="accordion">
        <span class='sql'>payment</span> - pagamentos dos clientes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 8rem;">payment_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql' style="min-width: 8rem;">customer_id</span>identificador do cliente (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">staff_id</span>id do funcionário que recebeu o pagamento (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">rental_id</span>identificador do registro de aluguel (FK)</li>
            <li> <span class='sql' style="min-width: 8rem;">amount</span>valor do pagamento</li>
            <li> <span class='sql' style="min-width: 8rem;">payment_date</span>data e hora do pagamento</li>
            <li> <span class='sql' style="min-width: 8rem;">last_update</span>data e hora da última atualização</li>
        </ul>
        <div class="table-wrapper">
        <table>
            <tr>
                <th>payment_id</th>
                <th>customer_id</th>
                <th>staff_id</th>
                <th>rental_id</th>
                <th>amount</th>
                <th>payment_date</th>
                <th>last_update</th>
            </tr>
            <tr>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>1</td>
                <td>4.99</td>
                <td>2023-01-01 12:13:14</td>
                <td>2023-01-01 12:14:15</td>
            </tr>
        </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (payment_id)</li>
        </ul>      
    </div>
    <div class="accordion">
        <span class='sql'>rental</span> - aluguéis dos clientes.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>rental_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>rental_date</span>data de início do aluguel</li>
            <li> <span class='sql'>inventory_id</span>identificador do disco (FK)</li>
            <li> <span class='sql'>customer_id</span>identificador do cliente (FK)</li>
            <li> <span class='sql'>return_date</span>data de devolução do filme</li>
            <li> <span class='sql'>staff_id</span>id do funcionário que emitiu o disco (FK)</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
        <table>
            <tr>
                <th>rental_id</th>
                <th>rental_date</th>
                <th>inventory_id</th>
                <th>customer_id</th>
                <th>return_date</th>
                <th>staff_id</th>
                <th>last_update</th>
            </tr>
            <tr>
                <td>1</td>
                <td>2023-01-01 16:15:21</td>
                <td>1</td>
                <td>1</td>
                <td>2023-01-10 09:12:36</td>
                <td>1</td>
                <td>2023-01-01 12:00:00</td>
            </tr>
        </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (rental_id)</li>
        </ul>    
    </div>
    <div class="accordion">
        <span class='sql'>staff</span> - equipe da empresa.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql'>staff_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql'>first_name</span>primeiro nome do membro da equipe</li>
            <li> <span class='sql'>last_name</span>sobrenome do membro da equipe</li>
            <li> <span class='sql'>address_id</span>identificador do endereço (FK)</li>
            <li> <span class='sql'>picture</span>fotografia do membro da equipe</li>
            <li> <span class='sql'>email</span>endereço de e-mail do membro da equipe</li>
            <li> <span class='sql'>store_id</span>chave estrangeira referenciando a tabela de lojas (FK)</li>
            <li> <span class='sql'>active</span>indicador de atividade do membro da equipe (0/1)</li>
            <li> <span class='sql'>username</span>nome de usuário para login no sistema</li>
            <li> <span class='sql'>password</span>senha para login</li>
            <li> <span class='sql'>last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
        <table>
            <tr>
                <th>staff_id</th>
                <th>first_name</th>
                <th>last_name</th>
                <th>address_id</th>
                <th>picture</th>
                <th>email</th>
                <th>store_id</th>
                <th>active</th>
                <th>username</th>
                <th>password</th>
                <th>last_update</th>
            </tr>
            <tr>
                <td>1</td>
                <td>John</td>
                <td>Doe</td>
                <td>1</td>
                <td>[null]</td>
                <td>john.doe@example.com</td>
                <td>1</td>
                <td>1</td>
                <td>johndoe</td>
                <td>********</td>
                <td>2023-01-01 12:00:00</td>
            </tr>
        </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (staff_id)</li>
        </ul>        
    </div>
    <div class="accordion">
        <span class='sql'>store</span> - histórias da empresa.
    </div>
    <div class="panel">
        <ul class="table-columns">
            <li> <span class='sql' style="min-width: 11rem;">store_id</span>identificador único do registro (PK)</li>
            <li> <span class='sql' style="min-width: 11rem;">manager_staff_id</span>identificador do gerente da loja (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">address_id</span>identificador do endereço (FK)</li>
            <li> <span class='sql' style="min-width: 11rem;">last_update</span>data e hora da última atualização</li> 
        </ul>
        <div class="table-wrapper">
            <table>
              <tr>
                  <th>store_id</th>
                  <th>manager_staff_id</th>
                  <th>address_id</th>
                  <th>last_update</th>
              </tr>
              <tr>
                  <td>1</td>
                  <td>1</td>
                  <td>1</td>
                  <td>2023-01-01 12:00:00</td>
              </tr>
            </table>
        </div>
        <ul class="table-columns">
            <li>PRIMARY KEY, btree (store_id)</li>
        </ul>
    </div>
    {if $User->showAd()}
        <div class="referal-add-block">
            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
        </div>
    {/if}
</div>