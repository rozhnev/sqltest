# Урок 4.4: Условная агрегация

Условная агрегация в SQL позволяет считать разные метрики в одном запросе, не делая несколько отдельных выборок. Идея проста: внутри агрегатной функции (`SUM`, `COUNT`, `AVG`) используется условное выражение (чаще всего `CASE`, но в некоторых СУБД это может быть и другой условный оператор), которое включает в расчет только те строки, что соответствуют условию.

Этот подход особенно полезен для отчетов, дашбордов и аналитики, где нужно получить несколько показателей сразу: количества, суммы, доли, разбивки по статусам и т.д.

В этом уроке разберем:

- как работает условная агрегация;
- как считать условные количества, суммы и средние значения;
- как строить pivot-отчеты (поворот строк в колонки) через `CASE`.

## Базовая идея

Классический шаблон условной агрегации:

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN value ELSE 0 END)
```

или короткий вариант:

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN 1 END)
```

Что происходит:

- `CASE` возвращает значение в зависимости от условия. В коротком варианте если условие не выполняется - возвращается `NULL`;
- агрегатная функция аккумулирует результат по группе;
- на выходе вы получаете метрику по условию.


## Условная сумма

### Пример: суммы продаж по сотрудникам с разбивкой по категориям суммы

```sql
SELECT
    staff_id,
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END) AS low_amount_total,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN amount ELSE 0 END) AS medium_amount_total,
    SUM(CASE WHEN amount > 6 THEN amount ELSE 0 END) AS high_amount_total
FROM payment
GROUP BY staff_id;
```

**Результат:** один запрос возвращает три разных суммы по каждому сотруднику.

## Условное среднее

### Пример: средняя сумма крупных платежей по сотрудникам

```sql
SELECT
    staff_id,
    AVG(CASE WHEN amount >= 5 THEN amount END) AS avg_big_payment
FROM payment
GROUP BY staff_id;
```

**Результат:** для каждого сотрудника считается средняя сумма только тех платежей, где `amount >= 5`.

Почему здесь обычно не нужен `ELSE 0`:

- `AVG` вычисляется как сумма значений, деленная на их количество;
- если подставить `0` для строк, которые не подходят под условие, эти нули попадут в расчет и занизят среднее;
- поэтому для условного `AVG` обычно используют `ELSE NULL` или не указывают `ELSE` совсем.

## Условный подсчет количества

### Пример: сколько платежей в каждом диапазоне суммы

```sql
SELECT
    customer_id,
    COUNT(CASE WHEN amount < 2 THEN 1 END) AS low_payments,
    COUNT(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 END) AS medium_payments,
    COUNT(CASE WHEN amount > 6 THEN 1 END) AS high_payments
FROM payment
GROUP BY customer_id;
```

**Результат:** для каждого клиента выводится число «низких», «средних» и «высоких» платежей.

Почему здесь не нужен `ELSE`:

- если условие истинно, `CASE` возвращает `1`;
- если условие ложно и `ELSE` не указан, `CASE` возвращает `NULL`;
- `COUNT(expression)` считает только не-`NULL`, поэтому учитываются только строки, где условие выполнилось.

Важно: не стоит писать `ELSE 0` в таком шаблоне для `COUNT`, потому что `0` тоже не `NULL`, и тогда `COUNT` начнет считать почти все строки.

### Пример: подсчет возвращенных и невозвращенных аренд

```sql
SELECT
    staff_id,
    COUNT(return_date) AS returned_count,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count
FROM rental
GROUP BY staff_id;
```

Что здесь происходит:

- `COUNT(return_date)` считает только не-`NULL` значения, то есть количество возвращенных аренд;
- `COUNT(CASE WHEN return_date IS NULL THEN 1 END)` считает только строки, где дата возврата отсутствует, то есть невозвращенные аренды;
- `GROUP BY staff_id` формирует отдельные счетчики для каждого сотрудника.

Итог: в одном запросе вы получаете обе метрики по каждому сотруднику.

## Pivot-техника через `CASE`

### Что такое pivot в SQL

Pivot (поворот) — это преобразование строк в колонки. Обычно исходные данные содержат категории в строках, а в отчете нужно видеть эти категории как отдельные столбцы.

Во многих СУБД есть специальный оператор `PIVOT`, но универсальный и переносимый способ — условная агрегация с `CASE`.

### Базовый шаблон pivot

```sql
SELECT
    group_column,
    SUM(CASE WHEN pivot_key = 'A' THEN measure ELSE 0 END) AS col_a,
    SUM(CASE WHEN pivot_key = 'B' THEN measure ELSE 0 END) AS col_b,
    SUM(CASE WHEN pivot_key = 'C' THEN measure ELSE 0 END) AS col_c
FROM source_table
GROUP BY group_column;
```

### Пример: pivot по рейтингу фильмов

Ниже пример, где для каждой категории фильмов считаем количество фильмов по рейтингам в отдельных столбцах:

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

**Результат:** каждая строка — это категория, а столбцы показывают количество фильмов каждого рейтинга и их среднюю продолжительность.

## Практические рекомендации

- Для `SUM` обычно используют `ELSE 0`, чтобы строки вне условия давали нулевой вклад.
- Для `COUNT(CASE ...)` `ELSE` обычно не нужен: `COUNT` и так игнорирует `NULL`.
- Для `AVG(CASE ...)` чаще используют `ELSE NULL` или вариант без `ELSE`, чтобы не занизить среднее.
- Если условных метрик много, давайте столбцам понятные алиасы (`*_count`, `*_total`).
- Проверяйте, что условия в `CASE` не пересекаются, если категории должны быть взаимоисключающими (комбинация условий из CASE и GROUP BY должна обеспечивать уникальность).
- Для больших запросов сначала отладьте логику на маленьком наборе данных или с `LIMIT`.

## Практическое применение

1. **Pivot по дням недели:**
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
    Такой запрос показывает, сколько аренд было оформлено в каждом месяце по дням недели.

2. **Расчет долей по условию:**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

### Коротко про синтаксис `FILTER`

В некоторых СУБД (например, PostgreSQL) условие можно вынести из `CASE` в `FILTER`:

```sql
COUNT(*) FILTER (WHERE condition)
SUM(amount) FILTER (WHERE condition)
```

Смысл здесь тот же, что и у условной агрегации через `CASE`: агрегатная функция обрабатывает не все строки, а только те, которые прошли условие в `WHERE` внутри `FILTER`.

Такой синтаксис часто читается проще, особенно если в одном `SELECT` нужно посчитать несколько разных метрик с разными условиями.

Например:

```sql
SELECT
    customer_id,
    COUNT(*) AS total_payments,
    COUNT(*) FILTER (WHERE amount >= 5) AS big_payments_count,
    SUM(amount) FILTER (WHERE amount >= 5) AS big_payments_total
FROM payment
GROUP BY customer_id;
```

В этом примере:

- `COUNT(*)` считает все платежи клиента;
- `COUNT(*) FILTER (WHERE amount >= 5)` считает только «крупные» платежи;
- `SUM(amount) FILTER (WHERE amount >= 5)` суммирует только такие платежи.

То есть `FILTER` делает ту же работу, что и `CASE`, но в более компактной форме. При этом важно помнить, что этот синтаксис поддерживается не всеми СУБД.

## Основные выводы из этого урока

- Условная агрегация — это агрегатная функция + условное выражение, чаще всего `CASE`.
- Через `SUM(CASE ...)`, `COUNT(CASE ...)` и `AVG(CASE ...)` можно получать несколько метрик в одном запросе.
- Pivot-техника через `CASE` — универсальный способ развернуть строки в колонки.
- Этот подход хорошо подходит для аналитических отчетов и дашбордов.

Освоив условную агрегацию, вы сможете писать более компактные и выразительные SQL-запросы для бизнес-аналитики.
