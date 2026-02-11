Aprenda a usar Subconsultas Correlacionadas SQL para realizar comparações complexas linha a linha. Esta lição explica a diferença entre subconsultas padrão e correlacionadas, o fluxo de execução e exemplos práticos, como encontrar registros que excedem a média de seu grupo. Domine técnicas SQL críticas para o desempenho usando o banco de dados Sakila.

# Lição 6.3: Subconsultas Correlacionadas

Nas lições anteriores, usamos subconsultas "independentes" que podiam ser executadas sozinhas. Nesta lição, apresentamos as **Subconsultas Correlacionadas** — um tipo mais avançado de subconsulta que depende de valores da consulta externa.

## O que é uma Subconsulta Correlacionada?

Uma subconsulta é **correlacionada** quando se refere a uma coluna de uma tabela na consulta externa. Diferente de uma subconsulta comum, uma subconsulta correlacionada não pode ser executada independentemente da consulta externa.

**Como funciona:**
1. O banco de dados pega uma linha da **consulta externa**.
2. Ele executa a **consulta interna** usando valores dessa linha específica.
3. Ele usa o resultado da consulta interna para satisfazer a cláusula `WHERE` (ou `SELECT`).
4. Ele passa para a **próxima linha** e repete o processo.

> **Nota de Desempenho:** Como uma subconsulta correlacionada é potencialmente executada uma vez para cada linha da consulta externa, ela pode ser mais lenta que um JOIN ou uma subconsulta comum em conjuntos de dados muito grandes.

## 1. Subconsultas Correlacionadas no WHERE

O uso mais comum é comparar o valor de uma linha com um conjunto de dados relacionado especificamente a *essa* linha.

**Cenário:** Encontrar todos os filmes que têm um custo de substituição maior do que o custo médio de substituição dos filmes na **mesma categoria de classificação** (ex: G, PG, R).

```sql
SELECT
    title,
    rating,
    replacement_cost
FROM
    film AS f1
WHERE
    replacement_cost > (
        SELECT AVG(replacement_cost)
        FROM film AS f2
        WHERE f1.rating = f2.rating
    );
```
- **Correlação:** `f1.rating = f2.rating` liga a consulta interna à linha atual da consulta externa.
- **Lógica:** Para cada filme, o banco de dados calcula a média de custo para sua classificação específica e verifica se aquele filme custa mais.

## 2. Subconsultas Correlacionadas no SELECT

Você pode usar subconsultas correlacionadas para recuperar dados descritivos ou agregados para cada linha sem usar uma cláusula `GROUP BY`.

**Cenário:** Mostrar a lista de categorias e o título do filme mais longo em cada categoria.

```sql
SELECT
    c.name AS nome_categoria,
    (
        SELECT f.title
        FROM film f
        JOIN film_category fc ON f.film_id = fc.film_id
        WHERE fc.category_id = c.category_id
        ORDER BY f.length DESC
        LIMIT 1) AS titulo_filme_mais_longo
FROM
    category AS c;
```

## 3. Subconsultas Correlacionadas com EXISTS

Vimos o operador `EXISTS` na lição anterior. O `EXISTS` é quase sempre usado com uma subconsulta correlacionada.

**Cenário:** Encontrar clientes que alugaram pelo menos um filme em uma loja específica (Loja 1).

```sql
SELECT
    first_name,
    last_name
FROM
    customer AS c
WHERE
    EXISTS (
        SELECT 1
        FROM rental AS r
        INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
        WHERE r.customer_id = c.customer_id
        AND i.store_id = 1
    );
```

## Principais Conclusões desta Lição

- Uma **Subconsulta Correlacionada** depende da consulta externa para seus valores.
- Ela é executada **linha a linha** (uma vez para cada linha candidata).
- **Aliases** são essenciais para distinguir entre as instâncias da tabela externa e interna.
- São poderosas para **comparações relativas ao grupo** (comparar uma linha com seu próprio grupo).
- Fique atento ao **desempenho** ao usá-las em milhões de registros.
