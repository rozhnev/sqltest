# Lesson 4.3: Filtering Grouped Data with HAVING in SQL

When working with grouped data in SQL, you often need to filter the results of aggregation. The `HAVING` clause allows you to specify conditions on groups created by the `GROUP BY` clause, similar to how `WHERE` filters individual rows. In this lesson, you will learn how to use `HAVING` to filter aggregated results, with practical examples from the Sakila database.

## The Role of HAVING

- `WHERE` filters rows before grouping.
- `HAVING` filters groups after aggregation.

### Syntax

```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1
HAVING condition;
```

## Example: Customers with Total Payments Above a Threshold

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```
**Result:** Returns only those customers whose total payments exceed 100.

## Example: Employees with More Than 50 Payments Processed

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```
**Result:** Shows only staff members who processed more than 50 payments.

## Example: Filtering by Average Payment Amount

```sql
SELECT customer_id, AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```
**Result:** Lists customers whose average payment is at least 5.

## Using HAVING with Multiple Conditions

You can combine multiple conditions in the `HAVING` clause using `AND`/`OR`.

```sql
SELECT staff_id, COUNT(*) AS payments_count, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```
**Result:** Returns staff who processed more than 50 payments and whose total payments exceed 500.

## Practical Usage

1. **Top-Selling Film Categories:**
   ```sql
   SELECT c.name AS category, SUM(p.amount) AS total_sales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name
   HAVING SUM(p.amount) > 2000;
   ```
   *Shows only categories with total sales above 2000.*

2. **Countries with More Than 20 Customers:**
   ```sql
   SELECT country, COUNT(*) AS customers_count
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY country
   HAVING COUNT(*) > 20;
   ```
   *Lists countries with more than 20 customers.*

## Key Takeaways from This Lesson

- Use `HAVING` to filter groups after aggregation.
- `HAVING` works with aggregate functions, while `WHERE` does not.
- Combine `HAVING` with `GROUP BY` for powerful data analysis and reporting.

Practice using `HAVING` with your own queries to gain deeper insights from grouped data in SQL.
