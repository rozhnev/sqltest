Learn how to use SQL SELF JOIN to join a table to itself. This lesson covers the concept of hierarchical data, using aliases to distinguish table instances, and practical examples like finding pairs of records with matching attributes. Master advanced SQL join techniques for complex data relationships.

# Lesson 5.7: SELF JOIN - Joining a Table to Itself

A **SELF JOIN** is not a different type of join keyword. Instead, it is a regular join (usually an `INNER JOIN` or `LEFT JOIN`) where a table is joined with itself. This is useful for querying hierarchical data or comparing rows within the same table.

## What is a SELF JOIN?

To perform a self-join, you must treat one table as if it were two separate tables. To do this, you **must use table aliases** to give each instance of the table a unique name. Without aliases, the database won't know which column belongs to which instance of the table.

**Visualization (Employee Hierarchy):**
Imagine an `employee` table where each row has a `manager_id` that points to the `employee_id` of their supervisor.

```
   Table A (Employees)          Table B (Managers)
   +----+-------+---------+     +----+-------+
   | id | name  | mgr_id  |     | id | name  |
   +----+-------+---------+     +----+-------+
   | 1  | Alice | NULL    |     | 1  | Alice |
   | 2  | Bob   | 1       | <-> | 1  | Alice | (Bob's Manager is Alice)
   | 3  | Carol | 1       | <-> | 1  | Alice | (Carol's Manager is Alice)
   +----+-------+---------+     +----+-------+
```

## SELF JOIN Syntax

```sql
SELECT
    e.name AS employee_name,
    m.name AS manager_name
FROM
    employee AS e
LEFT JOIN
    employee AS m ON e.manager_id = m.id;
```

- `employee AS e`: The first instance (representing the employees).
- `employee AS m`: The second instance (representing the managers).
- `ON e.manager_id = m.id`: The condition that links them.

## Practical Examples (Sakila Database)

### 1. Finding Films with the Same Duration
Suppose we want to find pairs of films that have exactly the same `length`. We can join the `film` table to itself.

```sql
SELECT
    f1.title AS film_1,
    f2.title AS film_2,
    f1.length
FROM
    film AS f1
INNER JOIN
    film AS f2 ON f1.length = f2.length
WHERE
    f1.film_id <> f2.film_id -- Ensure we don't match a film with itself
LIMIT 10;
```
*The condition `f1.film_id <> f2.film_id` is critical. Without it, every film would match itself (since it has the same length as itself).*

### 2. Finding Customers from the Same City
If we want to see which customers live in the same city (based on `address_id` in this simplified example):

```sql
SELECT
    c1.first_name AS cust_1_first,
    c1.last_name AS cust_1_last,
    c2.first_name AS cust_2_first,
    c2.last_name AS cust_2_last,
    c1.address_id
FROM
    customer AS c1
INNER JOIN
    customer AS c2 ON c1.address_id = c2.address_id
WHERE
    c1.customer_id < c2.customer_id; -- Use '<' instead of '<>' to avoid duplicate pairs (A-B and B-A)
```

## Key Takeaways from This Lesson

- A **SELF JOIN** is a table joined with itself.
- **Table Aliases** are mandatory to distinguish between the two instances of the table.
- Use `ON` conditions to define the relationship between rows (e.g., hierarchy or shared attributes).
- Use `WHERE` filter conditions like `id1 <> id2` or `id1 < id2` to avoid matching a row with itself or returning redundant pairs.
