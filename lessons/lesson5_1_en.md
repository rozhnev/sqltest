# Lesson 5.1: Working with Multiple Tables — Understanding Joins in SQL

In real-world databases, data is often distributed across multiple tables. To analyze and retrieve meaningful information, you need to combine data from these tables. SQL provides JOIN operations to connect related tables based on common columns. In this lesson, you will learn the fundamentals of SQL joins, their types, and practical examples using the Sakila database.

## What is a JOIN?
A JOIN in SQL is used to combine rows from two or more tables based on a related column between them. This allows you to query and analyze data that spans multiple tables.

## Types of Joins

### 1. INNER JOIN
Returns only the rows where there is a match in both tables.

**Syntax:**
```sql
SELECT columns
FROM table1
INNER JOIN table2 ON table1.column = table2.column;
```

**Example:**
```sql
SELECT c.first_name, c.last_name, p.amount
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id;
```
*Returns customer names and their payments.*

### 2. LEFT JOIN (or LEFT OUTER JOIN)
Returns all rows from the left table, and matched rows from the right table. Unmatched rows from the right table will have NULLs.

**Syntax:**
```sql
SELECT columns
FROM table1
LEFT JOIN table2 ON table1.column = table2.column;
```

**Example:**
```sql
SELECT c.first_name, c.last_name, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id;
```
*Returns all customers, including those who have not made any payments.*

### 3. RIGHT JOIN (or RIGHT OUTER JOIN)
Returns all rows from the right table, and matched rows from the left table. Unmatched rows from the left table will have NULLs.

**Syntax:**
```sql
SELECT columns
FROM table1
RIGHT JOIN table2 ON table1.column = table2.column;
```

**Example:**
```sql
SELECT c.first_name, c.last_name, p.amount
FROM customer c
RIGHT JOIN payment p ON c.customer_id = p.customer_id;
```
*Returns all payments, including those not linked to a customer (if any).* 

### 4. FULL OUTER JOIN
Returns all rows when there is a match in either left or right table. Unmatched rows will have NULLs for missing columns.

**Note:** Not all SQL databases support FULL OUTER JOIN directly.

**Syntax:**
```sql
SELECT columns
FROM table1
FULL OUTER JOIN table2 ON table1.column = table2.column;
```

**Example:**
```sql
SELECT c.first_name, c.last_name, p.amount
FROM customer c
FULL OUTER JOIN payment p ON c.customer_id = p.customer_id;
```
*Returns all customers and all payments, matching where possible.*

## Why Use Joins?
- To combine related data from different tables
- To perform complex queries and analysis
- To avoid data duplication and maintain normalization

## Practical Usage
1. **List all rentals with customer and film information:**
   ```sql
   SELECT r.rental_id, c.first_name, c.last_name, f.title
   FROM rental r
   JOIN customer c ON r.customer_id = c.customer_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id;
   ```
2. **Find customers who have not made any payments:**
   ```sql
   SELECT c.first_name, c.last_name
   FROM customer c
   LEFT JOIN payment p ON c.customer_id = p.customer_id
   WHERE p.payment_id IS NULL;
   ```

## Key Takeaways from This Lesson
- Joins are essential for working with normalized databases.
- Use INNER JOIN for matching data, LEFT/RIGHT JOIN for including unmatched rows, and FULL OUTER JOIN for all data.
- Practice writing join queries to analyze data across multiple tables in SQL.
