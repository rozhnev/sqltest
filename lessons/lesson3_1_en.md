# Lesson 3.1: Using Functions in SQL Queries

SQL functions are pre-built routines that perform specific operations on data. They allow you to manipulate data, perform calculations, and format results within your SQL queries. Functions can be used in various parts of a query, such as the `SELECT` clause to transform output, or the `WHERE` clause to filter data based on calculated values.

## What are SQL Functions?

SQL functions are similar to functions in other programming languages. They accept input values (arguments), perform a specific operation, and return a result. Functions can be built-in (provided by the database system) or user-defined (created by users). This lesson focuses on built-in functions.

## Common Syntax

The general syntax for using a function in SQL is:

```sql
FUNCTION_NAME(argument1, argument2, ...);
```

- **`FUNCTION_NAME`**: The name of the function you want to use.
- **`argument1, argument2, ...`**: The input values (arguments) that the function requires. These can be column names, literal values, or even other functions.

---

## Using Functions in the SELECT Clause

Functions in the `SELECT` clause allow you to transform or calculate values for the output.

### Example 1: String Function (`UPPER`)
The `UPPER()` function converts a string to uppercase.

```sql
SELECT UPPER(first_name) AS uppercase_name
FROM employees;
```

This query retrieves the `first_name` column from the `employees` table and converts each name to uppercase, aliasing the result as `uppercase_name`.

---

### Example 2: Mathematical Function (`ROUND`)
The `ROUND()` function rounds a number to a specified number of decimal places.

```sql
SELECT ROUND(salary, 0) AS rounded_salary
FROM employees;
```

This query retrieves the `salary` column from the `employees` table and rounds each salary to the nearest whole number, aliasing the result as `rounded_salary`.

---

### Example 3: Date Function (`NOW`)
The `NOW()` function have not arguments and returns the current date and time.

```sql
SELECT NOW() AS current_datetime;
```

This query returns the current date and time.

---

## Using Functions in the WHERE Clause

Functions in the `WHERE` clause allow you to filter data based on calculated or transformed values.

### Example 1: String Function (`LENGTH`)
The `LENGTH()` function returns the length of a string.

```sql
SELECT *
FROM products
WHERE LENGTH(product_name) > 20;
```

This query retrieves all columns from the `products` table where the length of the `product_name` is greater than 20 characters.

---

### Example 2: Date Function (`YEAR`)
The `YEAR()` function extracts the year from a date.

```sql
SELECT *
FROM orders
WHERE YEAR(order_date) = 2023;
```

This query retrieves all columns from the `orders` table where the year of the `order_date` is 2023.

---

### Example 3: Mathematical Function (`ABS`)
The `ABS()` function returns the absolute value of a number.

```sql
SELECT *
FROM transactions
WHERE ABS(amount) > 100;
```

This query retrieves all columns from the `transactions` table where the absolute value of the `amount` is greater than 100.

---

## Common Types of SQL Functions

SQL functions can be broadly categorized into the following types:

1. **String Functions**: Used for manipulating strings (e.g., `UPPER`, `LOWER`, `SUBSTRING`, `LENGTH`, `TRIM`).
2. **Mathematical Functions**: Used for performing mathematical calculations (e.g., `ROUND`, `ABS`, `SQRT`, `MOD`).
3. **Date and Time Functions**: Used for working with dates and times (e.g., `NOW`, `YEAR`, `MONTH`, `DAY`, `DATE_ADD`, `DATE_SUB`).
4. **Aggregate Functions**: Used for summarizing data (e.g., `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`). (Covered in a later lesson)
5. **Conversion Functions**: Used for converting data from one type to another (e.g., `CAST`, `CONVERT`).

---

## Best Practices

1. **Understand Function Behavior**: Be aware of the specific behavior and limitations of each function you use.
2. **Use Aliases**: Use aliases (`AS`) to give meaningful names to calculated columns.
3. **Check Data Types**: Ensure that the input values (arguments) are of the correct data type for the function.
4. **Refer to Documentation**: Consult the documentation for your specific database system for a complete list of available functions and their syntax.

**Key Takeaways from this Lesson:**

By mastering the use of functions in SQL queries, you can perform powerful data manipulation and analysis, extracting valuable insights from your data.

