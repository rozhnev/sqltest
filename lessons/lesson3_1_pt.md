---
title: "Funções SQL integradas: sintaxe, categorias e exemplos práticos"
description: "Aprenda como usar funções SQL integradas em SELECT e WHERE, com exemplos práticos baseados no banco Sakila."
keywords: ["funcoes sql", "funções SQL integradas", "exemplos de funções SQL", "funções no SELECT", "funções no WHERE", "SQL Sakila"]
teaches: ["O que são funções SQL integradas e por que são importantes", "Como usar funções SQL em SELECT e WHERE", "Como escolher funções para texto, números e datas", "Como evitar erros comuns ao usar funções SQL"]
about: ["SQL", "Funções integradas", "Processamento de dados", "Banco de dados Sakila", "Banco de dados relacional"]
---

_Lição 3.1 · Tempo de leitura: ~8 min_

Nesta lição, você vai estudar o tema "funcoes sql" e entender como funções integradas transformam dados diretamente na consulta. Vamos cobrir a sintaxe básica, as principais categorias de funções e exemplos práticos com Sakila. Ao final, você conseguirá aplicar funções SQL com segurança em cenários reais de análise.

# Funções SQL Integradas

Nas lições anteriores, você aprendeu a selecionar, filtrar e ordenar linhas. O próximo passo é calcular e transformar valores dentro da própria consulta, sem processamento extra na aplicação.

É nesse ponto que as funções SQL integradas se destacam: elas tornam as consultas mais expressivas, reduzem lógica repetitiva e aceleram a preparação de relatórios.

<img src="/images/lessons/lesson3_1-built-in-functions.svg" alt="Funções SQL integradas" width="100%">

---

## O que são funções SQL integradas

Uma função SQL integrada é uma operação predefinida oferecida pelo SGBD. Ela recebe argumentos e retorna um novo valor, como texto, número, data ou resultado booleano.

As funções são usadas quando você precisa:

- padronizar valores de texto;
- realizar cálculos diretamente no SQL;
- extrair partes de strings ou datas;
- converter valores entre tipos de dados.

---

## Sintaxe básica

```sql
FUNCTION_NAME(argument1, argument2, ...)
```

Onde:

- `FUNCTION_NAME` é o nome da função;
- `argument1, argument2, ...` são colunas, literais ou resultados de outras funções.

Exemplo de chamada simples de função:

```sql
SELECT
	UPPER(first_name) AS upper_name
FROM customer
LIMIT 5;
```

*Resultado: cada valor de `first_name` é convertido para maiúsculas.*

Você também pode usar chamadas aninhadas, quando o resultado de uma função é passado como argumento para outra.

Exemplo de chamada aninhada:

```sql
SELECT
	UPPER(TRIM(first_name)) AS normalized_name
FROM customer
LIMIT 5;
```

*Resultado: remove espaços no início e no fim, depois converte o nome para maiúsculas.*

---

## Onde as funções são mais usadas

### Funções no SELECT

No `SELECT`, as funções ajudam a modelar a saída.

```sql
SELECT
	customer_id,
	CONCAT(first_name, ' ', last_name) AS full_name,
	UPPER(email) AS email_upper
FROM customer
LIMIT 10;
```

*Observação: este exemplo usa apenas uma tabela e mostra como funções podem formatar colunas de saída diretamente no `SELECT`.*

### Funções no WHERE

No `WHERE`, as funções permitem filtrar com base em condições calculadas.

```sql
SELECT
	title,
	rental_duration
FROM film
WHERE LENGTH(title) >= 15
  AND ABS(rental_duration - 5) <= 2
ORDER BY title;
```

*Resultado: retorna filmes com títulos mais longos e duração de locação próxima de 5 dias.*

---

## Principais tipos de funções SQL

### Funções de string

Exemplos: `UPPER`, `LOWER`, `TRIM`, `SUBSTRING`, `CONCAT`.

Usadas para limpar e formatar campos de texto.

### Funções matemáticas

Exemplos: `ROUND`, `ABS`, `CEILING`, `FLOOR`, `MOD`.

Usadas para cálculos, arredondamentos e controle de valores numéricos.

### Funções de data e hora

Exemplos: `NOW`, `CURRENT_DATE`, `YEAR`, `MONTH`, `DATE_ADD`, `DATEDIFF`.

Usadas para análise temporal e cálculo de intervalos.

### Funções de conversão de tipo

Exemplos: `CAST`, `CONVERT`.

Usadas quando é necessário converter valores explicitamente para o tipo correto.

---

## Recomendações práticas

- Sempre confirme o comportamento da função no seu SGBD: sintaxe e detalhes podem variar.
- Use aliases com `AS` para tornar colunas calculadas mais legíveis.
- Considere valores `NULL`, pois o resultado da função pode virar `NULL`.
- Evite empilhar muitas funções em uma única consulta; divida a lógica em etapas.

---

**Principais conclusões desta lição:**

- Funções SQL integradas permitem processar dados diretamente nas consultas.
- Funções no `SELECT` modelam a saída, e funções no `WHERE` deixam o filtro mais preciso.
- Funções de string, matemáticas, temporais e de conversão cobrem a maioria dos cenários básicos.
- O tratamento correto de tipos de dados e `NULL` é essencial para resultados previsíveis.
- Funções bem aplicadas deixam as consultas SQL mais curtas, claras e úteis para análise.

## Perguntas de entrevista

### O que é uma função SQL integrada e por que ela é útil?
Uma função SQL integrada é uma operação predefinida fornecida pelo SGBD. Ela é útil porque permite transformar, calcular e formatar dados diretamente na consulta.

### Por que funções SQL são usadas com frequência em `SELECT` e em `WHERE`?
No `SELECT`, funções ajudam a formatar ou calcular valores de saída. No `WHERE`, elas ajudam a filtrar linhas com base em condições calculadas.

### O que é uma chamada de função aninhada e quando usá-la?
Uma chamada aninhada significa passar o resultado de uma função para outra. Use quando os dados precisarem de várias etapas de transformação, por exemplo `UPPER(TRIM(first_name))`.

Na próxima lição, vamos aprofundar as funções de string em SQL para limpar e transformar dados textuais com eficiência.