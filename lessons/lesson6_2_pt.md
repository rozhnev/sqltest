Aprenda a usar subconsultas SQL na cláusula WHERE para filtrar dados com base em valores dinâmicos. Esta lição aborda o uso de subconsultas com operadores de comparação, os operadores IN e NOT IN para comparação de listas e uma introdução ao operador EXISTS. Domine técnicas complexas de filtragem usando o banco de dados Sakila.

# Lição 6.2: Subconsultas na Cláusula WHERE

A cláusula `WHERE` é o lugar mais comum para encontrar uma subconsulta. Ela permite filtrar o conjunto de resultados da consulta externa com base nos resultados da consulta interna. Nesta lição, exploraremos diferentes operadores usados com subconsultas na cláusula `WHERE`.

## 1. Subconsultas com Operadores de Comparação

Quando uma subconsulta retorna um único valor (uma subconsulta **escalar**), você pode usar operadores de comparação padrão como `=`, `<>`, `>`, `>=`, `<` ou `<=`.

**Cenário:** Encontrar os nomes dos atores que têm o mesmo nome que o ator com `actor_id = 10`.

```sql
SELECT
    first_name,
    last_name
FROM
    actor
WHERE
    first_name = (SELECT first_name FROM actor WHERE actor_id = 10)
    AND actor_id <> 10;
```
*Nota: Se a subconsulta retornar mais de uma linha, a consulta falhará com um erro.*

## 2. Os Operadores IN e NOT IN

Se uma subconsulta retornar múltiplos valores (uma coluna, várias linhas), você não pode usar `=`, mas pode usar o operador `IN`.

**Cenário:** Encontrar todos os filmes que pertencem à categoria 'Action'.
Podemos fazer isso primeiro encontrando o `category_id` para 'Action' e depois filtrando a tabela `film_category`.

```sql
SELECT
    title
FROM
    film
WHERE
    film_id IN (
        SELECT film_id 
        FROM film_category 
        WHERE category_id = (SELECT category_id FROM category WHERE name = 'Action')
    );
```
*Nota: Este exemplo usa uma subconsulta aninhada dentro de outra subconsulta!*

O operador `NOT IN` funciona da maneira oposta, excluindo as linhas que correspondem a qualquer valor na lista.

## 3. Os Operadores EXISTS e NOT EXISTS

O operador `EXISTS` verifica a **existência** de qualquer registro na subconsulta. Muitas vezes é mais eficiente que o `IN` para grandes conjuntos de dados porque para a busca assim que encontra a primeira correspondência.

**Cenário:** Encontrar todos os clientes que fizeram pelo menos um pagamento.

```sql
SELECT
    c.first_name,
    c.last_name
FROM
    customer AS c
WHERE
    EXISTS (
        SELECT 1 
        FROM payment AS p 
        WHERE p.customer_id = c.customer_id
    );
```
*Dica: `SELECT 1` é comumente usado no `EXISTS` porque o dado real retornado pela subconsulta não importa; apenas se alguma linha é retornada.*

## 4. Operadores ANY e ALL

-   **ANY:** A condição é verdadeira se corresponder a **pelo menos um** valor no resultado da subconsulta.
-   **ALL:** A condição é verdadeira apenas se corresponder a **todos** os valores no resultado da subconsulta.

**Cenário:** Encontrar filmes cuja duração seja maior do que todos os filmes da categoria 'Comedy'.

```sql
SELECT
    title,
    length
FROM
    film
WHERE
    length > ALL (
        SELECT f.length
        FROM film f
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category c ON fc.category_id = c.category_id
        WHERE c.name = 'Comedy'
    );
```

## Principais Conclusões desta Lição

- Use **operadores de comparação** (`=`, `>`) apenas com subconsultas que retornam um único valor.
- Use **IN** quando a subconsulta retornar uma lista de valores.
- Use **EXISTS** para verificar se existem linhas correspondentes em outra tabela sem recuperar os dados.
- **NOT IN** e **NOT EXISTS** são essenciais para encontrar relacionamentos "ausentes".
- Subconsultas no `WHERE` tornam seu código dinâmico e lidam com lógica de filtragem em várias etapas.
