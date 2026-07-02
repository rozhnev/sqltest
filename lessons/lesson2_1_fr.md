---
title: "SQL SELECT : sélectionner des données et utiliser DISTINCT"
description: "Apprenez les bases de SELECT en SQL : toutes les colonnes ou colonnes ciblées, ordre d'affichage et DISTINCT pour supprimer les doublons."
keywords: ["SQL SELECT", "selection de donnees SQL", "SELECT DISTINCT", "valeurs uniques SQL", "SQL debutant", "Sakila"]
teaches: ["Comment sélectionner toutes les colonnes ou seulement celles nécessaires avec SELECT", "Pourquoi SELECT * n'est pas toujours la meilleure option", "Comment utiliser DISTINCT pour obtenir des valeurs uniques", "Comment l'ordre des colonnes dans SELECT influence le résultat"]
about: ["SQL", "SELECT", "DISTINCT", "Sakila", "Base de donnees relationnelle"]
---

_Leçon 2.1 · Temps de lecture : ~6 min_

# Sélectionner des données dans une table

## Sélection de données dans une table

L'opération la plus fondamentale en SQL consiste à extraire des données d'une table. L'instruction `SELECT` est utilisée à cette fin.

<img src="/images/lessons/lesson2_1-select-distinct.svg" alt="Schema visuel SQL SELECT et DISTINCT" width="100%">

## Syntaxe de base (Sélection de toutes les colonnes)

Pour sélectionner toutes les colonnes d'une table, vous utilisez la syntaxe `SELECT *` :

```sql
SELECT *
FROM nom_table;
```

- `SELECT` : Ce mot-clé récupère les données de la table.
- `*` (Astérisque) : Indique que toutes les colonnes de la table doivent être récupérées. L'astérisque (`*`) agit comme un caractère générique représentant toutes les colonnes de la table.
- `FROM nom_table` : Spécifie la table à partir de laquelle les données doivent être extraites. Remplacez `nom_table` par le nom réel de la table que vous interrogez.

### Exemple (Base de données Sakila)

Pour sélectionner toutes les colonnes de la table `actor` dans la base de données Sakila :

```sql
SELECT *
FROM actor;
```

Cette requête renverra toutes les lignes et toutes les colonnes (ex : `actor_id`, `first_name`, `last_name`, `last_update`) de la table `actor`.

### Évitez d'utiliser `*` pour sélectionner toutes les colonnes

L'utilisation de `*` pour sélectionner toutes les colonnes n'est généralement pas recommandée. Bien que cela puisse paraître pratique, cela peut entraîner plusieurs problèmes :

- **Impact sur les performances :** La récupération de toutes les colonnes peut augmenter la quantité de données transférées, surtout si la table contient de nombreuses colonnes ou de grands ensembles de données.
- **Changements involontaires :** Si le schéma de la table change (ex : ajout de nouvelles colonnes), les requêtes utilisant `*` peuvent renvoyer des résultats inattendus.
- **Lisibilité et maintenance :** Spécifier explicitement les colonnes rend la requête plus facile à comprendre et à maintenir.

Au lieu d'utiliser `*`, la meilleure pratique consiste à lister explicitement les colonnes dont vous avez besoin. Cette approche garantit la clarté, réduit le risque de résultats involontaires et améliore les performances de la requête.

## Sélection de colonnes spécifiques

Pour récupérer des colonnes spécifiques, listez leurs noms dans l'instruction `SELECT`, séparés par des virgules :

```sql
SELECT colonne1, colonne2, colonne3
FROM nom_table;
```

- `SELECT colonne1, colonne2, colonne3` : Spécifie les colonnes à récupérer. Remplacez `colonne1`, `colonne2` et `colonne3` par les noms réels des colonnes.
- `FROM nom_table` : Indique la table à partir de laquelle récupérer les données.

### Exemple (Base de données Sakila)

Pour récupérer uniquement les colonnes `first_name` et `last_name` de la table `actor` :

```sql
SELECT first_name, last_name
FROM actor;
```

Cette requête renverra toutes les lignes, mais uniquement les colonnes `first_name` et `last_name` pour chaque acteur.

## Sélection de valeurs uniques avec `DISTINCT`

Parfois, vous n'avez pas besoin de toutes les lignes, mais seulement des valeurs uniques d'une colonne (ou d'un groupe de colonnes). Pour cela, utilisez le mot-clé `DISTINCT`.

### Syntaxe de base

```sql
SELECT DISTINCT nom_colonne
FROM nom_table;
```

`DISTINCT` supprime les doublons du résultat et conserve uniquement les lignes uniques.

### Exemple (Base de données Sakila)

Obtenons la liste des classifications de films uniques :

```sql
SELECT DISTINCT rating
FROM film;
```

Cette requête renvoie chaque valeur de `rating` une seule fois.

### `DISTINCT` avec plusieurs colonnes

Vous pouvez aussi appliquer `DISTINCT` à plusieurs colonnes. Dans ce cas, l'unicité est déterminée par la **combinaison** des valeurs.

```sql
SELECT DISTINCT rating, rental_duration
FROM film;
```

Ici, les doublons sont supprimés sur la paire `rating + rental_duration`.

### Quand utiliser `DISTINCT`

`DISTINCT` est utile lorsque vous :

- construisez des listes de référence (par exemple, catégories, statuts ou classifications uniques) ;
- vérifiez la qualité des données (y a-t-il des valeurs répétées inattendues ?) ;
- préparez des données pour des filtres et des interfaces.

> Si vous devez seulement vérifier quelques valeurs d'une colonne, `IN (...)` dans `WHERE` est souvent plus adapté. Utilisez `DISTINCT` surtout pour éliminer les doublons du jeu de résultats.

## Ordre des colonnes dans SELECT

L'ordre dans lequel vous listez les colonnes dans l'instruction `SELECT` détermine leur ordre dans l'ensemble de résultats. Cependant, cela ne modifie pas l'ordre des colonnes dans la table elle-même.

### Exemple (Base de données Sakila)

```sql
SELECT last_name, first_name
FROM actor;
```

Dans ce cas, la colonne `last_name` apparaîtra avant la colonne `first_name` dans le résultat, même si `first_name` est définie plus tôt dans la structure de la table. L'ordre dans l'instruction `SELECT` prévaut sur l'ordre par défaut des colonnes de la table.

## Questions fréquentes

### Peut-on utiliser `SELECT *` dans un projet réel ?
Oui, mais de façon intentionnelle. C'est pratique pour des vérifications rapides, alors qu'en production il est généralement plus sûr de lister uniquement les colonnes nécessaires.

### L'ordre des colonnes dans `SELECT` modifie-t-il la structure de la table ?
Non. Il modifie seulement l'ordre des colonnes dans le résultat de la requête. La structure de la table reste inchangée.

### Pourquoi éviter `SELECT *` dans les API et les rapports ?
Parce qu'un changement de schéma peut ajouter de nouvelles colonnes dans le résultat automatiquement. Cela peut casser des contrats d'API, des rapports ou du code client qui attend un ensemble fixe de champs.

## Questions d'entretien

### Quel est le risque pratique de `SELECT *` ?
Les principaux risques sont un transfert de données inutile, une moindre stabilité face aux changements de schéma et une lisibilité plus faible. En production, on attend en général une liste explicite des colonnes.

### Quand `DISTINCT` peut-il ralentir une requête ?
Sur de gros volumes, car le moteur doit faire un travail supplémentaire pour supprimer les doublons (souvent tri ou hachage). Il faut l'utiliser quand l'unicité est réellement nécessaire.

### Que renvoie `SELECT DISTINCT a, b` ?
La requête renvoie des paires `(a, b)` uniques, et non des valeurs uniques de chaque colonne séparément.

### Comment choisir entre `DISTINCT` et un filtre `WHERE` ?
`WHERE` sert à filtrer les lignes selon des conditions. `DISTINCT` sert à enlever les doublons des lignes déjà sélectionnées.

---

**Points clés de cette leçon :**

- `SELECT *` récupère toutes les colonnes d'une table.
- `SELECT colonne1, colonne2, ...` récupère uniquement les colonnes spécifiées.
- `SELECT DISTINCT nom_colonne` renvoie uniquement des valeurs uniques, sans doublons.
- L'ordre des colonnes dans l'instruction `SELECT` détermine l'ordre dans l'ensemble de résultats.
