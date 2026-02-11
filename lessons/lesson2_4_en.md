This lesson focuses on column aliasing in SQL, a powerful technique for renaming columns in your query results. You will learn how to use the `AS` keyword to create temporary names that improve the readability and clarity of your output. We will explore the advantages of aliasing, such as simplifying complex column names, avoiding ambiguity in joins, and providing user-friendly headers for calculated columns. By the end of this lesson, you will be able to customize your result sets to be more descriptive and easier to understand for analysis and reporting.

# Lesson 2.4: Aliasing Columns

In previous lessons, we learned how to select data from tables. Sometimes, the default column names in a database aren't very descriptive, or you might want to give a new name to a column you've calculated. This is where **Column Aliasing** comes in.

## What is Column Aliasing?

Column aliasing allows you to assign a temporary, alternative name to a column in the result set of a `SELECT` query. This doesn't change the actual name of the column in the table; it only affects how the column is displayed in the query's output.

## Syntax

You can create a column alias using the `AS` keyword, although it is often optional:

```sql
SELECT column_name AS alias_name
FROM table_name;

-- OR (without AS)

SELECT column_name alias_name
FROM table_name;
```

*   **`column_name`**: The name of the column you want to alias.
*   **`AS alias_name`**: The `AS` keyword followed by the desired alias name.
*   **`alias_name`**: The new, temporary name for the column. If the alias contains spaces or special characters, it needs to be enclosed in double quotes (`"`).

## Advantages of Column Aliasing

Using aliases provides several benefits for data presentation and query construction:

*   **Improved Readability:** Aliases can make column names more descriptive and easier to understand, especially when dealing with complex queries or calculated columns.
*   **Simplified Column Names:** If a column name is long or contains underscores, an alias can provide a shorter, more manageable name for use in the result set.
*   **Avoiding Ambiguity:** When joining tables with columns that have the same name, aliases can help distinguish between them in the output.
*   **Creating More User-Friendly Output:** Aliases allow you to customize the column headers in the result set to be more meaningful for end-users or reporting tools.
*   **Working with Calculated Columns:** Aliases are essential when creating calculated columns (e.g., using functions or expressions) because these columns don't have inherent names.

## Examples

Let's look at some practical examples using the Sakila database structure.

### Example 1: Basic Aliasing
This query selects the `first_name` and `last_name` columns from the `actor` table, but displays them as "Given Name" and "Surname" in the result set. Note the use of double quotes because the alias contains a space.

```sql
SELECT first_name AS "Given Name", last_name AS "Surname"
FROM actor;
```

### Example 2: Aliasing Calculated Columns
This query calculates the rental duration in days and assigns the alias `rental_duration` to the calculated column.

```sql
SELECT rental_date, return_date - rental_date AS rental_duration
FROM rental;
```

### Example 3: Aliasing with Concatenation
This query concatenates the `first_name` and `last_name` columns to create a full name and assigns the alias "Full Name" to the resulting column.

```sql
SELECT first_name || ' ' || last_name AS "Full Name"
FROM actor;
```

> **Note:** The `||` operator is used for string concatenation in SQLite and PostgreSQL. Other databases may use different operators or functions (e.g., `+` in SQL Server, `CONCAT()` function in MySQL).

---

**Key Takeaways from this Lesson:**

*   Column aliasing provides temporary, descriptive names for columns in a query's result set.
*   Use the `AS` keyword (or simply a space) to create an alias.
*   Enclose aliases with spaces or special characters in double quotes (`"`).
*   Aliases improve readability, simplify column names, avoid ambiguity, and are essential for calculated columns.
In the next module, we will explore how to use **Functions** to further manipulate and transform data within our queries.
