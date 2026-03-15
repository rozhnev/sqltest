# Aula 4.4: Agregação condicional com `CASE WHEN ... THEN ... END` em SQL

A agregação condicional em SQL permite calcular várias métricas em uma única consulta, sem precisar executar várias consultas separadas. A ideia é simples: usar `CASE` dentro de uma função de agregação (`SUM`, `COUNT`, `AVG`) para incluir no cálculo apenas as linhas que atendem a uma condição.

Essa abordagem é especialmente útil para relatórios, dashboards e análises, quando você precisa obter vários indicadores de uma vez: contagens, somas, proporções, divisões por status e mais.

Nesta lição, vamos ver:

- como a agregação condicional funciona;
- como calcular contagens e somas condicionais;
- como construir relatórios no estilo pivot (transformar linhas em colunas) com `CASE`.

## Ideia básica

Modelo clássico de agregação condicional:

```sql
SUM(CASE WHEN condition THEN value ELSE 0 END)
```

ou, para contar linhas:

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END)
```

O que acontece:

- `CASE` retorna valor apenas para as linhas que correspondem à condição;
- a função de agregação soma os resultados por grupo;
- a saída final é uma métrica baseada na condição.

## Contagem condicional

### Exemplo: quantidade de pagamentos em cada faixa de valor

```sql
SELECT
    customer_id,
    SUM(CASE WHEN amount < 2 THEN 1 ELSE 0 END) AS low_payments,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 ELSE 0 END) AS medium_payments,
    SUM(CASE WHEN amount > 6 THEN 1 ELSE 0 END) AS high_payments
FROM payment
GROUP BY customer_id
LIMIT 20;
```

**Resultado:** para cada cliente, a consulta retorna a quantidade de pagamentos baixos, médios e altos.

## Soma condicional

### Exemplo: totais de vendas por funcionário com divisão por faixa de valor

```sql
SELECT
    staff_id,
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END) AS low_amount_total,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN amount ELSE 0 END) AS medium_amount_total,
    SUM(CASE WHEN amount > 6 THEN amount ELSE 0 END) AS high_amount_total
FROM payment
GROUP BY staff_id;
```

**Resultado:** uma única consulta retorna três totais diferentes por funcionário.

## Agregação condicional com `COUNT()`

As contagens condicionais também podem ser feitas com `COUNT`, não apenas com `SUM(...1/0...)`:

```sql
COUNT(CASE WHEN condition THEN 1 END)
```

Essa forma também é válida, porque `COUNT` considera somente valores não-`NULL`.

### Exemplo: contar aluguéis devolvidos e não devolvidos

```sql
SELECT
    staff_id,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count,
    COUNT(CASE WHEN return_date IS NOT NULL THEN 1 END) AS returned_count
FROM rental
GROUP BY staff_id;
```

## Técnica de pivot com `CASE`

### O que é pivot em SQL

Pivot é a transformação de linhas em colunas. Em muitos casos, os dados de origem guardam categorias em linhas, mas o relatório precisa dessas categorias como colunas separadas.

Alguns SGBDs têm operador `PIVOT`, mas a forma mais universal e portável é a agregação condicional com `CASE`.

### Modelo básico de pivot

```sql
SELECT
    group_column,
    SUM(CASE WHEN pivot_key = 'A' THEN measure ELSE 0 END) AS col_a,
    SUM(CASE WHEN pivot_key = 'B' THEN measure ELSE 0 END) AS col_b,
    SUM(CASE WHEN pivot_key = 'C' THEN measure ELSE 0 END) AS col_c
FROM source_table
GROUP BY group_column;
```

### Exemplo: pivot por classificação de filmes

No exemplo abaixo, para cada categoria de filmes, contamos quantos filmes há em cada classificação em colunas separadas:

```sql
SELECT
    c.name AS category,
    SUM(CASE WHEN f.rating = 'G' THEN 1 ELSE 0 END) AS rating_g,
    SUM(CASE WHEN f.rating = 'PG' THEN 1 ELSE 0 END) AS rating_pg,
    SUM(CASE WHEN f.rating = 'PG-13' THEN 1 ELSE 0 END) AS rating_pg13,
    SUM(CASE WHEN f.rating = 'R' THEN 1 ELSE 0 END) AS rating_r,
    SUM(CASE WHEN f.rating = 'NC-17' THEN 1 ELSE 0 END) AS rating_nc17
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name;
```

**Resultado:** cada linha representa uma categoria, e as colunas `rating_*` mostram a distribuição dos filmes por classificação.

## Recomendações práticas

- Sempre use `ELSE 0` em agregações numéricas para evitar `NULL` inesperado.
- Se houver muitas métricas condicionais, use aliases claros (`*_count`, `*_total`).
- Verifique se as condições do `CASE` não se sobrepõem quando as categorias devem ser mutuamente exclusivas.
- Em consultas grandes, valide a lógica primeiro em um conjunto pequeno ou com `LIMIT`.

## Aplicações práticas

1. **Relatório de pagamentos em uma única consulta:**
   ```sql
   SELECT
       staff_id,
       COUNT(*) AS payments_total,
       SUM(amount) AS amount_total,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) AS big_payment_count,
       SUM(CASE WHEN amount >= 5 THEN amount ELSE 0 END) AS big_payment_total
   FROM payment
   GROUP BY staff_id;
   ```

2. **Pivot por dia da semana (ideia):**
   contar pedidos por dia da semana em colunas separadas com `SUM(CASE WHEN weekday = ... THEN 1 ELSE 0 END)`.

3. **Cálculo de proporção condicional:**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

## Principais conclusões desta lição

- Agregação condicional = função de agregação + `CASE`.
- Com `SUM(CASE ...)` e `COUNT(CASE ...)`, você calcula várias métricas em uma consulta.
- Pivot com `CASE` é uma técnica universal para transformar linhas em colunas.
- Essa abordagem é ideal para relatórios analíticos e dashboards.

Ao dominar agregação condicional, você consegue escrever consultas SQL mais compactas e expressivas para análise de negócio.
