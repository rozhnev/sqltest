# Lesson 1.5: Overview of SQL

## What is SQL?
SQL (Structured Query Language) is a language used for managing and manipulating data in relational database management systems (RDBMS). It provides a powerful and flexible way to interact with databases, allowing users to perform various operations such as querying, inserting, updating, and deleting data.

SQL was developed in the early 1970s by IBM and has since become the de facto standard for relational database management. It is widely used across various industries and applications, making it an essential skill for data analysts, developers, and database administrators.
SQL is designed to be easy to learn and use, with a syntax that is both human-readable and machine-readable. It allows users to express complex queries and operations in a straightforward manner, making it accessible to both technical and non-technical users.

## Key Features of SQL
*   **Declarative Language:** SQL is a declarative language, meaning users specify what they want to retrieve or manipulate without detailing how to do it. This abstraction allows for easier query writing and optimization.
*   **Set-Based Operations:** SQL operates on sets of data rather than individual records, enabling efficient processing of large datasets.

## Subsets of SQL
SQL is divided into several subsets, each serving a specific purpose:
*   **Data Query Language (DQL):** Used for querying data from databases. The primary command is SELECT.
*   **Data Definition Language (DDL):** Used for defining and managing database structures. Commands include CREATE, ALTER, and DROP.
*   **Data Manipulation Language (DML):** Used for manipulating data within the database. Commands include INSERT, UPDATE, and DELETE.
*   **Data Control Language (DCL):** Used for controlling access to data within the database. Commands include GRANT and REVOKE.
*   **Transaction Control Language (TCL):** Used for managing transactions in the database. Commands include COMMIT, ROLLBACK, and SAVEPOINT.

## Objects of SQL
SQL operates on various objects within a database, including:
*   **Tables:** The primary structure for storing data in a relational database. Tables consist of rows and columns, where each row represents a record and each column represents an attribute of that record.
*   **Views:** Virtual tables that provide a way to present data from one or more tables in a specific format. Views can simplify complex queries and enhance security by restricting access to certain data.
*   **Indexes:** Structures that improve the speed of data retrieval operations on a database table. Indexes are created on one or more columns of a table to enhance query performance.
*   **Stored Procedures:** Predefined SQL code that can be executed as a single unit. Stored procedures can encapsulate complex logic and improve performance by reducing network traffic.
*   **Triggers:** Special types of stored procedures that automatically execute in response to certain events on a table, such as INSERT, UPDATE, or DELETE operations. Triggers can enforce business rules and maintain data integrity.
*   **Schemas:** Logical containers for database objects, such as tables, views, and indexes. Schemas help organize and manage database objects, providing a way to group related objects together.
*   **Constraints:** Rules applied to table columns to enforce data integrity. Common constraints include PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, and CHECK.
*   **Transactions:** A sequence of one or more SQL operations that are treated as a single unit of work. Transactions ensure data integrity and consistency by allowing multiple operations to be committed or rolled back as a group.
*   **Data Types:** Define the type of data that can be stored in a column, such as INTEGER, VARCHAR, DATE, and BOOLEAN. Data types ensure that the data stored in a table is consistent and valid.

## Basic SQL Conventions
THe unit of SQL is the **query**. A query is a request to RDBMS for retreive or modify data.

The basic structure of an SQL query consists of the following components:
*   **Statements:** Reserved words that have a specific meaning in SQL. Examples include SELECT, FROM, WHERE, and JOIN.
*   **Clauses:** Components of a SQL statement that specify the action to be performed. Common clauses include SELECT, FROM, WHERE, GROUP BY, and ORDER BY.
*   **Expressions:** Combinations of values, operators, and functions that evaluate to a single value. Expressions can be used in various parts of a SQL statement, such as the SELECT list or the WHERE clause.
*   **Identifiers:** Names used to refer to database objects, such as tables, columns, and views. Identifiers can be simple (e.g., table_name) or qualified (e.g., schema_name.table_name).
*   **Comments:** Non-executable text within SQL code that provides explanations or notes. Comments can be single-line (using --) or multi-line (using /* ... */).


## Writing Your First SQL Query

A basic SQL query consists of a SELECT statement, a FROM clause, and an optional WHERE clause. For example:

```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```