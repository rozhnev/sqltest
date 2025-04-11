# Lesson 1.3: Basic Data Types in SQL

In SQL, data types specify the kind of data that can be stored within a column. Choosing the correct data type is crucial for data integrity, storage efficiency, and query performance. This lesson covers common data types and their subtypes used in SQL databases, along with their value ranges.

## Numeric Data Types

Numeric data types are used to store numerical values.

### INTEGER
*   Stores whole numbers (integers).
*   Subtypes:
    *   `INT` or `INTEGER`: Typically a 4-byte integer.
    *   `SMALLINT`: Typically a 2-byte integer.
    *   `BIGINT`: Typically an 8-byte integer.
    *   `TINYINT`: Typically a 1-byte integer.
*   Ranges (approximate, may vary by database system):
    *   `TINYINT`: -128 to 127 (signed) or 0 to 255 (unsigned)
    *   `SMALLINT`: -32,768 to 32,767
    *   `INT`: -2,147,483,648 to 2,147,483,647
    *   `BIGINT`: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807

### DECIMAL / NUMERIC
*   Stores exact numeric values with a specified precision and scale.
*   Precision: The total number of digits.
*   Scale: The number of digits to the right of the decimal point.
*   Example: `DECIMAL(10, 2)` can store numbers with 10 total digits, 2 of which are after the decimal point.
*   Range: Depends on the precision and scale.

### FLOAT / REAL
*   Stores approximate numeric values with floating-point precision.
*   Subtypes:
    *   `FLOAT`: Single-precision floating-point number.
    *   `DOUBLE` / `DOUBLE PRECISION`: Double-precision floating-point number.
    *   `REAL`: A synonym for `FLOAT` in some databases.
*   Range: Varies depending on the specific implementation, but generally covers a wide range of values with limited precision.

## Character / String Data Types

Character data types are used to store text.

### CHAR
*   Stores fixed-length character strings.
*   You specify the length when defining the column.
*   Example: `CHAR(10)` stores strings of exactly 10 characters.
*   If the stored string is shorter than the specified length, it's padded with spaces.

### VARCHAR
*   Stores variable-length character strings.
*   You specify the maximum length when defining the column.
*   Example: `VARCHAR(255)` stores strings up to 255 characters long.
*   Only uses the space needed to store the actual string.

### TEXT
*   Stores large variable-length character strings.
*   Often used for storing documents, articles, or other large text data.
*   The maximum length is typically much larger than `VARCHAR`.

## Date and Time Data Types

Date and time data types are used to store temporal values.

### DATE
*   Stores a date (year, month, day).
*   Format: Varies depending on the database system (e.g., YYYY-MM-DD, MM/DD/YYYY).

### TIME
*   Stores a time (hour, minute, second).
*   Format: Varies depending on the database system (e.g., HH:MM:SS).

### DATETIME / TIMESTAMP
*   Stores both date and time.
*   Format: Varies depending on the database system (e.g., YYYY-MM-DD HH:MM:SS).
*   `TIMESTAMP` often has special behavior related to time zones and automatic updates.

## Boolean Data Type

### BOOLEAN
*   Stores true/false values.
*   Some databases may represent boolean values as integers (e.g., 0 for false, 1 for true).

## Other Data Types

### BLOB (Binary Large Object)
*   Stores binary data, such as images, audio, or video files.

### JSON
*   Stores JSON (JavaScript Object Notation) data.
*   Allows storing semi-structured data within a database column.

## NULL Values

It's important to understand the concept of `NULL` in SQL. `NULL` represents a missing or unknown value. A column can be defined to allow or disallow `NULL` values. Unlike other data types, `NULL` is not a data type itself, but rather a property of a column. It's crucial to handle `NULL` values properly in queries to avoid unexpected results. Comparisons with `NULL` should be done using `IS NULL` or `IS NOT NULL`.

## Choosing the Right Data Type

*   Consider the type of data you need to store (numeric, text, date/time, etc.).
*   Choose the smallest data type that can accommodate the range of values you expect.
*   Use `VARCHAR` instead of `CHAR` unless you need fixed-length strings.
*   Use `DECIMAL` for exact numeric values, especially when dealing with currency.
*   Be aware of the specific data types and their behavior in your database system.

By understanding the available data types and their characteristics, you can design databases that are efficient, reliable, and easy to maintain.

**Key Takeaways from this Lesson:**

*   **Data Types Matter:** Selecting the appropriate data type is crucial for data integrity, storage efficiency, and query performance.
*   **Numeric Types:** `INTEGER`, `DECIMAL`, and `FLOAT` are used for storing numerical data, each with different characteristics regarding precision and range.
*   **String Types:** `CHAR`, `VARCHAR`, and `TEXT` are used for storing text data, with varying length constraints and storage implications.
*   **Date/Time Types:** `DATE`, `TIME`, and `DATETIME` are used for storing temporal data, with specific formats that vary across database systems.
*   **Other Types:** `BOOLEAN`, `BLOB`, and `JSON` provide support for storing boolean values, binary data, and semi-structured data, respectively.
*   **NULL Values:** `NULL` represents a missing or unknown value and is not a data type itself. It's crucial to handle `NULL` values properly in queries.
*   **Choosing Wisely:** Consider the nature of the data, the required precision, and the storage implications when selecting a data type for a column.