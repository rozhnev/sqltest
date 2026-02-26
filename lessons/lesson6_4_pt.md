---
title: "Expressões de Tabelas Comuns SQL (CTE): Tutorial Cláusula WITH e Exemplos"
description: "Domine expressões de tabelas comuns SQL (CTE). Aprenda a sintaxe da cláusula WITH, vantagens sobre subconsultas e exemplos práticos. Guia completo para escrever consultas SQL mais limpas e facilitadas de manutenção."
keywords: "SQL CTE, expressão tabela comum, cláusula WITH SQL, alternativa subconsulta SQL, legibilidade consulta, tutoriel SQL, SQL avançado, MySQL CTE, PostgreSQL CTE"
lang: "pt"
region: "BR, PT, AO, MZ"
---

# Lição 6.4: Expressões de Tabelas Comuns (CTE)

As expressões de tabelas comuns, ou CTE, são uma das funcionalidades mais poderosas e subutilizadas do SQL. Elas permitem que você defina conjuntos de resultados temporários nomeados que podem ser referenciados em uma consulta maior. Nesta lição, exploraremos como as CTE podem tornar seu código SQL mais legível, mantível e mais fácil de depurar.

## O que são CTE?

Uma **expressão de tabela comum (CTE)** é um conjunto de resultados temporário definido no início de uma consulta usando a cláusula `WITH`. Pense nela como uma subconsulta nomeada que pode ser usada várias vezes na mesma consulta.

As principais vantagens das CTE:
- **Legibilidade**: Conjuntos de resultados nomeados tornam as consultas mais fáceis de entender
- **Reutilização**: Referencie o mesmo CTE várias vezes sem redefinir
- **Modularidade**: Decomponha consultas complexas em pedaços lógicos gerenciáveis
- **Manutenibilidade**: Mudanças na lógica precisam ser feitas apenas em um lugar
- **Depuração**: Teste cada CTE independentemente antes de combiná-los

## Sintaxe Básica de CTE

A sintaxe geral de uma CTE é:

```sql
WITH nome_cte AS (
    SELECT ...
)
SELECT * FROM nome_cte;
```

**Componentes:**
- **WITH**: Palavra-chave que introduz a CTE
- **nome_cte**: O nome que você dá ao conjunto de resultados temporário
- **AS**: Palavra-chave introduzindo a definição da consulta
- **(SELECT ...)**: A consulta que define a CTE
- A consulta principal pode então referenciar a CTE pelo nome

## Seu Primeiro CTE

Vamos começar com um exemplo simples que calcula o gasto dos clientes:

```sql
WITH gasto_cliente AS (
    SELECT
        customer_id,
        SUM(amount) AS total_gasto,
        COUNT(*) AS contagem_pagamentos,
        AVG(amount) AS pagamento_médio
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_gasto,
    contagem_pagamentos,
    pagamento_médio
FROM
    gasto_cliente
WHERE
    total_gasto > 100
ORDER BY
    total_gasto DESC;
```

Este CTE:
1. Define um conjunto de resultados nomeado chamado `gasto_cliente`
2. Calcula as métricas de gasto para cada cliente
3. Referencia este CTE na consulta principal para filtrar clientes que gastam muito

O benefício aqui é a clareza—a intenção é óbvia: estamos trabalhando com dados de gasto de clientes.

## CTE vs Subconsultas

Comparemos a mesma lógica usando uma abordagem tradicional de subconsulta:

**Usando uma subconsulta:**
```sql
SELECT
    customer_id,
    total_gasto,
    contagem_pagamentos,
    pagamento_médio
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_gasto,
        COUNT(*) AS contagem_pagamentos,
        AVG(amount) AS pagamento_médio
    FROM
        payment
    GROUP BY
        customer_id
) AS dados_gasto
WHERE
    total_gasto > 100
ORDER BY
    total_gasto DESC;
```

**Usando um CTE:**
```sql
WITH gasto_cliente AS (
    SELECT
        customer_id,
        SUM(amount) AS total_gasto,
        COUNT(*) AS contagem_pagamentos,
        AVG(amount) AS pagamento_médio
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_gasto,
    contagem_pagamentos,
    pagamento_médio
FROM
    gasto_cliente
WHERE
    total_gasto > 100
ORDER BY
    total_gasto DESC;
```

**Diferenças Principais:**
- O CTE é definido no topo, tornando a estrutura da consulta imediatamente clara
- O CTE tem um nome significativo (`gasto_cliente`), não apenas uma subconsulta anônima
- A intenção da consulta principal é visível antes de mergulhar em transformações de dados
- Se você precisasse referenciar este conjunto de resultados várias vezes, você o define apenas uma vez com um CTE

## Múltiplas CTE em Uma Consulta

Você pode definir múltiplas CTE em uma única consulta, cada uma referenciando as anteriores:

```sql
WITH gasto_cliente AS (
    SELECT
        customer_id,
        SUM(amount) AS total_gasto
    FROM
        payment
    GROUP BY
        customer_id
),
grandes_gastos AS (
    SELECT
        customer_id,
        total_gasto
    FROM
        gasto_cliente
    WHERE
        total_gasto > 150
),
detalhes_cliente AS (
    SELECT
        gg.customer_id,
        gg.total_gasto,
        c.first_name,
        c.last_name,
        c.email
    FROM
        grandes_gastos gg
    JOIN
        customer c ON gg.customer_id = c.customer_id
)
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS nome_cliente,
    email,
    total_gasto
FROM
    detalhes_cliente
ORDER BY
    total_gasto DESC;
```

Nesta consulta:
1. `gasto_cliente` calcula o total gasto por cliente
2. `grandes_gastos` filtra clientes com total gasto > 150
3. `detalhes_cliente` une grandes gastos com informações do cliente
4. A consulta principal seleciona e formata os resultados finais

Esta estrutura torna o fluxo lógico claro e fácil de seguir.

## Reutilização de CTE

Um aspecto poderoso dos CTE é referenciar-se múltiplas vezes:

```sql
WITH vendas_mensais AS (
    SELECT
        DATE_TRUNC('month', payment_date) AS mês,
        SUM(amount) AS total_mensal
    FROM
        payment
    GROUP BY
        DATE_TRUNC('month', payment_date)
)
SELECT
    m1.mês AS mês_atual,
    m1.total_mensal AS vendas_atuais,
    m2.total_mensal AS vendas_mês_anterior,
    ROUND(((m1.total_mensal - m2.total_mensal) / m2.total_mensal * 100), 2) AS percentual_mudança
FROM
    vendas_mensais m1
LEFT JOIN
    vendas_mensais m2 ON m1.mês = m2.mês + INTERVAL '1 month'
WHERE
    m1.mês IS NOT NULL
ORDER BY
    m1.mês;
```

Aqui, referenciamos `vendas_mensais` duas vezes—uma como `m1` e outra como `m2`. Isso exigiria duas subconsultas separadas se não estivéssemos usando um CTE.

## CTE com Funções de Janela

Os CTE funcionam lindamente com funções de janela:

```sql
WITH aluguel_classificado AS (
    SELECT
        customer_id,
        rental_date,
        return_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY rental_date DESC
        ) AS classificação_aluguel
    FROM
        rental
),
aluguel_recente AS (
    SELECT
        customer_id,
        rental_date,
        return_date
    FROM
        aluguel_classificado
    WHERE
        classificação_aluguel = 1
)
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS nome_cliente,
    ar.rental_date AS data_ultimo_aluguel,
    DATEDIFF(CURDATE(), ar.rental_date) AS dias_desde_aluguel
FROM
    customer c
LEFT JOIN
    aluguel_recente ar ON c.customer_id = ar.customer_id
ORDER BY
    dias_desde_aluguel DESC
LIMIT 20;
```

Esta consulta:
1. Usa `ROW_NUMBER()` para identificar o aluguel mais recente de cada cliente
2. Filtra para obter apenas o aluguel mais recente por cliente
3. Une com a tabela cliente para mostrar nomes de clientes e calcular dias desde o aluguel

A estrutura modular torna fácil entender e modificar.

## Exemplo Prático: Análise de Coorte

Os CTE são excelentes para consultas analíticas complexas como análise de coorte:

```sql
WITH primeiro_aluguel_cliente AS (
    SELECT
        customer_id,
        MIN(rental_date) AS data_primeiro_aluguel,
        DATE_TRUNC('month', MIN(rental_date)) AS mês_coorte
    FROM
        rental
    GROUP BY
        customer_id
),
historico_aluguel_cliente AS (
    SELECT
        fac.customer_id,
        fac.mês_coorte,
        DATE_TRUNC('month', r.rental_date) AS mês_aluguel,
        COUNT(*) AS alugueis_do_mês
    FROM
        primeiro_aluguel_cliente fac
    JOIN
        rental r ON fac.customer_id = r.customer_id
    GROUP BY
        fac.customer_id,
        fac.mês_coorte,
        DATE_TRUNC('month', r.rental_date)
)
SELECT
    mês_coorte,
    mês_aluguel,
    COUNT(DISTINCT customer_id) AS clientes,
    SUM(alugueis_do_mês) AS total_alugueis
FROM
    historico_aluguel_cliente
GROUP BY
    mês_coorte,
    mês_aluguel
ORDER BY
    mês_coorte,
    mês_aluguel;
```

Esta análise complexa torna-se gerenciável através de CTEs:
1. Primeiro CTE identifica a coorte de cada cliente (mês de primeiro aluguel)
2. Segundo CTE constrói um histórico de todos os aluguéis com informações de coorte
3. Consulta final agrega para mostrar desempenho de coorte ao longo do tempo

## Resumo de Benefícios

| Aspecto | CTE | Subconsulta |
|---------|-----|------------|
| Legibilidade | Altamente legível com conjuntos nomeados | Pode ser difícil de ler (estruturas aninhadas) |
| Reutilização | Fácil referenciar múltiplas vezes | Deve ser redefinido para cada uso |
| Depuração | Pode testar cada CTE independentemente | Difícil isolar lógica específica |
| Organização | Estrutura lógica, de cima para baixo | Linear mas às vezes confuso |
| Performance | Mesmo ou melhor (dependente do otimizador) | Pode ser menos eficiente com aninhamento profundo |

## Pontos-Chave a Lembrar

- **CTEs** são conjuntos de resultados temporários nomeados definidos com a cláusula `WITH`
- **Legibilidade**: CTEs nomeados tornam as consultas auto-documentadas
- **Múltiplas CTEs**: Encadeie CTEs, cada uma construindo sobre a anterior
- **Reutilização**: Referencie o mesmo CTE múltiplas vezes sem redefini-lo
- **Sem Penalidade de Performance**: CTEs não criam armazenamento intermediário; são ferramentas de otimização de consulta
- **Funciona com Tudo**: CTEs podem incluir uniões, agregações, funções de janela e mais
- **Modularidade**: Decomponha consultas complexas em pedaços lógicos mais fáceis de entender e manter

CTEs transformam consultas complexas de estruturas aninhadas ininteligíveis em código claro, legível e mantível. É uma ferramenta essencial no kit de ferramentas de qualquer analista de dados.

Na próxima lição, exploraremos CTEs recursivas—um recurso poderoso para trabalhar com dados hierárquicos.
