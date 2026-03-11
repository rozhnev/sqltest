---
title: "SQL Window Frame: ROWS, RANGE, GROUPS, BETWEEN, UNBOUNDED – Complete Guide"
description: "Master SQL window frame options: ROWS, RANGE, GROUPS modes, BETWEEN boundaries, UNBOUNDED PRECEDING/FOLLOWING, CURRENT ROW, and named windows. Practical examples with running totals, moving averages, and cumulative analysis."
keywords: "SQL window frame, ROWS BETWEEN, RANGE BETWEEN, UNBOUNDED PRECEDING, CURRENT ROW, window function boundaries, SQL OVER clause, moving average SQL, running total SQL, window functions tutorial"
lang: "en"
region: "US, GB, CA, AU"
---

# Lesson 7.3: Window Frames — Controlling the Window Boundaries

In the previous lessons, we used window functions with `PARTITION BY` and `ORDER BY`. But the `OVER` clause offers a third, equally powerful component: the **window frame**. A window frame lets you precisely define *which rows* around the current row are included in the calculation — enabling running totals, moving averages, and many other time-series patterns.

## What Is a Window Frame?

When you write `OVER (ORDER BY ...)`, many databases apply a **default frame** that you may not be aware of. Specifying a frame explicitly gives you full control over the calculation window.

The full syntax of the `OVER` clause is:

```sql
function_name() OVER (
    [PARTITION BY partition_expression]
    [ORDER BY sort_expression]
    [frame_clause]
)
```

Where `frame_clause` is:

```sql
{ ROWS | RANGE | GROUPS }
BETWEEN frame_start AND frame_end
```

And each boundary (`frame_start`, `frame_end`) is one of:

| Boundary keyword | Meaning |
|---|---|
| `UNBOUNDED PRECEDING` | The very first row of the partition |
| `n PRECEDING` | n rows (or range units) before the current row |
| `CURRENT ROW` | The current row itself |
| `n FOLLOWING` | n rows (or range units) after the current row |
| `UNBOUNDED FOLLOWING` | The very last row of the partition |

---

## Frame Modes: ROWS, RANGE, and GROUPS

The frame mode controls how the boundaries are measured.

### ROWS Mode

`ROWS` counts **physical rows**. `1 PRECEDING` always means exactly the one row that comes immediately before the current row in the ordering.

Best used when you need a fixed-width sliding window (e.g. a 7-day rolling average over daily rows).

### RANGE Mode

`RANGE` counts **logical values**. `1 PRECEDING` means all rows whose `ORDER BY` value is within 1 unit of the current row's value — not necessarily just one physical row.

Best used when you want to aggregate all rows with the same value as the current row, or all rows within a value range.

**Important:** The default frame when you specify `ORDER BY` but no explicit frame clause is:

```sql
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

This means the window includes all rows from the start of the partition **up to and including all rows with the same ORDER BY value as the current row**.

### GROUPS Mode

`GROUPS` counts **peer groups** (sets of rows with identical `ORDER BY` values). `1 PRECEDING` means the full group of rows that has the next-lower value. This mode is supported in PostgreSQL 11+ and some other databases, but not in MySQL/MariaDB.

---

## Common Frame Patterns

### Running Total (Cumulative Sum)

Include all rows from the start of the partition through the current row:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Output Sample:**
```
customer_id | payment_date | amount | running_total
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 7.98
1           | 2005-07-08   | 11.99  | 19.97
1           | 2005-08-01   | 11.99  | 31.96
```

**Key Point:** Each row's `running_total` accumulates all previous payments for that customer. The frame `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` means: start at row 1 of this partition, end at the current row.

---

### Moving Average (Sliding Window)

Calculate the 3-payment moving average for each customer:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY payment_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Output Sample:**
```
customer_id | payment_date | amount | moving_avg_3
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 3.99
1           | 2005-07-08   | 11.99  | 6.66
1           | 2005-08-01   | 11.99  | 9.66
1           | 2005-08-23   | 5.99   | 9.99
```

**Key Point:** `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` creates a window of exactly 3 rows: the current row and the 2 rows before it. When fewer than 3 rows exist (at the start of a partition), the window shrinks accordingly.

---

### Look Ahead (Including Future Rows)

Calculate the average of the current row and the next 2 rows:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY payment_date
            ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
        ), 2
    ) AS forward_avg
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Key Point:** `CURRENT ROW AND 2 FOLLOWING` shifts the window forward. The last two rows in the partition will average fewer values because there are no rows after them.

---

### Full Partition Aggregate (as a Window)

Compare each payment to the customer's overall average:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ), 2
    ) AS customer_avg,
    amount - ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ), 2
    ) AS deviation
FROM
    payment
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id, payment_date;
```

**Key Point:** `UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` spans the entire partition — equivalent to a `GROUP BY` aggregate but without collapsing rows.

---

## ROWS vs RANGE: A Direct Comparison

Understanding the difference between `ROWS` and `RANGE` is critical when rows share identical `ORDER BY` values.

```sql
SELECT
    customer_id,
    amount,
    SUM(amount) OVER (
        ORDER BY amount
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sum_rows,
    SUM(amount) OVER (
        ORDER BY amount
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sum_range
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    amount;
```

**Output Sample:**
```
customer_id | amount | sum_rows | sum_range
3           | 9.99   | 9.99     | 9.99
2           | 10.99  | 20.98    | 20.98
1           | 11.99  | 32.97    | 55.94
2           | 11.99  | 44.96    | 55.94
1           | 11.99  | 55.94    | 55.94
```

**Observations:**
- With `ROWS`: each physical row is counted individually, regardless of ties. The running sum advances one row at a time.
- With `RANGE`: all rows with the **same amount value** are included together. Both 11.99 rows are treated as part of the same logical group, so `sum_range` skips to the full total immediately.

---

## Named Windows (WINDOW Clause)

If you use the same frame definition multiple times in a query, you can name it with the `WINDOW` clause to avoid repetition:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount)   OVER w AS running_total,
    AVG(amount)   OVER w AS running_avg,
    COUNT(amount) OVER w AS payment_count
FROM
    payment
WHERE
    customer_id = 1
WINDOW w AS (
    PARTITION BY customer_id
    ORDER BY payment_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
ORDER BY
    payment_date;
```

**Key Point:** The `WINDOW w AS (...)` clause defines the frame once. All three window function calls reference it with `OVER w`. This is cleaner, less error-prone, and easier to maintain.

*Note: The `WINDOW` clause is supported in PostgreSQL, MySQL 8.0+, and MariaDB 10.2+.*

---

## Frame Boundaries Reference

| Frame definition | What it includes |
|---|---|
| `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | All rows from partition start to current row |
| `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` | All rows in the partition (full aggregate) |
| `ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING` | Current row plus one row on each side (3-row window) |
| `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` | Current row and the 2 rows before it (3-row sliding window) |
| `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING` | Current row through end of partition |
| `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Default when `ORDER BY` is present; includes all rows with same ORDER BY value as current |

---

## Practical Application: Daily Sales with Running and Moving Metrics

Combine multiple window frames in a single query for a complete picture:

```sql
SELECT
    DATE(payment_date)                            AS payment_day,
    SUM(amount)                                   AS daily_total,
    SUM(SUM(amount)) OVER (
        ORDER BY DATE(payment_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                             AS cumulative_total,
    ROUND(AVG(SUM(amount)) OVER (
        ORDER BY DATE(payment_date)
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2)                                         AS rolling_7day_avg
FROM
    payment
GROUP BY
    DATE(payment_date)
ORDER BY
    payment_day;
```

**Key Point:** The outer aggregate (`SUM(SUM(amount))`) nests a window function over grouped results — a powerful pattern for time-series dashboards.

---

## When to Use Each Frame Option

| Goal | Recommended frame |
|---|---|
| Running / cumulative total | `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Full partition aggregate alongside row data | `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` |
| N-period moving average | `ROWS BETWEEN N-1 PRECEDING AND CURRENT ROW` |
| Symmetric smoothing window | `ROWS BETWEEN N PRECEDING AND N FOLLOWING` |
| Value-based range aggregation (handle ties as a group) | `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Reuse the same frame across multiple functions | Named `WINDOW` clause |

---

## Key Takeaways

- A **window frame** defines the set of rows relative to the current row that are included in a window function calculation.
- The three frame modes are **ROWS** (physical rows), **RANGE** (logical value ranges), and **GROUPS** (peer groups of equal values).
- The default frame when `ORDER BY` is present is `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` — knowing this default prevents subtle bugs with tied values.
- Use **`ROWS`** for fixed-width sliding windows (e.g. 7-day rolling average); use **`RANGE`** when tied values should be aggregated together.
- Boundary keywords: `UNBOUNDED PRECEDING`, `n PRECEDING`, `CURRENT ROW`, `n FOLLOWING`, `UNBOUNDED FOLLOWING`.
- The **`WINDOW`** clause lets you name and reuse a frame definition, keeping complex queries readable.
- Window frames do not affect `PARTITION BY` — they only narrow the frame *within* a partition.

In the next lesson, we'll explore the offset window functions `LAG`, `LEAD`, `FIRST_VALUE`, and `LAST_VALUE`, which let you compare a row's value to values in other rows without self-joins.
