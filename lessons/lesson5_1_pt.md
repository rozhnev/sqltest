---
title: "SQL JOIN Explicado: Como Combinar Tabelas em SQL"
description: "Um SQL JOIN combina linhas de duas ou mais tabelas com base numa coluna relacionada. Aprenda o conceito, a cláusula ON, aliases de tabelas e exemplos práticos com a base Sakila."
keywords: ["SQL JOIN", "JOIN em SQL", "como funciona JOIN", "cláusula ON SQL", "aliases de tabela SQL", "exemplos JOIN Sakila"]
teaches: ["O que é um SQL JOIN e para que serve", "Como a cláusula ON define a relação entre tabelas", "Como usar aliases de tabelas para consultas legíveis", "Como unir as tabelas customer e payment na prática", "Como unir as tabelas film e language na prática"]
about: ["SQL JOIN", "INNER JOIN", "Cláusula ON", "Alias de tabela", "Base de dados relacional", "Base de dados Sakila"]
---

_Lição 5.1 · Tempo de leitura: ~8 min_

Um **SQL JOIN** combina linhas de duas ou mais tabelas com base numa coluna relacionada. Nesta lição, aprenderá o conceito fundamental do JOIN, como escrever uma cláusula `ON`, porque os aliases de tabelas são importantes, e como consultar dados relacionados da base Sakila passo a passo.

# SQL JOIN: Como Combinar Tabelas em Bases de Dados Relacionais

Em bancos de dados relacionais, a informação é armazenada como um conjunto de tabelas relacionadas. Para extrair dados significativos delas, você precisa saber como uni-las. A operação `JOIN` em SQL é usada para esse propósito. Ela permite combinar linhas de duas ou mais tabelas com base em uma coluna relacionada.

Esta lição estabelece a base para entender o `JOIN` como um conceito-chave para trabalhar com dados relacionais.

## O Que É um SQL JOIN e Como Funciona?

Um `JOIN` é um mecanismo que permite combinar linhas de diferentes tabelas em um único conjunto de resultados. A união é realizada com base em uma condição que, na maioria das vezes, compara valores em colunas-chave.

Imagine duas tabelas: `customer` (cliente) e `payment` (pagamento). A tabela `payment` tem uma coluna `customer_id` que indica qual cliente fez o pagamento. Um `JOIN` permite "colar" as linhas dessas duas tabelas para que, para cada pagamento, você possa ver o nome do cliente, e não apenas seu ID.

**Como funciona:**
1.  Você especifica as duas tabelas que deseja unir.
2.  Você define a condição de união na cláusula `ON`, por exemplo, `customer.customer_id = payment.customer_id`.
3.  O banco de dados percorre as linhas, encontra os pares correspondentes e forma novas linhas combinadas a partir deles.

**Visualização:**
```
  Table A (customer)      Table B (payment)
  +----+-------+            +----+----------+
  | id | name  |            | id | amount   |
  +----+-------+            +----+----------+
  | 1  | Ivan  | <-----\    | 1  | 100.00   |
  | 2  | Maria |       \--->| 1  | 50.00    |
  | 3  | Petr  |            | 3  | 200.00   |
  +----+-------+            +----+----------+
```
*As setas mostram como as linhas da tabela `payment` encontram seu cliente correspondente na tabela `customer` com base no `id` correspondente.*

## Como Usar JOIN na Prática: Exemplos com Sakila

Vamos ver como isso se parece em uma consulta SQL real usando o banco de dados Sakila.

1.  **Obtendo uma lista de clientes e seus pagamentos:**
    Esta consulta une as tabelas `customer` e `payment` para mostrar o nome e o sobrenome do cliente ao lado de cada pagamento.
    ```sql
    SELECT
        c.first_name,
        c.last_name,
        p.amount,
        p.payment_date
    FROM
        customer AS c
    JOIN
        payment AS p ON c.customer_id = p.customer_id;
    ```
    - `JOIN payment AS p` especifica que estamos unindo a tabela `payment`.
    - `ON c.customer_id = p.customer_id` é a condição que define como as linhas estão relacionadas.
    - `c` e `p` são **aliases** (apelidos), que tornam a consulta mais curta e legível.

2.  **Obtendo uma lista de filmes e seu idioma:**
    Vamos unir as tabelas `film` e `language` para mostrar o título de cada filme e o idioma em que ele está.
    ```sql
    SELECT
        f.title,
        l.name AS language
    FROM
        film AS f
    JOIN
        language AS l ON f.language_id = l.language_id;
    ```
    Aqui, a relação é estabelecida através da chave `language_id`.

---

**Principais conclusões desta lição:**

* Um **SQL JOIN** combina linhas de duas ou mais tabelas num único conjunto de resultados.
* A **cláusula ON** define como as linhas se relacionam — normalmente através de colunas-chave correspondentes.
* Os **aliases de tabelas** (`customer AS c`) encurtam as consultas e tornam-nas mais fáceis de ler.
* `JOIN` não modifica os dados originais; cria apenas um conjunto de resultados temporário.
* Nas lições seguintes, exploraremos `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` e `FULL JOIN` em detalhe.

→ [Lição 5.2: INNER JOIN — Combinando Linhas Correspondentes](/pt/lesson/joins/inner-join)

---

## Perguntas Frequentes

### Qual é a diferença entre JOIN e INNER JOIN?
Em SQL, `JOIN` simples é uma abreviação de `INNER JOIN`. Ambos produzem resultados idênticos. A forma explícita `INNER JOIN` é muitas vezes preferida para maior clareza, especialmente quando se combinam diferentes tipos de join na mesma consulta.

### O que acontece se a cláusula ON não encontrar correspondências?
Se nenhuma linha satisfizer a condição ON, um `INNER JOIN` devolve um conjunto de resultados vazio. Nenhum erro é gerado — a consulta simplesmente devolve zero linhas. Outros tipos de join (`LEFT JOIN`, etc.) tratam as linhas sem correspondência de forma diferente.

### Pode-se unir mais de duas tabelas numa só consulta?
Sim. É possível encadear várias cláusulas `JOIN` numa única consulta, cada uma com a sua própria condição `ON`. A base de dados processa-as da esquerda para a direita, construindo progressivamente o conjunto de resultados.

---

## Questões de Entrevista

### Como explicaria JOIN a um colega não técnico?
Um **JOIN** é como usar um ID comum para cruzar informações entre duas folhas de cálculo. Por exemplo, se uma folha lista clientes com IDs e outra lista pagamentos com o ID do cliente, um JOIN permite ver o nome do cliente ao lado de cada pagamento — sem duplicar dados.

### Para que serve a cláusula ON e pode-se dispensar?
A **cláusula ON** especifica a condição que liga as linhas das duas tabelas. Sem ela (ou sem uma condição válida), a base produziria um produto cartesiano — cada linha da primeira tabela combinada com cada linha da segunda — o que raramente é útil e pode ser enormemente volumoso.

### Por que usar aliases de tabelas em consultas JOIN?
Os **aliases** eliminam ambiguidades quando duas tabelas têm colunas com o mesmo nome (p. ex. `id`). Com aliases, escreve-se `c.id` vs `p.id`, o que é imediatamente claro tanto para o leitor como para a base de dados.