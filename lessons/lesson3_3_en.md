# Lesson 3.3: Essential Date and Time Functions in SQL

Date and time functions in SQL allow you to extract, modify, and format date and time values. These functions are widely used for analyzing temporal data, filtering by date, calculating intervals, and formatting output. This lesson covers the most commonly used functions with examples based on the Sakila database.

## Common Date and Time Functions

### `CURRENT_DATE` — Returns the current date (without time).

**Syntax:**
```sql
CURRENT_DATE
```

**Example:**
```sql
SELECT CURRENT_DATE AS today;
```
**Result:** The current date, e.g.: `2025-06-03`

### `CURRENT_TIME` — Returns the current time (without date).

**Syntax:**
```sql
CURRENT_TIME
```

**Example:**
```sql
SELECT CURRENT_TIME AS now_time;
```
**Result:** The current time, e.g.: `14:25:30`

### `CURRENT_TIMESTAMP` / `NOW()` — Returns the current date and time.

**Syntax:**
```sql
CURRENT_TIMESTAMP
NOW()
```

**Example:**
```sql
SELECT CURRENT_TIMESTAMP AS now_datetime;
SELECT NOW() AS now_datetime;
```
**Result:** The current date and time, e.g.: `2025-06-03 14:25:30`

### `DATE()` — Extracts only the date from a datetime value.

**Syntax:**
```sql
DATE(datetime_value)
```

**Example:**
```sql
SELECT DATE(rental_date) AS rental_only_date
FROM rental
LIMIT 3;
```
**Result:** Returns only the date from the `rental_date` column.

### `TIME()` — Extracts only the time from a datetime value.

**Syntax:**
```sql
TIME(datetime_value)
```

**Example:**
```sql
SELECT TIME(rental_date) AS rental_only_time
FROM rental
LIMIT 3;
```
**Result:** Returns only the time from the `rental_date` column.

### `YEAR()` — Extracts the year from a date value.

**Syntax:**
```sql
YEAR(date_value)
```

**Example:**
```sql
SELECT YEAR(rental_date) AS rental_year
FROM rental
LIMIT 3;
```
**Result:** Returns the year from the rental date.

### `MONTH()` — Extracts the month from a date value.

**Syntax:**
```sql
MONTH(date_value)
```

**Example:**
```sql
SELECT MONTH(rental_date) AS rental_month
FROM rental
LIMIT 3;
```
**Result:** Returns the month from the rental date.

### `DAY()` — Extracts the day of the month from a date value.

**Syntax:**
```sql
DAY(date_value)
```

**Example:**
```sql
SELECT DAY(rental_date) AS rental_day
FROM rental
LIMIT 3;
```
**Result:** Returns the day of the month from the rental date.

### `DATE_ADD()` — Adds a specified interval to a date.

**Syntax:**
```sql
DATE_ADD(date, INTERVAL value unit)
```

**Example:**
```sql
SELECT DATE_ADD(rental_date, INTERVAL 7 DAY) AS return_due
FROM rental
LIMIT 3;
```
**Result:** Returns the date increased by 7 days.

### `DATE_SUB()` — Subtracts a specified interval from a date.

**Syntax:**
```sql
DATE_SUB(date, INTERVAL value unit)
```

**Example:**
```sql
SELECT DATE_SUB(rental_date, INTERVAL 3 DAY) AS three_days_before
FROM rental
LIMIT 3;
```
**Result:** Returns the date decreased by 3 days.

### `DATEDIFF()` — Returns the number of days between two dates.

**Syntax:**
```sql
DATEDIFF(date1, date2)
```

**Example:**
```sql
SELECT DATEDIFF(return_date, rental_date) AS rental_duration
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Result:** The number of days between the return date and the rental date.

### `DATE_FORMAT()` — Formats a date in a specified format (MySQL).

**Syntax:**
```sql
DATE_FORMAT(date, format)
```

**Example:**
```sql
SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS formatted_date
FROM rental
LIMIT 3;
```
**Result:** Date in the format `dd.mm.yyyy`, e.g.: `03.06.2025`

**Common format specifiers:**
- `%Y`: Year (4 digits)
- `%m`: Month (2 digits)
- `%d`: Day of the month (2 digits)
- `%H`: Hour (24-hour format)
- `%i`: Minutes
- `%s`: Seconds

### `STRFTIME()` — Formats date/time (SQLite, PostgreSQL).

**Syntax:**
```sql
STRFTIME(format, date)
```

**Example:**
```sql
SELECT STRFTIME('%Y-%m-%d', rental_date) AS formatted_date
FROM rental
LIMIT 3;
```
**Result:** Date in the format `yyyy-mm-dd`.

### `TIMESTAMPDIFF()` — Difference between two dates/times in specified units (MySQL).

**Syntax:**
```sql
TIMESTAMPDIFF(unit, datetime1, datetime2)
```

**Example:**
```sql
SELECT TIMESTAMPDIFF(DAY, rental_date, return_date) AS days_rented
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Result:** The number of days between the rental and return dates.

### `EXTRACT()` — Extracts a part of a date or time (year, month, day, etc.).

**Syntax:**
```sql
EXTRACT(part FROM date)
```

**Example:**
```sql
SELECT EXTRACT(YEAR FROM rental_date) AS rental_year
FROM rental
LIMIT 3;
```
**Result:** Extracts the year from the rental date.

---

## Practical Usage

1. **Finding movies rented in the last 30 days:**
   ```sql
   SELECT *
   FROM rental
   WHERE rental_date > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
   ```
2. **Counting rentals per month:**
   ```sql
   SELECT YEAR(rental_date) AS year, MONTH(rental_date) AS month, COUNT(*) AS rentals
   FROM rental
   GROUP BY year, month
   ORDER BY year DESC, month DESC;
   ```
3. **Formatting rental date for a report:**
   ```sql
   SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS formatted_rental
   FROM rental
   LIMIT 5;
   ```

## Key Takeaways from This Lesson

Date and time functions allow you to flexibly analyze and transform temporal data in SQL. Use them for filtering, grouping, calculating intervals, and formatting dates in reports. Practice these functions with examples from the Sakila database to reinforce your skills.
