Learn how to use the SQL FULL OUTER JOIN to combine all records from both left and right tables. This lesson covers the concept of comprehensive data sets, handling NULLs on both sides, and common workarounds for databases that do not support FULL OUTER JOIN natively. Master advanced join techniques for complete data visibility.

# Lesson 5.5: FULL OUTER JOIN — Combining Everything from Both Tables

The **FULL OUTER JOIN** is the most inclusive type of join. It returns all rows when there is a match in **either** the left or the right table. It is essentially a combination of a `LEFT JOIN` and a `RIGHT JOIN`.

## What is a FULL OUTER JOIN?

A `FULL OUTER JOIN` creates a result set that includes all records from both tables. 
- If a row matches, columns from both tables are populated.
- If there is a row in the left table with no match in the right, the right columns are **NULL**.
- If there is a row in the right table with no match in the left, the left columns are **NULL**.

**Visualization:**
```
   Table A (potential_leads)    Table B (active_clients)
   +----+----------+            +----+----------+
   | id | name     |            | id | status   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | Active   | (Match!)
   | 2  | Bob      | <--------? | NULL          | (Lead only, no account yet)
   | NULL          | <--------> | 3  | Active   | (Client only, not in lead list)
   +----+----------+            +----+----------+
```

## FULL OUTER JOIN Syntax

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
FULL OUTER JOIN
    table2 ON table1.common_column = table2.common_column;
```

> **Important Note on Database Support:** Not all database systems support `FULL OUTER JOIN` natively. 
> - **PostgreSQL, SQL Server, and Oracle** support it.
> - **MySQL and MariaDB** do **NOT** support it.

## Workaround for MySQL/MariaDB

Since MySQL doesn't have `FULL OUTER JOIN`, developers achieve the same result by combining a `LEFT JOIN` and a `RIGHT JOIN` using the `UNION` operator:

```sql
SELECT * FROM table1 LEFT JOIN table2 ON table1.id = table2.id
UNION
SELECT * FROM table1 RIGHT JOIN table2 ON table1.id = table2.id;
```

## Practical Example

Imagine we are merging data from two different branch offices. Branch A has their own list of customers, and Branch B has theirs. We want a complete list of all customers across both branches, showing where they overlap.

```sql
SELECT
    a.customer_name AS branch_a_name,
    b.customer_name AS branch_b_name
FROM
    branch_a_customers AS a
FULL OUTER JOIN
    branch_b_customers AS b ON a.customer_id = b.customer_id;
```

## Key Takeaways from This Lesson

- **FULL OUTER JOIN** returns all records from both tables.
- It uses **NULLs** to fill in the gaps where no match is found on either side.
- It is the best tool for **database synchronization** and finding discrepancies between two lists.
- If your database doesn't support it (like MySQL), use a **UNION** of a LEFT and RIGHT join.
