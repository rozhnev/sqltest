---
title: "SQL AND, OR et NOT dans WHERE : combiner plusieurs conditions"
description: "Apprenez les opérateurs logiques AND, OR et NOT dans SQL WHERE, la priorité d'évaluation, les parenthèses et des exemples NOT IN et NOT LIKE."
keywords: ["SQL AND OR NOT", "opérateurs logiques SQL", "NOT IN SQL", "NOT LIKE SQL", "clause WHERE SQL", "priorité des opérateurs SQL"]
teaches: ["Combiner des conditions dans WHERE", "Utiliser AND, OR et NOT", "Appliquer NOT IN et NOT LIKE", "Contrôler la priorité avec des parenthèses", "Éviter les erreurs logiques"]
about: ["SQL", "WHERE", "Opérateurs logiques", "Filtrage des données"]
---

_Leçon 2.3 · Temps de lecture : ~7 min_

Cette leçon SQL explique comment combiner plusieurs conditions dans une clause WHERE à l'aide des opérateurs logiques : AND, OR et NOT. Vous apprendrez à créer des filtres de base de données avancés pour extraire des sous-ensembles de données spécifiques en connectant plusieurs expressions. La leçon explique la priorité des opérateurs et l'importance d'utiliser des parenthèses pour contrôler l'ordre d'évaluation et garantir la précision des requêtes. Maîtrisez les techniques complexes de filtrage de données pour améliorer vos compétences en requêtes SQL pour une analyse de données et un reporting plus efficaces.

# Combiner plusieurs conditions dans WHERE

## Combinaison de plusieurs critères en SQL

Dans la leçon précédente, nous avons appris à utiliser la clause `WHERE` avec des opérateurs de comparaison simples. Cependant, l'analyse de données en conditions réelles nécessite souvent un filtrage par plusieurs critères simultanément. Pour ce faire, nous utilisons les opérateurs logiques : `AND`, `OR` et `NOT`.

## Opérateurs logiques en SQL

Les opérateurs logiques vous permettent de connecter plusieurs expressions dans une clause `WHERE` pour créer des filtres plus sophistiqués.

### L'opérateur AND
L'opérateur `AND` (ET) ne renvoie les lignes que si **toutes** les conditions séparées par `AND` sont vraies. Il est utilisé pour affiner vos résultats.

**Exemple (Base de données Sakila)**
Supposons que nous voulions trouver les films qui sont à la fois classés 'G' et d'une durée inférieure à 80 minutes :

```sql
SELECT title, length, rating
FROM film
WHERE length < 80 AND rating = 'G';
```

*Résultat : uniquement les films qui respectent les deux conditions en même temps.*

### L'opérateur OR
L'opérateur `OR` (OU) renvoie les lignes si **l'une** des conditions séparées par `OR` est vraie. Il est utilisé pour élargir vos résultats.

**Exemple (Base de données Sakila)**
Pour trouver les acteurs dont le prénom est 'NICK' ou 'ED' :

```sql
SELECT first_name, last_name
FROM actor
WHERE first_name = 'NICK' OR first_name = 'ED';
```

*Résultat : les lignes dont le prénom correspond à au moins une valeur.*

### L'opérateur NOT
L'opérateur `NOT` (NON) renvoie une ligne lorsque la condition **n'est pas** vraie. En pratique, il est souvent utilisé avec `IN` et `LIKE` quand il faut exclure une liste de valeurs ou un motif textuel.

**Exemple 1 : exclure une seule classification**

Pour trouver tous les films sauf ceux classés 'R' :

```sql
SELECT title, rating
FROM film
WHERE NOT rating = 'R';
```

*Résultat : tous les films dont la classification n'est pas 'R'.*

**Exemple 2 : utiliser NOT IN pour exclure plusieurs valeurs**

Si vous voulez exclure plusieurs classifications d'un coup, `NOT IN` est plus pratique :

```sql
SELECT title, rating
FROM film
WHERE rating NOT IN ('R', 'NC-17');
```

*Résultat : les films dont la classification n'appartient pas à la liste 'R' et 'NC-17'.*

**Exemple 3 : utiliser NOT LIKE pour nier un motif**

Si vous voulez exclure les titres qui commencent par la lettre A :

```sql
SELECT title
FROM film
WHERE title NOT LIKE 'A%';
```

*Résultat : les films dont le titre ne commence pas par A.*

### L'opérateur XOR (OU exclusif, rarement utilisé)
L'opérateur `XOR` renvoie vrai uniquement lorsque **une seule** des deux conditions est vraie. En pratique, il est rarement utilisé, car il n'est pas pris en charge par tous les SGBD et peut réduire la lisibilité des requêtes.

**Exemple (Base de données Sakila)**
Pour trouver les films où une seule condition est vraie : soit la durée est inférieure à 60 minutes, soit la classification est 'G', mais pas les deux à la fois :

```sql
SELECT title, length, rating
FROM film
WHERE length < 60 XOR rating = 'G';
```

Pour une meilleure portabilité entre différents SGBD, cette logique est généralement écrite avec `AND`/`OR`/`NOT`.

---

## Priorité des opérateurs

Lorsque vous combinez plusieurs opérateurs dans une seule requête (ex : en utilisant à la fois `AND` et `OR`), SQL suit un ordre d'opération spécifique (priorité).

1. `NOT` est évalué en premier.
2. `AND` est évalué en deuxième.
3. `XOR` (si pris en charge par votre dialecte SQL) est généralement évalué après `AND`.
4. `OR` est évalué en dernier.

**La puissance des parenthèses :**
Tout comme en mathématiques, vous devez utiliser des parenthèses `()` pour contrôler l'ordre d'évaluation et rendre vos requêtes plus lisibles. Sans elles, SQL applique silencieusement sa priorité par défaut — et le résultat peut ne pas correspondre à ce que vous attendiez.

---

### Trouver les films 'G' et 'PG' de moins de 60 minutes

**Requête incorrecte — parenthèses manquantes :**

```sql
-- ERREUR : AND est plus prioritaire que OR, donc ceci est évalué comme :
-- rating = 'G'  OR  (rating = 'PG' AND length < 60)
-- Résultat : TOUS les films 'G' (toute durée) + uniquement les films 'PG' COURTS
SELECT title, length, rating
FROM film
WHERE rating = 'G' OR rating = 'PG' AND length < 60;
```

**Pourquoi c'est incorrect :** la condition `AND` est évaluée en premier, donc le filtre `length < 60` ne s'applique qu'aux films 'PG', tandis que tous les films 'G' — quelle que soit leur durée — passent au travers.

**Requête correcte — les parenthèses rendent l'intention explicite :**

```sql
-- CORRECT : les parenthèses forcent l'évaluation du OR en premier
-- Résultat : uniquement les films classés 'G' OU 'PG' ET de moins de 60 minutes
SELECT title, length, rating
FROM film
WHERE (rating = 'G' OR rating = 'PG') AND length < 60;
```

*Résultat : uniquement les films classés 'G' ou 'PG' et d'une durée inférieure à 60 minutes.*

---

### Exclure les films classés 'R' et 'NC-17'

**Requête incorrecte — NOT ne nie que la première condition :**

```sql
-- ERREUR : NOT s'applique uniquement à la condition qui le suit immédiatement
-- Équivalent à : (NOT rating = 'R') AND rating = 'NC-17'
-- Résultat : tous les films classés 'NC-17' (car 'NC-17' n'est pas 'R', NOT est toujours vrai)
SELECT title, rating, length
FROM film
WHERE NOT rating = 'R' AND rating = 'NC-17';
```

**Pourquoi c'est incorrect :** `NOT` ne nie que `rating = 'R'`, laissant `rating = 'NC-17'` comme filtre positif. La requête retourne tous les films classés 'NC-17' — car 'NC-17' n'est pas 'R', la condition `NOT` est toujours satisfaite pour ces lignes. Au lieu d'exclure les films NC-17, la requête retourne exactement les films que vous vouliez exclure.

**Option A — deux conditions NOT explicites :**

```sql
-- CORRECT : chaque condition est niée indépendamment
SELECT title, rating, length
FROM film
WHERE NOT rating = 'R' AND NOT rating = 'NC-17';
```

**Option B — NOT avec parenthèses (plus concis) :**

```sql
-- CORRECT : NOT s'applique à tout le groupe OR
SELECT title, rating, length
FROM film
WHERE NOT (rating = 'R' OR rating = 'NC-17');
```

Les deux options retournent le même résultat. L'option B est généralement préférée lorsqu'on exclut plusieurs valeurs — elle s'adapte mieux à mesure que la liste s'allonge.

---

## Questions fréquentes

### Quand faut-il utiliser AND plutôt que OR ?
Utilisez `AND` lorsqu'une ligne doit satisfaire **toutes** les conditions en même temps. Utilisez `OR` lorsqu'il suffit qu'**une seule** des conditions soit vraie. Si les deux opérateurs apparaissent dans la même requête, les parenthèses sont presque toujours utiles.

### En quoi NOT IN est-il différent de plusieurs conditions AND ?
`NOT IN` est une façon compacte d'exclure plusieurs valeurs d'une même colonne. C'est plus lisible et plus facile à faire évoluer qu'une longue suite de comparaisons niées reliées par `AND`.

### Quand utiliser NOT LIKE ?
Utilisez `NOT LIKE` quand vous voulez exclure des lignes qui correspondent à un motif textuel. C'est utile pour filtrer négativement par préfixe, suffixe ou sous-chaîne.

---

## Questions d'entretien

### Comment expliquer la priorité des opérateurs SQL lors d'un entretien ?
En SQL, `NOT` est évalué en premier, puis `AND`, et enfin `OR`. Quand une requête mélange plusieurs opérateurs, les parenthèses rendent la logique explicite et évitent des résultats accidentels.

### Quand utiliseriez-vous NOT IN plutôt que NOT = ?
Utilisez `NOT IN` lorsque vous devez exclure plusieurs valeurs d'une même colonne. C'est une option plus lisible et plus évolutive que de répéter plusieurs comparaisons avec `AND`.

### Comment fonctionne NOT LIKE ?
`NOT LIKE` renvoie les lignes qui ne correspondent pas au motif indiqué. Par exemple, `title NOT LIKE 'A%'` exclut tous les titres qui commencent par A.

### Pourquoi les parenthèses sont-elles importantes dans des clauses WHERE complexes ?
Les parenthèses contrôlent l'ordre d'évaluation et lèvent l'ambiguïté entre `AND` et `OR`. Elles permettent d'écrire exactement la logique voulue au lieu de dépendre de la priorité par défaut.

**Points clés de cette leçon :**

* Utilisez `AND` pour vous assurer que toutes les conditions sont remplies.
* Utilisez `OR` pour trouver des correspondances parmi plusieurs conditions.
* Utilisez `NOT`, `NOT IN` et `NOT LIKE` pour exclure des données.
* Utilisez `XOR` avec précaution : il peut être utile, mais n'est pas pris en charge par tous les dialectes SQL.
* Utilisez toujours des parenthèses `()` lorsque vous mélangez `AND` et `OR` afin d'éviter les erreurs logiques et d'améliorer la clarté.

Dans la leçon suivante, nous apprendrons comment **trier et limiter** les résultats pour organiser vos données plus efficacement.
