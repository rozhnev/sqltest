---
title: "SQL Ranking Functions: ROW_NUMBER vs RANK vs DENSE_RANK vs NTILE Tutorial"
description: "Master SQL ranking functions: ROW_NUMBER, RANK, DENSE_RANK, NTILE. Learn the differences and when to use each function with practical MySQL examples. Complete guide for data analysis."
keywords: "SQL ranking functions, ROW_NUMBER, RANK, DENSE_RANK, NTILE, window functions SQL, SQL tutorial, data ranking, analytical SQL, MySQL ranking"
lang: "en"
region: "US, GB, CA, AU"
---

# Lesson 7.2: Using ROW_NUMBER, RANK, DENSE_RANK, and NTILE

In the previous lesson, we introduced window functions and explored `ROW_NUMBER()`. Now we'll dive deeper into the family of ranking functions that SQL offers: `ROW_NUMBER`, `RANK`, `DENSE_RANK`, and `NTILE`. Each has a distinct purpose and understanding when to use each one is crucial for effective data analysis.

## Understanding the Differences

All four functions assign a numeric value to rows based on ordering, but they handle ties (equal values) differently. Let's explore each one.

### ROW_NUMBER(): Unique Sequential Numbers

`ROW_NUMBER()` assigns a unique sequential number to each row, even if values are identical. It treats ties as different rows.

**Syntax:**
```sql
ROW_NUMBER() OVER (
    [PARTITION BY partition_expression]
    ORDER BY sort_expression
)
```

**Example: Ranking Transactions**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Output Sample:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Key Point:** Even though the first two customer 1 payments have identical amounts (11.99), they receive different row numbers (1 and 2).

### RANK(): Ranking with Gaps

`RANK()` assigns the same rank to rows with identical ordering values, but leaves gaps in the numbering sequence. If two rows tie for rank 1, the next rank is 3 (skipping 2).

**Syntax:**
```sql
RANK() OVER (
    [PARTITION BY partition_expression]
    ORDER BY sort_expression
)
```

**Example: Ranking Payments by Amount**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    RANK() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Output Sample:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Key Point:** Both customer 1 payments of 11.99 receive rank 1, and the next payment gets rank 3 (not 2). This is useful when you want to identify ties but preserve ranking position in the full dataset.

### DENSE_RANK(): Ranking Without Gaps

`DENSE_RANK()` is similar to `RANK()` but doesn't skip numbers. If two rows tie for rank 1, the next rank is 2 (not 3).

**Syntax:**
```sql
DENSE_RANK() OVER (
    [PARTITION BY partition_expression]
    ORDER BY sort_expression
)
```

**Example: Dense Ranking Payment Amounts**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    DENSE_RANK() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Output Sample:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 2
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Key Point:** Both customer 1 payments of 11.99 receive rank 1, and the next distinct amount gets rank 2. No gaps in the ranking sequence. This is ideal when you want to identify distinct groups without gaps.

### NTILE(): Distributing Rows into Buckets

`NTILE(n)` divides the partition into n groups (buckets) and assigns each row a bucket number. This is useful for percentile analysis and bucketing data into quartiles, tertiles, etc.

**Syntax:**
```sql
NTILE(number_of_buckets) OVER (
    [PARTITION BY partition_expression]
    ORDER BY sort_expression
)
```

**Example: Quartile Analysis**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    NTILE(4) OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS quartile
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    quartile;
```

**Output Sample:**
```
customer_id | amount | payment_date | quartile
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Key Point:** Rows are distributed into 4 quartiles. This is extremely useful for percentile analysis—identifying top 25% (quartile 1), next 25% (quartile 2), etc.

## Side-by-Side Comparison

Let's see all four functions applied to the same data:

```sql
SELECT
    customer_id,
    amount,
    row_number() OVER (ORDER BY amount DESC) AS row_num,
    rank() OVER (ORDER BY amount DESC) AS rnk,
    dense_rank() OVER (ORDER BY amount DESC) AS dense_rnk,
    ntile(3) OVER (ORDER BY amount DESC) AS tertile
FROM
    payment
LIMIT 10;
```

**Output Sample:**
```
customer_id | amount | row_num | rnk | dense_rnk | tertile
1           | 11.99  | 1       | 1   | 1         | 1
1           | 11.99  | 2       | 1   | 1         | 1
2           | 11.99  | 3       | 1   | 1         | 1
5           | 10.99  | 4       | 4   | 2         | 1
6           | 10.99  | 5       | 4   | 2         | 1
3           | 9.99   | 6       | 6   | 3         | 2
4           | 9.99   | 7       | 6   | 3         | 2
7           | 8.99   | 8       | 8   | 4         | 3
8           | 8.99   | 9       | 8   | 4         | 3
9           | 7.99   | 10      | 10  | 5         | 3
```

**Observations:**
- `row_number`: Always unique, no gaps
- `rank`: Groups ties but creates gaps (1, 1, 1, 4, 4, 6, 6, 8, 8, 10)
- `dense_rank`: Groups ties without gaps (1, 1, 1, 2, 2, 3, 3, 4, 4, 5)
- `ntile(3)`: Distributes into 3 groups based on ordering

## Practical Applications

### Finding Top Performers (ROW_NUMBER)

Get the highest-paying customer per rental month:

```sql
WITH ranked_payments AS (
    SELECT
        customer_id,
        amount,
        DATE_TRUNC('month', payment_date) AS month,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_TRUNC('month', payment_date)
            ORDER BY amount DESC
        ) AS rank
    FROM
        payment
)
SELECT
    customer_id,
    amount,
    month
FROM
    ranked_payments
WHERE
    rank = 1
ORDER BY
    month DESC;
```

### Identifying Performance Tiers (DENSE_RANK)

Categorize films by rental frequency:

```sql
WITH rental_counts AS (
    SELECT
        film_id,
        COUNT(*) AS rental_count,
        DENSE_RANK() OVER (
            ORDER BY COUNT(*) DESC
        ) AS popularity_tier
    FROM
        rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
    GROUP BY
        film_id
)
SELECT
    film_id,
    rental_count,
    CASE
        WHEN popularity_tier = 1 THEN 'Blockbuster'
        WHEN popularity_tier <= 3 THEN 'Popular'
        WHEN popularity_tier <= 10 THEN 'Standard'
        ELSE 'Niche'
    END AS popularity_category
FROM
    rental_counts
LIMIT 20;
```

### Percentile Analysis (NTILE)

Segment customers into spending quartiles:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        NTILE(4) OVER (ORDER BY SUM(amount)) AS spending_quartile
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    spending_quartile,
    COUNT(*) AS customer_count,
    MIN(total_spent) AS low_amount,
    MAX(total_spent) AS high_amount
FROM
    customer_spending
GROUP BY
    spending_quartile
ORDER BY
    spending_quartile;
```

## When to Use Each Function

| Function | Use Case | Handles Ties |
|----------|----------|--------------|
| `ROW_NUMBER` | Need unique sequential numbers; don't care about ties | No (all unique) |
| `RANK` | Need to identify position but account for ties; gaps are OK | Yes (with gaps) |
| `DENSE_RANK` | Need tier identification without position gaps | Yes (no gaps) |
| `NTILE` | Need percentile/quartile/bucket analysis | Distributes into groups |

## Key Takeaways

- **ROW_NUMBER()** gives each row a unique number, useful for getting top N records from each group.
- **RANK()** assigns the same rank to tied values but skips ranks (1, 1, 3), useful for competitive rankings.
- **DENSE_RANK()** assigns the same rank to tied values without gaps (1, 1, 2), useful for tier identification.
- **NTILE(n)** divides rows into buckets for percentile and distributional analysis.
- All four functions are part of the window function family and use the `OVER` clause.
- The key difference is how they handle identical values in the ordering column.
- Choosing the right function depends on your analytical goal: positioning, grouping, or distribution.

In the next lesson, we'll explore advanced window function concepts including window frames, partitioning strategies, and other analytical functions like `LAG`, `LEAD`, `FIRST_VALUE`, and `LAST_VALUE`.
