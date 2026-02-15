Cette leçon présente les clauses `LIMIT` et `OFFSET` en SQL, des outils essentiels pour contrôler le nombre de lignes renvoyées par une requête et implémenter la pagination. Vous apprendrez comment récupérer un sous-ensemble spécifique de données, comme les "10 meilleurs" enregistrements, et comment sauter un certain nombre de lignes pour naviguer dans de grands ensembles de données. Maîtriser ces clauses est crucial pour créer des applications efficaces qui gèrent les données par "morceaux" ou pages maniables, améliorant ainsi les performances et l'expérience utilisateur.

# Leçon 2.6 : Limiter les résultats avec LIMIT et OFFSET

Lorsque vous travaillez avec de grandes tables, vous ne souhaitez souvent pas récupérer chaque ligne. Parfois, vous n'avez besoin que des premiers enregistrements, ou vous voulez implémenter une "pagination" (afficher les résultats sur la page 1, la page 2, etc.). Pour ces tâches, nous utilisons les clauses `LIMIT` et `OFFSET`.

## La clause LIMIT

La clause `LIMIT` est utilisée pour spécifier le nombre maximum de lignes que la requête doit renvoyer.

### Syntaxe

```sql
SELECT colonne1, colonne2, ...
FROM nom_table
ORDER BY nom_colonne
LIMIT nombre;
```

*   **`nombre`** : Le nombre maximum de lignes à renvoyer.

> **Note :** Il est fortement recommandé d'utiliser `LIMIT` conjointement avec `ORDER BY`. Sans tri, les "X premières lignes" pourraient être n'importe quelles lignes, selon la manière dont le moteur de base de données optimise la requête.

## La clause OFFSET

La clause `OFFSET` indique à la base de données de sauter un nombre spécifique de lignes avant de commencer à renvoyer les résultats.

### Syntaxe

```sql
SELECT colonne1, colonne2, ...
FROM nom_table
ORDER BY nom_colonne
LIMIT nombre OFFSET saut;
```

*   **`saut`** : Le nombre de lignes à sauter avant de commencer à renvoyer des lignes.

## Pagination : Combiner LIMIT et OFFSET

La pagination est le processus consistant à diviser un grand ensemble de résultats en pages distinctes. C'est le cas d'utilisation le plus courant de la combinaison de `LIMIT` et `OFFSET`.

*   **Page 1 :** `LIMIT 10 OFFSET 0` (Lignes 1-10)
*   **Page 2 :** `LIMIT 10 OFFSET 10` (Lignes 11-20)
*   **Page 3 :** `LIMIT 10 OFFSET 20` (Lignes 21-30)

## Exemples

### Exemple 1 : Les 5 films les plus longs
Cette requête trouve les 5 films les plus longs dans la table `film`.

```sql
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 5;
```

### Exemple 2 : Sauter des enregistrements
Cette requête saute les 10 premiers acteurs (triés par ID) et renvoie les 5 suivants.

```sql
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY actor_id
LIMIT 5 OFFSET 10;
```

---

**Points clés de cette leçon :**

*   `LIMIT` restreint le nombre de lignes dans l'ensemble de résultats.
*   `OFFSET` saute un nombre spécifié de lignes avant de renvoyer les données.
*   La combinaison de `LIMIT` et `OFFSET` est la méthode standard pour implémenter la pagination.
*   Utilisez toujours `ORDER BY` avec ces clauses pour garantir des résultats prévisibles.

Dans la leçon suivante, nous verrons comment **combiner WHERE, ORDER BY et LIMIT** pour construire des requêtes puissantes et précises.
