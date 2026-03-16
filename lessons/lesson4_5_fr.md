# Leçon 4.5 : Agrégation avancée avec `ROLLUP`, `CUBE` et `GROUPING SETS` en SQL

Quand les besoins de reporting augmentent, un simple `GROUP BY` ne suffit souvent plus. Par exemple, vous pouvez avoir besoin d'obtenir en même temps :

- le détail par statut de commande et client ;
- des sous-totaux par statut ;
- des totaux par client ;
- un total global sur tout le jeu de données.

On peut écrire plusieurs requêtes et les combiner avec `UNION ALL`, mais cette approche est plus verbeuse et plus difficile à maintenir. SQL propose des extensions de regroupement pour cela : `ROLLUP`, `CUBE` et `GROUPING SETS`.

Important : dans cette leçon, tous les exemples pratiques utilisent **SQL Server (AdventureWorks)**.

Remarque de syntaxe : `ROLLUP`, `CUBE`, `GROUPING SETS` et `GROUPING()` ci-dessous sont présentés en syntaxe SQL Server. En MySQL, les fonctionnalités sont plus limitées et la syntaxe diffère partiellement (par exemple, on utilise souvent `WITH ROLLUP`, tandis que `CUBE` et `GROUPING SETS` peuvent être indisponibles dans leur forme classique).

Dans cette leçon, nous allons voir :

- les différences entre `ROLLUP`, `CUBE` et `GROUPING SETS` ;
- comment sont générées les lignes de sous-total et total ;
- comment distinguer les lignes de total via `GROUPING()`.

## Pourquoi c'est important

L'agrégation avancée permet de :

- construire des rapports multi-niveaux avec une seule requête ;
- réduire la duplication du SQL ;
- obtenir des résultats cohérents entre détail, sous-totaux et total global.

## Idée de base

Supposons des ventes dans `SalesOrderHeader` avec les dimensions `Status`, `CustomerID` et la métrique `TotalDue`.

Un `GROUP BY` classique ne renvoie qu'un seul niveau de regroupement. Les extensions renvoient plusieurs niveaux en une fois.

## `ROLLUP` : totaux hiérarchiques

`ROLLUP` construit une hiérarchie de droite à gauche dans la liste de colonnes.

### Syntaxe

```sql
GROUP BY ROLLUP (col1, col2, col3)
```

Niveaux générés :

- `(col1, col2, col3)` - détail ;
- `(col1, col2)` - sous-total sur `col3` ;
- `(col1)` - sous-total sur `col2` et `col3` ;
- `()` - total global.

### Exemple : somme des commandes par statut et client

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount
FROM SalesOrderHeader
GROUP BY ROLLUP (Status, CustomerID)
ORDER BY Status, CustomerID;
```

**Résultat :**

- lignes pour chaque paire `Status + CustomerID` ;
- sous-total pour chaque `Status` ;
- total global.

## `CUBE` : toutes les combinaisons de dimensions

`CUBE` calcule des agrégats pour toutes les combinaisons possibles des colonnes listées.

### Syntaxe

```sql
GROUP BY CUBE (col1, col2)
```

Pour deux colonnes, les niveaux sont :

- `(col1, col2)` ;
- `(col1)` ;
- `(col2)` ;
- `()`.

Pour trois colonnes, il y a déjà $2^3 = 8$ combinaisons, donc la taille du résultat peut augmenter rapidement.

### Exemple : somme des commandes par statut et client sur tous les axes

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount
FROM SalesOrderHeader
GROUP BY CUBE (Status, CustomerID)
ORDER BY Status, CustomerID;
```

**Résultat :** en plus du détail et du total global, vous obtenez :

- les totaux par `Status` ;
- les totaux par `CustomerID`.

## `GROUPING SETS` : contrôle précis des niveaux

`GROUPING SETS` permet de définir explicitement uniquement les niveaux souhaités.

### Syntaxe

```sql
GROUP BY GROUPING SETS (
    (col1, col2),
    (col1),
    ()
)
```

### Exemple : seulement les niveaux nécessaires, sans combinaisons inutiles

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount
FROM SalesOrderHeader
GROUP BY GROUPING SETS (
    (Status, CustomerID),
    (Status),
    ()
)
ORDER BY Status, CustomerID;
```

Cette requête est équivalente à plusieurs requêtes `GROUP BY ... UNION ALL ...`, mais plus compacte et généralement mieux optimisée.

## Distinguer les lignes de total avec `GROUPING()`

Dans les lignes de total générées, les dimensions deviennent souvent `NULL`. Le problème est que les données source peuvent aussi contenir de vrais `NULL`.

`GROUPING(column)` permet de faire la différence :

- `0` - valeur normale issue des données ;
- `1` - valeur générée par le niveau d'agrégation.

### Exemple avec indicateurs de niveau

```sql
SELECT
    Status,
    CustomerID,
    SUM(TotalDue) AS total_amount,
    GROUPING(Status) AS g_status,
    GROUPING(CustomerID) AS g_customer
FROM SalesOrderHeader
GROUP BY ROLLUP (Status, CustomerID)
ORDER BY Status, CustomerID;
```

Modèle pratique pour étiqueter les lignes :

```sql
CASE
    WHEN GROUPING(Status) = 1 AND GROUPING(CustomerID) = 1 THEN 'GRAND TOTAL'
    WHEN GROUPING(CustomerID) = 1 THEN 'STATUS SUBTOTAL'
    ELSE 'DETAIL'
END AS row_type
```

## Quand utiliser quoi

- Utilisez `ROLLUP` pour des totaux hiérarchiques (par exemple, année -> mois -> jour).
- Utilisez `CUBE` pour obtenir toutes les vues analytiques par combinaison de dimensions.
- Utilisez `GROUPING SETS` pour contrôler précisément les niveaux retournés.

## Recommandations pratiques

- Vérifiez toujours la taille du résultat : `CUBE` peut augmenter fortement le nombre de lignes.
- Étiquetez les types de lignes (`DETAIL`, `SUBTOTAL`, `GRAND TOTAL`) pour une meilleure lisibilité.
- Ajoutez un `ORDER BY` explicite pour un affichage prévisible des totaux.
- Si vous devez filtrer des agrégats, combinez avec `HAVING`.

## Exemple pour MySQL

Voici un exemple MySQL sur la table `payment` avec sous-totaux via `WITH ROLLUP` :

```sql
SELECT
    staff_id,
    customer_id,
    SUM(amount) AS total_amount
FROM
    payment
GROUP BY
    staff_id, customer_id WITH ROLLUP
ORDER BY
    GROUPING(staff_id),
    staff_id,
    GROUPING(customer_id),
    customer_id;
```

Dans cette requête :

- le détail est renvoyé par paire `staff_id + customer_id` ;
- `WITH ROLLUP` ajoute un sous-total par `staff_id` et un total global ;
- `ORDER BY GROUPING(...)` affiche les lignes dans un ordre pratique : détails, sous-totaux, puis total global.

Points importants en MySQL :

- `WITH ROLLUP` fournit des totaux hiérarchiques, mais n'est pas un équivalent complet de `CUBE`/`GROUPING SETS`.
- Pour des combinaisons plus complexes, il faut souvent plusieurs requêtes avec `UNION ALL`.
- Si votre version de MySQL ne prend pas en charge `GROUPING()`, le tri et l'étiquetage des totaux se font généralement via des tests sur `NULL`.

## Applications pratiques

1. **Rapport des montants de commandes par statut et client avec totaux :**
   `ROLLUP (Status, CustomerID)` donne le détail, les sous-totaux par statut et le total global.

2. **Analyse multidimensionnelle des ventes :**
   `CUBE (Status, CustomerID)` donne toutes les combinaisons de vues par statut et client.

3. **Rapport personnalisé sur les montants de commandes :**
   `GROUPING SETS` permet de garder uniquement les niveaux utiles : détail + sous-total de service + total global.

## Points clés de cette leçon

- `ROLLUP`, `CUBE` et `GROUPING SETS` étendent `GROUP BY`.
- `ROLLUP` crée des totaux hiérarchiques, `CUBE` crée toutes les combinaisons, `GROUPING SETS` crée uniquement les niveaux explicitement listés.
- `GROUPING()` est essentiel pour interpréter correctement les lignes de total générées.
- Ces outils permettent de construire des rapports analytiques flexibles sur les montants de commandes en une seule requête.

En maîtrisant ces constructions, vous pourrez concevoir des rapports SQL plus puissants sans longues chaînes de `UNION ALL`.
