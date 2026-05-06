---
title: "Conceitos de Bases de Dados Relacionais: Tabelas, Chaves e ACID"
description: "Aprenda os componentes essenciais das bases de dados relacionais — tabelas, colunas, linhas, chaves primárias, estrangeiras e únicas, e propriedades ACID — com exemplos práticos."
keywords: ["conceitos bases de dados relacionais", "chave primária", "chave estrangeira", "propriedades ACID", "tabelas base de dados", "SQL base relacional"]
teaches: ["O que são tabelas, colunas e linhas numa base de dados relacional", "Como a chave primária identifica cada linha de forma única", "Como as chaves estrangeiras ligam tabelas", "O que garante uma chave única", "O que são restrições SQL e como NOT NULL e CHECK funcionam", "O que as propriedades ACID asseguram nas transações"]
about: ["Base de dados relacional", "Chave primária", "Chave estrangeira", "Restrição SQL", "ACID", "Transação de base de dados", "SQL"]
---

_Lição 1.3 · Tempo de leitura: ~10 min_

Uma **base de dados relacional** organiza os dados em tabelas ligadas por chaves. Nesta lição, aprenderá os componentes fundamentais — tabelas, colunas, linhas, chaves primárias, estrangeiras e únicas — e descobrirá como o modelo ACID garante a fiabilidade das transações mesmo em caso de falha ou acesso concorrente.

# Conceitos de Bases de Dados Relacionais: Tabelas, Chaves e ACID

Na lição anterior, introduzimos o conceito de bases de dados e analisámos os principais tipos de BDs. Agora, vamos aprofundar os componentes centrais das **bases de dados relacionais**, que são fundamentais para compreender como os dados são organizados e acedidos utilizando SQL.

<img src="/images/lessons/lesson1_2-rdb.jpg" alt="Diagrama de uma base de dados relacional mostrando duas tabelas ligadas por uma chave primária e uma chave estrangeira" width="100%">

## O Que São Tabelas, Colunas e Linhas?

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

## O Que São Chaves de Base de Dados? Primária, Estrangeira e Única

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

## O Que São Restrições SQL?

Uma **restrição (constraint)** é uma regra aplicada a uma coluna ou tabela que o motor da base de dados aplica automaticamente. As chaves (primária, estrangeira, única) são um tipo de restrição. Existem outras restrições importantes que usará no dia a dia em SQL:

| Restrição | Objetivo |
| :--------- | :------- |
| `NOT NULL` | A coluna deve ter sempre um valor; NULL não é permitido. |
| `UNIQUE` | Todos os valores na coluna devem ser distintos. |
| `PRIMARY KEY` | Combina NOT NULL + UNIQUE; identifica cada linha de forma única. |
| `FOREIGN KEY` | O valor deve corresponder a um valor existente noutra tabela. |
| `CHECK` | O valor deve satisfazer uma condição, p. ex. `age >= 0`. |

Por exemplo, uma tabela `customers` pode definir várias restrições em simultneo:

```sql
CREATE TABLE customers (
    customer_id  SERIAL        PRIMARY KEY,
    email        VARCHAR(255)  NOT NULL UNIQUE,
    age          INTEGER       CHECK (age >= 0),
    country      VARCHAR(100)  DEFAULT 'Unknown'
);
```

O motor da base de dados rejeitará automaticamente qualquer `INSERT` ou `UPDATE` que viole estas regras, mantendo os dados consistentes sem lógica adicional na aplicação.

## O Que É ACID? Segurança de Transações em Bases Relacionais

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

---

**Principais conclusões desta lição:**

* Uma base de dados relacional armazena dados em **tabelas** compostas por colunas e linhas.
* Uma **chave primária** identifica cada linha de forma única; deve ser única e não nula.
* Uma **chave estrangeira** liga uma linha de uma tabela a uma linha de outra, garantindo a integridade referencial.
* Uma **chave única** garante a unicidade dos valores numa coluna; uma tabela pode ter várias chaves únicas.
* As **restrições** (`NOT NULL`, `CHECK`, `DEFAULT`) são aplicadas automaticamente pelo motor da base de dados.
* O modelo **ACID** (Atomicidade, Consistência, Isolamento, Durabilidade) assegura a fiabilidade das transações mesmo em caso de falha ou acesso concorrente.

Na próxima lição, vamos analisar os tipos de dados básicos usados nas bases de dados relacionais e como escolher o tipo certo para cada coluna.

---

## Perguntas Frequentes

### Qual é a diferença entre uma chave primária e uma chave única?
Uma **chave primária** identifica cada linha de forma única e não pode ser NULL. Uma tabela só pode ter uma chave primária. Uma **chave única** também garante a unicidade, mas pode permitir valores NULL, e uma tabela pode ter várias chaves únicas. Use a chave primária como identificador principal da linha; use chaves únicas para impor unicidade noutras colunas, como `email`.

### Uma chave estrangeira pode referenciar uma chave única em vez de uma chave primária?
Sim. Uma chave estrangeira pode referenciar qualquer coluna (ou conjunto de colunas) com uma restrição de unicidade, não apenas a chave primária. No entanto, referenciar a chave primária é a prática mais comum e recomendada.

### O que acontece se uma transação ACID falhar a meio?
**A atomicidade** garante que toda a transação é revertida (rollback), deixando a base de dados no estado em que se encontrava antes do início da transação. Nenhuma alteração parcial é guardada.

## Questões de Entrevista

### Como explicaria uma chave primária numa entrevista?
Uma **chave primária** é uma coluna ou combinação de colunas que identifica de forma única cada linha numa tabela. Deve ser única, não pode conter valores NULL e só pode existir uma por tabela. Serve como ponto de ancoragem para referências de chaves estrangeiras de outras tabelas.

### O que é integridade referencial e como as chaves estrangeiras a garantem?
**Integridade referencial** significa que o valor de uma chave estrangeira numa tabela deve sempre corresponder a um valor de chave primária existente na tabela referenciada, ou ser NULL. O motor da base de dados aplica isto automaticamente — tentativas de inserir uma chave estrangeira órfã ou eliminar uma linha referenciada serão rejeitadas, a menos que uma regra de cascata esteja definida.

### O que significa ACID e por que é importante?
**ACID** significa Atomicidade, Consistência, Isolamento e Durabilidade. Define as garantias que tornam as transações fiáveis. Sem ACID, escritas concorrentes poderiam corromper dados, falhas parciais deixariam a base num estado inválido e alterações confirmadas poderiam perder-se após uma falha. É por isso que as bases de dados relacionais são utilizadas em sistemas financeiros, médicos e outras aplicações críticas.

→ [Lição 1.4: Tipos de Dados Básicos](/pt/lesson/getting-started/basic-data-types)