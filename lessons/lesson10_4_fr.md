---
title: "Introduction aux index SQL : accelerer les requetes en pratique"
description: "Decouvrez ce qu'est un index SQL, son impact sur la vitesse des requetes SELECT et les regles de base pour eviter les erreurs de performance."
keywords: ["index SQL", "introduction aux index", "performance SQL", "acceleration des requetes", "CREATE INDEX", "EXPLAIN SQL"]
teaches: ["Ce qu'est un index et pourquoi il est utile", "Comment les index accelerent la lecture et impactent l'ecriture", "Comment creer des index simples et composes", "Comment verifier l'utilisation d'un index avec EXPLAIN", "Quels patterns de requete peuvent empecher l'utilisation d'un index"]
about: ["SQL", "Index", "Performance de base de donnees", "Optimisation de requetes", "EXPLAIN"]
---

_Lecon 10.4 · Temps de lecture : ~10 min_

Cette lecon introduit les index SQL et leur role dans la performance des requetes. Vous apprendrez ce qu'est un index, comment il aide a trouver des donnees plus vite, et pourquoi il peut parfois ralentir les operations de modification. Nous verrons des exemples de base de creation et de verification d'index sur les tables Sakila. A la fin de la lecon, vous pourrez utiliser les index de facon plus consciente pour accelerer vos requetes.

# Introduction aux index SQL

Dans la lecon precedente, nous avons appris a lire les plans d'execution avec `EXPLAIN` et a trouver les goulots d'etranglement. L'etape suivante est de comprendre le mecanisme principal d'acceleration des recherches : les index.

Les index sont directement lies a la facon dont le SGBD cherche les lignes. Sans index, le serveur parcourt souvent toute la table. Avec un index adapte, il peut acceder aux donnees pertinentes beaucoup plus vite.

<img src="/images/lessons/lesson10_4-sql-indexes.svg" alt="Introduction aux index SQL et impact des index sur la performance des requetes" width="100%">

---

## Qu'est-ce qu'un index

Un index SQL est une structure de donnees supplementaire qui aide le SGBD a trouver plus rapidement des lignes par valeur de colonne.

Une analogie simple est l'index d'un livre. Au lieu de lire toutes les pages, vous allez directement a la section voulue.

Dans les bases relationnelles, les index B-tree sont les plus courants et fonctionnent bien pour :

- recherche exacte (`=`);
- plages (`>`, `<`, `BETWEEN`);
- tri (`ORDER BY`) sur colonnes indexees.

---

## Comment l'index impacte la performance

### Il accelere la lecture (`SELECT`)

Quand une condition `WHERE` utilise une colonne indexee, le SGBD peut trouver les lignes sans scan complet de table.

### Il peut ralentir l'ecriture (`INSERT`, `UPDATE`, `DELETE`)

Chaque index doit etre maintenu a jour. Quand les donnees changent, le SGBD met a jour la table et les index associes.

### Il occupe de l'espace supplementaire

Les index sont stockes a part et consomment du disque. Indexer toutes les colonnes est generalement une mauvaise strategie.

---

## Syntaxe de base

Creation d'un index simple :

```sql
CREATE INDEX idx_customer_last_name
ON customer (last_name);
```

Suppression d'un index (syntaxe selon SGBD) :

```sql
DROP INDEX idx_customer_last_name ON customer;
```

*Remarque : en PostgreSQL, la forme est `DROP INDEX index_name;` sans nom de table.*

---

## Exemple 1 : accelerer un filtre sur une colonne

Supposons qu'on recherche souvent des clients par nom de famille :

```sql
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

Sans index sur `last_name`, le SGBD peut faire un scan complet de `customer`. Apres creation de l'index, le type d'acces devient en general plus efficace.

Verification avec `EXPLAIN` :

```sql
EXPLAIN
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

*Resultat : dans le plan d'execution, vous devriez voir l'utilisation d'un index (`key`/`possible_keys` en MySQL ou `Index Scan` en PostgreSQL).* 

---

## Exemple 2 : index compose

Si des requetes filtrent souvent sur deux champs ensemble, un index compose est utile.

```sql
CREATE INDEX idx_payment_customer_date
ON payment (customer_id, payment_date);
```

Une requete qui correspond bien a cet index :

```sql
SELECT
   payment_id,
   customer_id,
   amount,
   payment_date
FROM payment
WHERE customer_id = 15
  AND payment_date >= '2005-07-01'
ORDER BY payment_date;
```

*Remarque : l'ordre des colonnes dans un index compose est important. Dans beaucoup de cas, mettez d'abord le champ le plus filtre.*

---

## Quand un index peut ne pas etre utilise

Meme si l'index existe, l'optimiseur peut l'ignorer. Raisons frequentes :

- fonction sur la colonne indexee dans `WHERE` (`YEAR(payment_date)`);
- recherche avec `%` en debut (`LIKE '%abc'`);
- faible selectivite de la colonne;
- ordre de colonnes peu adapte dans un index compose.

Exemple d'une condition qui bloque souvent l'index :

```sql
SELECT
   payment_id,
   payment_date
FROM payment
WHERE YEAR(payment_date) = 2005;
```

Version plus favorable aux index :

```sql
SELECT
   payment_id,
   payment_date
FROM payment
WHERE payment_date >= '2005-01-01'
  AND payment_date < '2006-01-01';
```

---

## Recommandations pratiques

- Ajoutez des index pour des requetes frequentes reelles, pas "au cas ou".
- Commencez par les colonnes de `WHERE`, `JOIN` et `ORDER BY`.
- Apres ajout d'un index, comparez les plans avec `EXPLAIN`.
- Gardez un equilibre : trop d'index penalise les ecritures.

---

**Points cles de cette lecon :**

- Un index est une structure qui accelere la recherche de lignes.
- Les index accelerent souvent `SELECT`, mais peuvent ralentir `INSERT`, `UPDATE` et `DELETE`.
- Index simple et index compose repondent a des besoins de filtrage differents.
- L'ordre des colonnes est critique dans un index compose.
- `EXPLAIN` permet de verifier si le SGBD utilise l'index cree.

## Questions d'entretien

### Qu'est-ce qu'un index SQL et pourquoi est-il utile ?
Un index est une structure de donnees supplementaire qui accelere la recherche de lignes par valeur de colonne. Il est utile car il reduit le temps de lecture et le volume de donnees scannees.

### Pourquoi un index peut accelerer `SELECT` mais ralentir `INSERT` ?
En lecture, l'index permet de localiser plus vite les lignes. En ecriture, le SGBD doit mettre a jour la table et les structures d'index, ce qui ajoute du travail.

### Comment verifier qu'un index est reellement utilise ?
Executez `EXPLAIN` sur la requete et analysez le plan : type d'acces, index choisi et estimation du nombre de lignes.

Dans la prochaine lecon, nous verrons la gestion des erreurs et les techniques de debug SQL au quotidien.

→ [Sommaire du cours](course.md)
