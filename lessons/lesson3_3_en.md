---
title: "SQL Mathematical Functions: ABS, ROUND, POWER, MOD, and more"
description: "Learn core SQL mathematical functions with Sakila examples: rounding, modulo, powers, roots, and practical calculation scenarios."
keywords: ["SQL mathematical functions", "ABS SQL", "ROUND SQL", "POWER SQL", "MOD SQL", "SQL Sakila"]
teaches: ["How to apply core mathematical functions in SQL queries", "How to account for data types in calculations", "How to use rounding and modulo in practical tasks", "How to use GREATEST and LEAST with DBMS-specific behavior"]
about: ["SQL", "Mathematical functions", "Calculations", "Sakila", "Relational database"]
---

_Lesson 3.3 · Reading time: ~8 min_

In this lesson, you will learn core SQL mathematical functions that help you calculate and transform numeric data directly in queries. We will cover rounding, modulo, powers, roots, and value comparisons, with practical examples from Sakila. By the end of the lesson, you will be able to apply these functions confidently in analytical and practical tasks.

# Core Mathematical Functions in SQL

Mathematical functions in SQL are used to perform calculations on numeric data. They let you round values, find minimum and maximum values, compute remainders, and much more. This lesson covers the most commonly used mathematical functions, with examples based on the Sakila database.

Important: numeric data in SQL can use different types (`INTEGER`, `REAL`/`FLOAT`, `DECIMAL`/`NUMERIC`). The same formula can produce different results depending on the data type (for example, because of integer division, rounding, and precision). If data types are ignored, the final result may differ from what you expect.

<img src="/images/lessons/lesson3_3-math-functions.svg" alt="Core SQL mathematical functions" width="100%">

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

### `PI()` - Returns the mathematical constant pi.

**Syntax:**
```sql
PI()
```

**Example:**
```sql
SELECT PI() AS pi_value;
```
**Result:** Returns the value of pi (approximately `3.141592653589793`).

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

## FAQ

### What is the difference between `ROUND()`, `CEIL()`, and `FLOOR()`?
`ROUND()` rounds to the nearest value (or to a specified decimal place), `CEIL()` always rounds up, and `FLOOR()` always rounds down.

### Why can similar formulas return different results?
The main reason is data types. Integer and decimal types handle division, rounding, and precision differently.

### When should I use `MOD()`?
`MOD()` is useful when you need periodic checks, such as splitting records into groups or filtering even/odd identifiers.

### Why should I care about DBMS differences for `GREATEST()` and `LEAST()`?
Because `NULL` handling can differ between MySQL/MariaDB and PostgreSQL. For predictable behavior, `COALESCE()` is often used.

## Interview Questions

### How do you choose the right rounding function for a business rule?
First define the rule: standard rounding (`ROUND`), always up (`CEIL`), or always down (`FLOOR`). Then validate how it impacts final report metrics.

### What are the risks of calculations without explicit type casting?
You can get unexpected results due to integer division or precision loss. In critical calculations, explicit casts like `CAST(... AS DECIMAL(...))` are safer.

### What does `SIGN()` do, and where is it useful?
`SIGN()` returns `-1`, `0`, or `1` based on the value's sign. It is useful for quick classification of deviations as negative, zero, or positive.

### Why should `RAND()` be used carefully in analytics queries?
Depending on DBMS behavior and execution plans, random values may not be recalculated per row as expected. Always verify behavior on your engine.

---

**Key takeaways from this lesson:**

- SQL mathematical functions help you perform calculations and transformations directly in queries.
- `ROUND`, `CEIL`, and `FLOOR` solve different rounding tasks, and the correct choice depends on business rules.
- `MOD`, `POWER`, and `SQRT` are practical for analytics and data checks.
- Data types strongly affect precision and final calculation results.
- For cross-DB queries, account for DBMS-specific `NULL` behavior in functions.

In the next lesson, we will move on to date and time functions and learn how to work with temporal values in SQL.
