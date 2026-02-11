Aprenda os fundamentos das subconsultas SQL, também conhecidas como consultas aninhadas ou consultas internas. Esta lição apresenta o conceito de colocar uma consulta dentro de outra, explica a diferença entre subconsultas escalares e de múltiplas linhas e apresenta as "Inline Views". Aprenda a usar subconsultas para realizar a recuperação de dados em várias etapas no banco de dados Sakila.

# Lição 6.1: Introdução às Subconsultas — Consultas Aninhadas e Inline Views

Nos módulos anteriores, aprendemos como recuperar dados de tabelas e uni-los. No entanto, às vezes uma única consulta não é suficiente para obter a resposta de que você precisa. Você pode precisar encontrar um valor primeiro (como uma média ou um ID específico) e depois usar esse valor em outra consulta. É aqui que entram as **Subconsultas**.

## O que é uma Subconsulta?

Uma **Subconsulta** (ou Consulta Interna) é uma instrução `SELECT` aninhada dentro de outra instrução SQL. A consulta que contém a subconsulta é chamada de **Consulta Externa** (ou Consulta Principal).

As subconsultas são sempre colocadas entre parênteses `()`.

## Lógica Central: Como elas funcionam
Normalmente, o banco de dados executa a **Consulta Interna** primeiro. O resultado dessa consulta interna é então passado para a **Consulta Externa**, que o utiliza para completar sua própria execução.

```sql
-- Exemplo Conceitual
SELECT column_name
FROM table_name
WHERE column_name = (SELECT value FROM another_table);
                    ^------- Isso executa primeiro -------^
```

## Categorias de Subconsultas

As subconsultas são frequentemente categorizadas pelo tipo de dados que retornam:

1.  **Subconsulta Escalar:** Retorna exatamente um valor (uma linha e uma coluna).
2.  **Subconsulta de Múltiplas Linhas:** Retorna uma lista de valores (uma coluna, várias linhas).
3.  **Subconsulta de Tabela (Inline View):** Retorna um conjunto de resultados inteiro (várias colunas e linhas) e é usada na cláusula `FROM` como se fosse uma tabela temporária.

---

## 1. Subconsultas Aninhadas (Dentro de WHERE)

O uso mais comum de uma subconsulta é na cláusula `WHERE` para filtrar dados com base em um valor dinâmico.

**Cenário:** Encontrar filmes que tenham um custo de substituição superior à média do custo de substituição de todos os filmes.

```sql
SELECT
    title,
    replacement_cost
FROM
    film
WHERE
    replacement_cost > (SELECT AVG(replacement_cost) FROM film);
```
- **Consulta Interna:** Calcula o custo médio (US$ 19,98, por exemplo).
- **Consulta Externa:** Encontra todos os filmes onde o custo é superior aos US$ 19,98 calculados.

---

## 2. Inline Views (Dentro de FROM)

Quando você coloca uma subconsulta na cláusula `FROM`, ela é chamada de **Inline View**. Você está essencialmente criando uma tabela temporária "na hora" que existe apenas durante a execução dessa consulta.

**Nota:** Você **deve** dar um alias (apelido) a uma inline view.

**Cenário:** Obter uma lista de clientes ativos e uni-la aos seus dados de pagamento.

```sql
SELECT
    active_cust.first_name,
    p.amount
FROM
    (SELECT * FROM customer WHERE active = 1) AS active_cust
INNER JOIN
    payment AS p ON active_cust.customer_id = p.customer_id;
```
*Nesse caso, a consulta externa une o resultado da subconsulta (`active_cust`) com a tabela `payment`.*

---

## Por que usar Subconsultas em vez de JOINs?

- **Legibilidade:** Às vezes, uma subconsulta é mais fácil de entender do que um join complexo.
- **Agregação:** As subconsultas são ótimas quando você precisa usar um valor agregado (como `AVG` ou `MAX`) para filtrar linhas individuais.
- **Lógica:** Certas lógicas (como "Encontrar todos os X que NÃO existem em Y") podem ser expressas de forma muito limpa com subconsultas usando `NOT IN` ou `NOT EXISTS`.

## Principais Conclusões desta Lição

- Uma **Subconsulta** é uma instrução `SELECT` dentro de outra consulta.
- **Subconsultas aninhadas** são geralmente encontradas nas cláusulas `WHERE` или `SELECT`.
- **Inline Views** são subconsultas usadas na cláusula `FROM` e requerem um **alias**.
- A **Consulta Interna** geralmente executa primeiro, fornecendo dados para a **Consulta Externa**.
- As subconsultas são sempre envolvidas em **parênteses**.
