# Leçon 3.5 : Opérateur conditionnel `CASE WHEN ... THEN ... END` en SQL

L'opérateur `CASE` en SQL permet d'ajouter une logique conditionnelle directement dans une requête. Il sert à créer des catégories, afficher des libellés lisibles, filtrer des données selon des règles différentes et définir un tri personnalisé. C'est un outil essentiel quand vous voulez rendre une requête plus intelligente sans déplacer la logique dans le code applicatif.

Dans cette leçon, nous allons voir :

- comment fonctionne `CASE` ;
- comment l'utiliser dans `SELECT` ;
- comment l'appliquer dans `WHERE` ;
- comment créer un tri personnalisé avec `CASE` dans `ORDER BY`.

## Syntaxe de `CASE`

`CASE` existe sous deux formes principales.

### 1) Forme simple (`simple CASE`)

```sql
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END
```

Cette forme compare une seule expression (`expression`) à plusieurs valeurs.

### 2) Forme recherchée (`searched CASE`)

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

Ici, chaque `WHEN` contient une condition complète. Cette forme est plus souple et la plus utilisée.

Points importants :

- les conditions sont évaluées de haut en bas ;
- la première branche `WHEN` qui correspond est utilisée ;
- si aucune condition ne correspond, `ELSE` est appliqué ;
- si `ELSE` est absent, le résultat est `NULL`.

## `CASE` dans `SELECT`

Le cas d'usage le plus fréquent est d'ajouter une colonne calculée avec une catégorie ou un statut.

### Exemple : catégoriser les paiements

```sql
SELECT
    payment_id,
    amount,
    CASE
        WHEN amount < 2 THEN 'Paiement faible'
        WHEN amount BETWEEN 2 AND 6 THEN 'Paiement moyen'
        ELSE 'Paiement élevé'
    END AS payment_level
FROM payment
LIMIT 10;
```

**Ce que fait la requête :**

- elle évalue `amount` pour chaque ligne de `payment` ;
- elle attribue une des trois catégories ;
- elle renvoie la catégorie dans une nouvelle colonne `payment_level`.

### Exemple : statut de location lisible

```sql
SELECT
    rental_id,
    rental_date,
    return_date,
    CASE
        WHEN return_date IS NULL THEN 'Non retourné'
        ELSE 'Retourné'
    END AS rental_status
FROM rental
LIMIT 10;
```

Cette approche est pratique pour les rapports et tableaux de bord, où des valeurs brutes doivent être converties en statuts clairs.

## `CASE` dans `WHERE`

Même si `CASE` est surtout utilisé dans `SELECT`, il peut aussi servir à filtrer. C'est utile lorsque la règle de filtrage dépend d'une autre colonne ou de seuils différents selon le contexte.

### Exemple : seuil de montant différent selon l'employé

```sql
SELECT
    payment_id,
    staff_id,
    amount
FROM payment
WHERE amount >= CASE
    WHEN staff_id = 1 THEN 5
    WHEN staff_id = 2 THEN 3
    ELSE 4
END;
```

**Logique du filtre :**

- pour `staff_id = 1`, on garde les paiements avec `amount >= 5` ;
- pour `staff_id = 2`, on garde les paiements avec `amount >= 3` ;
- pour les autres, le seuil est `amount >= 4`.

### Quand une alternative est préférable

Pour des conditions très simples, une expression avec `OR` est parfois plus lisible. Mais `CASE` dans `WHERE` reste pertinent quand la logique métier est réellement ramifiée et doit rester dans une seule expression.

## `CASE` dans `ORDER BY`

Un besoin fréquent consiste à trier selon une priorité métier, plutôt que selon l'ordre alphabétique ou numérique. `CASE` est parfait pour cela.

### Exemple : ordre personnalisé des classifications de films

```sql
SELECT
    title,
    rating
FROM film
ORDER BY CASE rating
    WHEN 'G' THEN 1
    WHEN 'PG' THEN 2
    WHEN 'PG-13' THEN 3
    WHEN 'R' THEN 4
    WHEN 'NC-17' THEN 5
    ELSE 6
END,
 title;
```

**Résultat :** les films aux classifications les plus « douces » apparaissent d'abord, puis les plus strictes, indépendamment du tri texte standard.

### Exemple : afficher d'abord les locations non retournées

```sql
SELECT
    rental_id,
    rental_date,
    return_date
FROM rental
ORDER BY CASE
    WHEN return_date IS NULL THEN 0
    ELSE 1
END,
 rental_date DESC
LIMIT 20;
```

Ainsi, les enregistrements les plus importants remontent en tête de résultat.

## Utilisation pratique

1. **Segmenter les clients selon leurs dépenses :**
   ```sql
   SELECT
       customer_id,
       SUM(amount) AS total_spent,
       CASE
           WHEN SUM(amount) < 50 THEN 'Basique'
           WHEN SUM(amount) < 100 THEN 'Actif'
           ELSE 'VIP'
       END AS customer_segment
   FROM payment
   GROUP BY customer_id;
   ```

2. **Compter les enregistrements par groupes conditionnels :**
   ```sql
   SELECT
       SUM(CASE WHEN amount < 2 THEN 1 ELSE 0 END) AS low_count,
       SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 ELSE 0 END) AS medium_count,
       SUM(CASE WHEN amount > 6 THEN 1 ELSE 0 END) AS high_count
   FROM payment;
   ```

3. **Définir une priorité personnalisée pour un rapport :**
   ```sql
   SELECT
       title,
       replacement_cost
   FROM film
   ORDER BY CASE
       WHEN replacement_cost >= 25 THEN 1
       WHEN replacement_cost >= 20 THEN 2
       ELSE 3
   END,
   replacement_cost DESC;
   ```

## Points clés de cette leçon

`CASE WHEN ... THEN ... END` est un outil universel de logique conditionnelle en SQL.

Idées essentielles :

- dans `SELECT`, il permet de créer des catégories et des statuts ;
- dans `WHERE`, il gère une logique de filtre ramifiée ;
- dans `ORDER BY`, il donne un contrôle total sur un ordre personnalisé ;
- dans la plupart des cas, ajoutez `ELSE` pour éviter des `NULL` inattendus.

En maîtrisant `CASE`, vos requêtes SQL deviennent plus flexibles, plus lisibles et plus proches de la logique métier.
