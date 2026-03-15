# Урок 4.4: Условная агрегация через `CASE WHEN ... THEN ... END` в SQL

Условная агрегация в SQL позволяет считать разные метрики в одном запросе, не делая несколько отдельных выборок. Идея проста: внутри агрегатной функции (`SUM`, `COUNT`, `AVG`) используется `CASE`, который включает в расчет только те строки, что соответствуют условию.

Этот подход особенно полезен для отчетов, дашбордов и аналитики, где нужно получить несколько показателей сразу: количества, суммы, доли, разбивки по статусам и т.д.

В этом уроке разберем:

- как работает условная агрегация;
- как считать условные количества и суммы;
- как строить pivot-отчеты (поворот строк в колонки) через `CASE`.

## Базовая идея

Классический шаблон условной агрегации:

```sql
SUM(CASE WHEN condition THEN value ELSE 0 END)
```

или для подсчета количества:

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END)
```

Что происходит:

- `CASE` возвращает значение только для нужных строк;
- агрегатная функция суммирует результат по группе;
- на выходе вы получаете метрику по условию.

## Условный подсчет количества

### Пример: сколько платежей в каждом диапазоне суммы

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

**Результат:** для каждого клиента выводится число «низких», «средних» и «высоких» платежей.

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

## Условная агрегация + `COUNT()`

Условные количества можно считать не только через `SUM(...1/0...)`, но и через `COUNT`:

```sql
COUNT(CASE WHEN condition THEN 1 END)
```

Такой вариант тоже корректен: `COUNT` считает только не-`NULL` значения.

### Пример: подсчет возвращенных и невозвращенных аренд

```sql
SELECT
    staff_id,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count,
    COUNT(CASE WHEN return_date IS NOT NULL THEN 1 END) AS returned_count
FROM rental
GROUP BY staff_id;
```

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

**Результат:** каждая строка — это категория, а столбцы `rating_*` показывают распределение фильмов по рейтингам.

## Практические рекомендации

- Всегда указывайте `ELSE 0` в числовых агрегациях, чтобы избежать неожиданных `NULL`.
- Если условных метрик много, давайте столбцам понятные алиасы (`*_count`, `*_total`).
- Проверяйте, что условия в `CASE` не пересекаются, если категории должны быть взаимоисключающими.
- Для больших запросов сначала отладьте логику на маленьком наборе данных или с `LIMIT`.

## Практическое применение

1. **Отчет по платежам в одном запросе:**
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

2. **Pivot по дням недели (идея):**
   можно считать количество заказов по каждому дню недели в отдельных колонках через `SUM(CASE WHEN weekday = ... THEN 1 ELSE 0 END)`.

3. **Расчет долей по условию:**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

## Основные выводы из этого урока

- Условная агрегация — это агрегатная функция + `CASE`.
- Через `SUM(CASE ...)` и `COUNT(CASE ...)` можно получать несколько метрик в одном запросе.
- Pivot-техника через `CASE` — универсальный способ развернуть строки в колонки.
- Этот подход хорошо подходит для аналитических отчетов и дашбордов.

Освоив условную агрегацию, вы сможете писать более компактные и выразительные SQL-запросы для бизнес-аналитики.
