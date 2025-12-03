# Quando um LEFT JOIN se Torna Silenciosamente um INNER JOIN

Aqui está uma armadilha clássica do SQL que pode pegar desprevenidos até mesmo desenvolvedores experientes. Entender esse comportamento é fundamental para dominar as junções (JOINs) em SQL.

Vamos começar com um esquema de banco de dados simples.

### O Esquema

Temos duas tabelas: `Customers` (Clientes) e `Orders` (Pedidos).

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

### Os Dados

Agora, vamos preencher nossas tabelas com alguns dados de exemplo. Observe que 'Charlie' não fez nenhum pedido.

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

**[Experimente este exemplo no SQL Playground](https://sqlize.online/sql/mariadb118/b7f05fd10a389202340f6623beb9f4e1/)**

### A Pergunta de Negócio

Uma solicitação comum de negócio pode ser: "Mostre-me todos os clientes, juntamente com seus pedidos, mas inclua apenas pedidos com um valor maior que 150."

Uma tentativa frequente, mas falha, de responder a isso é:

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

### O Resultado Inesperado
```
| CustomerID | Name  | OrderID | Amount |
|------------|-------|---------|--------|
| 1          | Alice | 11      | 200    |
```
Espere, onde está o Charlie? E o Bob? Usamos um `LEFT JOIN`, então deveríamos ver todos os clientes!

### Por Que Isso Acontece

A cláusula `WHERE` é aplicada *após* a operação de `LEFT JOIN`. Aqui está o detalhamento do que acontece:

1.  O `LEFT JOIN` une corretamente `Customers` e `Orders`. Para 'Charlie', que não tem pedidos, as colunas da tabela `Orders` (`OrderID`, `Amount`, etc.) são preenchidas com `NULL`.
2.  A cláusula `WHERE o.Amount > 150` então filtra esses resultados.
    *   Ela filtra as linhas onde o valor não é maior que 150 (como o pedido de 100 da Alice e o pedido de 160 do Bob).
    *   Crucialmente, ela também filtra as linhas onde `o.Amount` é `NULL` (a linha do Charlie), porque `NULL > 150` é avaliado como desconhecido (unknown), o que não é verdadeiro.

Isso efetivamente transforma seu `LEFT JOIN` em um `INNER JOIN`.

### A Solução Correta

Para obter o resultado desejado, o filtro na tabela da direita (`Orders`) deve ser movido para a cláusula `ON` da junção.

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

### O Resultado Correto
```
| CustomerID | Name    | OrderID | Amount |
|------------|---------|---------|--------|
| 1          | Alice   | 11      | 200    |
| 2          | Bob     | NULL    | NULL   |
| 3          | Charlie | NULL    | NULL   |
```
Agora, todos os clientes estão incluídos no resultado, que é o que pretendíamos com o `LEFT JOIN`.

### Por Que Isso Funciona

Quando você coloca a condição na cláusula `ON`, você está dizendo ao banco de dados para filtrar a tabela `Orders` *antes* de realizar a junção. A lógica se torna: "Junte `Customers` com o subconjunto de `Orders` onde o valor é maior que 150." Se um cliente não tiver pedidos correspondentes nesse subconjunto, sua linha ainda será incluída no resultado final com `NULL`s para as colunas de `Orders`.

### Principal Conclusão

Essa diferença sutil na estrutura da consulta pode levar a bugs difíceis de detectar. Se você encontrar seu `LEFT JOIN` "perdendo" linhas, verifique sua cláusula `WHERE`. É provável que ela seja a culpada!

---
*Crédito: [Mohamad Taghlobi, Ph.D.](https://www.linkedin.com/in/mohamad-taghlobi-ph-d-874496214/)*
