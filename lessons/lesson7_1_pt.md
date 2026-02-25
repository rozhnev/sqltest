---
title: "Tutorial Funções de Janela SQL: Domine Análise Avançada com ROW_NUMBER & PARTITION BY"
description: "Aprenda funções de janela SQL para análise avançada. Domine ROW_NUMBER(), RANK(), PARTITION BY e cláusula OVER com exemplos práticos MySQL. Guia completo para analistas de dados e desenvolvedores SQL."
keywords: "funções janela SQL, ROW_NUMBER SQL, PARTITION BY, cláusula OVER, análise SQL, tutorial SQL avançado, análise dados SQL, MySQL funções janela, PostgreSQL análise, funções classificação SQL"
lang: "pt"
region: "BR, PT, AO, MZ"
---

# Lição 7.1: Funções de Janela para Análise Avançada de Dados

As funções de janela são um dos recursos mais poderosos do SQL para realizar cálculos analíticos complexos. Ao contrário das funções de agregação que consolidam várias linhas em um único resultado, as funções de janela permitem realizar cálculos em um conjunto de linhas relacionadas à linha atual—mantendo todas as linhas individuais no conjunto de resultados.

Esta lição apresenta os conceitos fundamentais das funções de janela e demonstra como elas podem transformar suas capacidades de análise de dados.

## O que são Funções de Janela?

Uma **função de janela** realiza um cálculo em um conjunto de linhas de tabela que estão de alguma forma relacionadas à linha atual. Este conjunto de linhas é chamado de "janela" ou "quadro de janela". A principal diferença em relação às funções de agregação regulares é que as funções de janela **não** fazem com que as linhas sejam agrupadas em uma única linha de saída—cada linha mantém sua identidade.

Pense nisso como olhar através de uma janela em movimento enquanto você percorre seus dados. Para cada linha, você pode ver e calcular valores com base nas linhas relacionadas ao seu redor, mas cada linha ainda aparece separadamente no resultado.

**Características principais:**
- Funções de janela operam em um conjunto de linhas definido pela cláusula `OVER`
- Elas retornam um valor para **cada** linha no conjunto de resultados
- Elas não reduzem o número de linhas retornadas pela consulta
- Elas podem ser usadas para classificação, agregação e operações analíticas

## Sintaxe Básica

A sintaxe geral para uma função de janela é:

```sql
nome_funcao_janela(expressao) OVER (
    [PARTITION BY expressao_particao]
    [ORDER BY expressao_ordenacao]
    [clausula_quadro_janela]
)
```

**Componentes:**
- **nome_funcao_janela**: A função a ser aplicada (por exemplo, `ROW_NUMBER`, `SUM`, `AVG`)
- **Cláusula OVER**: Define a janela de linhas para a função
- **PARTITION BY** (opcional): Divide o conjunto de resultados em partições (grupos)
- **ORDER BY** (opcional): Define a ordem das linhas dentro de cada partição
- **clausula_quadro_janela** (opcional): Refina ainda mais quais linhas são incluídas na janela

## Sua Primeira Função de Janela: ROW_NUMBER()

Vamos começar com uma das funções de janela mais comumente usadas: `ROW_NUMBER()`. Esta função atribui um número sequencial único a cada linha dentro de uma partição.

### Exemplo 1: Numerando Todos os Pagamentos

```sql
SELECT
    payment_id,
    customer_id,
    amount,
    payment_date,
    ROW_NUMBER() OVER (ORDER BY payment_date) AS row_num
FROM
    payment
LIMIT 10;
```

Esta consulta atribui um número sequencial a cada pagamento ordenado por data de pagamento. A cláusula `OVER (ORDER BY payment_date)` informa ao SQL para:
1. Ordenar todas as linhas por `payment_date`
2. Atribuir números de linha começando de 1

### Exemplo 2: Numerando Dentro de Grupos Usando PARTITION BY

O verdadeiro poder das funções de janela vem quando você usa `PARTITION BY` para criar janelas separadas para grupos diferentes:

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY payment_date
    ) AS payment_number
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id, 
    payment_date;
```

Aqui está o que acontece:
- `PARTITION BY customer_id` cria uma janela separada para cada cliente
- Dentro da janela de cada cliente, as linhas são ordenadas por `payment_date`
- `ROW_NUMBER()` começa a contar a partir de 1 para cada novo cliente
- Isso permite que você veja o 1º, 2º, 3º pagamento de cada cliente

**Visualização:**
```
Cliente 1:      Cliente 2:      Cliente 3:
Linha 1 ----\   Linha 1 ----\   Linha 1 ----\
Linha 2 -----\  Linha 2 -----\  Linha 2 -----\
Linha 3 ------\ Linha 3 ------\ Linha 3 ------\
   ...             ...             ...
```

*Cada cliente tem sua própria numeração de linhas independente.*

## Aplicações Práticas

### Encontrando a Transação Mais Recente

As funções de janela facilitam a identificação do registro mais recente em cada grupo:

```sql
WITH numbered_payments AS (
    SELECT
        customer_id,
        amount,
        payment_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY payment_date DESC
        ) AS recency_rank
    FROM
        payment
)
SELECT
    customer_id,
    amount,
    payment_date
FROM
    numbered_payments
WHERE
    recency_rank = 1
ORDER BY
    customer_id
LIMIT 10;
```

Esta consulta encontra o pagamento mais recente para cada cliente:
1. Numerando os pagamentos para cada cliente em ordem decrescente de data
2. Filtrando para `recency_rank = 1` (o mais recente)

### Comparando Cada Linha com Valores Agregados

As funções de janela também podem realizar agregações mantendo as linhas individuais:

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    SUM(amount) OVER (PARTITION BY customer_id) AS total_spent,
    AVG(amount) OVER (PARTITION BY customer_id) AS avg_payment,
    amount - AVG(amount) OVER (PARTITION BY customer_id) AS diff_from_avg
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_date;
```

Para cada pagamento, esta consulta mostra:
- O valor do pagamento individual
- O valor total que este cliente gastou (em todos os seus pagamentos)
- O valor médio de pagamento para este cliente
- Quanto este pagamento específico difere da sua média

Note como as funções de agregação regulares exigiriam um `GROUP BY` e consolidariam as linhas, mas as funções de janela permitem que você mantenha todos os detalhes enquanto adiciona contexto agregado.

## Funções de Janela vs GROUP BY

É importante entender a diferença:

**GROUP BY (Funções de Agregação):**
```sql
SELECT
    customer_id,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_amount
FROM
    payment
GROUP BY
    customer_id;
```
Resultado: Uma linha por cliente

**Funções de Janela:**
```sql
SELECT
    customer_id,
    payment_id,
    amount,
    COUNT(*) OVER (PARTITION BY customer_id) AS payment_count,
    SUM(amount) OVER (PARTITION BY customer_id) AS total_amount
FROM
    payment;
```
Resultado: Cada linha de pagamento preservada, com valores agregados adicionados como colunas adicionais

## Pontos-Chave

- As **funções de janela** realizam cálculos em linhas relacionadas mantendo todas as linhas individuais no conjunto de resultados.
- A **cláusula OVER** é essencial e define a janela de linhas para a função operar.
- **PARTITION BY** divide os dados em grupos, com a função de janela aplicada separadamente a cada grupo.
- **ORDER BY** dentro da cláusula OVER determina a ordem das linhas para a função (crucial para funções como `ROW_NUMBER()`).
- As funções de janela são perfeitas para classificação, totais acumulados, médias móveis e comparação de valores individuais com agregados de grupo.
- Ao contrário do `GROUP BY`, as funções de janela **não consolidam** linhas—elas adicionam colunas calculadas aos seus dados existentes.

Nas próximas lições, exploraremos mais funções de janela como `RANK()`, `DENSE_RANK()`, `NTILE()`, e mergulharemos mais profundamente em quadros de janela e cálculos analíticos avançados.
