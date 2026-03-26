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

### 4. The XOR Operator (Exclusive OR, Rarely Used)
The `XOR` operator returns true only when **exactly one** of two conditions is true. In practice, it is rarely used because it is not supported by all SQL dialects and can reduce query readability.

**Example (Sakila Database)**
To find films where only one condition is true: either the length is less than 60 minutes or the rating is 'G', but not both:

```sql
SELECT title, length, rating
FROM film
WHERE length < 60 XOR rating = 'G';
```

For portability across different databases, the same logic is usually written with `AND`/`OR`/`NOT`.

---

## Operator Precedence

When you combine multiple operators in a single query (e.g., using both `AND` and `OR`), SQL follows a specific order of operations (precedence).

1.  `NOT` is evaluated first.
2.  `AND` is evaluated second.
3.  `XOR` (if supported by your SQL dialect) is usually evaluated after `AND`.
4.  `OR` is evaluated last.

**The Power of Parentheses:**
Just like in math, you should use parentheses `()` to control the order of evaluation and make your queries more readable. Without them, SQL silently applies its default precedence — and the result may not be what you intended.

---

### Example 1: Find 'G' and 'PG' films shorter than 60 minutes

**Buggy query — missing parentheses:**

```sql
-- BUG: AND binds tighter than OR, so this is evaluated as:
-- rating = 'G'  OR  (rating = 'PG' AND length < 60)
-- Result: ALL 'G' films (any length) + only SHORT 'PG' films
SELECT title, length, rating
FROM film
WHERE rating = 'G' OR rating = 'PG' AND length < 60;
```

**Why it's wrong:** the `AND` condition is evaluated first, so the `length < 60` filter only applies to 'PG' films, while all 'G' films — regardless of length — slip through.

**Fixed query — parentheses make the intent explicit:**

```sql
-- CORRECT: parentheses force OR to be evaluated first
-- Result: only films rated 'G' OR 'PG' AND shorter than 60 minutes
SELECT title, length, rating
FROM film
WHERE (rating = 'G' OR rating = 'PG') AND length < 60;
```

---

### Example 2: Exclude both 'R' and 'NC-17' rated films

**Buggy query — NOT only negates the first condition:**

```sql
-- BUG: NOT applies only to the immediately following condition
-- Equivalent to: (NOT rating = 'R') AND rating = 'NC-17'
-- Result: films rated 'NC-17' that are also not rated 'R' — always empty
SELECT title, rating, length
FROM film
WHERE NOT rating = 'R' AND rating = 'NC-17';
```

**Why it's wrong:** `NOT` only negates `rating = 'R'`, leaving `rating = 'NC-17'` as a positive filter. The query effectively returns all films rated 'NC-17' — because 'NC-17' is not 'R', the `NOT` condition is always satisfied for those rows. Instead of excluding NC-17 films, the query returns exactly the films you wanted to exclude.

**Option A — two explicit NOT conditions:**

```sql
-- CORRECT: each condition is independently negated
SELECT title, rating, length
FROM film
WHERE NOT rating = 'R' AND NOT rating = 'NC-17';
```

**Option B — NOT with parentheses (more concise):**

```sql
-- CORRECT: NOT applies to the whole OR group
SELECT title, rating, length
FROM film
WHERE NOT (rating = 'R' OR rating = 'NC-17');
```

Both options return the same result. Option B is generally preferred when excluding several values — it scales better as the list grows.

---

**Key Takeaways from this Lesson:**

*   Use `AND` to ensure all conditions are met.
*   Use `OR` to find matches for any of several conditions.
*   Use `NOT` to exclude specific data.
*   Use `XOR` carefully: it can be useful, but it is not supported in every SQL dialect.
*   Always use parentheses `()` when mixing `AND` and `OR` to avoid logic errors and improve clarity.

In the next lesson, we will learn how to **Sort and Limit** results to organize your data more effectively.
