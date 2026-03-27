# Lesson 4.2: Grouping Data with GROUP BY in SQL

Grouping data is a key tool for analysis and summarization in SQL. The `GROUP BY` clause allows you to combine rows with the same values in specified columns and apply aggregation functions to each group. In this lesson, you'll learn how to use `GROUP BY` for reporting and data analysis with examples from the Sakila database.

## Basics of Using GROUP BY

### Syntax
```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1;
```

### Important Rule

When using `GROUP BY`, every selected column in `SELECT` must:

- either be included in the `GROUP BY` clause;
- or be wrapped in an aggregation function (`SUM`, `COUNT`, `AVG`, `MIN`, `MAX`, etc.).

### Example: Total payments per customer
```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
```
**Result:** Returns the customer identifier and the total amount of payments for each customer.

### Example: Number of payments per staff
```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id;
```
**Result:** Returns the staff identifier and the number of payments processed by each staff member.

### Example: Average payment by date
```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY DATE(payment_date);
```
**Result:** Returns the average payment amount for each date.

### Variant: GROUP BY using alias
```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY pay_date;
```

This variant works in MySQL/MariaDB, where using an alias in `GROUP BY` is allowed.
However, this behavior is not universal across all DBMSs and is not considered portable standard SQL.
For cross-DB queries, it is safer to use the full form `GROUP BY DATE(payment_date)`.

## Using GROUP BY with Multiple Columns

You can group data by several columns at once for more detailed analysis.

### Example: Total payments by staff and customer
```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id, customer_id;
```
**Result:** Returns the staff identifier, customer identifier, and total amount of payments for each staff-customer pair.

## Practical Usage

1. **Sales analysis by film category:**
   ```sql
   SELECT c.name AS category, SUM(p.amount) AS total_sales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name;
   ```
2. **Number of customers by country:**
   ```sql
   SELECT co.country, COUNT(*) AS customers_count
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY co.country;
   ```

## Key Takeaways from This Lesson

The `GROUP BY` clause lets you group data and apply aggregation functions to each group. It's a powerful tool for reporting and data analysis in SQL. Practice using `GROUP BY` with examples from the Sakila database to quickly get summary data and build analytical queries.
