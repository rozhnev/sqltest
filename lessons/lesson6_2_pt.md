---
title: "Subconsultas SQL no WHERE: IN, EXISTS, ANY e ALL"
description: "Subconsultas no WHERE permitem filtrar dados dinamicamente. Aprenda IN, NOT IN, EXISTS, NOT EXISTS, ANY e ALL com exemplos práticos de Sakila."
keywords: ["SQL subquery", "WHERE", "EXISTS", "NOT EXISTS", "IN", "ANY ALL"]
teaches: ["Escolher o operador correto para cada tipo de resultado de subconsulta", "Aplicar EXISTS e NOT EXISTS corretamente", "Entender a diferença entre ANY e ALL"]
about: ["SQL", "Subquery", "WHERE clause", "Sakila"]
---

_Tempo de leitura: ~8 min_

Uma subconsulta no `WHERE` permite filtrar linhas com base no resultado intermediário de outra consulta. Nesta lição, você vai aprender quando usar operadores de comparação, `IN`, `NOT IN`, `EXISTS`, `NOT EXISTS`, `ANY` e `ALL`, e como escolher a opção mais segura em cenários práticos.

# Subconsultas na Cláusula WHERE

Na lição anterior, vimos a ideia geral de subconsultas. Agora vamos focar no cenário mais comum: a filtragem no `WHERE`, quando a consulta externa depende de valores calculados dinamicamente.

Na prática, isso é usado o tempo todo: desde encontrar clientes sem pagamentos até comparar uma linha com um conjunto de resultados.

<img src="/images/lessons/lesson6_2-where-subqueries.svg" alt="Diagrama de subconsultas em WHERE com os operadores IN, EXISTS, ANY e ALL" width="100%">

## Subconsultas Escalares e Operadores de Comparação

Se uma subconsulta retorna exatamente um valor, ela é chamada de subconsulta escalar. Nesse caso, você pode usar os operadores padrão `=`, `<>`, `>`, `>=`, `<`, `<=`.

**Cenário:** encontrar atores com o mesmo primeiro nome do ator com `actor_id = 10`.

```sql
SELECT
    first_name,
    last_name
FROM
    actor
WHERE
    first_name = (
        SELECT first_name
        FROM actor
        WHERE actor_id = 10
    )
    AND actor_id <> 10;
```

*Nota: se a consulta interna retornar várias linhas, esta consulta falha com erro.*

---

## Subconsultas de Múltiplas Linhas: IN e NOT IN

Quando uma subconsulta retorna uma lista de valores (uma coluna, várias linhas), use `IN`.

**Cenário:** encontrar filmes da categoria `Action`.

```sql
SELECT
    f.title
FROM
    film AS f
WHERE
    f.film_id IN (
        SELECT
            fc.film_id
        FROM
            film_category AS fc
        WHERE
            fc.category_id = (
                SELECT
                    c.category_id
                FROM
                    category AS c
                WHERE
                    c.name = 'Action'
            )
    );
```

*Resultado: você obtém todos os filmes ligados à categoria `Action` por meio da tabela `film_category`.*

`NOT IN` faz a filtragem inversa, mas lembre de um ponto importante: se o resultado da subconsulta contiver `NULL`, a condição pode gerar um resultado vazio inesperado. Nesses casos, `NOT EXISTS` costuma ser mais seguro.

---

## Verificação de Existência: EXISTS e NOT EXISTS

`EXISTS` verifica se existe pelo menos uma linha na subconsulta. O banco pode parar na primeira correspondência, então essa abordagem costuma ser eficiente em tabelas grandes.

### EXISTS

**Cenário:** encontrar clientes que têm pelo menos um pagamento.

```sql
SELECT
    c.first_name,
    c.last_name
FROM
    customer AS c
WHERE
    EXISTS (
        SELECT
            1
        FROM
            payment AS p
        WHERE
            p.customer_id = c.customer_id
    );
```

*Nota: com `EXISTS`, é comum usar `SELECT 1`, porque só importa se existe linha, não os valores das colunas retornadas.*

### NOT EXISTS

**Cenário:** encontrar clientes que não fizeram nenhum pagamento.

```sql
SELECT
    c.first_name,
    c.last_name
FROM
    customer AS c
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            payment AS p
        WHERE
            p.customer_id = c.customer_id
    );
```

*Resultado: apenas clientes sem nenhuma linha correspondente em `payment` serão retornados.*

---

## Comparação com um Conjunto: ANY e ALL

- `ANY`: a condição é verdadeira se for verdadeira para pelo menos um valor da subconsulta.
- `ALL`: a condição é verdadeira apenas se for verdadeira para todos os valores da subconsulta.

**Cenário:** comparar a duração de um filme com as durações dos filmes da categoria `Comedy`.

```sql
SELECT
    f.title,
    f.length
FROM
    film AS f
WHERE
    f.length > ANY (
        SELECT
            f2.length
        FROM
            film AS f2
        INNER JOIN film_category AS fc ON f2.film_id = fc.film_id
        INNER JOIN category AS c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Comedy'
    );
```

*Resultado: o filme entra no resultado se for mais longo que pelo menos um filme de `Comedy`.*

```sql
SELECT
    f.title,
    f.length
FROM
    film AS f
WHERE
    f.length > ALL (
        SELECT
            f2.length
        FROM
            film AS f2
        INNER JOIN film_category AS fc ON f2.film_id = fc.film_id
        INNER JOIN category AS c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Comedy'
    );
```

*Resultado: o filme entra no resultado apenas se for mais longo que todos os filmes de `Comedy`.*

---

## O Que Observar em Consultas Reais

- Para um único valor, use subconsulta escalar com operador de comparação.
- Para uma lista de valores, use `IN` ou `EXISTS` conforme a necessidade.
- Para encontrar relações ausentes, prefira `NOT EXISTS`, especialmente quando `NULL` for possível.
- Sempre verifique se a subconsulta pode retornar mais linhas do que o esperado.

---

**Principais conclusões desta lição:**

- `WHERE` com subconsulta permite filtragem dinâmica sem substituição manual de valores.
- `IN` é prático para verificar pertencimento a uma lista de valores.
- `EXISTS` e `NOT EXISTS` são eficazes para testar presença e ausência de linhas relacionadas.
- `ANY` e `ALL` permitem comparar uma linha com um conjunto inteiro de valores.
- Escolher o operador certo torna as consultas mais precisas, legíveis e confiáveis.

## Perguntas Frequentes

### O que é melhor para encontrar relacionamentos ausentes: NOT IN ou NOT EXISTS?
Na maioria dos casos práticos, `NOT EXISTS` é mais seguro. Se a subconsulta de `NOT IN` retornar `NULL`, o resultado pode ficar inesperado e filtrar linhas demais.

### Por que as pessoas geralmente usam SELECT 1 em EXISTS em vez de SELECT *?
Porque `EXISTS` verifica apenas se existem linhas. Os valores das colunas selecionadas não são usados, então `SELECT 1` é uma forma padrão e clara.

### Quando devo usar ANY e quando devo usar ALL?
Use `ANY` quando a condição deve ser verdadeira para pelo menos um valor da subconsulta. Use `ALL` quando a condição deve ser verdadeira para todos os valores do conjunto.

## Perguntas de Entrevista

### Qual é a diferença entre IN e EXISTS em SQL?
`IN` compara um valor com uma lista retornada por subconsulta, enquanto `EXISTS` verifica se há pelo menos uma linha correspondente. Em grandes volumes, `EXISTS` costuma ser mais eficiente em cenários correlacionados porque pode parar na primeira correspondência.

### Como você explicaria a diferença entre subconsulta escalar e subconsulta de múltiplas linhas?
Uma **subconsulta escalar** retorna um valor e é usada com operadores como `=` ou `>`. Uma **subconsulta de múltiplas linhas** retorna um conjunto de valores e geralmente é usada com `IN`, `ANY` ou `ALL`.

### Por que uma consulta com o operador = e uma subconsulta pode falhar?
O operador `=` espera um único valor no lado direito. Se a subconsulta retornar mais de uma linha, o mecanismo SQL não consegue fazer uma comparação inequívoca e retorna erro.

Na próxima lição, veremos subconsultas correlacionadas e como elas são executadas linha por linha na consulta externa.
