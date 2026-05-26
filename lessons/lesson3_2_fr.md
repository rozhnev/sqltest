---
title: "Fonctions de chaîne SQL : UPPER, LOWER, TRIM, SUBSTRING et CONCAT"
description: "Apprenez les principales fonctions de chaîne SQL avec des exemples Sakila : nettoyer, combiner et extraire des données textuelles dans des requêtes pratiques."
keywords: ["fonctions de chaîne SQL", "UPPER LOWER SQL", "TRIM SQL", "SUBSTRING SQL", "CONCAT SQL", "SQL Sakila"]
teaches: ["Comment utiliser les fonctions de chaîne principales dans des requêtes SQL", "Comment gérer correctement la longueur des chaînes et les valeurs NULL", "Comment nettoyer et formater des champs texte dans des cas pratiques", "Comment extraire des parties de chaîne pour l'analyse"]
about: ["SQL", "Fonctions de chaîne", "Traitement de texte", "Base de données Sakila", "Base de données relationnelle"]
---

_Leçon 3.2 · Temps de lecture : ~8 min_

Dans cette leçon, vous allez apprendre les fonctions de chaîne SQL qui permettent de nettoyer et de transformer du texte directement dans les requêtes. Nous verrons quand utiliser `UPPER`, `LOWER`, `TRIM`, `SUBSTRING`, `CONCAT` et d'autres fonctions, puis nous passerons à des exemples pratiques. À la fin de la leçon, vous pourrez traiter des champs texte avec assurance dans des cas réels.

# Fonctions de chaîne essentielles en SQL

Dans la leçon précédente, vous avez découvert les fonctions intégrées SQL dans leur ensemble. Nous allons maintenant nous concentrer sur les fonctions de chaîne, car les champs texte nécessitent souvent un traitement supplémentaire : normalisation de casse, suppression de caractères inutiles, concaténation de valeurs et extraction de fragments.

Ces opérations sont fréquentes en analytique, en reporting et en préparation de données. Plus vous maîtrisez les fonctions de chaîne, moins vous aurez de traitement manuel à faire hors SQL.

---

## Que sont les fonctions de chaîne

Les fonctions de chaîne travaillent sur du texte et renvoient une chaîne, un nombre ou la position d'une sous-chaîne. Elles sont utiles lorsque vous devez :

- uniformiser le format du texte ;
- nettoyer des valeurs bruitées ;
- extraire une partie d'une chaîne (par exemple un domaine d'e-mail) ;
- produire un rendu texte lisible pour des rapports.

---

## Syntaxe de base

```sql
FUNCTION_NAME(string_expression, ...)
```

Le plus souvent, l'argument est une colonne de table, un littéral texte ou le résultat d'une autre fonction.

---

## Fonctions de chaîne essentielles

### `UPPER()` et `LOWER()`

Utilisées pour normaliser la casse du texte.

```sql
SELECT
   customer_id,
   UPPER(last_name) AS last_name_upper,
   LOWER(first_name) AS first_name_lower
FROM customer
LIMIT 5;
```

*Résultat : le nom de famille est affiché en majuscules et le prénom en minuscules.*

### `CHAR_LENGTH()` et `LENGTH()`

Ces deux fonctions mesurent la longueur d'une chaîne, mais pas toujours de la même manière :

- `CHAR_LENGTH()` renvoie généralement le nombre de caractères ;
- `LENGTH()` dans MySQL renvoie le nombre d'octets.

```sql
SELECT
   title,
   CHAR_LENGTH(title) AS title_chars,
   LENGTH(title) AS title_bytes
FROM film
LIMIT 5;
```

*Remarque : pour les caractères multioctets, le nombre d'octets peut être supérieur au nombre de caractères.*

### `SUBSTRING()`, `LEFT()`, `RIGHT()`

Ces fonctions extraient une partie d'une chaîne.

```sql
SELECT
   email,
   SUBSTRING(email, 1, 5) AS email_start,
   LEFT(email, 3) AS first_3,
   RIGHT(email, 10) AS last_10
FROM customer
LIMIT 5;
```

*Résultat : différents fragments d'e-mail sont extraits pour l'analyse et la vérification du format.*

### `CONCAT()` et `CONCAT_WS()`

Ces fonctions combinent plusieurs valeurs dans une seule chaîne :

- `CONCAT()` concatène les arguments directement ;
- `CONCAT_WS(separator, ...)` ajoute un séparateur et est souvent plus pratique dans les rapports.

```sql
SELECT
   customer_id,
   CONCAT(first_name, ' ', last_name) AS full_name,
   CONCAT_WS(' | ', first_name, last_name, email) AS customer_label
FROM customer
LIMIT 5;
```

*Remarque : le comportement avec `NULL` dépend du SGBD, consultez donc la documentation de votre système.*

### `TRIM()` et `REPLACE()`

Utile pour nettoyer des valeurs textuelles.

```sql
SELECT
   address,
   TRIM(address) AS address_trimmed,
   REPLACE(address, 'Street', 'St.') AS address_short
FROM address
LIMIT 5;
```

*Résultat : les espaces superflus sont supprimés et des motifs textuels répétitifs sont remplacés.*

### Recherche de sous-chaîne : `POSITION()` / `INSTR()` / `CHARINDEX()`

Le nom de la fonction varie selon le SGBD, mais l'idée est la même : trouver la position d'une sous-chaîne dans une chaîne.

```sql
SELECT
   email,
   INSTR(email, '@') AS at_pos
FROM customer
LIMIT 5;
```

*Résultat : renvoie la position de `@`, utile pour valider un e-mail.*

---

## Points d'attention

- Vérifiez les différences entre SGBD : les noms de fonctions et leurs comportements peuvent varier.
- Attention à `NULL` : il modifie souvent le résultat des expressions de chaîne.
- Pour le cyrillique et les emoji, choisissez la fonction de longueur en connaissance de cause (caractères vs octets).
- Évitez d'imbriquer trop de fonctions dans une seule requête ; découpez la logique en étapes si nécessaire.

---

## Exemple pratique : préparer des données clients pour un envoi d'e-mails

La requête suivante prépare une liste client propre : elle normalise le nom, normalise l'e-mail et extrait le domaine.

```sql
SELECT
   c.customer_id,
   TRIM(CONCAT_WS(' ', c.first_name, c.last_name)) AS full_name,
   LOWER(TRIM(c.email)) AS email_normalized,
   SUBSTRING_INDEX(LOWER(TRIM(c.email)), '@', -1) AS email_domain
FROM customer AS c
WHERE c.email IS NOT NULL
ORDER BY c.customer_id
LIMIT 20;
```

*Résultat : vous obtenez un ensemble de champs texte propre et homogène, prêt pour l'analyse ou l'export.*

---

**Points clés de cette leçon :**

- Les fonctions de chaîne SQL permettent de nettoyer, normaliser et formater du texte directement dans les requêtes.
- `UPPER`, `LOWER`, `TRIM`, `REPLACE`, `SUBSTRING`, `LEFT`, `RIGHT` et `CONCAT` couvrent la plupart des besoins courants.
- Pour la longueur des chaînes, il faut distinguer caractères et octets.
- Lors de la concaténation, tenez compte du comportement de `NULL` dans votre SGBD.
- La valeur pratique des fonctions de chaîne apparaît surtout dans les scénarios réels de préparation de données.

## Questions d'entretien

### Quelle est la différence entre `CHAR_LENGTH()` et `LENGTH()`, et pourquoi est-ce important ?
`CHAR_LENGTH()` renvoie généralement le nombre de **caractères**, tandis que `LENGTH()` dans MySQL renvoie le nombre d'**octets**. Pour le cyrillique et d'autres caractères multioctets, les résultats peuvent différer. C'est essentiel pour valider la longueur des champs et appliquer des règles métier.

### Comment composer un nom complet de façon sûre si un champ peut être `NULL` ?
`CONCAT_WS()` est souvent privilégiée, car elle est pratique pour concaténer avec un séparateur. Il est aussi utile de gérer explicitement les valeurs vides avec **`COALESCE()`** afin d'obtenir un résultat prévisible selon les scénarios.

### Quelles fonctions de chaîne utiliser pour nettoyer les e-mails avant analyse ?
Une approche courante est **`TRIM()`** + **`LOWER()`** pour supprimer les espaces superflus et normaliser la casse. Pour valider la structure, vous pouvez aussi vérifier la présence de `@` avec `INSTR()` ou son équivalent dans votre SGBD.

Dans la prochaine leçon, nous passerons aux fonctions mathématiques SQL et verrons comment effectuer des calculs numériques dans les requêtes.