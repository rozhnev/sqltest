# Lesson 1.2: Relational Database Concepts

In the previous lesson, we introduced the concept of databases. Now, we'll dive deeper into the core components of **Relational Databases**, which are fundamental to understanding how data is organized and accessed using SQL.

<img src="/images/lessons/lesson1_2-rdb.jpg" alt="DBMS overview" width="100%">

##   Tables, Columns, and Rows

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

##   Keys: Ensuring Data Integrity

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

##   ACID: Reliable Transactions in Databases

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

##   Importance of These Concepts

Understanding tables, columns, rows, and keys is fundamental to working with relational databases.

* They define how data is structured and organized.
* They allow us to query and retrieve specific information efficiently.
* Keys ensure data integrity and establish relationships between different sets of data.
* ACID properties ensure that data changes remain correct and reliable, even under failures or concurrent access.

In the following lessons, we will build upon these concepts as we learn to use SQL to interact with relational databases.