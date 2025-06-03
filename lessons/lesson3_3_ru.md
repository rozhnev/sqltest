# Урок 3.3: Основные функции работы с датой и временем в SQL

Функции работы с датой и временем в SQL позволяют извлекать, изменять и форматировать значения дат и времени. Эти функции широко используются для анализа временных данных, фильтрации по дате, вычисления интервалов и форматирования вывода. В этом уроке рассмотрены наиболее часто используемые функции с примерами на базе данных Sakila.

## Общие функции даты и времени

### `CURRENT_DATE` — Возвращает текущую дату (без времени).

**Синтаксис:**
```sql
CURRENT_DATE
```

**Пример:**
```sql
SELECT CURRENT_DATE AS today;
```
**Результат:** Текущая дата, например: `2025-06-03`

### `CURRENT_TIME` — Возвращает текущее время (без даты).

**Синтаксис:**
```sql
CURRENT_TIME
```

**Пример:**
```sql
SELECT CURRENT_TIME AS now_time;
```
**Результат:** Текущее время, например: `14:25:30`

### `CURRENT_TIMESTAMP` / `NOW()` — Возвращает текущие дату и время.

**Синтаксис:**
```sql
CURRENT_TIMESTAMP
NOW()
```

**Пример:**
```sql
SELECT CURRENT_TIMESTAMP AS now_datetime;
SELECT NOW() AS now_datetime;
```
**Результат:** Текущие дата и время, например: `2025-06-03 14:25:30`

### `DATE()` — Извлекает только дату из значения даты и времени.

**Синтаксис:**
```sql
DATE(datetime_value)
```

**Пример:**
```sql
SELECT DATE(rental_date) AS rental_only_date
FROM rental
LIMIT 3;
```
**Результат:** Возвращает только дату из столбца `rental_date`.

### `TIME()` — Извлекает только время из значения даты и времени.

**Синтаксис:**
```sql
TIME(datetime_value)
```

**Пример:**
```sql
SELECT TIME(rental_date) AS rental_only_time
FROM rental
LIMIT 3;
```
**Результат:** Возвращает только время из столбца `rental_date`.

### `YEAR()` — Извлекает год из значения даты.

**Синтаксис:**
```sql
YEAR(date_value)
```

**Пример:**
```sql
SELECT YEAR(rental_date) AS rental_year
FROM rental
LIMIT 3;
```
**Результат:** Возвращает год из даты аренды.

### `MONTH()` — Извлекает месяц из значения даты.

**Синтаксис:**
```sql
MONTH(date_value)
```

**Пример:**
```sql
SELECT MONTH(rental_date) AS rental_month
FROM rental
LIMIT 3;
```
**Результат:** Возвращает месяц из даты аренды.

### `DAY()` — Извлекает день месяца из значения даты.

**Синтаксис:**
```sql
DAY(date_value)
```

**Пример:**
```sql
SELECT DAY(rental_date) AS rental_day
FROM rental
LIMIT 3;
```
**Результат:** Возвращает день месяца из даты аренды.

### `DATE_ADD()` — Добавляет указанный интервал к дате.

**Синтаксис:**
```sql
DATE_ADD(date, INTERVAL value unit)
```

**Пример:**
```sql
SELECT DATE_ADD(rental_date, INTERVAL 7 DAY) AS return_due
FROM rental
LIMIT 3;
```
**Результат:** Возвращает дату, увеличенную на 7 дней.

### `DATE_SUB()` — Вычитает указанный интервал из даты.

**Синтаксис:**
```sql
DATE_SUB(date, INTERVAL value unit)
```

**Пример:**
```sql
SELECT DATE_SUB(rental_date, INTERVAL 3 DAY) AS three_days_before
FROM rental
LIMIT 3;
```
**Результат:** Возвращает дату, уменьшенную на 3 дня.

### `DATEDIFF()` — Возвращает количество дней между двумя датами.

**Синтаксис:**
```sql
DATEDIFF(date1, date2)
```

**Пример:**
```sql
SELECT DATEDIFF(return_date, rental_date) AS rental_duration
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Результат:** Количество дней между датой возврата и датой аренды.

### `DATE_FORMAT()` — Форматирует дату в заданном формате (MySQL).

**Синтаксис:**
```sql
DATE_FORMAT(date, format)
```

**Пример:**
```sql
SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS formatted_date
FROM rental
LIMIT 3;
```
**Результат:** Дата в формате `дд.мм.гггг`, например: `03.06.2025`

**Общие спецификаторы формата:**
- `%Y`: Год (4 цифры)
- `%m`: Месяц (2 цифры)
- `%d`: День месяца (2 цифры)
- `%H`: Час (24-часовой формат)
- `%i`: Минуты
- `%s`: Секунды

### `STRFTIME()` — Форматирует дату/время (SQLite, PostgreSQL).

**Синтаксис:**
```sql
STRFTIME(format, date)
```

**Пример:**
```sql
SELECT STRFTIME('%Y-%m-%d', rental_date) AS formatted_date
FROM rental
LIMIT 3;
```
**Результат:** Дата в формате `гггг-мм-дд`.

### `TIMESTAMPDIFF()` — Разница между двумя датами/временем в заданных единицах (MySQL).

**Синтаксис:**
```sql
TIMESTAMPDIFF(unit, datetime1, datetime2)
```

**Пример:**
```sql
SELECT TIMESTAMPDIFF(DAY, rental_date, return_date) AS days_rented
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Результат:** Количество дней между датой аренды и возврата.

### `EXTRACT()` — Извлекает часть даты или времени (год, месяц, день и т.д.).

**Синтаксис:**
```sql
EXTRACT(part FROM date)
```

**Пример:**
```sql
SELECT EXTRACT(YEAR FROM rental_date) AS rental_year
FROM rental
LIMIT 3;
```
**Результат:** Извлекает год из даты аренды.

---

## Практическое применение

1. **Нахождение фильмов, арендованных за последние 30 дней:**
   ```sql
   SELECT *
   FROM rental
   WHERE rental_date > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
   ```
2. **Подсчет количества аренд в каждом месяце:**
   ```sql
   SELECT YEAR(rental_date) AS year, MONTH(rental_date) AS month, COUNT(*) AS rentals
   FROM rental
   GROUP BY year, month
   ORDER BY year DESC, month DESC;
   ```
3. **Форматирование даты аренды для отчета:**
   ```sql
   SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS formatted_rental
   FROM rental
   LIMIT 5;
   ```

## Основные выводы из этого урока

Функции работы с датой и временем позволяют гибко анализировать и преобразовывать временные данные в SQL. Используйте их для фильтрации, группировки, вычисления интервалов и форматирования дат в отчетах. Практикуйтесь с этими функциями на примерах из базы данных Sakila для закрепления навыков.
