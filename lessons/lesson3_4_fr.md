# Lecon 3.4 : Fonctions essentielles de date et d'heure en SQL

Les fonctions de date et d'heure en SQL permettent d'extraire, de modifier et de formater des valeurs de date et d'heure. Ces fonctions sont largement utilisees pour analyser des donnees temporelles, filtrer par date, calculer des intervalles et formater la sortie. Cette lecon couvre les fonctions les plus courantes avec des exemples bases sur la base de donnees Sakila.

*Important* : `CURRENT_DATE`, `CURRENT_TIME`, `CURRENT_TIMESTAMP` sont, dans de nombreux SGBD, des expressions SQL speciales (ou des alias de fonctions correspondantes), et non des "fonctions classiques" du type `NAME(arg1, arg2, ...)`. Pour cette raison, la syntaxe et certains details de comportement peuvent varier selon le SGBD.

## Fonctions de date et d'heure courantes

### `CURRENT_DATE` - Expression speciale qui renvoie la date actuelle (sans l'heure).

**Syntaxe :**
```sql
CURRENT_DATE
```

**Exemple :**
```sql
SELECT CURRENT_DATE AS today;
```
**Resultat :** La date actuelle, par exemple : `2025-06-03`

### `CURRENT_TIME` - Expression speciale/alias qui renvoie l'heure actuelle (sans la date).

**Syntaxe :**
```sql
CURRENT_TIME
CURRENT_TIME()
CURRENT_TIME(precision)
```

**Exemple :**
```sql
SELECT CURRENT_TIME AS now_time;
```
**Resultat :** L'heure actuelle. Avec une precision specifiee (par exemple `CURRENT_TIME(3)`), la valeur inclut des fractions de seconde.

### `CURRENT_TIMESTAMP` / `NOW()` - Renvoie la date et l'heure actuelles (souvent comme expression speciale/alias).

**Syntaxe :**
```sql
CURRENT_TIMESTAMP
CURRENT_TIMESTAMP()
CURRENT_TIMESTAMP(precision)
NOW()
```

**Exemple :**
```sql
SELECT CURRENT_TIMESTAMP AS now_datetime;
SELECT NOW() AS now_datetime;
```
**Resultat :** La date et l'heure actuelles, par exemple : `2025-06-03 14:25:30`

*Important* : dans la plupart des SGBD, `CURRENT_DATE`/`CURRENT_TIME`/`CURRENT_TIMESTAMP` sont figes au debut de l'execution de la requete (et, dans certains modes, au debut de la transaction). Donc, dans une meme requete, toutes les lignes recoivent generalement la meme valeur.

Si vous avez besoin d'un "horodatage courant" exactement au moment de l'evaluation pour chaque ligne, utilisez des alternatives specifiques au SGBD (par exemple `SYSDATE()` en MySQL/MariaDB, `clock_timestamp()` en PostgreSQL).

### `DATE()` - Extrait uniquement la date d'une valeur datetime.

**Syntaxe :**
```sql
DATE(datetime_value)
```

**Exemple :**
```sql
SELECT DATE(rental_date) AS rental_only_date
FROM rental
LIMIT 3;
```
**Resultat :** Renvoie uniquement la date de la colonne `rental_date`.

### `TIME()` - Extrait uniquement l'heure d'une valeur datetime.

**Syntaxe :**
```sql
TIME(datetime_value)
```

**Exemple :**
```sql
SELECT TIME(rental_date) AS rental_only_time
FROM rental
LIMIT 3;
```
**Resultat :** Renvoie uniquement l'heure de la colonne `rental_date`.

### `YEAR()` - Extrait l'annee d'une date.

**Syntaxe :**
```sql
YEAR(date_value)
```

**Exemple :**
```sql
SELECT YEAR(rental_date) AS rental_year
FROM rental
LIMIT 3;
```
**Resultat :** Renvoie l'annee de la date de location.

### `MONTH()` - Extrait le mois d'une date.

**Syntaxe :**
```sql
MONTH(date_value)
```

**Exemple :**
```sql
SELECT MONTH(rental_date) AS rental_month
FROM rental
LIMIT 3;
```
**Resultat :** Renvoie le mois de la date de location.

### `DAY()` - Extrait le jour du mois d'une date.

**Syntaxe :**
```sql
DAY(date_value)
```

**Exemple :**
```sql
SELECT DAY(rental_date) AS rental_day
FROM rental
LIMIT 3;
```
**Resultat :** Renvoie le jour du mois de la date de location.

### `DATE_ADD()` - Ajoute un intervalle specifie a une date.

**Syntaxe :**
```sql
DATE_ADD(date, INTERVAL value unit)
```

**Exemple :**
```sql
SELECT DATE_ADD(rental_date, INTERVAL 7 DAY) AS return_due
FROM rental
LIMIT 3;
```
**Resultat :** Renvoie la date augmentee de 7 jours.

### `DATE_SUB()` - Soustrait un intervalle specifie d'une date.

**Syntaxe :**
```sql
DATE_SUB(date, INTERVAL value unit)
```

**Exemple :**
```sql
SELECT DATE_SUB(rental_date, INTERVAL 3 DAY) AS three_days_before
FROM rental
LIMIT 3;
```
**Resultat :** Renvoie la date diminuee de 3 jours.

### `DATEDIFF()` - Renvoie le nombre de jours entre deux dates.

**Syntaxe :**
```sql
DATEDIFF(date1, date2)
```

**Exemple :**
```sql
SELECT DATEDIFF(return_date, rental_date) AS rental_duration
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Resultat :** Le nombre de jours entre la date de retour et la date de location.

### `DATE_FORMAT()` - Formate une date dans un format specifie (MySQL).

**Syntaxe :**
```sql
DATE_FORMAT(date, format)
```

**Exemple :**
```sql
SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS formatted_date
FROM rental
LIMIT 3;
```
**Resultat :** Date au format `jj.mm.aaaa`, par exemple : `03.06.2025`

**Specificateurs de format courants :**
- `%Y` : Annee (4 chiffres)
- `%m` : Mois (2 chiffres)
- `%d` : Jour du mois (2 chiffres)
- `%H` : Heure (format 24h)
- `%i` : Minutes
- `%s` : Secondes

### `STRFTIME()` - Formate une date/heure (SQLite, PostgreSQL).

**Syntaxe :**
```sql
STRFTIME(format, date)
```

**Exemple :**
```sql
SELECT STRFTIME('%Y-%m-%d', rental_date) AS formatted_date
FROM rental
LIMIT 3;
```
**Resultat :** Date au format `aaaa-mm-jj`.

### `TIMESTAMPDIFF()` - Difference entre deux dates/heures dans des unites specifiees (MySQL).

**Syntaxe :**
```sql
TIMESTAMPDIFF(unit, datetime1, datetime2)
```

**Exemple :**
```sql
SELECT TIMESTAMPDIFF(DAY, rental_date, return_date) AS days_rented
FROM rental
WHERE return_date IS NOT NULL
LIMIT 3;
```
**Resultat :** Le nombre de jours entre la date de location et la date de retour.

### `EXTRACT()` - Extrait une partie d'une date ou d'une heure (annee, mois, jour, etc.).

**Syntaxe :**
```sql
EXTRACT(part FROM date)
```

**Exemple :**
```sql
SELECT EXTRACT(YEAR FROM rental_date) AS rental_year
FROM rental
LIMIT 3;
```
**Resultat :** Extrait l'annee de la date de location.

---

## Utilisation pratique

1. **Trouver les films loues au cours des 30 derniers jours :**
   ```sql
   SELECT *
   FROM rental
   WHERE rental_date > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
   ```
2. **Compter les locations par mois :**
   ```sql
   SELECT YEAR(rental_date) AS year, MONTH(rental_date) AS month, COUNT(*) AS rentals
   FROM rental
   GROUP BY year, month
   ORDER BY year DESC, month DESC;
   ```
3. **Formater la date de location pour un rapport :**
   ```sql
   SELECT DATE_FORMAT(rental_date, '%d.%m.%Y') AS formatted_rental
   FROM rental
   LIMIT 5;
   ```

## Points cles de cette lecon

Les fonctions de date et d'heure permettent d'analyser et de transformer de facon flexible les donnees temporelles en SQL. Utilisez-les pour filtrer, grouper, calculer des intervalles et formater des dates dans des rapports. Entrainez-vous avec ces fonctions sur des exemples de la base Sakila pour consolider vos competences.
