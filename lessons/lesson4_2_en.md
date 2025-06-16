# Урок 4.2: Группировка данных с помощью GROUP BY в SQL

Группировка данных — важный инструмент для анализа и обобщения информации в SQL. Оператор `GROUP BY` позволяет объединять строки с одинаковыми значениями в указанных столбцах и применять агрегатные функции к каждой группе. В этом уроке вы узнаете, как использовать `GROUP BY` для создания отчетов и анализа данных на примерах из базы Sakila.

## Основы использования GROUP BY

### Синтаксис
```sql
SELECT column1, AGG_FUNCTION(column2)
FROM table
GROUP BY column1;
```

### Пример: Сумма платежей по каждому клиенту
```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
```
**Результат:** Возвращает сумму всех платежей для каждого клиента.

### Пример: Количество платежей по сотруднику
```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id;
```
**Результат:** Показывает, сколько платежей обработал каждый сотрудник.

### Пример: Средний платеж по дате
```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY pay_date;
```
**Результат:** Возвращает средний размер платежа по каждой дате.

## Использование GROUP BY с несколькими столбцами

Вы можете группировать данные сразу по нескольким столбцам для более детального анализа.

### Пример: Сумма платежей по сотруднику и клиенту
```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id, customer_id;
```
**Результат:** Показывает, сколько каждый сотрудник получил от каждого клиента.

## Практическое применение

1. **Анализ продаж по категориям фильмов:**
   ```sql
   SELECT c.name AS category, SUM(p.amount) AS total_sales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name;
   ```
2. **Количество клиентов по странам:**
   ```sql
   SELECT country, COUNT(*) AS customers_count
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY country;
   ```

## Основные выводы из этого урока

Оператор `GROUP BY` позволяет группировать данные и применять агрегатные функции к каждой группе. Это мощный инструмент для создания отчетов и анализа информации в SQL. Практикуйтесь с `GROUP BY` на примерах из базы Sakila, чтобы научиться быстро получать сводные данные и строить аналитические запросы.
