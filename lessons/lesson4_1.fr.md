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
