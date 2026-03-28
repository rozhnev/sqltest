# Aula 4.5: Agregação avançada com `ROLLUP`, `CUBE` e `GROUPING SETS` em SQL

À medida que as necessidades de relatório crescem, o `GROUP BY` tradicional muitas vezes não é suficiente. Por exemplo, você pode precisar obter ao mesmo tempo:

- detalhamento por status do pedido e cliente;
- subtotais por status;
- totais por cliente;
- total geral de todo o conjunto de dados.

É possível escrever várias consultas e combiná-las com `UNION ALL`, mas isso fica mais verboso e difícil de manter. Para esses casos, o SQL usa modificadores da expressão de agrupamento: `ROLLUP`, `CUBE` e `GROUPING SETS`.

De forma mais precisa: esses modificadores enriquecem o resultado agregado com linhas de nível mais alto de agregação (subtotais e total geral).

Importante: nesta aula, todos os exemplos práticos usam **SQL Server (AdventureWorks)**.

Observação de sintaxe: `ROLLUP`, `CUBE`, `GROUPING SETS` e `GROUPING()` abaixo estão no formato do SQL Server. No MySQL, a funcionalidade é mais limitada e a sintaxe é parcialmente diferente (por exemplo, é comum usar `WITH ROLLUP`, enquanto `CUBE` e `GROUPING SETS` podem não estar disponíveis na forma clássica).

Nesta aula, vamos ver:

- como `ROLLUP`, `CUBE` e `GROUPING SETS` se diferenciam;
- como linhas de subtotal e total são geradas;
- como distinguir linhas de total com `GROUPING()`.

## Por que isso importa

A agregação avançada ajuda a:

- construir relatórios multinível em uma única consulta;
- reduzir duplicação de SQL;
- obter resultados consistentes entre detalhe, subtotais e total geral.
- enriquecer o resultado detalhado com linhas em níveis mais altos de agregação.

## Ideia básica

Considere dados de vendas na tabela `SalesOrderHeader`, com dimensões `Status`, `CustomerID` e métrica `TotalDue`.

O `GROUP BY` comum retorna apenas um nível de agrupamento. As extensões retornam vários níveis de uma só vez.

## `ROLLUP`: totais hierárquicos

`ROLLUP` constrói uma hierarquia da direita para a esquerda na lista de colunas.

### Sintaxe

```sql
GROUP BY ROLLUP (col1, col2, col3)
```

Níveis gerados:

- `(col1, col2, col3)` - detalhe;
- `(col1, col2)` - subtotal de `col3`;
- `(col1)` - subtotal de `col2` e `col3`;
- `()` - total geral.

### Exemplo: soma dos pedidos por status e cliente

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount
FROM SalesOrderHeader
GROUP BY ROLLUP (Status, CustomerID)
ORDER BY Status, CustomerID;
```

**Resultado:**

- linhas para cada par `Status + CustomerID`;
- subtotal por `Status`;
- total geral.

## `CUBE`: todas as combinações de dimensões

`CUBE` calcula agregações para todas as combinações possíveis das colunas listadas.

### Sintaxe

```sql
GROUP BY CUBE (col1, col2)
```

Para duas colunas, os níveis são:

- `(col1, col2)`;
- `(col1)`;
- `(col2)`;
- `()`.

Para três colunas, já existem $2^3 = 8$ combinações, então o resultado pode crescer rapidamente.

### Exemplo: soma dos pedidos por status e cliente em todos os recortes

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount
FROM SalesOrderHeader
GROUP BY CUBE (Status, CustomerID)
ORDER BY Status, CustomerID;
```

**Resultado:** além do detalhamento e do total geral, você também obtém:

- totais por `Status`;
- totais por `CustomerID`.

## `GROUPING SETS`: controle preciso dos níveis

`GROUPING SETS` permite declarar explicitamente apenas os níveis de agrupamento necessários.

### Sintaxe

```sql
GROUP BY GROUPING SETS (
    (col1, col2),
    (col1),
    ()
)
```

### Exemplo: somente os níveis necessários, sem combinações extras

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount
FROM SalesOrderHeader
GROUP BY GROUPING SETS (
    (Status, CustomerID),
    (Status),
    ()
)
ORDER BY Status, CustomerID;
```

Isso é equivalente a várias consultas `GROUP BY ... UNION ALL ...`, mas de forma mais compacta e, em geral, melhor otimizada.

## Como distinguir linhas de total com `GROUPING()`

Nas linhas de total geradas, os valores das dimensões costumam virar `NULL`. O problema é que os dados originais também podem conter `NULL` reais.

`GROUPING(column)` ajuda a diferenciar:

- `0` - valor normal vindo dos dados;
- `1` - valor gerado pelo nível de agregação.

### Exemplo com marcadores de nível

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount,
    GROUPING(Status) AS g_status,
    GROUPING(CustomerID) AS g_customer
FROM SalesOrderHeader
GROUP BY ROLLUP (Status, CustomerID)
ORDER BY Status, CustomerID;
```

Padrão prático para rotular linhas em relatórios:

```sql
CASE
    WHEN GROUPING(Status) = 1 AND GROUPING(CustomerID) = 1 THEN 'GRAND TOTAL'
    WHEN GROUPING(CustomerID) = 1 THEN 'STATUS SUBTOTAL'
    ELSE 'DETAIL'
END AS row_type
```

## Quando usar cada um

- Use `ROLLUP` quando precisar de totais hierárquicos (por exemplo, ano -> mês -> dia).
- Use `CUBE` quando precisar de todos os recortes analíticos entre dimensões.
- Use `GROUPING SETS` quando quiser controle exato sobre quais níveis retornar.

## Recomendações práticas

- Sempre confira o tamanho do resultado: `CUBE` pode aumentar bastante o número de linhas.
- Rotule os tipos de linha (`DETAIL`, `SUBTOTAL`, `GRAND TOTAL`) para facilitar a leitura.
- Adicione `ORDER BY` explícito para que os totais apareçam em ordem previsível.
- Se precisar filtrar agregações, combine com `HAVING`.

## Exemplo para MySQL

Abaixo, um exemplo para MySQL na tabela `payment`, com subtotais usando `WITH ROLLUP`:

```sql
SELECT
    staff_id,
    customer_id,
    SUM(amount) AS total_amount
FROM
    payment
GROUP BY
    staff_id, customer_id WITH ROLLUP
ORDER BY
    GROUPING(staff_id),
    staff_id,
    GROUPING(customer_id),
    customer_id;
```

Nesta consulta:

- o detalhamento é retornado por par `staff_id + customer_id`;
- `WITH ROLLUP` adiciona subtotais por `staff_id` e um total geral;
- `ORDER BY GROUPING(...)` organiza as linhas em ordem prática: detalhes, subtotais e, por fim, total geral.

Pontos importantes no MySQL:

- `WITH ROLLUP` fornece totais hierárquicos, mas não é equivalente completo a `CUBE`/`GROUPING SETS`.
- Para combinações de agrupamento mais complexas, normalmente é preciso usar várias consultas com `UNION ALL`.
- Se sua versão do MySQL não suportar `GROUPING()`, a ordenação e a rotulagem dos totais normalmente são feitas com checagens de `NULL`.

## Aplicações práticas

1. **Relatório de soma dos pedidos por status e cliente com totais:**
   `ROLLUP (Status, CustomerID)` entrega detalhamento, subtotais por status e total geral.

2. **Análise multidimensional de vendas:**
   `CUBE (Status, CustomerID)` entrega todas as combinações de recortes entre status e cliente.

3. **Relatório personalizado de soma de pedidos:**
   `GROUPING SETS` permite manter apenas os níveis necessários: detalhe + subtotal do departamento + total geral.

## Principais conclusões desta aula

- `ROLLUP`, `CUBE` e `GROUPING SETS` estendem o `GROUP BY` tradicional.
- `ROLLUP` cria totais hierárquicos, `CUBE` cria todas as combinações, `GROUPING SETS` cria apenas os níveis explicitamente definidos.
- `GROUPING()` é essencial para interpretar corretamente linhas de total geradas.
- Essas ferramentas permitem criar relatórios analíticos flexíveis sobre soma de pedidos em uma única consulta.

Ao dominar essas construções, você poderá criar relatórios SQL mais poderosos sem longas cadeias de `UNION ALL`.
