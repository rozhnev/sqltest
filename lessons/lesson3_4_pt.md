# Aula 3.4: Funções Matemáticas Comuns em SQL

As funções matemáticas em SQL são usadas para realizar vários cálculos com dados numéricos. Elas permitem arredondar valores, encontrar valores mínimos e máximos, calcular somas, médias, restos e muito mais. Esta aula aborda as funções matemáticas mais utilizadas com exemplos baseados no banco de dados Sakila.

## Funções Matemáticas Comuns

### `ABS()` — Retorna o valor absoluto de um número.

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
**Resultado:** Retorna a diferença absoluta entre o valor de `amount` e 5.

### `CEIL()` / `CEILING()` — Arredonda um número para cima até o inteiro mais próximo.

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
**Resultado:** Arredonda o valor de `amount` para cima até o inteiro mais próximo.

### `FLOOR()` — Arredonda um número para baixo até o inteiro mais próximo.

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
**Resultado:** Arredonda o valor de `amount` para baixo até o inteiro mais próximo.

### `ROUND()` — Arredonda um número para o número especificado de casas decimais.

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
**Resultado:** Arredonda o valor de `amount` para uma casa decimal.

### `POWER()` / `POW()` — Eleva um número a uma potência.

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
**Resultado:** Eleva o valor de `amount` ao quadrado.

### `SQRT()` — Retorna a raiz quadrada de um número.

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
**Resultado:** Retorna a raiz quadrada do valor de `amount`.

### `MOD()` — Retorna o resto da divisão de um número por outro.

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

### `SIGN()` — Retorna o sinal de um número (-1, 0 ou 1).

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
**Resultado:** Retorna -1 se a diferença for negativa, 0 se for zero, 1 se for positiva.

### `GREATEST()` — Retorna o maior dos valores fornecidos (MySQL, PostgreSQL).

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
**Resultado:** Retorna o maior dos dois valores: `amount` ou 5.

### `LEAST()` — Retorna o menor dos valores fornecidos (MySQL, PostgreSQL).

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
**Resultado:** Retorna o menor dos dois valores: `amount` ou 5.

### `RAND()` — Retorna um número aleatório entre 0 e 1.

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
**Resultado:** Retorna um número aleatório para cada linha.

## Aplicações Práticas

1. **Arredondar valores de pagamento:**
   Use `ROUND(amount, 0)` para arredondar o valor para o inteiro mais próximo.

2. **Encontrar pagamentos com resto:**
   Use `MOD(payment_id, 2)` para encontrar pagamentos pares e ímpares.

3. **Calcular raízes quadradas:**
   Use `SQRT(amount)` para analisar a distribuição dos pagamentos.

4. **Comparar valores:**
   Use `GREATEST()` e `LEAST()` para selecionar o valor máximo ou mínimo de várias colunas.

## Principais Conclusões desta Aula

As funções matemáticas do SQL permitem realizar cálculos, analisar e transformar dados numéricos. Domine essas funções para trabalhar de forma eficaz com números em suas consultas SQL. Pratique com exemplos do banco de dados Sakila para reforçar seus conhecimentos.
