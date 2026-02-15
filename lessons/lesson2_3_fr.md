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

---

## Priorité des opérateurs

Lorsque vous combinez plusieurs opérateurs dans une seule requête (ex : en utilisant à la fois `AND` et `OR`), SQL suit un ordre d'opération spécifique (priorité).

1.  `NOT` est évalué en premier.
2.  `AND` est évalué en deuxième.
3.  `OR` est évalué en dernier.

**La puissance des parenthèses :**
Tout comme en mathématiques, vous devez utiliser des parenthèses `()` pour contrôler l'ordre d'évaluation et rendre vos requêtes plus lisibles.

### Exemple (Base de données Sakila)

```sql
-- Cette requête trouve les films qui sont (Classés G ET Courts) OU (Classés PG ET Courts)
SELECT title, length, rating
FROM film
WHERE (rating = 'G' OR rating = 'PG') AND length < 60;
```

---

**Points clés de cette leçon :**

*   Utilisez `AND` pour vous assurer que toutes les conditions sont remplies.
*   Utilisez `OR` pour trouver des correspondances parmi plusieurs conditions.
*   Utilisez `NOT` pour exclure des données spécifiques.
*   Utilisez toujours des parenthèses `()` lorsque vous mélangez `AND` et `OR` afin d'éviter les erreurs logiques et d'améliorer la clarté.

Dans la leçon suivante, nous apprendrons comment **trier et limiter** les résultats pour organiser vos données plus efficacement.
