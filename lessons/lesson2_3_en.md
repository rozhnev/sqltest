This SQL lesson covers how to combine multiple conditions in a WHERE clause using logical operators: AND, OR, and NOT. You will learn how to create advanced database filters to retrieve specific data subsets by connecting multiple expressions. The lesson explains operator precedence and the importance of using parentheses to control evaluation order and ensure query accuracy. Master complex data filtering techniques to enhance your SQL querying skills for more effective data analysis and reporting.

# Lesson 2.3 Combine Multiple Conditions

## Combining Multiple Criteria in SQL

In the previous lesson, we learned how to use the `WHERE` clause with simple comparison operators. However, real-world data analysis often requires filtering by multiple criteria simultaneously. To do this, we use logical operators: `AND`, `OR`, and `NOT`.

## Logical Operators

Logical operators allow you to connect multiple expressions in a `WHERE` clause to create more sophisticated filters.

### 1. The AND Operator
The `AND` operator returns rows only if **all** the conditions separated by `AND` are true. It is used to narrow down your results.

**Example (Sakila Database)**
Suppose we want to find films that are both rated 'G' and shorter than 80 minutes:

```sql
SELECT title, length, rating
FROM film
WHERE length < 80 AND rating = 'G';
```

### 2. The OR Operator
The `OR` operator returns rows if **any** of the conditions separated by `OR` are true. It is used to broaden your results.

**Example (Sakila Database)**
To find actors with the first name 'NICK' or 'ED':

```sql
SELECT first_name, last_name
FROM actor
WHERE first_name = 'NICK' OR first_name = 'ED';
```

### 3. The NOT Operator
The `NOT` operator displays a record if the condition(s) is **NOT** true. It effectively reverses the logic of a condition.

**Example (Sakila Database)**
To find all films except those with an 'R' rating:

```sql
SELECT title, rating
FROM film
WHERE NOT rating = 'R';
```

---

## Operator Precedence

When you combine multiple operators in a single query (e.g., using both `AND` and `OR`), SQL follows a specific order of operations (precedence).

1.  `NOT` is evaluated first.
2.  `AND` is evaluated second.
3.  `OR` is evaluated last.

**The Power of Parentheses:**
Just like in math, you should use parentheses `()` to control the order of evaluation and make your queries more readable.

### Example (Sakila Database)

```sql
-- This query finds films that are (Rated G AND Short) OR (Rated PG AND Short)
SELECT title, length, rating
FROM film
WHERE (rating = 'G' OR rating = 'PG') AND length < 60;
```

---

**Key Takeaways from this Lesson:**

*   Use `AND` to ensure all conditions are met.
*   Use `OR` to find matches for any of several conditions.
*   Use `NOT` to exclude specific data.
*   Always use parentheses `()` when mixing `AND` and `OR` to avoid logic errors and improve clarity.

In the next lesson, we will learn how to **Sort and Limit** results to organize your data more effectively.
