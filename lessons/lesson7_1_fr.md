---
title: "Tutoriel Fonctions Fenêtre SQL : Maîtriser l'Analyse Avancée avec ROW_NUMBER & PARTITION BY"
description: "Apprenez les fonctions de fenêtre SQL pour l'analyse avancée. Maîtrisez ROW_NUMBER(), RANK(), PARTITION BY et la clause OVER avec des exemples MySQL pratiques. Guide complet pour analystes de données."
keywords: "fonctions fenêtre SQL, ROW_NUMBER SQL, PARTITION BY, clause OVER, analytique SQL, tutoriel SQL avancé, analyse données SQL, MySQL fonctions fenêtre, PostgreSQL analytique, fonctions classement SQL"
lang: "fr"
region: "FR, BE, CH, CA"
---

# Leçon 7.1 : Fonctions de fenêtre pour l'analyse avancée des données

Les fonctions de fenêtre sont l'une des fonctionnalités les plus puissantes de SQL pour effectuer des calculs analytiques complexes. Contrairement aux fonctions d'agrégation qui regroupent plusieurs lignes en un seul résultat, les fonctions de fenêtre vous permettent d'effectuer des calculs sur un ensemble de lignes liées à la ligne actuelle—tout en préservant les lignes individuelles dans votre ensemble de résultats.

Cette leçon introduit les concepts fondamentaux des fonctions de fenêtre et démontre comment elles peuvent transformer vos capacités d'analyse de données.

## Qu'est-ce qu'une fonction de fenêtre ?

Une **fonction de fenêtre** effectue un calcul sur un ensemble de lignes de table qui sont d'une manière ou d'une autre liées à la ligne actuelle. Cet ensemble de lignes est appelé une "fenêtre" ou "cadre de fenêtre". La différence clé avec les fonctions d'agrégation classiques est que les fonctions de fenêtre **ne regroupent pas** les lignes en une seule ligne de sortie—chaque ligne conserve son identité.

Imaginez que vous regardez à travers une fenêtre mobile pendant que vous parcourez vos données. Pour chaque ligne, vous pouvez voir et calculer des valeurs basées sur les lignes associées autour d'elle, mais chaque ligne apparaît toujours séparément dans le résultat.

**Caractéristiques clés :**
- Les fonctions de fenêtre opèrent sur un ensemble de lignes défini par la clause `OVER`
- Elles retournent une valeur pour **chaque** ligne de l'ensemble de résultats
- Elles ne réduisent pas le nombre de lignes retournées par la requête
- Elles peuvent être utilisées pour le classement, l'agrégation et les opérations analytiques

## Syntaxe de base

La syntaxe générale d'une fonction de fenêtre est :

```sql
nom_fonction_fenetre(expression) OVER (
    [PARTITION BY expression_partition]
    [ORDER BY expression_tri]
    [clause_cadre_fenetre]
)
```

**Composants :**
- **nom_fonction_fenetre** : La fonction à appliquer (par exemple, `ROW_NUMBER`, `SUM`, `AVG`)
- **Clause OVER** : Définit la fenêtre de lignes pour la fonction
- **PARTITION BY** (optionnel) : Divise l'ensemble de résultats en partitions (groupes)
- **ORDER BY** (optionnel) : Définit l'ordre des lignes dans chaque partition
- **clause_cadre_fenetre** (optionnel) : Affine davantage quelles lignes sont incluses dans la fenêtre

## Votre première fonction de fenêtre : ROW_NUMBER()

Commençons par l'une des fonctions de fenêtre les plus couramment utilisées : `ROW_NUMBER()`. Cette fonction attribue un numéro séquentiel unique à chaque ligne dans une partition.

### Exemple 1 : Numérotation de tous les paiements

```sql
SELECT
    payment_id,
    customer_id,
    amount,
    payment_date,
    ROW_NUMBER() OVER (ORDER BY payment_date) AS row_num
FROM
    payment
LIMIT 10;
```

Cette requête attribue un numéro séquentiel à chaque paiement ordonné par date de paiement. La clause `OVER (ORDER BY payment_date)` indique à SQL de :
1. Ordonner toutes les lignes par `payment_date`
2. Attribuer des numéros de ligne à partir de 1

### Exemple 2 : Numérotation dans les groupes avec PARTITION BY

Le véritable pouvoir des fonctions de fenêtre apparaît lorsque vous utilisez `PARTITION BY` pour créer des fenêtres séparées pour différents groupes :

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY payment_date
    ) AS payment_number
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id, 
    payment_date;
```

Voici ce qui se passe :
- `PARTITION BY customer_id` crée une fenêtre séparée pour chaque client
- Dans la fenêtre de chaque client, les lignes sont ordonnées par `payment_date`
- `ROW_NUMBER()` commence à compter à partir de 1 pour chaque nouveau client
- Cela vous permet de voir le 1er, 2ème, 3ème paiement pour chaque client

**Visualisation :**
```
Client 1 :      Client 2 :      Client 3 :
Ligne 1 ----\   Ligne 1 ----\   Ligne 1 ----\
Ligne 2 -----\  Ligne 2 -----\  Ligne 2 -----\
Ligne 3 ------\ Ligne 3 ------\ Ligne 3 ------\
   ...             ...             ...
```

*Chaque client a sa propre numérotation de lignes indépendante.*

## Applications pratiques

### Trouver la transaction la plus récente

Les fonctions de fenêtre facilitent l'identification de l'enregistrement le plus récent dans chaque groupe :

```sql
WITH numbered_payments AS (
    SELECT
        customer_id,
        amount,
        payment_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY payment_date DESC
        ) AS recency_rank
    FROM
        payment
)
SELECT
    customer_id,
    amount,
    payment_date
FROM
    numbered_payments
WHERE
    recency_rank = 1
ORDER BY
    customer_id
LIMIT 10;
```

Cette requête trouve le paiement le plus récent pour chaque client en :
1. Numérotant les paiements pour chaque client dans l'ordre décroissant des dates
2. Filtrant pour `recency_rank = 1` (le plus récent)

### Comparer chaque ligne aux valeurs agrégées

Les fonctions de fenêtre peuvent également effectuer des agrégations tout en conservant les lignes individuelles :

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    SUM(amount) OVER (PARTITION BY customer_id) AS total_spent,
    AVG(amount) OVER (PARTITION BY customer_id) AS avg_payment,
    amount - AVG(amount) OVER (PARTITION BY customer_id) AS diff_from_avg
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_date;
```

Pour chaque paiement, cette requête montre :
- Le montant du paiement individuel
- Le montant total dépensé par ce client (sur tous ses paiements)
- Le montant moyen des paiements pour ce client
- La différence entre ce paiement spécifique et leur moyenne

Remarquez comment les fonctions d'agrégation classiques nécessiteraient un `GROUP BY` et regrouperaient les lignes, mais les fonctions de fenêtre vous permettent de conserver tous les détails tout en ajoutant un contexte agrégé.

## Fonctions de fenêtre vs GROUP BY

Il est important de comprendre la différence :

**GROUP BY (Fonctions d'agrégation) :**
```sql
SELECT
    customer_id,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_amount
FROM
    payment
GROUP BY
    customer_id;
```
Résultat : Une ligne par client

**Fonctions de fenêtre :**
```sql
SELECT
    customer_id,
    payment_id,
    amount,
    COUNT(*) OVER (PARTITION BY customer_id) AS payment_count,
    SUM(amount) OVER (PARTITION BY customer_id) AS total_amount
FROM
    payment;
```
Résultat : Chaque ligne de paiement préservée, avec des valeurs agrégées ajoutées comme colonnes supplémentaires

## Points clés à retenir

- Les **fonctions de fenêtre** effectuent des calculs sur des lignes liées tout en maintenant toutes les lignes individuelles dans l'ensemble de résultats.
- La **clause OVER** est essentielle et définit la fenêtre de lignes sur laquelle la fonction doit opérer.
- **PARTITION BY** divise les données en groupes, avec la fonction de fenêtre appliquée séparément à chaque groupe.
- **ORDER BY** dans la clause OVER détermine l'ordre des lignes pour la fonction (crucial pour des fonctions comme `ROW_NUMBER()`).
- Les fonctions de fenêtre sont parfaites pour le classement, les totaux cumulatifs, les moyennes mobiles et la comparaison de valeurs individuelles aux agrégats de groupe.
- Contrairement à `GROUP BY`, les fonctions de fenêtre **ne regroupent pas** les lignes—elles ajoutent des colonnes calculées à vos données existantes.

Dans les prochaines leçons, nous explorerons d'autres fonctions de fenêtre comme `RANK()`, `DENSE_RANK()`, `NTILE()`, et approfondirons les cadres de fenêtre et les calculs analytiques avancés.
