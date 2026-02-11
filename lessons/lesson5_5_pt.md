Aprenda a usar o SQL FULL OUTER JOIN para combinar todos os registros de ambas as tabelas (esquerda e direita). Esta lição aborda o conceito de conjuntos de dados abrangentes, lidando com NULLs em ambos os lados e soluções comuns para bancos de dados que não suportam FULL OUTER JOIN nativamente. Domine técnicas avançadas de junção para visibilidade total dos dados.

# Lição 5.5: FULL OUTER JOIN — Combinando Tudo de Ambas as Tabelas

O **FULL OUTER JOIN** é o tipo de junção mais inclusivo. Ele retorna todas as linhas quando há uma correspondência em **qualquer uma** das tabelas, esquerda ou direita. É essencialmente uma combinação de um `LEFT JOIN` e um `RIGHT JOIN`.

## O que é um FULL OUTER JOIN?

Um `FULL OUTER JOIN` cria um conjunto de resultados que inclui todos os registros de ambas as tabelas.
- Se uma linha coincidir, as colunas de ambas as tabelas são preenchidas.
- Se houver uma linha na tabela da esquerda sem correspondência na direita, as colunas da direita serão **NULL**.
- Se houver uma linha na tabela da direita sem correspondência na esquerda, as colunas da esquerda serão **NULL**.

**Visualização:**
```
   Tabela A (leads_potenciais)  Tabela B (clientes_ativos)
   +----+----------+            +----+----------+
   | id | nome     |            | id | status   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | Ativo    | (Correspondência!)
   | 2  | Bob      | <--------? | NULL          | (Apenas lead, sem conta ainda)
   | NULL          | <--------> | 3  | Ativo    | (Apenas cliente, não está na lista de leads)
   +----+----------+            +----+----------+
```

## Sintaxe do FULL OUTER JOIN

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
FULL OUTER JOIN
    table2 ON table1.common_column = table2.common_column;
```

> **Nota Importante sobre Suporte de Banco de Dados:** Nem todos os sistemas de banco de dados suportam `FULL OUTER JOIN` nativamente.
> - **PostgreSQL, SQL Server e Oracle** suportam.
> - **MySQL e MariaDB** **NÃO** suportam.

## Solução Alternativa para MySQL/MariaDB

Como o MySQL não possui `FULL OUTER JOIN`, os desenvolvedores obtêm o mesmo resultado combinando um `LEFT JOIN` e um `RIGHT JOIN` usando o operador `UNION`:

```sql
SELECT * FROM table1 LEFT JOIN table2 ON table1.id = table2.id
UNION
SELECT * FROM table1 RIGHT JOIN table2 ON table1.id = table2.id;
```

## Exemplo Prático

Imagine que estamos mesclando dados de duas filiais diferentes. A Filial A tem sua própria lista de clientes e a Filial B tem a dela. Queremos uma lista completa de todos os clientes em ambas as filiais, mostrando onde eles se sobrepõem.

```sql
SELECT
    a.customer_name AS nome_filial_a,
    b.customer_name AS nome_filial_b
FROM
    branch_a_customers AS a
FULL OUTER JOIN
    branch_b_customers AS b ON a.customer_id = b.customer_id;
```

## Principais Conclusões desta Lição

- **FULL OUTER JOIN** retorna todos os registros de ambas as tabelas.
- Ele usa **NULLs** para preencher as lacunas onde nenhuma correspondência é encontrada em nenhum dos lados.
- É a melhor ferramenta para **sincronização de banco de dados** e para encontrar discrepâncias entre duas listas.
- Se o seu banco de dados não suportar (como o MySQL), use um **UNION** de um LEFT e RIGHT join.
