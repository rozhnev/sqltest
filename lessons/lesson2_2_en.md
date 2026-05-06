---
title: "SQL WHERE Clause: Filter Data with BETWEEN, IN, LIKE and NULL"
description: "The SQL WHERE clause filters rows by condition. Learn comparison operators, BETWEEN ranges, IN lists, LIKE pattern matching, and how to handle NULL values correctly."
keywords: ["SQL WHERE clause", "SQL filter rows", "BETWEEN IN LIKE SQL", "SQL IS NULL", "SQL comparison operators", "WHERE clause tutorial"]
---

_Lesson 2.2 · Reading time: ~6 min_

The **SQL WHERE clause** filters table rows by evaluating a condition for each record — only rows where the condition is true are returned. In this lesson you'll learn comparison operators, `BETWEEN`, `IN`, `LIKE` pattern matching, and the correct way to handle `NULL` values.

# SQL WHERE Clause: Filtering Data in SQL Queries

The `SELECT` statement by itself returns all rows from a table. In real-world scenarios you usually need only a subset of data that meets specific criteria — and the `WHERE` clause is exactly how you express those criteria.

## What Is the SQL WHERE Clause?

The `WHERE` clause filters records before they are returned in the result set. It ensures that only rows satisfying a specified condition are included.

### Basic Syntax

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

The condition is an expression that evaluates to true, false, or unknown (when `NULL` values are involved). Only rows where the condition is **true** are returned.

---

## SQL Comparison Operators in WHERE

SQL provides a set of operators to compare column values in the `WHERE` clause:

| Operator | Description | Example |
| :--- | :--- | :--- |
| `=` | Equal to | `WHERE last_name = 'SMITH'` |
| `<>` or `!=` | Not equal to | `WHERE store_id <> 1` |
| `>` | Greater than | `WHERE rental_rate > 2.99` |
| `<` | Less than | `WHERE length < 60` |
| `>=` | Greater than or equal to | `WHERE replacement_cost >= 20.00` |
| `<=` | Less than or equal to | `WHERE amount <= 5.00` |

```sql
SELECT title, rental_rate, replacement_cost
FROM film
WHERE rental_rate = 4.99;
```

*Result: all films whose rental rate is exactly $4.99.*

---

## SQL BETWEEN, IN, and LIKE Operators

SQL includes powerful operators for range, set, and pattern filtering.

### BETWEEN — Range Filter

Filters values within a range (inclusive on both ends).

```sql
SELECT payment_id, amount, payment_date
FROM payment
WHERE amount BETWEEN 5.00 AND 10.00;
```

*Result: payments from $5.00 to $10.00 inclusive.*

### IN — List Match

Matches any value from a specified list. Cleaner than multiple `OR` conditions.

```sql
SELECT first_name, last_name, store_id
FROM customer
WHERE store_id IN (1, 2);
```

*Result: customers who belong to store 1 or store 2.*

### LIKE — Pattern Matching

Searches for a pattern in a text column using wildcards:
- `%` — zero, one, or more characters.
- `_` — exactly one character.

```sql
-- Films whose title starts with 'A'
SELECT title
FROM film
WHERE title LIKE 'A%';

-- Films where the second letter is 'I'
SELECT title
FROM film
WHERE title LIKE '_I%';
```

---

## How to Filter NULL Values in SQL

You cannot use `=` or `<>` to check for `NULL` — those comparisons always return unknown, never true. You must use `IS NULL` or `IS NOT NULL`.

```sql
-- Wrong: this returns no rows
-- WHERE return_date = NULL

-- Correct
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL;
```

*Result: all rentals that have not yet been returned.*

---

**Key Takeaways:**

* The `WHERE` clause filters rows **before** they are returned to the result set.
* String and date values must be enclosed in single quotes (e.g., `'SMITH'`); numeric values do not require quotes.
* `BETWEEN` is inclusive — `BETWEEN 5 AND 10` includes 5 and 10.
* `IN` is a concise alternative to multiple `OR` conditions.
* Use `LIKE` for pattern matching with `%` (any sequence) and `_` (single character).
* **Never** use `=` with `NULL` — always use `IS NULL` or `IS NOT NULL`.

---

## Frequently Asked Questions

### What is the difference between WHERE and HAVING in SQL?
`WHERE` filters rows **before** grouping and aggregation. `HAVING` filters **after** — it works on the results of `GROUP BY`. Use `WHERE` to filter individual rows, `HAVING` to filter aggregated groups.

### Can you use multiple conditions in a WHERE clause?
Yes. Combine conditions with `AND` (both must be true), `OR` (either must be true), or `NOT` (negation). You can also use parentheses to control evaluation order.

### Why does `WHERE column = NULL` return no results?
Because `NULL` represents an unknown value — comparing anything to `NULL` with `=` always returns unknown, not true or false. SQL requires `IS NULL` or `IS NOT NULL` to check for the absence of a value.

→ [Lesson 2.3: Combining Multiple Conditions with AND, OR, and NOT](lesson2_3_en.md)
