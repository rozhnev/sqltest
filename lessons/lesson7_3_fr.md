---
title: "Fenêtres SQL : ROWS, RANGE, GROUPS, BETWEEN, UNBOUNDED — Guide Complet"
description: "Maîtrisez les options de fenêtre SQL : modes ROWS, RANGE, GROUPS, limites BETWEEN, UNBOUNDED PRECEDING/FOLLOWING, CURRENT ROW et fenêtres nommées. Exemples pratiques : totaux cumulés, moyennes mobiles et analyse cumulative."
keywords: "fenêtre SQL, ROWS BETWEEN, RANGE BETWEEN, UNBOUNDED PRECEDING, CURRENT ROW, limites fonctions fenêtre, SQL OVER, moyenne mobile SQL, total cumulé SQL, tutoriel fonctions fenêtre"
lang: "fr"
region: "FR, BE, CH, CA"
---

# Leçon 7.3 : Fenêtres de calcul — Contrôler les limites de la fenêtre

Dans les leçons précédentes, nous avons utilisé les fonctions de fenêtre avec `PARTITION BY` et `ORDER BY`. Mais la clause `OVER` offre un troisième composant tout aussi puissant : le **cadre de fenêtre** (window frame). Un cadre de fenêtre permet de définir précisément *quelles lignes* autour de la ligne courante sont incluses dans le calcul — permettant les totaux cumulés, les moyennes mobiles et bien d'autres patterns de séries temporelles.

## Qu'est-ce qu'un cadre de fenêtre ?

Lorsque vous écrivez `OVER (ORDER BY ...)`, de nombreuses bases de données appliquent un **cadre par défaut** dont vous n'avez peut-être pas conscience. Spécifier un cadre explicitement vous donne un contrôle total sur la fenêtre de calcul.

La syntaxe complète de la clause `OVER` est :

```sql
function_name() OVER (
    [PARTITION BY partition_expression]
    [ORDER BY sort_expression]
    [frame_clause]
)
```

Où `frame_clause` est :

```sql
{ ROWS | RANGE | GROUPS }
BETWEEN frame_start AND frame_end
```

Et chaque limite (`frame_start`, `frame_end`) est l'une des suivantes :

| Mot-clé de limite | Signification |
|---|---|
| `UNBOUNDED PRECEDING` | La toute première ligne de la partition |
| `n PRECEDING` | n lignes (ou unités de plage) avant la ligne courante |
| `CURRENT ROW` | La ligne courante elle-même |
| `n FOLLOWING` | n lignes (ou unités de plage) après la ligne courante |
| `UNBOUNDED FOLLOWING` | La toute dernière ligne de la partition |

---

## Modes de cadre : ROWS, RANGE et GROUPS

Le mode de cadre contrôle comment les limites sont mesurées.

### Mode ROWS

`ROWS` compte les **lignes physiques**. `1 PRECEDING` signifie toujours exactement la ligne qui précède immédiatement la ligne courante dans l'ordre de tri.

Idéal lorsque vous avez besoin d'une fenêtre glissante de largeur fixe (ex. une moyenne mobile sur 7 jours sur des lignes journalières).

### Mode RANGE

`RANGE` compte les **valeurs logiques**. `1 PRECEDING` désigne toutes les lignes dont la valeur `ORDER BY` est dans une unité de la valeur de la ligne courante — pas nécessairement une seule ligne physique.

Idéal lorsque vous souhaitez agréger toutes les lignes ayant la même valeur que la ligne courante, ou toutes les lignes dans une plage de valeurs.

**Important :** Le cadre par défaut lorsque vous spécifiez `ORDER BY` sans clause de cadre explicite est :

```sql
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

Cela signifie que la fenêtre inclut toutes les lignes depuis le début de la partition **jusqu'à et incluant toutes les lignes ayant la même valeur ORDER BY que la ligne courante**.

### Mode GROUPS

`GROUPS` compte les **groupes pairs** (ensembles de lignes avec des valeurs `ORDER BY` identiques). `1 PRECEDING` désigne le groupe complet de lignes ayant la valeur immédiatement inférieure. Ce mode est supporté dans PostgreSQL 11+ et certaines autres bases de données, mais pas dans MySQL/MariaDB.

---

## Patterns de cadres courants

### Total cumulé (Running Total)

Inclure toutes les lignes depuis le début de la partition jusqu'à la ligne courante :

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Exemple de sortie :**
```
customer_id | payment_date | amount | running_total
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 7.98
1           | 2005-07-08   | 11.99  | 19.97
1           | 2005-08-01   | 11.99  | 31.96
```

**Point clé :** Le `running_total` de chaque ligne accumule tous les paiements précédents du client. Le cadre `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` signifie : commencer à la première ligne de cette partition, terminer à la ligne courante.

---

### Moyenne mobile (Sliding Window)

Calculer la moyenne mobile sur 3 paiements pour chaque client :

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY payment_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Exemple de sortie :**
```
customer_id | payment_date | amount | moving_avg_3
1           | 2005-05-25   | 2.99   | 2.99
1           | 2005-06-15   | 4.99   | 3.99
1           | 2005-07-08   | 11.99  | 6.66
1           | 2005-08-01   | 11.99  | 9.66
1           | 2005-08-23   | 5.99   | 9.99
```

**Point clé :** `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` crée une fenêtre de exactement 3 lignes : la ligne courante et les 2 lignes précédentes. Quand moins de 3 lignes existent (au début d'une partition), la fenêtre se réduit en conséquence.

---

### Regard vers l'avant (Including Future Rows)

Calculer la moyenne de la ligne courante et des 2 lignes suivantes :

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ORDER BY payment_date
            ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
        ), 2
    ) AS forward_avg
FROM
    payment
WHERE
    customer_id = 1
ORDER BY
    payment_date;
```

**Point clé :** `CURRENT ROW AND 2 FOLLOWING` déplace la fenêtre vers l'avant. Les deux dernières lignes de la partition calculeront la moyenne sur moins de valeurs car il n'y a plus de lignes après elles.

---

### Agrégat sur toute la partition (comme fenêtre)

Comparer chaque paiement à la moyenne globale du client :

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ), 2
    ) AS customer_avg,
    amount - ROUND(
        AVG(amount) OVER (
            PARTITION BY customer_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ), 2
    ) AS deviation
FROM
    payment
WHERE
    customer_id IN (1, 2)
ORDER BY
    customer_id, payment_date;
```

**Point clé :** `UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` couvre toute la partition — équivalent à un agrégat `GROUP BY` mais sans effondrer les lignes.

---

## ROWS vs RANGE : Comparaison directe

Comprendre la différence entre `ROWS` et `RANGE` est crucial lorsque des lignes partagent des valeurs `ORDER BY` identiques.

```sql
SELECT
    customer_id,
    amount,
    SUM(amount) OVER (
        ORDER BY amount
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sum_rows,
    SUM(amount) OVER (
        ORDER BY amount
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS sum_range
FROM
    payment
WHERE
    customer_id IN (1, 2, 3)
ORDER BY
    amount;
```

**Exemple de sortie :**
```
customer_id | amount | sum_rows | sum_range
3           | 9.99   | 9.99     | 9.99
2           | 10.99  | 20.98    | 20.98
1           | 11.99  | 32.97    | 55.94
2           | 11.99  | 44.96    | 55.94
1           | 11.99  | 55.94    | 55.94
```

**Observations :**
- Avec `ROWS` : chaque ligne physique est comptée individuellement, indépendamment des égalités. La somme cumulée progresse ligne par ligne.
- Avec `RANGE` : toutes les lignes avec la **même valeur amount** sont incluses ensemble. Les deux lignes 11.99 sont traitées comme un même groupe logique, donc `sum_range` saute directement au total complet.

---

## Fenêtres nommées (clause WINDOW)

Si vous utilisez la même définition de cadre plusieurs fois dans une requête, vous pouvez la nommer avec la clause `WINDOW` pour éviter les répétitions :

```sql
SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount)   OVER w AS running_total,
    AVG(amount)   OVER w AS running_avg,
    COUNT(amount) OVER w AS payment_count
FROM
    payment
WHERE
    customer_id = 1
WINDOW w AS (
    PARTITION BY customer_id
    ORDER BY payment_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
ORDER BY
    payment_date;
```

**Point clé :** La clause `WINDOW w AS (...)` définit le cadre une seule fois. Les trois appels de fonctions de fenêtre y font référence via `OVER w`. C'est plus propre, moins sujet aux erreurs et plus facile à maintenir.

*Note : La clause `WINDOW` est supportée dans PostgreSQL, MySQL 8.0+ et MariaDB 10.2+.*

---

## Référence des limites de cadre

| Définition du cadre | Ce qu'il inclut |
|---|---|
| `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Toutes les lignes du début de la partition jusqu'à la ligne courante |
| `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` | Toutes les lignes de la partition (agrégat complet) |
| `ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING` | La ligne courante plus une ligne de chaque côté (fenêtre de 3 lignes) |
| `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW` | La ligne courante et les 2 lignes précédentes (fenêtre glissante de 3) |
| `ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING` | La ligne courante jusqu'à la fin de la partition |
| `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` | Défaut avec `ORDER BY` ; inclut toutes les lignes ayant la même valeur ORDER BY |

---

## Application pratique : ventes journalières avec métriques cumulées et mobiles

Combiner plusieurs cadres de fenêtre dans une seule requête pour une vue complète :

```sql
SELECT
    DATE(payment_date)                            AS payment_day,
    SUM(amount)                                   AS daily_total,
    SUM(SUM(amount)) OVER (
        ORDER BY DATE(payment_date)
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                             AS cumulative_total,
    ROUND(AVG(SUM(amount)) OVER (
        ORDER BY DATE(payment_date)
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2)                                         AS rolling_7day_avg
FROM
    payment
GROUP BY
    DATE(payment_date)
ORDER BY
    payment_day;
```

**Point clé :** L'agrégat externe (`SUM(SUM(amount))`) imbrique une fonction de fenêtre sur des résultats groupés — un pattern puissant pour les tableaux de bord de séries temporelles.

---

## Quand utiliser chaque option de cadre

| Objectif | Cadre recommandé |
|---|---|
| Total cumulatif | `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Agrégat sur toute la partition avec les données de chaque ligne | `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` |
| Moyenne mobile sur N périodes | `ROWS BETWEEN N-1 PRECEDING AND CURRENT ROW` |
| Fenêtre de lissage symétrique | `ROWS BETWEEN N PRECEDING AND N FOLLOWING` |
| Agrégation par plage de valeurs (traiter les égalités en groupe) | `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` |
| Réutiliser le même cadre pour plusieurs fonctions | Clause `WINDOW` nommée |

---

## Points clés de cette leçon

- Un **cadre de fenêtre** définit l'ensemble de lignes par rapport à la ligne courante incluses dans le calcul d'une fonction de fenêtre.
- Les trois modes de cadre sont **ROWS** (lignes physiques), **RANGE** (plages de valeurs logiques) et **GROUPS** (groupes pairs de valeurs égales).
- Le cadre par défaut avec `ORDER BY` est `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` — connaître ce défaut évite des bugs subtils avec les valeurs égales.
- Utilisez **`ROWS`** pour les fenêtres glissantes de largeur fixe ; utilisez **`RANGE`** quand les valeurs égales doivent être agrégées ensemble.
- Mots-clés de limite : `UNBOUNDED PRECEDING`, `n PRECEDING`, `CURRENT ROW`, `n FOLLOWING`, `UNBOUNDED FOLLOWING`.
- La clause **`WINDOW`** permet de nommer et réutiliser une définition de cadre, gardant les requêtes complexes lisibles.
- Les cadres de fenêtre n'affectent pas `PARTITION BY` — ils ne réduisent le cadre que *à l'intérieur* d'une partition.

Dans la prochaine leçon, nous explorerons les fonctions de décalage `LAG`, `LEAD`, `FIRST_VALUE` et `LAST_VALUE`, qui permettent de comparer la valeur d'une ligne avec des valeurs d'autres lignes sans auto-jointures.
