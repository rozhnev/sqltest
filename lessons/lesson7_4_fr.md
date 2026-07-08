---
title: "Fonctions de fenetre SQL : LAG, LEAD, FIRST_VALUE et LAST_VALUE"
description: "Apprenez LAG, LEAD, FIRST_VALUE et LAST_VALUE : syntaxe, cas d'usage courants, comparaison de lignes sans self join et nuance importante de LAST_VALUE avec le frame."
keywords: ["LAG SQL", "LEAD SQL", "FIRST_VALUE SQL", "LAST_VALUE SQL", "fonctions de fenetre SQL", "Sakila"]
teaches: ["Utiliser LAG et LEAD pour comparer la ligne courante aux lignes voisines", "Appliquer FIRST_VALUE et LAST_VALUE pour acceder aux valeurs extremes d'une fenetre", "Comprendre comment le frame de fenetre influence le resultat de LAST_VALUE"]
about: ["SQL", "Window functions", "LAG", "LEAD", "FIRST_VALUE", "LAST_VALUE"]
---

_Temps de lecture: ~9 minutes_

Cette lecon presente les fonctions de fenetre `LAG`, `LEAD`, `FIRST_VALUE` et `LAST_VALUE`. Vous allez apprendre a recuperer une valeur precedente ou suivante sans `JOIN`, a obtenir la premiere et la derniere valeur dans une fenetre, et a comprendre pourquoi `LAST_VALUE` demande souvent un frame explicite. A la fin de cette lecon, vous pourrez utiliser ces fonctions avec assurance pour comparer des lignes, analyser des evolutions et construire des rapports analytiques.

# `LAG`, `LEAD`, `FIRST_VALUE` et `LAST_VALUE`

Dans la lecon precedente, nous avons etudie les frames de fenetre et vu comment leurs limites influencent les calculs. Passons maintenant aux fonctions qui permettent de regarder en arriere, en avant, et d'obtenir les valeurs aux bornes de la fenetre.

Ces fonctions sont particulierement utiles en analyse : elles permettent de comparer les ventes par jour, d'identifier l'action precedente d'un client, de calculer un ecart par rapport a une valeur anterieure, et de trouver la premiere ou la derniere ligne d'un groupe sans `self join`.

<img src="/images/lessons/lesson7_4-window-offsets.svg" alt="LAG LEAD FIRST_VALUE LAST_VALUE" width="100%">

## Ce que font ces fonctions

Les quatre fonctions sont des fonctions de fenetre et s'utilisent avec `OVER (...)`.

- `LAG` retourne une valeur provenant d'une ligne precedente dans la fenetre.
- `LEAD` retourne une valeur provenant d'une ligne suivante dans la fenetre.
- `FIRST_VALUE` retourne la premiere valeur dans la fenetre courante.
- `LAST_VALUE` retourne la derniere valeur dans la fenetre courante.

L'idee essentielle est simple : la ligne courante reste la meme, mais elle peut acceder aux valeurs d'autres lignes de la meme partition.

## Syntaxe de base

### `LAG` et `LEAD`

```sql
LAG(expression [, offset [, default_value]]) OVER (
    [PARTITION BY ...]
    ORDER BY ...
)

LEAD(expression [, offset [, default_value]]) OVER (
    [PARTITION BY ...]
    ORDER BY ...
)
```

- `expression` est la valeur a recuperer depuis une autre ligne.
- `offset` indique de combien de lignes aller en arriere ou en avant.
- `default_value` definit la valeur retournee si cette ligne n'existe pas.

### `FIRST_VALUE` et `LAST_VALUE`

```sql
FIRST_VALUE(expression) OVER (
    [PARTITION BY ...]
    ORDER BY ...
    [frame_clause]
)

LAST_VALUE(expression) OVER (
    [PARTITION BY ...]
    ORDER BY ...
    [frame_clause]
)
```

Pour `FIRST_VALUE` et surtout `LAST_VALUE`, le frame de fenetre est important. Sans frame explicite, `LAST_VALUE` donne souvent un resultat different de celui attendu par les debutants.

---

## Utiliser `LAG`

`LAG` est pratique lorsque vous devez comparer la ligne courante avec la precedente.

### Paiement precedent d'un client

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LAG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS previous_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultat : chaque ligne montre le paiement courant et le montant du paiement precedent du meme client.*

### Ecart par rapport au paiement precedent

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    amount - LAG(amount, 1, 0) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS amount_diff
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultat : vous voyez de combien le paiement courant differe du precedent. Pour la premiere ligne, `0` est utilise par defaut.*

---

## Utiliser `LEAD`

`LEAD` fonctionne de facon symetrique, mais regarde vers l'avant.

### Paiement suivant d'un client

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LEAD(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS next_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultat : chaque ligne affiche le montant du paiement suivant de ce client.*

### Date de location suivante

```sql
SELECT
    customer_id,
    rental_date,
    LEAD(rental_date) OVER (
        PARTITION BY customer_id
        ORDER BY rental_date
    ) AS next_rental_date
FROM rental
WHERE customer_id = 1
ORDER BY rental_date;
```

*Resultat : la requete montre quand ce meme client effectuera la location suivante.*

---

## Utiliser `FIRST_VALUE`

`FIRST_VALUE` retourne la premiere valeur dans la fenetre. C'est utile lorsque vous voulez comparer la ligne courante a un point de depart.

### Premier paiement d'un client

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    FIRST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_payment_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultat : le montant du tout premier paiement du client est repete sur chaque ligne de la fenetre.*

### Comparer le paiement courant au premier

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    amount - FIRST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS diff_from_first
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultat : cela aide a mesurer l'ecart entre les valeurs courantes et la premiere valeur de la sequence.*

---

## Utiliser `LAST_VALUE`

`LAST_VALUE` semble simple, mais c'est ici que les attentes sont souvent trompeuses.

### Nuance importante : le frame par defaut

Si vous ecrivez ceci :

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LAST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
    ) AS last_amount_default
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

alors, dans de nombreux SGBD, le resultat n'est pas la derniere valeur de toute la partition, mais la valeur a la fin du frame courant. Tres souvent, cela correspond simplement a la ligne courante.

### Version correcte pour la derniere valeur de la partition

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    LAST_VALUE(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_payment_amount
FROM payment
WHERE customer_id = 1
ORDER BY payment_date;
```

*Resultat : chaque ligne peut maintenant voir le montant du dernier paiement du client dans toute la partition.*

### Pourquoi c'est utile

Ce schema est pratique lorsque vous devez comparer une valeur courante a la derniere valeur connue d'une serie, au statut final d'une commande, ou au dernier paiement d'un client.

---

## Comparaison de `LAG`, `LEAD`, `FIRST_VALUE` et `LAST_VALUE`

| Fonction | Ce qu'elle retourne | Cas d'usage typique |
|---|---|---|
| `LAG` | Valeur d'une ligne precedente | Comparaison avec une valeur passee |
| `LEAD` | Valeur d'une ligne suivante | Preparation de l'etape ou de la date suivante |
| `FIRST_VALUE` | Premiere valeur dans la fenetre | Valeur de reference pour comparer |
| `LAST_VALUE` | Derniere valeur dans la fenetre | Valeur finale dans une sequence |

Si le besoin principal est de comparer des lignes voisines, `LAG` et `LEAD` sont en general les bons choix. Si vous avez besoin d'un point de reference au debut ou a la fin de la fenetre, utilisez `FIRST_VALUE` et `LAST_VALUE`.

---

## Exemple pratique : chiffre d'affaires journalier et comparaison avec les jours voisins

Commencons par agreger les paiements par jour, puis appliquons les fonctions de fenetre au resultat deja agrege :

```sql
SELECT
    pay_day,
    daily_total,
    LAG(daily_total) OVER (ORDER BY pay_day) AS previous_day_total,
    LEAD(daily_total) OVER (ORDER BY pay_day) AS next_day_total,
    FIRST_VALUE(daily_total) OVER (
        ORDER BY pay_day
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_day_total,
    LAST_VALUE(daily_total) OVER (
        ORDER BY pay_day
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_day_total
FROM (
    SELECT
        DATE(payment_date) AS pay_day,
        SUM(amount) AS daily_total
    FROM payment
    GROUP BY DATE(payment_date)
) AS daily_stats
ORDER BY pay_day;
```

*Resultat : chaque date obtient le chiffre d'affaires du jour precedent, du jour suivant, ainsi que les premiere et derniere valeurs de la sequence complete.*

Ce modele est tres utile pour l'analyse de series temporelles, la preparation de tableaux de bord et la detection des variations de tendance.

---

## Questions frequentes

### Quelle est la difference entre `LAG` et `LEAD` ?
`LAG` regarde en arriere et retourne une valeur issue d'une ligne precedente, tandis que `LEAD` regarde en avant et retourne une valeur issue d'une ligne suivante. Les deux fonctions operent dans la fenetre definie et selon l'ordre de tri choisi.

### Pourquoi `LAST_VALUE` retourne-t-il souvent la ligne courante ?
Parce que le resultat depend du frame de fenetre. Si vous gardez le frame par defaut, la derniere ligne du frame peut etre la ligne courante. Pour obtenir la derniere valeur de toute la partition, il faut generalement ecrire `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`.

### Peut-on utiliser `LAG` et `LEAD` sans `PARTITION BY` ?
Oui. Dans ce cas, la fonction travaille sur l'ensemble du resultat comme sur une seule grande partition. C'est utile lorsque vous voulez analyser une sequence globale sans la separer en groupes.

---

## Questions d'entretien

### Quand utiliser `LAG` et quand utiliser `LEAD` ?
Utilisez `LAG` lorsque vous devez comparer la ligne courante avec la precedente, par exemple pour trouver la variation par rapport au paiement precedent. Utilisez `LEAD` lorsque vous devez regarder vers l'avant, par exemple pour obtenir la date de l'evenement suivant ou la prochaine valeur d'une metrique.

### En quoi `FIRST_VALUE` differe-t-il de `MIN` ?
`MIN` retourne la valeur minimale sur un ensemble de lignes, tandis que `FIRST_VALUE` retourne la valeur de la premiere ligne selon l'ordre defini. Si l'ordre de tri ne correspond pas a la valeur minimale, les resultats seront differents.

### Pourquoi `LAST_VALUE` exige-t-il souvent un frame explicite ?
Parce que `LAST_VALUE` ne signifie pas "la derniere ligne de la partition dans tous les cas". Elle signifie la derniere ligne du frame courant. Si le frame par defaut se termine sur la ligne courante, la fonction retournera la valeur courante. Un frame explicite etend la fenetre a toute la partition.

---

**Points cles de cette lecon:**

- `LAG` et `LEAD` permettent d'acceder aux lignes voisines sans `self join`.
- `FIRST_VALUE` et `LAST_VALUE` retournent les valeurs aux bornes de la fenetre, et pas simplement le minimum ou le maximum.
- Pour toutes ces fonctions, la clause `ORDER BY` est essentielle car elle definit la sequence des lignes.
- `LAST_VALUE` exige souvent le frame explicite `UNBOUNDED PRECEDING ... UNBOUNDED FOLLOWING`.
- Ces fonctions sont particulierement utiles pour l'analyse de sequences, les series temporelles et la detection de changements entre lignes.

Dans la prochaine lecon, nous appliquerons les fonctions de fenetre aux totaux cumules et aux moyennes mobiles.
