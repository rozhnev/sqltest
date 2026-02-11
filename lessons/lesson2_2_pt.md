Esta lição de SQL foca na filtragem de linhas usando a cláusula WHERE. Aprenda a usar operadores de comparação, filtros de intervalo com BETWEEN, correspondência de listas com IN e correspondência de padrões com LIKE. A lição também aborda a distinção crítica do tratamento de valores NULL com IS NULL e IS NOT NULL. Domine as técnicas de filtragem de dados para recuperar informações precisas e otimizar suas consultas de banco de dados para uma análise eficiente.

# Lição 2.2 Filtragem de Linhas: A Cláusula WHERE

## Filtragem de Dados com a Cláusula WHERE

A instrução `SELECT`, por si só, retorna todas as linhas de uma tabela. No entanto, em cenários do mundo real, você geralmente precisa apenas de um subconjunto de dados que atenda a critérios específicos. É aqui que entra a cláusula `WHERE`.

## O que é a Cláusula WHERE?

A cláusula `WHERE` é usada para filtrar registros. Ela garante que apenas as linhas que satisfazem uma condição especificada sejam incluídas no conjunto de resultados.

### Sintaxe Básica

```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE condicao;
```

A condição é uma expressão que avalia para verdadeiro (true), falso (false) ou desconhecido (unknown, se valores `NULL` estiverem envolvidos). Apenas as linhas onde a condição avalia como **verdadeiro** são retornadas.

---

## Operadores de Comparação

O SQL fornece uma variedade de operadores para comparar valores na cláusula `WHERE`:

| Operador | Descrição | Exemplo |
| :--- | :--- | :--- |
| `=` | Igual a | `WHERE last_name = 'SMITH'` |
| `<>` ou `!=` | Diferente de | `WHERE store_id <> 1` |
| `>` | Maior que | `WHERE rental_rate > 2.99` |
| `<` | Menor que | `WHERE length < 60` |
| `>=` | Maior ou igual a | `WHERE replacement_cost >= 20.00` |
| `<=` | Menor ou igual a | `WHERE amount <= 5.00` |

### Exemplo (Banco de Dados Sakila)

Para encontrar filmes com uma taxa de aluguel de $4.99 na tabela `film`:

```sql
SELECT title, rental_rate, replacement_cost
FROM film
WHERE rental_rate = 4.99;
```

---

## Operadores Especiais de Filtragem

O SQL inclui operadores poderosos para intervalos, conjuntos e correspondência de padrões.

### 1. BETWEEN (ENTRE)
Filtra valores dentro de um determinado intervalo (inclusive).

```sql
-- Encontrar pagamentos entre $5.00 e $10.00
SELECT payment_id, amount, payment_date
FROM payment
WHERE amount BETWEEN 5.00 AND 10.00;
```

### 2. IN (EM)
Corresponde a qualquer valor em uma lista especificada.

```sql
-- Encontrar clientes de lojas específicas
SELECT first_name, last_name, store_id
FROM customer
WHERE store_id IN (1, 2);
```

### 3. LIKE (COMO)
Pesquisa por um padrão especificado em uma coluna usando curingas:
- `%` representa zero, um ou vários caracteres.
- `_` representa um único caractere.

### Exemplo (Banco de Dados Sakila)

```sql
-- Encontrar filmes que começam com 'A'
SELECT title
FROM film
WHERE title LIKE 'A%';

-- Encontrar filmes onde a segunda letra é 'I'
SELECT title
FROM film
WHERE title LIKE '_I%';
```

---

## A Armadilha: Filtrando valores NULL

Como aprendemos na lição sobre NULLs, você não pode usar `=` ou `<>` para verificar `NULL`. Você deve usar `IS NULL` ou `IS NOT NULL`.

### Exemplo (Banco de Dados Sakila)

```sql
-- Incorreto
-- WHERE return_date = NULL

-- Correto
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL;
```

---

**Principais conclusões desta lição:**

*   A cláusula `WHERE` filtra as linhas **antes** que elas sejam retornadas ao conjunto de resultados.
*   Valores de string e data devem ser colocados entre aspas simples (ex: 'SMITH').
*   Valores numéricos não requerem aspas.
*   Use `LIKE` para correspondência de padrões e `IN` para correspondência com listas.
*   **Nunca** use `=` com `NULL`; use sempre `IS NULL`.

Na próxima lição, exploraremos como **combinar múltiplas condições** para criar filtros ainda mais poderosos.
