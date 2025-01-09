<div id="db-description" class="db-description">
  <h2>Banco de Dados Sakila (MySQL)</h2>
  Sakila é um banco de dados de exemplo desenvolvido pelo MySQL, especificamente projetado para ensinar e demonstrar as capacidades dos sistemas de gerenciamento de banco de dados (SGBD) baseados no modelo relacional.
  <p>
      <a class="button erd" href="/{$Lang}/erd/Sakila" target="ERDWindow">
          Diagrama ER do Banco de Dados Sakila
      </a>
  </p>
  O banco de dados Sakila contém 15 tabelas principais descrevendo vários aspectos de uma empresa de aluguel de DVDs.
  <p>Abaixo está uma lista dessas tabelas:</p>
  <ul style="list-style-type: '▤ '; padding-inline-start: 20px;">
    <li><span class='sql' onclick="scrollInfoPanel('actor_table_description')">actor</span> - tabela de atores.</li>
    <li><span class='sql' onclick="scrollInfoPanel('address_table_description')">address</span> - tabela de endereços de clientes e funcionários</li>
    <li><span class='sql' onclick="scrollInfoPanel('category_table_description')">category</span> - tabela de categorias de filmes.</li>
    <li><span class='sql' onclick="scrollInfoPanel('city_table_description')">city</span> - tabela de cidades.</li>
    <li><span class='sql' onclick="scrollInfoPanel('country_table_description')">country</span> - tabela de países.</li>
    <li><span class='sql' onclick="scrollInfoPanel('customer_table_description')">customer</span> - tabela de clientes no banco de dados Sakila.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_table_description')">film</span> - tabela de filmes no banco de dados Sakila.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_actor_table_description')">film_actor</span> - tabela de relação entre atores e filmes.</li>
    <li><span class='sql' onclick="scrollInfoPanel('film_category_table_description')">film_category</span> - tabela de relação entre filmes e categorias.</li>
    <li><span class='sql' onclick="scrollInfoPanel('inventory_table_description')">inventory</span> - tabela de itens no banco de dados Sakila.</li>
    <li><span class='sql' onclick="scrollInfoPanel('language_table_description')">language</span> - tabela de idiomas dos filmes.</li>
    <li><span class='sql' onclick="scrollInfoPanel('payment_table_description')">payment</span> - tabela de pagamentos dos clientes.</li>
    <li><span class='sql' onclick="scrollInfoPanel('rental_table_description')">rental</span> - tabela de aluguéis dos clientes.</li>
    <li><span class='sql' onclick="scrollInfoPanel('staff_table_description')">staff</span> - tabela de funcionários da empresa.</li>
    <li><span class='sql' onclick="scrollInfoPanel('store_table_description')">store</span> - tabela de lojas da empresa.</li>
  </ul>
  {if $User.show_ad}
      {if isset($Book)}
        <a href="{$Book.referral_link}" target="_blank" style="text-decoration: none;">
          <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">
            <div  style = "width: 30%;">
                <img style="width: 100%;" src="{$Book.picture_link}" alt="{$Book.title}">
            </div>
            <div style="font-size: 1em;  width: 70%;  padding: 0 0.7em; font-weight: 100;">
                <div>{$Book.title}</div>
                <div style="font-size: small; padding-top: 0.5em;">{$Book.description}</div>
            </div>
          </div>
        </a>
      {/if}
    {/if}
  <h3 id="actor_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>actor</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>actor_id</span> - Identificador único para cada ator.</li>
    <li> <span class='sql'>first_name</span> - Primeiro nome do ator.</li>
    <li> <span class='sql'>last_name</span> - Sobrenome do ator.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li> 
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
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (actor_id)</li>
  </ul>
  <h3 id="address_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>address</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>address_id</span> - Identificador único para cada endereço.</li>
    <li> <span class='sql'>address</span> - Endereço da rua.</li>
    <li> <span class='sql'>address2</span> - Endereço adicional.</li>
    <li> <span class='sql'>district</span> - Distrito ou região.</li>
    <li> <span class='sql'>city_id</span> - Chave estrangeira referenciando a tabela city.</li>
    <li> <span class='sql'>postal_code</span> - Código postal.</li>
    <li> <span class='sql'>phone</span> - Número de telefone.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>123 Rua Principal</td>
        <td>Apto 4</td>
        <td>Centro</td>
        <td>1</td>
        <td>12345</td>
        <td>123-456-7890</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (address_id)</li>
  </ul>
  <h3 id="category_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>category</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>category_id</span> - Identificador único para cada categoria.</li>
    <li> <span class='sql'>name</span> - Nome da categoria.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>Ação</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (category_id)</li>
  </ul>
  <h3 id="city_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>city</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>city_id</span> - Identificador único para cada cidade.</li>
    <li> <span class='sql'>city</span> - Nome da cidade.</li>
    <li> <span class='sql'>country_id</span> - Chave estrangeira referenciando a tabela country.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>Metrópole</td>
        <td>1</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (city_id)</li>
  </ul>
  <h3 id="country_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>country</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>country_id</span> - Identificador único para cada país.</li>
    <li> <span class='sql'>country</span> - Nome do país.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>Estados Unidos</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (country_id)</li>
  </ul>
  <h3 id="customer_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>customer</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>customer_id</span> - Identificador único para cada cliente.</li>
    <li> <span class='sql'>store_id</span> - Chave estrangeira referenciando a tabela store.</li>
    <li> <span class='sql'>first_name</span> - Primeiro nome do cliente.</li>
    <li> <span class='sql'>last_name</span> - Sobrenome do cliente.</li>
    <li> <span class='sql'>email</span> - Endereço de e-mail do cliente.</li>
    <li> <span class='sql'>address_id</span> - Chave estrangeira referenciando a tabela address.</li>
    <li> <span class='sql'>active</span> - Indica se o cliente está ativo.</li>
    <li> <span class='sql'>create_date</span> - Data e hora indicando quando o cliente foi adicionado ao banco de dados.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>João</td>
        <td>Silva</td>
        <td>joao.silva@exemplo.com</td>
        <td>1</td>
        <td>true</td>
        <td>2023-01-01 12:00:00</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (customer_id)</li>
  </ul>
  <h3 id="film_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>film</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>film_id</span> - Identificador único para cada filme.</li>
    <li> <span class='sql'>title</span> - O título do filme.</li>
    <li> <span class='sql'>description</span> - Uma breve descrição ou resumo do enredo do filme.</li>
    <li> <span class='sql'>release_year</span> - O ano em que o filme foi lançado.</li>
    <li> <span class='sql'>language_id</span> - Chave estrangeira referenciando a tabela language; identifica o idioma do filme.</li>
    <li> <span class='sql'>original_language_id</span> - Uma chave estrangeira apontando para a tabela language; identifica o idioma original do filme. Usado quando um filme foi dublado em um novo idioma.</li>
    <li> <span class='sql'>rental_duration</span> - A duração do período de aluguel, em dias.</li>
    <li> <span class='sql'>rental_rate</span> - O custo para alugar o filme pelo período especificado na coluna rental_duration.</li>
    <li> <span class='sql'>length</span> - Duração do filme, em minutos.</li>
    <li> <span class='sql'>replacement_cost</span> - O valor cobrado ao cliente se o filme não for devolvido ou for devolvido danificado.</li>
    <li> <span class='sql'>rating</span> - A classificação atribuída ao filme. Pode ser uma das seguintes: G, PG, PG-13, R ou NC-17.</li>
    <li> <span class='sql'>special_features</span> - Lista quais recursos especiais comuns estão incluídos no DVD. Pode ser zero ou mais de: Trailers, Comentários, Cenas Deletadas, Por Trás das Cenas.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>Título do Filme</td>
        <td>Uma breve descrição do filme.</td>
        <td>2000</td>
        <td>1</td>
        <td>2</td>
        <td>5</td>
        <td>4.99</td>
        <td>120</td>
        <td>19.99</td>
        <td>PG-13</td>
        <td>Trailers, Comentários</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (film_id)</li>
  </ul>
  <h3 id="film_actor_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>film_actor</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>actor_id</span> - Identificador único para ator.</li>
    <li> <span class='sql'>film_id</span> - Identificador único para filme.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (actor_id, film_id)</li>
  </ul>
  <h3 id="film_category_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>film_category</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>film_id</span> - Identificador único para cada filme.</li>
    <li> <span class='sql'>category_id</span> - Identificador único para cada categoria.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
  Índices:
  <ul class="table-columns">
      <li>CHAVE PRIMÁRIA, btree (film_id, category_id)</li>
  </ul>
  <h3 id="inventory_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>inventory</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
      <li><span class='sql'>inventory_id</span> - Identificador único para cada item do inventário.</li>
      <li><span class='sql'>film_id</span> - Identificador único para cada filme no inventário.</li>
      <li><span class='sql'>store_id</span> - Identificador único para a loja onde o item do inventário está localizado.</li>
      <li><span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (inventory_id)</li>
  </ul>
  <h3 id="language_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>language</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
      <li> <span class='sql'>language_id</span> - Identificador único para cada idioma.</li>
      <li> <span class='sql'>name</span> - Nome do idioma.</li>
      <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li> 
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
        <td>Inglês</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (language_id)</li>
  </ul>
  <h3 id="payment_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>payment</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>payment_id</span> - Identificador único para cada pagamento.</li>
    <li> <span class='sql'>customer_id</span> - Chave estrangeira referenciando a tabela customer.</li>
    <li> <span class='sql'>staff_id</span> - Chave estrangeira referenciando a tabela staff.</li>
    <li> <span class='sql'>rental_id</span> - Chave estrangeira referenciando a tabela rental.</li>
    <li> <span class='sql'>amount</span> - Valor do pagamento.</li>
    <li> <span class='sql'>payment_date</span> - Data do pagamento.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (payment_id)</li>
  </ul>
  <h3 id="rental_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>rental</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>rental_id</span> - Identificador único para cada aluguel.</li>
    <li> <span class='sql'>rental_date</span> - Data em que o aluguel ocorreu.</li>
    <li> <span class='sql'>inventory_id</span> - Chave estrangeira referenciando a tabela inventory.</li>
    <li> <span class='sql'>customer_id</span> - Chave estrangeira referenciando a tabela customer.</li>
    <li> <span class='sql'>return_date</span> - Data em que o aluguel foi devolvido.</li>
    <li> <span class='sql'>staff_id</span> - Chave estrangeira referenciando a tabela staff.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>2023</td>
        <td>1</td>
        <td>2023-01-10 09:12:36</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (rental_id)</li>
  </ul>
  <h3 id="staff_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>staff</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>staff_id</span> - Identificador único para cada membro da equipe.</li>
    <li> <span class='sql'>first_name</span> - Primeiro nome do membro da equipe.</li>
    <li> <span class='sql'>last_name</span> - Sobrenome do membro da equipe.</li>
    <li> <span class='sql'>address_id</span> - Chave estrangeira referenciando a tabela address.</li>
    <li> <span class='sql'>picture</span> - Foto do membro da equipe.</li>
    <li> <span class='sql'>email</span> - Endereço de e-mail do membro da equipe.</li>
    <li> <span class='sql'>store_id</span> - Chave estrangeira referenciando a tabela store.</li>
    <li> <span class='sql'>active</span> - Indica se o membro da equipe está ativo.</li>
    <li> <span class='sql'>username</span> - Nome de usuário para login.</li>
    <li> <span class='sql'>password</span> - Senha para login.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
        <td>João</td>
        <td>Silva</td>
        <td>1</td>
        <td>[null]</td>
        <td>joao.silva@exemplo.com</td>
        <td>1</td>
        <td>true</td>
        <td>joaosilva</td>
        <td>********</td>
        <td>2023-01-01 12:00:00</td>
      </tr>
    </table>
  </div>
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (staff_id)</li>
  </ul>
  <h3 id="store_table_description">
    <span class="pointer-hand" onClick="scrollInfoPanel('db-description'); return false;" title="Rolar para cima">
      <svg height="15" width="15" style="">
        <polygon points="8,1 15,14 1,14" fill="white"/>
      </svg>
    </span>
    Tabela <span class='sql'>store</span>
  </h3>
  Colunas da tabela: <ul class="table-columns">
    <li> <span class='sql'>store_id</span> - Identificador único para cada loja.</li>
    <li> <span class='sql'>manager_staff_id</span> - Chave estrangeira referenciando a tabela staff para o gerente da loja.</li>
    <li> <span class='sql'>address_id</span> - Chave estrangeira referenciando a tabela address.</li>
    <li> <span class='sql'>last_update</span> - Quando a linha foi criada ou atualizada mais recentemente.</li>
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
  Índices:
  <ul class="table-columns">
    <li>CHAVE PRIMÁRIA, btree (store_id)</li>
  </ul>
</div>