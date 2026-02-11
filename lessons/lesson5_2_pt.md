# Lição 5.2: INNER JOIN — Combinando Linhas Correspondentes

Na lição anterior, estabelecemos o conceito fundamental de unir tabelas para recuperar dados relacionados. O tipo de join mais comum e frequentemente utilizado é o **INNER JOIN**. Nesta lição, exploraremos sua lógica, sintaxe e aplicações práticas em detalhes.

## O que é um INNER JOIN?

Um `INNER JOIN` é uma operação que combina linhas de duas tabelas apenas quando há um valor correspondente em ambas as tabelas com base em uma condição especificada. Se uma linha na Tabela A não tiver uma correspondência correspondente na Tabela B, essa linha será excluída do conjunto de resultados. Da mesma forma, quaisquer linhas na Tabela B que não correspondam à Tabela A também serão deixadas de fora.

Pense nisso como a **interseção** de dois conjuntos de dados.

**Visualização:**
```
   Tabela A (customer)          Tabela B (payment)
   +----+----------+            +----+----------+
   | id | name     |            | id | amount   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | 10.00    | (Correspondência!)
   | 2  | Bob      |            | 1  | 15.00    | (Correspondência!)
   | 3  | Charlie  |            | 4  | 20.00    | (Sem correspondência para Charlie ou ID 4)
   +----+----------+            +----+----------+
```
*Neste exemplo, Charlie é excluído porque não tem pagamentos, e o pagamento com `customer_id` 4 é excluído porque não há cliente com esse ID.*

## Sintaxe do INNER JOIN

A sintaxe padrão para um `INNER JOIN` é:

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
INNER JOIN
    table2 ON table1.common_column = table2.common_column;
```

- `INNER JOIN`: Especifica que queremos apenas linhas correspondentes.
- `ON`: Define a condição para a correspondência (geralmente a Chave Primária de uma tabela e a Chave Estrangeira de outra).

> **Nota:** Na maioria dos bancos de dados SQL (como MySQL, PostgreSQL e SQL Server), a palavra-chave `INNER` é opcional. Escrever `JOIN` e `INNER JOIN` produzirá exatamente o mesmo resultado.

## Exemplos Práticos (Banco de Dados Sakila)

### 1. Conectando Cidades a Países
A tabela `city` contém um `country_id` que se refere à tabela `country`. Para ver o nome da cidade ao lado do nome do seu país, usamos um `INNER JOIN`.

```sql
SELECT
    ci.city,
    co.country
FROM
    city AS ci
INNER JOIN
    country AS co ON ci.country_id = co.country_id;
```
*Esta consulta retorna apenas cidades que estão vinculadas a um país válido.*

### 2. Listando Funcionários e Seus Endereços
To find where each staff member lives, we join the `staff` and `address` tables.
Para descobrir onde cada funcionário mora, unimos as tabelas `staff` e `address`.

```sql
SELECT
    s.first_name,
    s.last_name,
    a.address,
    a.district
FROM
    staff AS s
INNER JOIN
    address AS a ON s.address_id = a.address_id;
```

## Unindo Mais de Duas Tabelas

Você pode encadear várias cláusulas `INNER JOIN` para reunir informações de várias tabelas ao mesmo tempo. Por exemplo, para ver em quais filmes um ator apareceu, precisamos de três tabelas: `actor`, `film` e a tabela de junção `film_actor`.

```sql
SELECT
    a.first_name,
    a.last_name,
    f.title
FROM
    actor AS a
INNER JOIN
    film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN
    film AS f ON fa.film_id = f.film_id
LIMIT 10;
```

**Como funciona:**
1. A primeira junção conecta `actor` e `film_actor` com base no `actor_id`.
2. A segunda junção conecta o resultado da primeira junção com a tabela `film` com base no `film_id`.
3. Apenas registros que existem em todas as três tabelas satisfazem a condição e aparecem nos resultados.

## Principais Conclusões desta Lição

- **INNER JOIN** é o tipo de join padrão no SQL.
- Ele retorna linhas apenas quando há uma **correspondência** em ambas as tabelas.
- Linhas que não atendem à condição de junção são **descartadas** do conjunto de resultados.
- Você pode unir várias tabelas adicionando instruções `INNER JOIN` subsequentes.
- O uso de **aliases de tabela** (`AS ci`, `AS co`) torna as junções complexas muito mais fáceis de ler e escrever.
