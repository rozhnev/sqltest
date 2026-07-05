---
title: "Basic SQL Aggregate Functions: COUNT, SUM, AVG, MIN, and MAX"
description: "Learn core SQL aggregate functions with Sakila examples: COUNT, SUM, AVG, MIN, MAX, plus differences between COUNT(*), COUNT(column), and COUNT(DISTINCT ...)."
keywords: ["SQL aggregate functions", "COUNT", "SUM", "AVG", "MIN", "MAX", "COUNT DISTINCT"]
teaches: ["Use core aggregate functions in SELECT queries", "Explain differences between COUNT(*), COUNT(column), and COUNT(DISTINCT ...)", "Handle NULL values correctly in counts, sums, and averages"]
about: ["SQL", "Aggregation", "COUNT DISTINCT", "Sakila"]
---

_Reading time: ~8 minutes_

SQL aggregate functions help transform sets of rows into summary metrics: count, sum, average, minimum, and maximum. In this lesson, you will work through the most common aggregates using Sakila examples and learn how to choose the right counting approach for each task. By the end of the lesson, you will confidently use `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX` in analytical SQL.

# Basic Aggregate Functions in SQL

In previous lessons, you focused on selecting individual rows. Now we move to the next important step: computing summary values from data.

Aggregate functions are essential in reporting and analytics because they quickly answer questions like "how many?", "how much total?", and "what is the average?".

## Core Aggregate Functions

### COUNT() - counts rows

Basic syntax:

```sql
COUNT(expression)
```

Example:

```sql
SELECT COUNT(*) AS total_payments
FROM payment;
```

*Result: the query returns the total number of rows in the payment table.*

### COUNT(column) vs COUNT(*)

These forms look similar but behave differently:

- `COUNT(*)` counts all rows in the result set.
- `COUNT(column)` counts only rows where `column` is not `NULL`.

If a column contains `NULL`, `COUNT(column)` can be smaller than `COUNT(*)`.

```sql
SELECT
    COUNT(*) AS total_rentals,
    COUNT(return_date) AS returned_rentals
FROM rental;
```

*Explanation: total_rentals counts all rentals, while returned_rentals counts only rows where return_date is filled.*

### COUNT(DISTINCT ...) - counts unique values

When you need the number of unique values, not just the number of rows, use `COUNT(DISTINCT column)`.

```sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM payment;
```

*Result: the query returns how many unique customers made payments, even if one customer has many payment rows.*

In practice, this is important for questions like "how many different customers bought", where plain `COUNT(*)` would overcount because of repeated rows.

### SUM() - calculates a total

```sql
SELECT SUM(amount) AS total_amount
FROM payment;
```

*Result: returns the total sum of the amount column.*

`SUM(amount)` ignores `NULL`. If all values are `NULL`, the result is `NULL`.

### AVG() - calculates an average

```sql
SELECT AVG(amount) AS average_amount
FROM payment;
```

*Result: returns the average amount over non-NULL rows.*

If you need rows with `NULL` to affect the denominator, use one of these approaches:

```sql
SELECT
    AVG(amount) AS avg_ignore_null,
    AVG(COALESCE(amount, 0)) AS avg_include_null_as_zero,
    SUM(amount) / COUNT(*) AS avg_sum_div_all_rows
FROM payment;
```

### MAX() - finds the maximum value

```sql
SELECT MAX(amount) AS max_amount
FROM payment;
```

*Result: returns the largest value in amount.*

### MIN() - finds the minimum value

```sql
SELECT MIN(amount) AS min_amount
FROM payment;
```

*Result: returns the smallest value in amount.*

Both `MIN()` and `MAX()` ignore `NULL`. If all values are `NULL`, they return `NULL`.

### MIN(column) vs ORDER BY ... LIMIT 1

They are not always equivalent.

```sql
SELECT MIN(column_name)
FROM table_name;

SELECT column_name
FROM table_name
ORDER BY column_name
LIMIT 1;
```

- `MIN(column_name)` finds the minimum among non-`NULL` values.
- `ORDER BY ... LIMIT 1` returns the first row after sorting.
- If your DBMS sorts `NULL` first, the second query may return `NULL`, while `MIN()` still returns the minimum non-`NULL` value.

A reliable equivalent to `MIN()`:

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NOT NULL
ORDER BY column_name
LIMIT 1;
```

---

## Practical Usage

### Count customers

```sql
SELECT COUNT(*) AS total_customers
FROM customer;
```

### Total sales by staff member

```sql
SELECT
    staff_id,
    SUM(amount) AS staff_total
FROM payment
GROUP BY staff_id;
```

### Average payment by customer

```sql
SELECT
    customer_id,
    AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id;
```

### Count unique paying customers

```sql
SELECT COUNT(DISTINCT customer_id) AS paying_customers
FROM payment;
```

---

## Frequently Asked Questions

### What is the difference between COUNT(*) and COUNT(column)?
`COUNT(*)` counts all result rows. `COUNT(column)` counts only rows where the specified column is not `NULL`.

### When should I use COUNT(DISTINCT ...)?
Use it when you need the number of unique values rather than total rows, for example unique customers instead of total payments.

### Why can AVG return an unexpected value?
Because `AVG(column)` ignores `NULL`. If you want those rows to affect the denominator, use `COALESCE` or divide `SUM(column)` by `COUNT(*)`.

---

## Interview Questions

### What are aggregate functions in SQL?
They are functions that compute a summary over multiple rows, such as count (`COUNT`), sum (`SUM`), or average (`AVG`). They return one value per group or per full result set.

### What is the difference between COUNT(*), COUNT(column), and COUNT(DISTINCT column)?
`COUNT(*)` counts all rows, `COUNT(column)` counts non-`NULL` values in that column, and `COUNT(DISTINCT column)` counts unique non-`NULL` values.

### How can MIN and ORDER BY ... LIMIT 1 return different results?
If a column contains `NULL` and the DBMS sorts `NULL` first, `ORDER BY ... LIMIT 1` may return `NULL`, while `MIN()` returns the minimum non-`NULL` value.

---

**Key takeaways from this lesson:**

- Aggregate functions provide summary metrics quickly.
- `COUNT(*)`, `COUNT(column)`, and `COUNT(DISTINCT ...)` solve different counting tasks.
- `SUM`, `AVG`, `MIN`, and `MAX` usually ignore `NULL`, which affects analysis.
- `COUNT(DISTINCT ...)` is essential when you need unique entities rather than row totals.
- Correct `NULL` handling directly impacts report accuracy.

In the next lesson, we will study `GROUP BY` and learn how to build aggregates by categories.
