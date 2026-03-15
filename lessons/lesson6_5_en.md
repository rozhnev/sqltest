---
title: "SQL Recursive CTEs: Hierarchical Data Tutorial with Examples"
description: "Master SQL recursive Common Table Expressions for hierarchical data. Learn recursive CTE syntax, examples with organizational charts, bill of materials, and practical tree traversal techniques."
keywords: "SQL recursive CTE, hierarchical data SQL, recursive query, WITH RECURSIVE, tree structure SQL, parent-child SQL, organizational chart SQL, SQL tutorial"
lang: "en"
region: "US, GB, CA, AU"
---

# Lesson 6.5: Recursive CTEs for Hierarchical Data

Recursive CTEs are one of the most powerful features in SQL, enabling you to work with hierarchical and tree-structured data. In this lesson, we'll explore how to use recursive Common Table Expressions to query data that has parent-child relationships, such as organizational charts, category trees, and bill of materials.

## What Are Recursive CTEs?

A **Recursive CTE** is a Common Table Expression that references itself, allowing you to traverse hierarchical data structures. Unlike regular CTEs that execute once, recursive CTEs execute iteratively until a termination condition is met.

Common use cases for recursive CTEs:
- **Organizational hierarchies**: Employee-manager relationships
- **Category trees**: Product categories with subcategories
- **Bill of Materials (BOM)**: Parts and subparts relationships
- **File system structures**: Folders and subfolders
- **Social networks**: Friend-of-friend relationships
- **Geographic hierarchies**: Country > State > City relationships

## Recursive CTE Syntax

The general syntax for a recursive CTE is:

```sql
WITH RECURSIVE cte_name AS (
    -- Anchor member (base case)
    SELECT ...
    FROM table
    WHERE condition
    
    UNION ALL
    
    -- Recursive member (recursive case)
    SELECT ...
    FROM table
    JOIN cte_name ON condition
)
SELECT * FROM cte_name;
```

**Components:**
- **WITH RECURSIVE**: Keyword that introduces a recursive CTE
- **Anchor member**: The initial query that returns the starting rows (base case)
- **UNION ALL**: Combines anchor and recursive members
- **Recursive member**: The query that references the CTE itself
- **Termination**: The recursion stops when the recursive member returns no rows

## How Recursive CTEs Work

The execution process:

1. **Execute anchor member**: Gets the initial set of rows
2. **Execute recursive member**: Uses results from step 1
3. **Repeat step 2**: Uses results from previous iteration
4. **Continue until**: Recursive member returns no rows
5. **Return all results**: Combined results from all iterations

## Basic Example: Number Sequence

Let's start with a simple example that generates a sequence of numbers:

```sql
WITH RECURSIVE number_sequence AS (
    -- Anchor member: start with 1
    SELECT 1 AS n
    
    UNION ALL
    
    -- Recursive member: add 1 to previous value
    SELECT n + 1
    FROM number_sequence
    WHERE n < 10
)
SELECT n
FROM number_sequence;
```

**Result:**
```
n
--
1
2
3
4
5
6
7
8
9
10
```

**How it works:**
1. Anchor: Returns `1`
2. Iteration 1: `1 + 1 = 2`
3. Iteration 2: `2 + 1 = 3`
4. ... continues until `n < 10` is false
5. Final iteration: Returns `10`, but `10 < 10` is false, so recursion stops

## Employee Hierarchy Example

Let's create a table representing an organizational structure:

```sql
-- Sample employee table
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT,
    title VARCHAR(100)
);

-- Sample data
INSERT INTO employee VALUES
    (1, 'Alice Johnson', NULL, 'CEO'),
    (2, 'Bob Smith', 1, 'VP of Engineering'),
    (3, 'Carol White', 1, 'VP of Sales'),
    (4, 'David Brown', 2, 'Engineering Manager'),
    (5, 'Eve Davis', 2, 'Engineering Manager'),
    (6, 'Frank Miller', 3, 'Sales Manager'),
    (7, 'Grace Wilson', 4, 'Senior Developer'),
    (8, 'Henry Moore', 4, 'Developer'),
    (9, 'Ivy Taylor', 5, 'Developer'),
    (10, 'Jack Anderson', 6, 'Sales Representative');
```

### Finding All Subordinates

To find all employees reporting to a specific manager (directly or indirectly):

```sql
WITH RECURSIVE subordinates AS (
    -- Anchor: Start with the manager
    SELECT
        employee_id,
        employee_name,
        manager_id,
        title,
        0 AS level
    FROM
        employee
    WHERE
        employee_name = 'Bob Smith'
    
    UNION ALL
    
    -- Recursive: Find direct reports
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.title,
        s.level + 1
    FROM
        employee e
    INNER JOIN
        subordinates s ON e.manager_id = s.employee_id
)
SELECT
    employee_id,
    employee_name,
    title,
    level
FROM
    subordinates
ORDER BY
    level, employee_name;
```

**Result:**
```
employee_id | employee_name   | title                | level
------------|-----------------|----------------------|------
2           | Bob Smith       | VP of Engineering    | 0
4           | David Brown     | Engineering Manager  | 1
5           | Eve Davis       | Engineering Manager  | 1
7           | Grace Wilson    | Senior Developer     | 2
8           | Henry Moore     | Developer            | 2
9           | Ivy Taylor      | Developer            | 2
```

### Building the Full Organizational Chart

To display the complete hierarchy from the CEO down:

```sql
WITH RECURSIVE org_chart AS (
    -- Anchor: Start with the CEO (no manager)
    SELECT
        employee_id,
        employee_name,
        manager_id,
        title,
        0 AS level,
        CAST(employee_name AS VARCHAR(1000)) AS path
    FROM
        employee
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: Add each level
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.title,
        oc.level + 1,
        CONCAT(oc.path, ' > ', e.employee_name)
    FROM
        employee e
    INNER JOIN
        org_chart oc ON e.manager_id = oc.employee_id
)
SELECT
    REPEAT('  ', level) || employee_name AS hierarchy,
    title,
    level,
    path
FROM
    org_chart
ORDER BY
    path;
```

**Result:**
```
hierarchy                      | title                | level | path
-------------------------------|----------------------|-------|---------------------------
Alice Johnson                  | CEO                  | 0     | Alice Johnson
  Bob Smith                    | VP of Engineering    | 1     | Alice Johnson > Bob Smith
    David Brown                | Engineering Manager  | 2     | Alice Johnson > Bob Smith > David Brown
      Grace Wilson             | Senior Developer     | 3     | Alice Johnson > Bob Smith > David Brown > Grace Wilson
      Henry Moore              | Developer            | 3     | Alice Johnson > Bob Smith > David Brown > Henry Moore
    Eve Davis                  | Engineering Manager  | 2     | Alice Johnson > Bob Smith > Eve Davis
      Ivy Taylor               | Developer            | 3     | Alice Johnson > Bob Smith > Eve Davis > Ivy Taylor
  Carol White                  | VP of Sales          | 1     | Alice Johnson > Carol White
    Frank Miller               | Sales Manager        | 2     | Alice Johnson > Carol White > Frank Miller
      Jack Anderson            | Sales Representative | 3     | Alice Johnson > Carol White > Frank Miller > Jack Anderson
```

## Category Tree Example

Let's work with a product category hierarchy:

```sql
-- Sample category table
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    parent_category_id INT
);

-- Sample data
INSERT INTO category VALUES
    (1, 'Electronics', NULL),
    (2, 'Computers', 1),
    (3, 'Phones', 1),
    (4, 'Laptops', 2),
    (5, 'Desktops', 2),
    (6, 'Gaming Laptops', 4),
    (7, 'Business Laptops', 4),
    (8, 'Smartphones', 3),
    (9, 'Feature Phones', 3);
```

### Finding All Subcategories

To find all subcategories under "Computers":

```sql
WITH RECURSIVE category_tree AS (
    -- Anchor: Start with Computers
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS depth,
        CAST(category_name AS VARCHAR(1000)) AS path
    FROM
        category
    WHERE
        category_name = 'Computers'
    
    UNION ALL
    
    -- Recursive: Get all subcategories
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.depth + 1,
        CONCAT(ct.path, ' > ', c.category_name)
    FROM
        category c
    INNER JOIN
        category_tree ct ON c.parent_category_id = ct.category_id
)
SELECT
    category_id,
    REPEAT('  ', depth) || category_name AS category_hierarchy,
    depth,
    path
FROM
    category_tree
ORDER BY
    path;
```

**Result:**
```
category_id | category_hierarchy    | depth | path
------------|----------------------|-------|--------------------------------
2           | Computers            | 0     | Computers
4           |   Laptops            | 1     | Computers > Laptops
6           |     Gaming Laptops   | 2     | Computers > Laptops > Gaming Laptops
7           |     Business Laptops | 2     | Computers > Laptops > Business Laptops
5           |   Desktops           | 1     | Computers > Desktops
```

## Finding Ancestors

To find all parent categories of a specific category:

```sql
WITH RECURSIVE category_ancestors AS (
    -- Anchor: Start with Gaming Laptops
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level_up
    FROM
        category
    WHERE
        category_name = 'Gaming Laptops'
    
    UNION ALL
    
    -- Recursive: Get parent categories
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ca.level_up + 1
    FROM
        category c
    INNER JOIN
        category_ancestors ca ON c.category_id = ca.parent_category_id
)
SELECT
    category_id,
    category_name,
    level_up
FROM
    category_ancestors
ORDER BY
    level_up;
```

**Result:**
```
category_id | category_name   | level_up
------------|-----------------|----------
6           | Gaming Laptops  | 0
4           | Laptops         | 1
2           | Computers       | 2
1           | Electronics     | 3
```

## Bill of Materials Example

A classic use case for recursive CTEs is exploring bill of materials (parts and subparts):

```sql
-- Sample parts table
CREATE TABLE parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100),
    quantity INT
);

-- Sample bill of materials table
CREATE TABLE bom (
    parent_part_id INT,
    child_part_id INT,
    quantity_needed INT,
    PRIMARY KEY (parent_part_id, child_part_id)
);

-- Sample data
INSERT INTO parts VALUES
    (1, 'Bicycle', 1),
    (2, 'Frame', 1),
    (3, 'Wheel', 2),
    (4, 'Tire', 1),
    (5, 'Rim', 1),
    (6, 'Spoke', 36);

INSERT INTO bom VALUES
    (1, 2, 1),  -- Bicycle needs 1 Frame
    (1, 3, 2),  -- Bicycle needs 2 Wheels
    (3, 4, 1),  -- Wheel needs 1 Tire
    (3, 5, 1),  -- Wheel needs 1 Rim
    (5, 6, 36); -- Rim needs 36 Spokes
```

### Calculating Total Parts Needed

To find all parts needed to build a bicycle:

```sql
WITH RECURSIVE parts_explosion AS (
    -- Anchor: Start with the top-level product
    SELECT
        p.part_id,
        p.part_name,
        1 AS quantity,
        0 AS level,
        CAST(p.part_name AS VARCHAR(1000)) AS path
    FROM
        parts p
    WHERE
        p.part_name = 'Bicycle'
    
    UNION ALL
    
    -- Recursive: Explode the BOM
    SELECT
        p.part_id,
        p.part_name,
        pe.quantity * b.quantity_needed,
        pe.level + 1,
        CONCAT(pe.path, ' > ', p.part_name)
    FROM
        parts_explosion pe
    INNER JOIN
        bom b ON pe.part_id = b.parent_part_id
    INNER JOIN
        parts p ON b.child_part_id = p.part_id
)
SELECT
    part_id,
    REPEAT('  ', level) || part_name AS part_hierarchy,
    quantity,
    level,
    path
FROM
    parts_explosion
ORDER BY
    path;
```

**Result:**
```
part_id | part_hierarchy | quantity | level | path
--------|----------------|----------|-------|--------------------------------
1       | Bicycle        | 1        | 0     | Bicycle
2       |   Frame        | 1        | 1     | Bicycle > Frame
3       |   Wheel        | 2        | 1     | Bicycle > Wheel
4       |     Tire       | 2        | 2     | Bicycle > Wheel > Tire
5       |     Rim        | 2        | 2     | Bicycle > Wheel > Rim
6       |       Spoke    | 72       | 3     | Bicycle > Wheel > Rim > Spoke
```

Notice that we need 72 spokes total: 2 wheels × 1 rim per wheel × 36 spokes per rim = 72 spokes.

## Preventing Infinite Loops

Recursive CTEs can create infinite loops if there are circular references in your data. Here are strategies to prevent this:

### 1. Limit Maximum Depth

```sql
WITH RECURSIVE limited_recursion AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS depth
    FROM
        category
    WHERE
        parent_category_id IS NULL
    
    UNION ALL
    
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        lr.depth + 1
    FROM
        category c
    INNER JOIN
        limited_recursion lr ON c.parent_category_id = lr.category_id
    WHERE
        lr.depth < 10  -- Maximum depth limit
)
SELECT * FROM limited_recursion;
```

### 2. Track Visited Nodes

```sql
WITH RECURSIVE safe_traversal AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        ARRAY[category_id] AS visited_ids
    FROM
        category
    WHERE
        parent_category_id IS NULL
    
    UNION ALL
    
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        st.visited_ids || c.category_id
    FROM
        category c
    INNER JOIN
        safe_traversal st ON c.parent_category_id = st.category_id
    WHERE
        NOT (c.category_id = ANY(st.visited_ids))  -- Prevent cycles
)
SELECT * FROM safe_traversal;
```

## Performance Considerations

### 1. Index Parent-Child Columns

Always index the columns used in recursive joins:

```sql
CREATE INDEX idx_employee_manager ON employee(manager_id);
CREATE INDEX idx_category_parent ON category(parent_category_id);
```

### 2. Limit Result Sets

Use WHERE clauses to limit the scope of recursion:

```sql
WITH RECURSIVE subordinates AS (
    SELECT employee_id, employee_name, manager_id, 0 AS level
    FROM employee
    WHERE employee_name = 'Bob Smith'
    
    UNION ALL
    
    SELECT e.employee_id, e.employee_name, e.manager_id, s.level + 1
    FROM employee e
    INNER JOIN subordinates s ON e.manager_id = s.employee_id
    WHERE s.level < 3  -- Only go 3 levels deep
)
SELECT * FROM subordinates;
```

### 3. Use Appropriate Join Types

- Use `INNER JOIN` when you only want matching rows
- Use `LEFT JOIN` when you want to include leaf nodes with no children

## Practical Use Case: Thread/Comment System

A common web application pattern is nested comments or forum threads:

```sql
CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    parent_comment_id INT,
    user_name VARCHAR(100),
    comment_text TEXT,
    created_at TIMESTAMP
);

WITH RECURSIVE comment_thread AS (
    -- Anchor: Top-level comments
    SELECT
        comment_id,
        parent_comment_id,
        user_name,
        comment_text,
        0 AS depth,
        CAST(comment_id AS VARCHAR(1000)) AS sort_path
    FROM
        comments
    WHERE
        parent_comment_id IS NULL
    
    UNION ALL
    
    -- Recursive: Nested replies
    SELECT
        c.comment_id,
        c.parent_comment_id,
        c.user_name,
        c.comment_text,
        ct.depth + 1,
        CONCAT(ct.sort_path, '-', LPAD(c.comment_id::TEXT, 10, '0'))
    FROM
        comments c
    INNER JOIN
        comment_thread ct ON c.parent_comment_id = ct.comment_id
)
SELECT
    REPEAT('  ', depth) || user_name AS indented_user,
    comment_text,
    depth
FROM
    comment_thread
ORDER BY
    sort_path;
```

## Key Takeaways

- **Recursive CTEs** enable traversing hierarchical data with parent-child relationships
- **WITH RECURSIVE** syntax includes an anchor member and a recursive member
- **Anchor member** defines the starting point (base case)
- **Recursive member** references the CTE itself and processes each iteration
- **Termination** occurs when the recursive member returns no rows
- **Common use cases**: Org charts, category trees, bill of materials, file systems
- **Level tracking**: Include a depth/level column to understand hierarchy position
- **Path building**: Concatenate paths to show full lineage
- **Infinite loop prevention**: Use depth limits or track visited nodes
- **Performance**: Index parent columns and limit recursion depth when possible
- **Versatile**: Works with any self-referencing table structure

Recursive CTEs are an essential tool for working with tree-structured and hierarchical data in SQL. They transform complex multi-query operations into elegant, single-query solutions.

In the next module, we'll explore Window Functions for advanced data analysis.
