This lesson is dedicated to the `DELETE` statement — the command that removes existing rows from a database table. You will learn the basic syntax of deletion, how to safely use the `WHERE` clause, examples of targeted and bulk deletion, and how to verify a query before executing it. By the end of this lesson, you will be able to remove data carefully and with confidence.

Title: Deleting Data

# Lesson 8.3: The DELETE Statement

In the previous lesson, we learned how to modify records using `UPDATE`. Now let's look at how to **remove unnecessary or outdated rows** with the `DELETE` statement. This is an important DML command that should be used especially carefully, because deleted data cannot always be easily recovered.

## Basic Syntax

```sql
DELETE FROM table_name
WHERE condition;
```

*   `DELETE FROM table_name` — specifies the table from which rows will be removed.
*   `WHERE condition` — determines which rows will be deleted.

If `WHERE` is omitted, **all rows** in the table will be deleted.

---

## Important Rules

*   **Always check the `WHERE` clause:** a mistake in the condition can delete the wrong data or too many rows.
*   **Run `SELECT` first:** before using `DELETE`, it is good practice to run `SELECT` with the same condition and make sure the result is correct.
*   **The table structure remains:** `DELETE` removes only data, not the table itself or its columns.
*   **Related data matters:** if foreign keys are defined, the database may prevent deletion of rows that are referenced by other tables.
*   **Transactions:** in production systems, it is safer to run important deletions inside a transaction.

---

## Examples

### Example 1: Deleting one row
Let's remove one customer by their identifier:

```sql
DELETE FROM customer
WHERE customer_id = 1;
```

*Note: thanks to `WHERE customer_id = 1`, only one specific row will be deleted.*

### Example 2: Deleting multiple rows by condition
Let's delete payment records made before a certain date:

```sql
DELETE FROM payment
WHERE payment_date < '2005-05-25';
```

*Result: all rows in `payment` with a payment date earlier than the specified date will be removed.*

### Example 3: Deleting with a subquery
Sometimes you need to delete rows based on a condition from another table. For example, let's remove payments made by inactive customers:

```sql
DELETE FROM payment
WHERE customer_id IN (
    SELECT customer_id
    FROM customer
    WHERE active = 0
);
```

*Result: all payments of customers marked as inactive will be deleted.*

### Example 4: Deleting all rows from a table
If you need to completely clear a table, `DELETE` can also be used without `WHERE`:

```sql
DELETE FROM temp_import;
```

*Note: the `temp_import` table will still exist, but all of its rows will be removed.*

---

## Checking Before Deleting

A good practice is to first inspect which rows will be affected:

```sql
-- First check the rows
SELECT customer_id, first_name, last_name, active
FROM customer
WHERE active = 0;

-- Only after verifying, run the DELETE
DELETE FROM customer
WHERE active = 0;
```

This approach helps avoid accidentally deleting extra data.

---

## When `DELETE` Is Especially Useful

- cleaning temporary or test data;
- removing outdated records by date;
- deleting rows that no longer meet business rules;
- preparing tables for reloading data.

---

**Key takeaways from this lesson:**

*   `DELETE` removes existing rows from a table.
*   Without `WHERE`, **all** rows in the table will be deleted.
*   Before deleting, it is advisable to run `SELECT` with the same condition.
*   `DELETE` keeps the table structure intact — only the data is removed.
*   In important scenarios, it is safer to use transactions and consider foreign keys.
