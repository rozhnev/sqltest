# Lesson 1.1: Introduction to Databases

Welcome to the exciting world of databases! In this first lesson, we'll lay the groundwork by understanding what databases are, why they're crucial in today's data-driven world, and the fundamental concepts we'll be exploring throughout this course.

## What is a Database?

At its core, a database is an organized collection of structured information, or data, typically stored electronically in a computer system. Think of it as a sophisticated digital filing cabinet. Instead of paper documents scattered everywhere, a database provides a structured way to store, manage, and retrieve information efficiently.

**Key Characteristics of a Database:**

* **Organized:** Data is structured in a specific way, making it easier to find and manage. This structure is often based on tables with rows and columns.
* **Persistent:** Data stored in a database is typically persistent, meaning it remains stored even when the application using it is closed or the computer is turned off.
* **Shared:** Multiple users and applications can often access and interact with the same database simultaneously.
* **Managed:** Database Management Systems (DBMS) are software applications that allow you to define, create, maintain, and access databases. Examples include MariaDB, PostgreSQL, MySQL, SQLite, Oracle, and Microsoft SQL Server.

## Why are Databases Important?

Databases are the backbone of countless applications and systems we use every day. Here are just a few reasons why they are so important:

* **Data Storage:** They provide a reliable and efficient way to store large volumes of data.
* **Data Retrieval:** They allow for quick and easy retrieval of specific information based on defined criteria.
* **Data Management:** DBMS provide tools for organizing, updating, and maintaining data integrity.
* **Data Sharing:** They enable multiple users and applications to access and share data in a controlled manner.
* **Data Analysis:** Structured data in databases is essential for performing analysis, generating reports, and gaining valuable insights.
* **Application Development:** Most modern applications rely on databases to store and manage their data, from social media platforms to e-commerce websites.

## Types of Databases (Brief Overview)

While this course will primarily focus on **Relational Databases**, it's helpful to have a basic understanding of other types:

* **Relational Databases (RDB):** Organize data into tables with rows and columns, establishing relationships between tables using keys. Examples: <a href="https://mariadb.org/" target="_blank">MariaDB</a>, <a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a>, <a href="https://mysql.com/" target="_blank">MySQL</a>,  <a href="https://www.sqlite.org/" target="_blank">SQLite</a>. This is the type we will be focusing on.
* **NoSQL Databases:** A broad category of databases that don't adhere to the traditional relational model. They are often used for handling unstructured or semi-structured data and for scalability in distributed environments. Examples: MongoDB, Cassandra, Redis.
* **In-Memory Databases:** Store data primarily in computer memory for faster access. Often used for caching or applications requiring very low latency. Examples: Redis (can also be persistent), Memcached.

## What is a DBMS?

A **Database Management System (DBMS)** is software that acts as an intermediary between users (or applications) and the database itself. It provides a systematic and controlled way to create, read, update, and delete data, while also ensuring security, consistency, and efficiency.

<img src="/images/lessons/lesson1_1-dbms.jpg" alt="DBMS overview" width="100%">

**Core Functions of a DBMS:**

* **Data Definition:** Allows you to define the structure (schema) of the database — creating tables, specifying data types, setting constraints, and establishing relationships.
* **Data Manipulation:** Provides mechanisms to insert, update, delete, and query data (typically through SQL).
* **Data Storage Management:** Handles how data is physically stored on disk, including indexing, buffering, and storage optimization for fast access.
* **Transaction Management:** Ensures that a series of operations either all succeed or all fail together (atomicity), keeping the database in a consistent state. This is governed by the **ACID** properties: Atomicity, Consistency, Isolation, and Durability.
* **Concurrency Control:** Manages simultaneous access by multiple users or applications, preventing conflicts and data corruption when several people modify data at the same time.
* **Access Control & Security:** Enforces authentication and authorization — controlling who can connect to the database and what operations they are permitted to perform.
* **Backup & Recovery:** Provides tools and mechanisms to back up data and restore the database to a consistent state after a failure.
* **Data Integrity:** Enforces rules (constraints) that keep data accurate and valid, such as ensuring a value is unique or that a reference to another table actually exists (referential integrity).

Well-known DBMS examples include **MariaDB**, **PostgreSQL**, **MySQL**, **SQLite**, **Oracle Database**, and **Microsoft SQL Server**.

## DBMS GUI Tools — And How They Differ from the DBMS

A **DBMS GUI (Graphical User Interface) tool** is a separate desktop or web application that provides a visual, user-friendly interface for interacting with a DBMS. While the DBMS is the engine that actually stores and processes data, a GUI tool is simply a **client** that connects to the DBMS and sends commands on your behalf.

**Examples of popular DBMS GUI tools:**

| Tool | Works with |
|------|-----------|
| **DBeaver** | MariaDB, PostgreSQL, MySQL, SQLite, and many more |
| **TablePlus** | MariaDB, PostgreSQL, MySQL, SQLite, and more |
| **pgAdmin** | PostgreSQL |
| **MySQL Workbench** | MySQL / MariaDB |
| **DataGrip** | Most major DBMS |
| **HeidiSQL** | MariaDB, MySQL, PostgreSQL |
| **DB Browser for SQLite** | SQLite |

**Key differences between a DBMS and a GUI tool:**

| Aspect | DBMS | DBMS GUI Tool |
|--------|------|---------------|
| **Role** | The database engine — stores, manages, and processes data | A client application — connects to the DBMS to display and edit data |
| **Required?** | Yes — cannot store or query data without it | No — optional convenience tool; the DBMS works without it |
| **Runs where?** | Typically on a server (or locally for SQLite) | On the developer's or administrator's machine |
| **Interface** | Command-line / programmatic API | Visual windows, query editors, table browsers |
| **Capabilities** | Full control over storage, transactions, security | Subset of DBMS features, presented visually |

In short, the **DBMS is the engine** and the **GUI tool is the dashboard**. You can drive without a dashboard, but the dashboard makes it far easier to see what is happening and control things. Throughout this course we will primarily interact with databases using **SQL** directly, which is the language understood by every DBMS — regardless of which GUI tool you may choose to use alongside it.

## Relational Databases: Our Focus

For this course, we will be diving deep into **Relational Databases** and the **SQL (Structured Query Language)** used to interact with them. The relational model, with its well-defined structure and powerful querying capabilities, remains a cornerstone of data management and analysis.

In the next lesson, we'll delve into the fundamental concepts of relational databases, including tables, columns, rows, and the crucial role of keys.

**Key Takeaways from this Lesson:**

* A database is an organized and persistent collection of structured data.
* Databases are essential for storing, managing, retrieving, and sharing information.
* A **DBMS** is the software engine that stores, manages, and controls access to a database — providing data definition, manipulation, transaction management, security, and more.
* A **DBMS GUI tool** is an optional client application that provides a visual interface to a DBMS — it is separate from the DBMS itself.
* We will primarily focus on Relational Databases (RDB) and SQL in this course.

Welcome aboard! Let's continue our journey into the world of SQL.