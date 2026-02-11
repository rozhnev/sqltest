Learn how to use SQL subqueries in the WHERE clause to filter data based on dynamic values. This lesson covers using subqueries with comparison operators, the IN and NOT IN operators for list comparison, and an introduction to the EXISTS operator. Master complex filtering techniques using the Sakila database.

# Lesson 6.2: Subqueries in the WHERE Clause

The `WHERE` clause is the most common place to find a subquery. It allows you to filter the result set of the outer query based on the results of the inner query. In this lesson, we will explore different operators used with subqueries in the `WHERE` clause.

## 1. Subqueries with Comparison Operators

When a subquery returns a single value (a **scalar** subquery), you can use standard comparison operators like `=`, `<>`, `>`, `>=`, `<`, or `<=`.

**Scenario:** Find the names of actors who have the same first name as the actor with `actor_id = 10`.

```sql
SELECT
    first_name,
    last_name
FROM
    actor
WHERE
    first_name = (SELECT first_name FROM actor WHERE actor_id = 10)
    AND actor_id <> 10;
```
*Note: If the subquery returns more than one row, the query will fail with an error.*

## 2. The IN and NOT IN Operators

If a subquery returns multiple values (one column, multiple rows), you cannot use `=`, but you can use the `IN` operator.

**Scenario:** Find all films that belong to the 'Action' category.
We can do this by first finding the `category_id` for 'Action' and then filtering the `film_category` table.

```sql
SELECT
    title
FROM
    film
WHERE
    film_id IN (
        SELECT film_id 
        FROM film_category 
        WHERE category_id = (SELECT category_id FROM category WHERE name = 'Action')
    );
```
*Note: This example uses a nested subquery inside another subquery!*

The `NOT IN` operator works the opposite way, excluding rows that match any value in the list.

## 3. The EXISTS and NOT EXISTS Operators

The `EXISTS` operator checks for the **existence** of any record in the subquery. It is often more efficient than `IN` for large datasets because it stops searching as soon as it finds the first match.

**Scenario:** Find all customers who have made at least one payment.

```sql
SELECT
    c.first_name,
    c.last_name
FROM
    customer AS c
WHERE
    EXISTS (
        SELECT 1 
        FROM payment AS p 
        WHERE p.customer_id = c.customer_id
    );
```
*Tip: `SELECT 1` is commonly used in `EXISTS` because the actual data returned by the subquery doesn't matter; only whether any rows are returned at all.*

## 4. ANY and ALL Operators

-   **ANY:** The condition is true if it matches **at least one** value in the subquery result.
-   **ALL:** The condition is true only if it matches **every** value in the subquery result.

**Scenario:** Find films whose length is greater than all films in the 'Comedy' category.

```sql
SELECT
    title,
    length
FROM
    film
WHERE
    length > ALL (
        SELECT f.length
        FROM film f
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category c ON fc.category_id = c.category_id
        WHERE c.name = 'Comedy'
    );
```

## Key Takeaways from This Lesson

- Use **comparison operators** (`=`, `>`) only with subqueries that return a single value.
- Use **IN** when the subquery returns a list of values.
- Use **EXISTS** to check if matching rows exist in another table without retrieving the data.
- **NOT IN** and **NOT EXISTS** are essential for finding "missing" relationships.
- Subqueries in `WHERE` make your code dynamic and handle multi-step filtering logic.
