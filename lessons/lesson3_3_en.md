# Lesson 3.3: Core Mathematical Functions in SQL

Mathematical functions in SQL are used to perform calculations on numeric data. They let you round values, find minimum and maximum values, compute remainders, and much more. This lesson covers the most commonly used mathematical functions, with examples based on the Sakila database.

Important: numeric data in SQL can use different types (`INTEGER`, `REAL`/`FLOAT`, `DECIMAL`/`NUMERIC`). The same formula can produce different results depending on the data type (for example, because of integer division, rounding, and precision). If data types are ignored, the final result may differ from what you expect.

## Common Mathematical Functions

### `ABS()` - Returns the absolute value of a number.

**Syntax:**
```sql
ABS(number)
```

**Example:**
```sql
SELECT ABS(amount - 5) AS abs_difference
FROM payment
LIMIT 3;
```
**Result:** Returns the absolute difference between `amount` and 5.

### `CEIL()` / `CEILING()` - Rounds a number up (to the nearest integer).

**Syntax:**
```sql
CEIL(number)
CEILING(number)
```

**Example:**
```sql
SELECT CEIL(amount) AS rounded_up
FROM payment
LIMIT 3;
```
**Result:** Rounds `amount` up to the nearest integer.

### `FLOOR()` - Rounds a number down (to the nearest integer).

**Syntax:**
```sql
FLOOR(number)
```

**Example:**
```sql
SELECT FLOOR(amount) AS rounded_down
FROM payment
LIMIT 3;
```
**Result:** Rounds `amount` down to the nearest integer.

### `ROUND()` - Rounds a number to a specified number of decimal places.

**Syntax:**
```sql
ROUND(number, decimals)
```

**Example:**
```sql
SELECT ROUND(amount, 1) AS rounded_amount
FROM payment
LIMIT 3;
```
**Result:** Rounds `amount` to one decimal place.

### `POWER()` / `POW()` - Raises a number to a power.

**Syntax:**
```sql
POWER(number, exponent)
POW(number, exponent)
```

**Example:**
```sql
SELECT POWER(amount, 2) AS squared_amount
FROM payment
LIMIT 3;
```
**Result:** Squares `amount`.

### `SQRT()` - Returns the square root of a number.

**Syntax:**
```sql
SQRT(number)
```

**Example:**
```sql
SELECT SQRT(amount) AS sqrt_amount
FROM payment
LIMIT 3;
```
**Result:** Returns the square root of `amount`.

### `MOD()` - Returns the remainder of a division.

**Syntax:**
```sql
MOD(dividend, divisor)
```

**Example:**
```sql
SELECT MOD(payment_id, 5) AS mod_result
FROM payment
LIMIT 3;
```
**Result:** Returns the remainder of `payment_id` divided by 5.

### `SIGN()` - Returns the sign of a number (-1, 0, or 1).

**Syntax:**
```sql
SIGN(number)
```

**Example:**
```sql
SELECT SIGN(amount - 5) AS sign_value
FROM payment
LIMIT 3;
```
**Result:** Returns -1 if negative, 0 if zero, and 1 if positive.

### `GREATEST()` - Returns the largest value among the provided values (MySQL, PostgreSQL).

**Syntax:**
```sql
GREATEST(value1, value2, ...)
```

**Example:**
```sql
SELECT GREATEST(amount, 5) AS max_value
FROM payment
LIMIT 3;
```
**Result:** Returns the larger value between `amount` and 5.

**Important (`NULL`):** `GREATEST()` behavior depends on the DBMS.
- In MySQL/MariaDB, if at least one argument is `NULL`, the result is usually `NULL`.
- In PostgreSQL, `NULL` arguments are ignored, and `NULL` is returned only if all arguments are `NULL`.

### `LEAST()` - Returns the smallest value among the provided values (MySQL, PostgreSQL).

**Syntax:**
```sql
LEAST(value1, value2, ...)
```

**Example:**
```sql
SELECT LEAST(amount, 5) AS min_value
FROM payment
LIMIT 3;
```
**Result:** Returns the smaller value between `amount` and 5.

**Important (`NULL`):** `LEAST()` follows the same DBMS-specific `NULL` behavior as `GREATEST()`.

To make behavior predictable across DBMSs, `COALESCE()` is often used, for example:
```sql
SELECT GREATEST(COALESCE(value1, 0), COALESCE(value2, 0));
```

### `RAND()` - Returns a random number between 0 and 1.

**Syntax:**
```sql
RAND()
```

**Example:**
```sql
SELECT RAND() AS random_value
FROM payment
LIMIT 3;
```
**Result:** Returns a random number between 0 and 1.

**Important:** do not assume that `RAND()` is always re-evaluated for every row in every context. Depending on the DBMS, execution plan, use of CTEs/subqueries, and other factors, the same random value can be reused for multiple rows.

If distinct row-level random values are critical, verify behavior on your DBMS and query shape.

## Practical Use Cases

1. **Rounding payment amounts:**
   Use `ROUND(amount, 0)` to round values to whole numbers.

2. **Finding records by remainder:**
   Use `MOD(payment_id, 2)` to separate even and odd payment IDs.

3. **Computing square roots:**
   Use `SQRT(amount)` to analyze payment distributions.

4. **Comparing values:**
   Use `GREATEST()` and `LEAST()` to pick the maximum or minimum from multiple values.

5. **Controlling data types:**
   If precision matters, explicitly cast values to the required type (for example, `CAST(value AS DECIMAL(10,2))`) to avoid surprises caused by integer arithmetic and rounding.

## Key Takeaways from This Lesson

SQL mathematical functions help you calculate, analyze, and transform numeric data. Master these functions to work effectively with numbers in SQL queries. Practice with Sakila-based examples to reinforce your skills.
