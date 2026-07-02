---
title: "Funções matemáticas SQL: ABS, ROUND, POWER, MOD e outras"
description: "Aprenda as principais funções matemáticas em SQL com exemplos do Sakila: arredondamento, módulo, potência, raiz e cenários práticos de cálculo."
keywords: ["funções matemáticas SQL", "ABS SQL", "ROUND SQL", "POWER SQL", "MOD SQL", "SQL Sakila"]
teaches: ["Como aplicar funções matemáticas básicas em consultas SQL", "Como considerar tipos de dados em cálculos", "Como usar arredondamento e módulo em tarefas práticas", "Como usar GREATEST e LEAST considerando diferenças entre SGBDs"]
about: ["SQL", "Funções matemáticas", "Cálculos", "Sakila", "Banco de dados relacional"]
---

_Lição 3.3 · Tempo de leitura: ~8 min_

Nesta lição, você vai estudar as principais funções matemáticas do SQL, que ajudam a calcular e transformar dados numéricos diretamente nas consultas. Vamos cobrir arredondamento, módulo, potência, raiz e comparação de valores, com exemplos práticos na base Sakila. Ao final, você conseguirá aplicar essas funções com confiança em cenários analíticos e práticos.

# Funções Matemáticas Essenciais no SQL

As funções matemáticas no SQL são usadas para realizar diferentes cálculos sobre dados numéricos. Elas permitem arredondar valores, encontrar valores mínimos e máximos, calcular restos de divisão e muito mais. Nesta lição, são apresentadas as funções matemáticas mais usadas, com exemplos na base de dados Sakila.

Importante: dados numéricos em SQL podem ter tipos diferentes (`INTEGER`, `REAL`/`FLOAT`, `DECIMAL`/`NUMERIC`). A mesma fórmula pode gerar resultados diferentes dependendo do tipo de dado (por exemplo, por causa de divisão inteira, arredondamento e precisão). Se o tipo não for considerado, o resultado final pode ser diferente do esperado.

<img src="/images/lessons/lesson3_3-math-functions.svg" alt="Funções matemáticas essenciais em SQL" width="100%">

## Funções Matemáticas Comuns

### `ABS()` - Retorna o valor absoluto de um número.

**Sintaxe:**
```sql
ABS(number)
```

**Exemplo:**
```sql
SELECT ABS(amount - 5) AS abs_difference
FROM payment
LIMIT 3;
```
**Resultado:** Retorna a diferença absoluta entre `amount` e 5.

### `CEIL()` / `CEILING()` - Arredonda um número para cima (para o inteiro mais próximo).

**Sintaxe:**
```sql
CEIL(number)
CEILING(number)
```

**Exemplo:**
```sql
SELECT CEIL(amount) AS rounded_up
FROM payment
LIMIT 3;
```
**Resultado:** Arredonda `amount` para cima até o inteiro mais próximo.

### `FLOOR()` - Arredonda um número para baixo (para o inteiro mais próximo).

**Sintaxe:**
```sql
FLOOR(number)
```

**Exemplo:**
```sql
SELECT FLOOR(amount) AS rounded_down
FROM payment
LIMIT 3;
```
**Resultado:** Arredonda `amount` para baixo até o inteiro mais próximo.

### `ROUND()` - Arredonda um número para uma quantidade definida de casas decimais.

**Sintaxe:**
```sql
ROUND(number, decimals)
```

**Exemplo:**
```sql
SELECT ROUND(amount, 1) AS rounded_amount
FROM payment
LIMIT 3;
```
**Resultado:** Arredonda `amount` para uma casa decimal.

### `POWER()` / `POW()` - Eleva um número a uma potência.

**Sintaxe:**
```sql
POWER(number, exponent)
POW(number, exponent)
```

**Exemplo:**
```sql
SELECT POWER(amount, 2) AS squared_amount
FROM payment
LIMIT 3;
```
**Resultado:** Eleva `amount` ao quadrado.

### `SQRT()` - Retorna a raiz quadrada de um número.

**Sintaxe:**
```sql
SQRT(number)
```

**Exemplo:**
```sql
SELECT SQRT(amount) AS sqrt_amount
FROM payment
LIMIT 3;
```
**Resultado:** Retorna a raiz quadrada de `amount`.

### `PI()` - Retorna a constante matematica pi.

**Sintaxe:**
```sql
PI()
```

**Exemplo:**
```sql
SELECT PI() AS pi_value;
```
**Resultado:** Retorna o valor de pi (aproximadamente `3.141592653589793`).

### `MOD()` - Retorna o resto da divisão entre dois números.

**Sintaxe:**
```sql
MOD(dividend, divisor)
```

**Exemplo:**
```sql
SELECT MOD(payment_id, 5) AS mod_result
FROM payment
LIMIT 3;
```
**Resultado:** Retorna o resto da divisão de `payment_id` por 5.

### `SIGN()` - Retorna o sinal de um número (-1, 0 ou 1).

**Sintaxe:**
```sql
SIGN(number)
```

**Exemplo:**
```sql
SELECT SIGN(amount - 5) AS sign_value
FROM payment
LIMIT 3;
```
**Resultado:** Retorna -1 se negativo, 0 se zero e 1 se positivo.

### `GREATEST()` - Retorna o maior valor entre os valores informados (MySQL, PostgreSQL).

**Sintaxe:**
```sql
GREATEST(value1, value2, ...)
```

**Exemplo:**
```sql
SELECT GREATEST(amount, 5) AS max_value
FROM payment
LIMIT 3;
```
**Resultado:** Retorna o maior valor entre `amount` e 5.

**Importante (`NULL`):** o comportamento de `GREATEST()` depende do SGBD.
- No MySQL/MariaDB, se pelo menos um argumento for `NULL`, o resultado geralmente será `NULL`.
- No PostgreSQL, argumentos `NULL` são ignorados, e `NULL` só é retornado se todos os argumentos forem `NULL`.

### `LEAST()` - Retorna o menor valor entre os valores informados (MySQL, PostgreSQL).

**Sintaxe:**
```sql
LEAST(value1, value2, ...)
```

**Exemplo:**
```sql
SELECT LEAST(amount, 5) AS min_value
FROM payment
LIMIT 3;
```
**Resultado:** Retorna o menor valor entre `amount` e 5.

**Importante (`NULL`):** para `LEAST()`, valem as mesmas diferenças entre SGBDs descritas para `GREATEST()`.

Para tornar o comportamento previsível em consultas cross-SGBD, usa-se com frequência `COALESCE()`, por exemplo:
```sql
SELECT GREATEST(COALESCE(value1, 0), COALESCE(value2, 0));
```

### `RAND()` - Retorna um número aleatório entre 0 e 1.

**Sintaxe:**
```sql
RAND()
```

**Exemplo:**
```sql
SELECT RAND() AS random_value
FROM payment
LIMIT 3;
```
**Resultado:** Retorna um número aleatório entre 0 e 1.

**Importante:** não assuma que `RAND()` será necessariamente recalculado para cada linha em qualquer contexto. Dependendo do SGBD, plano de execução, uso de CTE/subconsultas e outros fatores, o mesmo valor aleatório pode ser reutilizado em várias linhas.

Se você precisa de valores aleatórios diferentes por linha, valide o comportamento no seu SGBD e no formato específico da consulta.

## Casos Práticos de Uso

1. **Arredondar valores de pagamento:**
   Use `ROUND(amount, 0)` para arredondar valores para inteiros.

2. **Encontrar registros por resto da divisão:**
   Use `MOD(payment_id, 2)` para separar IDs de pagamento pares e ímpares.

3. **Calcular raiz quadrada:**
   Use `SQRT(amount)` para analisar a distribuição dos pagamentos.

4. **Comparar valores:**
   Use `GREATEST()` e `LEAST()` para escolher o valor máximo ou mínimo entre vários valores.

5. **Controlar tipo de dado:**
   Se a precisão for importante, faça conversão explícita para o tipo adequado (por exemplo, `CAST(value AS DECIMAL(10,2))`) para evitar surpresas causadas por cálculo inteiro e arredondamento.

## FAQ

### Qual é a diferença entre `ROUND()`, `CEIL()` e `FLOOR()`?
`ROUND()` arredonda para o valor mais próximo (ou para a quantidade definida de casas decimais), `CEIL()` sempre arredonda para cima e `FLOOR()` sempre arredonda para baixo.

### Por que fórmulas parecidas podem retornar resultados diferentes?
O principal motivo são os tipos de dados. Tipos inteiros e decimais tratam divisão, arredondamento e precisão de forma diferente.

### Quando é melhor usar `MOD()`?
`MOD()` é útil para verificações periódicas, como separar registros em grupos ou filtrar identificadores pares/ímpares.

### Por que considerar diferenças de SGBD em `GREATEST()` e `LEAST()`?
Porque o tratamento de `NULL` pode variar entre MySQL/MariaDB e PostgreSQL. Para comportamento previsível, `COALESCE()` é frequentemente usado.

## Perguntas de entrevista

### Como escolher a função de arredondamento correta para uma regra de negócio?
Primeiro defina a regra: arredondamento comum (`ROUND`), sempre para cima (`CEIL`) ou sempre para baixo (`FLOOR`). Depois valide o impacto nos indicadores finais dos relatórios.

### Quais riscos existem em cálculos sem conversão explícita de tipo?
Podem surgir resultados inesperados por divisão inteira ou perda de precisão. Em cálculos críticos, conversões explícitas como `CAST(... AS DECIMAL(...))` são mais seguras.

### O que `SIGN()` faz e onde isso é útil?
`SIGN()` retorna `-1`, `0` ou `1` conforme o sinal do valor. Isso ajuda a classificar rapidamente desvios como negativos, nulos ou positivos.

### Por que usar `RAND()` com cuidado em consultas analíticas?
Dependendo do SGBD e do plano de execução, o valor aleatório pode não ser recalculado por linha como esperado. É importante validar esse comportamento no seu motor.

---

**Principais conclusões desta lição:**

- Funções matemáticas SQL permitem fazer cálculos e transformações diretamente na consulta.
- `ROUND`, `CEIL` e `FLOOR` atendem regras de arredondamento diferentes, conforme a necessidade do negócio.
- `MOD`, `POWER` e `SQRT` são úteis para análise e validação de dados.
- Tipos de dados influenciam fortemente a precisão e o resultado final dos cálculos.
- Em consultas cross-SGBD, é essencial considerar diferenças de comportamento com `NULL`.

Na próxima lição, vamos estudar funções de data e hora e como trabalhar com valores temporais em SQL.
