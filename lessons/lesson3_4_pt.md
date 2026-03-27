# Aula 3.4: Funções Essenciais de Data e Hora em SQL

As funções de data e hora em SQL permitem extrair, modificar e formatar valores de data e hora. Essas funções são amplamente utilizadas para analisar dados temporais, filtrar por data, calcular intervalos e formatar a saída. Esta aula cobre as funções mais usadas com exemplos baseados no banco de dados Sakila.

*Importante*: `CURRENT_DATE`, `CURRENT_TIME` e `CURRENT_TIMESTAMP`, em muitos SGBDs, são expressões SQL especiais (ou aliases de funções correspondentes), e não "funções comuns" no formato `NAME(arg1, arg2, ...)`. Por isso, a sintaxe e os detalhes de comportamento podem variar entre SGBDs.

## Funções Comuns de Data e Hora

### `CURRENT_DATE` — Expressão especial que retorna a data atual (sem hora).

**Sintaxe:**
```sql
CURRENT_DATE
```

**Exemplo:**
```sql
SELECT CURRENT_DATE AS hoje;
```
**Resultado:** A data atual, por exemplo: `2025-06-03`

### `CURRENT_TIME` — Expressão especial/alias que retorna a hora atual (sem data).

**Sintaxe:**
```sql
CURRENT_TIME
CURRENT_TIME()
CURRENT_TIME(precision)
```

**Exemplo:**
```sql
SELECT CURRENT_TIME AS hora_atual;
```
**Resultado:** A hora atual. Com precisão informada (por exemplo, `CURRENT_TIME(3)`), o valor inclui frações de segundo.

### `CURRENT_TIMESTAMP` / `NOW()` — Retorna a data e hora atuais (frequentemente como expressão especial/alias).

**Sintaxe:**
```sql
CURRENT_TIMESTAMP
CURRENT_TIMESTAMP()
CURRENT_TIMESTAMP(precision)
NOW()
```

**Exemplo:**
```sql
SELECT CURRENT_TIMESTAMP AS data_hora_atual;
SELECT NOW() AS data_hora_atual;
```
**Resultado:** A data e hora atuais, por exemplo: `2025-06-03 14:25:30`

*Importante*: na maioria dos SGBDs, `CURRENT_DATE`/`CURRENT_TIME`/`CURRENT_TIMESTAMP` são fixados no início da execução da consulta (e, em alguns modos, no início da transação). Portanto, em uma mesma consulta, todas as linhas normalmente recebem o mesmo valor.

Se você precisa de uma "marca temporal atual" no momento da avaliação para cada linha, use alternativas específicas do SGBD (por exemplo, `SYSDATE()` no MySQL/MariaDB, `clock_timestamp()` no PostgreSQL).

### `DATE()` — Extrai apenas a data de um valor datetime.

**Sintaxe:**
```sql
DATE(valor_datetime)
```

**Exemplo:**
```sql
SELECT DATE(rental_date) AS data_apenas
FROM rental
LIMIT 3;
```
**Resultado:** Retorna apenas a data da coluna `rental_date`.

### `TIME()` — Extrai apenas a hora de um valor datetime.

**Sintaxe:**
```sql
TIME(valor_datetime)
```

**Exemplo:**
```sql
SELECT TIME(rental_date) AS hora_apenas
FROM rental
LIMIT 3;
```
**Resultado:** Retorna apenas a hora da coluna `rental_date`.

### `YEAR()` — Extrai o ano de um valor de data.

**Sintaxe:**
```sql
YEAR(valor_data)
```

**Exemplo:**
```sql
SELECT YEAR(rental_date) AS ano_locacao
FROM rental
LIMIT 3;
```
**Resultado:** Retorna o ano da data de locação.

### `MONTH()` — Extrai o mês de um valor de data.

**Sintaxe:**
```sql
MONTH(valor_data)
```

**Exemplo:**
```sql
SELECT MONTH(rental_date) AS mes_locacao
FROM rental
LIMIT 3;
```
**Resultado:** Retorna o mês da data de locação.

### `DAY()` — Extrai o dia do mês de um valor de data.

**Sintaxe:**
```sql
DAY(valor_data)
```

**Exemplo:**
```sql
SELECT DAY(rental_date) AS dia_locacao
FROM rental
LIMIT 3;
```
**Resultado:** Retorna o dia do mês da data de locação.

### `DATE_ADD()` — Adiciona um intervalo especificado a uma data.

**Sintaxe:**
```sql
DATE_ADD(data, INTERVAL valor unidade)
```

**Exemplo:**
```sql
SELECT DATE_ADD(rental_date, INTERVAL 7 DAY) AS devolucao_prevista
FROM rental
LIMIT 3;
```
**Resultado:** Retorna a data acrescida de 7 dias.

### `DATE_SUB()` — Subtrai um intervalo especificado de uma data.

**Sintaxe:**
```sql
DATE_SUB(data, INTERVAL valor unidade)
```

**Exemplo:**
```sql
SELECT DATE_SUB(rental_date, INTERVAL 3 DAY) AS tres_dias_antes
FROM rental
LIMIT 3;
```
**Resultado:** Retorna a data diminuída em 3 dias.

### `DATEDIFF()` — Retorna o número de dias entre duas datas.

**Sintaxe:**
```sql
DATEDIFF(data1, data2)
```

**Exemplo:**
```sql
SELECT DATEDIFF(return_date, rental_date) AS duracao_locacao
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Resultado:** O número de dias entre a data de devolução e a data de locação.

### `DATE_FORMAT()` — Formata uma data em um formato especificado (MySQL).

**Sintaxe:**
```sql
DATE_FORMAT(data, formato)
```

**Exemplo:**
```sql
SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS data_formatada
FROM rental
LIMIT 3;
```
**Resultado:** Data no formato `dd.mm.aaaa`, por exemplo: `03.06.2025`

**Especificadores de formato comuns:**
- `%Y`: Ano (4 dígitos)
- `%m`: Mês (2 dígitos)
- `%d`: Dia do mês (2 dígitos)
- `%H`: Hora (formato 24h)
- `%i`: Minutos
- `%s`: Segundos

### `STRFTIME()` — Formata data/hora (SQLite, PostgreSQL).

**Sintaxe:**
```sql
STRFTIME(formato, data)
```

**Exemplo:**
```sql
SELECT STRFTIME('%Y-%m-%d', rental_date) AS data_formatada
FROM rental
LIMIT 3;
```
**Resultado:** Data no formato `aaaa-mm-dd`.

### `TIMESTAMPDIFF()` — Diferença entre duas datas/horas em unidades especificadas (MySQL).

**Sintaxe:**
```sql
TIMESTAMPDIFF(unidade, datetime1, datetime2)
```

**Exemplo:**
```sql
SELECT TIMESTAMPDIFF(DAY, rental_date, return_date) AS dias_locados
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Resultado:** O número de dias entre a locação e a devolução.

### `EXTRACT()` — Extrai uma parte de uma data ou hora (ano, mês, dia, etc.).

**Sintaxe:**
```sql
EXTRACT(parte FROM data)
```

**Exemplo:**
```sql
SELECT EXTRACT(YEAR FROM rental_date) AS ano_locacao
FROM rental
LIMIT 3;
```
**Resultado:** Extrai o ano da data de locação.

---

## Aplicações Práticas

1. **Encontrar filmes locados nos últimos 30 dias:**
   ```sql
   SELECT *
   FROM rental
   WHERE rental_date > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
   ```
2. **Contar locações por mês:**
   ```sql
   SELECT YEAR(rental_date) AS ano, MONTH(rental_date) AS mes, COUNT(*) AS locacoes
   FROM rental
   GROUP BY ano, mes
   ORDER BY ano DESC, mes DESC;
   ```
3. **Formatar a data de locação para relatório:**
   ```sql
   SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS locacao_formatada
   FROM rental
   LIMIT 5;
   ```

## Principais Conclusões desta Aula

As funções de data e hora permitem analisar e transformar dados temporais de forma flexível no SQL. Use-as para filtrar, agrupar, calcular intervalos e formatar datas em relatórios. Pratique essas funções com exemplos do banco de dados Sakila para reforçar seus conhecimentos.
