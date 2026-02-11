This lesson explores how to combine the `WHERE`, `ORDER BY`, and `LIMIT` clauses in a single SQL query to perform precise data filtering and sorting. You will learn the correct syntactic order for these clauses and how they work together to refine your results—for example, by finding the "top 5" records that meet specific criteria. Mastering this combination is essential for creating targeted reports and optimized data retrieval in real-world database applications.

# Lesson 2.7: Putting It All Together: WHERE, ORDER BY, and LIMIT

So far, we have learned how to filter rows (`WHERE`), sort them (`ORDER BY`), and restrict the number of results (`LIMIT`). In real-world scenarios, you will almost always use these clauses together to get exactly the data you need.

## The Order of Clauses

SQL has a strict order for how these clauses must appear in your query. If you place them in the wrong order, the database will return an error.

The correct sequence is:
1.  **`SELECT`** (What columns?)
2.  **`FROM`** (Which table?)
3.  **`WHERE`** (Filter the rows first)
4.  **`ORDER BY`** (Sort the filtered rows)
5.  **`LIMIT`** (Take the top X results from the sorted list)
6.  **`OFFSET`** (Skip X rows if needed)

## Logic: How it Works

When you run a combined query, the database processes it conceptually like this:
1.  It looks at the **`FROM`** table.
2.  It filters out rows that don't match the **`WHERE`** condition.
3.  It takes the remaining rows and sorts them according to **`ORDER BY`**.
4.  Finally, it looks at the sorted result and applies the **`LIMIT`** to give you just the portion you asked for.

## Examples

### Example 1: Finding the 5 Shortest Action Movies
In this example, we filter by category first (conceptually), then sort by length, and finally limit the results.

```sql
SELECT title, length, replacement_cost
FROM film
WHERE replacement_cost < 20.00
ORDER BY length ASC
LIMIT 5;
```

### Example 2: Most Recent High-Value Rentals
This query finds the 10 most recent rentals that lasted more than 5 days.

```sql
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date - rental_date > 5
ORDER BY rental_date DESC
LIMIT 10;
```

### Example 3: Searching for Specific Actors
Find the first 3 actors whose last name starts with 'B', sorted alphabetically by their first name.

```sql
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'B%'
ORDER BY first_name
LIMIT 3;
```

## Pagination with WHERE and ORDER BY

In the previous lesson, we saw basic pagination using `LIMIT` and `OFFSET`. In real applications, you usually paginate through a **filtered** and **sorted** list. 

### Why do we need WHERE and ORDER BY for pagination?
1. **Filtering:** Users usually want to see a specific subset of data (e.g., "Active" products or "Comedy" movies).
2. **Consistency:** Without `ORDER BY`, the database might return rows in a different order every time you go to the next page, causing some items to appear twice and others to be missed.

### Pagination Formula
To implement pagination for "Page N" with "S" results per page:
*   `LIMIT S`
*   `OFFSET (N - 1) * S`

### Combined Example: Page 2 of 'A' Actors
If we want to show the second page (5 results per page) of actors whose first name starts with 'A', sorted by their last name:

```sql
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'A%'
ORDER BY last_name
LIMIT 5 OFFSET 5; -- Page 2: Skip 5, take 5
```

---

**Key Takeaways from this Lesson:**

*   Follow the strict syntactic order: `WHERE` -> `ORDER BY` -> `LIMIT`.
*   The `WHERE` clause conditions are applied *before* the sorting and limiting happens.
*   This combination is the foundation for most data reporting and user interface "top-X" lists.
*   Always use `LIMIT` with `ORDER BY` if you want your results to be consistent.

In the next module, we will move beyond simple row retrieval and explore **Aggregate Functions**, which allow us to calculate totals, averages, and counts across entire datasets.
