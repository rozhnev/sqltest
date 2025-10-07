# Урок 4.3: Фильтрация сгруппированных данных с помощью HAVING в SQL

В SQL при работе с агрегированными данными часто возникает необходимость отфильтровать группы после выполнения группировки. Для этого используется оператор `HAVING`, который позволяет накладывать условия на группы, сформированные с помощью `GROUP BY`. Это похоже на то, как `WHERE` фильтрует отдельные строки до группировки. В этом уроке вы научитесь применять `HAVING` для фильтрации агрегированных данных на примерах из базы данных Sakila.

## Роль HAVING

- `WHERE` фильтрует строки до группировки.
- `HAVING` фильтрует группы после агрегации.

### Синтаксис

```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1
HAVING condition;
```

## Пример: Клиенты с общей суммой платежей выше порога

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```
**Результат:** Возвращает только тех клиентов, чья общая сумма платежей превышает 100.

## Пример: Сотрудники, обработавшие более 50 платежей

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```
**Результат:** Показывает только тех сотрудников, которые обработали более 50 платежей.

## Пример: Фильтрация по среднему размеру платежа

```sql
SELECT customer_id, AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```
**Результат:** Список клиентов, у которых средний размер платежа не менее 5.

## Использование HAVING с несколькими условиями

Вы можете комбинировать несколько условий в `HAVING` с помощью `AND`/`OR`.

```sql
SELECT staff_id, COUNT(*) AS payments_count, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```
**Результат:** Возвращает сотрудников, которые обработали более 50 платежей и чья общая сумма платежей превышает 500.

## Практическое применение

1. **Категории фильмов с наибольшими продажами:**
   ```sql
   SELECT c.name AS category, SUM(p.amount) AS total_sales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name
   HAVING SUM(p.amount) > 2000;
   ```
   *Показывает только категории с суммарными продажами выше 2000.*

2. **Страны с более чем 20 клиентами:**
   ```sql
   SELECT country, COUNT(*) AS customers_count
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY country
   HAVING COUNT(*) > 20;
   ```
   *Список стран, в которых более 20 клиентов.*

## Основные выводы из этого урока

- Используйте `HAVING` для фильтрации групп после агрегации.
- `HAVING` работает с агрегатными функциями, а `WHERE` — нет.
- Комбинируйте `HAVING` с `GROUP BY` для мощного анализа и отчетности.

Практикуйтесь с использованием `HAVING` в своих запросах, чтобы получать более глубокие аналитические данные из сгруппированных данных в SQL.
