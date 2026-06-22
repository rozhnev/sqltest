---
title: "Introducing SQL Indexes: Practical Ways to Speed Up Queries"
description: "Learn what SQL indexes are, how they affect SELECT performance, and which basic rules help avoid common query speed mistakes."
keywords: ["SQL indexes", "introducing indexes", "SQL performance", "query acceleration", "CREATE INDEX", "EXPLAIN SQL"]
teaches: ["What an index is and why it matters", "How indexes speed up reads and affect writes", "How to create single-column and composite indexes", "How to verify index usage with EXPLAIN", "Which query patterns can prevent index usage"]
about: ["SQL", "Indexes", "Database performance", "Query optimization", "EXPLAIN"]
---

_Lesson 10.4 · Reading time: ~10 min_

This lesson introduces SQL indexes and their role in query performance. You will learn what an index is, how it helps retrieve data faster, and why it can sometimes slow down data modification operations. We will walk through basic examples of creating and validating indexes using Sakila tables. By the end of this lesson, you will be able to use indexes more deliberately to speed up practical queries.

# Introducing SQL Indexes

In the previous lesson, we learned how to read execution plans with `EXPLAIN` and detect bottlenecks. The next logical step is to understand the core mechanism used to accelerate lookups: indexes.

Indexes are directly connected to how a DBMS searches for rows. Without them, the server often scans the entire table. With a suitable index, it can jump to relevant data much faster.

<img src="/images/lessons/lesson10_4-sql-indexes.svg" alt="Introducing SQL indexes and how indexes affect query performance" width="100%">

---

## What an index is

An SQL index is an additional data structure that helps the DBMS find rows faster by column values.

A simple analogy is a book index. Instead of reading every page, you use the index and go directly to the relevant section.

In relational databases, B-tree indexes are commonly used and work well for:

- exact lookups (`=`);
- ranges (`>`, `<`, `BETWEEN`);
- sorting (`ORDER BY`) on indexed columns.

---

## How indexes affect performance

### They speed up reads (`SELECT`)

When a `WHERE` condition uses an indexed column, the DBMS can locate rows without scanning the whole table.

### They can slow down writes (`INSERT`, `UPDATE`, `DELETE`)

Every index must be kept up to date. When data changes, the DBMS updates both the table and its related indexes.

### They require extra storage

Indexes are stored separately and consume disk space. Creating indexes on every column is usually a poor strategy.

---

## Basic syntax

Create a single-column index:

```sql
CREATE INDEX idx_customer_last_name
ON customer (last_name);
```

Drop an index (syntax varies by DBMS):

```sql
DROP INDEX idx_customer_last_name ON customer;
```

*Note: in PostgreSQL, the form is `DROP INDEX index_name;` without table name.*

---

## Example 1: Speeding up filtering on one column

Suppose we frequently search customers by last name:

```sql
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

Without an index on `last_name`, the DBMS may perform a full scan of `customer`. After creating the index, the lookup usually changes to a more efficient access type.

Validation with `EXPLAIN`:

```sql
EXPLAIN
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

*Result: in the execution plan, you should see index usage (`key`/`possible_keys` in MySQL or `Index Scan` in PostgreSQL).* 

---

## Example 2: Composite index

If queries often filter by two fields together, a composite index is useful.

```sql
CREATE INDEX idx_payment_customer_date
ON payment (customer_id, payment_date);
```

A query that fits this index well:

```sql
SELECT
   payment_id,
   customer_id,
   amount,
   payment_date
FROM payment
WHERE customer_id = 15
  AND payment_date >= '2005-07-01'
ORDER BY payment_date;
```

*Note: column order in a composite index matters. In many cases, put the more frequently filtered field first.*

---

## When an index may not be used

Even if an index exists, the optimizer may skip it. Common reasons:

- a function on the indexed column in `WHERE` (`YEAR(payment_date)`);
- pattern search with leading `%` (`LIKE '%abc'`);
- very low column selectivity;
- unsuitable column order in a composite index.

Example of a condition that often prevents index usage:

```sql
SELECT
   payment_id,
   payment_date
FROM payment
WHERE YEAR(payment_date) = 2005;
```

A more index-friendly version:

```sql
SELECT
   payment_id,
   payment_date
FROM payment
WHERE payment_date >= '2005-01-01'
  AND payment_date < '2006-01-01';
```

---

## Practical recommendations

- Add indexes for real frequent queries, not "just in case".
- Start with columns used in `WHERE`, `JOIN`, and `ORDER BY`.
- After adding an index, compare execution plans with `EXPLAIN`.
- Keep balance: too many indexes can hurt write performance.

---

**Key takeaways from this lesson:**

- An index is a structure that speeds up row lookup.
- Indexes usually improve `SELECT` performance, but can slow down `INSERT`, `UPDATE`, and `DELETE`.
- Single-column and composite indexes solve different filtering patterns.
- Column order in composite indexes is critical.
- `EXPLAIN` helps verify whether the DBMS uses your index.

## Interview Questions

### What is an SQL index, and why is it useful?
An index is an additional data structure that speeds up row lookup by column values. It is useful because it reduces read time and the amount of data scanned.

### Why can an index speed up `SELECT` but slow down `INSERT`?
For reads, an index helps locate rows faster. For writes, the DBMS must update both table data and index structures, which adds work.

### How do you verify that an index is actually used?
Run `EXPLAIN` for the query and inspect the execution plan: access type, selected index, and estimated row count.

In the next lesson, we will cover error handling and SQL debugging techniques used in day-to-day work.

→ [Course contents](course.md)
