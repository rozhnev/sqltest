This SQL lesson focuses on row filtration using the WHERE clause. Learn how to use comparison operators, range filters with BETWEEN, list matching with IN, and pattern matching with LIKE. The lesson also covers the critical distinction of handling NULL values with IS NULL and IS NOT NULL. Master data filtering techniques to retrieve precise information and optimize your database queries for efficient analysis.

# Lesson 2.2 Rows Filtration: The WHERE Clause

## Filtering Data with the WHERE Clause

The `SELECT` statement by itself returns all rows from a table. However, in real-world scenarios, you usually only need a subset of data that meets specific criteria. This is where the `WHERE` clause comes in.

## What is the WHERE Clause?

The `WHERE` clause is used to filter records. It ensures that only those rows that satisfy a specified condition are included in the result set.

### Basic Syntax

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

The condition is an expression that evaluates to true, false, or unknown (if `NULL` values are involves). Only rows where the condition evaluates to **true** are returned.

---

## Comparison Operators

SQL provides a variety of operators to compare values in the `WHERE` clause:

| Operator | Description | Example |
| :--- | :--- | :--- |
| `=` | Equal to | `WHERE last_name = 'SMITH'` |
| `<>` or `!=` | Not equal to | `WHERE store_id <> 1` |
| `>` | Greater than | `WHERE rental_rate > 2.99` |
| `<` | Less than | `WHERE length < 60` |
| `>=` | Greater than or equal to | `WHERE replacement_cost >= 20.00` |
| `<=` | Less than or equal to | `WHERE amount <= 5.00` |

### Example (Sakila Database)

To find films with a rental rate of $4.99 from the `film` table:

```sql
SELECT title, rental_rate, replacement_cost
FROM film
WHERE rental_rate = 4.99;
```

---

## Special Filtering Operators

SQL includes powerful operators for range, set, and pattern matching.

### 1. BETWEEN
Filters values within a certain range (inclusive).

```sql
-- Find payments between $5.00 and $10.00
SELECT payment_id, amount, payment_date
FROM payment
WHERE amount BETWEEN 5.00 AND 10.00;
```

### 2. IN
Matches any value in a specified list.

```sql
-- Find customers from specific stores
SELECT first_name, last_name, store_id
FROM customer
WHERE store_id IN (1, 2);
```

### 3. LIKE
Searches for a specified pattern in a column using wildcards:
- `%` represents zero, one, or multiple characters.
- `_` represents a single character.

### Example (Sakila Database)

```sql
-- Find films starting with 'A'
SELECT title
FROM film
WHERE title LIKE 'A%';

-- Find films where the second letter is 'I'
SELECT title
FROM film
WHERE title LIKE '_I%';
```

---

## The Trap: Filtering NULL values

As we learned in the lesson on NULLs, you cannot use `=` or `<>` to check for `NULL`. You must use `IS NULL` or `IS NOT NULL`.

### Example (Sakila Database)

```sql
-- Incorrect
-- WHERE return_date = NULL

-- Correct
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL;
```

---

**Key Takeaways from this Lesson:**

*   The `WHERE` clause filters rows **before** they are returned to the result set.
*   String and date values must be enclosed in single quotes (e.g., `'SMITH'`).
*   Numeric values do not require quotes.
*   Use `LIKE` for pattern matching and `IN` for matching against lists.
*   **Never** use `=` with `NULL`; always use `IS NULL`.

In the next lesson, we will explore how to **Combine Multiple Conditions** to create even more powerful filters.
