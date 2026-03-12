# Lição 1.3: Conceitos de Bases de Dados Relacionais

Na lição anterior, introduzimos o conceito de bases de dados. Agora, vamos aprofundar os componentes centrais das **Bases de Dados Relacionais**, que são fundamentais para compreender como os dados são organizados e acedidos utilizando SQL.

<img src="/images/lessons/lesson1_2-rdb.jpg" alt="DBMS overview" width="100%">

##   Tabelas, Colunas e Linhas

As bases de dados relacionais organizam os dados em estruturas chamadas **tabelas**. Pense numa tabela como uma folha de cálculo:

* **Tabela:** Uma coleção de dados relacionados. Por exemplo, uma tabela pode armazenar informações sobre clientes, produtos ou encomendas.
* **Coluna:** Um conjunto vertical de dados dentro de uma tabela. Cada coluna representa um atributo ou característica específica dos dados. Por exemplo, numa tabela "Clientes", as colunas podem ser "CustomerID", "FirstName", "LastName" e "Email".
* **Linha:** Um conjunto horizontal de dados dentro de uma tabela. Cada linha representa uma única instância ou registo dos dados. Numa tabela "Clientes", cada linha representaria um único cliente.

**Exemplo:**

Vamos visualizar uma tabela "Clientes" simples:

|   CustomerID   |   FirstName   |   LastName   |   Email                |
| :------------- | :------------ | :----------- | :--------------------- |
|   1            |   John        |   Doe        |   john.doe@example.com   |
|   2            |   Jane        |   Smith      |   jane.smith@example.com   |
|   3            |   David       |   Lee        |   david.lee@example.com    |

* Toda a estrutura é a **tabela** chamada "Clientes".
* "CustomerID", "FirstName", "LastName" e "Email" são as **colunas**.
* Cada linha (por exemplo, "1 | John | Doe | john.doe@example.com") é uma **linha**.

##   Chaves: Garantindo a Integridade dos Dados

As **chaves** são um conceito crítico nas bases de dados relacionais. São utilizadas para estabelecer relações entre tabelas e impor a integridade dos dados. Aqui estão os principais tipos de chaves:

###   Chave Primária (Primary Key)

* Uma **Chave Primária** é uma coluna (ou um conjunto de colunas) que identifica exclusivamente cada linha numa tabela.
* **Características de uma Chave Primária:**
    * **Única:** Nenhuma linha pode ter o mesmo valor de chave primária.
    * **Não Nula:** Uma coluna de chave primária não pode conter valores NULL.
* Na nossa tabela "Clientes", "CustomerID" é um bom candidato para a chave primária porque cada cliente tem um ID único e não pode estar vazio.

###   Chave Estrangeira (Foreign Key)

* Uma **Chave Estrangeira** é uma coluna (ou um conjunto de colunas) numa tabela que se refere à Chave Primária noutra tabela.
* As chaves estrangeiras estabelecem relações entre tabelas.
* Por exemplo, se tivermos uma tabela "Encomendas", ela pode ter uma coluna "CustomerID" que é uma chave estrangeira que se refere à "CustomerID" na tabela "Clientes". Isto liga cada encomenda ao cliente que a fez.

###   Chave Única (Unique Key)

* Uma **Chave Única** é uma coluna (ou um conjunto de colunas) que garante que os valores na(s) coluna(s) são únicos em todas as linhas da tabela.
* **Diferença da Chave Primária:**
    * Uma tabela pode ter apenas uma chave primária, mas pode ter várias chaves únicas.
    * As colunas de chave única *podem* permitir valores NULL (embora as implementações variem ligeiramente).
* Na nossa tabela "Clientes", "Email" pode ser uma chave única, garantindo que cada cliente tem um endereço de email único.

##   ACID: Transações Fiáveis em Bases de Dados

Ao trabalhar com bases de dados relacionais, outro conceito fundamental é o modelo **ACID**. O ACID define as propriedades que tornam as transações de base de dados seguras e fiáveis.

Uma **transação** é um grupo de operações tratado como uma única unidade de trabalho. Por exemplo, uma transferência de dinheiro entre duas contas bancárias normalmente envolve pelo menos duas operações:

1. Debitar dinheiro da Conta A.
2. Creditar dinheiro na Conta B.

Ambos os passos devem ser concluídos em conjunto, ou então nenhum deve ser aplicado.

**ACID significa:**

* **Atomicidade:** Uma transação é "tudo ou nada". Se um passo falhar, toda a transação é revertida.
* **Consistência:** Uma transação deve levar a base de dados de um estado válido para outro, preservando todas as regras e restrições definidas.
* **Isolamento:** Transações concorrentes não devem interferir entre si de forma a causar resultados incorretos.
* **Durabilidade:** Depois de uma transação ser confirmada (commit), as alterações tornam-se permanentes, mesmo em caso de falha de energia ou crash do sistema.

Estas propriedades são essenciais em sistemas reais como banca, comércio eletrónico e gestão de inventário, onde atualizações incorretas ou parciais podem causar problemas graves.

##   Importância Destes Conceitos

Compreender tabelas, colunas, linhas e chaves é fundamental para trabalhar com bases de dados relacionais.

* Definem como os dados são estruturados e organizados.
* Permitem-nos consultar e recuperar informações específicas de forma eficiente.
* As chaves garantem a integridade dos dados e estabelecem relações entre diferentes conjuntos de dados.
* As propriedades ACID garantem que as alterações aos dados permanecem corretas e fiáveis, mesmo com falhas ou acesso concorrente.

Nas lições seguintes, vamos construir sobre estes conceitos à medida que aprendemos a usar SQL para interagir com bases de dados relacionais.