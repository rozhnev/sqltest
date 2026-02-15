Cette leçon SQL se concentre sur le filtrage des lignes à l'aide de la clause WHERE. Apprenez à utiliser les opérateurs de comparaison, les filtres de plage avec BETWEEN, la correspondance de liste avec IN et la recherche de motifs avec LIKE. La leçon couvre également la distinction cruciale de la gestion des valeurs NULL avec IS NULL et IS NOT NULL. Maîtrisez les techniques de filtrage des données pour extraire des informations précises et optimiser vos requêtes de base de données pour une analyse efficace.

# Leçon 2.2 Filtrage des lignes : la clause WHERE

## Filtrage des données avec la clause WHERE

L'instruction `SELECT` seule renvoie toutes les lignes d'une table. Cependant, dans des scénarios réels, vous n'avez généralement besoin que d'un sous-ensemble de données répondant à des critères spécifiques. C'est là qu'intervient la clause `WHERE`.

## Qu'est-ce que la clause WHERE ?

La clause `WHERE` est utilisée pour filtrer les enregistrements. Elle garantit que seules les lignes satisfaisant à une condition spécifiée sont incluses dans l'ensemble de résultats.

### Syntaxe de base

```sql
SELECT colonne1, colonne2, ...
FROM nom_table
WHERE condition;
```

La condition est une expression qui s'évalue à vrai (true), faux (false) ou inconnu (si des valeurs `NULL` sont impliquées). Seules les lignes où la condition s'évalue à **vrai** sont renvoyées.

---

## Opérateurs de comparaison

SQL propose une variété d'opérateurs pour comparer les valeurs dans la clause `WHERE` :

| Opérateur | Description | Exemple |
| :--- | :--- | :--- |
| `=` | Égal à | `WHERE last_name = 'SMITH'` |
| `<>` ou `!=` | Différent de | `WHERE store_id <> 1` |
| `>` | Supérieur à | `WHERE rental_rate > 2.99` |
| `<` | Inférieur à | `WHERE length < 60` |
| `>=` | Supérieur ou égal à | `WHERE replacement_cost >= 20.00` |
| `<=` | Inférieur ou égal à | `WHERE amount <= 5.00` |

### Exemple (Base de données Sakila)

Pour trouver les films avec un tarif de location (rental rate) de 4,99 $ dans la table `film` :

```sql
SELECT title, rental_rate, replacement_cost
FROM film
WHERE rental_rate = 4.99;
```

---

## Opérateurs de filtrage spéciaux

SQL inclut des opérateurs puissants pour les plages, les ensembles et la recherche de motifs.

### 1. BETWEEN
Filtre les valeurs dans une certaine plage (inclusive).

```sql
-- Trouver les paiements entre 5,00 et 10,00 $
SELECT payment_id, amount, payment_date
FROM payment
WHERE amount BETWEEN 5.00 AND 10.00;
```

### 2. IN
Correspond à n'importe quelle valeur dans une liste spécifiée.

```sql
-- Trouver les clients de magasins spécifiques
SELECT first_name, last_name, store_id
FROM customer
WHERE store_id IN (1, 2);
```

### 3. LIKE
Recherche un motif spécifié dans une colonne à l'aide de caractères génériques :
- `%` représente zéro, un ou plusieurs caractères.
- `_` représente un seul caractère.

### Exemple (Base de données Sakila)

```sql
-- Trouver les films commençant par 'A'
SELECT title
FROM film
WHERE title LIKE 'A%';

-- Trouver les films dont la deuxième lettre est 'I'
SELECT title
FROM film
WHERE title LIKE '_I%';
```

---

## Le piège : Filtrage des valeurs NULL

Comme nous l'avons appris dans la leçon sur les NULL, vous ne pouvez pas utiliser `=` ou `<>` pour vérifier `NULL`. Vous devez utiliser `IS NULL` ou `IS NOT NULL`.

### Exemple (Base de données Sakila)

```sql
-- Incorrect
-- WHERE return_date = NULL

-- Correct
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date IS NULL;
```

---

**Points clés de cette leçon :**

*   La clause `WHERE` filtre les lignes **avant** qu'elles ne soient renvoyées dans l'ensemble de résultats.
*   Les valeurs de chaîne (string) et de date doivent être entourées de guillemets simples (ex : `'SMITH'`).
*   Les valeurs numériques ne nécessitent pas de guillemets.
*   Utilisez `LIKE` pour la recherche de motifs et `IN` pour la correspondance par rapport à des listes.
*   **N'utilisez jamais** `=` avec `NULL`; utilisez toujours `IS NULL`.

Dans la leçon suivante, nous explorerons comment **combiner plusieurs conditions** pour créer des filtres encore plus puissants.
