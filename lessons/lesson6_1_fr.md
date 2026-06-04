---
title: "Qu'est-ce qu'une sous-requête SQL : bases, types et Inline View"
description: "Une sous-requête est un SELECT dans un autre SELECT. Découvrez les types de sous-requêtes, leur logique d'exécution et Inline View avec Sakila."
keywords: ["SQL subquery", "sous-requête", "Inline View", "requête imbriquée", "WHERE", "FROM"]
teaches: ["Comprendre la logique d'exécution entre requête interne et externe", "Différencier les sous-requêtes scalaires, multi-lignes et tabulaires", "Utiliser Inline View dans la clause FROM"]
about: ["SQL", "Subquery", "Inline View", "Sakila"]
---

_Temps de lecture : ~7 minutes_

Une sous-requête SQL permet de découper un problème en plusieurs étapes à l'intérieur d'une seule instruction. Dans cette leçon, vous verrez l'idée de base des sous-requêtes, leurs types, et comment les utiliser dans `WHERE` et `FROM` avec des exemples de la base Sakila.

# Introduction aux sous-requêtes : requêtes imbriquées et Inline View

Dans les leçons précédentes, vous avez appris à récupérer des données et à les combiner avec `JOIN`. Mais dans des cas réels, il faut souvent calculer un résultat intermédiaire puis l'utiliser dans la requête principale.

C'est exactement le rôle des sous-requêtes : elles permettent une logique par étapes, plus claire et plus flexible.

## Qu'est-ce qu'une sous-requête

Une **sous-requête** (Subquery) est une instruction `SELECT` imbriquée dans une autre requête SQL. La requête qui contient la sous-requête s'appelle la requête **externe**.

Une sous-requête est toujours écrite entre parenthèses `()`.

## Comment une sous-requête s'exécute

Dans la plupart des cas, le SGBD exécute d'abord la requête interne. Son résultat est ensuite transmis à la requête externe, qui termine le filtrage ou la construction du jeu de résultats final.

```sql
-- Exemple conceptuel
SELECT column_name
FROM table_name
WHERE column_name = (SELECT value FROM another_table);
```

*Note : l'expression entre parenthèses est calculée d'abord, puis la condition du `WHERE` externe est appliquée.*

---

## Types principaux de sous-requêtes

- **Sous-requête scalaire** : retourne une seule valeur (une ligne, une colonne).
- **Sous-requête multi-lignes** : retourne une liste de valeurs (une colonne, plusieurs lignes).
- **Sous-requête tabulaire (Inline View)** : retourne un ensemble de lignes et de colonnes utilisé comme table temporaire.

---

## Sous-requête dans SELECT

On peut placer une sous-requête directement dans la liste `SELECT` lorsqu'on veut afficher une métrique supplémentaire à côté des colonnes principales, sans changer la granularité du résultat. C'est particulièrement utile quand un `JOIN` risque de dupliquer les lignes ou d'alourdir l'agrégation.

**Scénario 1 :** afficher le dernier paiement de chaque client (date et montant).

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT p.payment_date
        FROM payment AS p
        WHERE p.customer_id = c.customer_id
        ORDER BY p.payment_date DESC
        LIMIT 1
    ) AS last_payment_date,
    (
        SELECT p.amount
        FROM payment AS p
        WHERE p.customer_id = c.customer_id
        ORDER BY p.payment_date DESC
        LIMIT 1
    ) AS last_payment_amount
FROM
    customer AS c
LIMIT 10;
```

*Résultat : pour chaque client, vous obtenez exactement un paiement « le plus récent ». Avec `JOIN`, c'est souvent plus complexe : il faut d'abord calculer la date maximale, puis refaire une jointure et gérer les égalités.*

**Scénario 2 :** afficher chaque paiement et son écart par rapport au paiement moyen du client.

```sql
SELECT
    p.payment_id,
    p.customer_id,
    p.amount,
    (
        SELECT AVG(p2.amount)
        FROM payment AS p2
        WHERE p2.customer_id = p.customer_id
    ) AS customer_avg_amount,
    p.amount - (
        SELECT AVG(p3.amount)
        FROM payment AS p3
        WHERE p3.customer_id = p.customer_id
    ) AS delta_from_customer_avg
FROM
    payment AS p
LIMIT 15;
```

*Résultat : chaque ligne de paiement conserve sa granularité d'origine et reçoit un benchmark client individuel. Une approche `JOIN` demanderait une table agrégée séparée puis une jointure supplémentaire.*

---

## Sous-requête dans WHERE

Le cas le plus fréquent est la sous-requête dans `WHERE`, quand le filtrage dépend d'une valeur calculée dynamiquement.

**Scénario :** trouver les films dont `replacement_cost` est supérieur à la moyenne de tous les films.

```sql
SELECT
    title,
    replacement_cost
FROM
    film
WHERE
    replacement_cost > (
        SELECT AVG(replacement_cost)
        FROM film
    );
```

*Résultat : la requête interne calcule la moyenne, et la requête externe retourne les films au-dessus de cette moyenne.*

---

## Sous-requête dans FROM (Inline View)

Quand la sous-requête est placée dans `FROM`, elle agit comme une table temporaire dans la requête courante. Cette approche s'appelle **Inline View**.

Important : une Inline View doit avoir un alias.

**Scénario :** obtenir les clients actifs et leurs paiements.

```sql
SELECT
    active_cust.first_name,
    p.amount
FROM
    (
        SELECT
            customer_id,
            first_name
        FROM
            customer
        WHERE
            active = 1
    ) AS active_cust
INNER JOIN
    payment AS p ON active_cust.customer_id = p.customer_id;
```

*Résultat : la requête externe joint le résultat de la sous-requête `active_cust` avec la table `payment`.*

---

## Quand une sous-requête est plus pratique qu'un JOIN

- Pour une logique par étapes, quand il faut d'abord calculer une valeur intermédiaire.
- Pour filtrer sur des agrégats (`AVG`, `MAX`, `MIN`) sans compliquer la requête principale.
- Pour les cas de relations absentes, où `NOT IN` ou `NOT EXISTS` sont souvent plus naturels.

---

**Points clés de cette leçon :**

- Une sous-requête est un `SELECT` imbriqué dans une autre requête SQL.
- La requête interne est généralement exécutée avant la requête externe.
- Une sous-requête peut retourner une valeur, une liste de valeurs, ou un jeu tabulaire complet.
- Une sous-requête dans `FROM` s'appelle Inline View et nécessite un alias.
- Les sous-requêtes rendent les requêtes SQL plus lisibles et plus souples.

## Questions fréquemment posées

### Quelle est la différence entre une sous-requête dans WHERE et dans FROM ?
La sous-requête dans `WHERE` sert généralement à filtrer les lignes de la requête externe. La sous-requête dans `FROM` crée un jeu temporaire (Inline View) que l'on peut ensuite joindre et traiter.

### Faut-il toujours donner un alias à une sous-requête dans FROM ?
Oui. Dans la plupart des SGBD, une sous-requête dans `FROM` doit obligatoirement avoir un alias. Sans alias, la requête échoue.

### Quand vaut-il mieux utiliser NOT EXISTS plutôt que NOT IN ?
Si la sous-requête peut retourner `NULL`, `NOT IN` peut produire un résultat inattendu. Dans ce cas, `NOT EXISTS` est généralement plus fiable.

## Questions d'entretien

### Qu'est-ce qu'une sous-requête et comment s'exécute-t-elle ?
Une **sous-requête** est un `SELECT` imbriqué dans une requête SQL externe. En général, la requête interne s'exécute d'abord, puis la requête externe utilise ce résultat pour filtrer ou construire le résultat final.

### Quelle est la différence entre une sous-requête scalaire et une sous-requête multi-lignes ?
Une **sous-requête scalaire** retourne une seule valeur et s'utilise souvent avec `=` ou `>`. Une **sous-requête multi-lignes** retourne un ensemble de valeurs et s'utilise avec `IN`, `ANY` ou `ALL`.

### Qu'est-ce qu'une Inline View en SQL ?
Une **Inline View** est une sous-requête dans `FROM` qui se comporte comme une table temporaire dans une seule requête. Elle doit obligatoirement avoir un alias pour que ses colonnes puissent être référencées.

Dans la prochaine leçon, nous étudierons en détail les sous-requêtes dans `WHERE` avec les opérateurs `IN`, `EXISTS`, `ANY` et `ALL`.
