---
title: "Fonctions d'aggregation SQL: COUNT, SUM, AVG, MIN et MAX"
description: "Apprenez les fonctions d'aggregation SQL sur Sakila: COUNT, SUM, AVG, MIN, MAX, avec les differences entre COUNT(*), COUNT(column) et COUNT(DISTINCT ...)."
keywords: ["fonctions d'aggregation SQL", "COUNT", "SUM", "AVG", "MIN", "MAX", "COUNT DISTINCT"]
teaches: ["Utiliser les fonctions d'aggregation de base dans des requetes SELECT", "Comprendre les differences entre COUNT(*), COUNT(column) et COUNT(DISTINCT ...)", "Gerer correctement les valeurs NULL dans les calculs d'aggregation"]
about: ["SQL", "Aggregation", "COUNT DISTINCT", "Sakila"]
---

_Temps de lecture : ~8 minutes_

Les fonctions d'aggregation SQL permettent de transformer un ensemble de lignes en indicateurs de synthese: nombre, somme, moyenne, minimum et maximum. Dans cette lecon, vous allez travailler les agregats les plus utilises avec des exemples Sakila et apprendre a choisir le bon type de comptage selon le besoin. A la fin, vous saurez utiliser `COUNT`, `SUM`, `AVG`, `MIN` et `MAX` avec assurance en SQL analytique.

# Fonctions d'aggregation de base en SQL

Dans les lecons precedentes, vous recuperiez surtout des lignes detaillees. Nous passons maintenant a une etape cle: produire des valeurs de synthese a partir des donnees.

Les fonctions d'aggregation sont essentielles en reporting et en analyse, car elles repondent rapidement a des questions comme "combien?", "quel total?" ou "quelle moyenne?".

## Fonctions d'aggregation principales

### COUNT() - compte les lignes

Syntaxe de base:

```sql
COUNT(expression)
```

Exemple:

```sql
SELECT COUNT(*) AS total_paiements
FROM payment;
```

*Resultat: la requete retourne le nombre total de lignes dans la table payment.*

### COUNT(column) et COUNT(*)

Ces deux formes se ressemblent, mais leur logique differe:

- `COUNT(*)` compte toutes les lignes du resultat.
- `COUNT(column)` compte seulement les lignes ou `column` n'est pas `NULL`.

Si la colonne contient des `NULL`, `COUNT(column)` peut etre inferieur a `COUNT(*)`.

```sql
SELECT
    COUNT(*) AS total_locations,
    COUNT(return_date) AS locations_retournees
FROM rental;
```

*Explication: total_locations compte toutes les locations, alors que locations_retournees ne compte que celles avec return_date renseignee.*

### COUNT(DISTINCT ...) - compte les valeurs uniques

Quand vous devez compter des valeurs uniques et non des lignes, utilisez `COUNT(DISTINCT column)`.

```sql
SELECT COUNT(DISTINCT customer_id) AS clients_uniques
FROM payment;
```

*Resultat: la requete retourne le nombre de clients differents ayant effectue un paiement, meme si un client possede plusieurs lignes dans payment.*

En pratique, c'est indispensable pour des questions comme "combien de clients differents ont achete", ou `COUNT(*)` surestime a cause des repetitions.

### SUM() - calcule la somme

```sql
SELECT SUM(amount) AS montant_total
FROM payment;
```

*Resultat: retourne la somme de la colonne amount.*

`SUM(amount)` ignore les `NULL`. Si toutes les valeurs sont `NULL`, le resultat est `NULL`.

### AVG() - calcule la moyenne

```sql
SELECT AVG(amount) AS montant_moyen
FROM payment;
```

*Resultat: retourne la moyenne de amount sur les lignes non-NULL.*

Si vous voulez que les lignes avec `NULL` influencent le denominateur, utilisez une de ces approches:

```sql
SELECT
    AVG(amount) AS avg_ignore_null,
    AVG(COALESCE(amount, 0)) AS avg_include_null_as_zero,
    SUM(amount) / COUNT(*) AS avg_sum_div_all_rows
FROM payment;
```

### MAX() - trouve la valeur maximale

```sql
SELECT MAX(amount) AS montant_max
FROM payment;
```

*Resultat: retourne la plus grande valeur de amount.*

### MIN() - trouve la valeur minimale

```sql
SELECT MIN(amount) AS montant_min
FROM payment;
```

*Resultat: retourne la plus petite valeur de amount.*

`MIN()` et `MAX()` ignorent les `NULL`. Si toutes les valeurs sont `NULL`, le resultat est `NULL`.

### MIN(column) et ORDER BY ... LIMIT 1

Ces deux approches ne sont pas toujours equivalentes.

```sql
SELECT MIN(column_name)
FROM table_name;

SELECT column_name
FROM table_name
ORDER BY column_name
LIMIT 1;
```

- `MIN(column_name)` cherche le minimum parmi les valeurs non-`NULL`.
- `ORDER BY ... LIMIT 1` renvoie la premiere ligne apres tri.
- Si votre SGBD trie les `NULL` en premier, la deuxieme requete peut renvoyer `NULL`, alors que `MIN()` renvoie le minimum non-`NULL`.

Version fiable equivalente a `MIN()`:

```sql
SELECT column_name
FROM table_name
WHERE column_name IS NOT NULL
ORDER BY column_name
LIMIT 1;
```

---

## Utilisation pratique

### Compter les clients

```sql
SELECT COUNT(*) AS total_clients
FROM customer;
```

### Somme des ventes par employe

```sql
SELECT
    staff_id,
    SUM(amount) AS total_employe
FROM payment
GROUP BY staff_id;
```

### Paiement moyen par client

```sql
SELECT
    customer_id,
    AVG(amount) AS paiement_moyen
FROM payment
GROUP BY customer_id;
```

### Compter les clients payants uniques

```sql
SELECT COUNT(DISTINCT customer_id) AS clients_payants
FROM payment;
```

---

## Questions frequentes

### Quelle est la difference entre COUNT(*) et COUNT(column)?
`COUNT(*)` compte toutes les lignes. `COUNT(column)` compte uniquement les lignes ou la colonne specifiee n'est pas `NULL`.

### Quand utiliser COUNT(DISTINCT ...)?
Quand vous avez besoin du nombre de valeurs uniques, par exemple le nombre de clients differents plutot que le nombre total de paiements.

### Pourquoi AVG peut-il donner une valeur inattendue?
Parce que `AVG(column)` ignore les `NULL`. Si vous voulez inclure ces lignes dans le denominateur, utilisez `COALESCE` ou `SUM(column) / COUNT(*)`.

---

## Questions d'entretien

### Que sont les fonctions d'aggregation en SQL?
Ce sont des fonctions qui calculent une synthese sur plusieurs lignes, par exemple le nombre (`COUNT`), la somme (`SUM`) ou la moyenne (`AVG`). Elles retournent une valeur par groupe ou pour l'ensemble du resultat.

### Quelle est la difference entre COUNT(*), COUNT(column) et COUNT(DISTINCT column)?
`COUNT(*)` compte toutes les lignes, `COUNT(column)` compte les valeurs non-`NULL` de la colonne, et `COUNT(DISTINCT column)` compte les valeurs uniques non-`NULL`.

### Comment MIN et ORDER BY ... LIMIT 1 peuvent-ils differer?
Si une colonne contient des `NULL` et que le tri place `NULL` en premier, `ORDER BY ... LIMIT 1` peut retourner `NULL`, tandis que `MIN()` retourne le minimum non-`NULL`.

---

**Points cles de cette lecon:**

- Les fonctions d'aggregation donnent rapidement des metriques de synthese.
- `COUNT(*)`, `COUNT(column)` et `COUNT(DISTINCT ...)` repondent a des besoins de comptage differents.
- `SUM`, `AVG`, `MIN` et `MAX` ignorent en general les `NULL`, ce qui influence l'analyse.
- `COUNT(DISTINCT ...)` est essentiel pour compter des entites uniques plutot que des lignes.
- Une bonne gestion de `NULL` est cruciale pour la fiabilite des rapports.

Dans la prochaine lecon, nous verrons `GROUP BY` pour construire des agregations par categories.
