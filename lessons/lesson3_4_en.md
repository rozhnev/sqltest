# Lesson 3.4: Common Mathematical Functions in SQL

Mathematical functions in SQL are used to perform various calculations on numeric data. They allow you to round values, find minimum and maximum values, calculate sums, averages, remainders, and much more. This lesson covers the most commonly used mathematical functions with examples based on the Sakila database.

## Common Mathematical Functions

### `ABS()` — Returns the absolute value of a number.

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
**Result:** Returns the absolute difference between the value of `amount` and 5.

### `CEIL()` / `CEILING()` — Rounds a number up to the nearest integer.

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
**Result:** Rounds the value of `amount` up to the nearest integer.

### `FLOOR()` — Rounds a number down to the nearest integer.

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
**Result:** Rounds the value of `amount` down to the nearest integer.

### `ROUND()` — Rounds a number to a specified number of decimal places.

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
**Result:** Rounds the value of `amount` to one decimal place.

### `POWER()` / `POW()` — Raises a number to a power.

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
**Result:** Raises the value of `amount` to the power of 2.

### `SQRT()` — Returns the square root of a number.

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
**Result:** Returns the square root of the value of `amount`.

### `MOD()` — Returns the remainder of dividing one number by another.

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
**Result:** Returns the remainder of dividing `payment_id` by 5.

### `SIGN()` — Returns the sign of a number (-1, 0, or 1).

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
**Result:** Returns -1 if the difference is negative, 0 if zero, 1 if positive.

### `GREATEST()` — Returns the largest of the given values (MySQL, PostgreSQL).

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
**Result:** Returns the greater of the two values: `amount` or 5.

### `LEAST()` — Returns the smallest of the given values (MySQL, PostgreSQL).

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
**Result:** Returns the lesser of the two values: `amount` or 5.

### `RAND()` — Returns a random number between 0 and 1.

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
**Result:** Returns a random number for each row.

## Practical Usage

1. **Rounding payment amounts:**
   Use `ROUND(amount, 0)` to round the amount to the nearest integer.

2. **Finding payments with a remainder:**
   Use `MOD(payment_id, 2)` to find even and odd payments.

3. **Calculating square roots:**
   Use `SQRT(amount)` to analyze the distribution of payments.

4. **Comparing values:**
   Use `GREATEST()` and `LEAST()` to select the maximum or minimum value from multiple columns.

## Key Takeaways from This Lesson

SQL mathematical functions allow you to perform calculations, analyze, and transform numeric data. Master these functions for effective work with numbers in your SQL queries. Practice with examples from the Sakila database to reinforce your skills.
