This lesson introduces the `CREATE TABLE` statement, the primary Data Definition Language (DDL) command used to create new tables in a database. You will learn the basic syntax, how to define columns and their data types, and how to use important constraints and column parameters such as `PRIMARY KEY`, `NOT NULL`, `DEFAULT`, `CHARACTER SET`, and `COLLATE`. By the end of this lesson, you will be able to create tables with a clear and reliable structure.

# Lesson 9.1: The CREATE TABLE Statement

So far, we have mostly worked with existing tables and retrieved data from them. But in real database work, it is important not only to read data, but also to know how to **create the structure used to store it**. That is where the `CREATE TABLE` statement comes in.

`CREATE TABLE` belongs to **Data Definition Language (DDL)**. It is used to describe how a table should be structured: which columns it will contain, which data types those columns will use, and which rules will apply to the values stored in them.

## The Basic Syntax

The simplest form of the statement looks like this:

```sql
CREATE TABLE table_name (
    column1 data_type,
    column2 data_type,
    column3 data_type
);
```

After the table name, the columns are listed inside parentheses. For each column, you need to specify:

- the column name (required);
- the data type (required);
- and, when needed, additional characteristics such as encoding, constraints, comments, and others.

## Example of a Simple Table

Let's create a `students` table:

```sql
CREATE TABLE students (
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    created_at TIMESTAMP
);
```

In this example:

- `student_id` is an integer;
- `first_name` and `last_name` are text values up to 50 characters long;
- `birth_date` stores the date of birth;
- `created_at` stores the date and time when the record was created.

After running this command, the table will be created, but it will still be empty.

---

## Commonly Used Data Types

When creating tables, it is important to choose suitable data types. Here are some of the most common ones:

- `INT` for whole numbers;
- `VARCHAR(n)` for variable-length strings up to `n` characters;
- `TEXT` for long text values;
- `DATE` for calendar dates;
- `TIMESTAMP` for date and time values, often used to store when a row was created or updated;
- `DECIMAL(p, s)` for exact numeric values, such as money;
- `BOOLEAN` for logical values `TRUE` or `FALSE`.

Choosing the right data type helps save space, maintain data quality, and avoid errors. You can read more about data types <a href="/en/lesson/getting-started/basic-data-types">here</a>.

---

## Column Constraints

Constraints define rules for the data stored in a table.

### 1. `PRIMARY KEY`
A primary key uniquely identifies each row in a table.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

The `student_id` column cannot contain duplicate values or `NULL`.

### 2. `NOT NULL`
This constraint requires that a column must always contain a value.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
```

Now `first_name` and `last_name` cannot be left empty.

### 3. `CHECK`
The `CHECK` constraint defines a condition that the values in a column must satisfy.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) CHECK (price >= 0)
);
```

In this example, the database will not allow a product with a negative price to be stored.

---

## Additional Column Parameters

In addition to constraints, columns can have extra parameters. These do not directly forbid or allow values, but they help define the column's behavior more precisely.

### 1. `DEFAULT`
The `DEFAULT` parameter defines the value that will be used if no value is provided during insertion.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) DEFAULT 0.00
);
```

If no price is provided when adding a product, the database will automatically use `0.00`.

### 2. `CHARACTER SET` and `COLLATE`
For text columns, you can explicitly specify the character set and the collation rules.

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    last_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);
```

Here, `CHARACTER SET` defines the encoding used to store text data, while `COLLATE` defines how strings are compared and sorted. This is especially important when a table needs to work correctly with different languages and characters.

---

## Example of a Table with Multiple Rules

Here is a more realistic example of an `employees` table:

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 0.00
);
```

What is happening here:

- `employee_id` is the unique identifier for an employee;
- `first_name` and `last_name` are required;
- `email` must be unique;
- `hire_date` is required;
- `salary` defaults to `0.00`.

This structure better reflects real-world data requirements.

---

## Using `IF NOT EXISTS`

In many database systems, you can avoid an error if the table already exists by using `IF NOT EXISTS`:

```sql
CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
```

This is useful when rerunning practice scripts or migrations.

---

## What to Pay Attention To

When creating tables, it is helpful to keep a few rules in mind:

- choose data types thoughtfully, rather than making everything overly generic;
- define a `PRIMARY KEY` for tables where each row must be uniquely identified;
- use `NOT NULL` for truly required fields;
- use `DEFAULT` when a column has a natural default value;
- explicitly set `CHARACTER SET` and `COLLATE` for text fields when needed;
- try to make the structure clear and predictable from the start.

A well-designed table reduces errors and makes it easier to work later with `INSERT`, `UPDATE`, and `SELECT`.

---

## Practical Example

Imagine that we want to create a table for storing books:

```sql
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    published_date DATE,
    price DECIMAL(8, 2) DEFAULT 0.00
);
```

Once this table is created, we can start adding rows to it using `INSERT INTO`.

---

**Key Takeaways from this Lesson:**

*   The `CREATE TABLE` statement is used to create new tables in a database.
*   Each column must have a name and a data type.
*   Constraints such as `PRIMARY KEY`, `NOT NULL`, `UNIQUE`, and `CHECK` help control data quality.
*   Additional column parameters such as `DEFAULT`, `CHARACTER SET`, and `COLLATE` help fine-tune data storage and behavior.
*   A well-designed table makes future work with data simpler and more reliable.
*   `IF NOT EXISTS` helps avoid errors when creating a table more than once.
