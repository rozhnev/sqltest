---
title: "Funções de String em SQL: UPPER, LOWER, TRIM, SUBSTRING e CONCAT"
description: "Aprenda as principais funções de string em SQL com exemplos do Sakila: como limpar, combinar e extrair dados de texto em consultas práticas."
keywords: ["funções de string SQL", "UPPER LOWER SQL", "TRIM SQL", "SUBSTRING SQL", "CONCAT SQL", "SQL Sakila"]
teaches: ["Como aplicar funções principais de string em consultas SQL", "Como lidar com segurança com tamanho de strings e valores NULL", "Como limpar e formatar campos de texto em cenários práticos", "Como extrair partes de strings para análise"]
about: ["SQL", "Funções de string", "Processamento de texto", "Banco de dados Sakila", "Banco de dados relacional"]
---

_Aula 3.2 · Tempo de leitura: ~8 min_

Nesta aula, você aprenderá funções de string em SQL que ajudam a limpar e transformar dados de texto diretamente nas consultas. Vamos ver quando usar `UPPER`, `LOWER`, `TRIM`, `SUBSTRING`, `CONCAT` e outras funções, além de analisar exemplos práticos. Ao final da aula, você conseguirá tratar campos de texto com confiança em situações reais.

# Funções Essenciais de String no SQL

Na aula anterior, você conheceu as funções embutidas de SQL de forma geral. Agora, vamos focar nas funções de string, pois campos de texto frequentemente exigem processamento extra: normalização de caixa, remoção de caracteres indesejados, concatenação de valores e extração de trechos.

Essas operações aparecem o tempo todo em análise de dados, relatórios e preparação de dados. Quanto melhor você dominar funções de string, menos pós-processamento manual será necessário fora do SQL.

---

## O que são funções de string

Funções de string trabalham com texto e retornam uma string, um número ou a posição de uma substring. Elas são úteis quando você precisa:

- padronizar o formato do texto;
- limpar valores com ruído;
- extrair parte de uma string (por exemplo, o domínio de um e-mail);
- montar uma saída textual mais legível para relatórios.

---

## Sintaxe básica

```sql
FUNCTION_NAME(string_expression, ...)
```

Normalmente, o argumento é uma coluna da tabela, um literal de texto ou o resultado de outra função.

---

## Funções essenciais de string

### `UPPER()` e `LOWER()`

São usadas para normalizar a caixa do texto.

```sql
SELECT
   customer_id,
   UPPER(last_name) AS last_name_upper,
   LOWER(first_name) AS first_name_lower
FROM customer
LIMIT 5;
```

*Resultado: o sobrenome é exibido em maiúsculas e o nome em minúsculas.*

### `CHAR_LENGTH()` e `LENGTH()`

As duas funções medem o tamanho da string, mas nem sempre da mesma forma:

- `CHAR_LENGTH()` normalmente retorna quantidade de caracteres;
- `LENGTH()` no MySQL retorna quantidade de bytes.

```sql
SELECT
   title,
   CHAR_LENGTH(title) AS title_chars,
   LENGTH(title) AS title_bytes
FROM film
LIMIT 5;
```

*Observação: para caracteres multibyte, a contagem em bytes pode ser maior que a contagem em caracteres.*

### `SUBSTRING()`, `LEFT()`, `RIGHT()`

Essas funções extraem parte de uma string.

```sql
SELECT
   email,
   SUBSTRING(email, 1, 5) AS email_start,
   LEFT(email, 3) AS first_3,
   RIGHT(email, 10) AS last_10
FROM customer
LIMIT 5;
```

*Resultado: diferentes trechos do e-mail são extraídos para análise e validação de formato.*

### `CONCAT()` e `CONCAT_WS()`

Essas funções combinam vários valores em uma única string:

- `CONCAT()` concatena os argumentos diretamente;
- `CONCAT_WS(separator, ...)` adiciona separador e costuma ser mais prática em relatórios.

```sql
SELECT
   customer_id,
   CONCAT(first_name, ' ', last_name) AS full_name,
   CONCAT_WS(' | ', first_name, last_name, email) AS customer_label
FROM customer
LIMIT 5;
```

*Observação: o comportamento com `NULL` depende do SGBD, então verifique a documentação do seu sistema.*

### `TRIM()` e `REPLACE()`

São úteis para limpeza de dados textuais.

```sql
SELECT
   address,
   TRIM(address) AS address_trimmed,
   REPLACE(address, 'Street', 'St.') AS address_short
FROM address
LIMIT 5;
```

*Resultado: espaços extras são removidos e padrões de texto repetitivos são substituídos.*

### Busca de substring: `POSITION()` / `INSTR()` / `CHARINDEX()`

O nome da função muda conforme o SGBD, mas a ideia é a mesma: encontrar a posição de uma substring dentro da string.

```sql
SELECT
   email,
   INSTR(email, '@') AS at_pos
FROM customer
LIMIT 5;
```

*Resultado: retorna a posição de `@`, útil para validação de e-mail.*

---

## Pontos de atenção

- Verifique diferenças entre SGBDs: nomes e comportamentos das funções podem variar.
- Considere `NULL`: ele frequentemente altera o resultado de expressões de string.
- Para texto com cirílico e emoji, escolha conscientemente a função de tamanho (caracteres vs bytes).
- Evite empilhar funções demais em uma única consulta; prefira quebrar a lógica em etapas.

---

## Exemplo prático: preparação de dados de clientes para envio de e-mail

A consulta abaixo prepara uma lista de clientes limpa: normaliza nome, normaliza e-mail e extrai domínio.

```sql
SELECT
   c.customer_id,
   TRIM(CONCAT_WS(' ', c.first_name, c.last_name)) AS full_name,
   LOWER(TRIM(c.email)) AS email_normalized,
   SUBSTRING_INDEX(LOWER(TRIM(c.email)), '@', -1) AS email_domain
FROM customer AS c
WHERE c.email IS NOT NULL
ORDER BY c.customer_id
LIMIT 20;
```

*Resultado: você obtém um conjunto limpo e consistente de campos textuais, pronto para análise ou exportação.*

---

**Principais conclusões desta aula:**

- Funções de string em SQL ajudam a limpar, normalizar e formatar texto diretamente nas consultas.
- `UPPER`, `LOWER`, `TRIM`, `REPLACE`, `SUBSTRING`, `LEFT`, `RIGHT` e `CONCAT` cobrem a maioria dos casos comuns.
- Para tamanho de string, é importante diferenciar caracteres de bytes.
- Ao combinar strings, considere o comportamento de `NULL` no seu SGBD.
- O valor prático das funções de string aparece claramente em cenários reais de preparação de dados.

## Perguntas de entrevista

### Qual é a diferença entre `CHAR_LENGTH()` e `LENGTH()`, e por que isso importa?
`CHAR_LENGTH()` normalmente retorna o número de **caracteres**, enquanto `LENGTH()` no MySQL retorna o número de **bytes**. Para cirílico e outros caracteres multibyte, os resultados podem ser diferentes. Isso é importante para validação de tamanho de campos e aplicação de regras de negócio.

### Como montar um nome completo com segurança se um dos campos pode ser `NULL`?
`CONCAT_WS()` costuma ser preferida, pois é prática para concatenar strings com separador. Também é comum tratar valores vazios explicitamente com **`COALESCE()`** para obter saída previsível em diferentes cenários.

### Quais funções de string você usaria para limpar e-mail antes de análise?
Uma abordagem comum é usar **`TRIM()`** + **`LOWER()`** para remover espaços extras e normalizar caixa. Para validar a estrutura, você também pode verificar a posição de `@` com `INSTR()` ou equivalente no seu SGBD.

Na próxima aula, vamos passar para funções matemáticas em SQL e ver como fazer cálculos numéricos em consultas.