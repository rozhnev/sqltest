Learn how to use the SQL RIGHT JOIN (or RIGHT OUTER JOIN) to retrieve all records from the right table and matching records from the left. This lesson explains why RIGHT JOIN is often considered the mirror image of LEFT JOIN, when to use it, and how to maintain query readability. Master comprehensive data retrieval techniques using the Sakila database.

# Lesson 5.4: RIGHT JOIN — Including All Records from the Right Table

The **RIGHT JOIN** (or **RIGHT OUTER JOIN**) is the logical opposite of the `LEFT JOIN`. It ensures that all rows from the "right" table (the one mentioned after the `JOIN` keyword) are included in the result set, regardless of whether they have a match in the "left" table.

## What is a RIGHT JOIN?

A `RIGHT JOIN` returns **all** rows from the right table and the matched rows from the left table. If there is no match in the left table, the result will contain **NULL** values for the columns of the left table.

**Visualization:**
```
   Table A (customer)           Table B (payment)
   +----+----------+            +----+----------+
   | id | name     |            | id | amount   |
   +----+----------+            +----+----------+
   | 1  | Alice    | <--------> | 1  | 10.00    | (Match!)
   | NULL          | <--------> | 4  | 50.00    | (No match, keeps Payment 4!)
   +----+----------+            +----+----------+
```
*In this example, the payment with ID 4 is kept even if no customer is associated with it (though in a well-designed database like Sakila, this is rare due to foreign key constraints).*

## RIGHT JOIN Syntax

The syntax follows the same pattern as other joins:

```sql
SELECT
    table1.column1,
    table2.column2
FROM
    table1
RIGHT JOIN
    table2 ON table1.common_column = table2.common_column;
```

- `RIGHT JOIN`: Ensures all rows from `table2` (the right table) are kept.
- `ON`: Specify the join condition.

## Practical Examples (Sakila Database)

While `RIGHT JOIN` is less common in practice than `LEFT JOIN` (because any `RIGHT JOIN` can be rewritten as a `LEFT JOIN` by swapping table order), it is still important to understand.

### 1. Listing All Addresses and Their Staff
Suppose we want to see all addresses in our system and check if any staff members are currently assigned to them.

```sql
SELECT
    s.first_name,
    s.last_name,
    a.address
FROM
    staff AS s
RIGHT JOIN
    address AS a ON s.address_id = a.address_id
ORDER BY
    s.last_name;
```
*This will return all addresses from the `address` table. If an address has no staff member, the names will be NULL.*

## RIGHT JOIN vs. LEFT JOIN

Every `RIGHT JOIN` can be expressed as a `LEFT JOIN`. Most SQL developers prefer to use `LEFT JOIN` exclusively and simply reorder the tables to keep the "main" table on the left. This usually makes the query easier to read from top to bottom.

**Example of equivalence:**

```sql
-- Using RIGHT JOIN
SELECT f.title, i.inventory_id
FROM film f
RIGHT JOIN inventory i ON f.film_id = i.film_id;

-- Using LEFT JOIN (same result)
SELECT f.title, i.inventory_id
FROM inventory i
LEFT JOIN film f ON i.film_id = f.film_id;
```

## Key Takeaways from This Lesson

- **RIGHT JOIN** returns all rows from the right table.
- It is the **mirror image** of the `LEFT JOIN`.
- Columns from the left table will contain **NULL** where no match is found.
- Most developers prefer **LEFT JOIN** for consistency, but understanding both is essential for reading existing code.
