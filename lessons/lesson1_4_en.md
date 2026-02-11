Learn about NULL values in SQL, understanding that NULL represents missing or unknown data. This lesson covers how NULL differs from zero or an empty string, the importance of IS NULL and IS NOT NULL operators, and how NULL affects database operations and logic.

# Lesson 1.4: Understanding NULL Values in SQL

In the world of databases, you will often encounter situations where data is missing, unknown, or not applicable. SQL uses a special marker called **NULL** to represent these cases. Understanding NULL is critical because it behaves differently than any other value.

## What is NULL?

**NULL** is not a value; it is a **state** or a placeholder indicating that a data value does *not* exist in the database.

It is important to remember what NULL is **NOT**:
*   **NULL is not 0:** Zero is a number. NULL is the absence of a number.
*   **NULL is not an empty string (' '):** An empty string is a piece of text with zero characters. NULL is the absence of text.
*   **NULL is not "false":** In SQL logic, NULL remains "unknown."

## Why do we use NULL?
*   **Unknown information:** For example, we might not know a customer's middle name yet.
*   **Not applicable:** A "Company Tax ID" column would be NULL for an individual person.
*   **Missing data:** Data that was overlooked during entry.

## Working with NULL: IS NULL and IS NOT NULL

Because NULL represents an unknown state, you cannot use standard comparison operators like `=` or `<>` with it. Any comparison with NULL (e.g., `value = NULL`) will result in "unknown," not "true" or "false."

To check for NULL values, you must use specific operators:

### 1. IS NULL
Used to find records where a column has no value.
```sql
SELECT *
FROM address
WHERE address2 IS NULL;
```

### 2. IS NOT NULL
Used to find records where a column contains *any* data.
```sql
SELECT *
FROM address
WHERE address2 IS NOT NULL;
```

## NULL in Calculations

One of the most important things to remember is that **NULL propagates**. If you perform a mathematical operation with a NULL value, the result will always be NULL.

*   `10 + NULL = NULL`
*   `5 * NULL = NULL`
*   `'Hello ' + NULL = NULL`

## Key Takeaways from This Lesson

*   **NULL** represents missing, unknown, or non-applicable data.
*   It is **different** from zero, empty strings, or blank spaces.
*   Standard comparisons (`=` or `<>`) **do not work** with NULL.
*   Use **IS NULL** and **IS NOT NULL** to filter for missing data.
*   Most mathematical operations involving NULL will result in **NULL**.
