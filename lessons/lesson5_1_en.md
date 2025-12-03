# Lesson 5.1: Fundamentals of JOINs in SQL

In relational databases, information is stored as a set of related tables. To extract meaningful data from them, you need to know how to join them. The `JOIN` operation in SQL is used for this purpose. It allows you to combine rows from two or more tables based on a related column.

This lesson lays the foundation for understanding `JOIN` as a key concept for working with relational data.

## The Core Concept of a JOIN

A `JOIN` is a mechanism that allows you to combine rows from different tables into a single result set. The join is performed based on a condition that most often compares values in key columns.

Imagine two tables: `customer` and `payment`. The `payment` table has a `customer_id` column that indicates which customer made the payment. A `JOIN` lets you "glue" the rows from these two tables together so that for each payment, you can see the customer's name, not just their ID.

**How it works:**
1.  You specify the two tables you want to join.
2.  You define the join condition in the `ON` clause, for example, `customer.customer_id = payment.customer_id`.
3.  The database goes through the rows, finds matching pairs, and forms new, combined rows from them.

**Visualization:**
```
  Table A (customer)      Table B (payment)
  +----+-------+            +----+----------+
  | id | name  |            | id | amount   |
  +----+-------+            +----+----------+
  | 1  | Ivan  | <-----\    | 1  | 100.00   |
  | 2  | Maria |       \--->| 1  | 50.00    |
  | 3  | Petr  |            | 3  | 200.00   |
  +----+-------+            +----+----------+
```

*The arrows show how rows from the `payment` table find their corresponding customer in the `customer` table based on the matching `id`.*

## Practical Application

Let's see what this looks like in a real SQL query using the Sakila database.

1.  **Getting a list of customers and their payments:**
    This query joins the `customer` and `payment` tables to show the customer's first and last name next to each payment.
    ```sql
    SELECT
        c.first_name,
        c.last_name,
        p.amount,
        p.payment_date
    FROM
        customer AS c
    JOIN
        payment AS p ON c.customer_id = p.customer_id;
    ```
    - `JOIN payment AS p` specifies that we are joining the `payment` table.
    - `ON c.customer_id = p.customer_id` is the condition that defines how the rows are related.
    - `c` and `p` are **aliases**, which make the query shorter and more readable.

2.  **Getting a list of films and their language:**
    Let's join the `film` and `language` tables to show the title of each film and the language it is in.
    ```sql
    SELECT
        f.title,
        l.name AS language
    FROM
        film AS f
    JOIN
        language AS l ON f.language_id = l.language_id;
    ```
    Here, the relationship is established through the `language_id` key.

## Key Takeaways from This Lesson

- **JOIN** is a fundamental operation in SQL for working with relational data, allowing you to combine tables.
- The join is based on a **condition** specified in the `ON` clause, which defines how the rows are related.
- Using **aliases** for tables (`customer AS c`) is a good practice that improves query readability.
- `JOIN` does not modify the original data; it only creates a temporary result set of rows.

In the following lessons, we will explore the different types of joins (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`) in detail and see how they affect the final result.
EOF