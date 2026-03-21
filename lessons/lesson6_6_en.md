---
title: "Recursive CTE Applications in SQL: Hierarchical Data, BOM, Organization Charts"
description: "Learn recursive CTEs in SQL for solving practical problems. Work with hierarchies, category structures, organizational graphs, menu systems, and path finding. Complete guide with examples."
keywords: "recursive CTE, SQL hierarchy, category tree, BOM, organization chart, path finding, menu structure, recursive query SQL, WITH RECURSIVE"
lang: "en"
region: "US, GB, AU, NZ"
---

# Lesson 6.6: Applying Recursive CTEs to Real-World Problems

In the previous lesson, we explored regular (non-recursive) CTEs—a tool for organizing and structuring SQL queries. Now we move to their most powerful variant: **recursive CTEs**.

Recursive CTEs enable you to work with hierarchical, tree-like, and network data structures. They solve many real-world problems that traditionally required procedural code or complex stored procedures.

<img src="/images/lessons/lesson6_6_recursive-cte.jpg" alt="Recursive CTE" width="100%">

## What is a Recursive CTE?

A **recursive CTE** is a CTE that references itself, allowing you to traverse hierarchical structures level by level.

The structure of a recursive CTE:

```sql
WITH RECURSIVE cte_name AS (
    -- ANCHOR MEMBER (base case)
    SELECT ... 
    WHERE anchor_condition
    
    UNION ALL
    
    -- RECURSIVE MEMBER (how to move to next level)
    SELECT ...
    FROM cte_name
    WHERE stop_condition
)
SELECT * FROM cte_name;
```

**Key components:**
1. **Anchor member** — the starting point of recursion (usually root records)
2. **UNION ALL** — combines results from anchor and recursion
3. **Recursive member** — how to transition from one level to another
4. **Stop condition** — when to terminate recursion

## Example 1: Category Hierarchy

One of the most common applications is working with product category hierarchies in e-commerce.

**Table structure:**
```sql
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    parent_id INT,
    name VARCHAR(100),
    FOREIGN KEY (parent_id) REFERENCES categories(category_id)
);

INSERT INTO categories VALUES
(1, NULL, 'Electronics'),
(2, 1, 'Computers'),
(3, 1, 'Mobile Phones'),
(4, 2, 'Laptops'),
(5, 2, 'Desktop PCs'),
(6, 4, 'Dell Laptops'),
(7, 4, 'HP Laptops'),
(8, 3, 'Smartphones'),
(9, 3, 'Tablets');
```

**Task: Get the full category hierarchy from root to leaves**

```sql
WITH RECURSIVE category_hierarchy AS (
    -- Anchor member: start with root categories
    SELECT
        category_id,
        parent_id,
        name,
        1 AS level,
        name AS full_path
    FROM
        categories
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    -- Recursive member: add child categories
    SELECT
        c.category_id,
        c.parent_id,
        c.name,
        ch.level + 1,
        CONCAT(ch.full_path, ' → ', c.name)
    FROM
        categories c
    JOIN
        category_hierarchy ch ON c.parent_id = ch.category_id
)
SELECT
    category_id,
    REPEAT('  ', level - 1) AS indent,
    name,
    level,
    full_path
FROM
    category_hierarchy
ORDER BY
    level,
    category_id;
```

**Result:**
```
category_id | indent | name              | level | full_path
1           |        | Electronics       | 1     | Electronics
2           |   | Computers          | 2     | Electronics → Computers
4           |       | Laptops           | 3     | Electronics → Computers → Laptops
6           |           | Dell Laptops      | 4     | Electronics → Computers → Laptops → Dell Laptops
7           |           | HP Laptops        | 4     | Electronics → Computers → Laptops → HP Laptops
5           |       | Desktop PCs       | 3     | Electronics → Computers → Desktop PCs
3           |   | Mobile Phones     | 2     | Electronics → Mobile Phones
8           |       | Smartphones       | 3     | Electronics → Mobile Phones → Smartphones
9           |       | Tablets           | 3     | Electronics → Mobile Phones → Tablets
```

**What happens:**
- The anchor member finds only `Electronics` (parent_id IS NULL)
- The recursive member finds `Computers` and `Mobile Phones` (children of Electronics)
- The process repeats until all leaves are found

## Example 2: Organization Chart

Often you need to display company structure with a management chain.

**Table structure:**
```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

INSERT INTO employees VALUES
(1, 'John Smith', 'Chief Executive Officer', NULL, 150000),
(2, 'Anna Johnson', 'Sales Director', 1, 100000),
(3, 'Peter Williams', 'IT Director', 1, 120000),
(4, 'Maria Brown', 'Sales Manager', 2, 60000),
(5, 'Alex Davis', 'Sales Manager', 2, 60000),
(6, 'Sergei Miller', 'Senior Developer', 3, 90000),
(7, 'Olga Wilson', 'Developer', 6, 70000),
(8, 'Dmitry Moore', 'Developer', 6, 70000);
```

**Task: Display organization structure with management chain**

```sql
WITH RECURSIVE org_chart AS (
    -- Anchor: Chief Executive Officer
    SELECT
        employee_id,
        name,
        position,
        manager_id,
        salary,
        1 AS level,
        name AS management_chain
    FROM
        employees
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    -- Recursion: add subordinates
    SELECT
        e.employee_id,
        e.name,
        e.position,
        e.manager_id,
        e.salary,
        oc.level + 1,
        CONCAT(oc.management_chain, ' → ', e.name)
    FROM
        employees e
    JOIN
        org_chart oc ON e.manager_id = oc.employee_id
    WHERE
        oc.level < 10  -- Protection against infinite recursion
)
SELECT
    employee_id,
    REPEAT('│ ', level - 1) AS hierarchy,
    name,
    position,
    salary,
    management_chain
FROM
    org_chart
ORDER BY
    level,
    employee_id;
```

**Result:**
```
employee_id | hierarchy | name         | position            | salary | management_chain
1           |          | John Smith   | Chief Executive Officer | 150000 | John Smith
2           | │        | Anna Johnson | Sales Director      | 100000 | John Smith → Anna Johnson
4           | │ │      | Maria Brown  | Sales Manager       | 60000  | John Smith → Anna Johnson → Maria Brown
5           | │ │      | Alex Davis   | Sales Manager       | 60000  | John Smith → Anna Johnson → Alex Davis
3           | │        | Peter Williams| IT Director         | 120000 | John Smith → Peter Williams
6           | │ │      | Sergei Miller| Senior Developer    | 90000  | John Smith → Peter Williams → Sergei Miller
7           | │ │ │    | Olga Wilson  | Developer           | 70000  | John Smith → Peter Williams → Sergei Miller → Olga Wilson
8           | │ │ │    | Dmitry Moore | Developer           | 70000  | John Smith → Peter Williams → Sergei Miller → Dmitry Moore
```

**Application: Calculate department budget**

```sql
WITH RECURSIVE org_chart AS (
    SELECT
        employee_id,
        name,
        position,
        salary,
        1 AS level
    FROM
        employees
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    SELECT
        e.employee_id,
        e.name,
        e.position,
        e.salary,
        oc.level + 1
    FROM
        employees e
    JOIN
        org_chart oc ON e.manager_id = oc.employee_id
)
SELECT
    name AS position,
    COUNT(*) AS number_of_employees,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS average_salary
FROM
    org_chart
GROUP BY
    employee_id,
    name
ORDER BY
    SUM(salary) DESC;
```

## Example 3: Bill of Materials (BOM)

In manufacturing, you need to know what components make up a product.

**Table structure:**
```sql
CREATE TABLE bom (
    product_id INT,
    component_id INT,
    quantity INT,
    PRIMARY KEY (product_id, component_id)
);

INSERT INTO bom VALUES
(1, 2, 1),      -- Laptop consists of 1 motherboard
(1, 3, 2),      -- and 2 RAM sticks
(1, 4, 1),      -- and 1 hard drive
(2, 5, 1),      -- Motherboard consists of 1 chipset
(2, 6, 20),     -- and 20 resistors
(4, 7, 1);      -- Hard drive consists of 1 spindle
```

**Task: Expand BOM to full component list**

```sql
WITH RECURSIVE bom_expanded AS (
    -- Anchor: finished goods (not used as components)
    SELECT
        product_id,
        product_id AS component_id,
        1 AS quantity,
        0 AS level,
        CAST(product_id AS CHAR(100)) AS path
    FROM
        (SELECT DISTINCT product_id FROM bom
         UNION
         SELECT DISTINCT component_id FROM bom) AS products
    
    UNION ALL
    
    -- Recursion: expand each component
    SELECT
        be.product_id,
        b.component_id,
        be.quantity * b.quantity,
        be.level + 1,
        CONCAT(be.path, ' → ', b.component_id)
    FROM
        bom_expanded be
    JOIN
        bom b ON be.component_id = b.product_id
    WHERE
        be.level < 10
)
SELECT
    product_id,
    component_id,
    quantity,
    level,
    path
FROM
    bom_expanded
WHERE
    level > 0
ORDER BY
    product_id,
    level,
    component_id;
```

## Example 4: Menu Structure (Menu Trees)

E-commerce sites and web applications often have multi-level menus.

**Table structure:**
```sql
CREATE TABLE menu (
    menu_id INT PRIMARY KEY,
    parent_menu_id INT,
    title VARCHAR(100),
    url VARCHAR(255),
    sort_order INT,
    FOREIGN KEY (parent_menu_id) REFERENCES menu(menu_id)
);

INSERT INTO menu VALUES
(1, NULL, 'Home', '/', 1),
(2, NULL, 'Catalog', '/catalog', 2),
(3, NULL, 'About Us', '/about', 3),
(4, 2, 'Computers', '/catalog/computers', 1),
(5, 2, 'Accessories', '/catalog/accessories', 2),
(6, 4, 'Laptops', '/catalog/computers/laptops', 1),
(7, 4, 'Desktop PCs', '/catalog/computers/desktops', 2),
(8, 5, 'Mice', '/catalog/accessories/mice', 1),
(9, 5, 'Keyboards', '/catalog/accessories/keyboards', 2),
(10, 3, 'History', '/about/history', 1),
(11, 3, 'Team', '/about/team', 2);
```

**Task: Display menu as a tree with indentation**

```sql
WITH RECURSIVE menu_tree AS (
    -- Anchor: main menu items
    SELECT
        menu_id,
        parent_menu_id,
        title,
        url,
        1 AS level,
        title AS breadcrumb
    FROM
        menu
    WHERE
        parent_menu_id IS NULL
    ORDER BY
        sort_order
    
    UNION ALL
    
    -- Recursion: submenus
    SELECT
        m.menu_id,
        m.parent_menu_id,
        m.title,
        m.url,
        mt.level + 1,
        CONCAT(mt.breadcrumb, ' > ', m.title)
    FROM
        menu m
    JOIN
        menu_tree mt ON m.parent_menu_id = mt.menu_id
)
SELECT
    menu_id,
    REPEAT('  ', level - 1) AS indent,
    title,
    url,
    breadcrumb
FROM
    menu_tree
ORDER BY
    level,
    menu_id;
```

**Result:**
```
menu_id | indent | title            | url                      | breadcrumb
1       |        | Home             | /                        | Home
2       |        | Catalog          | /catalog                 | Catalog
4       |   | Computers       | /catalog/computers       | Catalog > Computers
6       |       | Laptops         | /catalog/computers/laptops | Catalog > Computers > Laptops
7       |       | Desktop PCs     | /catalog/computers/desktops | Catalog > Computers > Desktop PCs
5       |   | Accessories     | /catalog/accessories     | Catalog > Accessories
8       |       | Mice            | /catalog/accessories/mice | Catalog > Accessories > Mice
9       |       | Keyboards       | /catalog/accessories/keyboards | Catalog > Accessories > Keyboards
3       |        | About Us         | /about                   | About Us
10      |   | History         | /about/history           | About Us > History
11      |   | Team            | /about/team              | About Us > Team
```

## Example 5: Path Finding in Graphs

Recursive CTEs are used to find all paths between two nodes in a graph (e.g., delivery routes in a logistics system).

**Table structure:**
```sql
CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE routes (
    from_city_id INT,
    to_city_id INT,
    distance INT,
    PRIMARY KEY (from_city_id, to_city_id),
    FOREIGN KEY (from_city_id) REFERENCES cities(city_id),
    FOREIGN KEY (to_city_id) REFERENCES cities(city_id)
);

INSERT INTO cities VALUES (1, 'Moscow'), (2, 'Tver'), (3, 'Smolensk'), (4, 'Bryansk');

INSERT INTO routes VALUES
(1, 2, 170),   -- Moscow → Tver
(2, 3, 220),   -- Tver → Smolensk
(1, 4, 380),   -- Moscow → Bryansk
(4, 3, 250);   -- Bryansk → Smolensk
```

**Task: Find all routes from Moscow to Smolensk**

```sql
WITH RECURSIVE routes_search AS (
    -- Anchor: start from Moscow (city_id = 1)
    SELECT
        from_city_id,
        to_city_id,
        distance,
        1 AS hops,
        CAST(to_city_id AS CHAR(1000)) AS path,
        distance AS total_distance
    FROM
        routes
    WHERE
        from_city_id = 1
    
    UNION ALL
    
    -- Recursion: continue from each destination
    SELECT
        rs.from_city_id,
        r.to_city_id,
        r.distance,
        rs.hops + 1,
        CONCAT(rs.path, ',', r.to_city_id),
        rs.total_distance + r.distance
    FROM
        routes_search rs
    JOIN
        routes r ON rs.to_city_id = r.from_city_id
    WHERE
        rs.hops < 10  -- Prevent cycles
        AND rs.path NOT LIKE CONCAT('%,', r.to_city_id, '%')  -- Avoid loops
)
SELECT
    from_city_id,
    to_city_id,
    hops,
    path,
    total_distance,
    ROUND(total_distance / hops, 2) AS average_distance_between_cities
FROM
    routes_search
WHERE
    to_city_id = 3  -- Destination: Smolensk
ORDER BY
    hops,
    total_distance;
```

## Best Practices and Optimization

### 1. Always Define a Stop Condition

Recursion without a stop condition will lead to infinite loops:

```sql
-- ❌ BAD: May lead to infinite recursion
WITH RECURSIVE bad_recursion AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM bad_recursion
)
SELECT * FROM bad_recursion;

-- ✅ GOOD: Stop condition included
WITH RECURSIVE good_recursion AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM good_recursion
    WHERE n < 1000
)
SELECT * FROM good_recursion;
```

### 2. Use UNION ALL Instead of UNION

`UNION ALL` doesn't remove duplicates and runs faster:

```sql
-- ❌ Slower
WITH RECURSIVE cte AS (
    SELECT ...
    UNION  -- Removes duplicates
    SELECT ...
)

-- ✅ Faster
WITH RECURSIVE cte AS (
    SELECT ...
    UNION ALL  -- Doesn't remove duplicates
    SELECT ...
)
```

### 3. Avoid Circular References

Use path checking to prevent cycles:

```sql
WITH RECURSIVE safe_recursion AS (
    SELECT
        id,
        parent_id,
        CAST(id AS CHAR(1000)) AS path
    FROM
        table_name
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        CONCAT(sr.path, ',', t.id)
    FROM
        table_name t
    JOIN
        safe_recursion sr ON t.parent_id = sr.id
    WHERE
        sr.path NOT LIKE CONCAT('%,', t.id, '%')  -- Cycle check
        AND sr.path NOT LIKE CONCAT(t.id, ',%')
)
SELECT * FROM safe_recursion;
```

### 4. Limit Recursion Depth

Explicitly limit maximum recursion depth:

```sql
WITH RECURSIVE limited_recursion AS (
    SELECT
        id,
        parent_id,
        0 AS level
    FROM table_name
    WHERE parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        lr.level + 1
    FROM
        table_name t
    JOIN
        limited_recursion lr ON t.parent_id = lr.id
    WHERE
        lr.level < 20  -- Maximum 20 levels
)
SELECT * FROM limited_recursion;
```

## Application Matrix for Recursive CTEs

| Task | Example | Complexity |
|------|---------|-----------|
| Category hierarchy | Product categories in a store | Low |
| Organization chart | Company structure, reporting chain | Low |
| BOM (Bill of Materials) | Composition of manufactured products | Medium |
| Menu structure | Website navigation trees | Low |
| Path finding | Delivery routes, relationship graphs | High |
| Comment trees | Nested comments in social media | Medium |
| Dependency graphs | Projects and subtasks | Medium |
| Traceability | Material origin tracking | Medium |

## Key Takeaways

- **Recursive CTEs** are powerful tools for working with hierarchical data
- **Structure**: anchor member + recursive member + stop condition
- **Anchor member** defines starting rows
- **Recursive member** adds new rows based on previous ones
- **Stop condition** prevents infinite loops
- **Practical applications**: categories, organization structures, BOMs, menus, path finding
- **Performance**: The simpler the structure, the faster the execution
- **Alternatives**: Procedural code can be used, but recursive CTEs are often simpler and clearer

Recursive CTEs transform complex hierarchical queries from puzzles into understandable SQL. They are an indispensable tool for anyone working with tree and network data structures.

In subsequent lessons, we'll explore advanced optimization techniques and specialized SQL functions.
