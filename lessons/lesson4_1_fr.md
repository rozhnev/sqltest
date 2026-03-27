# Leçon 4.1 : Fonctions d'agrégation de base en SQL

Les fonctions d'agrégation en SQL permettent d'effectuer des calculs sur plusieurs lignes d'une colonne et de retourner une seule valeur. Elles sont essentielles pour résumer des données, générer des rapports et réaliser des analyses statistiques. Cette leçon couvre les fonctions d'agrégation les plus courantes avec des exemples pratiques basés sur la base Sakila.

## Fonctions d'agrégation courantes

### `COUNT()` — Compte le nombre de lignes

**Syntaxe :**
```sql
COUNT(expression)
```

**Exemple :**
```sql
SELECT COUNT(*) AS total_paiements
FROM payment;
```
**Résultat :** Retourne le nombre total de lignes dans la table `payment`.

### `COUNT(column)` vs `COUNT(*)`

Ces deux formes se ressemblent, mais elles ne sont pas identiques :

- `COUNT(*)` compte **toutes les lignes** du jeu de résultats ;
- `COUNT(column)` compte uniquement les lignes où `column` est **NOT NULL**.

Donc, si la colonne contient des valeurs `NULL`, `COUNT(column)` peut renvoyer un nombre inférieur à `COUNT(*)`.

**Exemple (Sakila) :**
```sql
SELECT
   COUNT(*) AS total_locations,
   COUNT(return_date) AS locations_retournees
FROM rental;
```

**Explication :**

- `total_locations` compte toutes les lignes de `rental` ;
- `locations_retournees` compte seulement les lignes où `return_date` est renseignée ;
- les locations non encore retournées ont `return_date = NULL`, donc elles sont exclues de `COUNT(return_date)`.

### `SUM()` — Calcule la somme des valeurs

**Syntaxe :**
```sql
SUM(expression)
```

**Exemple :**
```sql
SELECT SUM(amount) AS montant_total
FROM payment;
```
**Résultat :** Retourne la somme totale de la colonne `amount`.

**Commentaire :** la fonction `SUM(amount)` ignore les `NULL`. Si toutes les valeurs du jeu sont `NULL`, le résultat est `NULL`.

### `AVG()` — Calcule la valeur moyenne

**Syntaxe :**
```sql
AVG(expression)
```

**Exemple :**
```sql
SELECT AVG(amount) AS montant_moyen
FROM payment;
```
**Résultat :** Retourne la valeur moyenne de la colonne `amount`.

**Commentaire :** la fonction `AVG(amount)` prend en compte uniquement les lignes où `amount` n'est pas `NULL`.

Si vous devez inclure les lignes avec `NULL` dans le nombre de lignes (dénominateur), utilisez l'une des options suivantes :

```sql
SELECT
   AVG(amount) AS avg_ignore_null,
   AVG(COALESCE(amount, 0)) AS avg_include_null_as_zero,
   SUM(amount) / COUNT(*) AS avg_sum_div_all_rows
FROM payment;
```

**Explication :**

- `avg_ignore_null` correspond au comportement standard de `AVG`, où les `NULL` sont ignorés ;
- `avg_include_null_as_zero` remplace les `NULL` par `0`, donc toutes les lignes sont incluses dans le calcul ;
- `avg_sum_div_all_rows` divise la somme par le nombre total de lignes (`COUNT(*)`), ce qui inclut aussi les lignes avec `NULL` dans le dénominateur.

### `MAX()` — Trouve la valeur maximale

**Syntaxe :**
```sql
MAX(expression)
```

**Exemple :**
```sql
SELECT MAX(amount) AS montant_max
FROM payment;
```
**Résultat :** Retourne la plus grande valeur de la colonne `amount`.

**Commentaire :** la fonction `MAX(amount)` ignore les `NULL`. Si toutes les valeurs sont `NULL`, le résultat est `NULL`.

### `MIN()` — Trouve la valeur minimale

**Syntaxe :**
```sql
MIN(expression)
```

**Exemple :**
```sql
SELECT MIN(amount) AS montant_min
FROM payment;
```
**Résultat :** Retourne la plus petite valeur de la colonne `amount`.

**Commentaire :** la fonction `MIN(amount)` ignore les `NULL`. Si toutes les valeurs sont `NULL`, le résultat est `NULL`.

#### `MIN(column)` et `ORDER BY column LIMIT 1` — est-ce toujours identique ?

Pas toujours.

Comparons :

```sql
SELECT MIN(column_name) FROM table_name;
SELECT column_name FROM table_name ORDER BY column_name LIMIT 1;
```

- `MIN(column_name)` ignore les `NULL` et cherche le minimum parmi les valeurs non `NULL` ;
- `ORDER BY column_name LIMIT 1` retourne la première ligne après tri ;
- si `NULL` est trié en premier dans votre SGBD (par exemple MySQL/MariaDB en `ASC`), la seconde requête peut retourner `NULL`, alors que `MIN()` retourne la plus petite valeur non `NULL`.

Les résultats coïncident si :

- la colonne ne contient pas de `NULL` ;
- ou si `NULL` est trié en dernier ;
- ou si vous excluez explicitement les `NULL`.

**Version fiable, équivalente à `MIN()` :**

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NOT NULL
ORDER BY column_name
LIMIT 1;
```

## Utilisation pratique

1. **Compter le nombre de clients :**
   Utilisez `COUNT(*)` pour connaître le nombre de clients dans la base.
   ```sql
   SELECT COUNT(*) AS total_clients
   FROM customer;
   ```
2. **Calculer les ventes totales par employé :**
   Utilisez `SUM(amount)` avec `GROUP BY staff_id` pour voir les ventes par employé.
   ```sql
   SELECT staff_id, SUM(amount) AS total_employe
   FROM payment
   GROUP BY staff_id;
   ```
3. **Trouver le paiement moyen par client :**
   Utilisez `AVG(amount)` avec `GROUP BY customer_id`.
   ```sql
   SELECT customer_id, AVG(amount) AS paiement_moyen
   FROM payment
   GROUP BY customer_id;
   ```

## Points clés de cette leçon

Les fonctions d'agrégation SQL sont des outils puissants pour résumer et analyser les données. Maîtriser `COUNT`, `SUM`, `AVG`, `MIN` et `MAX` vous aidera à générer des rapports pertinents et des analyses à partir de votre base. Pratiquez ces fonctions avec la base Sakila pour renforcer vos compétences SQL.
