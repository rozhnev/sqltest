# Aula 4.4: Agregação condicional

A agregação condicional em SQL permite calcular várias métricas em uma única consulta, sem executar várias consultas separadas. A ideia é simples: dentro de uma função de agregação (`SUM`, `COUNT`, `AVG`), usa-se uma expressão condicional (na maioria das vezes `CASE`, mas em alguns SGBDs pode ser outro operador condicional) que inclui no cálculo apenas as linhas que atendem à condição.

Essa abordagem é especialmente útil para relatórios, dashboards e análises, quando você precisa obter vários indicadores ao mesmo tempo: contagens, somas, proporções, divisões por status etc.

Nesta aula, vamos ver:

- como a agregação condicional funciona;
- como calcular contagens, somas e médias condicionais;
- como construir relatórios no estilo pivot (transformar linhas em colunas) com `CASE`.

## Ideia básica

Modelo clássico de agregação condicional:

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN value ELSE 0 END)
```

ou versão curta:

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN 1 END)
```

O que acontece:

- `CASE` retorna um valor de acordo com a condição. Na versão curta, se a condição não for atendida, ele retorna `NULL`;
- a função de agregação acumula o resultado por grupo;
- na saída, você obtém uma métrica baseada na condição.

## Soma condicional

### Exemplo: somas de vendas por funcionário com divisão por faixas de valor

```sql
SELECT
    staff_id,
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END) AS low_amount_total,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN amount ELSE 0 END) AS medium_amount_total,
    SUM(CASE WHEN amount > 6 THEN amount ELSE 0 END) AS high_amount_total
FROM payment
GROUP BY staff_id;
```

**Resultado:** uma consulta retorna três somas diferentes para cada funcionário.

## Média condicional

### Exemplo: valor médio de pagamentos altos por funcionário

```sql
SELECT
    staff_id,
    AVG(CASE WHEN amount >= 5 THEN amount END) AS avg_big_payment
FROM payment
GROUP BY staff_id;
```

**Resultado:** para cada funcionário, calcula-se o valor médio apenas dos pagamentos em que `amount >= 5`.

Por que `ELSE 0` normalmente não é necessário aqui:

- `AVG` é calculado como a soma dos valores dividida pela quantidade deles;
- se colocar `0` para linhas que não atendem à condição, esses zeros entram no cálculo e reduzem a média;
- por isso, em `AVG` condicional, normalmente usa-se `ELSE NULL` ou não se informa `ELSE`.

## Contagem condicional

### Exemplo: quantos pagamentos em cada faixa de valor

```sql
SELECT
    customer_id,
    COUNT(CASE WHEN amount < 2 THEN 1 END) AS low_payments,
    COUNT(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 END) AS medium_payments,
    COUNT(CASE WHEN amount > 6 THEN 1 END) AS high_payments
FROM payment
GROUP BY customer_id;
```

**Resultado:** para cada cliente, a consulta retorna o número de pagamentos “baixos”, “médios” e “altos”.

Por que `ELSE` não é necessário aqui:

- se a condição for verdadeira, `CASE` retorna `1`;
- se a condição for falsa e `ELSE` não for informado, `CASE` retorna `NULL`;
- `COUNT(expression)` conta apenas valores não-`NULL`, então só entram as linhas em que a condição foi atendida.

Importante: não use `ELSE 0` nesse padrão com `COUNT`, porque `0` também não é `NULL`, e então `COUNT` passa a contar quase todas as linhas.

### Exemplo: contagem de aluguéis devolvidos e não devolvidos

```sql
SELECT
    staff_id,
    COUNT(return_date) AS returned_count,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count
FROM rental
GROUP BY staff_id;
```

O que acontece aqui:

- `COUNT(return_date)` conta apenas valores não-`NULL`, ou seja, quantidade de aluguéis devolvidos;
- `COUNT(CASE WHEN return_date IS NULL THEN 1 END)` conta apenas linhas em que a data de devolução está ausente, ou seja, aluguéis não devolvidos;
- `GROUP BY staff_id` forma contadores separados para cada funcionário.

Resultado: em uma única consulta, você obtém as duas métricas para cada funcionário.

## Técnica de pivot com `CASE`

### O que é pivot em SQL

Pivot (rotação) é a transformação de linhas em colunas. Normalmente, os dados de origem têm categorias em linhas, mas no relatório você precisa ver essas categorias como colunas separadas.

Em muitos SGBDs existe um operador especial `PIVOT`, mas a forma universal e portátil é a agregação condicional com `CASE`.

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

Abaixo, para cada categoria de filmes, contamos a quantidade de filmes por classificação em colunas separadas:

```sql
SELECT
    c.name AS category,
    COUNT(CASE WHEN f.rating = 'G' THEN 1 END) AS g_films_count,
    AVG(CASE WHEN f.rating = 'G' THEN length ELSE 0 END) AS g_films_average_length,
    COUNT(CASE WHEN f.rating = 'PG' THEN 1 END) AS pg_films_count,
    AVG(CASE WHEN f.rating = 'PG' THEN length ELSE 0 END) AS pg_films_average_length,
    COUNT(CASE WHEN f.rating = 'PG-13' THEN 1 END) AS pg13_films_count,
    AVG(CASE WHEN f.rating = 'PG-13' THEN length ELSE 0 END) AS pg13_films_average_length,
    COUNT(CASE WHEN f.rating = 'R' THEN 1 END) AS r_films_count,
    AVG(CASE WHEN f.rating = 'R' THEN length ELSE 0 END) AS r_films_average_length,
    COUNT(CASE WHEN f.rating = 'NC-17' THEN 1 END) AS nc17_films_rating,
    AVG(CASE WHEN f.rating = 'NC-17' THEN length ELSE 0 END) AS nc17_films_average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name;
```

**Resultado:** cada linha é uma categoria, e as colunas mostram a quantidade de filmes de cada classificação e sua duração média.

## Recomendações práticas

- Para `SUM`, geralmente usa-se `ELSE 0`, para que linhas fora da condição deem contribuição zero.
- Para `COUNT(CASE ...)`, `ELSE` normalmente não é necessário: `COUNT` já ignora `NULL`.
- Para `AVG(CASE ...)`, usa-se com mais frequência `ELSE NULL` ou versão sem `ELSE`, para não reduzir a média.
- Se houver muitas métricas condicionais, dê aliases claros às colunas (`*_count`, `*_total`).
- Verifique se as condições em `CASE` não se sobrepõem, quando as categorias devem ser mutuamente exclusivas.
- Para consultas grandes, primeiro valide a lógica em um conjunto pequeno de dados ou com `LIMIT`.

## Aplicação prática

1. **Pivot por dias da semana:**
    ```sql
    SELECT
        MONTH(rental_date) AS rental_month,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Monday' THEN 1 ELSE 0 END) AS monday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Tuesday' THEN 1 ELSE 0 END) AS tuesday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Wednesday' THEN 1 ELSE 0 END) AS wednesday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Thursday' THEN 1 ELSE 0 END) AS thursday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Friday' THEN 1 ELSE 0 END) AS friday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Saturday' THEN 1 ELSE 0 END) AS saturday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Sunday' THEN 1 ELSE 0 END) AS sunday_rentals
    FROM rental
    GROUP BY MONTH(rental_date);
    ```
    Essa consulta mostra quantos aluguéis foram feitos em cada mês por dia da semana.

2. **Cálculo de proporções por condição:**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

### Brevemente sobre a sintaxe `FILTER`

Em alguns SGBDs (por exemplo, PostgreSQL), a condição pode ser movida de `CASE` para `FILTER`:

```sql
COUNT(*) FILTER (WHERE condition)
SUM(amount) FILTER (WHERE condition)
```

O sentido aqui é o mesmo da agregação condicional com `CASE`: a função de agregação processa não todas as linhas, mas apenas as que passaram na condição do `WHERE` dentro de `FILTER`.

Essa sintaxe costuma ser mais fácil de ler, especialmente se em um mesmo `SELECT` você precisa calcular várias métricas diferentes com condições diferentes.

Por exemplo:

```sql
SELECT
    customer_id,
    COUNT(*) AS total_payments,
    COUNT(*) FILTER (WHERE amount >= 5) AS big_payments_count,
    SUM(amount) FILTER (WHERE amount >= 5) AS big_payments_total
FROM payment
GROUP BY customer_id;
```

Nesse exemplo:

- `COUNT(*)` conta todos os pagamentos do cliente;
- `COUNT(*) FILTER (WHERE amount >= 5)` conta apenas os pagamentos “grandes”;
- `SUM(amount) FILTER (WHERE amount >= 5)` soma apenas esses pagamentos.

Ou seja, `FILTER` faz o mesmo trabalho que `CASE`, mas em uma forma mais compacta. Ao mesmo tempo, é importante lembrar que essa sintaxe não é suportada por todos os SGBDs.

## Principais conclusões desta aula

- Agregação condicional é uma função de agregação + expressão condicional, na maioria das vezes `CASE`.
- Com `SUM(CASE ...)`, `COUNT(CASE ...)` e `AVG(CASE ...)`, você pode obter várias métricas em uma única consulta.
- Pivot com `CASE` é uma forma universal de transformar linhas em colunas.
- Essa abordagem é bem adequada para relatórios analíticos e dashboards.

Ao dominar a agregação condicional, você conseguirá escrever consultas SQL mais compactas e expressivas para análise de negócios.
