---
title: "Cláusula SQL WHERE: Filtrar Dados com BETWEEN, IN, LIKE e NULL"
description: "A cláusula SQL WHERE filtra linhas por condição. Aprenda operadores de comparação, BETWEEN, IN, correspondência de padrões com LIKE e como tratar valores NULL corretamente."
keywords: ["cláusula SQL WHERE", "filtrar dados SQL", "BETWEEN IN LIKE SQL", "IS NULL SQL", "operadores de comparação SQL", "tutorial WHERE SQL"]
---

_Lição 2.2 · Tempo de leitura: ~6 min_

A **cláusula SQL WHERE** filtra as linhas de uma tabela avaliando uma condição para cada registo — apenas as linhas onde a condição é verdadeira são retornadas. Nesta lição, aprenderá os operadores de comparação, `BETWEEN`, `IN`, correspondência de padrões com `LIKE` e a forma correta de lidar com valores `NULL`.

# Cláusula SQL WHERE: Filtrar Dados em Consultas SELECT

A instrução `SELECT` por si só retorna todas as linhas de uma tabela. Em cenários reais, geralmente precisa apenas de um subconjunto de dados que satisfaça critérios específicos — e é exatamente para isso que serve a cláusula `WHERE`.

## O Que É a Cláusula SQL WHERE?

A cláusula `WHERE` filtra registos antes de serem incluídos no resultado. Apenas as linhas que satisfazem a condição especificada são retornadas.

### Sintaxe Básica

```sql
SELECT coluna1, coluna2, ...
FROM nome_tabela
WHERE condicao;
```

A condição é uma expressão que avalia para verdadeiro (true), falso (false) ou desconhecido (se valores `NULL` estiverem envolvidos). Apenas as linhas onde a condição é **verdadeira** são retornadas.

---

## Operadores de Comparação SQL no WHERE

O SQL fornece um conjunto de operadores para comparar valores na cláusula `WHERE`:

| Operador | Descrição | Exemplo |
| :--- | :--- | :--- |
| `=` | Igual a | `WHERE last_name = 'SMITH'` |
| `<>` ou `!=` | Diferente de | `WHERE store_id <> 1` |
| `>` | Maior que | `WHERE rental_rate > 2.99` |
| `<` | Menor que | `WHERE length < 60` |
| `>=` | Maior ou igual a | `WHERE replacement_cost >= 20.00` |
| `<=` | Menor ou igual a | `WHERE amount <= 5.00` |

```sql
SELECT title, rental_rate, replacement_cost
FROM film
WHERE rental_rate = 4.99;
```

*Resultado: todos os filmes com taxa de aluguer exatamente $4.99.*

---

## Operadores SQL BETWEEN, IN e LIKE

O SQL inclui operadores poderosos para filtragem por intervalo, lista e padrão.

### BETWEEN — Filtro por Intervalo

Filtra valores dentro de um intervalo (inclusive em ambas as extremidades).

```sql
SELECT payment_id, amount, payment_date
FROM payment
WHERE amount BETWEEN 5.00 AND 10.00;
```

*Resultado: pagamentos de $5.00 a $10.00, inclusive.*

### IN — Correspondência com Lista

Verifica se um valor pertence a uma lista especificada. Alternativa concisa a múltiplas condições `OR`.

```sql
SELECT first_name, last_name, store_id
FROM customer
WHERE store_id IN (1, 2);
```

*Resultado: clientes pertencentes à loja 1 ou 2.*

### LIKE — Pesquisa por Padrão

Pesquisa um padrão numa coluna de texto usando carateres especiais:
- `%` — zero, um ou vários carateres quaisquer.
- `_` — exatamente um caráter.

```sql
-- Filmes cujo título começa com 'A'
SELECT title
FROM film
WHERE title LIKE 'A%';

-- Filmes onde a segunda letra do título é 'I'
SELECT title
FROM film
WHERE title LIKE '_I%';
```

---

## Como Filtrar Valores NULL em SQL

Não é possível usar `=` ou `<>` para verificar `NULL` — essas comparações retornam sempre desconhecido, nunca verdadeiro. Use `IS NULL` ou `IS NOT NULL`.

```sql
-- Errado: não retorna nenhuma linha
-- WHERE return_date = NULL

-- Correto
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL;
```

*Resultado: todos os alugueres que ainda não foram devolvidos.*

---

**Principais conclusões:**

* A cláusula `WHERE` filtra as linhas **antes** de serem retornadas no resultado.
* Strings e datas devem ser colocadas entre aspas simples (`'SMITH'`); valores numéricos não precisam de aspas.
* `BETWEEN` é inclusivo: `BETWEEN 5 AND 10` inclui 5 e 10.
* `IN` é uma alternativa concisa a múltiplas condições `OR`.
* `LIKE` usa `%` (sequência qualquer) e `_` (um único caráter).
* **Nunca** use `=` com `NULL` — use sempre `IS NULL` ou `IS NOT NULL`.

---

## Perguntas Frequentes

### Qual é a diferença entre WHERE e HAVING em SQL?
`WHERE` filtra linhas **antes** do agrupamento e agregação. `HAVING` filtra **depois** — trabalha com os resultados de `GROUP BY`. Use `WHERE` para filtrar linhas individuais, `HAVING` para filtrar grupos agregados.

### É possível usar múltiplas condições no WHERE?
Sim. Combine condições com `AND` (ambas devem ser verdadeiras), `OR` (pelo menos uma deve ser verdadeira) ou `NOT` (negação). Use parênteses para controlar a ordem de avaliação.

### Por que `WHERE coluna = NULL` não retorna resultados?
Porque `NULL` representa um valor desconhecido — comparar qualquer coisa com `NULL` usando `=` retorna sempre desconhecido, nunca verdadeiro ou falso. O SQL exige `IS NULL` ou `IS NOT NULL` para verificar a ausência de valor.

→ [Lição 2.3: Combinar Múltiplas Condições com AND, OR e NOT](lesson2_3_pt.md)
