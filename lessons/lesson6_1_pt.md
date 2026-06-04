---
title: "O que é uma subconsulta em SQL: fundamentos, tipos e Inline View"
description: "Uma subconsulta é um SELECT dentro de outra consulta. Veja tipos de subconsulta, fluxo de execução e Inline View com exemplos práticos em Sakila."
keywords: ["SQL subquery", "subconsulta", "Inline View", "consulta aninhada", "WHERE", "FROM"]
teaches: ["Entender o fluxo de execução entre consulta interna e externa", "Diferenciar subconsultas escalares, de múltiplas linhas e tabulares", "Usar Inline View na cláusula FROM"]
about: ["SQL", "Subquery", "Inline View", "Sakila"]
---

_Tempo de leitura: ~7 min_

Uma subconsulta em SQL permite dividir um problema em várias etapas dentro de uma única instrução. Nesta lição, você vai entender a ideia central de subconsultas, os principais tipos e como usá-las em `SELECT`, `WHERE` e `FROM` com exemplos da base Sakila.

# Introdução às Subconsultas: consultas aninhadas e Inline View

Nas lições anteriores, você aprendeu a recuperar dados e combinar tabelas com `JOIN`. Mas em tarefas reais, muitas vezes é preciso calcular um resultado intermediário primeiro e só depois usá-lo na consulta principal.

É exatamente para isso que servem as subconsultas: elas deixam a lógica SQL mais sequencial e mais fácil de entender.

<img src="/images/lessons/lesson6_1-subqueries-intro.svg" alt="Diagrama de subconsultas SQL mostrando a execução primeiro da consulta interna, depois da externa, e o uso em SELECT, WHERE e FROM" width="100%">

## O que é uma subconsulta

Uma **subconsulta** é uma instrução `SELECT` aninhada dentro de outra consulta SQL. A consulta que contém a subconsulta é chamada de consulta **externa**.

A subconsulta é sempre escrita entre parênteses `()`.

## Como a subconsulta é executada

Na maioria dos casos, o SGBD executa primeiro a consulta interna. Em seguida, o resultado é passado para a consulta externa, que conclui o filtro ou monta o conjunto final de dados.

```sql
-- Exemplo conceitual
SELECT column_name
FROM table_name
WHERE column_name = (SELECT value FROM another_table);
```

*Nota: a expressão entre parênteses é calculada primeiro e depois a condição do `WHERE` externo é aplicada.*

---

## Tipos principais de subconsultas

- **Subconsulta escalar**: retorna um valor (uma linha, uma coluna).
- **Subconsulta de múltiplas linhas**: retorna uma lista de valores (uma coluna, várias linhas).
- **Subconsulta tabular (Inline View)**: retorna um conjunto de linhas e colunas usado como tabela temporária.

---

## Subconsulta em SELECT

Você pode colocar subconsultas diretamente na lista `SELECT` quando precisa exibir uma métrica adicional ao lado das colunas principais sem mudar a granularidade do resultado. Isso é especialmente útil quando um `JOIN` poderia duplicar linhas ou exigir agregações mais pesadas.

**Cenário 1:** mostrar o último pagamento de cada cliente (data e valor).

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT p.payment_date
        FROM payment AS p
        WHERE p.customer_id = c.customer_id
        ORDER BY p.payment_date DESC
        LIMIT 1
    ) AS last_payment_date,
    (
        SELECT p.amount
        FROM payment AS p
        WHERE p.customer_id = c.customer_id
        ORDER BY p.payment_date DESC
        LIMIT 1
    ) AS last_payment_amount
FROM
    customer AS c
LIMIT 10;
```

*Resultado: para cada cliente, você obtém exatamente um pagamento "mais recente". Com `JOIN`, isso costuma ser mais complexo: primeiro calcula-se a data máxima, depois faz-se nova junção e tratamento de empates.*

**Cenário 2:** mostrar cada pagamento e seu desvio em relação à média de pagamentos do cliente.

```sql
SELECT
    p.payment_id,
    p.customer_id,
    p.amount,
    (
        SELECT AVG(p2.amount)
        FROM payment AS p2
        WHERE p2.customer_id = p.customer_id
    ) AS customer_avg_amount,
    p.amount - (
        SELECT AVG(p3.amount)
        FROM payment AS p3
        WHERE p3.customer_id = p.customer_id
    ) AS delta_from_customer_avg
FROM
    payment AS p
LIMIT 15;
```

*Resultado: cada linha de pagamento mantém a granularidade original e recebe um benchmark por cliente. Com `JOIN`, seria preciso criar uma tabela agregada separada e depois fazer uma junção extra.*

---

## Subconsulta em WHERE

O caso mais comum é a subconsulta dentro de `WHERE`, quando o filtro depende de um valor calculado dinamicamente.

**Cenário:** encontrar filmes com `replacement_cost` acima da média de todos os filmes.

```sql
SELECT
    title,
    replacement_cost
FROM
    film
WHERE
    replacement_cost > (
        SELECT AVG(replacement_cost)
        FROM film
    );
```

*Resultado: a consulta interna calcula a média e a consulta externa retorna os filmes acima desse valor.*

---

## Subconsulta em FROM (Inline View)

Quando a subconsulta é colocada em `FROM`, ela funciona como uma tabela temporária dentro da consulta atual. Esse padrão é chamado **Inline View**.

Importante: toda Inline View precisa de alias.

**Cenário:** obter clientes ativos e seus pagamentos.

```sql
SELECT
    active_cust.first_name,
    p.amount
FROM
    (
        SELECT
            customer_id,
            first_name
        FROM
            customer
        WHERE
            active = 1
    ) AS active_cust
INNER JOIN
    payment AS p ON active_cust.customer_id = p.customer_id;
```

*Resultado: a consulta externa junta o resultado da subconsulta `active_cust` com `payment`.*

---

## Quando a subconsulta é mais prática que JOIN

- Para lógica por etapas, quando você precisa primeiro de um valor intermediário.
- Para filtrar por agregados (`AVG`, `MAX`, `MIN`) sem complicar a consulta principal.
- Para cenários de ausência de relacionamento, em que `NOT IN` ou `NOT EXISTS` costumam ser opções naturais.

---

**Principais conclusões desta lição:**

- Uma subconsulta é um `SELECT` dentro de outra consulta SQL.
- A consulta interna geralmente executa antes da consulta externa.
- A subconsulta pode retornar um valor, uma lista de valores ou um conjunto tabular completo.
- A subconsulta em `FROM` é chamada Inline View e exige alias.
- Subconsultas ajudam a escrever SQL mais claro e flexível.

## Perguntas frequentes

### Qual é a diferença entre subconsulta em WHERE e em FROM?
Subconsulta em `WHERE` normalmente serve para filtrar linhas da consulta externa. Subconsulta em `FROM` cria um conjunto temporário (Inline View) que pode ser unido e processado depois.

### Preciso sempre dar alias para subconsulta em FROM?
Sim. Na maioria dos SGBDs, a subconsulta em `FROM` precisa obrigatoriamente de alias. Sem isso, a consulta falha.

### Quando NOT EXISTS é melhor que NOT IN?
Se a subconsulta puder retornar `NULL`, `NOT IN` pode gerar resultados inesperados. Nesses casos, `NOT EXISTS` costuma ser mais seguro.

## Perguntas de entrevista

### O que é uma subconsulta e como ela executa?
Uma **subconsulta** é um `SELECT` aninhado dentro de uma consulta SQL externa. Em geral, a consulta interna executa primeiro e a externa usa esse resultado para filtrar ou montar o resultado final.

### Qual é a diferença entre subconsulta escalar e subconsulta de múltiplas linhas?
Uma **subconsulta escalar** retorna um valor e normalmente trabalha com `=` ou `>`. Uma **subconsulta de múltiplas linhas** retorna um conjunto de valores e é usada com `IN`, `ANY` ou `ALL`.

### O que é Inline View em SQL?
Uma **Inline View** é uma subconsulta em `FROM` que se comporta como tabela temporária dentro de uma única consulta. Ela precisa de alias para que suas colunas possam ser referenciadas.

Na próxima lição, vamos aprofundar subconsultas em `WHERE` e estudar os operadores `IN`, `EXISTS`, `ANY` e `ALL`.
