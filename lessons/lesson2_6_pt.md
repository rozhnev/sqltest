Esta lição apresenta as cláusulas `LIMIT` e `OFFSET` no SQL, ferramentas essenciais para controlar o número de linhas retornadas por uma consulta e implementar a paginação. Você aprenderá como recuperar um subconjunto específico de dados, como os "10 melhores" registros, e como pular um determinado número de linhas para navegar por grandes conjuntos de dados. Dominar essas cláusulas é crucial para construir aplicações eficientes que manipulam dados em "pedaços" ou páginas gerenciáveis, melhorando o desempenho e a experiência do usuário.

# Lição 2.6: Limitando Resultados com LIMIT e OFFSET

Ao trabalhar com tabelas grandes, muitas vezes você não deseja recuperar cada linha. Às vezes, você precisa apenas dos primeiros registros ou deseja implementar a "paginação" (mostrando resultados na Página 1, Página 2, etc.). Para essas tarefas, usamos as cláusulas `LIMIT` e `OFFSET`.

## A Cláusula LIMIT

A cláusula `LIMIT` é usada para especificar o número máximo de linhas que a consulta deve retornar.

### Sintaxe

```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
ORDER BY nome_da_coluna
LIMIT count;
```

*   **`count`**: O número máximo de linhas a serem retornadas.

> **Nota:** É altamente recomendável usar `LIMIT` em conjunto com `ORDER BY`. Sem a ordenação, as "primeiras X linhas" podem ser quaisquer linhas, dependendo de como o mecanismo do banco de dados otimiza a consulta.

## A Cláusula OFFSET

A cláusula `OFFSET` diz ao banco de dados para pular um número específico de linhas antes de começar a retornar os resultados.

### Sintaxe

```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
ORDER BY nome_da_coluna
LIMIT count OFFSET skip;
```

*   **`skip`**: O número de linhas a serem puladas antes de começar a retornar as linhas.

## Paginação: Combinando LIMIT e OFFSET

A paginação é o processo de dividir um grande conjunto de resultados em páginas discretas. Este é o caso de uso mais comum para combinar `LIMIT` e `OFFSET`.

*   **Página 1:** `LIMIT 10 OFFSET 0` (Linhas 1-10)
*   **Página 2:** `LIMIT 10 OFFSET 10` (Linhas 11-20)
*   **Página 3:** `LIMIT 10 OFFSET 20` (Linhas 21-30)

## Exemplos

### Exemplo 1: Top 5 Filmes Mais Longos
Esta consulta encontra os 5 filmes mais longos na tabela `film`.

```sql
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 5;
```

### Exemplo 2: Pulando Registros
Esta consulta pula os primeiros 10 atores (ordenados por ID) e retorna os 5 seguintes.

```sql
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY actor_id
LIMIT 5 OFFSET 10;
```

---

**Principais conclusões desta lição:**

*   `LIMIT` restringe o número de linhas no conjunto de resultados.
*   `OFFSET` pula um número especificado de linhas antes de retornar os dados.
*   Combinar `LIMIT` e `OFFSET` é a maneira padrão de implementar a paginação.
*   Sempre use `ORDER BY` com estas cláusulas para garantir resultados previsíveis.

Na próxima lição, veremos como **combinar WHERE, ORDER BY e LIMIT** para construir consultas poderosas e precisas.
