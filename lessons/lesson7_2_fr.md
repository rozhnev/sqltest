---
title: "Fonctions de Classement SQL : Tutoriel ROW_NUMBER vs RANK vs DENSE_RANK vs NTILE"
description: "Maîtrisez les fonctions de classement SQL : ROW_NUMBER, RANK, DENSE_RANK, NTILE. Apprenez les différences et quand utiliser chaque fonction avec des exemples MySQL pratiques. Guide complet pour l'analyse de données."
keywords: "fonctions classement SQL, ROW_NUMBER, RANK, DENSE_RANK, NTILE, fonctions fenêtre SQL, tutoriel SQL, classement données, SQL analytique, classement MySQL"
lang: "fr"
region: "FR, BE, CH, CA"
---

# Leçon 7.2 : Utiliser ROW_NUMBER, RANK, DENSE_RANK et NTILE

Dans la leçon précédente, nous avons introduit les fonctions de fenêtre et exploré `ROW_NUMBER()`. Maintenant, nous allons approfondir la famille des fonctions de classement qu'offre SQL : `ROW_NUMBER`, `RANK`, `DENSE_RANK` et `NTILE`. Chacune a un but distinct et comprendre quand utiliser chacune est crucial pour une analyse de données efficace.

## Comprendre les différences

Les quatre fonctions assignent une valeur numérique aux lignes en fonction du tri, mais elles gèrent les égalités (valeurs identiques) différemment. Explorons chacune.

### ROW_NUMBER() : Numéros séquentiels uniques

`ROW_NUMBER()` assigne un numéro séquentiel unique à chaque ligne, même si les valeurs sont identiques. Elle traite les égalités comme des lignes différentes.

**Syntaxe:**
```sql
ROW_NUMBER() OVER (
    [PARTITION BY expression_partition]
    ORDER BY expression_tri
)
```

**Exemple : Classer les transactions**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Exemple de résultat:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Point clé:** Même si les deux premiers paiements du client 1 ont des montants identiques (11.99), ils reçoivent des numéros de ligne différents (1 et 2).

### RANK() : Classement avec espaces

`RANK()` assigne le même rang aux lignes avec des valeurs de tri identiques, mais laisse des espaces dans la séquence de numérotation. Si deux lignes partagent le rang 1, le rang suivant est 3 (en sautant 2).

**Syntaxe:**
```sql
RANK() OVER (
    [PARTITION BY expression_partition]
    ORDER BY expression_tri
)
```

**Exemple : Classer les paiements par montant**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    RANK() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Exemple de résultat:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Point clé:** Les deux paiements du client 1 de 11.99 reçoivent le rang 1, et le paiement suivant obtient le rang 3 (pas 2). C'est utile quand vous voulez identifier les égalités mais préserver la position de classement dans l'ensemble complet.

### DENSE_RANK() : Classement sans espaces

`DENSE_RANK()` est similaire à `RANK()` mais ne saute pas les numéros. Si deux lignes partagent le rang 1, le rang suivant est 2 (pas 3).

**Syntaxe:**
```sql
DENSE_RANK() OVER (
    [PARTITION BY expression_partition]
    ORDER BY expression_tri
)
```

**Exemple : Classement dense des montants de paiement**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    DENSE_RANK() OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS payment_rank
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    payment_rank;
```

**Exemple de résultat:**
```
customer_id | amount | payment_date | payment_rank
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 1
1           | 10.99  | 2005-06-19   | 2
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Point clé:** Les deux paiements du client 1 de 11.99 reçoivent le rang 1, et le montant distinct suivant obtient le rang 2. Pas d'espaces dans la séquence de classement. C'est idéal quand vous voulez identifier des groupes distincts sans espaces.

### NTILE() : Distribution des lignes en groupes

`NTILE(n)` divise la partition en n groupes (seaux) et assigne à chaque ligne un numéro de secteur. C'est utile pour l'analyse des centiles et le regroupement des données en quartiles, etc.

**Syntaxe:**
```sql
NTILE(nombre_de_seaux) OVER (
    [PARTITION BY expression_partition]
    ORDER BY expression_tri
)
```

**Exemple : Analyse des quartiles**

```sql
SELECT
    customer_id,
    amount,
    payment_date,
    NTILE(4) OVER (
        PARTITION BY customer_id 
        ORDER BY amount DESC
    ) AS quartile
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    customer_id,
    quartile;
```

**Exemple de résultat:**
```
customer_id | amount | payment_date | quartile
1           | 11.99  | 2005-08-01   | 1
1           | 11.99  | 2005-07-08   | 2
1           | 10.99  | 2005-06-19   | 3
2           | 11.99  | 2005-08-02   | 1
2           | 10.99  | 2005-07-09   | 2
3           | 9.99   | 2005-08-03   | 1
```

**Point clé:** Les lignes sont distribuées en 4 quartiles. C'est extrêmement utile pour l'analyse des centiles—identifier les meilleurs 25% (quartile 1), les 25% suivants (quartile 2), etc.

## Comparaison côte à côte

Voyons les quatre fonctions appliquées aux mêmes données :

```sql
SELECT
    customer_id,
    amount,
    row_number() OVER (ORDER BY amount DESC) AS row_num,
    rank() OVER (ORDER BY amount DESC) AS rnk,
    dense_rank() OVER (ORDER BY amount DESC) AS dense_rnk,
    ntile(3) OVER (ORDER BY amount DESC) AS tertile
FROM
    payment
LIMIT 10;
```

**Exemple de résultat:**
```
customer_id | amount | row_num | rnk | dense_rnk | tertile
1           | 11.99  | 1       | 1   | 1         | 1
1           | 11.99  | 2       | 1   | 1         | 1
2           | 11.99  | 3       | 1   | 1         | 1
5           | 10.99  | 4       | 4   | 2         | 1
6           | 10.99  | 5       | 4   | 2         | 1
3           | 9.99   | 6       | 6   | 3         | 2
4           | 9.99   | 7       | 6   | 3         | 2
7           | 8.99   | 8       | 8   | 4         | 3
8           | 8.99   | 9       | 8   | 4         | 3
9           | 7.99   | 10      | 10  | 5         | 3
```

**Observations:**
- `row_number`: Toujours unique, sans espaces
- `rank`: Regroupe les égalités mais crée des espaces (1, 1, 1, 4, 4, 6, 6, 8, 8, 10)
- `dense_rank`: Regroupe les égalités sans espaces (1, 1, 1, 2, 2, 3, 3, 4, 4, 5)
- `ntile(3)`: Distribue en 3 groupes selon le tri

## Applications pratiques

### Trouver les meilleurs performers (ROW_NUMBER)

Obtenir le client à plus haut service par mois de location :

```sql
WITH ranked_payments AS (
    SELECT
        customer_id,
        amount,
        DATE_TRUNC('month', payment_date) AS month,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_TRUNC('month', payment_date)
            ORDER BY amount DESC
        ) AS rank
    FROM
        payment
)
SELECT
    customer_id,
    amount,
    month
FROM
    ranked_payments
WHERE
    rank = 1
ORDER BY
    month DESC;
```

### Identifier les niveaux de performance (DENSE_RANK)

Catégoriser les films par fréquence de location :

```sql
WITH rental_counts AS (
    SELECT
        film_id,
        COUNT(*) AS rental_count,
        DENSE_RANK() OVER (
            ORDER BY COUNT(*) DESC
        ) AS popularity_tier
    FROM
        rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
    GROUP BY
        film_id
)
SELECT
    film_id,
    rental_count,
    CASE
        WHEN popularity_tier = 1 THEN 'Blockbuster'
        WHEN popularity_tier <= 3 THEN 'Populaire'
        WHEN popularity_tier <= 10 THEN 'Standard'
        ELSE 'Niche'
    END AS popularity_category
FROM
    rental_counts
LIMIT 20;
```

### Analyse des centiles (NTILE)

Segmenter les clients en quartiles de dépenses :

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent,
        NTILE(4) OVER (ORDER BY SUM(amount)) AS spending_quartile
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    spending_quartile,
    COUNT(*) AS customer_count,
    MIN(total_spent) AS low_amount,
    MAX(total_spent) AS high_amount
FROM
    customer_spending
GROUP BY
    spending_quartile
ORDER BY
    spending_quartile;
```

## Quand utiliser chaque fonction

| Fonction | Cas d'usage | Gère les égalités |
|----------|-------------|-------------------|
| `ROW_NUMBER` | Besoin de numéros séquentiels uniques; ne se soucie pas des égalités | Non (tous uniques) |
| `RANK` | Besoin d'identifier la position mais tenir compte des égalités; les espaces sont OK | Oui (avec espaces) |
| `DENSE_RANK` | Besoin d'identification de niveaux sans espaces de position | Oui (sans espaces) |
| `NTILE` | Besoin d'analyse de centiles/quartiles/groupes | Distribue en groupes |

## Points clés à retenir

- **ROW_NUMBER()** donne à chaque ligne un numéro unique, utile pour obtenir les N meilleurs enregistrements de chaque groupe.
- **RANK()** assigne le même rang aux valeurs égales mais saute des rangs (1, 1, 3), utile pour les classements compétitifs.
- **DENSE_RANK()** assigne le même rang aux valeurs égales sans espaces (1, 1, 2), utile pour l'identification de niveaux.
- **NTILE(n)** divise les lignes en seaux pour l'analyse des centiles et distributionnelle.
- Les quatre fonctions font partie de la famille des fonctions de fenêtre et utilisent la clause `OVER`.
- La différence clé est comment elles traitent les valeurs identiques dans la colonne de tri.
- Choisir la bonne fonction dépend de votre objectif analytique : positionnement, regroupement ou distribution.

Dans la leçon suivante, nous explorerons des concepts avancés des fonctions de fenêtre, y compris les cadres de fenêtre, les stratégies de partitionnement et d'autres fonctions analytiques comme `LAG`, `LEAD`, `FIRST_VALUE` et `LAST_VALUE`.
