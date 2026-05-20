---
title: "Efficient SQL Queries: How to Write Faster and Leaner SQL"
description: "Efficient SQL queries reduce server load and speed up reports. Learn practical filtering, JOIN, SARGable, and LIMIT techniques."
keywords: ["efficient SQL queries", "SQL optimization", "SARGable SQL", "SQL JOIN performance", "query performance", "SQL for analysts"]
teaches: ["Why SELECT * slows production queries", "How early filtering improves speed", "How to write SARGable conditions", "When to use EXISTS instead of JOIN", "How to use LIMIT safely while debugging"]
about: ["SQL", "Query optimization", "Database performance", "SARGable", "JOIN"]
---

_Lesson 10.2 · Reading time: ~10 min_

This lesson introduces the fundamentals of writing high-performance SQL queries. You will learn how to avoid unnecessary database load, why `SELECT *` often hurts performance, and how to filter data effectively. We will review practical techniques that help queries run faster, even on large datasets. By the end of this lesson, you will be able to write efficient SQL that uses server resources responsibly.

# Lesson 10.2: Writing Efficient SQL Queries

In the previous lesson, we focused on readability for people. But SQL must also be readable and efficient for the database engine. Even perfectly formatted code can perform poorly if it forces the server to do unnecessary work.

Query efficiency directly affects application and reporting speed. In large-data or high-load systems, the difference between "works" and "optimized" can be minutes or even hours of runtime.

Modern DBMS engines have powerful optimizers that can rewrite queries under the hood. Still, an optimizer is not all-powerful. It does not know your business intent and cannot always fix fundamentally inefficient design choices. Code quality remains the developer's responsibility.

<img src="/images/lessons/lesson10_2-efficient-queries.svg" alt="Diagram of SQL query acceleration techniques: filtering, indexes, JOIN optimization, and limiting result sets" width="100%">

---

## Golden rule: retrieve only what you need

The most common reason for slow queries is moving too much unnecessary data between the database server and the client.

### Avoid `SELECT *`

While `SELECT *` is convenient for quick exploration, avoid it in production SQL.

- **Extra traffic:** you transfer columns you do not need.
- **Index limitations:** covering-index strategies become harder when all columns are requested.
- **Fragile code:** adding a new column can unexpectedly change behavior and performance.

```sql
-- Poor
SELECT * FROM film;

-- Better
SELECT film_id, title, release_year
FROM film;
```

---

## Filtering optimization

How you limit rows determines how much data the DBMS must scan and process.

### Filter on the server side

Apply `WHERE` conditions as early as possible, before heavy aggregation or return to clients. The earlier you reduce rows, the faster downstream steps (`JOIN`, `GROUP BY`) become.

### Avoid functions in `WHERE` (SARGable queries)

To use indexes effectively, `WHERE` predicates should be **SARGable** (*Search ARGumentable*). If you wrap an indexed column in a function, the optimizer often cannot use the index efficiently and may scan the full table.

```sql
-- Slow (Non-SARGable: index on rental_date may not be used)
SELECT count(*) 
FROM rental 
WHERE YEAR(rental_date) = 2005;

-- Fast (SARGable: index can be used)
SELECT count(*) 
FROM rental 
WHERE rental_date >= '2005-01-01' AND rental_date < '2006-01-01';
```

---

## Working with `JOIN`

Joining tables is one of the most resource-intensive query operations.

- **Filter first, join second:** reduce row volume in child tables before joining.
- **Check indexes on join keys:** typically primary and foreign keys.
- **Avoid unnecessary `CROSS JOIN`:** Cartesian products can explode quickly.
- **Use `EXISTS` for existence checks:** if you only need to know whether related rows exist, `EXISTS` is often cheaper than `JOIN`.

```sql
-- Less efficient (JOIN forces matching through all payments)
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id;

-- More efficient (EXISTS can stop on first match)
SELECT c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
    SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id
);
```

---

## Use `LIMIT` while testing

When debugging a query, always use `LIMIT` to avoid accidentally returning millions of rows.

```sql
SELECT customer_id, first_name, last_name
FROM customer
WHERE active = 1
LIMIT 10;
```

---

## Practical example: report optimization

Assume we need films rented more than 30 times, limited to one category.

**Less efficient approach:**
```sql
SELECT f.title, COUNT(r.rental_id)
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
GROUP BY f.title
HAVING COUNT(r.rental_id) > 30;
```

**More efficient approach:**
If we know the category ID, we can skip joining the category-name lookup.

```sql
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE fc.category_id = 1 -- Use ID instead of string lookup
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) > 30;
```

*Note: filtering by numeric IDs is usually faster than filtering by text names and often allows fewer joins.*

---

**Key takeaways from this lesson:**

*   Avoid `SELECT *` in production queries; list only needed columns.
*   Filter as early as possible using `WHERE`.
*   Write **SARGable** predicates so indexes can be used.
*   Prefer `EXISTS` over `JOIN` for pure existence checks.
*   Use `LIMIT` during exploration and debugging.
*   Prefer filtering by numeric keys rather than text labels.

---

## Frequently Asked Questions

### Why is `SELECT *` harmful in production queries?
It returns unnecessary columns, increases traffic, and may block index-friendly plans. Explicit column lists are typically faster and safer.

### What does SARGable mean in practice?
A SARGable predicate allows index-based search. Wrapping indexed columns in functions often prevents efficient index use.

### When should I use `EXISTS` instead of `JOIN`?
Use `EXISTS` when you only need to know whether related rows exist and you do not need columns from the second table.

## Interview Questions

### What are your first steps when a SQL query is slow?
Check whether it uses `SELECT *`, review `WHERE` selectivity, and identify non-SARGable predicates. Then inspect join strategy and row volume early in the query.

### Why does early filtering improve performance?
It reduces the number of rows involved in joins, sorting, and aggregation, lowering the overall plan cost.

### How do `JOIN` and `EXISTS` differ from a performance perspective?
`JOIN` combines row sets and is required when you need columns from both sides. `EXISTS` is often faster for boolean existence checks because it can stop at first match.

In the next lesson, we will go deeper into execution analysis and see how indexes accelerate queries at the physical level.

-> [Lesson 10.3: Understanding Query Optimization Methods](lesson10_3_en.md)
