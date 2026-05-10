---
title: "NULL Values in Relational Databases: Meaning, IS NULL, and Logic"
description: "Learn what NULL means in relational databases, how it differs from 0 and empty strings, and how IS NULL, IS NOT NULL, and calculations behave."
keywords: ["NULL values relational databases", "IS NULL", "IS NOT NULL", "NULL vs empty string", "NULL in SQL logic", "missing data databases"]
teaches: ["What NULL means in a relational database", "How NULL differs from 0, empty strings, and false", "Why databases use NULL for unknown or non-applicable data", "How IS NULL and IS NOT NULL work", "How NULL behaves in calculations and comparisons"]
about: ["NULL", "IS NULL", "IS NOT NULL", "Relational database", "Missing data", "Three-valued logic"]
---

_Lesson 1.5 · Reading time: ~7 min_

NULL is the special marker relational databases use when a value is missing, unknown, or not applicable. In this lesson, you will learn what NULL really means, how it differs from ordinary values, and how to work with it safely in comparisons and simple queries.

# NULL Values in Relational Databases: Meaning, IS NULL, and Logic

In the previous lessons, we looked at relational concepts and data types. Now we need to understand what happens when a column does not contain a meaningful value at all.

<img src="/images/lessons/lesson1_5-sql.jpg" alt="Illustration showing NULL as a missing or unknown value in relational database columns" width="100%">

## What Does NULL Mean in a Relational Database?

**NULL** does not mean a normal stored value. It is a special marker that tells the database that the value is missing, unknown, or not applicable.

This is important because NULL does not behave like text, numbers, or boolean values. It follows its own rules in comparisons, filtering, and calculations.

## What Is NULL Not?

To avoid confusion, remember what NULL is **not**:

* **NULL is not 0**: zero is a real numeric value.
* **NULL is not an empty string**: `''` is still text, even if it contains no characters.
* **NULL is not false**: in database logic, NULL usually means **unknown**, not true or false.

## Why Do Databases Use NULL?

Databases use NULL when a value cannot be filled in normally.

Typical cases:

* **Unknown information**: a customer's middle name may not be known yet.
* **Not applicable**: a company tax ID does not apply to a private individual.
* **Missing data**: some information may have been skipped during data entry.

## How Do IS NULL and IS NOT NULL Work?

Because NULL represents an unknown state, standard comparison operators such as `=` and `<>` do not work correctly with it.

For example, `value = NULL` does not return true. To check NULL properly, use special operators.

### IS NULL

Use `IS NULL` to find rows where a column has no value:

```sql
SELECT *
FROM address
WHERE address2 IS NULL;
```

### IS NOT NULL

Use `IS NOT NULL` to find rows where a column contains some value:

```sql
SELECT *
FROM address
WHERE address2 IS NOT NULL;
```

## How Does NULL Behave in Calculations and Logic?

One of the most important rules is that **NULL often propagates**. If you use NULL in a calculation, the result is usually NULL as well.

* `10 + NULL = NULL`
* `5 * NULL = NULL`
* `'Hello ' + NULL = NULL`

The same idea affects comparisons. Since NULL means "unknown," many expressions involving NULL also return an unknown result rather than true or false.

---

**Key takeaways from this lesson:**

* `NULL` represents missing, unknown, or non-applicable data.
* `NULL` is different from zero, empty strings, and boolean false.
* Standard comparisons such as `=` and `<>` do not work correctly with NULL.
* Use `IS NULL` and `IS NOT NULL` when filtering NULL values.
* Calculations involving NULL often return NULL as the result.

---

## Frequently Asked Questions

### Is NULL the same as an empty string?
No. An empty string is still a text value with zero characters. `NULL` means there is no known value stored.

### Why does `value = NULL` not work?
Because NULL means "unknown," and standard comparison operators are not designed to test that state. Use `IS NULL` instead.

### Can NULL appear in numeric columns?
Yes. NULL is not tied to one data type. A numeric column, text column, or date column can all contain NULL unless a constraint forbids it.

## Interview Questions

### How would you explain NULL in a database interview?
NULL is a special marker that represents missing, unknown, or not applicable data. It is not the same as zero, false, or an empty string, and it follows special rules in comparisons and calculations.

### Why do SQL queries use IS NULL instead of = NULL?
Because NULL represents an unknown state. Standard operators like `=` and `<>` do not evaluate NULL the same way they evaluate ordinary values, so SQL provides `IS NULL` and `IS NOT NULL` for correct checks.

### What is a common mistake when working with NULL?
A common mistake is treating NULL like an ordinary value in comparisons or arithmetic. This can produce unexpected results in filters, conditions, and calculated fields.

In the next lesson, we will introduce SQL itself and look at the basic structure of a query.
