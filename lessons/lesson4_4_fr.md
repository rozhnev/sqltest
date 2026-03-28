# Leçon 4.4 : Agrégation conditionnelle

L'agrégation conditionnelle en SQL permet de calculer plusieurs métriques dans une seule requête, sans lancer plusieurs requêtes séparées. L'idée est simple : à l'intérieur d'une fonction d'agrégation (`SUM`, `COUNT`, `AVG`), on utilise une expression conditionnelle (le plus souvent `CASE`, mais dans certains SGBD cela peut être un autre opérateur conditionnel) qui inclut dans le calcul uniquement les lignes correspondant à la condition.

Cette approche est particulièrement utile pour les rapports, les tableaux de bord et l'analytique, quand il faut obtenir plusieurs indicateurs à la fois : quantités, sommes, parts, répartitions par statut, etc.

Dans cette leçon, nous allons voir :

- comment fonctionne l'agrégation conditionnelle ;
- comment calculer des comptes, des sommes et des moyennes conditionnels ;
- comment construire des rapports de type pivot (transformer des lignes en colonnes) avec `CASE`.

## Idée de base

Modèle classique d'agrégation conditionnelle :

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN value ELSE 0 END)
```

ou version courte :

```sql
AGGREGATION_FUNCTION(CASE WHEN condition THEN 1 END)
```

Ce qui se passe :

- `CASE` renvoie une valeur selon la condition. Dans la version courte, si la condition n'est pas satisfaite, il renvoie `NULL` ;
- la fonction d'agrégation accumule le résultat par groupe ;
- en sortie, vous obtenez une métrique basée sur la condition.

## Somme conditionnelle

### Exemple : sommes de ventes par employé avec découpage par catégories de montant

```sql
SELECT
    staff_id,
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END) AS low_amount_total,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN amount ELSE 0 END) AS medium_amount_total,
    SUM(CASE WHEN amount > 6 THEN amount ELSE 0 END) AS high_amount_total
FROM payment
GROUP BY staff_id;
```

**Résultat :** une requête renvoie trois sommes différentes pour chaque employé.

## Moyenne conditionnelle

### Exemple : montant moyen des paiements élevés par employé

```sql
SELECT
    staff_id,
    AVG(CASE WHEN amount >= 5 THEN amount END) AS avg_big_payment
FROM payment
GROUP BY staff_id;
```

**Résultat :** pour chaque employé, la moyenne est calculée uniquement pour les paiements où `amount >= 5`.

Pourquoi `ELSE 0` n'est généralement pas nécessaire ici :

- `AVG` est calculé comme la somme des valeurs divisée par leur nombre ;
- si l'on met `0` pour les lignes qui ne satisfont pas la condition, ces zéros entrent dans le calcul et abaissent la moyenne ;
- c'est pourquoi pour un `AVG` conditionnel on utilise généralement `ELSE NULL` ou on omet complètement `ELSE`.

## Comptage conditionnel

### Exemple : combien de paiements dans chaque plage de montant

```sql
SELECT
    customer_id,
    COUNT(CASE WHEN amount < 2 THEN 1 END) AS low_payments,
    COUNT(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 END) AS medium_payments,
    COUNT(CASE WHEN amount > 6 THEN 1 END) AS high_payments
FROM payment
GROUP BY customer_id;
```

**Résultat :** pour chaque client, la requête renvoie le nombre de paiements « faibles », « moyens » et « élevés ».

Pourquoi `ELSE` n'est pas nécessaire ici :

- si la condition est vraie, `CASE` renvoie `1` ;
- si la condition est fausse et que `ELSE` n'est pas indiqué, `CASE` renvoie `NULL` ;
- `COUNT(expression)` ne compte que les valeurs non-`NULL`, donc seules les lignes où la condition est satisfaite sont prises en compte.

Important : il ne faut pas écrire `ELSE 0` dans ce modèle pour `COUNT`, car `0` n'est pas `NULL`, et `COUNT` commence alors à compter presque toutes les lignes.

### Exemple : comptage des locations retournées et non retournées

```sql
SELECT
    staff_id,
    COUNT(return_date) AS returned_count,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count
FROM rental
GROUP BY staff_id;
```

Ce qui se passe ici :

- `COUNT(return_date)` compte uniquement les valeurs non-`NULL`, donc le nombre de locations retournées ;
- `COUNT(CASE WHEN return_date IS NULL THEN 1 END)` compte uniquement les lignes où la date de retour est absente, donc les locations non retournées ;
- `GROUP BY staff_id` forme des compteurs séparés pour chaque employé.

Résultat : en une seule requête, vous obtenez les deux métriques pour chaque employé.

## Technique pivot avec `CASE`

### Qu'est-ce qu'un pivot en SQL

Le pivot est la transformation de lignes en colonnes. Généralement, les données sources contiennent les catégories en lignes, tandis que dans le rapport on veut voir ces catégories sous forme de colonnes séparées.

Dans de nombreux SGBD, il existe un opérateur spécial `PIVOT`, mais la méthode universelle et portable reste l'agrégation conditionnelle avec `CASE`.

### Modèle pivot de base

```sql
SELECT
    group_column,
    SUM(CASE WHEN pivot_key = 'A' THEN measure ELSE 0 END) AS col_a,
    SUM(CASE WHEN pivot_key = 'B' THEN measure ELSE 0 END) AS col_b,
    SUM(CASE WHEN pivot_key = 'C' THEN measure ELSE 0 END) AS col_c
FROM source_table
GROUP BY group_column;
```

### Exemple : pivot par classification des films

Ci-dessous, pour chaque catégorie de films, nous comptons le nombre de films par classification dans des colonnes séparées :

```sql
SELECT
    c.name AS category,
    COUNT(CASE WHEN f.rating = 'G' THEN 1 END) AS g_films_count,
    AVG(CASE WHEN f.rating = 'G' THEN length ELSE 0 END) AS g_films_average_length,
    COUNT(CASE WHEN f.rating = 'PG' THEN 1 END) AS pg_films_count,
    AVG(CASE WHEN f.rating = 'PG' THEN length ELSE 0 END) AS pg_films_average_length,
    COUNT(CASE WHEN f.rating = 'PG-13' THEN 1 END) AS pg13_films_count,
    AVG(CASE WHEN f.rating = 'PG-13' THEN length ELSE 0 END) AS pg13_films_average_length,
    COUNT(CASE WHEN f.rating = 'R' THEN 1 END) AS r_films_count,
    AVG(CASE WHEN f.rating = 'R' THEN length ELSE 0 END) AS r_films_average_length,
    COUNT(CASE WHEN f.rating = 'NC-17' THEN 1 END) AS nc17_films_rating,
    AVG(CASE WHEN f.rating = 'NC-17' THEN length ELSE 0 END) AS nc17_films_average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name;
```

**Résultat :** chaque ligne est une catégorie, et les colonnes montrent le nombre de films de chaque classification et leur durée moyenne.

## Recommandations pratiques

- Pour `SUM`, on utilise généralement `ELSE 0` pour que les lignes hors condition apportent une contribution nulle.
- Pour `COUNT(CASE ...)`, `ELSE` n'est généralement pas nécessaire : `COUNT` ignore déjà les `NULL`.
- Pour `AVG(CASE ...)`, on utilise plus souvent `ELSE NULL` ou une version sans `ELSE` pour ne pas sous-estimer la moyenne.
- Si vous avez beaucoup de métriques conditionnelles, donnez des alias explicites (`*_count`, `*_total`).
- Vérifiez que les conditions dans `CASE` ne se chevauchent pas si les catégories doivent être mutuellement exclusives.
- Pour les grandes requêtes, validez d'abord la logique sur un petit jeu de données ou avec `LIMIT`.

## Utilisation pratique

1. **Pivot par jour de la semaine :**
    ```sql
    SELECT
        MONTH(rental_date) AS rental_month,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Monday' THEN 1 ELSE 0 END) AS monday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Tuesday' THEN 1 ELSE 0 END) AS tuesday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Wednesday' THEN 1 ELSE 0 END) AS wednesday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Thursday' THEN 1 ELSE 0 END) AS thursday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Friday' THEN 1 ELSE 0 END) AS friday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Saturday' THEN 1 ELSE 0 END) AS saturday_rentals,
        SUM(CASE WHEN DAYNAME(rental_date) = 'Sunday' THEN 1 ELSE 0 END) AS sunday_rentals
    FROM rental
    GROUP BY MONTH(rental_date);
    ```
    Cette requête montre combien de locations ont été créées chaque mois selon les jours de la semaine.

2. **Calcul des parts conditionnelles :**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

### Petit point sur la syntaxe `FILTER`

Dans certains SGBD (par exemple PostgreSQL), la condition peut être sortie du `CASE` vers `FILTER` :

```sql
COUNT(*) FILTER (WHERE condition)
SUM(amount) FILTER (WHERE condition)
```

Le sens est le même qu'avec l'agrégation conditionnelle via `CASE` : la fonction d'agrégation traite non pas toutes les lignes, mais seulement celles qui passent la condition dans `WHERE` à l'intérieur de `FILTER`.

Cette syntaxe est souvent plus lisible, surtout si dans un même `SELECT` il faut calculer plusieurs métriques différentes avec des conditions différentes.

Par exemple :

```sql
SELECT
    customer_id,
    COUNT(*) AS total_payments,
    COUNT(*) FILTER (WHERE amount >= 5) AS big_payments_count,
    SUM(amount) FILTER (WHERE amount >= 5) AS big_payments_total
FROM payment
GROUP BY customer_id;
```

Dans cet exemple :

- `COUNT(*)` compte tous les paiements du client ;
- `COUNT(*) FILTER (WHERE amount >= 5)` compte seulement les paiements « élevés » ;
- `SUM(amount) FILTER (WHERE amount >= 5)` additionne seulement ces paiements.

Autrement dit, `FILTER` fait le même travail que `CASE`, mais sous une forme plus compacte. En même temps, il est important de se rappeler que cette syntaxe n'est pas prise en charge par tous les SGBD.

## Points clés de cette leçon

- L'agrégation conditionnelle est une fonction d'agrégation plus une expression conditionnelle, le plus souvent `CASE`.
- Avec `SUM(CASE ...)`, `COUNT(CASE ...)` et `AVG(CASE ...)`, vous pouvez obtenir plusieurs métriques dans une seule requête.
- Le pivot avec `CASE` est une méthode universelle pour transformer des lignes en colonnes.
- Cette approche convient bien aux rapports analytiques et aux tableaux de bord.

En maîtrisant l'agrégation conditionnelle, vous pourrez écrire des requêtes SQL plus compactes et plus expressives pour l'analyse métier.
