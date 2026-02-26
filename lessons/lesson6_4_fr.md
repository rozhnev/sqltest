---
title: "SQL Expressions de Table Commune (CTE) : Tutoriel Clause WITH et Exemples"
description: "Maîtrisez les expressions de table commune SQL (CTE). Apprenez la syntaxe de la clause WITH, les avantages par rapport aux sous-requêtes, et les exemples pratiques. Guide complet pour écrire des requêtes SQL plus propres et maintenables."
keywords: "SQL CTE, expression table commune, clause WITH SQL, alternative sous-requête SQL, lisibilité requête, tutoriel SQL, SQL avancé, MySQL CTE, PostgreSQL CTE"
lang: "fr"
region: "FR, BE, CH, CA"
---

# Leçon 6.4 : Expressions de Table Commune (CTE)

Les expressions de table commune, ou CTE, sont l'une des fonctionnalités les plus puissantes et sous-utilisées de SQL. Elles vous permettent de définir des ensembles de résultats temporaires nommés qui peuvent être référencés dans une requête plus grande. Dans cette leçon, nous explorerons comment les CTE peuvent rendre votre code SQL plus lisible, maintenable et plus facile à déboguer.

## Qu'est-ce qu'une CTE ?

Une **expression de table commune (CTE)** est un ensemble de résultats temporaire défini au début d'une requête à l'aide de la clause `WITH`. Pensez-y comme une sous-requête nommée qui peut être utilisée plusieurs fois dans la même requête.

Les avantages clés des CTE :
- **Lisibilité**: Les ensembles de résultats nommés rendent les requêtes plus faciles à comprendre
- **Réutilisabilité**: Référencez le même CTE plusieurs fois sans le redéfinir
- **Modularité**: Décomposez les requêtes complexes en pièces logiques et gérables
- **Maintenabilité**: Les modifications de logique n'ont besoin d'être apportées qu'une seule fois
- **Débogage**: Testez chaque CTE indépendamment avant de les combiner

## Syntaxe de base des CTE

La syntaxe générale d'une CTE est :

```sql
WITH nom_cte AS (
    SELECT ...
)
SELECT * FROM nom_cte;
```

**Composants:**
- **WITH**: Mot-clé qui introduit la CTE
- **nom_cte**: Le nom que vous donnez au résultat temporaire
- **AS**: Mot-clé introduisant la définition de la requête
- **(SELECT ...)**: La requête qui définit la CTE
- La requête principale peut ensuite référencer la CTE par nom

## Votre première CTE

Commençons par un exemple simple qui calcule les dépenses des clients :

```sql
WITH client_dépenses AS (
    SELECT
        customer_id,
        SUM(amount) AS total_dépensé,
        COUNT(*) AS nombre_paiements,
        AVG(amount) AS paiement_moyen
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_dépensé,
    nombre_paiements,
    paiement_moyen
FROM
    client_dépenses
WHERE
    total_dépensé > 100
ORDER BY
    total_dépensé DESC;
```

Cette CTE :
1. Définit un ensemble de résultats nommé appelé `client_dépenses`
2. Calcule les métriques de dépenses pour chaque client
3. Référence cette CTE dans la requête principale pour filtrer les clients qui dépensent beaucoup

Le bénéfice ici est la clarté—l'intention est évidente : nous travaillons avec les données de dépenses des clients.

## CTE vs Sous-requêtes

Comparons la même logique en utilisant une approche traditionnelle de sous-requête :

**Utiliser une sous-requête :**
```sql
SELECT
    customer_id,
    total_dépensé,
    nombre_paiements,
    paiement_moyen
FROM (
    SELECT
        customer_id,
        SUM(amount) AS total_dépensé,
        COUNT(*) AS nombre_paiements,
        AVG(amount) AS paiement_moyen
    FROM
        payment
    GROUP BY
        customer_id
) AS données_dépenses
WHERE
    total_dépensé > 100
ORDER BY
    total_dépensé DESC;
```

**Utiliser une CTE :**
```sql
WITH client_dépenses AS (
    SELECT
        customer_id,
        SUM(amount) AS total_dépensé,
        COUNT(*) AS nombre_paiements,
        AVG(amount) AS paiement_moyen
    FROM
        payment
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    total_dépensé,
    nombre_paiements,
    paiement_moyen
FROM
    client_dépenses
WHERE
    total_dépensé > 100
ORDER BY
    total_dépensé DESC;
```

**Différences clés :**
- La CTE est définie en haut, rendant la structure de la requête immédiatement claire
- La CTE a un nom significatif (`client_dépenses`), pas seulement une sous-requête anonyme
- L'intention de la requête principale est visible avant de plonger dans les transformations de données
- Si vous aviez besoin de référencer cet ensemble de résultats plusieurs fois, vous ne le définissez qu'une seule fois avec une CTE

## Plusieurs CTE dans une requête

Vous pouvez définir plusieurs CTE dans une seule requête, chacune référençant les précédentes :

```sql
WITH client_dépenses AS (
    SELECT
        customer_id,
        SUM(amount) AS total_dépensé
    FROM
        payment
    GROUP BY
        customer_id
),
grands_dépensiers AS (
    SELECT
        customer_id,
        total_dépensé
    FROM
        client_dépenses
    WHERE
        total_dépensé > 150
),
détails_client AS (
    SELECT
        gd.customer_id,
        gd.total_dépensé,
        c.first_name,
        c.last_name,
        c.email
    FROM
        grands_dépensiers gd
    JOIN
        customer c ON gd.customer_id = c.customer_id
)
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS nom_client,
    email,
    total_dépensé
FROM
    détails_client
ORDER BY
    total_dépensé DESC;
```

Dans cette requête :
1. `client_dépenses` calcule le total dépensé par client
2. `grands_dépensiers` filtre les clients avec un total dépensé > 150
3. `détails_client` joint les grands dépensiers avec les informations client
4. La requête principale sélectionne et formate les résultats finaux

Cette structure rend le flux logique clair et facile à suivre.

## Réutilisabilité des CTE

Un aspect puissant des CTE est de vous référencer plusieurs fois :

```sql
WITH ventes_mensuelles AS (
    SELECT
        DATE_TRUNC('month', payment_date) AS mois,
        SUM(amount) AS total_mensuel
    FROM
        payment
    GROUP BY
        DATE_TRUNC('month', payment_date)
)
SELECT
    m1.mois AS mois_actuel,
    m1.total_mensuel AS ventes_courantes,
    m2.total_mensuel AS ventes_mois_précédent,
    ROUND(((m1.total_mensuel - m2.total_mensuel) / m2.total_mensuel * 100), 2) AS pourcentage_changement
FROM
    ventes_mensuelles m1
LEFT JOIN
    ventes_mensuelles m2 ON m1.mois = m2.mois + INTERVAL '1 month'
WHERE
    m1.mois IS NOT NULL
ORDER BY
    m1.mois;
```

Ici, nous référençons `ventes_mensuelles` deux fois—une fois comme `m1` et une fois comme `m2`. Cela nécessiterait deux sous-requêtes séparées si nous n'utilisions pas une CTE.

## CTE avec fonctions de fenêtre

Les CTE fonctionnent magnifiquement avec les fonctions de fenêtre :

```sql
WITH locations_classées AS (
    SELECT
        customer_id,
        rental_date,
        return_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY rental_date DESC
        ) AS rang_location
    FROM
        rental
),
location_récente AS (
    SELECT
        customer_id,
        rental_date,
        return_date
    FROM
        locations_classées
    WHERE
        rang_location = 1
)
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS nom_client,
    lr.rental_date AS date_dernière_location,
    DATEDIFF(CURDATE(), lr.rental_date) AS jours_depuis_location
FROM
    customer c
LEFT JOIN
    location_récente lr ON c.customer_id = lr.customer_id
ORDER BY
    jours_depuis_location DESC
LIMIT 20;
```

Cette requête :
1. Utilise `ROW_NUMBER()` pour identifier la location la plus récente de chaque client
2. Filtre pour obtenir uniquement la location la plus récente par client
3. Joint avec la table client pour afficher les noms client et calculer les jours depuis la location

La structure modulaire rend facile à comprendre et à modifier.

## Exemple pratique : Analyse de cohorte

Les CTE sont excellentes pour les requêtes analytiques complexes comme l'analyse de cohorte :

```sql
WITH première_location_client AS (
    SELECT
        customer_id,
        MIN(rental_date) AS date_première_location,
        DATE_TRUNC('month', MIN(rental_date)) AS mois_cohorte
    FROM
        rental
    GROUP BY
        customer_id
),
historique_location_client AS (
    SELECT
        flc.customer_id,
        flc.mois_cohorte,
        DATE_TRUNC('month', r.rental_date) AS mois_location,
        COUNT(*) AS locations_du_mois
    FROM
        première_location_client flc
    JOIN
        rental r ON flc.customer_id = r.customer_id
    GROUP BY
        flc.customer_id,
        flc.mois_cohorte,
        DATE_TRUNC('month', r.rental_date)
)
SELECT
    mois_cohorte,
    mois_location,
    COUNT(DISTINCT customer_id) AS clients,
    SUM(locations_du_mois) AS total_locations
FROM
    historique_location_client
GROUP BY
    mois_cohorte,
    mois_location
ORDER BY
    mois_cohorte,
    mois_location;
```

Cette analyse complexe devient gérable grâce aux CTE :
1. Première CTE identifie la cohorte de chaque client (mois de première location)
2. Deuxième CTE construit un historique de toutes les locations avec informations de cohorte
3. Requête finale agrège pour afficher les performances de cohorte au fil du temps

## Résumé des avantages

| Aspect | CTE | Sous-requête |
|--------|-----|------------|
| Lisibilité | Hautement lisible avec ensembles nommés | Peut être difficile à lire (structures imbriquées) |
| Réutilisabilité | Facile de référencer plusieurs fois | Doit être redéfini pour chaque utilisation |
| Débogage | Peut tester chaque CTE indépendamment | Difficile d'isoler une logique spécifique |
| Organisation | Structure logique, de haut en bas | Linéaire mais parfois encombrant |
| Performance | Identique ou mieux (dépend de l'optimiseur) | Peut être moins efficace avec imbrication profonde |

## Points clés à retenir

- **Les CTE** sont des ensembles de résultats temporaires nommés définis avec la clause `WITH`
- **Lisibilité**: Les CTE nommées rendent les requêtes auto-documentées
- **Plusieurs CTE**: Enchaînez les CTE, chacune s'appuyant sur la précédente
- **Réutilisabilité**: Référencez le même CTE plusieurs fois sans le redéfinir
- **Pas de pénalité de performance**: Les CTE ne créent pas de stockage intermédiaire ; ce sont des outils d'optimisation de requête
- **Fonctionne avec tout**: Les CTE peuvent inclure des jointures, des agrégations, des fonctions de fenêtre et bien plus
- **Modularité**: Décomposez les requêtes complexes en pièces logiques plus faciles à comprendre et maintenir

Les CTE transforment les requêtes complexes de structures imbriquées inintelligibles en code clair, lisible et maintenable. C'est un outil essentiel dans l'outillage de tout analyste de données.

Dans la leçon suivante, nous explorerons les CTE récursives—une fonctionnalité puissante pour travailler avec des données hiérarchiques.
