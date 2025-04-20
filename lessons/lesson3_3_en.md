SQL provides several built-in functions to work with dates and times. These functions help you extract, manipulate, and format date/time values in your queries. Here’s a summary of the most commonly used date and time functions in SQL.

Lesson 3.3: Common SQL Date and Time functions


## 1. **CURRENT_DATE**
   - **Description**: Returns the current date (without the time) in the format `YYYY-MM-DD`.
   - **Example**:
     ```sql
     SELECT CURRENT_DATE;
     ```
   - **Result**: `2025-04-20` (example)

## 2. **CURRENT_TIME**
   - **Description**: Returns the current time (without the date) in the format `HH:MM:SS`.
   - **Example**:
     ```sql
     SELECT CURRENT_TIME;
     ```
   - **Result**: `15:30:45` (example)

## 3. **CURRENT_TIMESTAMP**
   - **Description**: Returns the current date and time (both date and time parts) in the format `YYYY-MM-DD HH:MM:SS`.
   - **Example**:
     ```sql
     SELECT CURRENT_TIMESTAMP;
     ```
   - **Result**: `2025-04-20 15:30:45` (example)

## 4. **NOW()**
   - **Description**: Returns the current date and time, equivalent to `CURRENT_TIMESTAMP`.
   - **Example**:
     ```sql
     SELECT NOW();
     ```
   - **Result**: `2025-04-20 15:30:45` (example)

## 5. **DATE()**
   - **Description**: Extracts the date part from a given date or datetime value.
   - **Example**:
     ```sql
     SELECT DATE('2025-04-20 15:30:45');
     ```
   - **Result**: `2025-04-20`

## 6. **TIME()**
   - **Description**: Extracts the time part from a given date or datetime value.
   - **Example**:
     ```sql
     SELECT TIME('2025-04-20 15:30:45');
     ```
   - **Result**: `15:30:45`

## 7. **YEAR()**
   - **Description**: Extracts the year from a date or datetime value.
   - **Example**:
     ```sql
     SELECT YEAR('2025-04-20');
     ```
   - **Result**: `2025`

## 8. **MONTH()**
   - **Description**: Extracts the month from a date or datetime value.
   - **Example**:
     ```sql
     SELECT MONTH('2025-04-20');
     ```
   - **Result**: `4` (for April)

## 9. **DAY()**
   - **Description**: Extracts the day of the month from a date or datetime value.
   - **Example**:
     ```sql
     SELECT DAY('2025-04-20');
     ```
   - **Result**: `20`

## 10. **DATE_ADD()**
   - **Description**: Adds a specified time interval to a date.
   - **Example**:
     ```sql
     SELECT DATE_ADD('2025-04-20', INTERVAL 5 DAY);
     ```
   - **Result**: `2025-04-25`

## 11. **DATE_SUB()**
   - **Description**: Subtracts a specified time interval from a date.
   - **Example**:
     ```sql
     SELECT DATE_SUB('2025-04-20', INTERVAL 5 DAY);
     ```
   - **Result**: `2025-04-15`

## 12. **DATEDIFF()**
   - **Description**: Returns the number of days between two dates.
   - **Example**:
     ```sql
     SELECT DATEDIFF('2025-04-20', '2025-04-15');
     ```
   - **Result**: `5`

## 13. **DATE_FORMAT()**
   - **Description**: Formats a date or datetime value according to a specific format.
   - **Example**:
     ```sql
     SELECT DATE_FORMAT('2025-04-20', '%Y-%m-%d');
     ```
   - **Result**: `2025-04-20`

   **Common Format Specifiers**:
   - `%Y`: Year (four digits)
   - `%m`: Month (two digits)
   - `%d`: Day of the month (two digits)
   - `%H`: Hour (24-hour format)
   - `%i`: Minutes
   - `%s`: Seconds

## 14. **STRFTIME()** (SQLite and PostgreSQL)
   - **Description**: Similar to `DATE_FORMAT()`, it formats date/time values in a specified format.
   - **Example**:
     ```sql
     SELECT STRFTIME('%Y-%m-%d', '2025-04-20');
     ```
   - **Result**: `2025-04-20`

## 15. **TIMESTAMPDIFF()**
   - **Description**: Returns the difference between two date/time values, measured in a specified unit (e.g., seconds, minutes, days).
   - **Example**:
     ```sql
     SELECT TIMESTAMPDIFF(DAY, '2025-04-15', '2025-04-20');
     ```
   - **Result**: `5`

## 16. **EXTRACT()**
   - **Description**: Extracts a part of a date or time value (like year, month, day, hour, etc.).
   - **Example**:
     ```sql
     SELECT EXTRACT(YEAR FROM '2025-04-20');
     ```
   - **Result**: `2025`

---

### Practical Usage Examples

1. **Finding users who registered in the last 30 days**:
   ```sql
   SELECT * 
   FROM users 
   WHERE registration_date > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
