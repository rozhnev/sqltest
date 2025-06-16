# Aula 4.2: Agrupando Dados com GROUP BY em SQL

O agrupamento de dados é uma ferramenta fundamental para análise e sumarização em SQL. A cláusula `GROUP BY` permite combinar linhas com os mesmos valores em colunas especificadas e aplicar funções de agregação a cada grupo. Nesta lição, você aprenderá a usar o `GROUP BY` para relatórios e análise de dados com exemplos do banco de dados Sakila.

## Noções Básicas de Uso do GROUP BY

### Sintaxe
```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1;
```

### Exemplo: Total de pagamentos por cliente
```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
```
**Resultado:** Retorna o valor total dos pagamentos para cada cliente.

### Exemplo: Número de pagamentos por funcionário
```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id;
```
**Resultado:** Mostra quantos pagamentos cada funcionário processou.

### Exemplo: Pagamento médio por data
```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY pay_date;
```
**Resultado:** Retorna o valor médio dos pagamentos para cada data.

## Usando GROUP BY com Múltiplas Colunas

Você pode agrupar dados por várias colunas ao mesmo tempo para uma análise mais detalhada.

### Exemplo: Total de pagamentos por funcionário e cliente
```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id, customer_id;
```
**Resultado:** Mostra quanto cada funcionário recebeu de cada cliente.

## Aplicações Práticas

1. **Análise de vendas por categoria de filme:**
   ```sql
   SELECT c.name AS category, SUM(p.amount) AS total_sales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name;
   ```
2. **Número de clientes por país:**
   ```sql
   SELECT country, COUNT(*) AS customers_count
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY country;
   ```

## Principais Conclusões desta Lição

A cláusula `GROUP BY` permite agrupar dados e aplicar funções de agregação a cada grupo. É uma ferramenta poderosa para relatórios e análise de dados em SQL. Pratique o uso do `GROUP BY` com exemplos do banco de dados Sakila para obter rapidamente dados resumidos e construir consultas analíticas.
