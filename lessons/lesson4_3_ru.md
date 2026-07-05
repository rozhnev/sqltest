---
title: "Фильтрация сгруппированных данных с HAVING в SQL"
description: "Разбираем оператор HAVING: синтаксис, различия WHERE vs HAVING, фильтрация групп после агрегации, примеры на Sakila."
keywords: ["HAVING SQL", "фильтрация групп", "GROUP BY", "агрегатные функции", "Sakila"]
teaches: ["Применять HAVING для фильтрации групп после агрегации", "Понимать различия между WHERE и HAVING", "Комбинировать несколько условий в HAVING"]
about: ["SQL", "HAVING", "GROUP BY", "Aggregation", "Sakila"]
---

_Время чтения: ~7 минут_

Когда вы используете `GROUP BY` с агрегатными функциями, часто нужно отфильтровать группы по результатам агрегации. `HAVING` — это оператор для фильтрации групп, как `WHERE` фильтрует отдельные строки. В этом уроке вы разберете различия `WHERE` и `HAVING`, синтаксис и практические примеры на Sakila. К концу урока вы сможете уверенно применять `HAVING` для глубокого анализа данных.

# Фильтрация групп с помощью HAVING

В предыдущих уроках вы изучили `GROUP BY` для группировки данных и применения агрегатных функций. Теперь нужен следующий шаг: фильтровать сами группы по условиям на агрегированные значения.

`HAVING` решает эту задачу, позволяя накладывать условия после группировки.

## Различия WHERE и HAVING

- **WHERE** фильтрует строки **до** группировки
- **HAVING** фильтрует группы **после** агрегации

```sql
SELECT column1, COUNT(*) AS cnt
FROM table
WHERE column1 > 100          -- фильтруем ДО группировки
GROUP BY column1
HAVING COUNT(*) > 10;        -- фильтруем ПОСЛЕ группировки
```

## Синтаксис HAVING

Базовая структура:

```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1
HAVING condition;
```

Условие в `HAVING` обычно включает агрегатную функцию.

---

## Примеры с одним условием

### Клиенты с суммой платежей выше 100

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```

*Результат: только клиенты, чей суммарный платеж превышает 100.*

### Сотрудники, обработавшие более 50 платежей

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```

*Результат: сотрудники с количеством платежей более 50.*

### Клиенты со средним платежом ≥ 5

```sql
SELECT customer_id, AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```

*Результат: клиенты, у которых средний платеж не менее 5.*

---

## HAVING с несколькими условиями

Можно комбинировать условия через `AND` и `OR`:

```sql
SELECT staff_id, COUNT(*) AS cnt, SUM(amount) AS total
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```

*Результат: сотрудники с более чем 50 платежами И суммой более 500.*

### С оператором OR

```sql
SELECT customer_id, COUNT(*) AS rentals, SUM(amount) AS paid
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 100 OR SUM(amount) > 1000;
```

*Результат: клиенты, у которых более 100 платежей ИЛИ сумма превышает 1000.*

---

## Практические примеры

### Категории фильмов с продажами выше 2000

```sql
SELECT category_id, SUM(p.amount) AS total_sales
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
GROUP BY category_id
HAVING SUM(p.amount) > 2000;
```

### Страны с более чем 20 клиентами

```sql
SELECT country, COUNT(*) AS customers_count
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY country
HAVING COUNT(*) > 20;
```

### Магазины с наибольшей выручкой за день

```sql
SELECT store_id, DATE(payment_date) AS pay_date, SUM(amount) AS daily_revenue
FROM payment
GROUP BY store_id, DATE(payment_date)
HAVING SUM(amount) > 500;
```

---

## Часто задаваемые вопросы

### Почему нельзя использовать WHERE вместо HAVING?
`WHERE` работает до группировки, поэтому он не может проверять агрегированные функции. `HAVING` работает после группировки и может анализировать результаты агрегации (COUNT, SUM, AVG и т.д.).

### Можно ли использовать неагрегированный столбец в HAVING?
Да, можно использовать столбец из `GROUP BY`, но обычно это не требуется. Например, `HAVING customer_id > 100` работает, но более естественно это писать в `WHERE` до группировки.

### Может ли HAVING использоваться без GROUP BY?
Технически в некоторых СУБД это возможно, но практически бессмысленно, так как HAVING предназначен для фильтрации групп. Используйте `WHERE` для фильтрации отдельных строк без группировки.

---

## Вопросы для собеседования

### Что такое HAVING и в чем его главное отличие от WHERE?
HAVING фильтрует группы после агрегации, а WHERE фильтрует строки до группировки. WHERE не может работать с агрегатными функциями, а HAVING работает только с ними.

### Можно ли комбинировать WHERE и HAVING в одном запросе?
Да, это даже рекомендуется. WHERE фильтрует строки до группировки, а HAVING — группы после. Например, `WHERE amount > 10 GROUP BY customer_id HAVING SUM(amount) > 100` сначала исключает малые платежи, затем группирует и фильтрует группы.

### Какой порядок применения: WHERE или HAVING?
WHERE применяется первым (до GROUP BY), затем GROUP BY выполняет группировку, потом HAVING фильтрует готовые группы, и finally применяется ORDER BY и LIMIT.

---

**Ключевые выводы этого урока:**

- `HAVING` фильтрует группы **после** агрегации, `WHERE` фильтрует строки **до** группировки.
- `HAVING` используется с агрегатными функциями (COUNT, SUM, AVG, MIN, MAX).
- Можно комбинировать несколько условий в `HAVING` через `AND`/`OR`.
- Часто WHERE и HAVING работают вместе: WHERE исключает ненужные строки, HAVING фильтрует группы.
- `HAVING` позволяет строить глубокие аналитические запросы с фильтрацией на уровне групп.

В следующем уроке мы разберем `ORDER BY` для сортировки результатов.
