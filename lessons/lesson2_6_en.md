This lesson introduces the `LIMIT` and `OFFSET` clauses in SQL, essential tools for controlling the number of rows returned by a query and implementing pagination. You will learn how to retrieve a specific subset of data, such as the "top 10" records, and how to skip a certain number of rows to navigate through large datasets. Mastering these clauses is crucial for building efficient applications that handle data in manageable "chunks" or pages, improving performance and user experience.

# Lesson 2.6: Limiting Results with LIMIT and OFFSET

When working with large tables, you often don't want to retrieve every single row. Sometimes you only need the first few records, or you want to implement "paging" (showing results on Page 1, Page 2, etc.). For these tasks, we use the `LIMIT` and `OFFSET` clauses.

## The LIMIT Clause

The `LIMIT` clause is used to specify the maximum number of rows that the query should return.

### Syntax

```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column_name
LIMIT count;
```

*   **`count`**: The maximum number of rows to return.

> **Note:** It is highly recommended to use `LIMIT` in conjunction with `ORDER BY`. Without sorting, the "first X rows" could be any rows, depending on how the database engine optimizes the query.

## The OFFSET Clause

The `OFFSET` clause tells the database to skip a specific number of rows before it starts returning the results.

### Syntax

```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column_name
LIMIT count OFFSET skip;
```

*   **`skip`**: The number of rows to skip before starting to return rows.

## Pagination: Combining LIMIT and OFFSET

Pagination is the process of dividing a large result set into discrete pages. This is the most common use case for combining `LIMIT` and `OFFSET`.

*   **Page 1:** `LIMIT 10 OFFSET 0` (Rows 1-10)
*   **Page 2:** `LIMIT 10 OFFSET 10` (Rows 11-20)
*   **Page 3:** `LIMIT 10 OFFSET 20` (Rows 21-30)

## Examples

### Example 1: Top 5 Longest Films
This query finds the 5 longest films in the `film` table.

```sql
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 5;
```

### Example 2: Skipping Records
This query skips the first 10 actors (ordered by ID) and returns the next 5.

```sql
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY actor_id
LIMIT 5 OFFSET 10;
```

---

**Key Takeaways from this Lesson:**

*   `LIMIT` restricts the number of rows in the result set.
*   `OFFSET` skips a specified number of rows before returning data.
*   Combining `LIMIT` and `OFFSET` is the standard way to implement pagination.
*   Always use `ORDER BY` with these clauses to ensure predictable results.

In the next lesson, we will see how to **combine WHERE, ORDER BY, and LIMIT** to build powerful and precise queries.
