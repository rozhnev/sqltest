---
title: "SQL Common Table Expressions (CTEs): WITH Clause Tutorial & Examples"
description: "Master SQL Common Table Expressions (CTEs). Learn WITH clause syntax, benefits over subqueries, and practical examples. Complete guide for writing cleaner, more maintainable SQL queries."
keywords: "SQL CTE, common table expression, WITH clause SQL, SQL subquery alternative, query readability, SQL tutorial, advanced SQL, MySQL CTE, PostgreSQL CTE"
lang: "en"
region: "US, GB, CA, AU"
---

# Lesson 6.4: Common Table Expressions (CTEs)

Common Table Expressions, or CTEs, are one of the most powerful and underutilized features in SQL. They allow you to define temporary named result sets that can be referenced within a larger query. In this lesson, we'll explore how CTEs can make your SQL code more readable, maintainable, and easier to debug.

## What Are CTEs?

A **Common Table Expression (CTE)** is a temporary result set defined at the beginning of a query using the `WITH` clause. Think of it as a named subquery that can be used multiple times within the same query.

The key advantages of CTEs:
- **Readability**: Named result sets make queries easier to understand
- **Reusability**: Reference the same CTE multiple times without redefining it
- **Modularity**: Break complex queries into logical, manageable pieces
- **Maintainability**: Changes to the logic only need to be made in one place
- **Debugging**: Test each CTE independently before combining them

## Basic CTE Syntax

The general syntax for a CTE is:

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;
```

**Components:**
- **WITH**: Keyword that introduces the CTE
- **cte_name**: The name you give to the temporary result set
- **AS**: Keyword introducing the query definition
- **(SELECT ...)**: The query that defines the CTE
- The main query can then reference the CTE by name

## Your First CTE

Let's start with a simple example that calculates customer spending:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        COUNT(*) AS payment_count,
        AVG(amount) AS avg_payment
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_spent,
    payment_count,
    avg_payment
FROM
    customer_spending
WHERE
    total_spent > 100
ORDER BY
    total_spent DESC;
```

This CTE:
1. Defines a named result set called `customer_spending`
2. Calculates spending metrics for each customer
3. References this CTE in the main query to filter for high-spending customers

The benefit here is clarity—the intent is obvious: we're working with customer spending data.

## CTEs vs Subqueries

Let's compare the same logic using a traditional subquery approach:

**Using a Subquery:**
```sql
SELECT
    customer_id,
    total_spent,
    payment_count,
    avg_payment
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        COUNT(*) AS payment_count,
        AVG(amount) AS avg_payment
    FROM
        payment
    GROUP BY
        customer_id
) AS spending_data
WHERE
    total_spent > 100
ORDER BY
    total_spent DESC;
```

**Using a CTE:**
```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        COUNT(*) AS payment_count,
        AVG(amount) AS avg_payment
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_spent,
    payment_count,
    avg_payment
FROM
    customer_spending
WHERE
    total_spent > 100
ORDER BY
    total_spent DESC;
```

**Key Differences:**
- The CTE is defined at the top, making the query structure immediately clear
- The CTE has a meaningful name (`customer_spending`), not just an anonymous subquery
- The main query intent is visible before diving into data transformations
- If you needed to reference this result set multiple times, you only define it once with a CTE

## Multiple CTEs in One Query

You can define multiple CTEs in a single query, each referencing the previous ones:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM
        payment
    GROUP BY
        customer_id
),
high_spenders AS (
    SELECT
        customer_id,
        total_spent
    FROM
        customer_spending
    WHERE
        total_spent > 150
),
customer_details AS (
    SELECT
        hs.customer_id,
        hs.total_spent,
        c.first_name,
        c.last_name,
        c.email
    FROM
        high_spenders hs
    JOIN
        customer c ON hs.customer_id = c.customer_id
)
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    email,
    total_spent
FROM
    customer_details
ORDER BY
    total_spent DESC;
```

In this query:
1. `customer_spending` calculates total spent per customer
2. `high_spenders` filters for customers with total spent > 150
3. `customer_details` joins high spenders with customer information
4. The main query selects and formats the final results

This structure makes the logic flow clear and easy to follow.

## CTE Reusability

One powerful aspect of CTEs is referencing yourself multiple times:

```sql
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', payment_date) AS month,
        SUM(amount) AS monthly_total
    FROM
        payment
    GROUP BY
        DATE_TRUNC('month', payment_date)
)
SELECT
    m1.month AS current_month,
    m1.monthly_total AS current_sales,
    m2.monthly_total AS previous_month_sales,
    ROUND(((m1.monthly_total - m2.monthly_total) / m2.monthly_total * 100), 2) AS percent_change
FROM
    monthly_sales m1
LEFT JOIN
    monthly_sales m2 ON m1.month = m2.month + INTERVAL '1 month'
WHERE
    m1.month IS NOT NULL
ORDER BY
    m1.month;
```

Here, we reference `monthly_sales` twice—once as `m1` and once as `m2`. This would require two separate subqueries if we weren't using a CTE.

## CTE with Window Functions

CTEs work beautifully with window functions:

```sql
WITH ranked_rentals AS (
    SELECT
        customer_id,
        rental_date,
        return_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY rental_date DESC
        ) AS rental_rank
    FROM
        rental
),
most_recent_rental AS (
    SELECT
        customer_id,
        rental_date,
        return_date
    FROM
        ranked_rentals
    WHERE
        rental_rank = 1
)
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    mrr.rental_date AS last_rental_date,
    DATEDIFF(CURDATE(), mrr.rental_date) AS days_since_rental
FROM
    customer c
LEFT JOIN
    most_recent_rental mrr ON c.customer_id = mrr.customer_id
ORDER BY
    days_since_rental DESC
LIMIT 20;
```

This query:
1. Uses `ROW_NUMBER()` to identify each customer's most recent rental
2. Filters to get only the most recent rental per customer
3. Joins with the customer table to show customer names and calculate days since rental

The modular structure makes it easy to understand and modify.

## Practical Example: Cohort Analysis

CTEs are excellent for complex analytical queries like cohort analysis:

```sql
WITH customer_first_rental AS (
    SELECT
        customer_id,
        MIN(rental_date) AS first_rental_date,
        DATE_TRUNC('month', MIN(rental_date)) AS cohort_month
    FROM
        rental
    GROUP BY
        customer_id
),
customer_rental_history AS (
    SELECT
        cfr.customer_id,
        cfr.cohort_month,
        DATE_TRUNC('month', r.rental_date) AS rental_month,
        COUNT(*) AS rentals_in_month
    FROM
        customer_first_rental cfr
    JOIN
        rental r ON cfr.customer_id = r.customer_id
    GROUP BY
        cfr.customer_id,
        cfr.cohort_month,
        DATE_TRUNC('month', r.rental_date)
)
SELECT
    cohort_month,
    rental_month,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(rentals_in_month) AS total_rentals
FROM
    customer_rental_history
GROUP BY
    cohort_month,
    rental_month
ORDER BY
    cohort_month,
    rental_month;
```

This complex analysis becomes manageable through CTEs:
1. First CTE identifies each customer's cohort (first rental month)
2. Second CTE builds a history of all rentals with cohort information
3. Final query aggregates to show cohort performance over time

## Benefits Summary

| Aspect | CTE | Subquery |
|--------|-----|----------|
| Readability | Highly readable with named result sets | Can become hard to read (nested structures) |
| Reusability | Easy to reference multiple times | Must redefine for each use |
| Debugging | Can test each CTE independently | Difficult to isolate specific logic |
| Organization | Logical, top-down structure | Linear but sometimes cluttered |
| Performance | Same or better (optimizer-dependent) | Can be less efficient with deep nesting |

## Key Takeaways

- **CTEs** are temporary named result sets defined with the `WITH` clause
- **Readability**: Named CTEs make queries self-documenting
- **Multiple CTEs**: Chain CTEs together, each building on the previous
- **Reusability**: Reference the same CTE multiple times without redefining it
- **No Performance Penalty**: CTEs don't create intermediate storage; they're query optimization tools
- **Works with Everything**: CTEs can include joins, aggregations, window functions, and more
- **Modularity**: Break complex queries into logical pieces that are easier to understand and maintain

CTEs transform complex queries from unintelligible nested structures into clear, readable, maintainable code. They're an essential tool in any data analyst's toolkit.

In the next lesson, we'll explore recursive CTEs—a powerful feature for working with hierarchical data.
