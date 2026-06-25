---
title: Why `SUM() OVER (ORDER BY ...)` Sometimes Feels Wrong: A Practical Guide to SQL Window Frames
published: false
tags: sql, databases, postgres, tutorial
description: Window functions become much easier to reason about once you understand frames. This guide explains ROWS, RANGE, GROUPS, default frames, and practical SQL patterns.
---

Window functions in SQL can make you feel productive very quickly. You learn `PARTITION BY`, add `ORDER BY`, use `ROW_NUMBER()`, `RANK()`, and running totals, and it feels like you already have the mental model.

That was exactly my mistake.

For a while, I thought I understood window functions well enough because my queries were working and the results looked plausible. The confusion only started later, when I began getting results that were syntactically correct but did not match what I expected logically.

A classic example looks like this:

```sql
SUM(amount) OVER (ORDER BY amount)
```

You expect a normal running total. Instead, the result suddenly jumps by multiple rows at once. No SQL error. No broken query. The database is doing exactly what you asked.

The missing piece is usually the same: **the window frame**.

The frame determines **which rows around the current row are actually included in the calculation**. Until that part clicks, window functions are easy to copy from memory but hard to control precisely.

For me, understanding frames was the point where window functions stopped feeling like a bag of handy tricks and started feeling like a consistent system.

When I want to test behavior like this quickly, I usually run the queries in a live environment. For quick experiments I use [sqlize.online](https://sqlize.online), and for more structured SQL practice and lessons I publish material on [sqltest.online](https://sqltest.online).

In this article, I want to walk through:

- what a window frame actually is;
- the difference between `ROWS`, `RANGE`, and `GROUPS`;
- how boundaries like `UNBOUNDED PRECEDING`, `CURRENT ROW`, and `n FOLLOWING` work;
- why the default frame can surprise you;
- how to write running totals and moving averages without hidden assumptions.

## What a window frame is

When we write a window function, we usually see something like this:

```sql
SUM(amount) OVER (
    PARTITION BY customer_id
    ORDER BY payment_date
)
```

When I first started using queries like this, I mentally translated them as: “the function is calculated over the whole `customer_id` partition in `payment_date` order.”

That is not quite right.

`PARTITION BY` defines **which partition the window works inside**.

`ORDER BY` defines **the order of rows inside that partition**.

The **window frame** defines **which subset of rows from that partition is used for the current row’s calculation**.

The full shape looks like this:

```sql
function_name() OVER (
    [PARTITION BY ...]
    [ORDER BY ...]
    [ROWS | RANGE | GROUPS BETWEEN ... AND ...]
)
```

So the mental model is really three layers:

1. Choose the partition.
2. Define the ordering inside that partition.
3. For each row, define the frame: where it starts and where it ends.

## Why this matters

The same `SUM()` can mean completely different things depending on the frame:

- a running total from the start of the partition to the current row;
- a 3-row sliding window;
- an average across the current row and future rows;
- a full-partition aggregate without collapsing rows.

From the outside, these queries can look very similar. Their behavior is not similar at all. That is why window functions can seem simple right up until you hit the first result that looks weird in production.

## Frame boundaries

A frame is usually defined with `BETWEEN ... AND ...`.

The available boundaries are:

- `UNBOUNDED PRECEDING` — start from the first row in the partition;
- `n PRECEDING` — go `n` rows or logical steps backward;
- `CURRENT ROW` — the current row;
- `n FOLLOWING` — go `n` rows or logical steps forward;
- `UNBOUNDED FOLLOWING` — continue to the last row in the partition.

For example:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

That is the classic running-total frame: from the start of the partition up to the current row.

## `ROWS`, `RANGE`, and `GROUPS`: the real difference

This is where things usually become interesting.

### `ROWS`

`ROWS` works with **physical rows**.

If you write:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

that always means exactly three rows:

- the current row;
- the two previous rows.

It does not matter whether those rows have the same `ORDER BY` value or not. The count is based on row positions.

This is the most predictable mode. In most practical analytics work, especially when I need a fixed-width sliding window, `ROWS` is usually where I start.

### `RANGE`

`RANGE` works with a **logical value range**, not physical rows.

If multiple rows share the same `ORDER BY` value, they can enter the frame together as one logical group.

That is why `RANGE` often surprises people.

The most important detail is this: if you specify `ORDER BY` but do **not** define a frame explicitly, many databases use this default:

```sql
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

That means the calculation includes not only all rows before the current row, but also **all rows that share the same ordering value as the current row**.

If your `ORDER BY` column contains duplicates, the result can jump more than you expect.

### `GROUPS`

`GROUPS` works with **peer groups** of equal `ORDER BY` values.

If `ROWS` counts rows and `RANGE` thinks in logical value ranges, `GROUPS` counts groups of equal values.

For example:

```sql
GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW
```

means: take the current peer group and the previous peer group as whole units.

This is useful when your mental model is based on equal-value groups rather than individual rows. PostgreSQL supports it. Support in MySQL and MariaDB is more limited depending on version.

## Example 1: running total

Let’s start with the most common case.

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
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

What happens here:

- rows are partitioned by `customer_id`;
- rows inside the partition are ordered by `payment_date`;
- for each row, the sum runs from the first row in the partition up to the current row.

This is the explicit, correct running-total pattern.

In my own queries, I almost always write this frame explicitly, even if the database would happen to return the expected result without it. Writing the frame makes the behavior obvious and protects you from subtle surprises later.

## Example 2: moving average

Now let’s use a fixed-width window:

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
        ),
        2
    ) AS moving_avg_3
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

For each row, the frame includes:

- the current row;
- the two previous rows.

So the maximum frame width is three rows.

This is a typical case where `ROWS` is the right choice and `RANGE` is not. The goal is a fixed number of rows, not a logical expansion around equal values.

## Example 3: looking forward

Window functions can look ahead as well:

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
        ),
        2
    ) AS forward_avg
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

This kind of frame is useful for things like:

- smoothing;
- local trend analysis;
- short forward-looking comparisons.

Near the end of the partition, the frame naturally shrinks because there are no future rows left.

## Example 4: full-partition aggregate without `GROUP BY`

Sometimes you want to keep row-level detail and still show a partition-level aggregate next to each row:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ),
        2
    ) AS customer_avg
FROM payment
WHERE customer_id IN (1, 2)
ORDER BY customer_id, payment_date;
```

This behaves a bit like `GROUP BY customer_id`, except rows are not collapsed. You still see every row, with the partition average attached to each one.

That pattern is useful when you want to compare a row against its wider context:

- deviation from average;
- share of total;
- comparison with a partition maximum or minimum.

## The main trap: `ROWS` and `RANGE` can produce different running totals

Suppose you have multiple rows with the same `amount`.

Compare these two expressions:

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
FROM payment
WHERE customer_id IN (1, 2, 3)
ORDER BY amount;
```

If `amount = 11.99` appears multiple times, the behavior changes:

- `ROWS` counts one physical row at a time;
- `RANGE` includes all rows with the same `amount` together.

That is why a running total based on `RANGE` can jump several rows at once when there are duplicates in the ordering column.

This is one of the most common sources of confusion I see with window functions. The query is valid. The database is right. The expectation was wrong.

## When I use `ROWS` vs `RANGE`

My rule of thumb is simple.

Use `ROWS` when you want:

- row-by-row running totals;
- moving averages based on a fixed number of rows;
- predictable incremental behavior;
- analytics where each physical row matters separately.

Use `RANGE` when you want:

- calculations based on logical value ranges;
- tied `ORDER BY` values to be treated together;
- behavior tied to the ordering value itself rather than row count.

Use `GROUPS` when the right mental model is “peer groups as units.”

If I am not sure, I almost always start with `ROWS`. It is the most predictable option.

## Named windows

When the same window definition is reused several times in one query, things get noisy fast. That is where the `WINDOW` clause helps:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount)   OVER w AS running_total,
    AVG(amount)   OVER w AS running_avg,
    COUNT(amount) OVER w AS payment_count
FROM payment
WHERE customer_id = 1
WINDOW w AS (
    PARTITION BY customer_id
    ORDER BY payment_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
ORDER BY payment_date;
```

Why I like this approach:

- less duplication;
- lower chance of mistakes;
- easier maintenance;
- the logic of the window lives in one place.

If a query contains several window functions, named windows usually make it much easier to read.

## A practical reporting pattern: daily sales

One of the most useful patterns for reporting and dashboards looks like this:

```sql
SELECT
    DATE(payment_date) AS payment_day,
    SUM(amount) AS daily_total,
    SUM(SUM(amount)) OVER (
        ORDER BY DATE(payment_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_total,
    ROUND(
        AVG(SUM(amount)) OVER (
            ORDER BY DATE(payment_date)
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_7day_avg
FROM payment
GROUP BY DATE(payment_date)
ORDER BY payment_day;
```

This gives you two very useful metrics immediately:

- `cumulative_total` for the running total;
- `rolling_7day_avg` for a 7-day moving average.

Notice the `SUM(SUM(amount)) OVER (...)` pattern: first we aggregate by day, then we apply a window function over the grouped result.

I like this example because it shows the practical value of frames very quickly. In one query, you get accumulation, smoothing, and a solid base for a chart or dashboard.

## Where this topic kept breaking for me

If I reduce my own mistakes here to a short list, they usually came from three things:

- mentally substituting “the whole partition” where only the current frame was actually used;
- forgetting that `RANGE` does not behave like `ROWS` when `ORDER BY` values are duplicated;
- relying too long on defaults instead of writing the frame explicitly.

Once I started asking one extra question for every window query, most of the confusion went away:

**Which exact rows should be included in the calculation for the current row?**

That question alone removes a lot of the magic.

## What is worth remembering

A window frame is not about the partition itself and not about ordering by itself. It is specifically about **the boundaries of rows included in the current calculation**.

In short:

- `PARTITION BY` splits data into partitions;
- `ORDER BY` defines order inside a partition;
- the frame defines which rows around the current row are included in the calculation.

The three most useful patterns to remember are:

- running total:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

- full partition:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
```

- 3-row sliding window:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

And the most important trap is this:

- if you have `ORDER BY` but no explicit frame, many databases will use `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`.

Which means duplicate ordering values can change the result in ways that are easy to miss.

## Final thought

Window functions only became intuitive for me once I stopped thinking in terms of just partitions and ordering and started thinking in terms of **frames**.

If you want to write analytical SQL with confidence, it is worth building one habit:

- do not rely on the default frame;
- write it explicitly;
- choose between `ROWS` and `RANGE` on purpose;
- remember that ties in `ORDER BY` change frame behavior.

If I had to leave one practical takeaway from this entire article, it would be this:

**When you write a window function, do not think only about `PARTITION BY` and `ORDER BY`. Ask one more question: which exact rows should participate in the calculation for the current row?**

Once that answer is explicit, window queries become much more reliable and much easier to reason about.

If you want to experiment with `ROWS`, `RANGE`, and `GROUPS` directly, [sqlize.online](https://sqlize.online) is the easiest place to test queries quickly. If you want a more structured way to study SQL through lessons and practice, I publish that work on [sqltest.online](https://sqltest.online).
