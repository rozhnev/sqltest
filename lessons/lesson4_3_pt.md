# Lição 4.3: Filtrando Dados Agrupados com HAVING no SQL

Ao trabalhar com dados agrupados no SQL, muitas vezes é necessário filtrar os resultados da agregação. A cláusula `HAVING` permite especificar condições sobre os grupos criados pelo `GROUP BY`, de forma semelhante ao que o `WHERE` faz para linhas individuais. Nesta lição, você aprenderá a usar o `HAVING` para filtrar resultados agregados, com exemplos práticos usando o banco de dados Sakila.

## O Papel do HAVING

- `WHERE` filtra linhas antes do agrupamento.
- `HAVING` filtra grupos após a agregação.

### Sintaxe

```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1
HAVING condition;
```

## Exemplo: Clientes com Pagamentos Totais Acima de um Limite

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```
**Resultado:** Retorna apenas os clientes cujo total de pagamentos excede 100.

## Exemplo: Funcionários com Mais de 50 Pagamentos Processados

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```
**Resultado:** Mostra apenas os funcionários que processaram mais de 50 pagamentos.

## Exemplo: Filtrando pela Média de Pagamento

```sql
SELECT customer_id, AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```
**Resultado:** Lista os clientes cuja média de pagamento é pelo menos 5.

## Usando HAVING com Múltiplas Condições

Você pode combinar várias condições na cláusula `HAVING` usando `AND`/`OR`.

```sql
SELECT staff_id, COUNT(*) AS payments_count, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```
**Resultado:** Retorna funcionários que processaram mais de 50 pagamentos e cujo total de pagamentos excede 500.

## Uso Prático

1. **Categorias de Filmes com Maiores Vendas:**
   ```sql
   SELECT c.name AS category, SUM(p.amount) AS total_sales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name
   HAVING SUM(p.amount) > 2000;
   ```
   *Mostra apenas categorias com vendas totais acima de 2000.*

2. **Países com Mais de 20 Clientes:**
   ```sql
   SELECT country, COUNT(*) AS customers_count
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY country
   HAVING COUNT(*) > 20;
   ```
   *Lista países com mais de 20 clientes.*

## Principais Conclusões desta Lição

- Use `HAVING` para filtrar grupos após a agregação.
- `HAVING` funciona com funções agregadas, enquanto `WHERE` não.
- Combine `HAVING` com `GROUP BY` para análises e relatórios poderosos.

Pratique o uso do `HAVING` em suas próprias consultas para obter insights mais profundos de dados agrupados no SQL.
