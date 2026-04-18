This lesson introduces temporary tables, a special type of table that exists for a limited time and is usually used for intermediate calculation results. You will learn what temporary tables are, how to create them, how they differ from regular tables, and in which tasks they are especially useful. By the end of this lesson, you will be able to confidently use temporary tables to simplify complex SQL scenarios.

# Lesson 9.3: Temporary Tables

In the previous lesson, we discussed creating tables with `CREATE TABLE`. Now let’s look at a special type of table: **temporary tables**. They help store intermediate data within a session or transaction and are often used in analytical queries, ETL processes, and multi-step data processing.

Unlike regular tables, temporary tables are not intended for permanent data storage. They are created for a limited period and are then automatically removed or become unavailable after the session ends.

<img src="/images/lessons/lesson9_3-temporary-tables.svg" alt="Temporary Tables" width="100%">

## What Is a Temporary Table

A temporary table is a table created for short-term data storage while a user is working or a script is running.

These tables are typically:

- available only within the current connection or transaction;
- used for intermediate calculations;
- useful for splitting complex logic into several clearer steps;
- helpful when you need to reuse an intermediate result in multiple queries.

In many DBMSs, temporary tables are created using the `TEMPORARY` or `TEMP` keyword.

## Basic Syntax

One common way to create a temporary table looks like this:

```sql
CREATE TEMPORARY TABLE table_name (
    column1 data_type,
    column2 data_type,
    column3 data_type
);
```

The name of a temporary table should not match the name of an existing regular table, so it is a good idea to use a prefix such as `temp_`.

After that, you can work with the temporary table almost like with a regular one: insert data, select from it, update rows, and delete rows.

## Example: Creating a Temporary Table

Suppose we want to store a list of customers who made more than 30 payments:

```sql
CREATE TEMPORARY TABLE tmp_active_customers AS
SELECT customer_id, COUNT(*) AS payment_count
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 30;
```

Now we can use this temporary table in subsequent queries:

```sql
SELECT ac.customer_id, ac.payment_count, c.first_name, c.last_name
FROM tmp_active_customers ac
JOIN customer c ON ac.customer_id = c.customer_id
ORDER BY ac.payment_count DESC;

SELECT COUNT(*) AS active_customer_count,
       AVG(payment_count) AS avg_payment_count,
       MAX(payment_count) AS max_payment_count
FROM tmp_active_customers;
```

*Result: in the first query, we get the list of active customers, and in the second, we calculate summary metrics on the same intermediate dataset. This is one of the key advantages of a temporary table: unlike a subquery or a CTE, it can be reused across several separate queries without rewriting the same logic.*

---

## How a Temporary Table Differs from a Regular Table

Although temporary and regular tables are structurally similar, there are several important differences.

### 1. Lifetime

- **A regular table** stays in the database permanently until you explicitly drop it.
- **A temporary table** exists for a limited time, usually until the end of a session or transaction.

### 2. Purpose

- **A regular table** is used for permanent storage of business data.
- **A temporary table** is used for intermediate, technical, or preparatory data.

### 3. Visibility Scope

- **A regular table** is available to all users with the required permissions.
- **A temporary table** is usually visible only within the current connection.

### 4. Practical Use

- **A regular table** stores customers, orders, products, payments, and other core information.
- **A temporary table** stores results of intermediate filtering, aggregation, or data preparation for a report.

### 5. Data Durability

- **A regular table** is usually part of durable storage and is intended for permanent data retention.
- **A temporary table** is usually not treated as durable storage: its data is needed only during a session or for intermediate processing steps and generally should not survive the end of the work.

---

## When Temporary Tables Are Especially Useful

Use temporary tables when:

- a query is too complex and easier to split into stages;
- the same intermediate result is needed more than once;
- you need to temporarily store cleaned or aggregated data;
- you want to simplify readability and maintenance of an SQL script.

For example, you can first build a temporary table with selected films and then calculate metrics only for them.

```sql
CREATE TEMPORARY TABLE tmp_expensive_films AS
SELECT film_id, title, rental_rate
FROM film
WHERE rental_rate >= 4.00;

SELECT COUNT(*) AS film_count, AVG(rental_rate) AS avg_rate
FROM tmp_expensive_films;
```

*Result: the logic is split into two clear steps, data preparation and analysis.*

---

## Temporary Table vs. Regular CTE

In some cases, you can use a CTE (`WITH`) or a subquery instead of a temporary table. The difference is that:

- **a CTE** exists only within a single query;
- **a subquery** also exists only inside the query where it is written;
- **a temporary table** can be used in multiple queries during a session;
- **a CTE** is convenient for compact logic inside one SQL statement;
- **a temporary table** is convenient when the intermediate result must be reused in two or more separate queries.

If a result is needed only once, a CTE or a subquery is often simpler. If it is needed across multiple steps, a temporary table is usually more convenient because you do not have to rewrite the same intermediate query in each following step.

---

## In-Memory Temporary Tables

In some DBMSs, you can explicitly create a temporary table so that it is stored in RAM. This can significantly speed up data access, especially when the table is small and used heavily in several steps of the same scenario.

For example, in MySQL or MariaDB, you can explicitly specify the table engine:

```sql
CREATE TEMPORARY TABLE tmp_fast_result (
    customer_id INT,
    total_amount DECIMAL(10, 2)
) ENGINE = MEMORY;
```

This approach requires explicitly setting the appropriate `ENGINE` in the table definition. It should be used carefully: RAM is limited, and overly large temporary tables can create unnecessary load on the server.

---

## What to Pay Attention To

When working with temporary tables, it is useful to keep a few rules in mind:

- do not use them where one simple query is enough;
- give temporary tables clear names that reflect their purpose, and use a prefix such as `tmp_` for temporary table names;
- do not expect temporary tables to provide durability in the same way as regular tables;
- place temporary tables in memory only when that is truly justified by the data volume and workload;
- pay attention to when the table is dropped in your DBMS;
- do not keep data in temporary tables longer than necessary;
- check syntax specifics in your DBMS, because `TEMPORARY TABLE` behavior can differ.

When used well, a temporary table makes complex SQL more readable and manageable.

---

## Practical Example

Imagine that we need to find customers who rented films from the `Action` category and then build a separate report for them.

```sql
CREATE TEMPORARY TABLE tmp_action_customers AS
SELECT DISTINCT r.customer_id
FROM rental r
JOIN inventory i      ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
WHERE c.name = 'Action';

SELECT ac.customer_id, cu.first_name, cu.last_name
FROM tmp_action_customers ac
JOIN customer cu ON ac.customer_id = cu.customer_id
ORDER BY cu.last_name, cu.first_name;

SELECT COUNT(*) AS action_customer_count
FROM tmp_action_customers;
```

This approach is especially convenient if, after getting this list, you need to run several additional analytical queries. For example, after retrieving the customer list, you can immediately count the total number of such customers without repeating the original selection logic.

That is exactly the important difference from subqueries and CTEs: you can create a temporary table once and then use it sequentially in several independent queries.

---

**Key takeaways from this lesson:**

*   Temporary tables are used for short-term storage of intermediate data.
*   They usually exist only within the current session or transaction and are removed automatically unless something else is specified when the table is created, but in practice it is better to drop them explicitly.
*   In syntax and usage, they are similar to regular tables but are not meant for permanent data storage.
*   Temporary tables are usually not used as durable storage in the `Durability` sense.
*   Temporary tables are especially useful in complex multi-step queries and analytical scenarios.
*   Small temporary tables in some DBMSs can be stored in memory, but this should be used carefully.
*   If an intermediate result is needed in only one query, a CTE may be a better option.

In the next lesson, we will look at how temporary tables differ from views and when each of these tools is better to use.
