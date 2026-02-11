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

---

## Precedência de Operadores

Quando você combina vários operadores em uma única consulta (por exemplo, usando `AND` e `OR`), o SQL segue uma ordem específica de operações (precedência).

1.  `NOT` é avaliado primeiro.
2.  `AND` é avaliado segundo.
3.  `OR` é avaliado por último.

**O Poder dos Parênteses:**
Assim como na matemática, você deve usar parênteses `()` para controlar a ordem de avaliação e tornar suas consultas mais legíveis.

### Exemplo (Banco de Dados Sakila)

```sql
-- Esta consulta encontra filmes que são (Classificação G E Curtos) OU (Classificação PG E Curtos)
SELECT title, length, rating
FROM film
WHERE (rating = 'G' OR rating = 'PG') AND length < 60;
```

---

**Principais conclusões desta lição:**

*   Use `AND` para garantir que todas as condições sejam atendidas.
*   Use `OR` para encontrar correspondências para qualquer uma das várias condições.
*   Use `NOT` para excluir dados específicos.
*   Sempre use parênteses `()` ao misturar `AND` e `OR` para evitar erros lógicos e melhorar a clareza.

Na próxima lição, aprenderemos como **ordenar e limitar** os resultados para organizar seus dados de maneira mais eficaz.
