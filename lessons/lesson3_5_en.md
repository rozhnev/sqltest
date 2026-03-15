# Lesson 3.5: Conditional Operator `CASE WHEN ... THEN ... END` in SQL

The `CASE` operator in SQL lets you add conditional logic directly inside a query. You can use it to assign categories, return readable labels, filter data with branching rules, and control custom sorting. It is one of the most practical tools when you need smarter SQL without moving logic to application code.

In this lesson, we will cover:

- how `CASE` works;
- how to use it in `SELECT`;
- how to apply `CASE` in `WHERE`;
- how to build custom sorting with `CASE` in `ORDER BY`.

## `CASE` Syntax

`CASE` has two main forms.

### 1) Simple form (`simple CASE`)

```sql
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END
```

This form compares one expression (`expression`) to multiple values.

### 2) Searched form (`searched CASE`)

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

Here, each `WHEN` contains a full condition. This form is more flexible and more commonly used.

Important behavior:

- conditions are evaluated from top to bottom;
- the first matching `WHEN` branch is returned;
- if no condition matches, `ELSE` is used;
- if `ELSE` is omitted, the result is `NULL`.

## `CASE` in `SELECT`

The most common use case is adding a computed column with a category or status label.

### Example: classify payments

```sql
SELECT
    payment_id,
    amount,
    CASE
        WHEN amount < 2 THEN 'Low payment'
        WHEN amount BETWEEN 2 AND 6 THEN 'Medium payment'
        ELSE 'High payment'
    END AS payment_level
FROM payment
LIMIT 10;
```

**What this query does:**

- evaluates `amount` for each row in `payment`;
- assigns one of three categories;
- returns the category in a new column called `payment_level`.

### Example: readable rental status

```sql
SELECT
    rental_id,
    rental_date,
    return_date,
    CASE
        WHEN return_date IS NULL THEN 'Not returned'
        ELSE 'Returned'
    END AS rental_status
FROM rental
LIMIT 10;
```

This approach is useful in reports and dashboards where raw values should be displayed as clear statuses.

## `CASE` in `WHERE`

Although `CASE` is most often used in `SELECT`, it can also be used for filtering. This is useful when filtering rules depend on another column or need branch-specific thresholds.

### Example: different amount threshold per staff member

```sql
SELECT
    payment_id,
    staff_id,
    amount
FROM payment
WHERE amount >= CASE
    WHEN staff_id = 1 THEN 5
    WHEN staff_id = 2 THEN 3
    ELSE 4
END;
```

**Filter logic:**

- for `staff_id = 1`, only payments with `amount >= 5` are included;
- for `staff_id = 2`, only payments with `amount >= 3` are included;
- for all others, threshold is `amount >= 4`.

### When an alternative may be better

For very simple conditions, `OR` can be easier to read. But `CASE` in `WHERE` is helpful when business logic truly branches and should stay in one expression.

## `CASE` in `ORDER BY`

A common requirement is sorting by business priority instead of alphabetical or numeric order. `CASE` is ideal for that.

### Example: custom sort order for film ratings

```sql
SELECT
    title,
    rating
FROM film
ORDER BY CASE rating
    WHEN 'G' THEN 1
    WHEN 'PG' THEN 2
    WHEN 'PG-13' THEN 3
    WHEN 'R' THEN 4
    WHEN 'NC-17' THEN 5
    ELSE 6
END,
 title;
```

**Result:** movies with lighter ratings come first, then stricter ratings, regardless of default string sorting.

### Example: show unreturned rentals first

```sql
SELECT
    rental_id,
    rental_date,
    return_date
FROM rental
ORDER BY CASE
    WHEN return_date IS NULL THEN 0
    ELSE 1
END,
 rental_date DESC
LIMIT 20;
```

This lets you place the most important records at the top.

## Practical Usage

1. **Customer segmentation by spending:**
   ```sql
   SELECT
       customer_id,
       SUM(amount) AS total_spent,
       CASE
           WHEN SUM(amount) < 50 THEN 'Basic'
           WHEN SUM(amount) < 100 THEN 'Active'
           ELSE 'VIP'
       END AS customer_segment
   FROM payment
   GROUP BY customer_id;
   ```

2. **Counting rows by conditional groups:**
   ```sql
   SELECT
       SUM(CASE WHEN amount < 2 THEN 1 ELSE 0 END) AS low_count,
       SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 ELSE 0 END) AS medium_count,
       SUM(CASE WHEN amount > 6 THEN 1 ELSE 0 END) AS high_count
   FROM payment;
   ```

3. **Custom report priority:**
   ```sql
   SELECT
       title,
       replacement_cost
   FROM film
   ORDER BY CASE
       WHEN replacement_cost >= 25 THEN 1
       WHEN replacement_cost >= 20 THEN 2
       ELSE 3
   END,
   replacement_cost DESC;
   ```

## Key Takeaways from This Lesson

`CASE WHEN ... THEN ... END` is a universal tool for conditional SQL logic.

Key points:

- in `SELECT`, it helps build categories and statuses;
- in `WHERE`, it supports branching filter logic;
- in `ORDER BY`, it gives full control over custom sort order;
- in most cases, include `ELSE` to avoid unexpected `NULL` values.

Once you master `CASE`, your SQL queries become more flexible, more readable, and closer to real business logic.
