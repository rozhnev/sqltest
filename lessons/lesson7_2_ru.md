---
title: "Функции ранжирования SQL: Полное руководство ROW_NUMBER vs RANK vs DENSE_RANK vs NTILE"
description: "Изучите функции ранжирования SQL: ROW_NUMBER, RANK, DENSE_RANK, NTILE. Поймите различия и когда использовать каждую функцию с практическими примерами MySQL. Полное руководство для анализа данных."
keywords: "функции ранжирования SQL, ROW_NUMBER, RANK, DENSE_RANK, NTILE, оконные функции SQL, учебник SQL, ранжирование данных, аналитический SQL, ранжирование MySQL"
lang: "ru"
region: "RU, BY, KZ, UA"
---

# Урок 7.2: Использование ROW_NUMBER, RANK, DENSE_RANK и NTILE

В предыдущем уроке мы познакомились с оконными функциями и изучили `ROW_NUMBER()`. Теперь мы глубже погружаемся в семейство функций ранжирования, которые предлагает SQL: `ROW_NUMBER`, `RANK`, `DENSE_RANK` и `NTILE`. Каждая имеет отчётливую цель, и понимание, когда использовать каждую, критично для эффективного анализа данных.

## Понимание различий

Все четыре функции присваивают числовое значение строкам на основе сортировки, но обрабатывают ничьи (одинаковые значения) по-разному. Давайте исследуем каждую.

### ROW_NUMBER(): Уникальные последовательные номера

`ROW_NUMBER()` присваивает уникальный последовательный номер каждой строке, даже если значения идентичны. Она рассматривает ничьи как разные строки.

**Синтаксис:**
```sql
ROW_NUMBER() OVER (
    [PARTITION BY выражение_партиции]
    ORDER BY выражение_сортировки
)
```

**Пример: Ранжирование транзакций**

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

**Пример результата:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ключевой момент:** Даже если первые два платежа клиента 1 имеют одинаковые суммы (11.99), они получают разные номера строк (1 и 2).

### RANK(): Ранжирование с пропусками

`RANK()` присваивает одинаковый ранг строкам с одинаковыми значениями сортировки, но оставляет пропуски в последовательности нумерации. Если две строки делят ранг 1, следующий — 3 (пропуская 2).

**Синтаксис:**
```sql
RANK() OVER (
    [PARTITION BY выражение_партиции]
    ORDER BY выражение_сортировки
)
```

**Пример: Ранжирование платежей по сумме**

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

**Пример результата:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ключевой момент:** Оба платежа клиента 1 по 11.99 получают ранг 1, а следующий платёж получает ранг 3 (не 2). Это полезно, когда вы хотите выявить ничьи, но сохранить позицию ранжирования в полном наборе данных.

### DENSE_RANK(): Ранжирование без пропусков

`DENSE_RANK()` похожа на `RANK()`, но не пропускает числа. Если две строки делят ранг 1, следующий — 2 (не 3).

**Синтаксис:**
```sql
DENSE_RANK() OVER (
    [PARTITION BY выражение_партиции]
    ORDER BY выражение_сортировки
)
```

**Пример: Плотное ранжирование сумм платежей**

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

**Пример результата:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 2
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ключевой момент:** Оба платежа клиента 1 по 11.99 получают ранг 1, а следующая отличающаяся сумма получает ранг 2. Нет пропусков в последовательности ранжирования. Это идеально, когда вы хотите выявить отличные группы без пропусков.

### NTILE(): Распределение строк в группы

`NTILE(n)` разделяет партицию на n групп (бакеты) и присваивает каждой строке номер бакета. Это полезно для анализа процентилей и размещения данных в квартили и т.д.

**Синтаксис:**
```sql
NTILE(количество_бакетов) OVER (
    [PARTITION BY выражение_партиции]
    ORDER BY выражение_сортировки
)
```

**Пример: Анализ квартилей**

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

**Пример результата:**
```
customer_id | amount | payment_date | quartile
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Ключевой момент:** Строки распределены в 4 квартиля. Это чрезвычайно полезно для анализа процентилей — выявления топ 25% (квартиль 1), следующих 25% (квартиль 2) и так далее.

## Сравнение бок о бок

Давайте посмотрим на все четыре функции, применённые к одним данным:

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

**Пример результата:**
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

**Наблюдения:**
- `row_number`: Всегда уникален, без пропусков
- `rank`: Группирует ничьи, но создаёт пропуски (1, 1, 1, 4, 4, 6, 6, 8, 8, 10)
- `dense_rank`: Группирует ничьи без пропусков (1, 1, 1, 2, 2, 3, 3, 4, 4, 5)
- `ntile(3)`: Распределяет в 3 группы на основе сортировки

## Практические применения

### Поиск лучших исполнителей (ROW_NUMBER)

Получить платёж с наивысшей суммой по месяцам:

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

### Выявление уровней производительности (DENSE_RANK)

Категоризировать фильмы по частоте проката:

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
        WHEN popularity_tier = 1 THEN 'Блокбастер'
        WHEN popularity_tier <= 3 THEN 'Популярный'
        WHEN popularity_tier <= 10 THEN 'Стандартный'
        ELSE 'Нишевый'
    END AS popularity_category
FROM
    rental_counts
LIMIT 20;
```

### Анализ процентилей (NTILE)

Разделить клиентов на квартили по расходам:

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

## Когда использовать каждую функцию

| Функция | Случай использования | Обрабатывает ничьи |
|---------|----------------------|-------------------|
| `ROW_NUMBER` | Нужны уникальные последовательные номера; не важны ничьи | Нет (все уникальны) |
| `RANK` | Нужно выявить позицию, учитывая ничьи; пропуски допустимы | Да (с пропусками) |
| `DENSE_RANK` | Нужна идентификация уровней без пропусков | Да (без пропусков) |
| `NTILE` | Нужен анализ процентилей/квартилей/групп | Распределяет в группы |

## Ключевые выводы

- **ROW_NUMBER()** даёт каждой строке уникальный номер, полезна для получения топ N записей из каждой группы.
- **RANK()** присваивает одинаковый ранг одинаковым значениям, но пропускает ранги (1, 1, 3), полезна для соревновательного ранжирования.
- **DENSE_RANK()** присваивает одинаковый ранг одинаковым значениям без пропусков (1, 1, 2), полезна для классификации уровней.
- **NTILE(n)** разделяет строки на бакеты для анализа процентилей и распределения.
- Все четыре функции входят в семейство оконных функций и используют предложение `OVER`.
- Ключевое различие — как они обрабатывают одинаковые значения в столбце сортировки.
- Выбор правильной функции зависит от вашей аналитической цели: позиционирование, группировка или распределение.

В следующем уроке мы будем изучать продвинутые концепции оконных функций, включая оконные фреймы, стратегии партиционирования и другие аналитические функции, такие как `LAG`, `LEAD`, `FIRST_VALUE` и `LAST_VALUE`.
