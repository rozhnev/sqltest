Learn how to use SQL Correlated Subqueries to perform complex row-by-row comparisons. This lesson explains the difference between standard and correlated subqueries, the execution flow, and practical examples like finding records that exceed their group average. Master performance-critical SQL techniques using the Sakila database.

# Lesson 6.3: Correlated Subqueries

In the previous lessons, we used "standalone" subqueries that could be run on their own. In this lesson, we introduce **Correlated Subqueries** — a more advanced type of subquery that depends on cells or values from the outer query.

## What is a Correlated Subquery?

A subquery is **correlated** when it refers to a column from a table in the outer query. Unlike a regular subquery, a correlated subquery cannot be executed independently of the outer query.

**How it works:**
1. The database takes a row from the **outer query**.
2. It executes the **inner query** using values from that specific row.
3. It uses the result of the inner query to satisfy the `WHERE` (or `SELECT`) clause.
4. It moves to the **next row** and repeats the process.

> **Performance Note:** Because a correlated subquery is potentially executed once for every row in the outer query, it can be slower than a JOIN or a regular subquery on very large datasets.

## 1. Correlated Subqueries in WHERE

The most common use is to compare a row's value against a set of data related specifically to *that* row.

**Scenario:** Find all films that have a replacement cost higher than the average replacement cost of films in the **same rating category** (e.g., G, PG, R).

```sql
SELECT
    title,
    rating,
    replacement_cost
FROM
    film AS f1
WHERE
    replacement_cost > (
        SELECT AVG(replacement_cost)
        FROM film AS f2
        WHERE f1.rating = f2.rating
    );
```
- **Correlation:** `f1.rating = f2.rating` links the inner query to the current row of the outer query.
- **Logic:** For every film, the database calculates the average cost for its specific rating and checks if that film costs more.

## 2. Correlated Subqueries in SELECT

You can use correlated subqueries to retrieve descriptive data or aggregates for each row without using a `GROUP BY` clause.

**Scenario:** Show the list of categories and the title of the longest film in each category.

```sql
SELECT
    c.name AS category_name,
    (
        SELECT f.title
        FROM film f
        JOIN film_category fc ON f.film_id = fc.film_id
        WHERE fc.category_id = c.category_id
        ORDER BY f.length DESC
        LIMIT 1) AS longest_film_title
FROM
    category AS c;
```

## 3. Correlated Subqueries with EXISTS

We saw the `EXISTS` operator in the previous lesson. `EXISTS` is almost always used with a correlated subquery.

**Scenario:** Find customers who have rented at least one film at a specific store (Store 1).

```sql
SELECT
    first_name,
    last_name
FROM
    customer AS c
WHERE
    EXISTS (
        SELECT 1
        FROM rental AS r
        INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
        WHERE r.customer_id = c.customer_id
        AND i.store_id = 1
    );
```

## Key Takeaways from This Lesson

- A **Correlated Subquery** depends on the outer query for its values.
- It is executed **row-by-row** (once for each candidate row).
- **Aliases** are essential to distinguish between the outer and inner table instances.
- They are powerful for **group-relative comparisons** (comparing a row to its own group).
- Be mindful of **performance** when using them on millions of records.
