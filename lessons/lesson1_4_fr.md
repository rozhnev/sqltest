---
title: "Types de données SQL expliqués : INTEGER, VARCHAR, DATE et plus"
description: "Les types de données SQL définissent les valeurs qu'une colonne peut stocker. Découvrez les types numériques, texte, date/heure et les bonnes pratiques pour bien choisir."
keywords: ["types de données SQL", "INTEGER VARCHAR DECIMAL", "types date SQL", "CHAR vs VARCHAR", "choisir type de données SQL", "types de colonnes SQL"]
teaches: ["Quels sont les types numériques SQL et quand utiliser INTEGER, DECIMAL et FLOAT", "La différence entre CHAR, VARCHAR et TEXT", "Ce que stockent DATE, TIME et TIMESTAMP", "Quand utiliser BOOLEAN, BLOB et JSON", "Comment choisir le bon type de données pour une colonne"]
about: ["Types de données SQL", "INTEGER", "VARCHAR", "DECIMAL", "DATE", "TIMESTAMP", "BOOLEAN"]
---

_Leçon 1.4 · Temps de lecture : ~8 min_

Les types de données définissent les valeurs qu'une colonne peut contenir dans une base relationnelle. Dans cette leçon, vous allez apprendre les types SQL les plus courants, comprendre quand utiliser chacun d'eux, et voir comment un bon choix améliore la qualité des données, le stockage et les performances des requêtes.

# Types de données SQL expliqués : INTEGER, VARCHAR, DATE et plus

Dans la leçon précédente, nous avons vu les tables, les clés, les contraintes et ACID. Nous passons maintenant à une décision de conception essentielle: choisir le bon type de données pour chaque colonne.

<img src="/images/lessons/lesson1_3-datatypes.jpg" alt="Comparaison des types SQL numériques, texte et date/heure pour concevoir les colonnes d'une table" width="100%">

Avant d'entrer dans les sous-types, voici les grandes familles de types SQL:

* **Types numériques**: `TINYINT`, `INT`, `BIGINT`, `DECIMAL`, `FLOAT`
* **Types texte**: `CHAR`, `VARCHAR`, `TEXT`
* **Types date/heure**: `DATE`, `TIME`, `DATETIME`, `TIMESTAMP`
* **Types spécialisés**: `BOOLEAN`, `BLOB`, `JSON`

## Quels sont les types numériques en SQL ?

Les types numériques stockent des nombres, mais chaque famille répond à un besoin différent:

* entiers pour les valeurs sans décimales,
* décimaux exacts pour la finance,
* flottants pour les calculs approximatifs.

### Famille INTEGER

Les types entiers stockent des valeurs sans partie décimale.

| Type | Taille typique | Plage signée approximative |
| :--- | :------------- | :------------------------- |
| `TINYINT` | 1 octet | -128 à 127 |
| `SMALLINT` | 2 octets | -32 768 à 32 767 |
| `INTEGER` / `INT` | 4 octets | -2 147 483 648 à 2 147 483 647 |
| `BIGINT` | 8 octets | -9 223 372 036 854 775 808 à 9 223 372 036 854 775 807 |

Les bornes exactes varient selon le SGBD et le support signed/unsigned.

### DECIMAL / NUMERIC

`DECIMAL` stocke des valeurs exactes avec une précision fixe.

* `DECIMAL(p, s)`:
  * `p` = nombre total de chiffres,
  * `s` = nombre de chiffres après la virgule.
* Exemple: `DECIMAL(10, 2)` permet des valeurs jusqu'à 99 999 999,99.
* Recommandé pour les prix, factures, taxes et montants financiers.

### FLOAT / REAL / DOUBLE

Les types flottants stockent des valeurs approximatives.

* Utiles pour calculs scientifiques et mesures.
* À éviter pour l'argent, car de petites erreurs d'arrondi peuvent apparaître.
* `DOUBLE` offre généralement plus de précision que `FLOAT`.

## Quels sont les types de texte en SQL ?

Les types texte diffèrent surtout par leur stratégie de longueur et de stockage.

### CHAR

* Chaîne à longueur fixe.
* `CHAR(10)` réserve toujours 10 caractères.
* Si la valeur est plus courte, de nombreux SGBD ajoutent des espaces de remplissage.
* Pratique pour des codes de taille stable (pays, état, etc.).

### VARCHAR

* Chaîne à longueur variable avec limite maximale.
* `VARCHAR(255)` stocke uniquement les caractères réellement saisis.
* Bon choix par défaut pour noms, emails et libellés.

### TEXT

* Texte long à longueur variable.
* Adapté aux descriptions longues, commentaires et contenus éditoriaux.
* Les limites d'indexation peuvent varier selon le SGBD.

## Quels sont les types date et heure ?

Les types temporels doivent être utilisés dès qu'une colonne représente une date, une heure ou un instant d'événement.

### DATE

Stocke uniquement la date (année, mois, jour).

### TIME

Stocke uniquement l'heure (heure, minute, seconde).

### DATETIME / TIMESTAMP

Stocke date et heure ensemble.

Selon le SGBD, `TIMESTAMP` peut être lié au fuseau horaire alors que `DATETIME` reste souvent neutre. Vérifiez ce comportement avant de concevoir des tables d'audit et d'événements.

## Quels autres types de données faut-il connaître ?

La plupart des bases relationnelles proposent aussi des types spécialisés:

* `BOOLEAN`: valeurs vrai/faux.
* `BLOB`: contenu binaire (images, fichiers).
* `JSON`: documents semi-structurés JSON.

## Comment choisir le bon type de données ?

Checklist pratique:

* Prenez le plus petit type qui couvre vos valeurs attendues sans risque.
* Utilisez `DECIMAL` pour les montants financiers, pas `FLOAT`.
* Préférez `VARCHAR` pour le texte variable et `CHAR` pour les formats fixes.
* Utilisez des types temporels dédiés, pas des chaînes de texte pour les dates/heures.
* Vérifiez les spécificités du SGBD: fuseaux horaires, valeurs par défaut, index, support JSON.

Un bon choix de type au départ réduit les migrations futures, les erreurs applicatives et les régressions de performance.

---

**Points clés de cette leçon :**

* Les types de données déterminent les valeurs autorisées et influencent directement la qualité des données.
* Les types numériques répondent à des besoins différents: entiers, valeurs exactes et calculs approximatifs.
* `CHAR`, `VARCHAR` et `TEXT` se choisissent selon la longueur attendue et le comportement de stockage.
* Les colonnes temporelles doivent utiliser `DATE`, `TIME` ou `TIMESTAMP` plutôt que du texte.
* Un bon choix de type dès le départ évite des erreurs, des migrations et des problèmes de performance.

---

## Foire aux questions

### Quelle est la différence entre DECIMAL et FLOAT ?
`DECIMAL` stocke des valeurs exactes et convient aux montants financiers. `FLOAT` stocke des valeurs approximatives et peut introduire des écarts d'arrondi.

### Faut-il utiliser CHAR ou VARCHAR pour les noms et emails ?
Dans la plupart des cas, utilisez `VARCHAR`, car la longueur est variable. `CHAR` est plus adapté aux champs de longueur fixe, comme certains codes.

### NULL est-il un type de données ?
Non. `NULL` représente une valeur absente ou inconnue. C'est un marqueur spécial, pas un type de données.

## Questions d'entretien

### Comment choisir entre SMALLINT, INTEGER et BIGINT ?
Évaluez la plage de valeurs attendue et choisissez le plus petit type qui la couvre sans risque. Cela réduit l'espace utilisé et évite les dépassements.

### Pourquoi DECIMAL est-il recommandé pour les montants d'argent ?
Parce que `DECIMAL` conserve une précision exacte et évite les erreurs d'arrondi des types en virgule flottante.

### Quels problèmes peut causer un mauvais choix de type de données ?
Vous pouvez rencontrer des erreurs de conversion, des tris/filtres incorrects, un stockage inutilement lourd, des requêtes plus lentes et une logique applicative plus fragile.

→ [Leçon 1.5 : Comprendre les valeurs NULL en SQL](/fr/lesson/getting-started/null-values)
