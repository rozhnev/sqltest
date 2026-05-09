---
title: "Relational Database Concepts: Tables, Keys, and ACID"
description: "Learn the core building blocks of relational databases — tables, columns, rows, primary and foreign keys, and ACID transaction properties — with practical examples."
keywords: ["relational database concepts", "primary key", "foreign key", "ACID properties", "database tables", "SQL relational database"]
teaches: ["What tables, columns, and rows are in a relational database", "How primary keys uniquely identify rows", "How foreign keys link tables together", "What unique keys enforce", "What SQL constraints are and how NOT NULL and CHECK work", "What ACID properties guarantee in transactions"]
about: ["Relational database", "Primary key", "Foreign key", "SQL constraint", "ACID", "Database transaction", "SQL"]
---

_Lesson 1.3 · Reading time: ~10 min_

A **relational database** organizes data into tables connected by keys. In this lesson you will learn the core building blocks — tables, columns, rows, primary keys, foreign keys, unique keys, and constraints — and discover how the ACID model keeps transactions safe and reliable even under concurrent access or system failure.

# Relational Database Concepts: Tables, Keys, and ACID

In the previous lessons, we introduced the concept of databases and looked at the main database types. Now we'll dive deeper into the core components of **relational databases**, which are fundamental to understanding how data is organized and accessed using SQL.

<img src="/images/lessons/lesson1_2-rdb.jpg" alt="Diagram showing a relational database structure with two tables linked by a primary key and foreign key reference" width="100%">

## What Are Tables, Columns, and Rows?

Relational databases organize data into structures called **tables**. Think of a table as a spreadsheet:

* **Table:** A collection of related data. For example, a table might store information about customers, products, or orders.
* **Column:** A vertical set of data within a table. Each column represents a specific attribute or characteristic of the data. For instance, in a "Customers" table, columns might be "CustomerID," "FirstName," "LastName," and "Email."
* **Row:** A horizontal set of data within a table. Each row represents a single instance or record of the data. In a "Customers" table, each row would represent a single customer.

**Example:**

Let's visualize a simple "Customers" table:

|   CustomerID   |   FirstName   |   LastName   |   Email                |
| :------------- | :------------ | :----------- | :--------------------- |
|   1            |   John        |   Doe        |   john.doe@example.com   |
|   2            |   Jane        |   Smith      |   jane.smith@example.com   |
|   3            |   David       |   Lee        |   david.lee@example.com    |

* The entire structure is the **table** named "Customers."
* "CustomerID," "FirstName," "LastName," and "Email" are the **columns**.
* Each line (e.g., "1 | John | Doe | john.doe@example.com") is a **row**.

## What Are Database Keys? Primary, Foreign, and Unique

**Keys** are a critical concept in relational databases. They are used to establish relationships between tables and enforce data integrity. Here are the main types of keys:

###   Primary Key

* A **Primary Key** is a column (or a set of columns) that uniquely identifies each row in a table.
* **Characteristics of a Primary Key:**
    * **Unique:** No two rows can have the same primary key value.
    * **Not Null:** A primary key column cannot contain NULL values.
* In our "Customers" table, "CustomerID" is a good candidate for the primary key because each customer has a unique ID, and it cannot be empty.

###   Foreign Key

* A **Foreign Key** is a column (or a set of columns) in one table that refers to the Primary Key in another table.
* Foreign keys establish relationships between tables.
* For example, if we have an "Orders" table, it might have a "CustomerID" column that is a foreign key referencing the "CustomerID" in the "Customers" table. This links each order to the customer who placed it.

###   Unique Key

* A **Unique Key** is a column (or a set of columns) that ensures that the values in the column(s) are unique across all rows in the table.
* **Difference from Primary Key:**
    * A table can have only one primary key, but it can have multiple unique keys.
    * Unique key columns *can* allow NULL values (though implementations vary slightly).
* In our "Customers" table, "Email" could be a unique key, ensuring that each customer has a unique email address.

## What Are SQL Constraints?

A **constraint** is a rule applied to a column or table that the database engine enforces automatically. Keys (primary, foreign, unique) are a type of constraint. There are several other important constraints you will use in everyday SQL:

| Constraint | Purpose |
| :--------- | :------ |
| `NOT NULL` | The column must always have a value; NULL is not allowed. |
| `UNIQUE` | All values in the column must be distinct across rows. |
| `PRIMARY KEY` | Combines NOT NULL + UNIQUE; uniquely identifies each row. |
| `FOREIGN KEY` | Value must match an existing value in another table's column. |
| `CHECK` | Value must satisfy a specified condition, e.g. `age >= 0`. |

For example, in a `customers` table:

* `customer_id` can act as a `PRIMARY KEY`, so each customer has a unique identifier.
* `email` can be marked as `UNIQUE`, so two customers cannot share the same email address.
* `age` can use a `CHECK` rule such as `age >= 0`, so negative ages are rejected.

The database automatically enforces these rules and rejects invalid changes, which helps keep data consistent without extra application-level checks.

## What Is ACID? Transaction Safety in Relational Databases

When working with relational databases, another core concept is the **ACID** model. ACID defines the properties that make database transactions safe and reliable.

A **transaction** is a group of operations treated as one unit of work. For example, transferring money between two bank accounts usually involves at least two operations:

1. Subtract money from Account A.
2. Add money to Account B.

Both steps must succeed together, or neither should be applied.

**ACID stands for:**

* **Atomicity:** A transaction is "all or nothing." If one step fails, the whole transaction is rolled back.
* **Consistency:** A transaction must move the database from one valid state to another, preserving all defined rules and constraints.
* **Isolation:** Concurrent transactions should not interfere with each other in a way that causes incorrect results.
* **Durability:** Once a transaction is committed, its changes are permanent, even if there is a power loss or system crash.

These properties are essential in real-world systems such as banking, e-commerce, and inventory management, where incorrect or partial updates can cause serious problems.

---

**Key takeaways from this lesson:**

* A relational database stores data in **tables** made up of columns and rows.
* A **primary key** uniquely identifies each row; it must be unique and non-null.
* A **foreign key** links a row in one table to a row in another, enforcing referential integrity.
* A **unique key** guarantees uniqueness in a column but allows multiple unique keys per table.
* **Constraints** (`NOT NULL`, `CHECK`) enforce data rules at the database level automatically.
* The **ACID** model (Atomicity, Consistency, Isolation, Durability) ensures that transactions are reliable even under failure or concurrent access.

In the next lesson, we will look at the basic data types used in relational databases and how to choose the right type for each column.

---

## Frequently Asked Questions

### What is the difference between a primary key and a unique key?
A **primary key** uniquely identifies each row and cannot be NULL. A table can have only one primary key. A **unique key** also enforces uniqueness but can allow NULL values, and a table can have multiple unique keys. Use a primary key as the main row identifier; use unique keys to enforce uniqueness on other columns such as `email`.

### Can a foreign key reference a unique key instead of a primary key?
Yes. A foreign key can reference any column (or set of columns) that has a unique constraint, not just the primary key. However, referencing the primary key is the most common and recommended practice.

### What happens if an ACID transaction fails halfway through?
**Atomicity** ensures the entire transaction is rolled back, leaving the database in the state it was before the transaction started. No partial changes are saved.

## Interview Questions

### How would you explain a primary key in an interview?
A **primary key** is a column or combination of columns that uniquely identifies every row in a table. It must be unique, cannot contain NULL values, and there can be only one per table. It is used as the anchor for foreign key references from other tables.

### What is referential integrity and how do foreign keys enforce it?
**Referential integrity** means that a foreign key value in one table must always match an existing primary key value in the referenced table, or be NULL. The database engine enforces this automatically — attempts to insert an orphaned foreign key value or delete a referenced row will be rejected unless a cascade rule is defined.

### What does ACID stand for and why does it matter?
**ACID** stands for Atomicity, Consistency, Isolation, and Durability. It defines the guarantees that make database transactions reliable. Without ACID, concurrent writes could corrupt data, partial failures could leave the database in an invalid state, and committed changes could be lost after a crash. ACID is why relational databases are trusted for financial, medical, and other critical systems.

→ [Lesson 1.4: Basic Data Types](/en/lesson/getting-started/basic-data-types)