# Урок 3.5: Условный оператор `CASE WHEN ... THEN ... END` в SQL

Оператор `CASE` в SQL позволяет реализовать условную логику прямо внутри запроса. С его помощью можно назначать категории, подставлять текстовые метки, фильтровать данные по сложным условиям и управлять порядком сортировки. Это один из самых полезных инструментов, когда нужно сделать запрос «умнее», не вынося логику в код приложения.

В этом уроке разберем:

- как устроен `CASE`;
- как использовать его в `SELECT`;
- как применять `CASE` в `WHERE`;
- как задавать кастомную сортировку через `CASE` в `ORDER BY`.

## Синтаксис `CASE`

`CASE` бывает в двух основных формах.

### 1) Простая форма (`simple CASE`)

```sql
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END
```

Эта форма сравнивает одно выражение (`expression`) с разными значениями.

### 2) Поисковая форма (`searched CASE`)

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

Здесь в каждом `WHEN` указывается полноценное условие. Эта форма более гибкая и используется чаще.

Важно:

- ветки проверяются сверху вниз;
- срабатывает первая подходящая ветка `WHEN`;
- если ни одно условие не подошло, используется `ELSE`;
- если `ELSE` не указан, возвращается `NULL`.

## `CASE` в `SELECT`

Самый популярный сценарий — добавить вычисляемый столбец с категорией или меткой.

### Пример: категоризация платежей

```sql
SELECT
    payment_id,
    amount,
    CASE
        WHEN amount < 2 THEN 'Низкий платеж'
        WHEN amount BETWEEN 2 AND 6 THEN 'Средний платеж'
        ELSE 'Высокий платеж'
    END AS payment_level
FROM payment
LIMIT 10;
```

**Что делает запрос:**

- для каждой строки таблицы `payment` оценивает значение `amount`;
- присваивает одну из трех категорий;
- выводит категорию в новом столбце `payment_level`.

### Пример: человекочитаемый статус возврата

```sql
SELECT
    rental_id,
    rental_date,
    return_date,
    CASE
        WHEN return_date IS NULL THEN 'Не возвращено'
        ELSE 'Возвращено'
    END AS rental_status
FROM rental
LIMIT 10;
```

Такой подход удобен для отчетов и дашбордов, где сырые значения нужно превратить в понятные статусы.

## `CASE` в `WHERE`

Хотя чаще `CASE` используют в `SELECT`, он также может участвовать в фильтрации. Обычно это полезно, когда условие зависит от другой колонки или от параметра логики.

### Пример: разный порог суммы для разных сотрудников

```sql
SELECT
    payment_id,
    staff_id,
    amount
FROM payment
WHERE amount >= CASE
    WHEN staff_id = 1 THEN 5
    WHEN staff_id = 2 THEN 3
    ELSE 4
END;
```

**Логика фильтра:**

- для `staff_id = 1` отбираются платежи с `amount >= 5`;
- для `staff_id = 2` — с `amount >= 3`;
- для остальных — с `amount >= 4`.

### Когда лучше альтернатива

Для простых случаев условие через `OR` часто читается легче. Но `CASE` в `WHERE` полезен, когда правило фильтрации действительно ветвится и должно оставаться в одном выражении.

## `CASE` в `ORDER BY`

Очень частая задача — сортировать не по алфавиту или числу, а по бизнес-приоритету. `CASE` отлично решает это.

### Пример: сортировка фильмов по рейтингу в заданном порядке

```sql
SELECT
    title,
    rating
FROM film
ORDER BY CASE rating
    WHEN 'G' THEN 1
    WHEN 'PG' THEN 2
    WHEN 'PG-13' THEN 3
    WHEN 'R' THEN 4
    WHEN 'NC-17' THEN 5
    ELSE 6
END,
 title;
```

**Результат:** сначала идут фильмы с более «мягким» рейтингом, затем с более строгим, независимо от стандартной сортировки строк.

### Пример: показывать невозвращенные аренды первыми

```sql
SELECT
    rental_id,
    rental_date,
    return_date
FROM rental
ORDER BY CASE
    WHEN return_date IS NULL THEN 0
    ELSE 1
END,
 rental_date DESC
LIMIT 20;
```

Так можно выводить самые важные записи в начало результата.

## Практическое применение

1. **Сегментация клиентов по тратам:**
   ```sql
   SELECT
       customer_id,
       SUM(amount) AS total_spent,
       CASE
           WHEN SUM(amount) < 50 THEN 'Базовый'
           WHEN SUM(amount) < 100 THEN 'Активный'
           ELSE 'VIP'
       END AS customer_segment
   FROM payment
   GROUP BY customer_id;
   ```

2. **Подсчет количества записей по условным группам:**
   ```sql
   SELECT
       SUM(CASE WHEN amount < 2 THEN 1 ELSE 0 END) AS low_count,
       SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 ELSE 0 END) AS medium_count,
       SUM(CASE WHEN amount > 6 THEN 1 ELSE 0 END) AS high_count
   FROM payment;
   ```

3. **Кастомный приоритет для отчета:**
   ```sql
   SELECT
       title,
       replacement_cost
   FROM film
   ORDER BY CASE
       WHEN replacement_cost >= 25 THEN 1
       WHEN replacement_cost >= 20 THEN 2
       ELSE 3
   END,
   replacement_cost DESC;
   ```

## Основные выводы из этого урока

`CASE WHEN ... THEN ... END` — универсальный инструмент условной логики в SQL.

Ключевые идеи:

- в `SELECT` он помогает строить категории и статусы;
- в `WHERE` позволяет задавать ветвящуюся фильтрацию;
- в `ORDER BY` дает полный контроль над пользовательским порядком сортировки;
- почти всегда стоит добавлять `ELSE`, чтобы избежать неожиданных `NULL`.

Освоив `CASE`, вы сможете делать запросы гибче, понятнее и ближе к бизнес-логике прямо на уровне SQL.
