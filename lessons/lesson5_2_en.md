# Lesson 5.2: INNER JOIN — Combining Matching Rows

In the previous lesson, we established the fundamental concept of joining tables to retrieve related data. The most common and frequently used type of join is the **INNER JOIN**. In this lesson, we will explore its logic, syntax, and practical applications in detail.

## What is an INNER JOIN?

An `INNER JOIN` is an operation that combines rows from two tables only when there is a matching value in both tables based on a specified condition. If a row in Table A does not have a corresponding match in Table B, that row is excluded from the result set. Similarly, any rows in Table B that do not match Table A are also left out.

Think of it as the **intersection** of two sets of data.

**Visualization:**
```
   Table A (customer)           Table B (payment)
   +----+----------+            +----+----------+
   | id | name     |            | id | amount   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | 10.00    | (Match!)
   | 2  | Bob      |            | 1  | 15.00    | (Match!)
   | 3  | Charlie  |            | 4  | 20.00    | (No match for Charlie or ID 4)
   +----+----------+            +----+----------+
```
*In this example, Charlie is excluded because he has no payments, and the payment with `customer_id` 4 is excluded because there is no customer with that ID.*

## INNER JOIN Syntax

The standard syntax for an `INNER JOIN` is:

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
INNER JOIN
    table2 ON table1.common_column = table2.common_column;
```

- `INNER JOIN`: Specifies that we only want matching rows.
- `ON`: Defines the condition for matching (usually the Primary Key of one table and the Foreign Key of another).

> **Note:** In most SQL databases (like MySQL, PostgreSQL, and SQL Server), the keyword `INNER` is optional. Writing `JOIN` and `INNER JOIN` will produce the exact same result.

## Practical Examples (Sakila Database)

### 1. Connecting Cities to Countries
The `city` table contains a `country_id` which refers to the `country` table. To see the city name alongside its country name, we use an `INNER JOIN`.

```sql
SELECT
    ci.city,
    co.country
FROM
    city AS ci
INNER JOIN
    country AS co ON ci.country_id = co.country_id;
```
*This query returns only cities that are linked to a valid country.*

### 2. Listing Staff and Their Addresses
To find where each staff member lives, we join the `staff` and `address` tables.

```sql
SELECT
    s.first_name,
    s.last_name,
    a.address,
    a.district
FROM
    staff AS s
INNER JOIN
    address AS a ON s.address_id = a.address_id;
```

## Joining More Than Two Tables

You can chain multiple `INNER JOIN` clauses to gather information from several tables at once. For example, to see which films an actor has appeared in, we need three tables: `actor`, `film`, and the junction table `film_actor`.

```sql
SELECT
    a.first_name,
    a.last_name,
    f.title
FROM
    actor AS a
INNER JOIN
    film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN
    film AS f ON fa.film_id = f.film_id
LIMIT 10;
```

**How it works:**
1. The first join connects `actor` and `film_actor` based on `actor_id`.
2. The second join connects the result of the first join with the `film` table based on `film_id`.
3. Only records that exist in all three tables satisfy the condition and appear in the results.

## Key Takeaways from This Lesson

- **INNER JOIN** is the default join type in SQL.
- It returns rows only when there is a **match** in both tables.
- Rows that do not meet the join condition are **discarded** from the result set.
- You can join multiple tables by adding subsequent `INNER JOIN` statements.
- Using **table aliases** (`AS ci`, `AS co`) makes complex joins much easier to read and write.
