Learn how to use the SQL LEFT JOIN (or LEFT OUTER JOIN) to retrieve all records from one table and matching records from another. This lesson explains the logic of "left" and "right" in JOIN operations, how to handle NULL values for unmatched records, and practical examples using the Sakila database. Master techniques for finding missing data and comprehensive reporting.

# Lesson 5.3: LEFT JOIN — Including All Records from the Left Table

While the `INNER JOIN` only returns rows where there is a match in both tables, there are many scenarios where you want to keep all records from one table, even if they don't have a match in the other. This is exactly what the **LEFT JOIN** (also known as **LEFT OUTER JOIN**) does.

## What is a LEFT JOIN?

A `LEFT JOIN` returns **all** rows from the "left" table (the one mentioned first in the query) and the matching rows from the "right" table (the one mentioned after the `JOIN` keyword). 

If there is no match in the right table for a specific row in the left table, the database still returns the row from the left table, but it puts **NULL** in all columns coming from the right table.

**Visualization:**
```
   Table A (customer)           Table B (payment)
   +----+----------+            +----+----------+
   | id | name     |            | id | amount   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | 10.00    | (Match!)
   | 2  | Bob      | <--------> | 1  | 15.00    | (Match!)
   | 3  | Charlie  | <--------? | NULL          | (No match, keeps Charlie!)
   +----+----------+            +----+----------+
```
*In this example, Charlie is included in the results even though he has no payments. The "amount" for his row will be NULL.*

## LEFT JOIN Syntax

The syntax for a `LEFT JOIN` is identical to `INNER JOIN`, but with a different keyword:

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
LEFT JOIN
    table2 ON table1.common_column = table2.common_column;
```

- `LEFT JOIN`: Ensures all rows from `table1` (the left table) are kept.
- `ON`: The condition for matching.

> **Note:** `LEFT JOIN` and `LEFT OUTER JOIN` are the same thing. The keyword `OUTER` is optional.

## Practical Examples (Sakila Database)

### 1. Finding All Customers and Their Payments
Suppose we want a list of all customers, including those who have never made a payment. An `INNER JOIN` would filter out customers without payments, but a `LEFT JOIN` keeps them.

```sql
SELECT
    c.first_name,
    c.last_name,
    p.amount
FROM
    customer AS c
LEFT JOIN
    payment AS p ON c.customer_id = p.customer_id
ORDER BY
    p.amount ASC;
```
*If you see rows where `amount` is NULL, those are customers who have no payment records.*

### 2. Identifying "Dead" Inventory
Let's find all film copies (inventory) and check if they have ever been rented.

```sql
SELECT
    i.inventory_id,
    f.title,
    r.rental_id
FROM
    inventory AS i
JOIN
    film AS f ON i.film_id = f.film_id
LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id
WHERE
    r.rental_id IS NULL;
```
*By using `LEFT JOIN` and then filtering for `r.rental_id IS NULL`, we can find specific items in our inventory that have never been rented out.*

## Important Considerations

1.  **Table Order Matters:** In a `LEFT JOIN`, the table listed after `FROM` is the "Left" table. If you swap the tables, the result changes completely.
2.  **Handling NULLs:** When using `LEFT JOIN`, your application code needs to be ready to handle `NULL` values in the results.
3.  **Filtering:** If you put a condition in the `WHERE` clause that references the right table, you might accidentally turn your `LEFT JOIN` into an `INNER JOIN` (this is a common SQL trap).

## Key Takeaways from This Lesson

- **LEFT JOIN** returns all rows from the left table, regardless of whether a match exists.
- Columns from the right table will contain **NULL** when no match is found.
- It is a powerful tool for **finding missing data** or generating comprehensive lists.
- Unlike `INNER JOIN`, the **order of tables** in the query significantly impacts the result.
