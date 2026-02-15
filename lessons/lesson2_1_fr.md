# Leçon 2.1 : Sélectionner des données dans une table

## Sélection de données dans une table

L'opération la plus fondamentale en SQL consiste à extraire des données d'une table. L'instruction `SELECT` est utilisée à cette fin.

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

## Ordre des colonnes dans SELECT

L'ordre dans lequel vous listez les colonnes dans l'instruction `SELECT` détermine leur ordre dans l'ensemble de résultats. Cependant, cela ne modifie pas l'ordre des colonnes dans la table elle-même.

### Exemple (Base de données Sakila)

```sql
SELECT last_name, first_name
FROM actor;
```

Dans ce cas, la colonne `last_name` apparaîtra avant la colonne `first_name` dans le résultat, même si `first_name` est définie plus tôt dans la structure de la table. L'ordre dans l'instruction `SELECT` prévaut sur l'ordre par défaut des colonnes de la table.

**Points clés de cette leçon :**

- `SELECT *` récupère toutes les colonnes d'une table.
- `SELECT colonne1, colonne2, ...` récupère uniquement les colonnes spécifiées.
- L'ordre des colonnes dans l'instruction `SELECT` détermine l'ordre dans l'ensemble de résultats.
