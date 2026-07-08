---
title: "Оконные функции LAG, LEAD, FIRST_VALUE и LAST_VALUE в SQL"
description: "Разбираем функции LAG, LEAD, FIRST_VALUE и LAST_VALUE: синтаксис, типовые сценарии, сравнение строк без self join и важный нюанс LAST_VALUE с оконным фреймом."
keywords: ["LAG SQL", "LEAD SQL", "FIRST_VALUE SQL", "LAST_VALUE SQL", "оконные функции SQL", "Sakila"]
teaches: ["Использовать LAG и LEAD для сравнения текущей строки с соседними", "Применять FIRST_VALUE и LAST_VALUE для доступа к крайним значениям в окне", "Понимать, как оконный фрейм влияет на результат LAST_VALUE"]
about: ["SQL", "Window functions", "LAG", "LEAD", "FIRST_VALUE", "LAST_VALUE"]
---

_Время чтения: ~9 минут_

Этот урок знакомит с оконными функциями `LAG`, `LEAD`, `FIRST_VALUE` и `LAST_VALUE`. Вы узнаете, как получать предыдущее и следующее значение без `JOIN`, как находить первое и последнее значение внутри окна и почему для `LAST_VALUE` часто нужно явно задавать фрейм. К концу урока вы сможете уверенно использовать эти функции для сравнения строк, анализа динамики и построения аналитических отчетов.

# Функции LAG, LEAD, FIRST_VALUE и LAST_VALUE

В предыдущем уроке мы разобрали оконные фреймы и увидели, как границы окна влияют на вычисления. Теперь перейдем к функциям, которые позволяют смотреть назад, вперед и брать крайние значения внутри окна.

Эти функции особенно полезны в аналитике: они помогают сравнивать продажи по дням, видеть предыдущее действие клиента, рассчитывать изменение относительно прошлого значения и находить первую или последнюю запись в группе без `self join`.

<img src="/images/lessons/lesson7_4-window-offsets.svg" alt="LAG LEAD FIRST_VALUE LAST_VALUE" width="100%">

## Что делают эти функции

Все четыре функции работают как оконные и используются с `OVER (...)`.

- `LAG` возвращает значение из предыдущей строки в окне.
- `LEAD` возвращает значение из следующей строки в окне.
- `FIRST_VALUE` возвращает первое значение в текущем окне.
- `LAST_VALUE` возвращает последнее значение в текущем окне.

Ключевая идея здесь одна: строка остается на месте, но получает доступ к значениям других строк в той же секции (`PARTITION`).

## Базовый синтаксис

### `LAG` и `LEAD`

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

- `expression` — значение, которое нужно получить из другой строки;
- `offset` — на сколько строк сместиться назад или вперед;
- `default_value` — что вернуть, если такой строки нет.

### `FIRST_VALUE` и `LAST_VALUE`

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

Для `FIRST_VALUE` и особенно для `LAST_VALUE` важен оконный фрейм. Без явного фрейма результат `LAST_VALUE` часто оказывается не тем, что ожидают новички.

---

## Использование `LAG`

`LAG` удобно применять, когда нужно сравнить текущую строку с предыдущей.

### Предыдущий платеж клиента

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

*Результат: каждая строка показывает текущий платеж и сумму предыдущего платежа этого же клиента.*

### Изменение относительно предыдущего платежа

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

*Результат: видно, насколько текущий платеж отличается от предыдущего. Для первой строки подставляется `0`.*

---

## Использование `LEAD`

`LEAD` работает симметрично, но смотрит вперед.

### Следующий платеж клиента

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

*Результат: для каждой строки выводится сумма следующего платежа этого клиента.*

### Следующая дата аренды

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

*Результат: запрос показывает, когда будет следующая аренда у того же клиента.*

---

## Использование `FIRST_VALUE`

`FIRST_VALUE` возвращает первое значение в окне. Это полезно, когда нужно сравнить текущую строку с начальной точкой.

### Первый платеж клиента

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

*Результат: в каждой строке повторяется сумма самого первого платежа клиента в окне.*

### Сравнение текущего платежа с первым

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

*Результат: можно оценить, как текущие значения отклоняются от первого значения в последовательности.*

---

## Использование `LAST_VALUE`

`LAST_VALUE` кажется простым, но здесь чаще всего возникает ошибка ожиданий.

### Важный нюанс: фрейм по умолчанию

Если написать так:

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

то во многих СУБД результатом будет не последнее значение всей секции, а значение на границе текущего фрейма. Часто это просто текущая строка.

### Корректный вариант для последнего значения в секции

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

*Результат: каждая строка теперь видит сумму последнего платежа клиента во всей секции.*

### Когда это полезно

Такой прием удобен, если нужно сравнить текущее значение с последним известным значением в серии, финальным статусом заказа или последним платежом клиента.

---

## Сравнение `LAG`, `LEAD`, `FIRST_VALUE` и `LAST_VALUE`

| Функция | Что возвращает | Типичный сценарий |
|---|---|---|
| `LAG` | Значение из предыдущей строки | Сравнение с прошлым значением |
| `LEAD` | Значение из следующей строки | Подготовка к следующему шагу или дате |
| `FIRST_VALUE` | Первое значение в окне | Базовое значение для сравнения |
| `LAST_VALUE` | Последнее значение в окне | Конечное значение в последовательности |

Если задача сводится к сравнению соседних строк, чаще всего нужны `LAG` и `LEAD`. Если нужен ориентир на начало или конец окна, используйте `FIRST_VALUE` и `LAST_VALUE`.

---

## Практический пример: выручка по дням и сравнение с соседними днями

Сначала сгруппируем платежи по дням, а потом применим оконные функции к уже агрегированному результату:

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

*Результат: каждая дата получает доступ к выручке предыдущего дня, следующего дня, а также к первому и последнему значению во всей последовательности.*

Это хороший шаблон для анализа временных рядов, подготовки дашбордов и поиска отклонений в динамике.

---

## Часто задаваемые вопросы

### Чем `LAG` отличается от `LEAD`?
`LAG` смотрит назад и возвращает значение из предыдущей строки, а `LEAD` смотрит вперед и возвращает значение из следующей строки. Обе функции работают в рамках заданного окна и порядка сортировки.

### Почему `LAST_VALUE` часто возвращает текущую строку?
Потому что результат зависит от оконного фрейма. Если оставить фрейм по умолчанию, последней строкой окна может оказаться текущая строка. Чтобы получить последнее значение всей секции, обычно нужно явно писать `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`.

### Можно ли использовать `LAG` и `LEAD` без `PARTITION BY`?
Да. Тогда функция будет работать по всему результирующему набору как по одной большой секции. Это удобно, если нужно анализировать общую последовательность без разделения на группы.

---

## Вопросы для собеседования

### Когда использовать `LAG`, а когда `LEAD`?
`LAG` используют, когда нужно сравнить текущую строку с предыдущей, например найти изменение относительно прошлого платежа. `LEAD` применяют, когда нужно посмотреть вперед, например узнать следующую дату события или следующее значение метрики.

### Чем `FIRST_VALUE` отличается от `MIN`?
`MIN` возвращает минимальное значение по набору строк, а `FIRST_VALUE` возвращает значение первой строки в заданном порядке. Если порядок сортировки не совпадает с минимальным значением, результаты будут разными.

### Почему для `LAST_VALUE` часто требуется явный фрейм?
Потому что `LAST_VALUE` работает не с "последней строкой секции вообще", а с последней строкой текущего окна. Если окно по умолчанию заканчивается на текущей строке, функция и вернет текущее значение. Явный фрейм расширяет окно до всей секции.

---

**Ключевые выводы этого урока:**

- `LAG` и `LEAD` позволяют получать значения из соседних строк без `self join`.
- `FIRST_VALUE` и `LAST_VALUE` возвращают крайние значения внутри окна, а не просто минимум или максимум.
- Для всех этих функций критически важен корректный `ORDER BY`, потому что он определяет последовательность строк.
- `LAST_VALUE` часто требует явного фрейма `UNBOUNDED PRECEDING ... UNBOUNDED FOLLOWING`.
- Эти функции особенно полезны для анализа последовательностей, временных рядов и изменений между строками.

В следующем уроке мы применим оконные функции к накопительным итогам и скользящим средним.