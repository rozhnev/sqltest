---
title: "Comment fonctionnent les index B-tree en SQL : structure, recherche et plages"
description: "Comprenez comment les index B-tree sont structurés en SQL, pourquoi ils accélèrent la recherche à une complexité logarithmique et comment les utiliser dans des requêtes pratiques."
keywords: ["index B-tree", "comment fonctionnent les index SQL", "index SQL", "recherche par index", "recherche de plage SQL", "performance de base de données"]
teaches: ["Comment les niveaux des index B-tree sont organisés", "Pourquoi la recherche par index s'exécute rapidement", "Comment B-tree aide pour l'égalité, les plages et le tri", "Comment lire l'utilisation de B-tree dans EXPLAIN", "Quelles conditions empêchent B-tree de fonctionner efficacement"]
about: ["SQL", "B-tree", "Index", "Optimisation des requêtes", "Performance de base de données"]
---

_Leçon 10.5 · Temps de lecture : ~11 min_

Cette leçon explique en détail comment les index B-tree fonctionnent en SQL au niveau physique et logique. Vous apprendrez de quels nœuds est composée la structure, comment la base de données traverse l'arbre et pourquoi cette approche accélère le filtrage et le tri. Nous examinerons des exemples pratiques sur les tables Sakila et renforcerons les règles d'utilisation clés. À la fin de la leçon, vous comprendrez mieux quand un index B-tree accélère réellement les requêtes.

# Comment fonctionnent les index B-tree

Dans la leçon précédente, vous avez appris comment créer des index. Comprendre maintenant comment un index est organisé en interne et pourquoi il accélère la recherche.

Comprendre B-tree vous aidera à voir quand un index fonctionne vraiment et quand il ne peut pas être utilisé. Cette connaissance sera utile lors de l'optimisation des requêtes lentes.

<img src="/images/lessons/lesson10_5-btree-index.svg" alt="Schéma du fonctionnement des index B-tree en SQL : racine, nœuds internes, feuilles et chemin de recherche" width="100%">

---

## Qu'est-ce qu'un index B-tree

Un index B-tree ressemble à une table des matières dans un livre. Au lieu de lire toutes les pages dans l'ordre, vous ouvrez la table des matières, trouvez le chapitre dont vous avez besoin et allez directement.

Un B-tree a trois niveaux :

- **nœud racine** - le point de départ de la recherche, comme la couverture d'une table des matières ;
- **nœuds intermédiaires** - suggèrent quelle direction prendre ensuite ;
- **nœuds feuilles** - contiennent les valeurs dont vous avez besoin et les liens vers les lignes de la table.

La structure entière est triée, de sorte que la base de données peut rapidement choisir la bonne direction à chaque niveau.

Voici à quoi cela ressemble :

```
                    [ ROOT ]
                   /   |   \
                  /    |    \
            [NODE A] [NODE B] [NODE C]
            / |  \    / | \    / | \
           /  |   \  /  |  \  /  |  \
         [L1][L2][L3][L4][L5][L6][L7][L8]
```

Chaque nœud contient des valeurs qui aident à sélectionner le nœud suivant. Les nœuds feuilles (L1–L8) contiennent les données dont vous avez besoin.

---

## Comment fonctionne la recherche par B-tree

Quand vous cherchez `WHERE last_name = 'SMITH'`, la base de données :

1. commence par le nœud racine ;
2. sélectionne la branche où les noms commençant par 'S' pourraient être ;
3. descend en affinant la recherche à chaque niveau ;
4. trouve le nom dont vous avez besoin dans un nœud feuille.

Grâce à cet algorithme, la recherche est très rapide — même dans une table avec des millions de lignes, vous ne devez vérifier que quelques niveaux.

---

## Quelles opérations B-tree accélère-t-il le mieux

### Égalité (`=`)

B-tree convient bien aux recherches de valeurs exactes.

```sql
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

### Plages (`>`, `<`, `BETWEEN`)

Parce que les clés sont triées, B-tree est efficace pour les conditions de plage.

```sql
SELECT
   payment_id,
   amount,
   payment_date
FROM payment
WHERE payment_date >= '2005-07-01'
  AND payment_date < '2005-08-01';
```

### Tri (`ORDER BY`)

Si l'ordre de tri correspond à l'index, la base de données peut souvent éviter un tri séparé coûteux.

```sql
SELECT
   payment_id,
   customer_id,
   payment_date
FROM payment
WHERE customer_id = 10
ORDER BY payment_date;
```

---

## Exemple d'index B-tree composite

Créons un index pour un modèle de filtrage et de tri courant :

```sql
CREATE INDEX idx_payment_customer_date
ON payment (customer_id, payment_date);
```

Vérifions le plan :

```sql
EXPLAIN
SELECT
   payment_id,
   customer_id,
   payment_date,
   amount
FROM payment
WHERE customer_id = 10
  AND payment_date >= '2005-07-01'
ORDER BY payment_date;
```

*Résultat : généralement la base de données utilise l'index pour filtrer par `customer_id` et la plage `payment_date`, ainsi que pour la lecture ordonnée.*

---

## Règle du préfixe gauche pour les index composites

Si un index est créé comme `(customer_id, payment_date)`, la base de données l'utilise au mieux si la condition filtre **d'abord** par `customer_id`.

**Fonctionne bien :**
```sql
WHERE customer_id = 10
```

**Fonctionne bien :**
```sql
WHERE customer_id = 10 AND payment_date >= '2005-01-01'
```

**Fonctionne mal :**
```sql
WHERE payment_date >= '2005-01-01'
```

Cette règle s'appelle le « préfixe gauche » : l'index fonctionne au mieux quand vous utilisez les conditions de gauche à droite.

---

## Quand un index n'aide pas

Un index n'est pas utilisé si :

- vous appliquez une fonction à une colonne : `WHERE YEAR(payment_date) = 2005` — l'index ne fonctionne pas ;
- vous utilisez un masque au début : `WHERE name LIKE '%SMITH'` — l'index n'aidera pas ;
- la condition est trop générale et retourne beaucoup de lignes — l'index peut être plus lent que la lecture de toute la table.

**Mauvais (la fonction empêche l'utilisation de l'index) :**
```sql
SELECT payment_id, payment_date
FROM payment
WHERE YEAR(payment_date) = 2005;
```

**Bon (l'index peut fonctionner) :**
```sql
SELECT payment_id, payment_date
FROM payment
WHERE payment_date >= '2005-01-01'
  AND payment_date < '2006-01-01';
```

---

## Recommandations pratiques

- Indexez les champs qui apparaissent fréquemment dans `WHERE`, `JOIN`, `ORDER BY`.
- Pour les index composites, mettez la colonne la plus importante pour le filtrage en premier.
- Vérifiez l'utilisation réelle de l'index via `EXPLAIN`.
- Ne créez pas d'index redondants : ils augmentent le coût des écritures.

---

**Points clés de cette leçon :**

- B-tree est une structure équilibrée qui accélère la recherche par clé.
- La force principale de B-tree : égalité, plages et tri par ordre d'index.
- Les index composites suivent la règle du préfixe gauche.
- Une forme de condition inappropriée peut priver une requête des avantages de l'index.
- `EXPLAIN` vous aide à comprendre si B-tree est utilisé dans le plan d'exécution réel.

## Questions d'entretien

### Pourquoi un index B-tree est-il généralement plus rapide qu'un balayage complet ?
Parce que la base de données traverse l'arbre le long des branches et trouve la plage nécessaire en un nombre d'étapes logarithmique, au lieu de scanner toutes les lignes de la table.

### Qu'est-ce que la règle du préfixe gauche pour un index composite ?
Cette règle signifie que l'optimiseur utilise au mieux l'index en commençant par la première colonne de la clé et en procédant dans l'ordre.

### Comment vérifier en pratique qu'un index B-tree est utilisé ?
Vous exécutez `EXPLAIN` et regardez le type d'accès, la clé choisie et le nombre attendu de lignes à chaque étape d'exécution.

Dans la leçon suivante, nous aborderons la gestion des erreurs et les techniques de débogage SQL.
