# Leçon 4.4 : Agrégation conditionnelle avec `CASE WHEN ... THEN ... END` en SQL

L'agrégation conditionnelle en SQL permet de calculer plusieurs métriques dans une seule requête, sans lancer plusieurs requêtes séparées. L'idée est simple : utiliser `CASE` à l'intérieur d'une fonction d'agrégation (`SUM`, `COUNT`, `AVG`) afin d'inclure seulement les lignes qui correspondent à une condition.

Cette approche est particulièrement utile pour les rapports, les tableaux de bord et l'analytique, quand il faut obtenir plusieurs indicateurs à la fois : volumes, montants, parts, répartitions par statut, etc.

Dans cette leçon, nous allons voir :

- comment fonctionne l'agrégation conditionnelle ;
- comment calculer des comptes et des sommes conditionnels ;
- comment construire des rapports de type pivot (transformer des lignes en colonnes) avec `CASE`.

## Idée de base

Modèle classique d'agrégation conditionnelle :

```sql
SUM(CASE WHEN condition THEN value ELSE 0 END)
```

ou pour compter des lignes :

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END)
```

Ce qui se passe :

- `CASE` renvoie une valeur uniquement pour les lignes qui correspondent ;
- la fonction d'agrégation additionne les résultats par groupe ;
- la sortie finale est une métrique basée sur la condition.

## Comptage conditionnel

### Exemple : nombre de paiements par tranche de montant

```sql
SELECT
    customer_id,
    SUM(CASE WHEN amount < 2 THEN 1 ELSE 0 END) AS low_payments,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 ELSE 0 END) AS medium_payments,
    SUM(CASE WHEN amount > 6 THEN 1 ELSE 0 END) AS high_payments
FROM payment
GROUP BY customer_id
LIMIT 20;
```

**Résultat :** pour chaque client, la requête renvoie le nombre de paiements faibles, moyens et élevés.

## Somme conditionnelle

### Exemple : montants de vente par employé avec découpage par catégorie de montant

```sql
SELECT
    staff_id,
    SUM(CASE WHEN amount < 2 THEN amount ELSE 0 END) AS low_amount_total,
    SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN amount ELSE 0 END) AS medium_amount_total,
    SUM(CASE WHEN amount > 6 THEN amount ELSE 0 END) AS high_amount_total
FROM payment
GROUP BY staff_id;
```

**Résultat :** une seule requête renvoie trois totaux différents par employé.

## Agrégation conditionnelle avec `COUNT()`

Les comptages conditionnels peuvent aussi se faire avec `COUNT`, pas seulement avec `SUM(...1/0...)` :

```sql
COUNT(CASE WHEN condition THEN 1 END)
```

Cette forme est également valide, car `COUNT` ne compte que les valeurs non-`NULL`.

### Exemple : compter les locations retournées et non retournées

```sql
SELECT
    staff_id,
    COUNT(CASE WHEN return_date IS NULL THEN 1 END) AS not_returned_count,
    COUNT(CASE WHEN return_date IS NOT NULL THEN 1 END) AS returned_count
FROM rental
GROUP BY staff_id;
```

## Technique pivot avec `CASE`

### Qu'est-ce qu'un pivot en SQL

Un pivot transforme des lignes en colonnes. Les données sources stockent souvent les catégories dans des lignes, alors qu'un rapport attend ces catégories sous forme de colonnes distinctes.

Certaines bases de données proposent un opérateur `PIVOT`, mais la méthode la plus universelle et portable reste l'agrégation conditionnelle avec `CASE`.

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

### Exemple : pivot par classification de films

Dans l'exemple ci-dessous, pour chaque catégorie de films, on compte le nombre de films par classification dans des colonnes séparées :

```sql
SELECT
    c.name AS category,
    SUM(CASE WHEN f.rating = 'G' THEN 1 ELSE 0 END) AS rating_g,
    SUM(CASE WHEN f.rating = 'PG' THEN 1 ELSE 0 END) AS rating_pg,
    SUM(CASE WHEN f.rating = 'PG-13' THEN 1 ELSE 0 END) AS rating_pg13,
    SUM(CASE WHEN f.rating = 'R' THEN 1 ELSE 0 END) AS rating_r,
    SUM(CASE WHEN f.rating = 'NC-17' THEN 1 ELSE 0 END) AS rating_nc17
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name;
```

**Résultat :** chaque ligne correspond à une catégorie, et les colonnes `rating_*` montrent la répartition des films par classification.

## Recommandations pratiques

- Utilisez toujours `ELSE 0` dans les agrégations numériques pour éviter des `NULL` inattendus.
- Si vous avez beaucoup de métriques conditionnelles, utilisez des alias explicites (`*_count`, `*_total`).
- Vérifiez que les conditions du `CASE` ne se recouvrent pas quand les catégories doivent être exclusives.
- Pour les requêtes volumineuses, validez d'abord la logique sur un petit jeu de données ou avec `LIMIT`.

## Utilisation pratique

1. **Rapport de paiements dans une seule requête :**
   ```sql
   SELECT
       staff_id,
       COUNT(*) AS payments_total,
       SUM(amount) AS amount_total,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) AS big_payment_count,
       SUM(CASE WHEN amount >= 5 THEN amount ELSE 0 END) AS big_payment_total
   FROM payment
   GROUP BY staff_id;
   ```

2. **Pivot par jour de semaine (idée) :**
   compter les commandes par jour de semaine dans des colonnes séparées via `SUM(CASE WHEN weekday = ... THEN 1 ELSE 0 END)`.

3. **Calcul de part conditionnelle :**
   ```sql
   SELECT
       customer_id,
       SUM(CASE WHEN amount >= 5 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS high_payment_share
   FROM payment
   GROUP BY customer_id;
   ```

## Points clés de cette leçon

- L'agrégation conditionnelle = fonction d'agrégation + `CASE`.
- Avec `SUM(CASE ...)` et `COUNT(CASE ...)`, on calcule plusieurs métriques dans une seule requête.
- Le pivot via `CASE` est une technique universelle pour transformer des lignes en colonnes.
- Cette approche est idéale pour les rapports analytiques et les tableaux de bord.

En maîtrisant l'agrégation conditionnelle, vous pourrez écrire des requêtes SQL plus compactes et plus expressives pour l'analyse métier.
