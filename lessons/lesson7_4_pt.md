---
title: "Funcoes de Janela SQL: LAG, LEAD, FIRST_VALUE e LAST_VALUE"
description: "Aprenda LAG, LEAD, FIRST_VALUE e LAST_VALUE: sintaxe, casos de uso comuns, comparacao entre linhas sem self join e a nuance importante de LAST_VALUE com frame."
keywords: ["LAG SQL", "LEAD SQL", "FIRST_VALUE SQL", "LAST_VALUE SQL", "funcoes de janela SQL", "Sakila"]
teaches: ["Usar LAG e LEAD para comparar a linha atual com linhas vizinhas", "Aplicar FIRST_VALUE e LAST_VALUE para acessar valores extremos em uma janela", "Entender como o frame de janela afeta o resultado de LAST_VALUE"]
about: ["SQL", "Window functions", "LAG", "LEAD", "FIRST_VALUE", "LAST_VALUE"]
---

_Tempo de leitura: ~9 minutos_

Esta licao apresenta as funcoes de janela `LAG`, `LEAD`, `FIRST_VALUE` e `LAST_VALUE`. Voce vai aprender como obter valores anteriores e seguintes sem `JOIN`, como encontrar o primeiro e o ultimo valor dentro de uma janela, e por que `LAST_VALUE` muitas vezes precisa de um frame explicito. Ao final da licao, voce conseguira usar essas funcoes com confianca para comparar linhas, analisar tendencias e montar relatorios analiticos.

# `LAG`, `LEAD`, `FIRST_VALUE` e `LAST_VALUE`

Na licao anterior, estudamos frames de janela e vimos como seus limites afetam os calculos. Agora vamos para as funcoes que permitem olhar para tras, para frente e para os valores extremos dentro da janela.

Essas funcoes sao especialmente uteis em analise: ajudam a comparar vendas por dia, identificar a acao anterior de um cliente, calcular variacoes em relacao a um valor anterior e encontrar o primeiro ou o ultimo registro de um grupo sem `self join`.

<img src="/images/lessons/lesson7_4-window-offsets.svg" alt="LAG LEAD FIRST_VALUE LAST_VALUE" width="100%">

## O que essas funcoes fazem

As quatro funcoes sao funcoes de janela e usam `OVER (...)`.

- `LAG` retorna um valor de uma linha anterior na janela.
- `LEAD` retorna um valor de uma linha seguinte na janela.
- `FIRST_VALUE` retorna o primeiro valor na janela atual.
- `LAST_VALUE` retorna o ultimo valor na janela atual.

A ideia principal e simples: a linha atual permanece no lugar, mas ganha acesso a valores de outras linhas na mesma particao.

## Sintaxe basica

### `LAG` e `LEAD`

```sql
LAG(expression [, offset [, default_value]]) OVER (
    [PARTITION BY ...]
    ORDER BY ...
)

LEAD(expression [, offset [, default_value]]) OVER (
    [PARTITION BY ...]
    ORDER BY ...
)
```

- `expression` e o valor que voce quer obter de outra linha.
- `offset` define quantas linhas retroceder ou avancar.
- `default_value` define o que retornar se essa linha nao existir.

### `FIRST_VALUE` e `LAST_VALUE`

```sql
FIRST_VALUE(expression) OVER (
    [PARTITION BY ...]
    ORDER BY ...
    [frame_clause]
)

LAST_VALUE(expression) OVER (
    [PARTITION BY ...]
    ORDER BY ...
    [frame_clause]
)
```

Para `FIRST_VALUE` e principalmente `LAST_VALUE`, o frame da janela importa. Sem um frame explicito, `LAST_VALUE` frequentemente produz um resultado diferente do que iniciantes esperam.

---

## Usando `LAG`

`LAG` e util quando voce precisa comparar a linha atual com a anterior.

### Pagamento anterior de um cliente

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LAG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS previous_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultado: cada linha mostra o pagamento atual e o valor do pagamento anterior do mesmo cliente.*

### Diferenca em relacao ao pagamento anterior

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    amount - LAG(amount, 1, 0) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS amount_diff
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultado: voce pode ver quanto o pagamento atual difere do anterior. Para a primeira linha, `0` e usado como valor padrao.*

---

## Usando `LEAD`

`LEAD` funciona de forma simetrica, mas olha para frente.

### Proximo pagamento de um cliente

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LEAD(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS next_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultado: cada linha mostra o valor do proximo pagamento desse cliente.*

### Proxima data de locacao

```sql
SELECT
    customer_id,
    rental_date,
    LEAD(rental_date) OVER (
        PARTITION BY customer_id
        ORDER BY rental_date
    ) AS next_rental_date
FROM rental
WHERE customer_id = 1
ORDER BY rental_date;
```

*Resultado: a consulta mostra quando o mesmo cliente fara a locacao seguinte.*

---

## Usando `FIRST_VALUE`

`FIRST_VALUE` retorna o primeiro valor da janela. Isso e util quando voce quer comparar a linha atual com um ponto inicial.

### Primeiro pagamento de um cliente

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    FIRST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_payment_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultado: o valor do primeiro pagamento do cliente se repete em cada linha da janela.*

### Comparando o pagamento atual com o primeiro

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    amount - FIRST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS diff_from_first
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultado: isso ajuda a medir o quanto os valores atuais se afastam do primeiro valor da sequencia.*

---

## Usando `LAST_VALUE`

`LAST_VALUE` parece simples, mas e aqui que as expectativas costumam falhar.

### Nuance importante: o frame padrao

Se voce escrever isto:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LAST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS last_amount_default
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

em muitos SGBDs o resultado nao sera o ultimo valor da particao inteira, mas o valor no final do frame atual. Em muitos casos, isso significa a propria linha atual.

### Versao correta para o ultimo valor da particao

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LAST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_payment_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultado: agora cada linha consegue ver o valor do ultimo pagamento do cliente em toda a particao.*

### Por que isso e util

Esse padrao e conveniente quando voce precisa comparar um valor atual com o ultimo valor conhecido de uma serie, o status final de um pedido ou o ultimo pagamento feito por um cliente.

---

## Comparando `LAG`, `LEAD`, `FIRST_VALUE` e `LAST_VALUE`

| Funcao | O que retorna | Caso de uso tipico |
|---|---|---|
| `LAG` | Valor de uma linha anterior | Comparacao com um valor passado |
| `LEAD` | Valor de uma linha seguinte | Preparacao para o proximo passo ou data |
| `FIRST_VALUE` | Primeiro valor na janela | Valor-base para comparacao |
| `LAST_VALUE` | Ultimo valor na janela | Valor final em uma sequencia |

Se a tarefa envolve comparar linhas vizinhas, `LAG` e `LEAD` costumam ser as melhores escolhas. Se voce precisa de um ponto de referencia no inicio ou no fim da janela, use `FIRST_VALUE` e `LAST_VALUE`.

---

## Exemplo pratico: receita por dia e comparacao com dias vizinhos

Primeiro, agregamos os pagamentos por dia e depois aplicamos funcoes de janela ao resultado agregado:

```sql
SELECT
    pay_day,
    daily_total,
    LAG(daily_total) OVER (ORDER BY pay_day) AS previous_day_total,
    LEAD(daily_total) OVER (ORDER BY pay_day) AS next_day_total,
    FIRST_VALUE(daily_total) OVER (
        ORDER BY pay_day
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_day_total,
    LAST_VALUE(daily_total) OVER (
        ORDER BY pay_day
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_day_total
FROM (
    SELECT
        DATE(payment_date) AS pay_day,
        SUM(amount) AS daily_total
    FROM payment
    GROUP BY DATE(payment_date)
) AS daily_stats
ORDER BY pay_day;
```

*Resultado: cada data passa a ter acesso a receita do dia anterior, do dia seguinte e tambem aos primeiros e ultimos valores de toda a sequencia.*

Esse e um bom modelo para analise de series temporais, preparacao de dashboards e identificacao de desvios de tendencia.

---

## Perguntas Frequentes

### Qual e a diferenca entre `LAG` e `LEAD`?
`LAG` olha para tras e retorna um valor de uma linha anterior, enquanto `LEAD` olha para frente e retorna um valor de uma linha seguinte. Ambas funcionam dentro da janela definida e da ordenacao especificada.

### Por que `LAST_VALUE` muitas vezes retorna a linha atual?
Porque o resultado depende do frame da janela. Se voce mantiver o frame padrao, a ultima linha do frame pode ser a linha atual. Para obter o ultimo valor de toda a particao, geralmente e necessario escrever `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`.

### Posso usar `LAG` e `LEAD` sem `PARTITION BY`?
Sim. Nesse caso, a funcao trabalha sobre todo o conjunto de resultados como se fosse uma unica particao. Isso e util quando voce precisa analisar uma sequencia geral sem separa-la em grupos.

---

## Perguntas de Entrevista

### Quando devo usar `LAG` e quando devo usar `LEAD`?
Use `LAG` quando precisar comparar a linha atual com a anterior, por exemplo para encontrar a variacao em relacao ao pagamento anterior. Use `LEAD` quando precisar olhar para frente, por exemplo para obter a proxima data de evento ou o proximo valor de uma metrica.

### Como `FIRST_VALUE` difere de `MIN`?
`MIN` retorna o menor valor em um conjunto de linhas, enquanto `FIRST_VALUE` retorna o valor da primeira linha de acordo com a ordenacao definida. Se a ordenacao nao coincidir com o menor valor, os resultados serao diferentes.

### Por que `LAST_VALUE` frequentemente exige um frame explicito?
Porque `LAST_VALUE` nao significa "a ultima linha da particao em qualquer caso". Significa a ultima linha do frame atual. Se o frame padrao termina na linha atual, a funcao retorna o valor atual. Um frame explicito amplia a janela para toda a particao.

---

**Principais conclusoes desta licao:**

- `LAG` e `LEAD` permitem acessar linhas vizinhas sem `self join`.
- `FIRST_VALUE` e `LAST_VALUE` retornam valores extremos dentro da janela, e nao apenas o minimo ou o maximo.
- Para todas essas funcoes, a clausula `ORDER BY` e critica porque define a sequencia das linhas.
- `LAST_VALUE` frequentemente exige o frame explicito `UNBOUNDED PRECEDING ... UNBOUNDED FOLLOWING`.
- Essas funcoes sao especialmente uteis para analise de sequencias, series temporais e deteccao de mudancas entre linhas.

Na proxima licao, vamos aplicar funcoes de janela a totais acumulados e medias moveis.
