# Lição 3.3: Funções Matemáticas Essenciais no SQL

As funções matemáticas no SQL são usadas para realizar diferentes cálculos sobre dados numéricos. Elas permitem arredondar valores, encontrar valores mínimos e máximos, calcular restos de divisão e muito mais. Nesta lição, são apresentadas as funções matemáticas mais usadas, com exemplos na base de dados Sakila.

Importante: dados numéricos em SQL podem ter tipos diferentes (`INTEGER`, `REAL`/`FLOAT`, `DECIMAL`/`NUMERIC`). A mesma fórmula pode gerar resultados diferentes dependendo do tipo de dado (por exemplo, por causa de divisão inteira, arredondamento e precisão). Se o tipo não for considerado, o resultado final pode ser diferente do esperado.

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

## Principais Conclusões desta Lição

As funções matemáticas do SQL permitem calcular, analisar e transformar dados numéricos. Domine essas funções para trabalhar com números com eficiência em consultas SQL. Pratique com exemplos baseados em Sakila para consolidar as habilidades.
