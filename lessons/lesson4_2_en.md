---
title: "Grouping Data in SQL with GROUP BY and Aggregates"
description: "Learn GROUP BY: syntax, rules, single and multi-column grouping, practical Sakila examples."
keywords: ["GROUP BY SQL", "data grouping", "aggregate functions", "HAVING", "Sakila"]
teaches: ["Use GROUP BY to group and aggregate data", "Understand the rule: all SELECT columns either in GROUP BY or in a function", "Group by one or multiple columns"]
about: ["SQL", "GROUP BY", "Aggregation", "Sakila"]
---

_Reading time: ~7 minutes_

Grouping transforms individual rows into categorized metrics. `GROUP BY` is essential for reports where you need totals per category, date, or any other dimension. In this lesson, you'll learn GROUP BY syntax, the core rule, and practical examples on Sakila. By the end, you'll confidently build analytical queries with grouping.

# Grouping Data with GROUP BY

In the previous lesson, you learned about aggregate functions. Now we take the next step: applying those functions to different data categories.

`GROUP BY` does this by dividing data into groups and calculating metrics for each group separately.

## GROUP BY Syntax

Basic structure:

```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1;
```

## The Core Rule

When using `GROUP BY`, **every column in SELECT must**:

- either be in the `GROUP BY` list;
- or be wrapped in an aggregate function (`SUM`, `COUNT`, `AVG`, `MIN`, `MAX`).

This rule prevents ambiguity: SQL needs to know which value to return when a group has multiple rows.

## Grouping by One Column

### Total payments per customer

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
```

*Result: one row per customer with their total payment sum.*

### Number of payments per staff member

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id;
```

*Result: for each staff member, the count of payments they processed.*

### Average payment by date

```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY DATE(payment_date);
```

*Result: for each date, the average payment amount.*

### Variant: GROUP BY with alias

```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY pay_date;
```

*Note: this works in MySQL/MariaDB but not all DBMSs. For cross-DB compatibility, write `GROUP BY DATE(payment_date)` in full.*

---

## Grouping by Multiple Columns

You can group by multiple fields at once for more detailed analysis.

### Total payments by staff and customer

```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id, customer_id;
```

*Result: one row per staff-customer pair with their total payment.*

---

## Practical Examples

### Daily revenue report

```sql
SELECT DATE(payment_date) AS pay_date, SUM(amount) AS total_sales
FROM payment
GROUP BY DATE(payment_date)
ORDER BY pay_date;
```

### Most active customers by rental count

```sql
SELECT customer_id, COUNT(*) AS rentals_count
FROM rental
GROUP BY customer_id
ORDER BY rentals_count DESC;
```

### Average rental rate by film category

```sql
SELECT category_id, AVG(rental_rate) AS avg_rental_rate
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY category_id;
```

---

## Frequently Asked Questions

### Why can't every column be in SELECT if I use GROUP BY?
Because aggregate functions (`SUM`, `COUNT`, `AVG`) already tell SQL how to handle all rows in the group. If a column isn't aggregated, it must be in GROUP BY so SQL knows which value to pick.

### Can I group by an expression instead of a column?
Yes, for example `GROUP BY DATE(payment_date)` or `GROUP BY YEAR(payment_date)`. The expression must match in SELECT and GROUP BY.

### What if GROUP BY is empty?
That's a syntax error. GROUP BY always needs at least one column or expression.

---

## Interview Questions

### What is GROUP BY and why do we need it?
GROUP BY combines rows where selected columns have identical values into a single group. You can then apply aggregate functions to each group to get summary statistics.

### Why can't I arbitrarily select a column when using GROUP BY?
Because a group may contain multiple rows with different values in that column. SQL needs to know which value to return, otherwise the result is ambiguous. So the column must either be in GROUP BY or inside an aggregate function.

### What's the difference between WHERE and HAVING?
`WHERE` filters rows BEFORE grouping, while `HAVING` filters groups AFTER grouping. For example, `WHERE amount > 10` excludes rows before grouping, while `HAVING SUM(amount) > 100` excludes groups whose sum is less than 100.

---

**Key takeaways from this lesson:**

- `GROUP BY` divides data into groups and applies aggregates to each.
- Core rule: all SELECT columns either in GROUP BY or in an aggregate function.
- You can group by one or multiple columns simultaneously.
- You can group by expressions, like `GROUP BY DATE(payment_date)`.
- `GROUP BY` powers reports, analytics, and category-based summaries.

In the next lesson, we will explore filtering groups with the `HAVING` operator.
