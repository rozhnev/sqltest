# Lesson 4.4: Conditional Aggregation

Conditional aggregation in SQL lets you calculate multiple metrics in one query without running several separate queries. The idea is simple: inside an aggregate function (`SUM`, `COUNT`, `AVG`), you use a conditional expression (most often `CASE`, but in some DBMSs it can be another conditional operator) that includes only rows matching a condition in the calculation.

This approach is especially useful for reports, dashboards, and analytics where you need several indicators at once: counts, sums, shares, status breakdowns, and so on.

In this lesson, we will cover:

- how conditional aggregation works;
- how to calculate conditional counts, sums, and averages;
- how to build pivot-style reports (turning rows into columns) with `CASE`.

## Core Idea

Classic conditional aggregation template:

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN value ELSE 0 END)
```

or a short version:

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN 1 END)
```

What happens:

- `CASE` returns a value depending on the condition. In the short version, if the condition is not met, it returns `NULL`;
- the aggregate function accumulates the result per group;
- the output is a metric based on the condition.

## Conditional Sum

### Example: sales totals per staff split by amount ranges

```sql
SELECT
    staff_id,
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END) AS low_amount_total,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN amount ELSE 0 END) AS medium_amount_total,
    SUM(CASE WHEN amount > 6 THEN amount ELSE 0 END) AS high_amount_total
FROM payment
GROUP BY staff_id;
```

**Result:** one query returns three different sums for each staff member.

## Conditional Average

### Example: average amount of large payments by staff

```sql
SELECT
    staff_id,
    AVG(CASE WHEN amount >= 5 THEN amount END) AS avg_big_payment
FROM payment
GROUP BY staff_id;
```

**Result:** for each staff member, the average amount is calculated only for payments where `amount >= 5`.

Why `ELSE 0` is usually not needed here:

- `AVG` is computed as the sum of values divided by their count;
- if you put `0` for rows that do not meet the condition, those zeros will be included and lower the average;
- that is why conditional `AVG` usually uses `ELSE NULL` or omits `ELSE` entirely.

## Conditional Counting

### Example: number of payments in each amount range

```sql
SELECT
    customer_id,
    COUNT(CASE WHEN amount < 2 THEN 1 END) AS low_payments,
    COUNT(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 END) AS medium_payments,
    COUNT(CASE WHEN amount > 6 THEN 1 END) AS high_payments
FROM payment
GROUP BY customer_id;
```

**Result:** for each customer, the query returns the number of low, medium, and high payments.

Why `ELSE` is not needed here:

- if the condition is true, `CASE` returns `1`;
- if the condition is false and `ELSE` is not specified, `CASE` returns `NULL`;
- `COUNT(expression)` counts only non-`NULL` values, so only rows where the condition is true are included.

Important: do not use `ELSE 0` in this pattern for `COUNT`, because `0` is also not `NULL`, and then `COUNT` starts counting almost all rows.

### Example: counting returned and not returned rentals

```sql
SELECT
    staff_id,
    COUNT(return_date) AS returned_count,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count
FROM rental
GROUP BY staff_id;
```

What happens here:

- `COUNT(return_date)` counts only non-`NULL` values, that is the number of returned rentals;
- `COUNT(CASE WHEN return_date IS NULL THEN 1 END)` counts only rows where the return date is missing, that is not returned rentals;
- `GROUP BY staff_id` builds separate counters for each staff member.

Result: in one query, you get both metrics for each staff member.

## Pivot Technique with `CASE`

### What is pivot in SQL

A pivot transforms rows into columns. Usually, source data contains categories in rows, but in a report you need those categories as separate columns.

Many DBMSs have a dedicated `PIVOT` operator, but the universal and portable way is conditional aggregation with `CASE`.

### Basic pivot template

```sql
SELECT
    group_column,
    SUM(CASE WHEN pivot_key = 'A' THEN measure ELSE 0 END) AS col_a,
    SUM(CASE WHEN pivot_key = 'B' THEN measure ELSE 0 END) AS col_b,
    SUM(CASE WHEN pivot_key = 'C' THEN measure ELSE 0 END) AS col_c
FROM source_table
GROUP BY group_column;
```

### Example: pivot by film rating

Below is an example where, for each film category, we count films by rating in separate columns:

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

**Result:** each row is a category, and the columns show the number of films of each rating and their average duration.

## Practical Recommendations

- For `SUM`, `ELSE 0` is usually used so rows outside the condition give zero contribution.
- For `COUNT(CASE ...)`, `ELSE` is usually not needed: `COUNT` already ignores `NULL`.
- For `AVG(CASE ...)`, `ELSE NULL` or no `ELSE` is used more often so the average is not lowered.
- If there are many conditional metrics, use clear aliases (`*_count`, `*_total`).
- Check that `CASE` conditions do not overlap when categories should be mutually exclusive.
- For large queries, validate the logic first on a small dataset or with `LIMIT`.

## Practical Usage

1. **Pivot by weekday:**
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
    This query shows how many rentals were made in each month by weekday.

2. **Conditional share calculation:**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

### Quick Note on `FILTER` Syntax

In some DBMSs (for example, PostgreSQL), you can move the condition from `CASE` into `FILTER`:

```sql
COUNT(*) FILTER (WHERE condition)
SUM(amount) FILTER (WHERE condition)
```

The meaning is the same as conditional aggregation with `CASE`: the aggregate function processes not all rows, but only rows that pass the condition in `WHERE` inside `FILTER`.

This syntax is often easier to read, especially if in one `SELECT` you need to calculate several different metrics with different conditions.

For example:

```sql
SELECT
    customer_id,
    COUNT(*) AS total_payments,
    COUNT(*) FILTER (WHERE amount >= 5) AS big_payments_count,
    SUM(amount) FILTER (WHERE amount >= 5) AS big_payments_total
FROM payment
GROUP BY customer_id;
```

In this example:

- `COUNT(*)` counts all customer payments;
- `COUNT(*) FILTER (WHERE amount >= 5)` counts only large payments;
- `SUM(amount) FILTER (WHERE amount >= 5)` sums only those payments.

So, `FILTER` does the same work as `CASE`, but in a more compact form. At the same time, it is important to remember that this syntax is not supported by all DBMSs.

## Key Takeaways from This Lesson

- Conditional aggregation is an aggregate function plus a conditional expression, most often `CASE`.
- With `SUM(CASE ...)`, `COUNT(CASE ...)`, and `AVG(CASE ...)`, you can get several metrics in one query.
- Pivot with `CASE` is a universal way to turn rows into columns.
- This approach is well suited for analytical reports and dashboards.

By mastering conditional aggregation, you will be able to write more compact and expressive SQL queries for business analytics.
