---
title: "Clause SQL WHERE : filtrer les données avec BETWEEN, IN, LIKE et NULL"
description: "La clause SQL WHERE filtre les lignes par condition. Apprenez les opérateurs de comparaison, BETWEEN, IN, la recherche LIKE et la gestion correcte des valeurs NULL."
keywords: ["clause SQL WHERE", "filtrer données SQL", "BETWEEN IN LIKE SQL", "IS NULL SQL", "opérateurs de comparaison SQL", "tutoriel WHERE SQL"]
---

_Leçon 2.2 · Temps de lecture : ~6 min_

La **clause SQL WHERE** filtre les lignes d'une table en évaluant une condition pour chaque enregistrement — seules les lignes où la condition est vraie sont retournées. Dans cette leçon, vous apprendrez les opérateurs de comparaison, `BETWEEN`, `IN`, la recherche de motifs avec `LIKE` et la bonne façon de gérer les valeurs `NULL`.

# Clause SQL WHERE : filtrer les données dans les requêtes SELECT

L'instruction `SELECT` seule renvoie toutes les lignes d'une table. En pratique, vous n'avez généralement besoin que d'un sous-ensemble de données répondant à des critères précis — c'est exactement à cela que sert la clause `WHERE`.

## Qu'est-ce que la clause SQL WHERE ?

La clause `WHERE` filtre les enregistrements avant qu'ils soient inclus dans le résultat. Seules les lignes satisfaisant la condition spécifiée sont retournées.

### Syntaxe de base

```sql
SELECT colonne1, colonne2, ...
FROM nom_table
WHERE condition;
```

La condition est une expression qui s'évalue à vrai (true), faux (false) ou inconnu (si des valeurs `NULL` sont impliquées). Seules les lignes où la condition est **vraie** sont retournées.

---

## Opérateurs de comparaison SQL dans WHERE

SQL propose un ensemble d'opérateurs pour comparer les valeurs dans la clause `WHERE` :

| Opérateur | Description | Exemple |
| :--- | :--- | :--- |
| `=` | Égal à | `WHERE last_name = 'SMITH'` |
| `<>` ou `!=` | Différent de | `WHERE store_id <> 1` |
| `>` | Supérieur à | `WHERE rental_rate > 2.99` |
| `<` | Inférieur à | `WHERE length < 60` |
| `>=` | Supérieur ou égal à | `WHERE replacement_cost >= 20.00` |
| `<=` | Inférieur ou égal à | `WHERE amount <= 5.00` |

```sql
SELECT title, rental_rate, replacement_cost
FROM film
WHERE rental_rate = 4.99;
```

*Résultat : tous les films dont le tarif de location est exactement 4,99 $.*

---

## Opérateurs SQL BETWEEN, IN et LIKE

SQL inclut des opérateurs puissants pour filtrer par plage, par liste et par motif.

### BETWEEN — filtre par plage

Filtre les valeurs dans un intervalle donné (bornes incluses).

```sql
SELECT payment_id, amount, payment_date
FROM payment
WHERE amount BETWEEN 5.00 AND 10.00;
```

*Résultat : paiements de 5,00 $ à 10,00 $ inclus.*

### IN — correspondance avec une liste

Vérifie si une valeur appartient à une liste spécifiée. Alternative concise à plusieurs conditions `OR`.

```sql
SELECT first_name, last_name, store_id
FROM customer
WHERE store_id IN (1, 2);
```

*Résultat : clients appartenant au magasin 1 ou 2.*

### LIKE — recherche par motif

Recherche un motif dans une colonne de texte à l'aide de caractères génériques :
- `%` — zéro, un ou plusieurs caractères quelconques.
- `_` — exactement un caractère.

```sql
-- Films dont le titre commence par 'A'
SELECT title
FROM film
WHERE title LIKE 'A%';

-- Films dont la deuxième lettre du titre est 'I'
SELECT title
FROM film
WHERE title LIKE '_I%';
```

---

## Comment filtrer les valeurs NULL en SQL

Il est impossible d'utiliser `=` ou `<>` pour vérifier `NULL` — ces comparaisons retournent toujours inconnu, jamais vrai. Utilisez `IS NULL` ou `IS NOT NULL`.

```sql
-- Incorrect : ne renvoie aucune ligne
-- WHERE return_date = NULL

-- Correct
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL;
```

*Résultat : toutes les locations qui n'ont pas encore été retournées.*

---

**Points clés :**

* La clause `WHERE` filtre les lignes **avant** qu'elles ne soient retournées dans le résultat.
* Les chaînes et les dates doivent être entourées de guillemets simples (`'SMITH'`) ; les nombres n'en ont pas besoin.
* `BETWEEN` est inclusif : `BETWEEN 5 AND 10` inclut 5 et 10.
* `IN` est une alternative concise à plusieurs conditions `OR`.
* `LIKE` utilise `%` (séquence quelconque) et `_` (un seul caractère).
* **N'utilisez jamais** `=` avec `NULL` — utilisez toujours `IS NULL` ou `IS NOT NULL`.

---

## Questions fréquentes

### Quelle est la différence entre WHERE et HAVING en SQL ?
`WHERE` filtre les lignes **avant** le regroupement et l'agrégation. `HAVING` filtre **après** — il travaille sur les résultats de `GROUP BY`. Utilisez `WHERE` pour filtrer des lignes individuelles, `HAVING` pour filtrer des groupes agrégés.

### Peut-on utiliser plusieurs conditions dans WHERE ?
Oui. Combinez les conditions avec `AND` (les deux doivent être vraies), `OR` (au moins une doit être vraie) ou `NOT` (négation). Utilisez des parenthèses pour contrôler l'ordre d'évaluation.

### Pourquoi `WHERE colonne = NULL` ne retourne-t-il aucun résultat ?
Parce que `NULL` représente une valeur inconnue — comparer quoi que ce soit à `NULL` avec `=` retourne toujours inconnu, jamais vrai ou faux. SQL exige `IS NULL` ou `IS NOT NULL` pour vérifier l'absence de valeur.

→ [Leçon 2.3 : Combiner plusieurs conditions avec AND, OR et NOT](lesson2_3_fr.md)
