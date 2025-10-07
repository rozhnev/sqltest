# Aula 4.1: Funções Básicas de Agregação em SQL

As funções de agregação em SQL são usadas para realizar cálculos em várias linhas de uma coluna de tabela e retornar um único valor. Essas funções são essenciais para resumir dados, gerar relatórios e realizar análises estatísticas. Esta lição aborda as funções de agregação mais comuns com exemplos práticos baseados no banco de dados Sakila.

## Funções de Agregação Comuns

### `COUNT()` — Conta o número de linhas

**Sintaxe:**
```sql
COUNT(expressão)
```

**Exemplo:**
```sql
SELECT COUNT(*) AS total_payments
FROM payment;
```
**Resultado:** Retorna o número total de linhas na tabela `payment`.

### `SUM()` — Calcula a soma dos valores

**Sintaxe:**
```sql
SUM(expressão)
```

**Exemplo:**
```sql
SELECT SUM(amount) AS total_amount
FROM payment;
```
**Resultado:** Retorna a soma total da coluna `amount`.

### `AVG()` — Calcula o valor médio

**Sintaxe:**
```sql
AVG(expressão)
```

**Exemplo:**
```sql
SELECT AVG(amount) AS average_amount
FROM payment;
```
**Resultado:** Retorna o valor médio da coluna `amount`.

### `MIN()` — Encontra o valor mínimo

**Sintaxe:**
```sql
MIN(expressão)
```

**Exemplo:**
```sql
SELECT MIN(amount) AS min_amount
FROM payment;
```
**Resultado:** Retorna o menor valor na coluna `amount`.

### `MAX()` — Encontra o valor máximo

**Sintaxe:**
```sql
MAX(expressão)
```

**Exemplo:**
```sql
SELECT MAX(amount) AS max_amount
FROM payment;
```
**Resultado:** Retorna o maior valor na coluna `amount`.

## Aplicações Práticas

1. **Contando o número de clientes:**
   Use `COUNT(customer_id)` para descobrir quantos clientes existem no banco de dados.
   ```sql
   SELECT COUNT(customer_id) AS total_customers
   FROM customer;
   ```
2. **Calculando o total de vendas por funcionário:**
   Use `SUM(amount)` com `GROUP BY staff_id` para ver as vendas de cada funcionário.
   ```sql
   SELECT staff_id, SUM(amount) AS staff_total
   FROM payment
   GROUP BY staff_id;
   ```
3. **Encontrando o pagamento médio por cliente:**
   Use `AVG(amount)` com `GROUP BY customer_id`.
   ```sql
   SELECT customer_id, AVG(amount) AS avg_payment
   FROM payment
   GROUP BY customer_id;
   ```

## Principais Conclusões desta Lição

As funções de agregação do SQL são ferramentas poderosas para resumir e analisar dados. Dominar `COUNT`, `SUM`, `AVG`, `MIN` e `MAX` ajudará você a gerar relatórios e insights valiosos do seu banco de dados. Pratique essas funções com o banco de dados Sakila para fortalecer suas habilidades em SQL.
