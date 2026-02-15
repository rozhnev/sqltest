Cette leçon traite de la clause `ORDER BY` en SQL, qui est utilisée pour trier l'ensemble de résultats d'une requête. Vous apprendrez à organiser les données par ordre croissant ou décroissant, à trier sur plusieurs colonnes et à comprendre l'impact du tri sur l'analyse des données. Maîtriser la clause `ORDER BY` est essentiel pour présenter les données dans une séquence logique et pour préparer des rapports où l'ordre des enregistrements est important, comme les produits les plus vendus ou les journaux d'activité chronologiques.

# Leçon 2.5 : Trier les résultats

Par défaut, il n'est pas garanti que les lignes d'une table de base de données ou d'un ensemble de résultats de requête soient dans un ordre spécifique. Pour organiser les lignes de sortie dans une séquence significative, nous utilisons la clause `ORDER BY`.

## La clause ORDER BY

La clause `ORDER BY` est ajoutée à la fin d'une instruction `SELECT` pour trier l'ensemble de résultats en fonction d'une ou plusieurs colonnes.

### Syntaxe

```sql
SELECT colonne1, colonne2, ...
FROM nom_table
ORDER BY colonne1 [ASC|DESC], colonne2 [ASC|DESC], ...;
```

*   **`colonne1, colonne2, ...`** : Les colonnes par lesquelles vous souhaitez trier.
*   **`ASC`** : Trie les données par ordre croissant (du plus petit au plus grand, de A à Z). C'est le choix par défaut.
*   **`DESC`** : Trie les données par ordre décroissant (du plus grand au plus petit, de Z à A).

## Tri par une seule colonne

Pour trier par une seule colonne, spécifiez simplement son nom après le mot-clé `ORDER BY`.

### Exemple : Trier les acteurs par nom
Cette requête récupère tous les acteurs et les trie par ordre alphabétique de leur nom (last_name).

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name;
```

Si vous souhaitez les trier dans l'ordre alphabétique inverse :

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name DESC;
```

## Tri par plusieurs colonnes

Vous pouvez trier par plusieurs colonnes en les listant séparées par des virgules. La base de données trie d'abord par la première colonne et, s'il y a des valeurs identiques dans cette colonne, elle trie ces doublons par la deuxième colonne, et ainsi de suite.

### Exemple : Trier par nom, puis par prénom
C'est utile lorsque plusieurs acteurs partagent le même nom de famille.

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name, first_name; -- D'abord par nom, puis par prénom en cas d'égalité
```

## Tri par alias de colonne ou par position

Dans la plupart des dialectes SQL, vous pouvez également trier par l'alias d'une colonne ou par sa position numérique dans la liste `SELECT`.

### Exemple : Trier par alias
```sql
SELECT first_name || ' ' || last_name AS full_name
FROM actor
ORDER BY full_name;
```

### Exemple : Trier par position
```sql
-- Trie par la deuxième colonne (last_name)
SELECT first_name, last_name
FROM actor
ORDER BY 2;
```

---

**Points clés de cette leçon :**

*   Utilisez `ORDER BY` pour trier les lignes de votre ensemble de résultats.
*   `ASC` (par défaut) trie par ordre croissant ; `DESC` trie par ordre décroissant.
*   Vous pouvez trier par plusieurs colonnes pour affiner davantage l'ordre.
*   Le tri peut également être effectué en utilisant des alias de colonnes ou des positions numériques.

Dans la leçon suivante, nous découvrirons les **fonctions d'agrégation**, qui nous permettent d'effectuer des calculs sur des ensembles de données.
