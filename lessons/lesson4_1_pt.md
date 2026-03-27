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

### `COUNT(column)` vs `COUNT(*)`

Essas duas formas são parecidas, mas não são iguais:

- `COUNT(*)` conta **todas as linhas** do conjunto de resultados;
- `COUNT(column)` conta apenas as linhas em que `column` é **NOT NULL**.

Por isso, se a coluna tiver valores `NULL`, `COUNT(column)` pode retornar um número menor que `COUNT(*)`.

**Exemplo (Sakila):**
```sql
SELECT
   COUNT(*) AS total_rentals,
   COUNT(return_date) AS returned_rentals
FROM rental;
```

**Explicação:**

- `total_rentals` conta todas as linhas da tabela `rental`;
- `returned_rentals` conta apenas as linhas em que `return_date` possui valor;
- aluguéis ainda não devolvidos têm `return_date = NULL`, então ficam fora de `COUNT(return_date)`.

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

**Comentário:** a função `SUM(amount)` ignora `NULL`. Se todos os valores do conjunto forem `NULL`, o resultado será `NULL`.

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

**Comentário:** a função `AVG(amount)` considera no cálculo apenas as linhas em que `amount` não é `NULL`.

Se você precisar incluir as linhas com `NULL` na quantidade de linhas (denominador), use uma das opções abaixo:

```sql
SELECT
   AVG(amount) AS avg_ignore_null,
   AVG(COALESCE(amount, 0)) AS avg_include_null_as_zero,
   SUM(amount) / COUNT(*) AS avg_sum_div_all_rows
FROM payment;
```

**Explicação:**

- `avg_ignore_null` é o comportamento padrão de `AVG`, em que `NULL` é ignorado;
- `avg_include_null_as_zero` substitui `NULL` por `0`, então todas as linhas entram no cálculo;
- `avg_sum_div_all_rows` divide a soma pelo total de linhas (`COUNT(*)`), o que também inclui as linhas com `NULL` no denominador.

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

**Comentário:** a função `MAX(amount)` ignora `NULL`. Se todos os valores forem `NULL`, o resultado será `NULL`.

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

**Comentário:** a função `MIN(amount)` ignora `NULL`. Se todos os valores forem `NULL`, o resultado será `NULL`.

#### `MIN(column)` e `ORDER BY column LIMIT 1` — o resultado é sempre igual?

Nem sempre.

Compare:

```sql
SELECT MIN(column_name) FROM table_name;
SELECT column_name FROM table_name ORDER BY column_name LIMIT 1;
```

- `MIN(column_name)` ignora `NULL` e procura o menor valor entre os não `NULL`;
- `ORDER BY column_name LIMIT 1` retorna a primeira linha após a ordenação;
- se `NULL` for ordenado primeiro no seu SGBD (por exemplo, MySQL/MariaDB em `ASC`), a segunda consulta pode retornar `NULL`, enquanto `MIN()` retorna o menor valor não `NULL`.

Elas coincidem quando:

- não há `NULL` na coluna;
- ou `NULL` é ordenado por último;
- ou você exclui explicitamente os `NULL`.

**Versão confiável, equivalente a `MIN()`:**

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NOT NULL
ORDER BY column_name
LIMIT 1;
```

## Aplicações Práticas

1. **Contando o número de clientes:**
   Use `COUNT(*)` para descobrir quantos clientes existem no banco de dados.
   ```sql
   SELECT COUNT(*) AS total_customers
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
