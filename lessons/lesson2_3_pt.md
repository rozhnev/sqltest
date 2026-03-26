Esta lição de SQL aborda como combinar múltiplas condições em uma cláusula WHERE usando operadores lógicos: AND, OR e NOT. Você aprenderá a criar filtros de banco de dados avançados para recuperar subconjuntos de dados específicos conectando múltiplas expressões. A lição explica a precedência dos operadores e a importância de usar parênteses para controlar a ordem de avaliação e garantir a precisão da consulta. Domine técnicas complexas de filtragem de dados para aprimorar suas habilidades de consulta SQL para análise de dados e relatórios mais eficazes.

# Lição 2.3 Combinando Múltiplas Condições

## Combinando Múltiplos Critérios em SQL

Na lição anterior, aprendemos como usar a cláusula `WHERE` com operadores de comparação simples. No entanto, a análise de dados no mundo real frequentemente exige a filtragem por vários critérios simultaneamente. Para fazer isso, usamos operadores lógicos: `AND`, `OR` e `NOT`.

## Operadores Lógicos

Os operadores lógicos permitem conectar múltiplas expressões em uma cláusula `WHERE` para criar filtros mais sofisticados.

### 1. O Operador AND
O operador `AND` retorna linhas apenas se **todas** as condições separadas por `AND` forem verdadeiras. Ele é usado para restringir seus resultados.

**Exemplo (Banco de Dados Sakila)**
Suponha que queiramos encontrar filmes que tenham classificação 'G' e menos de 80 minutos de duração:

```sql
SELECT title, length, rating
FROM film
WHERE length < 80 AND rating = 'G';
```

### 2. O Operador OR
O operador `OR` retorna linhas se **qualquer** uma das condições separadas por `OR` for verdadeira. Ele é usado para ampliar seus resultados.

**Exemplo (Banco de Dados Sakila)**
Para encontrar atores com o primeiro nome 'NICK' ou 'ED':

```sql
SELECT first_name, last_name
FROM actor
WHERE first_name = 'NICK' OR first_name = 'ED';
```

### 3. O Operador NOT
O operador `NOT` exibe um registro se a(s) condição(ões) **NÃO** for(em) verdadeira(s). Ele inverte efetivamente a lógica de uma condição.

**Exemplo (Banco de Dados Sakila)**
Para encontrar todos os filmes, exceto aqueles com classificação 'R':

```sql
SELECT title, rating
FROM film
WHERE NOT rating = 'R';
```

### 4. O Operador XOR (OU Exclusivo, raramente usado)
O operador `XOR` retorna verdadeiro apenas quando **exatamente uma** entre duas condições é verdadeira. Na prática, ele é pouco usado porque não é suportado por todos os dialetos SQL e pode reduzir a legibilidade da consulta.

**Exemplo (Banco de Dados Sakila)**
Para encontrar filmes em que apenas uma condição seja verdadeira: ou a duração é menor que 60 minutos, ou a classificação é 'G', mas não ambas ao mesmo tempo:

```sql
SELECT title, length, rating
FROM film
WHERE length < 60 XOR rating = 'G';
```

Para maior portabilidade entre diferentes bancos de dados, essa mesma lógica costuma ser escrita com `AND`/`OR`/`NOT`.

---

## Precedência de Operadores

Quando você combina vários operadores em uma única consulta (por exemplo, usando `AND` e `OR`), o SQL segue uma ordem específica de operações (precedência).

1.  `NOT` é avaliado primeiro.
2.  `AND` é avaliado segundo.
3.  `XOR` (se suportado pelo seu dialeto SQL) geralmente é avaliado após `AND`.
4.  `OR` é avaliado por último.

**O Poder dos Parênteses:**
Assim como na matemática, você deve usar parênteses `()` para controlar a ordem de avaliação e tornar suas consultas mais legíveis. Sem eles, o SQL aplica silenciosamente sua precedência padrão — e o resultado pode não ser o que você esperava.

---

### Exemplo 1: Encontrar filmes 'G' e 'PG' com menos de 60 minutos

**Consulta incorreta — parênteses ausentes:**

```sql
-- ERRO: AND tem maior precedência que OR, então isso é avaliado como:
-- rating = 'G'  OR  (rating = 'PG' AND length < 60)
-- Resultado: TODOS os filmes 'G' (qualquer duração) + apenas filmes 'PG' CURTOS
SELECT title, length, rating
FROM film
WHERE rating = 'G' OR rating = 'PG' AND length < 60;
```

**Por que está errado:** a condição `AND` é avaliada primeiro, portanto o filtro `length < 60` só se aplica aos filmes 'PG', enquanto todos os filmes 'G' — independentemente da duração — passam pelo filtro.

**Consulta correta — parênteses tornam a intenção explícita:**

```sql
-- CORRETO: parênteses forçam o OR a ser avaliado primeiro
-- Resultado: apenas filmes classificados 'G' OU 'PG' E com menos de 60 minutos
SELECT title, length, rating
FROM film
WHERE (rating = 'G' OR rating = 'PG') AND length < 60;
```

---

### Exemplo 2: Excluir filmes com classificação 'R' e 'NC-17'

**Consulta incorreta — NOT nega apenas a primeira condição:**

```sql
-- ERRO: NOT aplica-se apenas à condição imediatamente seguinte
-- Equivalente a: (NOT rating = 'R') AND rating = 'NC-17'
-- Resultado: todos os filmes classificados 'NC-17' (pois 'NC-17' não é 'R', NOT é sempre verdadeiro)
SELECT title, rating, length
FROM film
WHERE NOT rating = 'R' AND rating = 'NC-17';
```

**Por que está errado:** `NOT` nega apenas `rating = 'R'`, deixando `rating = 'NC-17'` como filtro positivo. A consulta efetivamente retorna todos os filmes classificados como 'NC-17' — porque 'NC-17' não é 'R', a condição `NOT` é sempre satisfeita para essas linhas. Em vez de excluir filmes NC-17, a consulta retorna exatamente os filmes que você queria excluir.

**Opção A — duas condições NOT explícitas:**

```sql
-- CORRETO: cada condição é negada independentemente
SELECT title, rating, length
FROM film
WHERE NOT rating = 'R' AND NOT rating = 'NC-17';
```

**Opção B — NOT com parênteses (mais conciso):**

```sql
-- CORRETO: NOT aplica-se a todo o grupo OR
SELECT title, rating, length
FROM film
WHERE NOT (rating = 'R' OR rating = 'NC-17');
```

Ambas as opções retornam o mesmo resultado. A opção B é geralmente preferida ao excluir vários valores — ela escala melhor à medida que a lista cresce.

---

**Principais conclusões desta lição:**

*   Use `AND` para garantir que todas as condições sejam atendidas.
*   Use `OR` para encontrar correspondências para qualquer uma das várias condições.
*   Use `NOT` para excluir dados específicos.
*   Use `XOR` com cuidado: pode ser útil, mas não é suportado por todos os dialetos SQL.
*   Sempre use parênteses `()` ao misturar `AND` e `OR` para evitar erros lógicos e melhorar a clareza.

Na próxima lição, aprenderemos como **ordenar e limitar** os resultados para organizar seus dados de maneira mais eficaz.
