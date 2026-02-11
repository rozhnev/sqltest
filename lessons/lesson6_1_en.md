Learn the fundamentals of SQL subqueries, also known as nested queries or inner queries. This lesson introduces the concept of placing a query inside another query, explains the difference between scalar and multi-row subqueries, and introduces "Inline Views." Master how to use subqueries to perform multi-step data retrieval in the Sakila database.

# Lesson 6.1: Introduction to Subqueries — Nested Queries and Inline Views

In previous modules, we learned how to retrieve data from tables and join them. However, sometimes a single query isn't enough to get the answer you need. You might need to find a value first (like an average or a specific ID) and then use that value in another query. This is where **Subqueries** come in.

## What is a Subquery?

A **Subquery** (or Inner Query) is a `SELECT` statement nested inside another SQL statement. The query that contains the subquery is called the **Outer Query** (or Main Query).

Subqueries are always enclosed in parentheses `()`.

## Core Logic: How They Work
Typically, the database executes the **Inner Query** first. The result of that inner query is then passed to the **Outer Query**, which uses it to complete its own execution.

```sql
-- Conceptual Example
SELECT column_name
FROM table_name
WHERE column_name = (SELECT value FROM another_table);
                    ^------- This runs first -------^
```

## Categories of Subqueries

Subqueries are often categorized by the data they return:

1.  **Scalar Subquery:** Returns exactly one value (one row and one column).
2.  **Multiple-Row Subquery:** Returns a list of values (one column, many rows).
3.  **Table Subquery (Inline View):** Returns an entire result set (multiple columns and rows) and is used in the `FROM` clause as if it were a temporary table.

---

## 1. Nested Subqueries (Inside WHERE)

The most common use of a subquery is in the `WHERE` clause to filter data based on a dynamic value.

**Scenario:** Find films that have a replacement cost higher than the average replacement cost of all movies.

```sql
SELECT
    title,
    replacement_cost
FROM
    film
WHERE
    replacement_cost > (SELECT AVG(replacement_cost) FROM film);
```
- **Inner Query:** Calculates the average cost ($19.98, for example).
- **Outer Query:** Finds all films where the cost is higher than that calculated $19.98.

---

## 2. Inline Views (Inside FROM)

When you put a subquery in the `FROM` clause, it is called an **Inline View**. You are essentially creating a temporary table "on the fly" that only exists for the duration of that query.

**Note:** You **must** give an inline view an alias.

**Scenario:** Get a list of active customers and join it with their payment data.

```sql
SELECT
    active_cust.first_name,
    p.amount
FROM
    (SELECT * FROM customer WHERE active = 1) AS active_cust
INNER JOIN
    payment AS p ON active_cust.customer_id = p.customer_id;
```
*In this case, the outer query joins the result of the subquery (`active_cust`) with the `payment` table.*

---

## Why Use Subqueries instead of JOINs?

- **Readability:** Sometimes a subquery is easier to understand than a complex join.
- **Aggregation:** Subqueries are great when you need to use an aggregate value (like `AVG` or `MAX`) to filter individual rows.
- **Logic:** Certain logic (like "Find all X that do NOT exist in Y") can be expressed very cleanly with subqueries using `NOT IN` or `NOT EXISTS`.

## Key Takeaways from This Lesson

- A **Subquery** is a `SELECT` statement inside another query.
- **Nested subqueries** are usually found in the `WHERE` or `SELECT` clauses.
- **Inline Views** are subqueries used in the `FROM` clause and require an **alias**.
- The **Inner Query** generally runs first, providing data to the **Outer Query**.
- Subqueries are always wrapped in **parentheses**.
