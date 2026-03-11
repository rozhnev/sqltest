---
title: "SQL Оконные фреймы: ROWS, RANGE, GROUPS, BETWEEN, UNBOUNDED — Полное руководство"
description: "Освойте параметры оконных фреймов SQL: режимы ROWS, RANGE, GROUPS, границы BETWEEN, UNBOUNDED PRECEDING/FOLLOWING, CURRENT ROW и именованные окна. Практические примеры: накопительные итоги, скользящие средние и кумулятивный анализ."
keywords: "SQL оконный фрейм, ROWS BETWEEN, RANGE BETWEEN, UNBOUNDED PRECEDING, CURRENT ROW, границы оконных функций, SQL OVER, скользящее среднее SQL, накопительный итог SQL, оконные функции"
lang: "ru"
region: "RU, BY, KZ, UA"
---

# Урок 7.3: Оконные фреймы — управление границами окна

В предыдущих уроках мы использовали оконные функции с `PARTITION BY` и `ORDER BY`. Однако секция `OVER` предлагает третий, не менее мощный компонент: **оконный фрейм**. Оконный фрейм позволяет точно определить, *какие строки* вокруг текущей строки включаются в вычисление, — что открывает возможности для накопительных итогов, скользящих средних и многих других шаблонов временных рядов.

## Что такое оконный фрейм?

Когда вы пишете `OVER (ORDER BY ...)`, многие базы данных применяют **фрейм по умолчанию**, о котором вы можете не подозревать. Явное указание фрейма даёт вам полный контроль над окном вычисления.

Полный синтаксис секции `OVER`:

```sql
function_name() OVER (
    [PARTITION BY partition_expression]
    [ORDER BY sort_expression]
    [frame_clause]
)
```

Где `frame_clause`:

```sql
{ ROWS | RANGE | GROUPS }
BETWEEN frame_start AND frame_end
```

Каждая граница (`frame_start`, `frame_end`) — одно из следующих значений:

| Ключевое слово | Значение |
|---|---|
| `UNBOUNDED PRECEDING` | Самая первая строка секции |
| `n PRECEDING` | n строк (или единиц диапазона) перед текущей строкой |
| `CURRENT ROW` | Текущая строка |
| `n FOLLOWING` | n строк (или единиц диапазона) после текущей строки |
| `UNBOUNDED FOLLOWING` | Самая последняя строка секции |

---

## Режимы фрейма: ROWS, RANGE и GROUPS

Режим фрейма определяет, как измеряются границы.

### Режим ROWS

`ROWS` подсчитывает **физические строки**. `1 PRECEDING` всегда означает ровно одну строку, стоящую непосредственно перед текущей в порядке сортировки.

Лучше всего подходит, когда нужно скользящее окно фиксированной ширины (например, скользящее среднее за 7 дней по дневным строкам).

### Режим RANGE

`RANGE` подсчитывает **логические значения**. `1 PRECEDING` означает все строки, у которых значение `ORDER BY` отличается от значения текущей строки не более чем на 1 единицу — это может быть не одна физическая строка.

Лучше всего подходит, когда нужно агрегировать все строки с тем же значением, что и у текущей, или все строки в диапазоне значений.

**Важно:** Фрейм по умолчанию, когда указан `ORDER BY` без явного фрейма:

```sql
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

Это означает, что окно включает все строки от начала секции **вплоть до всех строк с таким же значением ORDER BY, что и у текущей строки**.

### Режим GROUPS

`GROUPS` подсчитывает **группы равных (peer groups)** — наборы строк с одинаковыми значениями `ORDER BY`. `1 PRECEDING` означает полную группу строк со следующим меньшим значением. Этот режим поддерживается в PostgreSQL 11+ и ряде других СУБД, но не в MySQL/MariaDB.

---

## Часто используемые шаблоны фреймов

### Накопительный итог (Running Total)

Включить все строки от начала секции до текущей строки:

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

**Пример вывода:**
```
customer_id | payment_date | amount | running_total
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 7.98
1           | 2005-07-08   | 11.99  | 19.97
1           | 2005-08-01   | 11.99  | 31.96
```

**Ключевой момент:** `running_total` каждой строки накапливает все предыдущие платежи клиента. Фрейм `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` означает: начать с первой строки секции, закончить текущей строкой.

---

### Скользящее среднее (Sliding Window)

Вычислить скользящее среднее по трём платежам для каждого клиента:

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

**Пример вывода:**
```
customer_id | payment_date | amount | moving_avg_3
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 3.99
1           | 2005-07-08   | 11.99  | 6.66
1           | 2005-08-01   | 11.99  | 9.66
1           | 2005-08-23   | 5.99   | 9.99
```

**Ключевой момент:** `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` создаёт окно ровно из 3 строк: текущей и двух предшествующих. Если строк меньше трёх (в начале секции), окно сужается соответственно.

---

### Заглядывание вперёд (Including Future Rows)

Вычислить среднее для текущей строки и следующих двух:

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

**Ключевой момент:** `CURRENT ROW AND 2 FOLLOWING` смещает окно вперёд. Последние две строки секции будут усреднять меньше значений, так как после них нет других строк.

---

### Агрегат по всей секции (как окно)

Сравнить каждый платёж со средним значением по клиенту:

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

**Ключевой момент:** `UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` охватывает всю секцию — эквивалентно агрегату `GROUP BY`, но без сворачивания строк.

---

## ROWS vs RANGE: прямое сравнение

Понимание разницы между `ROWS` и `RANGE` критично, когда строки имеют одинаковые значения `ORDER BY`.

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

**Пример вывода:**
```
customer_id | amount | sum_rows | sum_range
3           | 9.99   | 9.99     | 9.99
2           | 10.99  | 20.98    | 20.98
1           | 11.99  | 32.97    | 55.94
2           | 11.99  | 44.96    | 55.94
1           | 11.99  | 55.94    | 55.94
```

**Наблюдения:**
- С `ROWS`: каждая физическая строка считается отдельно независимо от совпадений. Накопительная сумма растёт по одной строке за раз.
- С `RANGE`: все строки с **одинаковым значением amount** включаются вместе. Обе строки 11.99 рассматриваются как одна логическая группа, поэтому `sum_range` сразу переходит к полному итогу.

---

## Именованные окна (секция WINDOW)

Если одно и то же определение фрейма используется несколько раз в запросе, его можно именовать с помощью секции `WINDOW`, чтобы избежать повторений:

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

**Ключевой момент:** Секция `WINDOW w AS (...)` определяет фрейм один раз. Все три вызова оконных функций ссылаются на него через `OVER w`. Это делает код чище, снижает риск ошибок и упрощает сопровождение.

*Примечание: секция `WINDOW` поддерживается в PostgreSQL, MySQL 8.0+ и MariaDB 10.2+.*

---

## Справочник границ фрейма

| Определение фрейма | Что включает |
|---|---|
| `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Все строки от начала секции до текущей строки |
| `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` | Все строки секции (полный агрегат) |
| `ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING` | Текущая строка и по одной строке с каждой стороны (3 строки) |
| `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` | Текущая строка и 2 предшествующие (скользящее окно из 3 строк) |
| `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING` | Текущая строка до конца секции |
| `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Значение по умолчанию при наличии `ORDER BY`; включает все строки с тем же значением ORDER BY |

---

## Практическое применение: дневные продажи с накопительными и скользящими метриками

Объединение нескольких оконных фреймов в одном запросе для полной картины:

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

**Ключевой момент:** Внешний агрегат (`SUM(SUM(amount))`) вкладывает оконную функцию поверх сгруппированных результатов — мощный шаблон для дашбордов временных рядов.

---

## Когда использовать каждый вариант фрейма

| Цель | Рекомендуемый фрейм |
|---|---|
| Накопительный / кумулятивный итог | `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Агрегат по всей секции рядом с данными строки | `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` |
| Скользящее среднее за N периодов | `ROWS BETWEEN N-1 PRECEDING AND CURRENT ROW` |
| Симметричное сглаживающее окно | `ROWS BETWEEN N PRECEDING AND N FOLLOWING` |
| Агрегация по диапазону значений (обработка совпадений как группы) | `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Повторное использование одного фрейма в нескольких функциях | Именованная секция `WINDOW` |

---

## Основные выводы урока

- **Оконный фрейм** определяет набор строк относительно текущей строки, включаемых в вычисление оконной функции.
- Три режима фрейма: **ROWS** (физические строки), **RANGE** (логические диапазоны значений) и **GROUPS** (группы равных значений).
- Фрейм по умолчанию при наличии `ORDER BY` — `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`. Знание этого умолчания предотвращает неочевидные ошибки при работе с совпадающими значениями.
- Используйте **`ROWS`** для скользящих окон фиксированной ширины; используйте **`RANGE`**, когда совпадающие значения должны агрегироваться вместе.
- Ключевые слова границ: `UNBOUNDED PRECEDING`, `n PRECEDING`, `CURRENT ROW`, `n FOLLOWING`, `UNBOUNDED FOLLOWING`.
- Секция **`WINDOW`** позволяет именовать и переиспользовать определение фрейма, делая сложные запросы читаемыми.
- Оконные фреймы не влияют на `PARTITION BY` — они сужают фрейм только *внутри* секции.

В следующем уроке мы изучим функции смещения `LAG`, `LEAD`, `FIRST_VALUE` и `LAST_VALUE`, которые позволяют сравнивать значение строки со значениями других строк без самосоединений.
