# Aula 3.2: Funções Comuns de String no SQL

As funções de string no SQL são usadas para manipular e transformar dados de texto. Essas funções são essenciais para limpar, formatar e extrair informações de colunas de texto em um banco de dados. Esta aula aborda algumas das funções de string mais utilizadas e fornece exemplos práticos.

## Funções Comuns de String

### `UPPER()` - Converte uma string para maiúsculas.

**Sintaxe:**
```sql
UPPER(string)
```

**Exemplo:**
```sql
SELECT UPPER(first_name) AS uppercase_name
FROM employees;
```
**Resultado:** Converte todos os valores de `first_name` para maiúsculas.

### `LOWER()` - Converte uma string para minúsculas.

**Sintaxe:**
```sql
LOWER(string)
```

**Exemplo:**
```sql
SELECT LOWER(last_name) AS lowercase_name
FROM employees;
```
**Resultado:** Converte todos os valores de `last_name` para minúsculas.

### `LENGTH()`, `CHAR_LENGTH()` ou `LEN()` - Retorna o comprimento de uma string (em caracteres ou bytes, dependendo do SGBD).

**Sintaxe:**
```sql
CHAR_LENGTH(string) -- Número de caracteres (por exemplo, no MySQL)
LENGTH(string)      -- No MySQL: comprimento em bytes
LEN(string)         -- No SQL Server: comprimento em caracteres
```

Importante: em diferentes SGBDs, “comprimento da string” pode significar coisas diferentes. Algumas funções retornam o comprimento em caracteres, enquanto outras retornam em bytes. Sempre verifique em qual unidade uma função trabalha no seu SGBD.

**Quando `LENGTH()` e `CHAR_LENGTH()` podem ser diferentes (por exemplo, no MySQL):**
- Para strings com apenas letras latinas e dígitos, os valores costumam coincidir.
- Para strings com caracteres multibyte (cirílico, emoji, ideogramas), `LENGTH()` geralmente é maior que `CHAR_LENGTH()`, porque conta bytes.

**Exemplo curto:**
- `'SQL'`: `LENGTH` = 3, `CHAR_LENGTH` = 3
- `'Привет'`: `LENGTH` = 12, `CHAR_LENGTH` = 6

**Exemplo:**
```sql
SELECT CHAR_LENGTH(product_name) AS name_length
FROM products;
```
**Resultado:** Retorna o número de caracteres em cada `product_name`.

### `SUBSTRING()` ou `SUBSTR()` - Extrai uma parte de uma string.

**Sintaxe:**
```sql
SUBSTRING(string, start_position, length) -- Para a maioria dos bancos de dados
SUBSTR(string, start_position, length)    -- Para Oracle e outros
```

**Exemplo:**
```sql
SELECT SUBSTRING(email, 1, 5) AS email_prefix
FROM users;
```
**Resultado:** Extrai os primeiros 5 caracteres da coluna `email`.

### `CONCAT()` - Concatena duas ou mais strings em uma única.

**Sintaxe:**
```sql
CONCAT(string1, string2, ...)
```

**Exemplo:**
```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;
```
**Resultado:** Combina `first_name` e `last_name` em um único `full_name`.

**Importante:** o comportamento de `CONCAT()` com `NULL` depende do SGBD. Por exemplo, no MySQL e no MariaDB, se pelo menos um argumento for `NULL`, o resultado de `CONCAT()` também será `NULL`.

### `CONCAT_WS()` - Concatena strings, inserindo um separador entre elas e ignorando valores `NULL`.

**Sintaxe:**
```sql
CONCAT_WS(separator, string1, string2, ...)
```

**Exemplo:**
```sql
SELECT CONCAT_WS(' ', first_name, last_name) AS full_name
FROM employees;
```
**Resultado:** Combina `first_name` e `last_name` com um espaço, ignorando valores `NULL` nos argumentos.

Se você precisar de uma concatenação NULL-safe sem separador, pode usar `CONCAT_WS('', string1, string2, ...)`.

### `TRIM()` - Remove caracteres no início e no final de uma string, geralmente espaços.

**Sintaxe:**
```sql
TRIM(string)
TRIM([characters FROM] string)
```

**Exemplo:**
```sql
SELECT TRIM('   SQL Basics   ') AS trimmed_string;
```
**Resultado:** Retorna `'SQL Basics'` sem os espaços em branco no início ou no final.

No caso mais simples, `TRIM()` remove espaços nas extremidades da string. Em alguns SGBDs, a função também permite informar explicitamente quais caracteres devem ser removidos.

### `REPLACE()` - Substitui ocorrências de uma substring dentro de uma string.

**Sintaxe:**
```sql
REPLACE(string, old_substring, new_substring)
```

**Exemplo:**
```sql
SELECT REPLACE(phone_number, '-', '') AS cleaned_phone
FROM contacts;
```
**Resultado:** Remove os traços de `phone_number`.

### `INSTR()` ou `CHARINDEX()` - Encontra a posição de uma substring dentro de uma string.

**Sintaxe:**
```sql
INSTR(string, substring)       -- Para a maioria dos bancos de dados
CHARINDEX(substring, string)   -- Para SQL Server
```

**Exemplo:**
```sql
SELECT INSTR(email, '@') AS at_position
FROM users;
```
**Resultado:** Retorna a posição do símbolo `@` na coluna `email`.

### `LEFT()` e `RIGHT()` - Extrai um número especificado de caracteres do início ou do final de uma string.

**Sintaxe:**
```sql
LEFT(string, number_of_characters)
RIGHT(string, number_of_characters)
```

**Exemplo:**
```sql
SELECT LEFT(product_code, 3) AS product_prefix,
       RIGHT(product_code, 4) AS product_suffix
FROM products;
```
**Resultado:** Extrai os primeiros 3 caracteres e os últimos 4 caracteres de `product_code`.

### `FORMAT()` ou `TO_CHAR()` - Formata uma string ou número em um formato específico.

**Sintaxe:**
```sql
FORMAT(value, format)       -- Para SQL Server
TO_CHAR(value, format)      -- Para Oracle
```

**Exemplo:**
```sql
SELECT FORMAT(salary, 'C') AS formatted_salary
FROM employees;
```
**Resultado:** Formata a coluna `salary` como moeda.

## Casos Práticos de Uso

1. **Limpeza de Dados:**
   Use `TRIM()` e `REPLACE()` para limpar dados desorganizados, como remover espaços extras ou caracteres indesejados.

2. **Formatação de Saída:**
   Use `UPPER()`, `LOWER()`, `CONCAT()` e `CONCAT_WS()` para padronizar e formatar texto para relatórios.

3. **Extração de Informações:**
   Use `SUBSTRING()`, `LEFT()` e `RIGHT()` para extrair partes específicas de uma string, como prefixos ou nomes de domínio.

4. **Validação de Dados:**
   Use funções que contam caracteres (por exemplo, `CHAR_LENGTH()` ou `LEN()`) e `INSTR()` para validar a estrutura de strings, como verificar o comprimento de números de telefone ou a presença de um símbolo `@` em endereços de e-mail.

**Principais Conclusões desta Aula:**

As funções de string são ferramentas essenciais para trabalhar com dados de texto no SQL. Ao dominar essas funções, você pode limpar, formatar e extrair informações valiosas de seus dados. Pratique o uso dessas funções em cenários do mundo real para aprimorar suas habilidades em SQL.