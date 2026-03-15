# Lesson 4.4: Conditional Aggregation with `CASE WHEN ... THEN ... END` in SQL

Conditional aggregation in SQL lets you calculate multiple metrics in a single query instead of running several separate queries. The idea is simple: use `CASE` inside an aggregate function (`SUM`, `COUNT`, `AVG`) so that only rows matching a condition are included in a metric.

This approach is especially useful for reporting, dashboards, and analytics where you need multiple KPIs at once: counts, totals, shares, status splits, and more.

In this lesson, we will cover:

- how conditional aggregation works;
- how to calculate conditional counts and sums;
- how to build pivot-style reports (turning rows into columns) with `CASE`.

## Core Idea

Classic conditional aggregation pattern:

```sql
SUM(CASE WHEN condition THEN value ELSE 0 END)
```

or for counting rows:

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END)
```

What happens here:

- `CASE` returns a value only for matching rows;
- the aggregate function sums results per group;
- the final output is a metric based on your condition.

## Conditional Counting

### Example: number of payments in each amount range

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

**Result:** for each customer, the query returns the count of low, medium, and high payments.

## Conditional Sum

### Example: sales totals per staff split by amount category

```sql
SELECT
    staff_id,
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END) AS low_amount_total,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN amount ELSE 0 END) AS medium_amount_total,
    SUM(CASE WHEN amount > 6 THEN amount ELSE 0 END) AS high_amount_total
FROM payment
GROUP BY staff_id;
```

**Result:** one query returns three different totals per staff member.

## Conditional Aggregation with `COUNT()`

Conditional counts can also be calculated with `COUNT`, not only with `SUM(...1/0...)`:

```sql
COUNT(CASE WHEN condition THEN 1 END)
```

This is also valid because `COUNT` includes only non-`NULL` values.

### Example: counting returned vs not returned rentals

```sql
SELECT
    staff_id,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count,
    COUNT(CASE WHEN return_date IS NOT NULL THEN 1 END) AS returned_count
FROM rental
GROUP BY staff_id;
```

## Pivot Technique with `CASE`

### What is a pivot in SQL

A pivot transforms rows into columns. Source data often stores categories as row values, while reports usually require those categories as separate columns.

Some DBMSs provide a dedicated `PIVOT` operator, but the most universal and portable approach is conditional aggregation with `CASE`.

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

In the example below, for each film category we count films by rating into separate columns:

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

**Result:** each row is a category, and `rating_*` columns show the distribution of films by rating.

## Practical Recommendations

- Always use `ELSE 0` in numeric aggregations to avoid unexpected `NULL` values.
- If you have many conditional metrics, use clear aliases (`*_count`, `*_total`).
- Ensure `CASE` conditions do not overlap when categories must be mutually exclusive.
- For large queries, test logic first on a small dataset or with `LIMIT`.

## Practical Usage

1. **Payment report in one query:**
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

2. **Pivot by weekday (idea):**
   count orders for each weekday into separate columns using `SUM(CASE WHEN weekday = ... THEN 1 ELSE 0 END)`.

3. **Conditional share calculation:**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

## Key Takeaways from This Lesson

- Conditional aggregation is an aggregate function plus `CASE`.
- With `SUM(CASE ...)` and `COUNT(CASE ...)`, you can compute multiple metrics in one query.
- Pivot via `CASE` is a universal technique for turning rows into columns.
- This approach is ideal for analytical reports and dashboards.

By mastering conditional aggregation, you can write more compact and expressive SQL queries for business analytics.
