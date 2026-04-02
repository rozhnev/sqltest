This lesson is dedicated to the `UPDATE` statement — the command that allows you to modify existing records in a database table. You will learn the basic syntax for updating one or more columns, how to use the `WHERE` clause to target specific rows, and the important rules for using `UPDATE` safely. We will also cover updating multiple rows at once and using current column values in expressions.

Title: Updating Data

# Lesson 8.2: The UPDATE Statement

In the previous lesson, we learned how to add new rows using `INSERT INTO`. Now let's look at how to **modify already existing data** with the `UPDATE` statement. This is one of the key DML operations that keeps your database current and accurate.

## Basic Syntax

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

*   `UPDATE table_name` — specifies the table in which you want to change data.
*   `SET column = value` — assigns new values to one or more columns.
*   `WHERE condition` — determines which rows will be updated.

---

## Important Rules

*   **Always use `WHERE`:** Without a `WHERE` clause, the `UPDATE` statement will modify **every row** in the table. This is one of the most common and dangerous mistakes.
*   **Data Types:** New values must match the data type of the column.
*   **Strings and Dates:** Text values and dates must be enclosed in single quotes (`'`).
*   **Numbers:** Numeric values do not require quotes.
*   **Transactions:** In production systems, it is recommended to run `UPDATE` inside a transaction so you can roll back changes in case of an error.

---

## Examples

### Example 1: Updating a Single Column
Let's change the email address of a specific customer in the `customer` table.

```sql
UPDATE customer
SET email = 'new.email@example.com'
WHERE customer_id = 1;
```

*Note: The `WHERE customer_id = 1` condition ensures that only one specific record is changed.*

### Example 2: Updating Multiple Columns at Once
You can list multiple columns in the `SET` clause, separated by commas.

```sql
UPDATE customer
SET first_name = 'ALICE',
    last_name  = 'COOPER',
    email      = 'alice.cooper@example.com'
WHERE customer_id = 42;
```

### Example 3: Using the Current Value in an Expression
The `UPDATE` statement allows you to calculate a new value based on the current one. For example, let's increase the rental rate for all Comedy films by 10%:

```sql
UPDATE film
SET rental_rate = rental_rate * 1.10
WHERE film_id IN (
    SELECT f.film_id
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c       ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy'
);
```

*Result: The rental rate for all Comedy films will increase by 10%.*

### Example 4: Updating Multiple Rows by Condition
Let's mark all inactive customers who haven't rented anything after a certain date:

```sql
UPDATE customer
SET active = 0
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM rental
    WHERE rental_date >= '2005-08-01'
);
```

### Example 5: Setting a Value to NULL
If a column allows `NULL`, you can explicitly clear it:

```sql
UPDATE film
SET original_language_id = NULL
WHERE film_id = 10;
```

---

## Verify Before Updating

A good practice is to run a `SELECT` with the same `WHERE` condition first, to confirm that the right rows will be affected:

```sql
-- First, check what SELECT returns
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id = 1;

-- Only after verifying, run the UPDATE
UPDATE customer
SET email = 'new.email@example.com'
WHERE customer_id = 1;
```

---

**Key Takeaways from this Lesson:**

*   The `UPDATE` statement modifies existing rows in a table.
*   Without a `WHERE` clause, **all** rows in the table will be updated — always double-check it is present.
*   Multiple columns can be updated in a single `SET` clause, separated by commas.
*   A new column value can be calculated from its current value (e.g., `price = price * 1.1`).
*   Before running an `UPDATE`, it is recommended to run a `SELECT` with the same condition to verify the affected rows.

In the next lesson, we will explore the **DELETE** statement — how to remove rows from a table safely and with control.
