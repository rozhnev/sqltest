---
title: "Frames de Janela SQL: ROWS, RANGE, GROUPS, BETWEEN, UNBOUNDED — Guia Completo"
description: "Domine as opções de frame de janela SQL: modos ROWS, RANGE, GROUPS, limites BETWEEN, UNBOUNDED PRECEDING/FOLLOWING, CURRENT ROW e janelas nomeadas. Exemplos práticos: totais acumulados, médias móveis e análise cumulativa."
keywords: "frame janela SQL, ROWS BETWEEN, RANGE BETWEEN, UNBOUNDED PRECEDING, CURRENT ROW, limites funções janela, SQL OVER, média móvel SQL, total acumulado SQL, tutorial funções janela"
lang: "pt"
region: "BR, PT, AO, MZ"
---

# Lição 7.3: Frames de Janela — Controlando os Limites da Janela

Nas lições anteriores, usámos funções de janela com `PARTITION BY` e `ORDER BY`. Mas a cláusula `OVER` oferece um terceiro componente igualmente poderoso: o **frame de janela**. Um frame de janela permite definir precisamente *quais linhas* ao redor da linha atual são incluídas no cálculo — habilitando totais acumulados, médias móveis e muitos outros padrões de séries temporais.

## O Que É um Frame de Janela?

Quando escreve `OVER (ORDER BY ...)`, muitas bases de dados aplicam um **frame padrão** do qual pode não ter consciência. Especificar um frame explicitamente dá-lhe controlo total sobre a janela de cálculo.

A sintaxe completa da cláusula `OVER` é:

```sql
function_name() OVER (
    [PARTITION BY partition_expression]
    [ORDER BY sort_expression]
    [frame_clause]
)
```

Onde `frame_clause` é:

```sql
{ ROWS | RANGE | GROUPS }
BETWEEN frame_start AND frame_end
```

E cada limite (`frame_start`, `frame_end`) é um dos seguintes:

| Palavra-chave de limite | Significado |
|---|---|
| `UNBOUNDED PRECEDING` | A primeira linha da partição |
| `n PRECEDING` | n linhas (ou unidades de intervalo) antes da linha atual |
| `CURRENT ROW` | A linha atual |
| `n FOLLOWING` | n linhas (ou unidades de intervalo) após a linha atual |
| `UNBOUNDED FOLLOWING` | A última linha da partição |

---

## Modos de Frame: ROWS, RANGE e GROUPS

O modo de frame controla como os limites são medidos.

### Modo ROWS

`ROWS` conta **linhas físicas**. `1 PRECEDING` significa sempre exatamente a linha que vem imediatamente antes da linha atual na ordenação.

Melhor usado quando precisar de uma janela deslizante de largura fixa (ex. uma média móvel de 7 dias sobre linhas diárias).

### Modo RANGE

`RANGE` conta **valores lógicos**. `1 PRECEDING` significa todas as linhas cujo valor `ORDER BY` está dentro de 1 unidade do valor da linha atual — não necessariamente apenas uma linha física.

Melhor usado quando quiser agregar todas as linhas com o mesmo valor que a linha atual, ou todas as linhas dentro de um intervalo de valores.

**Importante:** O frame padrão quando especifica `ORDER BY` mas sem cláusula de frame explícita é:

```sql
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

Isto significa que a janela inclui todas as linhas desde o início da partição **até e incluindo todas as linhas com o mesmo valor ORDER BY que a linha atual**.

### Modo GROUPS

`GROUPS` conta **grupos pares** (conjuntos de linhas com valores `ORDER BY` idênticos). `1 PRECEDING` significa o grupo completo de linhas com o valor imediatamente inferior. Este modo é suportado no PostgreSQL 11+ e algumas outras bases de dados, mas não no MySQL/MariaDB.

---

## Padrões Comuns de Frame

### Total Acumulado (Running Total)

Incluir todas as linhas desde o início da partição até à linha atual:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Exemplo de Saída:**
```
customer_id | payment_date | amount | running_total
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 7.98
1           | 2005-07-08   | 11.99  | 19.97
1           | 2005-08-01   | 11.99  | 31.96
```

**Ponto Chave:** O `running_total` de cada linha acumula todos os pagamentos anteriores do cliente. O frame `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` significa: começar na linha 1 desta partição, terminar na linha atual.

---

### Média Móvel (Sliding Window)

Calcular a média móvel de 3 pagamentos para cada cliente:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY payment_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Exemplo de Saída:**
```
customer_id | payment_date | amount | moving_avg_3
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 3.99
1           | 2005-07-08   | 11.99  | 6.66
1           | 2005-08-01   | 11.99  | 9.66
1           | 2005-08-23   | 5.99   | 9.99
```

**Ponto Chave:** `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` cria uma janela de exatamente 3 linhas: a linha atual e as 2 linhas anteriores. Quando existem menos de 3 linhas (no início de uma partição), a janela reduz-se em conformidade.

---

### Olhar para a Frente (Including Future Rows)

Calcular a média da linha atual e das próximas 2 linhas:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY payment_date
            ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
        ), 2
    ) AS forward_avg
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Ponto Chave:** `CURRENT ROW AND 2 FOLLOWING` desloca a janela para a frente. As últimas duas linhas da partição calcularão a média com menos valores porque não há linhas após elas.

---

### Agregado de Partição Completa (como Janela)

Comparar cada pagamento com a média global do cliente:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ), 2
    ) AS customer_avg,
    amount - ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ), 2
    ) AS deviation
FROM
    payment
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id, payment_date;
```

**Ponto Chave:** `UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` abrange toda a partição — equivalente a um agregado `GROUP BY` mas sem colapsar as linhas.

---

## ROWS vs RANGE: Comparação Direta

Compreender a diferença entre `ROWS` e `RANGE` é crítico quando linhas partilham valores `ORDER BY` idênticos.

```sql
SELECT
    customer_id,
    amount,
    SUM(amount) OVER (
        ORDER BY amount
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sum_rows,
    SUM(amount) OVER (
        ORDER BY amount
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sum_range
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    amount;
```

**Exemplo de Saída:**
```
customer_id | amount | sum_rows | sum_range
3           | 9.99   | 9.99     | 9.99
2           | 10.99  | 20.98    | 20.98
1           | 11.99  | 32.97    | 55.94
2           | 11.99  | 44.96    | 55.94
1           | 11.99  | 55.94    | 55.94
```

**Observações:**
- Com `ROWS`: cada linha física é contada individualmente, independentemente de empates. A soma acumulada avança uma linha de cada vez.
- Com `RANGE`: todas as linhas com o **mesmo valor amount** são incluídas juntas. Ambas as linhas 11.99 são tratadas como o mesmo grupo lógico, então `sum_range` salta imediatamente para o total completo.

---

## Janelas Nomeadas (Cláusula WINDOW)

Se usar a mesma definição de frame várias vezes numa consulta, pode nomeá-la com a cláusula `WINDOW` para evitar repetição:

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount)   OVER w AS running_total,
    AVG(amount)   OVER w AS running_avg,
    COUNT(amount) OVER w AS payment_count
FROM
    payment
WHERE
    customer_id = 1
WINDOW w AS (
    PARTITION BY customer_id
    ORDER BY payment_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
ORDER BY
    payment_date;
```

**Ponto Chave:** A cláusula `WINDOW w AS (...)` define o frame uma vez. As três chamadas de funções de janela referenciam-no com `OVER w`. Isto é mais limpo, menos propenso a erros e mais fácil de manter.

*Nota: A cláusula `WINDOW` é suportada no PostgreSQL, MySQL 8.0+ e MariaDB 10.2+.*

---

## Referência de Limites de Frame

| Definição de frame | O que inclui |
|---|---|
| `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Todas as linhas do início da partição até à linha atual |
| `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` | Todas as linhas da partição (agregado completo) |
| `ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING` | Linha atual mais uma linha de cada lado (janela de 3 linhas) |
| `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` | Linha atual e as 2 linhas anteriores (janela deslizante de 3) |
| `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING` | Linha atual até ao fim da partição |
| `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Padrão com `ORDER BY`; inclui todas as linhas com o mesmo valor ORDER BY |

---

## Aplicação Prática: Vendas Diárias com Métricas Acumuladas e Móveis

Combinar múltiplos frames de janela numa única consulta para uma visão completa:

```sql
SELECT
    DATE(payment_date)                            AS payment_day,
    SUM(amount)                                   AS daily_total,
    SUM(SUM(amount)) OVER (
        ORDER BY DATE(payment_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                             AS cumulative_total,
    ROUND(AVG(SUM(amount)) OVER (
        ORDER BY DATE(payment_date)
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2)                                         AS rolling_7day_avg
FROM
    payment
GROUP BY
    DATE(payment_date)
ORDER BY
    payment_day;
```

**Ponto Chave:** O agregado externo (`SUM(SUM(amount))`) ainha uma função de janela sobre resultados agrupados — um padrão poderoso para dashboards de séries temporais.

---

## Quando Usar Cada Opção de Frame

| Objetivo | Frame recomendado |
|---|---|
| Total cumulativo | `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Agregado de partição completa com dados por linha | `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` |
| Média móvel de N períodos | `ROWS BETWEEN N-1 PRECEDING AND CURRENT ROW` |
| Janela de suavização simétrica | `ROWS BETWEEN N PRECEDING AND N FOLLOWING` |
| Agregação por intervalo de valores (tratar empates como grupo) | `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Reutilizar o mesmo frame em múltiplas funções | Cláusula `WINDOW` nomeada |

---

## Principais Conclusões desta Lição

- Um **frame de janela** define o conjunto de linhas relativas à linha atual que são incluídas no cálculo de uma função de janela.
- Os três modos de frame são **ROWS** (linhas físicas), **RANGE** (intervalos de valores lógicos) e **GROUPS** (grupos pares de valores iguais).
- O frame padrão com `ORDER BY` é `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` — conhecer este padrão evita bugs subtis com valores empatados.
- Use **`ROWS`** para janelas deslizantes de largura fixa; use **`RANGE`** quando valores empatados devem ser agregados juntos.
- Palavras-chave de limite: `UNBOUNDED PRECEDING`, `n PRECEDING`, `CURRENT ROW`, `n FOLLOWING`, `UNBOUNDED FOLLOWING`.
- A cláusula **`WINDOW`** permite nomear e reutilizar uma definição de frame, mantendo consultas complexas legíveis.
- Os frames de janela não afetam `PARTITION BY` — apenas restringem o frame *dentro* de uma partição.

Na próxima lição, exploraremos as funções de deslocamento `LAG`, `LEAD`, `FIRST_VALUE` e `LAST_VALUE`, que permitem comparar o valor de uma linha com valores noutras linhas sem auto-junções.
