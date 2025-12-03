# Когда LEFT JOIN незаметно превращается в INNER JOIN

Вот классическая ловушка SQL, которая может застать врасплох даже опытных разработчиков. Понимание этого поведения является ключом к освоению объединений (JOIN) в SQL.

Начнем с простой схемы базы данных.

### Схема

У нас есть две таблицы: `Customers` (Клиенты) и `Orders` (Заказы).

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

### Данные

Теперь заполним наши таблицы примерами данных. Обратите внимание, что 'Charlie' не делал никаких заказов.

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

**[Попробовать этот пример в SQL Playground](https://sqlize.online/sql/mariadb118/b7f05fd10a389202340f6623beb9f4e1/)**

### Бизнес-задача

Распространенный запрос от бизнеса может звучать так: "Покажите мне всех клиентов вместе с их заказами, но включите только те заказы, сумма которых превышает 150".

Частая, но ошибочная попытка ответить на этот вопрос:

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

### Неожиданный результат
```
| CustomerID | Name  | OrderID | Amount |
|------------|-------|---------|--------|
| 1          | Alice | 11      | 200    |
```
Подождите, а где Charlie? И Bob? Мы использовали `LEFT JOIN`, поэтому должны видеть всех клиентов!

### Почему это происходит

Условие `WHERE` применяется *после* операции `LEFT JOIN`. Вот что происходит пошагово:

1.  `LEFT JOIN` корректно объединяет `Customers` и `Orders`. Для 'Charlie', у которого нет заказов, столбцы из таблицы `Orders` (`OrderID`, `Amount` и т.д.) заполняются значениями `NULL`.
2.  Затем условие `WHERE o.Amount > 150` фильтрует эти результаты.
    *   Оно отфильтровывает строки, где сумма не превышает 150 (как заказ Alice на 100 и заказ Bob на 160).
    *   Что особенно важно, оно также отфильтровывает строки, где `o.Amount` равно `NULL` (строка Charlie), потому что выражение `NULL > 150` вычисляется как неизвестное (unknown), что не является истиной.

Это фактически превращает ваш `LEFT JOIN` в `INNER JOIN`.

### Правильное решение

Чтобы получить желаемый результат, фильтр по правой таблице (`Orders`) должен быть перемещен в условие `ON` объединения.

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

### Правильный результат
```
| CustomerID | Name    | OrderID | Amount |
|------------|---------|---------|--------|
| 1          | Alice   | 11      | 200    |
| 2          | Bob     | NULL    | NULL   |
| 3          | Charlie | NULL    | NULL   |
```
Теперь все клиенты включены в результат, что и предполагалось при использовании `LEFT JOIN`.

### Почему это работает

Когда вы помещаете условие в `ON`, вы говорите базе данных отфильтровать таблицу `Orders` *до* выполнения объединения. Логика становится такой: "Объединить `Customers` с подмножеством `Orders`, где сумма больше 150". Если у клиента нет соответствующих заказов в этом подмножестве, его строка все равно включается в окончательный результат с `NULL` в столбцах `Orders`.

### Главный вывод

Это тонкое различие в структуре запроса может привести к ошибкам, которые трудно обнаружить. Если вы когда-нибудь обнаружите, что ваш `LEFT JOIN` "теряет" строки, проверьте условие `WHERE`. Скорее всего, причина именно в нем!

---
*Авторство: [Mohamad Taghlobi, Ph.D.](https://www.linkedin.com/in/mohamad-taghlobi-ph-d-874496214/)*
