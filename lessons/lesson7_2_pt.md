---
title: "Funções de Classificação SQL: Tutorial ROW_NUMBER vs RANK vs DENSE_RANK vs NTILE"
description: "Domine funções de classificação SQL: ROW_NUMBER, RANK, DENSE_RANK, NTILE. Aprenda as diferenças e quando usar cada função com exemplos práticos MySQL. Guia completo para análise de dados."
keywords: "funções classificação SQL, ROW_NUMBER, RANK, DENSE_RANK, NTILE, funções janela SQL, tutorial SQL, classificação dados, SQL analítico, classificação MySQL"
lang: "pt"
region: "BR, PT, AO, MZ"
---

# Lição 7.2: Usar ROW_NUMBER, RANK, DENSE_RANK e NTILE

Na lição anterior, apresentamos funções de janela e exploramos `ROW_NUMBER()`. Agora vamos aprofundar a família de funções de classificação que SQL oferece: `ROW_NUMBER`, `RANK`, `DENSE_RANK` e `NTILE`. Cada uma tem um propósito distinto e entender quando usar cada uma é crucial para análise de dados eficaz.

## Compreender as Diferenças

As quatro funções atribuem um valor numérico às linhas com base na ordenação, mas lidam com empates (valores idênticos) de forma diferente. Vamos explorar cada uma.

### ROW_NUMBER(): Números Sequenciais Únicos

`ROW_NUMBER()` atribui um número sequencial único a cada linha, mesmo se os valores forem idênticos. Ela trata empates como linhas diferentes.

**Sintaxe:**
```sql
ROW_NUMBER() OVER (
    [PARTITION BY expressao_particao]
    ORDER BY expressao_ordenacao
)
```

**Exemplo: Classificar Transações**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Exemplo de Resultado:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ponto-chave:** Embora os primeiros dois pagamentos do cliente 1 tenham montantes idênticos (11.99), eles recebem números de linha diferentes (1 e 2).

### RANK(): Classificação com Lacunas

`RANK()` atribui o mesmo classificação de linhas com valores de ordenação idênticos, mas deixa lacunas na sequência de numeração. Se duas linhas empatarem na classificação 1, o próximo é 3 (pulando 2).

**Sintaxe:**
```sql
RANK() OVER (
    [PARTITION BY expressao_particao]
    ORDER BY expressao_ordenacao
)
```

**Exemplo: Classificar Pagamentos por Valor**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    RANK() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Exemplo de Resultado:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ponto-chave:** Ambos os pagamentos do cliente 1 de 11.99 recebem classificação 1, e o próximo pagamento recebe classificação 3 (não 2). Isso é útil quando você quer identificar empates mas preservar a posição de classificação no conjunto de dados completo.

### DENSE_RANK(): Classificação sem Lacunas

`DENSE_RANK()` é semelhante a `RANK()` mas não pula números. Se duas linhas empatarem na classificação 1, o próximo é 2 (não 3).

**Sintaxe:**
```sql
DENSE_RANK() OVER (
    [PARTITION BY expressao_particao]
    ORDER BY expressao_ordenacao
)
```

**Exemplo: Classificação Densa de Montantes de Pagamento**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    DENSE_RANK() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Exemplo de Resultado:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 2
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ponto-chave:** Ambos os pagamentos do cliente 1 de 11.99 recebem classificação 1, e o próximo montante distinto recebe classificação 2. Sem lacunas na sequência de classificação. Isso é ideal quando você quer identificar grupos distintos sem lacunas.

### NTILE(): Distribuindo Linhas em Grupos

`NTILE(n)` divide a partição em n grupos (baldes) e atribui a cada linha um número de balde. Isso é útil para análise de percentil e agrupamento de dados em quartis, etc.

**Sintaxe:**
```sql
NTILE(numero_de_baldes) OVER (
    [PARTITION BY expressao_particao]
    ORDER BY expressao_ordenacao
)
```

**Exemplo: Análise de Quartil**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    NTILE(4) OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS quartile
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    quartile;
```

**Exemplo de Resultado:**
```
customer_id | amount | payment_date | quartile
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ponto-chave:** As linhas são distribuídas em 4 quartis. Isso é extremamente útil para análise de percentil—identificando top 25% (quartil 1), próximos 25% (quartil 2), etc.

## Comparação Lado a Lado

Vamos ver as quatro funções aplicadas aos mesmos dados:

```sql
SELECT
    customer_id,
    amount,
    row_number() OVER (ORDER BY amount DESC) AS row_num,
    rank() OVER (ORDER BY amount DESC) AS rnk,
    dense_rank() OVER (ORDER BY amount DESC) AS dense_rnk,
    ntile(3) OVER (ORDER BY amount DESC) AS tertile
FROM
    payment
LIMIT 10;
```

**Exemplo de Resultado:**
```
customer_id | amount | row_num | rnk | dense_rnk | tertile
1           | 11.99  | 1       | 1   | 1         | 1
1           | 11.99  | 2       | 1   | 1         | 1
2           | 11.99  | 3       | 1   | 1         | 1
5           | 10.99  | 4       | 4   | 2         | 1
6           | 10.99  | 5       | 4   | 2         | 1
3           | 9.99   | 6       | 6   | 3         | 2
4           | 9.99   | 7       | 6   | 3         | 2
7           | 8.99   | 8       | 8   | 4         | 3
8           | 8.99   | 9       | 8   | 4         | 3
9           | 7.99   | 10      | 10  | 5         | 3
```

**Observações:**
- `row_number`: Sempre único, sem lacunas
- `rank`: Agrupa empates mas cria lacunas (1, 1, 1, 4, 4, 6, 6, 8, 8, 10)
- `dense_rank`: Agrupa empates sem lacunas (1, 1, 1, 2, 2, 3, 3, 4, 4, 5)
- `ntile(3)`: Distribui em 3 grupos com base na ordenação

## Aplicações Práticas

### Encontrar Melhores Performers (ROW_NUMBER)

Obter o cliente com maior pagamento por mês de aluguel:

```sql
WITH ranked_payments AS (
    SELECT
        customer_id,
        amount,
        DATE_TRUNC('month', payment_date) AS month,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_TRUNC('month', payment_date)
            ORDER BY amount DESC
        ) AS rank
    FROM
        payment
)
SELECT
    customer_id,
    amount,
    month
FROM
    ranked_payments
WHERE
    rank = 1
ORDER BY
    month DESC;
```

### Identificar Níveis de Performance (DENSE_RANK)

Categorizar filmes por frequência de aluguel:

```sql
WITH rental_counts AS (
    SELECT
        film_id,
        COUNT(*) AS rental_count,
        DENSE_RANK() OVER (
            ORDER BY COUNT(*) DESC
        ) AS popularity_tier
    FROM
        rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
    GROUP BY
        film_id
)
SELECT
    film_id,
    rental_count,
    CASE
        WHEN popularity_tier = 1 THEN 'Blockbuster'
        WHEN popularity_tier <= 3 THEN 'Popular'
        WHEN popularity_tier <= 10 THEN 'Padrão'
        ELSE 'Nicho'
    END AS popularity_category
FROM
    rental_counts
LIMIT 20;
```

### Análise de Percentil (NTILE)

Segmentar clientes em quartis de gastos:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        NTILE(4) OVER (ORDER BY SUM(amount)) AS spending_quartile
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    spending_quartile,
    COUNT(*) AS customer_count,
    MIN(total_spent) AS low_amount,
    MAX(total_spent) AS high_amount
FROM
    customer_spending
GROUP BY
    spending_quartile
ORDER BY
    spending_quartile;
```

## Quando Usar Cada Função

| Função | Caso de Uso | Lida com Empates |
|--------|-------------|------------------|
| `ROW_NUMBER` | Precisa de números sequenciais únicos; não se importa com empates | Não (todos únicos) |
| `RANK` | Precisa identificar posição mas levar em conta empates; lacunas são OK | Sim (com lacunas) |
| `DENSE_RANK` | Precisa de identificação de nível sem lacunas de posição | Sim (sem lacunas) |
| `NTILE` | Precisa de análise de percentil/quartil/grupo | Distribui em grupos |

## Pontos-Chave a Lembrar

- **ROW_NUMBER()** fornece a cada linha um número único, útil para obter os N melhores registros de cada grupo.
- **RANK()** atribui a mesma classificação aos valores empatados, mas pula classificações (1, 1, 3), útil para rankings competitivos.
- **DENSE_RANK()** atribui a mesma classificação aos valores empatados sem lacunas (1, 1, 2), útil para identificação de nível.
- **NTILE(n)** divide linhas em baldes para análise de percentil e distribucional.
- Todas as quatro funções fazem parte da família de funções de janela e usam a cláusula `OVER`.
- A diferença chave é como elas lidam com valores idênticos na coluna de ordenação.
- Escolher a função correta depende do seu objetivo analítico: posicionamento, agrupamento ou distribuição.

Na próxima lição, exploraremos conceitos avançados de funções de janela, incluindo quadros de janela, estratégias de particionamento e outras funções analíticas como `LAG`, `LEAD`, `FIRST_VALUE` e `LAST_VALUE`.
