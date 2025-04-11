# Lição 3.1: Usando Funções em Consultas SQL

As funções SQL são rotinas pré-definidas que executam operações específicas nos dados. Elas permitem manipular dados, realizar cálculos e formatar resultados diretamente em suas consultas SQL. As funções podem ser usadas em várias partes de uma consulta, como na cláusula `SELECT` para transformar a saída ou na cláusula `WHERE` para filtrar dados com base em valores calculados.

## O que são Funções SQL?

As funções SQL são semelhantes às funções em outras linguagens de programação. Elas aceitam valores de entrada (argumentos), executam uma operação específica e retornam um resultado. As funções podem ser integradas (fornecidas pelo sistema de banco de dados) ou definidas pelo usuário (criadas pelos usuários). Esta lição foca nas funções integradas.

## Sintaxe Comum

A sintaxe geral para usar uma função em SQL é:

```sql
FUNCTION_NAME(argument1, argument2, ...);
```

- **`FUNCTION_NAME`**: O nome da função que você deseja usar.
- **`argument1, argument2, ...`**: Os valores de entrada (argumentos) que a função requer. Estes podem ser nomes de colunas, valores literais ou até mesmo outras funções.

---

## Usando Funções na Cláusula SELECT

As funções na cláusula `SELECT` permitem transformar ou calcular valores para a saída.

### Exemplo 1: Função de String (`UPPER`)
A função `UPPER()` converte uma string para letras maiúsculas.

```sql
SELECT UPPER(first_name) AS uppercase_name
FROM employees;
```

Esta consulta recupera a coluna `first_name` da tabela `employees` e converte cada nome para letras maiúsculas, atribuindo o resultado ao alias `uppercase_name`.

---

### Exemplo 2: Função Matemática (`ROUND`)
A função `ROUND()` arredonda um número para um número especificado de casas decimais.

```sql
SELECT ROUND(salary, 0) AS rounded_salary
FROM employees;
```

Esta consulta recupera a coluna `salary` da tabela `employees` e arredonda cada salário para o número inteiro mais próximo, atribuindo o resultado ao alias `rounded_salary`.

---

### Exemplo 3: Função de Data (`NOW`)
A função `NOW()` não aceita argumentos e retorna a data e hora atuais.

```sql
SELECT NOW() AS current_datetime;
```

Esta consulta retorna a data e hora atuais.

---

## Usando Funções na Cláusula WHERE

As funções na cláusula `WHERE` permitem filtrar dados com base em valores calculados ou transformados.

### Exemplo 1: Função de String (`LENGTH`)
A função `LENGTH()` retorna o comprimento de uma string.

```sql
SELECT *
FROM products
WHERE LENGTH(product_name) > 20;
```

Esta consulta recupera todas as colunas da tabela `products` onde o comprimento de `product_name` é maior que 20 caracteres.

---

### Exemplo 2: Função de Data (`YEAR`)
A função `YEAR()` extrai o ano de uma data.

```sql
SELECT *
FROM orders
WHERE YEAR(order_date) = 2023;
```

Esta consulta recupera todas as colunas da tabela `orders` onde o ano de `order_date` é 2023.

---

### Exemplo 3: Função Matemática (`ABS`)
A função `ABS()` retorna o valor absoluto de um número.

```sql
SELECT *
FROM transactions
WHERE ABS(amount) > 100;
```

Esta consulta recupera todas as colunas da tabela `transactions` onde o valor absoluto de `amount` é maior que 100.

---

## Tipos Comuns de Funções SQL

As funções SQL podem ser amplamente categorizadas nos seguintes tipos:

1. **Funções de String**: Usadas para manipular strings (por exemplo, `UPPER`, `LOWER`, `SUBSTRING`, `LENGTH`, `TRIM`).
2. **Funções Matemáticas**: Usadas para realizar cálculos matemáticos (por exemplo, `ROUND`, `ABS`, `SQRT`, `MOD`).
3. **Funções de Data e Hora**: Usadas para trabalhar com datas e horas (por exemplo, `NOW`, `YEAR`, `MONTH`, `DAY`, `DATE_ADD`, `DATE_SUB`).
4. **Funções Agregadas**: Usadas para resumir dados (por exemplo, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`). (Abordadas em uma lição posterior)
5. **Funções de Conversão**: Usadas para converter dados de um tipo para outro (por exemplo, `CAST`, `CONVERT`).

---

## Melhores Práticas

1. **Entenda o Comportamento das Funções**: Esteja ciente do comportamento específico e das limitações de cada função que você usa.
2. **Use Aliases**: Use aliases (`AS`) para dar nomes significativos às colunas calculadas.
3. **Verifique os Tipos de Dados**: Certifique-se de que os valores de entrada (argumentos) têm o tipo de dados correto para a função.
4. **Consulte a Documentação**: Consulte a documentação do seu sistema de banco de dados para obter uma lista completa das funções disponíveis e sua sintaxe.

**Principais Conclusões desta Lição:**

Ao dominar o uso de funções em consultas SQL, você poderá realizar manipulações e análises poderosas de dados, extraindo insights valiosos de suas informações.