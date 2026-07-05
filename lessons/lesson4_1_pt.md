---
title: "Funcoes de agregacao SQL: COUNT, SUM, AVG, MIN e MAX"
description: "Aprenda as principais funcoes de agregacao SQL com exemplos Sakila: COUNT, SUM, AVG, MIN, MAX e diferencas entre COUNT(*), COUNT(column) e COUNT(DISTINCT ...)."
keywords: ["funcoes de agregacao SQL", "COUNT", "SUM", "AVG", "MIN", "MAX", "COUNT DISTINCT"]
teaches: ["Aplicar funcoes de agregacao basicas em consultas SELECT", "Entender diferencas entre COUNT(*), COUNT(column) e COUNT(DISTINCT ...)", "Lidar corretamente com NULL em contagens, somas e medias"]
about: ["SQL", "Aggregation", "COUNT DISTINCT", "Sakila"]
---

_Tempo de leitura: ~8 minutos_

As funcoes de agregacao em SQL transformam conjuntos de linhas em metricas de resumo: quantidade, soma, media, minimo e maximo. Nesta aula, voce vai praticar os agregados mais usados com exemplos da base Sakila e aprender a escolher o tipo correto de contagem para cada cenario. Ao final, voce conseguira usar `COUNT`, `SUM`, `AVG`, `MIN` e `MAX` com seguranca em consultas analiticas.

# Funcoes basicas de agregacao em SQL

Nas aulas anteriores, o foco foi selecionar linhas detalhadas. Agora avancamos para um passo essencial: gerar valores de resumo a partir dos dados.

As funcoes de agregacao sao fundamentais em relatorios e analise, porque respondem rapidamente perguntas como "quantos?", "qual o total?" e "qual a media?".

## Principais funcoes de agregacao

### COUNT() - conta linhas

Sintaxe basica:

```sql
COUNT(expressao)
```

Exemplo:

```sql
SELECT COUNT(*) AS total_payments
FROM payment;
```

*Resultado: a consulta retorna o total de linhas da tabela payment.*

### COUNT(column) e COUNT(*)

As duas formas parecem similares, mas funcionam de modo diferente:

- `COUNT(*)` conta todas as linhas do resultado.
- `COUNT(column)` conta apenas as linhas em que `column` nao e `NULL`.

Se a coluna tiver `NULL`, `COUNT(column)` pode ser menor que `COUNT(*)`.

```sql
SELECT
    COUNT(*) AS total_rentals,
    COUNT(return_date) AS returned_rentals
FROM rental;
```

*Explicacao: total_rentals conta todos os alugueis, enquanto returned_rentals conta apenas os que possuem return_date preenchida.*

### COUNT(DISTINCT ...) - conta valores unicos

Quando voce precisa contar valores unicos, e nao o total de linhas, use `COUNT(DISTINCT column)`.

```sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM payment;
```

*Resultado: a consulta retorna quantos clientes diferentes realizaram pagamentos, mesmo que um cliente tenha varias linhas em payment.*

Na pratica, isso e essencial para perguntas como "quantos clientes diferentes compraram", em que `COUNT(*)` superestima por causa de repeticoes.

### SUM() - calcula a soma

```sql
SELECT SUM(amount) AS total_amount
FROM payment;
```

*Resultado: retorna a soma da coluna amount.*

`SUM(amount)` ignora `NULL`. Se todos os valores forem `NULL`, o resultado sera `NULL`.

### AVG() - calcula a media

```sql
SELECT AVG(amount) AS average_amount
FROM payment;
```

*Resultado: retorna a media de amount considerando apenas linhas nao-NULL.*

Se voce precisar que linhas com `NULL` influenciem o denominador, use uma destas abordagens:

```sql
SELECT
    AVG(amount) AS avg_ignore_null,
    AVG(COALESCE(amount, 0)) AS avg_include_null_as_zero,
    SUM(amount) / COUNT(*) AS avg_sum_div_all_rows
FROM payment;
```

### MAX() - encontra o valor maximo

```sql
SELECT MAX(amount) AS max_amount
FROM payment;
```

*Resultado: retorna o maior valor em amount.*

### MIN() - encontra o valor minimo

```sql
SELECT MIN(amount) AS min_amount
FROM payment;
```

*Resultado: retorna o menor valor em amount.*

`MIN()` e `MAX()` ignoram `NULL`. Se todos os valores forem `NULL`, o resultado sera `NULL`.

### MIN(column) e ORDER BY ... LIMIT 1

Nem sempre essas abordagens sao equivalentes.

```sql
SELECT MIN(column_name)
FROM table_name;

SELECT column_name
FROM table_name
ORDER BY column_name
LIMIT 1;
```

- `MIN(column_name)` busca o menor valor entre os nao-`NULL`.
- `ORDER BY ... LIMIT 1` retorna a primeira linha apos a ordenacao.
- Se o SGBD ordenar `NULL` primeiro, a segunda consulta pode retornar `NULL`, enquanto `MIN()` retorna o menor valor nao-`NULL`.

Versao confiavel equivalente a `MIN()`:

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NOT NULL
ORDER BY column_name
LIMIT 1;
```

---

## Aplicacoes praticas

### Contar clientes

```sql
SELECT COUNT(*) AS total_customers
FROM customer;
```

### Soma de vendas por funcionario

```sql
SELECT
    staff_id,
    SUM(amount) AS staff_total
FROM payment
GROUP BY staff_id;
```

### Pagamento medio por cliente

```sql
SELECT
    customer_id,
    AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id;
```

### Contar clientes pagantes unicos

```sql
SELECT COUNT(DISTINCT customer_id) AS paying_customers
FROM payment;
```

---

## Perguntas frequentes

### Qual e a diferenca entre COUNT(*) e COUNT(column)?
`COUNT(*)` conta todas as linhas. `COUNT(column)` conta apenas as linhas em que a coluna especificada nao e `NULL`.

### Quando usar COUNT(DISTINCT ...)?
Quando voce precisa do numero de valores unicos, por exemplo clientes diferentes, e nao do total de linhas.

### Por que AVG pode retornar um valor inesperado?
Porque `AVG(column)` ignora `NULL`. Se voce quiser incluir essas linhas no denominador, use `COALESCE` ou `SUM(column) / COUNT(*)`.

---

## Perguntas de entrevista

### O que sao funcoes de agregacao em SQL?
Sao funcoes que calculam um resumo sobre varias linhas, como quantidade (`COUNT`), soma (`SUM`) e media (`AVG`). Elas retornam um valor por grupo ou para o conjunto inteiro.

### Qual e a diferenca entre COUNT(*), COUNT(column) e COUNT(DISTINCT column)?
`COUNT(*)` conta todas as linhas, `COUNT(column)` conta valores nao-`NULL` da coluna, e `COUNT(DISTINCT column)` conta valores unicos nao-`NULL`.

### Como MIN e ORDER BY ... LIMIT 1 podem retornar resultados diferentes?
Se a coluna tiver `NULL` e o SGBD ordenar `NULL` primeiro, `ORDER BY ... LIMIT 1` pode retornar `NULL`, enquanto `MIN()` retorna o menor valor nao-`NULL`.

---

**Principais conclusoes desta aula:**

- Funcoes de agregacao geram metricas de resumo rapidamente.
- `COUNT(*)`, `COUNT(column)` e `COUNT(DISTINCT ...)` atendem necessidades de contagem diferentes.
- `SUM`, `AVG`, `MIN` e `MAX` geralmente ignoram `NULL`, o que impacta a analise.
- `COUNT(DISTINCT ...)` e essencial para contar entidades unicas, nao apenas linhas.
- Tratar `NULL` corretamente e decisivo para a confiabilidade dos relatorios.

Na proxima aula, estudaremos `GROUP BY` para criar agregacoes por categorias.
