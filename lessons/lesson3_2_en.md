
# Lesson 3.2: Common String Functions in SQL

String functions in SQL are used to manipulate and transform text data. These functions are essential for cleaning, formatting, and extracting information from string columns in a database. This lesson covers some of the most commonly used string functions and provides practical examples.

## Common String Functions

### `UPPER()` - Converts a string to uppercase.

**Syntax:**
```sql
UPPER(string)
```

**Example:**
```sql
SELECT UPPER(first_name) AS uppercase_name
FROM employees;
```
**Result:** Converts all `first_name` values to uppercase.

### `LOWER()` - Converts a string to lowercase.

**Syntax:**
```sql
LOWER(string)
```

**Example:**
```sql
SELECT LOWER(last_name) AS lowercase_name
FROM employees;
```
**Result:** Converts all `last_name` values to lowercase.

### `LENGTH()` or `LEN()` Returns the length of a string (number of characters).

**Syntax:**
```sql
LENGTH(string) -- For most databases
LEN(string)    -- For SQL Server
```

**Example:**
```sql
SELECT LENGTH(product_name) AS name_length
FROM products;
```
**Result:** Returns the number of characters in each `product_name`.

### `SUBSTRING()` or `SUBSTR()` - Extracts a portion of a string.

**Syntax:**
```sql
SUBSTRING(string, start_position, length) -- For most databases
SUBSTR(string, start_position, length)    -- For Oracle and others
```

**Example:**
```sql
SELECT SUBSTRING(email, 1, 5) AS email_prefix
FROM users;
```
**Result:** Extracts the first 5 characters from the `email` column.

### `CONCAT()` - Concatenates two or more strings into one.

**Syntax:**
```sql
CONCAT(string1, string2, ...)
```

**Example:**
```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;
```
**Result:** Combines `first_name` and `last_name` into a single `full_name`.

### `TRIM()` - Removes leading and trailing spaces from a string.

**Syntax:**
```sql
TRIM(string)
```

**Example:**
```sql
SELECT TRIM('   SQL Basics   ') AS trimmed_string;
```
**Result:** Returns `'SQL Basics'` without leading or trailing spaces.

### `REPLACE()` - Replaces occurrences of a substring within a string.

**Syntax:**
```sql
REPLACE(string, old_substring, new_substring)
```

**Example:**
```sql
SELECT REPLACE(phone_number, '-', '') AS cleaned_phone
FROM contacts;
```
**Result:** Removes dashes from `phone_number`.

### `INSTR()` or `CHARINDEX()` - Finds the position of a substring within a string.

**Syntax:**
```sql
INSTR(string, substring)       -- For most databases
CHARINDEX(substring, string)   -- For SQL Server
```

**Example:**
```sql
SELECT INSTR(email, '@') AS at_position
FROM users;
```
**Result:** Returns the position of the `@` symbol in the `email` column.

### `LEFT()` and `RIGHT()` - Extracts a specified number of characters from the left or right of a string.

**Syntax:**
```sql
LEFT(string, number_of_characters)
RIGHT(string, number_of_characters)
```

**Example:**
```sql
SELECT LEFT(product_code, 3) AS product_prefix,
       RIGHT(product_code, 4) AS product_suffix
FROM products;
```
**Result:** Extracts the first 3 characters and the last 4 characters from `product_code`.

### `FORMAT()` or `TO_CHAR()` - Formats a string or number into a specific format.

**Syntax:**
```sql
FORMAT(value, format)       -- For SQL Server
TO_CHAR(value, format)      -- For Oracle
```

**Example:**
```sql
SELECT FORMAT(salary, 'C') AS formatted_salary
FROM employees;
```
**Result:** Formats the `salary` column as currency.

## Practical Use Cases

1. **Cleaning Data:**
   Use `TRIM()` and `REPLACE()` to clean up messy data, such as removing extra spaces or unwanted characters.

2. **Formatting Output:**
   Use `UPPER()`, `LOWER()`, and `CONCAT()` to standardize and format text for reports.

3. **Extracting Information:**
   Use `SUBSTRING()`, `LEFT()`, and `RIGHT()` to extract specific parts of a string, such as prefixes or domain names.

4. **Validating Data:**
   Use `LENGTH()` and `INSTR()` to validate the structure of strings, such as checking the length of phone numbers or the presence of an `@` symbol in email addresses.

**Key Takeaways from this Lesson:**

String functions are essential tools for working with text data in SQL. By mastering these functions, you can clean, format, and extract valuable information from your data. Practice using these functions in real-world scenarios to enhance your SQL skills.