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

## Practical Usage

1. **Counting the number of customers:**
   Use `COUNT(customer_id)` to find out how many customers are in the database.
   ```sql
   SELECT COUNT(customer_id) AS total_customers
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
