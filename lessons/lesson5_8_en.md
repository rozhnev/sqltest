Master practical SQL JOIN scenarios to solve real-world data analysis problems. This lesson covers joining multiple tables, using aggregate functions with joins for reporting, and identifying missing data. Learn how to combine JOIN and GROUP BY to extract deeper insights from the Sakila database.

# Lesson 5.8: Practical JOIN Scenarios and Techniques

So far, we have explored the mechanics of different join types. In this lesson, we will move beyond the basics and look at how to apply joins to solve common business problems, handle multiple tables, and combine joins with aggregation.

## 1. Joining Multiple Tables (3+)

In complex databases, the data you need is often spread across three or more tables connected by junction tables. 

**Scenario:** We want to see a list of actors and the titles of the films they have appeared in.
This requires three tables: `actor`, `film_actor` (the bridge), and `film`.

```sql
SELECT
    a.first_name,
    a.last_name,
    f.title
FROM
    actor AS a
INNER JOIN
    film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN
    film AS f ON fa.film_id = f.film_id
ORDER BY
    a.last_name
LIMIT 10;
```

**How it works:**
- Every `JOIN` creates a new virtual table that the next `JOIN` can use.
- The order of joins usually follows the relationship path in the ERD (Database Diagram).

## 2. Using Aggregate Functions with JOINs

One of the most powerful uses of joins is calculating statistics across related tables. You can use functions like `COUNT`, `SUM`, and `AVG` after joining.

**Scenario:** Calculate the total amount spent by each customer.

```sql
SELECT
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM
    customer AS c
INNER JOIN
    payment AS p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    total_spent DESC;
```
*Note: When using `GROUP BY` with joins, always include the primary key (`customer_id`) to ensure unique results if two customers have the same name.*

## 3. Finding Missing Data (The "Anti-Join")

We can use `LEFT JOIN` combined with a `WHERE` clause to find records that **do not** have a corresponding entry in another table.

**Scenario:** Find all films that are currently NOT in our inventory (meaning we have the record but no physical copies).

```sql
SELECT
    f.title
FROM
    film AS f
LEFT JOIN
    inventory AS i ON f.film_id = i.film_id
WHERE
    i.inventory_id IS NULL;
```

## 4. The FILTER Trap: WHERE vs. ON

A common mistake is putting a filter in the `WHERE` clause when using a `LEFT JOIN`, which accidentally turns it back into an `INNER JOIN`.

**Incorrect:**
```sql
-- This removes customers with no payments because p.payment_date is checked after the join
SELECT c.last_name, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_date > '2005-08-01';
```

**Correct (keeping all customers):**
```sql
-- This keeps all customers but only joins payment data that matches the date
SELECT c.last_name, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id 
    AND p.payment_date > '2005-08-01';
```

## Key Takeaways from This Lesson

- **Chaining Joins:** You can join as many tables as needed by adding more `JOIN` statements.
- **Reporting:** Combining `JOIN` with `GROUP BY` allows for complex reporting across business entities.
- **Data Auditing:** Use `LEFT JOIN ... WHERE ... IS NULL` to find gaps in your data.
- **Logical Precision:** Be careful where you place your filters (in `ON` vs. `WHERE`) when working with outer joins.
