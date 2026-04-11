# Aula 4.2: Agrupando Dados com GROUP BY em SQL

O agrupamento de dados é uma ferramenta fundamental para análise e sumarização em SQL. A cláusula `GROUP BY` permite combinar linhas com os mesmos valores em colunas especificadas e aplicar funções de agregação a cada grupo. Nesta lição, você aprenderá a usar o `GROUP BY` para relatórios e análise de dados com exemplos do banco de dados Sakila.

## Noções Básicas de Uso do GROUP BY

### Sintaxe
```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1;
```

### Regra importante

Ao usar `GROUP BY`, toda coluna selecionada em `SELECT` deve:

- ou estar incluída na cláusula `GROUP BY`;
- ou estar envolvida por uma função de agregação (`SUM`, `COUNT`, `AVG`, `MIN`, `MAX`, etc.).

### Exemplo: Total de pagamentos por cliente
```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
```
**Resultado:** Retorna o identificador do cliente e o valor total dos pagamentos para cada cliente.

### Exemplo: Número de pagamentos por funcionário
```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id;
```
**Resultado:** Retorna o identificador do funcionário e a quantidade de pagamentos processados por cada funcionário.

### Exemplo: Pagamento médio por data
```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY DATE(payment_date);
```
**Resultado:** Retorna o valor médio dos pagamentos para cada data.

### Variante: GROUP BY com alias
```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY pay_date;
```

Essa variante funciona em MySQL/MariaDB, onde é permitido usar alias no `GROUP BY`.
Porém, esse comportamento não é universal em todos os SGBDs e não é considerado SQL padrão portável.
Para consultas entre diferentes SGBDs, é mais seguro usar a forma completa `GROUP BY DATE(payment_date)`.

## Usando GROUP BY com Múltiplas Colunas

Você pode agrupar dados por várias colunas ao mesmo tempo para uma análise mais detalhada.

### Exemplo: Total de pagamentos por funcionário e cliente
```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id, customer_id;
```
**Resultado:** Retorna o identificador do funcionário, o identificador do cliente e o valor total dos pagamentos para cada par funcionário-cliente.

## Aplicações Práticas

Nesta etapa, é melhor praticar `GROUP BY` usando apenas uma tabela. Nas próximas lições, você verá como usar agregações também em consultas que combinam dados de várias tabelas.

1. **Relatório de receita por dia:**
   ```sql
   SELECT DATE(payment_date) AS pay_date, SUM(amount) AS total_sales
   FROM payment
   GROUP BY DATE(payment_date)
   ORDER BY pay_date;
   ```
2. **Clientes mais ativos pelo número de locações:**
   ```sql
   SELECT customer_id, COUNT(*) AS rentals_count
   FROM rental
   GROUP BY customer_id
   ORDER BY rentals_count DESC;
   ```

## Principais Conclusões desta Lição

A cláusula `GROUP BY` permite agrupar dados e aplicar funções de agregação a cada grupo. É uma ferramenta poderosa para relatórios e análise de dados em SQL. Pratique o uso do `GROUP BY` com exemplos do banco de dados Sakila para obter rapidamente dados resumidos e construir consultas analíticas.
