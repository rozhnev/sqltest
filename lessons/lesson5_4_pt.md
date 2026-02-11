Aprenda a usar o SQL RIGHT JOIN (ou RIGHT OUTER JOIN) para recuperar todos os registros da tabela à direita e os registros correspondentes da esquerda. Esta lição explica por que o RIGHT JOIN é frequentemente considerado a imagem espelhada do LEFT JOIN, quando usá-lo e como manter a legibilidade da consulta. Domine técnicas completas de recuperação de dados usando o banco de dados Sakila.

# Lição 5.4: RIGHT JOIN — Incluindo Todos os Registros da Tabela à Direita

O **RIGHT JOIN** (ou **RIGHT OUTER JOIN**) é o oposto lógico do `LEFT JOIN`. Ele garante que todas as linhas da tabela da "direita" (a mencionada após a palavra-chave `JOIN`) sejam incluídas no conjunto de resultados, independentemente de terem ou não uma correspondência na tabela da "esquerda".

## O que é um RIGHT JOIN?

Um `RIGHT JOIN` retorna **todas** as linhas da tabela da direita e as linhas correspondentes da tabela da esquerda. Se não houver correspondência na tabela da esquerda, o resultado conterá valores **NULL** para as colunas da tabela da esquerda.

**Visualização:**
```
   Tabela A (customer)          Tabela B (payment)
   +----+----------+            +----+----------+
   | id | name     |            | id | amount   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | 10.00    | (Correspondência!)
   | NULL          | <--------> | 4  | 50.00    | (Sem correspondência, mantém Pagamento 4!)
   +----+----------+            +----+----------+
```
*Neste exemplo, o pagamento com ID 4 é mantido mesmo que nenhum cliente esteja associado a ele (embora em um banco de dados bem projetado como o Sakila, isso seja raro devido às restrições de chave estrangeira).*

## Sintaxe do RIGHT JOIN

A sintaxe segue o mesmo padrão das outras junções:

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
RIGHT JOIN
    table2 ON table1.common_column = table2.common_column;
```

- `RIGHT JOIN`: Garante que todas as linhas da `table2` (a tabela da direita) sejam mantidas.
- `ON`: Especifica a condição de junção.

## Exemplos Práticos (Banco de Dados Sakila)

Embora o `RIGHT JOIN` seja menos comum na prática do que o `LEFT JOIN` (porque qualquer `RIGHT JOIN` pode ser reescrito como um `LEFT JOIN` invertendo a ordem das tabelas), ainda é importante compreendê-lo.

### 1. Listando Todos os Endereços e Seus Funcionários
Suponha que queiramos ver todos os endereços em nosso sistema e verificar se algum funcionário está atribuído a eles no momento.

```sql
SELECT
    s.first_name,
    s.last_name,
    a.address
FROM
    staff AS s
RIGHT JOIN
    address AS a ON s.address_id = a.address_id
ORDER BY
    s.last_name;
```
*Isso retornará todos os endereços da tabela `address`. Se um endereço não tiver funcionário, os nomes serão NULL.*

## RIGHT JOIN vs. LEFT JOIN

Cada `RIGHT JOIN` pode ser expresso como um `LEFT JOIN`. A maioria dos desenvolvedores SQL prefere usar `LEFT JOIN` exclusivamente e simplesmente reordenar as tabelas para manter a tabela "principal" à esquerda. Isso geralmente torna a consulta mais fácil de ler de cima para baixo.

**Exemplo de equivalência:**

```sql
-- Usando RIGHT JOIN
SELECT f.title, i.inventory_id
FROM film f
RIGHT JOIN inventory i ON f.film_id = i.film_id;

-- Usando LEFT JOIN (mesmo resultado)
SELECT f.title, i.inventory_id
FROM inventory i
LEFT JOIN film f ON i.film_id = f.film_id;
```

## Principais Conclusões desta Lição

- **RIGHT JOIN** retorna todas as linhas da tabela da direita.
- É a **imagem espelhada** do `LEFT JOIN`.
- As colunas da tabela da esquerda conterão **NULL** onde nenhuma correspondência for encontrada.
- A maioria dos desenvolvedores prefere o **LEFT JOIN** para consistência, mas entender ambos é essencial para ler códigos existentes.
