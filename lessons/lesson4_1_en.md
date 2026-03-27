# Lesson 4.1: Basic Aggregation Functions in SQL

Aggregation functions in SQL are used to perform calculations on multiple rows of a table's column and return a single value. These functions are essential for summarizing data, generating reports, and performing statistical analysis. This lesson covers the most common aggregation functions with practical examples based on the Sakila database.

## Common Aggregation Functions

### `COUNT()` — Counts the number of rows

**Syntax:**
```sql
COUNT(expression)
```

**Example:**
```sql
SELECT COUNT(*) AS total_payments
FROM payment;
```
**Result:** Returns the total number of rows in the `payment` table.

### `COUNT(column)` vs `COUNT(*)`

These two forms are similar but not identical:

- `COUNT(*)` counts **all rows** in the result set.
- `COUNT(column)` counts only rows where `column` is **NOT NULL**.

So, if the column contains `NULL` values, `COUNT(column)` can return a smaller number than `COUNT(*)`.

**Example (Sakila):**
```sql
SELECT
   COUNT(*) AS total_rentals,
   COUNT(return_date) AS returned_rentals
FROM rental;
```

**Explanation:**

- `total_rentals` counts every row in `rental`.
- `returned_rentals` counts only rows where `return_date` has a value.
- Rentals that are not returned yet have `return_date = NULL`, so they are excluded from `COUNT(return_date)`.

### `SUM()` — Calculates the sum of values

**Syntax:**
```sql
SUM(expression)
```

**Example:**
```sql
SELECT SUM(amount) AS total_amount
FROM payment;
```
**Result:** Returns the total sum of the `amount` column.

**Comment:** `SUM(amount)` ignores `NULL`. If all values in the set are `NULL`, the result is `NULL`.

### `AVG()` — Calculates the average value

**Syntax:**
```sql
AVG(expression)
```

**Example:**
```sql
SELECT AVG(amount) AS average_amount
FROM payment;
```
**Result:** Returns the average value of the `amount` column.

**Comment:** `AVG(amount)` includes only rows where `amount` is not `NULL`.

If you need to include rows with `NULL` in the row count (denominator), use one of these options:

```sql
SELECT
   AVG(amount) AS avg_ignore_null,
   AVG(COALESCE(amount, 0)) AS avg_include_null_as_zero,
   SUM(amount) / COUNT(*) AS avg_sum_div_all_rows
FROM payment;
```

**Explanation:**

- `avg_ignore_null` is standard `AVG` behavior, where `NULL` values are ignored.
- `avg_include_null_as_zero` replaces `NULL` with `0`, so all rows are included in the calculation.
- `avg_sum_div_all_rows` divides the sum by the total number of rows (`COUNT(*)`), which also includes rows with `NULL` in the denominator.

### `MAX()` — Finds the maximum value

**Syntax:**
```sql
MAX(expression)
```

**Example:**
```sql
SELECT MAX(amount) AS max_amount
FROM payment;
```
**Result:** Returns the largest value in the `amount` column.

**Comment:** `MAX(amount)` ignores `NULL`. If all values are `NULL`, the result is `NULL`.

### `MIN()` — Finds the minimum value

**Syntax:**
```sql
MIN(expression)
```

**Example:**
```sql
SELECT MIN(amount) AS min_amount
FROM payment;
```
**Result:** Returns the smallest value in the `amount` column.

**Comment:** `MIN(amount)` ignores `NULL`. If all values are `NULL`, the result is `NULL`.

#### `MIN(column)` and `ORDER BY column LIMIT 1` — are they always the same?

Not always.

Compare:

```sql
SELECT MIN(column_name) FROM table_name;
SELECT column_name FROM table_name ORDER BY column_name LIMIT 1;
```

- `MIN(column_name)` ignores `NULL` and finds the minimum among non-`NULL` values.
- `ORDER BY column_name LIMIT 1` returns the first row after sorting.
- If `NULL` is sorted first in your DBMS (for example, in MySQL/MariaDB with `ASC`), the second query may return `NULL`, while `MIN()` still returns the minimum non-`NULL` value.

They match if:

- there are no `NULL` values in the column,
- or `NULL` is sorted last,
- or you explicitly exclude `NULL`.

**Reliable version equivalent to `MIN()`:**

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NOT NULL
ORDER BY column_name
LIMIT 1;
```

## Practical Usage

1. **Counting the number of customers:**
   Use `COUNT(*)` to find out how many customers are in the database.
   ```sql
   SELECT COUNT(*) AS total_customers
   FROM customer;
   ```
2. **Calculating total sales per staff:**
   Use `SUM(amount)` with `GROUP BY staff_id` to see sales by each staff member.
   ```sql
   SELECT staff_id, SUM(amount) AS staff_total
   FROM payment
   GROUP BY staff_id;
   ```
3. **Finding the average payment per customer:**
   Use `AVG(amount)` with `GROUP BY customer_id`.
   ```sql
   SELECT customer_id, AVG(amount) AS avg_payment
   FROM payment
   GROUP BY customer_id;
   ```

## Key Takeaways from This Lesson

SQL aggregation functions are powerful tools for summarizing and analyzing data. Mastering `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX` will help you generate meaningful reports and insights from your database. Practice these functions with the Sakila database to strengthen your SQL skills.
