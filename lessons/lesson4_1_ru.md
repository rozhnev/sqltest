# Урок 4.1: Базовые агрегатные функции в SQL

Агрегатные функции в SQL используются для выполнения вычислений над несколькими строками столбца таблицы и возвращают одно итоговое значение. Эти функции необходимы для суммирования данных, создания отчетов и проведения статистического анализа. В этом уроке рассмотрены самые распространённые агрегатные функции с практическими примерами на базе данных Sakila.

## Основные агрегатные функции

### `COUNT()` — Считает количество строк

**Синтаксис:**
```sql
COUNT(expression)
```

**Пример:**
```sql
SELECT COUNT(*) AS total_payments
FROM payment;
```
**Результат:** Возвращает общее количество строк в таблице `payment`.

### `COUNT(column)` и `COUNT(*)`

Эти две формы похожи, но работают по-разному:

- `COUNT(*)` считает **все строки** в результирующем наборе;
- `COUNT(column)` считает только строки, где `column` имеет значение **NOT NULL**.

Поэтому, если в столбце есть `NULL`, результат `COUNT(column)` может быть меньше, чем `COUNT(*)`.

**Пример (Sakila):**
```sql
SELECT
   COUNT(*) AS total_rentals,
   COUNT(return_date) AS returned_rentals
FROM rental;
```

**Пояснение:**

- `total_rentals` считает все строки таблицы `rental`;
- `returned_rentals` считает только строки, где `return_date` заполнен;
- для невозвращённых аренд `return_date = NULL`, поэтому они не попадают в `COUNT(return_date)`.

### `SUM()` — Вычисляет сумму значений

**Синтаксис:**
```sql
SUM(expression)
```

**Пример:**
```sql
SELECT SUM(amount) AS total_amount
FROM payment;
```
**Результат:** Возвращает сумму значений столбца `amount`.

**Комментарий:** функция `SUM(amount)` игнорирует `NULL`. Если все значения в выборке `NULL`, результатом будет `NULL`.

### `AVG()` — Вычисляет среднее значение

**Синтаксис:**
```sql
AVG(expression)
```

**Пример:**
```sql
SELECT AVG(amount) AS average_amount
FROM payment;
```
**Результат:** Возвращает среднее значение столбца `amount`.

**Комментарий:** функция `AVG(amount)` учитывает в среднем только строки, где `amount` не `NULL`.

Если нужно включить строки с `NULL` в количество строк (знаменатель), используйте один из вариантов:

```sql
SELECT
   AVG(amount) AS avg_ignore_null,
   AVG(COALESCE(amount, 0)) AS avg_include_null_as_zero,
   SUM(amount) / COUNT(*) AS avg_sum_div_all_rows
FROM payment;
```

**Пояснение:**

- `avg_ignore_null` — стандартное поведение `AVG`, `NULL` не учитываются;
- `avg_include_null_as_zero` — `NULL` заменяются на `0`, и все строки попадают в расчет;
- `avg_sum_div_all_rows` — сумма делится на общее число строк `COUNT(*)`, что также включает строки с `NULL` в знаменатель.


### `MAX()` — Находит максимальное значение

**Синтаксис:**
```sql
MAX(expression)
```

**Пример:**
```sql
SELECT MAX(amount) AS max_amount
FROM payment;
```
**Результат:** Возвращает наибольшее значение в столбце `amount`.

**Комментарий:** функция `MAX(amount)` игнорирует `NULL`. Если все значения `NULL`, результатом будет `NULL`.

### `MIN()` — Находит минимальное значение

**Синтаксис:**
```sql
MIN(expression)
```

**Пример:**
```sql
SELECT MIN(amount) AS min_amount
FROM payment;
```
**Результат:** Возвращает наименьшее значение в столбце `amount`.

**Комментарий:** функция `MIN(amount)` игнорирует `NULL`. Если все значения `NULL`, результатом будет `NULL`.

#### `MIN(column)` и `ORDER BY column LIMIT 1` — всегда ли одно и то же?

Не всегда.

Сравним:

```sql
SELECT MIN(column_name) FROM table_name;
SELECT column_name FROM table_name ORDER BY column_name LIMIT 1;
```

- `MIN(column_name)` игнорирует `NULL` и ищет минимум среди не-`NULL` значений;
- `ORDER BY column_name LIMIT 1` возвращает первую строку после сортировки;
- если `NULL` в вашей СУБД сортируется первым (например, в MySQL/MariaDB при `ASC`), второй запрос может вернуть `NULL`, а `MIN()` при этом вернет минимальное не-`NULL` значение.

Они совпадут, если:

- в столбце нет `NULL`;
- или `NULL` сортируется последним;
- или вы явно исключили `NULL`.

**Надежный вариант, эквивалентный `MIN()`:**

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NOT NULL
ORDER BY column_name
LIMIT 1;
```

## Практическое применение

1. **Подсчет количества клиентов:**
   Используйте `COUNT(*)`, чтобы узнать, сколько клиентов в базе данных.
   ```sql
   SELECT COUNT(*) AS total_customers
   FROM customer;
   ```
2. **Вычисление общей суммы продаж по сотрудникам:**
   Используйте `SUM(amount)` с `GROUP BY staff_id`, чтобы увидеть продажи по каждому сотруднику.
   ```sql
   SELECT staff_id, SUM(amount) AS staff_total
   FROM payment
   GROUP BY staff_id;
   ```
3. **Нахождение среднего платежа по клиенту:**
   Используйте `AVG(amount)` с `GROUP BY customer_id`.
   ```sql
   SELECT customer_id, AVG(amount) AS avg_payment
   FROM payment
   GROUP BY customer_id;
   ```

## Основные выводы из этого урока

Агрегатные функции SQL — мощный инструмент для анализа и обобщения данных. Освоив `COUNT`, `SUM`, `AVG`, `MIN` и `MAX`, вы сможете создавать информативные отчеты и получать ценные инсайты из вашей базы данных. Практикуйтесь с этими функциями на примерах из базы Sakila для закрепления навыков.
