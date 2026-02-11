This lesson covers the `ORDER BY` clause in SQL, which is used to sort the result set of a query. You will learn how to arrange data in ascending or descending order, sort by multiple columns, and understand the impact of sorting on data analysis. Mastering the `ORDER BY` clause is essential for presenting data in a logical sequence and for preparing reports where the sequence of records matters, such as top-selling products or chronological activity logs.

# Lesson 2.5: Ordering Results

By default, the rows in a database table or a query's result set are not guaranteed to be in any specific order. To arrange the output rows in a meaningful sequence, we use the `ORDER BY` clause.

## The ORDER BY Clause

The `ORDER BY` clause is added to the end of a `SELECT` statement to sort the result set based on one or more columns.

### Syntax

```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
```

*   **`column1, column2, ...`**: The columns you want to sort by.
*   **`ASC`**: Sorts the data in ascending order (lowest to highest, A to Z). This is the default.
*   **`DESC`**: Sorts the data in descending order (highest to lowest, Z to A).

## Sorting by a Single Column

To sort by one column, simply specify its name after the `ORDER BY` keyword.

### Example: Sorting Actors by Last Name
This query retrieves all actors and sorts them alphabetically by their last name.

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name;
```

If you want to sort them in reverse alphabetical order:

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name DESC;
```

## Sorting by Multiple Columns

You can sort by multiple columns by listing them separated by commas. The database first sorts by the first column, and if there are duplicate values in that column, it sorts those duplicates by the second column, and so on.

### Example: Sorting by Last Name, then First Name
This is useful when multiple actors share the same last name.

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name, first_name; -- First by last_name, then by first_name for ties
```

## Sorting by Column Aliases or Positions

In most SQL dialects, you can also sort by a column's alias or its numerical position in the `SELECT` list.

### Example: Sorting by Alias
```sql
SELECT first_name || ' ' || last_name AS full_name
FROM actor
ORDER BY full_name;
```

### Example: Sorting by Position
```sql
-- Sorts by the second column (last_name)
SELECT first_name, last_name
FROM actor
ORDER BY 2;
```

---

**Key Takeaways from this Lesson:**

*   Use `ORDER BY` to sort the rows in your result set.
*   `ASC` (default) sorts in ascending order; `DESC` sorts in descending order.
*   You can sort by multiple columns to refine the order further.
*   Sorting can also be done using column aliases or numerical positions.

In the next lesson, we will learn about **Aggregate Functions**, which allow us to perform calculations on sets of data.
