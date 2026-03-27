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

### `LENGTH()`, `CHAR_LENGTH()`, or `LEN()` - Returns the length of a string (in characters or bytes, depending on the DBMS).

**Syntax:**
```sql
CHAR_LENGTH(string) -- Number of characters (for example, in MySQL)
LENGTH(string)      -- In MySQL: length in bytes
LEN(string)         -- In SQL Server: length in characters
```

Important: in different DBMSs, “string length” may mean different things. Some functions return length in characters, while others return length in bytes. Always check which unit a specific function uses in your DBMS.

**When `LENGTH()` and `CHAR_LENGTH()` can differ (for example, in MySQL):**
- For strings containing only Latin letters and digits, the values often match.
- For strings with multibyte characters (Cyrillic, emoji, CJK characters), `LENGTH()` is usually greater than `CHAR_LENGTH()` because it counts bytes.

**Quick example:**
- `'SQL'`: `LENGTH` = 3, `CHAR_LENGTH` = 3
- `'Привет'`: `LENGTH` = 12, `CHAR_LENGTH` = 6

**Example:**
```sql
SELECT CHAR_LENGTH(product_name) AS name_length
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

**Important:** `CONCAT()` behavior with `NULL` depends on the DBMS. For example, in MySQL and MariaDB, if at least one argument is `NULL`, the result of `CONCAT()` is also `NULL`.

### `CONCAT_WS()` - Concatenates strings with a separator and usually skips `NULL` values.

**Syntax:**
```sql
CONCAT_WS(separator, string1, string2, ...)
```

**Example:**
```sql
SELECT CONCAT_WS(' ', first_name, last_name) AS full_name
FROM employees;
```
**Result:** Combines `first_name` and `last_name` with a space, skipping `NULL` values in the arguments.

If you need NULL-safe concatenation without a separator, you can use `CONCAT_WS('', string1, string2, ...)`.

### `TRIM()` - Removes leading and trailing characters from a string, most often spaces.

**Syntax:**
```sql
TRIM(string)
TRIM([characters FROM] string)
```

**Example:**
```sql
SELECT TRIM('   SQL Basics   ') AS trimmed_string;
```
**Result:** Returns `'SQL Basics'` without leading or trailing spaces.

In the simplest case, `TRIM()` removes spaces from both ends of a string. In some DBMSs, the function also allows you to specify exactly which characters should be removed.

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
   Use `UPPER()`, `LOWER()`, `CONCAT()`, and `CONCAT_WS()` to standardize and format text for reports.

3. **Extracting Information:**
   Use `SUBSTRING()`, `LEFT()`, and `RIGHT()` to extract specific parts of a string, such as prefixes or domain names.

4. **Validating Data:**
   Use character-counting functions (for example, `CHAR_LENGTH()` or `LEN()`) and `INSTR()` to validate string structure, such as checking the length of phone numbers or the presence of an `@` symbol in email addresses.

**Key Takeaways from this Lesson:**

String functions are essential tools for working with text data in SQL. By mastering these functions, you can clean, format, and extract valuable information from your data. Practice using these functions in real-world scenarios to enhance your SQL skills.