---
title: "How B-tree Indexes Work in SQL: Structure, Search, and Ranges"
description: "Understand how B-tree indexes are structured in SQL, why they accelerate search to logarithmic complexity, and how to use them in practical queries."
keywords: ["B-tree index", "how SQL indexes work", "SQL indexes", "index search", "range search SQL", "database performance"]
teaches: ["How B-tree index levels are organized", "Why index search executes quickly", "How B-tree helps with equality, ranges, and sorting", "How to read B-tree usage in EXPLAIN", "What conditions prevent B-tree from working efficiently"]
about: ["SQL", "B-tree", "Indexes", "Query optimization", "Database performance"]
---

_Lesson 10.5 · Reading time: ~11 min_

This lesson explains in detail how B-tree indexes work in SQL at the physical and logical level. You will learn what nodes make up the structure, how the database traverses the tree, and why this approach speeds up filtering and sorting. We will look at practical examples on Sakila tables and reinforce key usage rules. By the end of the lesson, you will better understand when a B-tree index actually accelerates queries.

# How B-tree Indexes Work

In the previous lesson, you learned how to create indexes. Now let's understand how an index is organized internally and why it speeds up search.

Understanding B-tree will help you see when an index truly works and when it cannot be used. This knowledge will be useful when optimizing slow queries.

<img src="/images/lessons/lesson10_5-btree-index.svg" alt="Schema of how B-tree indexes work in SQL: root, internal nodes, leaves, and search path" width="100%">

---

## What Is a B-tree Index

A B-tree index is like a table of contents in a book. Instead of reading all pages in order, you open the table of contents, find the chapter you need, and go there directly.

A B-tree has three levels:

- **root node** - the starting point of the search, like the cover of a table of contents;
- **intermediate nodes** - suggest which direction to go next;
- **leaf nodes** - contain the values you need and links to table rows.

The entire structure is sorted, so the database can quickly choose the right direction at each level.

Here's what it looks like:

```
                    [ ROOT ]
                   /   |   \
                  /    |    \
            [NODE A] [NODE B] [NODE C]
            / |  \    / | \    / | \
           /  |   \  /  |  \  /  |  \
         [L1][L2][L3][L4][L5][L6][L7][L8]
```

Each node contains values that help select the next node. Leaf nodes (L1–L8) contain the data you need.

---

## How Search by B-tree Works

When you search for `WHERE last_name = 'SMITH'`, the database:

1. starts from the root node;
2. selects the branch where names beginning with 'S' might be;
3. descends, refining the search at each level;
4. finds the name you need in a leaf node.

Thanks to this algorithm, search is very fast — even in a table with millions of rows, you only need to check a few levels.

---

## What Operations Does B-tree Accelerate Best

### Equality (`=`)

B-tree is well suited for exact value searches.

```sql
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

### Ranges (`>`, `<`, `BETWEEN`)

Because the keys are sorted, B-tree is efficient for range conditions.

```sql
SELECT
   payment_id,
   amount,
   payment_date
FROM payment
WHERE payment_date >= '2005-07-01'
  AND payment_date < '2005-08-01';
```

### Sorting (`ORDER BY`)

If the sort order matches the index, the database can often avoid expensive separate sorting.

```sql
SELECT
   payment_id,
   customer_id,
   payment_date
FROM payment
WHERE customer_id = 10
ORDER BY payment_date;
```

---

## Example of a Composite B-tree Index

Let's create an index for a common filtering and sorting pattern:

```sql
CREATE INDEX idx_payment_customer_date
ON payment (customer_id, payment_date);
```

Let's check the plan:

```sql
EXPLAIN
SELECT
   payment_id,
   customer_id,
   payment_date,
   amount
FROM payment
WHERE customer_id = 10
  AND payment_date >= '2005-07-01'
ORDER BY payment_date;
```

*Result: typically the database uses the index for filtering by `customer_id` and the range `payment_date`, as well as for ordered reading.*

---

## Leftmost Prefix Rule for Composite Indexes

If an index is created as `(customer_id, payment_date)`, the database uses it best if the condition **first** filters by `customer_id`.

**Works well:**
```sql
WHERE customer_id = 10
```

**Works well:**
```sql
WHERE customer_id = 10 AND payment_date >= '2005-01-01'
```

**Works poorly:**
```sql
WHERE payment_date >= '2005-01-01'
```

This rule is called the "leftmost prefix": the index works best when you use conditions from left to right.

---

## When an Index Doesn't Help

An index is not used if:

- you apply a function to a column: `WHERE YEAR(payment_date) = 2005` — the index doesn't work;
- you use a mask at the beginning: `WHERE name LIKE '%SMITH'` — the index won't help;
- the condition is too general and returns many rows — the index may be slower than reading the entire table.

**Bad (function prevents index use):**
```sql
SELECT payment_id, payment_date
FROM payment
WHERE YEAR(payment_date) = 2005;
```

**Good (index can work):**
```sql
SELECT payment_id, payment_date
FROM payment
WHERE payment_date >= '2005-01-01'
  AND payment_date < '2006-01-01';
```

---

## Practical Recommendations

- Index fields that frequently appear in `WHERE`, `JOIN`, `ORDER BY`.
- For composite indexes, put the most important column for filtering first.
- Check actual index usage through `EXPLAIN`.
- Don't create redundant indexes: they increase the cost of writes.

---

**Key takeaways from this lesson:**

- B-tree is a balanced structure that accelerates key search.
- The main strength of B-tree: equality, ranges, and sorting by index order.
- Composite indexes follow the leftmost prefix rule.
- An inappropriate condition form can deprive a query of index benefits.
- `EXPLAIN` helps you understand whether B-tree is used in the actual execution plan.

## Interview Questions

### Why is a B-tree index usually faster than a full scan?
Because the database traverses the tree along branches and finds the needed range in a logarithmic number of steps, instead of scanning all table rows.

### What is the leftmost prefix rule for a composite index?
This rule means that the optimizer uses the index best when starting from the first column of the key and proceeding in order.

### How do you check in practice that a B-tree index is being used?
You run `EXPLAIN` and look at the access type, chosen key, and expected number of rows at each execution stage.

In the next lesson, we will move on to error handling and SQL debugging techniques.
