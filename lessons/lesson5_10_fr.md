---
title: "Opérations sur les ensembles de données en SQL : UNION, INTERSECT et EXCEPT"
description: "Les opérations sur les ensembles de données permettent de combiner, croiser et soustraire des résultats de requêtes. Découvrez UNION, INTERSECT et EXCEPT avec des exemples Sakila."
keywords: ["opérations sur les ensembles SQL", "UNION", "INTERSECT", "EXCEPT", "UNION ALL", "set operations"]
teaches: ["Combiner plusieurs résultats de requêtes avec UNION et UNION ALL", "Trouver les intersections et les différences avec INTERSECT et EXCEPT", "Réécrire des conditions OR complexes avec UNION quand cela améliore la lisibilité", "Comprendre les contraintes de compatibilité des colonnes et des types", "Choisir le bon opérateur pour des tâches analytiques pratiques"]
about: ["SQL", "UNION", "UNION ALL", "INTERSECT", "EXCEPT"]
---

_Leçon 5.10 · Temps de lecture : ~8 min_

Cette leçon présente les opérations sur les ensembles de données en SQL. Vous apprendrez à combiner les résultats de plusieurs requêtes, à trouver les lignes communes et à exclure les valeurs dont vous n'avez pas besoin. Nous verrons `UNION`, `UNION ALL`, `INTERSECT` et `EXCEPT` à partir d'exemples Sakila. À la fin de la leçon, vous saurez choisir le bon opérateur pour différents scénarios analytiques.

# Opérations sur les ensembles de données

Dans les leçons précédentes, vous avez appris à relier des tables avec `JOIN` et à comprendre comment le moteur exécute ces jointures. Nous passons maintenant à une autre idée : parfois, on ne veut pas relier des lignes par des clés, mais plutôt combiner et comparer des ensembles de résultats entiers.

Les opérations sur les ensembles de données sont utiles lorsque vous souhaitez fusionner des données provenant de plusieurs requêtes, trouver le chevauchement entre deux audiences ou supprimer des lignes déjà présentes dans une autre liste. En pratique, cela apparaît souvent dans les rapports, les contrôles de qualité des données et la préparation des listes finales.

<img src="/images/lessons/lesson5_10-dataset-operations.svg" alt="SQL dataset operations UNION INTERSECT EXCEPT" width="100%">

---

## Que sont les opérations sur les ensembles de données

Les opérations sur les ensembles de données ne travaillent pas avec les lignes d'une seule table, mais avec les **résultats de deux requêtes ou plus**. En SQL, chaque `SELECT` renvoie un ensemble de lignes, et des opérateurs comme `UNION` ou `INTERSECT` combinent ces ensembles selon des règles précises.

Les quatre opérateurs les plus utilisés sont :

- `UNION` - combine les résultats et supprime les doublons ;
- `UNION ALL` - combine les résultats et conserve les doublons ;
- `INTERSECT` - ne conserve que les lignes présentes dans les deux ensembles ;
- `EXCEPT` - renvoie les lignes du premier ensemble absentes du second.

> **Important :** tous les moteurs de base de données ne prennent pas en charge ces opérateurs exactement de la même manière. Lorsque vous déplacez des requêtes d'un moteur à l'autre, vérifiez toujours la version et la compatibilité.

## Règles générales

Pour utiliser une opération ensembliste, les deux requêtes `SELECT` doivent renvoyer des résultats compatibles.

### Exigences sur les requêtes

- le même nombre de colonnes ;
- des types de données compatibles aux positions correspondantes ;
- le même ordre de colonnes ;
- si possible, le même sens métier des valeurs.

Si vous devez trier le résultat final, écrivez `ORDER BY` tout à la fin de l'expression entière.

```sql
SELECT column1, column2
FROM table_a
UNION
SELECT column1, column2
FROM table_b
ORDER BY column1;
```

## UNION et UNION ALL

`UNION` et `UNION ALL` se ressemblent, mais résolvent des problèmes différents.

- `UNION` supprime les doublons du résultat final.
- `UNION ALL` conserve toutes les lignes, même si elles se répètent.

### Exemple : une seule liste de villes pour les clients et le personnel

Supposons que nous voulions une liste unique des villes où vivent les clients et le personnel de Sakila.

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
UNION
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Résultat : vous obtenez une liste unique des villes, sans doublons, même si les clients et le personnel vivent dans la même ville.*

Si vous souhaitez conserver toutes les sources, utilisez `UNION ALL` :

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
UNION ALL
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Note : `UNION ALL` est utile lorsque les doublons ont du sens, par exemple si vous prévoyez de compter les lignes de la liste combinée par la suite.*

### Quand choisir UNION ALL

`UNION ALL` est généralement plus rapide que `UNION`, car la base de données ne perd pas de temps à supprimer les doublons. Donc, si vous n'avez pas besoin d'unicité, `UNION ALL` est en général le meilleur choix.

## INTERSECT

`INTERSECT` renvoie uniquement les lignes présentes dans **les deux** ensembles de résultats. C'est utile lorsque vous avez besoin du chevauchement entre deux listes.

### Exemple : villes où vivent à la fois les clients et le personnel

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
INTERSECT
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Résultat : vous ne voyez que les villes présentes à la fois parmi les clients et parmi le personnel.*

### Quand cela aide

`INTERSECT` est pratique pour trouver la partie commune entre deux audiences, comparer des listes provenant de systèmes différents ou vérifier le chevauchement de deux extractions.

## EXCEPT

`EXCEPT` renvoie les lignes du premier ensemble qui n'existent **pas** dans le second. C'est l'opérateur de différence ensembliste.

### Exemple : villes où vivent les clients mais pas le personnel

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
EXCEPT
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Résultat : vous obtenez la liste des villes où il y a des clients mais pas de personnel.*

### Remarque importante

Dans certaines bases de données, `EXCEPT` peut s'appeler `MINUS` ou n'être disponible que dans certaines versions. Si vous écrivez du SQL portable, vérifiez ce point séparément.

## Utilisation pratique

Les opérations sur les ensembles sont particulièrement utiles en analytique et en validation de données.

- `UNION` aide à construire une liste de référence unique à partir de plusieurs sources.
- `UNION ALL` est utile pour combiner des flux de données avant une agrégation ultérieure.
- `INTERSECT` montre le chevauchement ou les lignes correspondantes.
- `EXCEPT` aide à trouver les écarts, les manques et les valeurs en trop.

Parfois, les opérations sur les ensembles peuvent être remplacées par `JOIN`, mais ce n'est pas toujours pratique. Si vous devez comparer des **résultats de requêtes** plutôt que relier des tables par des clés, les opérations ensemblistes sont souvent plus lisibles.

### Quand plusieurs conditions `OR` gagnent à être réécrites avec `UNION`

Parfois, une longue clause `WHERE` avec plusieurs conditions `OR` devient difficile à lire et à maintenir. Dans ce cas, vous pouvez séparer la logique en plusieurs branches et les combiner avec `UNION`.

Cette approche est particulièrement utile lorsque :

- chaque branche représente une règle métier différente ;
- les conditions ont des sens très différents ;
- vous voulez rendre la requête plus simple à lire et à maintenir.

**Exemple :** trouver les films qui ont soit la classification `R`, soit une durée supérieure à 180 minutes.

```sql
SELECT
    title,
    rating,
    length
FROM film
WHERE rating = 'R'

UNION

SELECT
    title,
    rating,
    length
FROM film
WHERE length > 180
ORDER BY title;
```

*Résultat : au lieu d'une seule clause `WHERE ... OR ...` longue, vous obtenez deux requêtes claires, plus faciles à lire, modifier et tester. Si une ligne peut correspondre aux deux branches, `UNION` supprime automatiquement les doublons. Si les doublons ne posent pas de problème et que les branches ne se recoupent pas, vous pouvez utiliser `UNION ALL`.*

*Note : si les conditions s'appliquent à la même colonne, `IN (...)` suffit souvent. `UNION` est surtout utile lorsque les branches sont logiquement différentes ou reposent sur des colonnes différentes.*

## Questions d'entretien

### Quelle est la différence entre `UNION` et `UNION ALL` ?
`UNION` combine les résultats de deux requêtes et supprime les doublons, tandis que `UNION ALL` conserve toutes les lignes. En pratique, `UNION ALL` est généralement plus rapide car il ne fait pas le travail supplémentaire nécessaire pour détecter les répétitions.

### Pourquoi les opérations ensemblistes exigent-elles des requêtes `SELECT` compatibles ?
Parce que SQL combine les résultats par position de colonne, et non par nom de colonne. Si deux requêtes renvoient un nombre de colonnes différent ou des types incompatibles, la base de données ne peut pas construire un ensemble final valide.

### Quand faut-il utiliser `INTERSECT`, et quand faut-il utiliser `EXCEPT` ?
`INTERSECT` est idéal lorsque vous voulez les lignes présentes dans les deux listes. `EXCEPT` est utile lorsque vous souhaitez soustraire la deuxième liste à la première et ne conserver que les valeurs restantes.

### En quoi les opérations ensemblistes sont-elles différentes de `JOIN` ?
`JOIN` relie les lignes par des clés et ajoute généralement des colonnes provenant d'une autre table. Les opérations ensemblistes travaillent sur des résultats de requêtes entiers et les comparent comme des ensembles, ce qui est utile pour fusionner des listes, trouver des recoupements et identifier des différences.

---

## Points clés de cette leçon

- `UNION` combine les résultats et supprime les doublons.
- `UNION ALL` combine les résultats sans supprimer les doublons.
- `INTERSECT` ne conserve que les lignes communes de deux ensembles.
- `EXCEPT` renvoie les lignes présentes dans le premier ensemble mais absentes du second.
- Toutes les opérations ensemblistes exigent des requêtes `SELECT` compatibles avec le même nombre de colonnes.
- `ORDER BY` pour le résultat final doit être placé à la fin de l'expression entière.
- En analytique pratique, ces opérations sont utiles pour fusionner des listes, trouver des recoupements et comparer des données entre sources.

Dans la leçon suivante, nous passerons aux sous-requêtes et verrons comment utiliser des `SELECT` imbriqués pour des conditions et des calculs plus flexibles.
