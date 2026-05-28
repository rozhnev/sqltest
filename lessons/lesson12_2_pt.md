---
title: "Uso prático de funções de data e hora em SQL para análise de dados"
description: "Aprenda a aplicar funções de data e hora em SQL na prática: métricas diárias e mensais, cálculo de intervalos, sazonalidade e relatórios analíticos."
keywords: ["funções de data e hora SQL", "DATE_FORMAT SQL", "TIMESTAMPDIFF SQL", "análise temporal SQL", "agregação por data SQL", "SQL Sakila"]
teaches: ["Como extrair partes de data e hora para análise", "Como construir métricas diárias, semanais e mensais", "Como calcular intervalos entre eventos em SQL", "Como analisar a dinâmica de transações e locações ao longo do tempo", "Como usar funções de data e hora em relatórios práticos"]
about: ["SQL", "Data e hora", "Análise de dados", "Sakila", "Agregação"]
---

_Aula 12.2 · Tempo de leitura: ~11 min_

Esta aula é dedicada ao uso prático de funções de data e hora em SQL para análise. Você vai aprender a extrair períodos de campos temporais, agregar dados por dia e por mês, calcular intervalos entre eventos e construir relatórios baseados em métricas temporais. Ao final da aula, você conseguirá analisar com confiança a dinâmica dos dados no tempo usando a base Sakila.

# Uso prático de funções de data e hora para análise de dados

Na aula anterior, vimos o processamento prático de strings. Agora avançamos para outro tipo de dado que aparece constantemente em cenários reais: data e hora.

Em análise de dados, não basta apenas exibir `payment_date` ou `rental_date`. Na prática, precisamos responder perguntas como: como a atividade varia por dia, em quais horas há mais transações, quanto tempo passa entre locação e devolução, e se existem picos sazonais.

<img src="/images/lessons/lesson12_2-date-time-analysis.svg" alt="Análise prática de dados com funções de data e hora em SQL" width="100%">

---

## Por que funções de data e hora são essenciais na análise

Quase todo relatório tem uma dimensão temporal. Mesmo quando a pergunta de negócio é “quantas vendas” ou “quantos clientes”, geralmente é necessário adicionar contexto de tempo: por dia, semana, mês, trimestre ou período específico.

Funções de data e hora ajudam a:

- extrair a granularidade necessária (dia, mês, hora);
- agregar métricas ao longo do tempo;
- comparar períodos entre si;
- calcular duração de processos;
- detectar picos e quedas anormais.

---

## Funções básicas mais usadas

No MySQL, estas funções são especialmente úteis para análise prática:

- `DATE()` - obter apenas a data de um `DATETIME`;
- `YEAR()`, `MONTH()`, `DAY()` - extrair partes da data;
- `HOUR()` - analisar atividade por hora;
- `DATE_FORMAT()` - criar uma chave temporal legível;
- `TIMESTAMPDIFF()` - calcular intervalo entre dois momentos;
- `DATEDIFF()` - diferença em dias.

A seguir, vamos aplicar essas funções em cenários reais com dados do Sakila.

---

## Agregação de pagamentos por dia

Um primeiro cenário prático é observar como o volume de pagamentos varia por dia.

```sql
SELECT
   DATE(payment_date) AS payment_day,
   COUNT(*) AS payments_count,
   SUM(amount) AS total_amount
FROM payment
GROUP BY DATE(payment_date)
ORDER BY payment_day;
```

*Resultado: você obtém a dinâmica diária de quantidade de pagamentos e valor total de receita.*

Esse relatório é útil como base para monitoramento de atividade e detecção de mudanças bruscas.

---

## Comparação mensal com DATE_FORMAT

Quando precisamos de uma visão mais compacta, agregamos por mês.

```sql
SELECT
   DATE_FORMAT(payment_date, '%Y-%m') AS year_month,
   COUNT(*) AS payments_count,
   ROUND(SUM(amount), 2) AS revenue
FROM payment
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY year_month;
```

*Observação: o formato `%Y-%m` é prático para ordenação e visualização em ferramentas de BI.*

Se você usar apenas o número do mês sem o ano, meses iguais de anos diferentes serão misturados.

---

## Análise de atividade por hora

Uma pergunta prática comum é: em quais horas os usuários realizam mais ações?

```sql
SELECT
   HOUR(payment_date) AS payment_hour,
   COUNT(*) AS payments_count,
   ROUND(SUM(amount), 2) AS total_amount
FROM payment
GROUP BY HOUR(payment_date)
ORDER BY payment_hour;
```

*Resultado: você vê a distribuição da atividade por hora do dia.*

Isso é útil para planejamento de carga, horários de campanhas e organização operacional.

---

## Cálculo da duração da locação

Funções de tempo também são usadas para analisar o ciclo de vida dos eventos. No Sakila, podemos medir quantas horas passam entre locação e devolução.

```sql
SELECT
   rental_id,
   rental_date,
   return_date,
   TIMESTAMPDIFF(HOUR, rental_date, return_date) AS rental_duration_hours
FROM rental
WHERE return_date IS NOT NULL
ORDER BY rental_duration_hours DESC
LIMIT 10;
```

*Resultado: a consulta mostra as locações concluídas mais longas.*

Para visão consolidada, vale agregar a duração por média e mediana (se o SGBD oferecer suporte).

---

## Relatório prático: tempo médio de devolução por dia da semana

Agora vamos combinar funções temporais e agregação em uma consulta aplicada.

```sql
SELECT
   DAYOFWEEK(rental_date) AS week_day,
   COUNT(*) AS rentals_count,
   ROUND(AVG(TIMESTAMPDIFF(HOUR, rental_date, return_date)), 2) AS avg_return_hours
FROM rental
WHERE return_date IS NOT NULL
GROUP BY DAYOFWEEK(rental_date)
ORDER BY week_day;
```

*Resultado: você obtém a duração média de locação por dia da semana.*

Esse relatório ajuda a identificar padrões de comportamento e ajustar regras operacionais conforme o dia.

---

## Comparação entre período atual e período anterior

Na análise real, não basta apenas calcular métricas; também é importante comparar períodos. Mesmo uma comparação simples entre dois intervalos já fornece sinal útil.

```sql
SELECT
   CASE
      WHEN payment_date >= '2005-07-01' AND payment_date < '2005-08-01' THEN 'period_1'
      WHEN payment_date >= '2005-08-01' AND payment_date < '2005-09-01' THEN 'period_2'
   END AS period_label,
   COUNT(*) AS payments_count,
   ROUND(SUM(amount), 2) AS revenue
FROM payment
WHERE payment_date >= '2005-07-01'
  AND payment_date < '2005-09-01'
GROUP BY period_label
ORDER BY period_label;
```

*Observação: esse padrão escala facilmente para week-over-week, month-over-month e quarter-over-quarter.*

---

## Recomendações práticas

- Defina com antecedência a granularidade necessária: dia, semana, mês ou hora.
- Para ordenação estável de períodos, use formato ordenável lexicalmente (`YYYY-MM`).
- Filtre explicitamente eventos incompletos (`return_date IS NOT NULL`) ao calcular intervalos.
- Verifique o fuso horário da fonte ao analisar atividade por hora.
- Para comparação de períodos, use limites claros `>=` e `<` para evitar sobreposição.

---

**Principais conclusões desta aula:**

- Funções de data e hora em SQL são essenciais para análise prática de tendência e sazonalidade.
- `DATE`, `DATE_FORMAT`, `HOUR`, `TIMESTAMPDIFF` e `DATEDIFF` cobrem a maioria dos cenários reais.
- A granularidade temporal afeta diretamente a interpretação das métricas.
- A análise de intervalos entre eventos ajuda a medir eficiência de processos.
- Mesmo comparações simples entre períodos já geram sinal útil para decisão.

---

## Perguntas frequentes

### Por que usar `>= início` e `< fim` em vez de `BETWEEN`?
Porque esse formato cria intervalos claros e sem sobreposição, especialmente com `DATETIME`. Isso reduz o risco de contagem duplicada nas bordas.

### Quando usar `DATE_FORMAT` versus `YEAR()` e `MONTH()`?
`DATE_FORMAT` é ótimo para chaves prontas de relatório (por exemplo, `2025-08`). `YEAR()` e `MONTH()` são melhores quando você precisa de lógica separada por ano e mês.

### O que mais costuma quebrar análises temporais?
Problemas comuns: fusos horários misturados, granularidade incorreta, registros incompletos (`NULL` em `return_date`) e limites de período mal definidos.

## Perguntas de entrevista

### Como você explicaria a diferença entre `DATEDIFF()` e `TIMESTAMPDIFF()`?
`DATEDIFF()` retorna diferença em dias entre datas. `TIMESTAMPDIFF()` permite escolher a unidade (horas, minutos, dias etc.) e é melhor para análise de intervalos com maior precisão.

### Por que escolher a granularidade temporal correta é importante em relatórios?
Porque a granularidade define a interpretação: análise diária mostra variações operacionais; análise mensal mostra tendência. Um nível de agregação inadequado pode esconder padrões importantes.

### Como você validaria um relatório temporal antes de publicar?
Eu verificaria limites de período, suposição de fuso horário, tratamento de `NULL`, ausência de sobreposição de intervalos e reconciliação dos totais com uma amostra de controle dos dados brutos.

Na próxima aula, avançaremos para técnicas de transformação de dados para análise e veremos como combinar cálculos temporais e condicionais em uma mesma consulta.
