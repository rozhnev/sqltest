---
title: "What Is SQL: Query Language and SQL Query Structure"
description: "SQL is the standard language for relational databases. Learn how SQL is organized, what its subsets are, and how a basic query is built."
keywords: ["what is SQL", "SQL overview", "SQL query structure", "SELECT FROM WHERE", "SQL subsets"]
teaches: ["Understand SQL's role in relational databases", "Distinguish DQL, DDL, DML, DCL, and TCL", "Read the structure of a basic SQL query", "Recognize core database objects"]
about: ["SQL", "Relational database", "RDBMS", "SELECT", "DDL", "DML", "Transactions"]
---

_Lesson 1.6 · Reading time: ~8 min_

SQL (Structured Query Language) is the core language for working with relational databases. In this lesson, you will see how SQL is organized, which tasks it solves, and what a first basic query looks like. By the end of the lesson, you will be able to read simple SQL constructs with confidence and understand their purpose.

# What Is SQL: Overview of the Language and Query Structure

In the previous lesson, we discussed NULL values and how to work with missing data. Now it is time to look at the bigger picture: what SQL is and why most practical analytics in relational databases is built on it.

SQL is important not only for developers. It is also essential for analysts, data engineers, and anyone who extracts, validates, and transforms data in daily work.

<img src="/images/lessons/lesson1_5-sql.jpg" alt="Diagram showing SQL as a language for querying and modifying data in a relational database" width="100%">

---

## What is SQL and why is it useful?

**SQL** (Structured Query Language) is the language we use to communicate with an RDBMS in order to read, insert, update, and delete data.

SQL was developed in the 1970s at IBM and became the de facto standard for relational database management. Its syntax is strict enough for machine execution while still readable for humans, which makes SQL practical for everyday data tasks.

In practice, SQL solves three main categories of tasks:

* retrieve required data from tables;
* modify data and database structure;
* control access and transactions.

---

## Key features of SQL

* **Declarative language:** you describe the result you need instead of writing step-by-step execution logic.
* **Set-based operations:** SQL processes many rows at once, not one record at a time.
* **Standardized syntax:** core constructs are similar across different RDBMSs, making skills transferable.

---

## Subsets of SQL

SQL is divided into several subsets, each serving a specific purpose:

* **Data Query Language (DQL):** Used for querying data from databases. The primary command is SELECT.
* **Data Definition Language (DDL):** Used for defining and managing database structures. Commands include CREATE, ALTER, and DROP.
* **Data Manipulation Language (DML):** Used for manipulating data within the database. Commands include INSERT, UPDATE, and DELETE.
* **Data Control Language (DCL):** Used for controlling access to data within the database. Commands include GRANT and REVOKE.
* **Transaction Control Language (TCL):** Used for managing transactions in the database. Commands include COMMIT, ROLLBACK, and SAVEPOINT.

---

## Core SQL objects

SQL operates on various objects within a database, including:

* **Tables:** The primary structure for storing data in a relational database. Tables consist of rows and columns, where each row represents a record and each column represents an attribute of that record.
* **Views:** Virtual tables that provide a way to present data from one or more tables in a specific format. Views can simplify complex queries and enhance security by restricting access to certain data.
* **Indexes:** Structures that improve the speed of data retrieval operations on a database table. Indexes are created on one or more columns of a table to enhance query performance.
* **Stored Procedures:** Predefined SQL code that can be executed as a single unit. Stored procedures can encapsulate complex logic and improve performance by reducing network traffic.
* **Triggers:** Special types of stored procedures that automatically execute in response to certain events on a table, such as INSERT, UPDATE, or DELETE operations. Triggers can enforce business rules and maintain data integrity.
* **Schemas:** Logical containers for database objects, such as tables, views, and indexes. Schemas help organize and manage database objects, providing a way to group related objects together.
* **Constraints:** Rules applied to table columns to enforce data integrity. Common constraints include PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, and CHECK.
* **Transactions:** A sequence of one or more SQL operations that are treated as a single unit of work. Transactions ensure data integrity and consistency by allowing multiple operations to be committed or rolled back as a group.
* **Data Types:** Define the type of data that can be stored in a column, such as INTEGER, VARCHAR, DATE, and BOOLEAN. Data types ensure that the data stored in a table is consistent and valid.

Understanding these objects is important because SQL queries always refer to them.

---

## Basic SQL conventions

The basic unit in SQL is a **query**. A query is a request to the RDBMS to retrieve or modify data.

The basic structure of a SQL query consists of the following components:

* **Statements:** Reserved words that have a specific meaning in SQL. Examples include SELECT, FROM, WHERE, and JOIN.
* **Clauses:** Components of a SQL statement that specify the action to be performed. Common clauses include SELECT, FROM, WHERE, GROUP BY, and ORDER BY.
* **Expressions:** Combinations of values, operators, and functions that evaluate to a single value. Expressions can be used in various parts of a SQL statement, such as the SELECT list or the WHERE clause.
* **Identifiers:** Names used to refer to database objects, such as tables, columns, and views. Identifiers can be simple (for example, table_name) or qualified (for example, schema_name.table_name).
* **Comments:** Non-executable text in SQL code that provides explanations or notes. Comments can be single-line (using --) or multi-line (using /* ... */).

---

## Writing your first SQL query

A basic query template usually includes SELECT, FROM, and optionally WHERE:

```sql
SELECT column1,
	   column2
FROM table_name
WHERE condition;
```

*Result: the query returns only rows from table_name that match condition, and displays columns column1 and column2.*

Even this short template is useful because it shows the common structure used in most analytical SQL queries.

---

**Key takeaways from this lesson:**

* SQL is the core language for working with relational databases.
* SQL is declarative: you describe the result, not the execution algorithm.
* SQL includes subsets: DQL, DDL, DML, DCL, and TCL.
* Queries are built from statements, clauses, expressions, and identifiers.
* A basic query framework is SELECT ... FROM ... WHERE ....

---

## Frequently Asked Questions

### Is SQL a programming language or a query language?
SQL is usually described as a query language. It is not a general-purpose programming language, but it is the standard for working with relational data.

### Why is it useful to know SQL subsets?
Subsets help you quickly understand a command's purpose: data retrieval, schema changes, access control, or transaction handling.

### Can I write SQL the same way in every RDBMS?
Core constructs are very similar, but syntax details and built-in functions can differ between MariaDB, PostgreSQL, SQL Server, and other systems.

## Interview Questions

### How would you explain SQL in a short answer?
**SQL** is the standard language for managing and querying data in relational databases. It is used to read and modify data, manage schema objects, and control transactions.

### What is the difference between DDL and DML?
**DDL** defines and changes database structure (tables, indexes, schemas), while **DML** works with table data (inserting, updating, deleting rows).

### What are the core parts of a basic SQL query?
A basic query usually includes **SELECT** (what to return), **FROM** (which table to read), and **WHERE** (which rows to filter).

In the next lesson, we will move to SQL command types and see how they are applied in practical tasks.