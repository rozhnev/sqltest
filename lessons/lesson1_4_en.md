---
title: "SQL Data Types Explained: INTEGER, VARCHAR, DATE and More"
description: "SQL data types define what values a column can store. Learn numeric, string, date/time, boolean, and other types with practical examples and selection tips."
keywords: ["SQL data types", "INTEGER VARCHAR DECIMAL", "SQL date types", "CHAR vs VARCHAR", "choosing SQL data types", "SQL column types"]
teaches: ["What numeric data types are and when to use INTEGER, DECIMAL, and FLOAT", "The difference between CHAR, VARCHAR, and TEXT", "What DATE, TIME, and TIMESTAMP store", "When to use BOOLEAN, BLOB, and JSON", "How to choose the right data type for each column"]
about: ["SQL data types", "INTEGER", "VARCHAR", "DECIMAL", "DATE", "TIMESTAMP", "BOOLEAN"]
---

_Lesson 1.4 · Reading time: ~8 min_

Data types define what kind of values each column can store in a relational database. In this lesson, you will learn the most common SQL data types, when to use each of them, and how correct type choices improve data quality, storage efficiency, and query performance.

# SQL Data Types Explained: INTEGER, VARCHAR, DATE and More

In the previous lesson, we covered tables, keys, constraints, and ACID. Now we move to a practical design decision you make for every table: choosing the right data type for each column.

<img src="/images/lessons/lesson1_3-datatypes.jpg" alt="Comparison of SQL numeric, text, and date/time data types used when designing table columns" width="100%">

Before diving into subtypes, here are the main SQL data type groups:

* **Numeric types**: `TINYINT`, `INT`, `BIGINT`, `DECIMAL`, `FLOAT`
* **String types**: `CHAR`, `VARCHAR`, `TEXT`
* **Date/time types**: `DATE`, `TIME`, `DATETIME`, `TIMESTAMP`
* **Specialized types**: `BOOLEAN`, `BLOB`, `JSON`

## What Are Numeric Data Types in SQL?

Numeric data types store numbers, but not all numbers should be stored the same way. In practice, you choose between:

* integer types for whole numbers,
* exact decimal types for financial values,
* floating-point types for approximate scientific values.

### INTEGER Family

Integer types store whole numbers without decimal places.

| Type | Typical size | Approximate signed range |
| :--- | :----------- | :----------------------- |
| `TINYINT` | 1 byte | -128 to 127 |
| `SMALLINT` | 2 bytes | -32,768 to 32,767 |
| `INTEGER` / `INT` | 4 bytes | -2,147,483,648 to 2,147,483,647 |
| `BIGINT` | 8 bytes | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 |

The exact ranges can vary slightly by database and by signed/unsigned support.

### DECIMAL / NUMERIC

`DECIMAL` stores exact values with fixed precision.

* `DECIMAL(p, s)` means:
  * `p` = total number of digits,
  * `s` = digits after the decimal point.
* Example: `DECIMAL(10, 2)` supports values up to 99,999,999.99.
* Best for prices, invoices, taxes, and any value where accuracy is mandatory.

### FLOAT / REAL / DOUBLE

Floating-point types store approximate values.

* Good for scientific calculations and telemetry data.
* Not ideal for currency because binary floating-point can introduce small rounding differences.
* `DOUBLE` generally offers higher precision than `FLOAT`.

## What Are String Data Types in SQL?

Text types differ mainly by length behavior and storage strategy.

### CHAR

* Fixed-length text.
* `CHAR(10)` always reserves space for 10 characters.
* If the value is shorter, many databases pad it with spaces.
* Useful for fixed-size data like ISO country codes.

### VARCHAR

* Variable-length text with an upper limit.
* `VARCHAR(255)` stores up to 255 characters but uses only the needed space.
* Good default choice for names, emails, titles, and labels.

### TEXT

* Large variable-length text.
* Useful for long descriptions, article bodies, comments, or logs.
* Behavior and indexing limits can differ by database system.

## What Are Date and Time Data Types?

Temporal types should be used for any value representing a date, a time, or an event timestamp.

### DATE

Stores only year-month-day.

### TIME

Stores only hour-minute-second.

### DATETIME / TIMESTAMP

Stores both date and time.

`TIMESTAMP` may have timezone-aware behavior in some systems, while `DATETIME` is often timezone-neutral. Always verify your DBMS behavior before designing audit or event tables.

## What Other Data Types Should You Know?

Many relational databases also support useful specialized types:

* `BOOLEAN`: stores true/false values.
* `BLOB`: stores binary content such as images or files.
* `JSON`: stores semi-structured JSON documents and often supports JSON functions/indexes.

## How to Choose the Right Data Type?

Use this practical checklist:

* Choose the smallest type that safely covers expected values.
* Use `DECIMAL` for money; avoid `FLOAT` for financial amounts.
* Prefer `VARCHAR` over `CHAR` unless data length is truly fixed.
* Store dates and times with temporal types, not strings.
* Check DB-specific behavior for defaults, timezone handling, and indexing.

Choosing data types carefully at design time reduces future data migration work, application bugs, and performance regressions.

---

**Key takeaways from this lesson:**

* Data types define what values a column can store and strongly affect data quality.
* Numeric types serve different goals: whole numbers, exact decimals, and approximate floating-point values.
* `CHAR`, `VARCHAR`, and `TEXT` should be chosen based on expected text length and storage behavior.
* Date/time fields should use `DATE`, `TIME`, or `TIMESTAMP` instead of plain text.
* Picking the correct type early helps avoid bugs, data cleanup, and performance issues later.

---

## Frequently Asked Questions

### What is the difference between DECIMAL and FLOAT?
`DECIMAL` stores exact values and is best for money. `FLOAT` stores approximate values and may introduce rounding differences, so it is better for scientific-style calculations.

### Should I use CHAR or VARCHAR for names and emails?
In most cases, use `VARCHAR` because names and emails have variable length. `CHAR` is better for fixed-length values like country codes.

### Is NULL a data type?
No. `NULL` means a missing or unknown value. It is not a separate data type but a special marker that can appear in columns, depending on constraints.

## Interview Questions

### How do you choose between INTEGER, BIGINT, and SMALLINT?
Estimate the expected value range and pick the smallest type that safely fits it. This improves storage efficiency while preventing overflow.

### Why is DECIMAL preferred for currency values?
Because `DECIMAL` stores exact precision and avoids floating-point rounding errors that can cause financial inaccuracies.

### What problems happen when data types are chosen poorly?
Typical issues include incorrect sorting/filtering, conversion errors, wasted storage, slower queries, and inconsistent application logic.

→ [Lesson 1.5: Understanding NULL Values in SQL](/en/lesson/getting-started/null-values)