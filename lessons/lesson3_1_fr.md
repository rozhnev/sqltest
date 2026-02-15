# Leçon 3.1 : Utilisation des fonctions dans les requêtes SQL

Les fonctions SQL sont des routines intégrées qui effectuent des opérations spécifiques sur les données. Elles vous permettent de manipuler des données, d'effectuer des calculs et de formater les résultats au sein de vos requêtes SQL. Les fonctions peuvent être utilisées dans diverses parties d'une requête, comme la clause `SELECT` pour transformer la sortie, ou la clause `WHERE` pour filtrer les données en fonction de valeurs calculées.

## Que sont les fonctions SQL ?

Les fonctions SQL sont similaires aux fonctions d'autres langages de programmation. Elles acceptent des valeurs d'entrée (arguments), effectuent une opération spécifique et renvoient un résultat. Les fonctions peuvent être intégrées (fournies par le système de base de données) ou définies par l'utilisateur (créées par les utilisateurs). Cette leçon se concentre sur les fonctions intégrées.

## Syntaxe courante

La syntaxe générale pour utiliser une fonction en SQL est :

```sql
NOM_FONCTION(argument1, argument2, ...);
```

- **`NOM_FONCTION`** : Le nom de la fonction que vous souhaitez utiliser.
- **`argument1, argument2, ...`** : Les valeurs d'entrée (arguments) requises par la fonction. Il peut s'agir de noms de colonnes, de valeurs littérales ou même d'autres fonctions.

---

## Utilisation des fonctions dans la clause SELECT

Les fonctions dans la clause `SELECT` vous permettent de transformer ou de calculer des valeurs pour le résultat final.

### Exemple 1 : Fonction de chaîne (`UPPER`)
La fonction `UPPER()` convertit une chaîne en majuscules.

```sql
SELECT UPPER(first_name) AS uppercase_name
FROM employees;
```

Cette requête récupère la colonne `first_name` de la table `employees` et convertit chaque nom en majuscules, en donnant au résultat l'alias `uppercase_name`.

---

### Exemple 2 : Fonction mathématique (`ROUND`)
La fonction `ROUND()` arrondit un nombre à un nombre spécifié de décimales.

```sql
SELECT ROUND(salary, 0) AS rounded_salary
FROM employees;
```

Cette requête récupère la colonne `salary` de la table `employees` et arrondit chaque salaire au nombre entier le plus proche, avec l'alias `rounded_salary`.

---

### Exemple 3 : Fonction de date (`NOW`)
La fonction `NOW()` ne prend pas d'arguments et renvoie la date et l'heure actuelles.

```sql
SELECT NOW() AS current_datetime;
```

Cette requête renvoie la date et l'heure actuelles.

---

## Utilisation des fonctions dans la clause WHERE

Les fonctions dans la clause `WHERE` vous permettent de filtrer les données en fonction de valeurs calculées ou transformées.

### Exemple 1 : Fonction de chaîne (`LENGTH`)
La fonction `LENGTH()` (ou `LEN()` selon le SGBD) renvoie la longueur d'une chaîne.

```sql
SELECT *
FROM products
WHERE LENGTH(product_name) > 20;
```

Cette requête récupère toutes les colonnes de la table `products` où la longueur du `product_name` est supérieure à 20 caractères.

---

### Exemple 2 : Fonction de date (`YEAR`)
La fonction `YEAR()` extrait l'année d'une date.

```sql
SELECT *
FROM orders
WHERE YEAR(order_date) = 2023;
```

Cette requête récupère toutes les colonnes de la table `orders` où l'année de `order_date` est 2023.

---

### Exemple 3 : Fonction mathématique (`ABS`)
La fonction `ABS()` renvoie la valeur absolue d'un nombre.

```sql
SELECT *
FROM transactions
WHERE ABS(amount) > 100;
```

Cette requête récupère toutes les colonnes de la table `transactions` où la valeur absolue du montant (`amount`) est supérieure à 100.

---

## Types courants de fonctions SQL

Les fonctions SQL peuvent être globalement classées dans les types suivants :

1. **Fonctions de chaîne (String Functions)** : Utilisées pour manipuler des chaînes de caractères (ex : `UPPER`, `LOWER`, `SUBSTRING`, `LENGTH`, `TRIM`).
2. **Fonctions mathématiques (Mathematical Functions)** : Utilisées pour effectuer des calculs mathématiques (ex : `ROUND`, `ABS`, `SQRT`, `MOD`).
3. **Fonctions de date et d'heure (Date and Time Functions)** : Utilisées pour travailler avec les dates et les heures (ex : `NOW`, `YEAR`, `MONTH`, `DAY`, `DATE_ADD`, `DATE_SUB`).
4. **Fonctions d'agrégation (Aggregate Functions)** : Utilisées pour résumer les données (ex : `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`). (Abordées dans une leçon ultérieure)
5. **Fonctions de conversion (Conversion Functions)** : Utilisées pour convertir des données d'un type à un autre (ex : `CAST`, `CONVERT`).

---

## Bonnes pratiques

1. **Comprendre le comportement de la fonction** : Soyez conscient du comportement spécifique et des limites de chaque fonction que vous utilisez.
2. **Utiliser des alias** : Utilisez des alias (`AS`) pour donner des noms significatifs aux colonnes calculées.
3. **Vérifier les types de données** : Assurez-vous que les valeurs d'entrée (arguments) sont du bon type de données pour la fonction.
4. **Se référer à la documentation** : Consultez la documentation de votre système de base de données spécifique pour obtenir une liste complète des fonctions disponibles et de leur syntaxe.

**Points clés de cette leçon :**

En maîtrisant l'utilisation des fonctions dans les requêtes SQL, vous pouvez effectuer des manipulations et des analyses de données puissantes, extrayant ainsi des informations précieuses de vos données.
