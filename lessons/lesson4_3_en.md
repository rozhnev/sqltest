---
title: "Filtering Grouped Data with HAVING in SQL"
description: "Learn HAVING clause: syntax, WHERE vs HAVING differences, filtering groups after aggregation, Sakila examples."
keywords: ["HAVING SQL", "group filtering", "GROUP BY", "aggregate functions", "Sakila"]
teaches: ["Use HAVING to filter groups after aggregation", "Understand differences between WHERE and HAVING", "Combine multiple conditions in HAVING"]
about: ["SQL", "HAVING", "GROUP BY", "Aggregation", "Sakila"]
---

_Reading time: ~7 minutes_

When using `GROUP BY` with aggregates, you often need to filter groups by their aggregated results. `HAVING` is the operator for filtering groups, just as `WHERE` filters individual rows. In this lesson, you'll learn the differences between `WHERE` and `HAVING`, syntax, and practical examples on Sakila. By the end, you'll confidently use `HAVING` for deep data analysis.

# Filtering Groups with HAVING

In previous lessons, you learned `GROUP BY` for grouping data and applying aggregates. Now comes the next step: filtering the groups themselves by conditions on aggregated values.

`HAVING` does this by allowing conditions after grouping.

## WHERE vs HAVING

- **WHERE** filters rows **before** grouping
- **HAVING** filters groups **after** aggregation

```sql
SELECT column1, COUNT(*) AS cnt
FROM table
WHERE column1 > 100          -- filter BEFORE grouping
GROUP BY column1
HAVING COUNT(*) > 10;        -- filter AFTER grouping
```

## HAVING Syntax

Basic structure:

```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1
HAVING condition;
```

The condition in `HAVING` typically involves an aggregate function.

---

## Examples with Single Condition

### Customers with total payments above 100

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```

*Result: only customers whose total payments exceed 100.*

### Staff members who processed more than 50 payments

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```

*Result: staff with more than 50 payments processed.*

### Customers with average payment ≥ 5

```sql
SELECT customer_id, AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```

*Result: customers whose average payment is at least 5.*

---

## HAVING with Multiple Conditions

You can combine conditions using `AND` and `OR`:

```sql
SELECT staff_id, COUNT(*) AS cnt, SUM(amount) AS total
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```

*Result: staff with more than 50 payments AND total above 500.*

### With OR operator

```sql
SELECT customer_id, COUNT(*) AS rentals, SUM(amount) AS paid
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 100 OR SUM(amount) > 1000;
```

*Result: customers with more than 100 payments OR total above 1000.*

---

## Practical Examples

### Film categories with sales above 2000

```sql
SELECT category_id, SUM(p.amount) AS total_sales
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
GROUP BY category_id
HAVING SUM(p.amount) > 2000;
```

### Countries with more than 20 customers

```sql
SELECT country, COUNT(*) AS customers_count
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY country
HAVING COUNT(*) > 20;
```

### Stores with daily revenue above 500

```sql
SELECT store_id, DATE(payment_date) AS pay_date, SUM(amount) AS daily_revenue
FROM payment
GROUP BY store_id, DATE(payment_date)
HAVING SUM(amount) > 500;
```

---

## Frequently Asked Questions

### Why can't I use WHERE instead of HAVING?
`WHERE` operates before grouping, so it cannot check aggregate functions. `HAVING` operates after grouping and can analyze aggregation results (COUNT, SUM, AVG, etc.).

### Can I use a non-aggregated column in HAVING?
Yes, you can use a column from `GROUP BY`, but usually this isn't needed. For example, `HAVING customer_id > 100` works, but it's more natural to write this in `WHERE` before grouping.

### Can HAVING be used without GROUP BY?
Technically in some DBMSs this is possible, but it's impractical since `HAVING` is designed for filtering groups. Use `WHERE` to filter individual rows without grouping.

---

## Interview Questions

### What is HAVING and how does it differ from WHERE?
HAVING filters groups after aggregation, while WHERE filters rows before grouping. WHERE cannot work with aggregate functions, but HAVING can only work with them.

### Can I use both WHERE and HAVING in one query?
Yes, this is even recommended. WHERE filters rows before grouping, and HAVING filters groups after. For example, `WHERE amount > 10 GROUP BY customer_id HAVING SUM(amount) > 100` first excludes small payments, then groups and filters groups.

### What's the order of execution: WHERE or HAVING?
WHERE is applied first (before GROUP BY), then GROUP BY performs grouping, then HAVING filters the resulting groups, and finally ORDER BY and LIMIT are applied.

---

**Key takeaways from this lesson:**

- `HAVING` filters groups **after** aggregation, `WHERE` filters rows **before** grouping.
- `HAVING` is used with aggregate functions (COUNT, SUM, AVG, MIN, MAX).
- You can combine multiple conditions in `HAVING` using `AND`/`OR`.
- Often WHERE and HAVING work together: WHERE excludes unwanted rows, HAVING filters groups.
- `HAVING` enables deep analytical queries with group-level filtering.

In the next lesson, we'll explore `ORDER BY` for sorting results.
