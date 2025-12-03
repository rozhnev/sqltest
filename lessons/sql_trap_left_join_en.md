# The SQL Trap: When a LEFT JOIN Quietly Becomes an INNER JOIN

Here's a classic SQL pitfall that can catch even experienced developers off guard. Understanding this behavior is key to mastering SQL joins.

Let’s begin with a straightforward database schema.

### The Schema

We have two tables: `Customers` and `Orders`.

```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Amount INT,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
```

### The Data

Now, let's populate our tables with some sample data. Notice that 'Charlie' has not placed any orders.

```sql
INSERT INTO Customers (CustomerID, Name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO Orders (OrderID, CustomerID, Amount) VALUES
(10, 1, 100),
(11, 1, 200),
(12, 2, 160);
```

**[Try this example on SQL Playground](https://sqlize.online/sql/mariadb118/b7f05fd10a389202340f6623beb9f4e1/)**

### The Business Question

A common business request might be: "Show me all customers, along with their orders, but only include orders with an amount greater than 150."

A frequent, but flawed, attempt to answer this is:

```sql
SELECT
    c.CustomerID,
    c.Name,
    o.OrderID,
    o.Amount
FROM
    Customers c
LEFT JOIN
    Orders o ON c.CustomerID = o.CustomerID
WHERE
    o.Amount > 150;
```

### The Unexpected Result
```
| CustomerID | Name  | OrderID | Amount |
|------------|-------|---------|--------|
| 1          | Alice | 11      | 200    |
```
Wait, where is Charlie? And Bob? We used a `LEFT JOIN`, so we should see all customers!

### Why It Happens

The `WHERE` clause is applied *after* the `LEFT JOIN` operation. Here’s the breakdown of what happens:

1.  The `LEFT JOIN` correctly joins `Customers` and `Orders`. For 'Charlie', who has no orders, the columns from the `Orders` table (`OrderID`, `Amount`, etc.) are filled with `NULL`.
2.  The `WHERE o.Amount > 150` clause then filters these results.
    *   It filters out rows where the amount is not greater than 150 (like Alice's order of 100 and Bob's order of 160).
    *   Crucially, it also filters out rows where `o.Amount` is `NULL` (Charlie's row), because `NULL > 150` evaluates to unknown, which is not true.

This effectively transforms your `LEFT JOIN` into an `INNER JOIN`.

### The Correct Solution

To get the desired result, the filter on the right table (`Orders`) must be moved into the `ON` clause of the join.

```sql
SELECT
    c.CustomerID,
    c.Name,
    o.OrderID,
    o.Amount
FROM
    Customers c
LEFT JOIN
    Orders o ON c.CustomerID = o.CustomerID AND o.Amount > 150;
```

### The Correct Result
```
| CustomerID | Name    | OrderID | Amount |
|------------|---------|---------|--------|
| 1          | Alice   | 11      | 200    |
| 2          | Bob     | NULL    | NULL   |
| 3          | Charlie | NULL    | NULL   |
```
Now, all customers are included in the result, which is what we intended with the `LEFT JOIN`.

### Why This Works

When you place the condition in the `ON` clause, you are telling the database to filter the `Orders` table *before* it performs the join. The logic becomes: "Join `Customers` with the subset of `Orders` where the amount is greater than 150." If a customer has no matching orders in that subset, their row is still included in the final result with `NULL`s for the `Orders` columns.

### Key Takeaway

This subtle difference in query structure can lead to bugs that are difficult to spot. If you ever find your `LEFT JOIN` "losing" rows, check your `WHERE` clause. It's likely the culprit!

---
*Credit: [Mohamad Taghlobi, Ph.D.](https://www.linkedin.com/in/mohamad-taghlobi-ph-d-874496214/)*

