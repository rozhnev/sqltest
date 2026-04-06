This lesson introduces the `TRUNCATE` and `DROP TABLE` statements, which are used to remove data or tables from a database. You will learn how they differ from each other and from `DELETE`, when to use each one, and which risks should be kept in mind. By the end of this lesson, you will be able to choose the right statement for clearing or removing a table.

# Lesson 9.2: The TRUNCATE and DROP TABLE Statements

In the previous lesson, we learned how to create tables with `CREATE TABLE`. But in real database work, it is important not only to create structure, but also to understand how to clear tables or remove them completely. For that, SQL provides the `TRUNCATE` and `DROP TABLE` statements.

Both belong to Data Definition Language (DDL), but they solve different tasks. `TRUNCATE` quickly removes all rows from a table, while `DROP TABLE` removes the table itself together with its structure.

## What `TRUNCATE` Does

The `TRUNCATE` statement removes all rows from a table, but the table itself remains.

After running `TRUNCATE`:

- the table structure is preserved;
- column names, data types, and constraints remain;
- the table becomes empty;
- in many DBMSs, the operation is faster than a large `DELETE`.

### `TRUNCATE` Syntax

```sql
TRUNCATE TABLE table_name;
```

### `TRUNCATE` Example

```sql
TRUNCATE TABLE logs;
```

After that, the `logs` table will still exist in the database, but all its rows will be removed.

---

## What `DROP TABLE` Does

The `DROP TABLE` statement removes a table completely.

After running `DROP TABLE`:

- all table data is removed;
- the table structure is removed;
- the table no longer exists in the database;
- it cannot be referenced in later queries unless it is created again.

### `DROP TABLE` Syntax

```sql
DROP TABLE table_name;
```

### `DROP TABLE` Example

```sql
DROP TABLE old_reports;
```

After that, the `old_reports` table will be fully removed from the database.

---

## How `TRUNCATE` Differs from `DROP TABLE`

Although both statements remove data, there is a fundamental difference between them.

### 1. What exactly is removed

- `TRUNCATE` removes only rows.
- `DROP TABLE` removes both the rows and the table itself.

### 2. Whether the table can still be used

- After `TRUNCATE`, the table remains and new data can be inserted into it again.
- After `DROP TABLE`, the table is gone, and it must be recreated before it can be used again.

### 3. When to use it

- `TRUNCATE` is suitable when you need to quickly clear a table while keeping its structure.
- `DROP TABLE` is suitable when the table is no longer needed at all.

---

## How `TRUNCATE` Differs from `DELETE`

Beginners often compare `TRUNCATE` with `DELETE`, because both commands can remove data from a table.

The main differences are:

- `DELETE` can be used with `WHERE` to remove only part of the rows;
- `TRUNCATE` removes all rows from the table at once;
- `DELETE` belongs to DML, while `TRUNCATE` is usually treated as DDL;
- `TRUNCATE` is often faster in many DBMSs when the whole table must be cleared;
- behavior related to logging, rollback, and identity counter resets depends on the specific DBMS.

If you need to remove only part of the data, `DELETE` is usually the right choice. If you need to quickly clear the whole table but keep its structure, `TRUNCATE` is often more convenient.

---

## What to Pay Attention To

When using `TRUNCATE` and `DROP TABLE`, it is important to remember a few rules:

- always check whether you need to remove only the data or the whole table structure;
- do not use `DROP TABLE` if the table structure will still be needed;
- do not replace `DELETE` with `TRUNCATE` if you need to remove only part of the rows;
- remember that in some DBMSs `TRUNCATE` cannot be used if the table is referenced by foreign keys;
- keep in mind that `TRUNCATE` behavior and rollback support depend on the specific DBMS.

Using these statements incorrectly can lead to loss of data or table structure.

---

## Practical Example

Imagine that we have a helper table called `daily_import` into which intermediate data from an external system is loaded every day.

If the table is used regularly but must be completely cleared before each new load, `TRUNCATE` is appropriate:

```sql
TRUNCATE TABLE daily_import;
```

After that, the table structure remains, and new data can be loaded into it again.

If the table was created only for a one-time task and is no longer needed, it can be removed completely:

```sql
DROP TABLE daily_import;
```

In the first case, we prepare the existing table for reuse. In the second, we completely remove an object that is no longer needed from the database.

---

**Key takeaways from this lesson:**

*   `TRUNCATE` removes all rows from a table but keeps its structure.
*   `DROP TABLE` removes both the data and the table itself.
*   `TRUNCATE` and `DELETE` solve similar problems, but they work differently.
*   Before using them, it is important to understand whether you need to clear a table or remove it completely.
*   The behavior of `TRUNCATE` and `DROP TABLE` can differ slightly across DBMSs.

In the next lesson, we will look at temporary tables and understand when they are convenient for intermediate results.
