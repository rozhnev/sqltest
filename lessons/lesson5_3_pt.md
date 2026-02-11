Aprenda a usar o SQL LEFT JOIN (ou LEFT OUTER JOIN) para recuperar todos os registros de uma tabela e registros correspondentes de outra. Esta lição explica a lógica de "esquerda" e "direita" em operações JOIN, como lidar com valores NULL para registros não correspondentes e exemplos práticos usando o banco de dados Sakila. Domine técnicas para encontrar dados ausentes e relatórios abrangentes.

# Lição 5.3: LEFT JOIN — Incluindo Todos os Registros da Tabela à Esquerda

Enquanto o `INNER JOIN` retorna apenas linhas onde há uma correspondência em ambas as tabelas, há muitos cenários em que você deseja manter todos os registros de uma tabela, mesmo que eles não tenham uma correspondência na outra. É exatamente isso que o **LEFT JOIN** (também conhecido como **LEFT OUTER JOIN**) faz.

## O que é um LEFT JOIN?

Um `LEFT JOIN` retorna **todas** as linhas da tabela da "esquerda" (a mencionada primeiro na consulta) e as linhas correspondentes da tabela da "direita" (a mencionada após a palavra-chave `JOIN`).

Se não houver correspondência na tabela da direita para uma linha específica na tabela da esquerda, o banco de dados ainda retornará a linha da tabela da esquerda, mas colocará **NULL** em todas as colunas vindas da tabela da direita.

**Visualização:**
```
   Tabela A (customer)          Tabela B (payment)
   +----+----------+            +----+----------+
   | id | name     |            | id | amount   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | 10.00    | (Correspondência!)
   | 2  | Bob      | <--------> | 1  | 15.00    | (Correspondência!)
   | 3  | Charlie  | <--------? | NULL          | (Sem correspondência, mantém Charlie!)
   +----+----------+            +----+----------+
```
*Neste exemplo, Charlie é incluído nos resultados mesmo que não tenha pagamentos. O "amount" para sua linha será NULL.*

## Sintaxe do LEFT JOIN

A sintaxe para um `LEFT JOIN` é idêntica à do `INNER JOIN`, mas com uma palavra-chave diferente:

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
LEFT JOIN
    table2 ON table1.common_column = table2.common_column;
```

- `LEFT JOIN`: Garante que todas as linhas da `table1` (a tabela da esquerda) sejam mantidas.
- `ON`: A condição para a correspondência.

> **Nota:** `LEFT JOIN` e `LEFT OUTER JOIN` são a mesma coisa. A palavra-chave `OUTER` é opcional.

## Exemplos Práticos (Banco de Dados Sakila)

### 1. Encontrando Todos os Clientes e Seus Pagamentos
Suponha que queiramos uma lista de todos os clientes, incluindo aqueles que nunca fizeram um pagamento. Um `INNER JOIN` filtraria os clientes sem pagamentos, mas um `LEFT JOIN` os mantém.

```sql
SELECT
    c.first_name,
    c.last_name,
    p.amount
FROM
    customer AS c
LEFT JOIN
    payment AS p ON c.customer_id = p.customer_id
ORDER BY
    p.amount ASC;
```
*Se você vir linhas onde `amount` é NULL, esses são clientes que não possuem registros de pagamento.*

### 2. Identificando Inventário "Morto"
Vamos encontrar todas as cópias de filmes (inventário) e verificar se elas já foram alugadas.

```sql
SELECT
    i.inventory_id,
    f.title,
    r.rental_id
FROM
    inventory AS i
JOIN
    film AS f ON i.film_id = f.film_id
LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id
WHERE
    r.rental_id IS NULL;
```
*Ao usar `LEFT JOIN` e filtrar por `r.rental_id IS NULL`, podemos encontrar itens específicos em nosso inventário que nunca foram alugados.*

## Considerações Importantes

1.  **A Ordem das Tabelas Importa:** Em um `LEFT JOIN`, a tabela listada após `FROM` é a tabela da "Esquerda". Se você inverter as tabelas, o resultado muda completamente.
2.  **Lidando com NULLs:** Ao usar `LEFT JOIN`, o código da sua aplicação precisa estar pronto para lidar com valores `NULL` nos resultados.
3.  **Filtragem:** Se você colocar uma condição na cláusula `WHERE` que faça referência à tabela da direita, poderá acidentalmente transformar seu `LEFT JOIN` em um `INNER JOIN` (esta é uma armadilha comum do SQL).

## Principais Conclusões desta Lição

- **LEFT JOIN** retorna todas as linhas da tabela da esquerda, independentemente de existir uma correspondência.
- As colunas da tabela da direita conterão **NULL** quando nenhuma correspondência for encontrada.
- É uma ferramenta poderosa para **encontrar dados ausentes** ou gerar listas abrangentes.
- Ao contrário do `INNER JOIN`, a **ordem das tabelas** na consulta impacta significativamente o resultado.
