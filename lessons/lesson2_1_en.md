# Lesson 2.1 Select Data from a Table

## Selecting Data from a Table

The most fundamental operation in SQL is retrieving data from a table. The `SELECT` statement is used for this purpose.

## Basic Syntax (Selecting All Columns)

To select all columns from a table, you use the `SELECT *` syntax:

```sql
SELECT *
FROM table_name;
```

- `SELECT`: This keyword retrive data from table
- `*` (Asterisk): Indicates that all columns from the table should be retrieved. The asterisk (`*`) acts as a wildcard representing all columns in the table.
- `FROM table_name`: Specifies the table from which the data is to be retrieved. Replace `table_name` with the actual name of the table you are querying.

### Example (Sakila Database)

To select all columns from the `actor` table in the Sakila database:

```sql
SELECT *
FROM actor;
```

This query will return all rows and all columns (e.g., `actor_id`, `first_name`, `last_name`, `last_update`) from the `actor` table.

### Avoid Using `*` to Select All Columns

Using `*` to select all columns is generally not recommended. While it may seem convenient, it can lead to several issues:

- **Performance Impact:** Retrieving all columns can increase the amount of data transferred, especially if the table has many columns or large datasets.
- **Unintended Changes:** If the table schema changes (e.g., new columns are added), queries using `*` may return unexpected results.
- **Readability and Maintenance:** Explicitly specifying columns makes the query easier to understand and maintain.

Instead of using `*`, it is a best practice to explicitly list the columns you need. This approach ensures clarity, reduces the risk of unintended results, and improves query performance.

## Selecting Specific Columns

To retrieve specific columns, list their names in the `SELECT` statement, separated by commas:

```sql
SELECT column1, column2, column3
FROM table_name;
```

- `SELECT column1, column2, column3`: Specifies the columns to retrieve. Replace `column1`, `column2`, and `column3` with the actual column names.
- `FROM table_name`: Indicates the table from which to retrieve the data.

### Example (Sakila Database)

To retrieve only the `first_name` and `last_name` columns from the `actor` table:

```sql
SELECT first_name, last_name
FROM actor;
```

This query will return all rows, but only the `first_name` and `last_name` columns for each actor.

Instead of selecting all columns, you can choose to retrieve only specific columns. To do this, you list the column names you want to retrieve, separated by commas:

```sql
SELECT column1, column2, column3
FROM table_name;
```

- `SELECT column1, column2, column3`: This specifies the columns you want to retrieve. Replace `column1`, `column2`, and `column3` with the actual names of the columns.
- `FROM table_name`: This specifies the table from which you want to retrieve the data.

### Example (Sakila Database)

To select only the `first_name` and `last_name` columns from the `actor` table:

```sql
SELECT first_name, last_name
FROM actor;
```

This query will return all rows, but only the `first_name` and `last_name` columns for each actor.

## Column Order in SELECT

The order in which you list columns in the `SELECT` statement determines their order in the result set. However, it does not alter the column order in the table itself.

### Example (Sakila Database)

```sql
SELECT last_name, first_name
FROM actor;
```

In this case, the `last_name` column will appear before the `first_name` column in the output, even though `first_name` might be defined earlier in the table structure. The order in the `SELECT` statement overrides the default table column order.

**Key Takeaways from this Lesson:**

- `SELECT *` retrieves all columns from a table.
- `SELECT column1, column2, ...` retrieves only the specified columns.
- The order of columns in the `SELECT` statement determines the order in the result set.