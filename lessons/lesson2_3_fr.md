Cette leçon SQL explique comment combiner plusieurs conditions dans une clause WHERE à l'aide des opérateurs logiques : AND, OR et NOT. Vous apprendrez à créer des filtres de base de données avancés pour extraire des sous-ensembles de données spécifiques en connectant plusieurs expressions. La leçon explique la priorité des opérateurs et l'importance d'utiliser des parenthèses pour contrôler l'ordre d'évaluation et garantir la précision des requêtes. Maîtrisez les techniques complexes de filtrage de données pour améliorer vos compétences en requêtes SQL pour une analyse de données et un reporting plus efficaces.

# Leçon 2.3 Combiner plusieurs conditions

## Combinaison de plusieurs critères en SQL

Dans la leçon précédente, nous avons appris à utiliser la clause `WHERE` avec des opérateurs de comparaison simples. Cependant, l'analyse de données en conditions réelles nécessite souvent un filtrage par plusieurs critères simultanément. Pour ce faire, nous utilisons les opérateurs logiques : `AND`, `OR` et `NOT`.

## Opérateurs logiques

Les opérateurs logiques vous permettent de connecter plusieurs expressions dans une clause `WHERE` pour créer des filtres plus sophistiqués.

### 1. L'opérateur AND
L'opérateur `AND` (ET) ne renvoie les lignes que si **toutes** les conditions séparées par `AND` sont vraies. Il est utilisé pour affiner vos résultats.

**Exemple (Base de données Sakila)**
Supposons que nous voulions trouver les films qui sont à la fois classés 'G' et d'une durée inférieure à 80 minutes :

```sql
SELECT title, length, rating
FROM film
WHERE length < 80 AND rating = 'G';
```

### 2. L'opérateur OR
L'opérateur `OR` (OU) renvoie les lignes si **l'une** des conditions séparées par `OR` est vraie. Il est utilisé pour élargir vos résultats.

**Exemple (Base de données Sakila)**
Pour trouver les acteurs dont le prénom est 'NICK' ou 'ED' :

```sql
SELECT first_name, last_name
FROM actor
WHERE first_name = 'NICK' OR first_name = 'ED';
```

### 3. L'opérateur NOT
L'opérateur `NOT` (NON) affiche un enregistrement si la ou les conditions **ne sont PAS** vraies. Il inverse efficacement la logique d'une condition.

**Exemple (Base de données Sakila)**
Pour trouver tous les films sauf ceux classés 'R' :

```sql
SELECT title, rating
FROM film
WHERE NOT rating = 'R';
```

### 4. L'opérateur XOR (OU exclusif, rarement utilisé)
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

1.  `NOT` est évalué en premier.
2.  `AND` est évalué en deuxième.
3.  `XOR` (si pris en charge par votre dialecte SQL) est généralement évalué après `AND`.
4.  `OR` est évalué en dernier.

**La puissance des parenthèses :**
Tout comme en mathématiques, vous devez utiliser des parenthèses `()` pour contrôler l'ordre d'évaluation et rendre vos requêtes plus lisibles. Sans elles, SQL applique silencieusement sa priorité par défaut — et le résultat peut ne pas correspondre à ce que vous attendiez.

---

### Exemple 1 : Trouver les films 'G' et 'PG' de moins de 60 minutes

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

---

### Exemple 2 : Exclure les films classés 'R' et 'NC-17'

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

**Points clés de cette leçon :**

*   Utilisez `AND` pour vous assurer que toutes les conditions sont remplies.
*   Utilisez `OR` pour trouver des correspondances parmi plusieurs conditions.
*   Utilisez `NOT` pour exclure des données spécifiques.
*   Utilisez `XOR` avec précaution : il peut être utile, mais n'est pas pris en charge par tous les dialectes SQL.
*   Utilisez toujours des parenthèses `()` lorsque vous mélangez `AND` et `OR` afin d'éviter les erreurs logiques et d'améliorer la clarté.

Dans la leçon suivante, nous apprendrons comment **trier et limiter** les résultats pour organiser vos données plus efficacement.
