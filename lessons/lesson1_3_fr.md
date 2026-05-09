---
title: "Concepts des bases relationnelles : tables, clés et ACID"
description: "Découvrez les composants essentiels des bases relationnelles — tables, colonnes, lignes, clés primaires, étrangères et uniques, et propriétés ACID — avec des exemples concrets."
keywords: ["concepts bases relationnelles", "clé primaire", "clé étrangère", "propriétés ACID", "tables base de données", "SQL base relationnelle"]
teaches: ["Ce que sont les tables, colonnes et lignes dans une base relationnelle", "Comment la clé primaire identifie chaque ligne de façon unique", "Comment la clé étrangère relie les tables", "Ce que garantit une clé unique", "Ce que sont les contraintes SQL et comment NOT NULL et CHECK fonctionnent", "Ce qu'assurent les propriétés ACID dans les transactions"]
about: ["Base de données relationnelle", "Clé primaire", "Clé étrangère", "Contrainte SQL", "ACID", "Transaction de base de données", "SQL"]
---

_Leçon 1.3 · Temps de lecture : ~10 min_

Une **base de données relationnelle** organise les données dans des tables liées par des clés. Dans cette leçon, vous apprendrez les composants fondamentaux — tables, colonnes, lignes, clés primaires, étrangères et uniques — et découvrirez comment le modèle ACID garantit la fiabilité des transactions même en cas de panne ou d'accès concurrents.

# Concepts des bases relationnelles : tables, clés et ACID

Dans la leçon précédente, nous avons introduit le concept de base de données et les principaux types de BDD. Maintenant, nous allons approfondir les composants centraux des **bases relationnelles**, essentiels pour comprendre comment les données sont organisées et consultées via SQL.

<img src="/images/lessons/lesson1_2-rdb.jpg" alt="Schéma d'une base relationnelle montrant deux tables liées par une clé primaire et une clé étrangère" width="100%">

## Que sont les tables, colonnes et lignes ?

Les bases relationnelles organisent les données en structures appelées **tables**. Pensez à une table comme à une feuille de calcul :

* **Table :** Une collection de données liées, par exemple les clients, produits ou commandes.
* **Colonne :** Un ensemble vertical de données dans une table. Chaque colonne représente un attribut (ex. CustomerID, FirstName, LastName, Email).
* **Ligne :** Un ensemble horizontal de données dans une table. Chaque ligne représente un enregistrement individuel (un client, une commande, etc.).

**Exemple :**

Visualisons une table "Customers" simple :

| CustomerID | FirstName | LastName | Email |
| :--------: | :-------: | :------: | :---: |
| 1 | John | Doe | john.doe@example.com |
| 2 | Jane | Smith | jane.smith@example.com |
| 3 | David | Lee | david.lee@example.com |

* La structure entière est la **table** "%20Customers%20".
* "CustomerID", "FirstName", "LastName", "Email" sont les **colonnes**.
* Chaque ligne (ex. "1 | John | Doe | ...") est un **enregistrement**.

## Que sont les clés de base de données ? Primaire, étrangère et unique

Les **clés** sont cruciales en relationnel : elles établissent des relations entre tables et font respecter l'intégrité des données. Principaux types :

### Clé primaire (Primary Key)
* Colonne (ou ensemble de colonnes) qui identifie de façon unique chaque ligne.
* Caractéristiques :
  * **Unique**
  * **Non NULL**
* Ex : "CustomerID" est souvent une bonne clé primaire.

### Clé étrangère (Foreign Key)
* Colonne dans une table qui référence la clé primaire d'une autre table.
* Sert à établir des relations entre tables.
* Exemple : si une table "Orders" contient un champ "CustomerID" qui référence "Customers.CustomerID".

### Clé unique (Unique Key)
* Colonne (ou ensemble) qui garantit l'unicité des valeurs dans la table.
* Différence par rapport à la clé primaire : une table peut avoir plusieurs clés uniques.
* Les colonnes uniques peuvent inclure des valeurs NULL selon le SGBD.
* Exemple : la colonne "Email" pourrait être une clé unique.

## Que sont les contraintes SQL ?

Une **contrainte** est une règle appliquée à une colonne ou à une table que le moteur de base de données applique automatiquement. Les clés (primaire, étrangère, unique) sont un type de contrainte. Voici les autres contraintes importantes utilisées au quotidien en SQL :

| Contrainte | Rôle |
| :--------- | :--- |
| `NOT NULL` | La colonne doit toujours avoir une valeur ; NULL est interdit. |
| `UNIQUE` | Toutes les valeurs de la colonne doivent être distinctes. |
| `PRIMARY KEY` | Combine NOT NULL + UNIQUE ; identifie chaque ligne de manière unique. |
| `FOREIGN KEY` | La valeur doit correspondre à une valeur existante dans une autre table. |
| `CHECK` | La valeur doit satisfaire une condition, p. ex. `age >= 0`. |

Par exemple, dans une table `customers` :

* `customer_id` peut jouer le rôle de `PRIMARY KEY`, ce qui identifie chaque client de façon unique.
* `email` peut recevoir une contrainte `UNIQUE`, afin que deux clients ne partagent pas la même adresse.
* `age` peut suivre une règle `CHECK`, par exemple `age >= 0`, pour empêcher les valeurs négatives.

Le moteur de base de données applique automatiquement ces règles et rejette les modifications invalides, ce qui aide à conserver des données cohérentes sans logique supplémentaire côté application.

## Qu'est-ce qu'ACID ? La sécurité des transactions en base relationnelle

Dans les bases relationnelles, une autre notion fondamentale est le modèle **ACID**. ACID définit les propriétés qui rendent les transactions sûres et fiables.

Une **transaction** est un groupe d'opérations traité comme une seule unité de travail. Par exemple, un virement bancaire entre deux comptes implique généralement au moins deux opérations :

1. Débiter le compte A.
2. Créditer le compte B.

Ces deux étapes doivent réussir ensemble, sinon aucune ne doit être appliquée.

**ACID signifie :**

* **Atomicité :** Une transaction est « tout ou rien ». Si une étape échoue, toute la transaction est annulée.
* **Cohérence :** Une transaction doit faire passer la base d'un état valide à un autre en respectant toutes les règles et contraintes définies.
* **Isolation :** Les transactions concurrentes ne doivent pas interférer entre elles d'une façon qui produirait des résultats incorrects.
* **Durabilité :** Une fois validées (commit), les modifications d'une transaction sont permanentes, même en cas de panne ou de coupure électrique.

Ces propriétés sont essentielles dans des systèmes réels comme la banque, l'e-commerce ou la gestion des stocks, où des mises à jour partielles ou incorrectes peuvent avoir de lourdes conséquences.

---

**Points clés de cette leçon :**

* Une base relationnelle stocke les données dans des **tables** composées de colonnes et de lignes.
* Une **clé primaire** identifie chaque ligne de façon unique ; elle doit être unique et non NULL.
* Une **clé étrangère** relie une ligne d'une table à une ligne d'une autre, assurant l'intégrité référentielle.
* Une **clé unique** garantit l'unicité des valeurs dans une colonne ; une table peut en avoir plusieurs.
* Les **contraintes** (`NOT NULL`, `CHECK`) sont appliquées automatiquement par le moteur de base de données.
* Le modèle **ACID** (Atomicité, Cohérence, Isolation, Durabilité) assure la fiabilité des transactions même en cas de panne ou d'accès concurrents.

Dans la leçon suivante, nous découvrirons les types de données de base utilisés dans les bases relationnelles et comment choisir le bon type pour chaque colonne.

---

## Foire aux questions

### Quelle est la différence entre une clé primaire et une clé unique ?
Une **clé primaire** identifie chaque ligne de façon unique et ne peut pas être NULL. Une table ne peut avoir qu'une seule clé primaire. Une **clé unique** garantit aussi l'unicité, mais peut autoriser des valeurs NULL, et une table peut en avoir plusieurs. Utilisez la clé primaire comme identifiant principal de la ligne ; les clés uniques servent à imposer l'unicité sur d'autres colonnes, comme `email`.

### Une clé étrangère peut-elle référencer une clé unique plutôt qu'une clé primaire ?
Oui. Une clé étrangère peut référencer toute colonne (ou ensemble de colonnes) disposant d'une contrainte d'unicité, pas uniquement la clé primaire. Cependant, référencer la clé primaire reste la pratique la plus courante et recommandée.

### Que se passe-t-il si une transaction ACID échoue à mi-parcours ?
**L'atomicité** garantit que toute la transaction est annulée (rollback), laissant la base dans l'état où elle se trouvait avant le début de la transaction. Aucune modification partielle n'est conservée.

## Questions d'entretien

### Comment expliquer une clé primaire lors d'un entretien ?
Une **clé primaire** est une colonne ou une combinaison de colonnes qui identifie de manière unique chaque ligne d'une table. Elle doit être unique, ne peut pas contenir de valeurs NULL, et il ne peut y en avoir qu'une par table. Elle sert de point d'ancrage pour les références de clés étrangères des autres tables.

### Qu'est-ce que l'intégrité référentielle et comment les clés étrangères l'assurent-elles ?
**L'intégrité référentielle** signifie qu'une valeur de clé étrangère dans une table doit toujours correspondre à une valeur de clé primaire existante dans la table référencée, ou être NULL. Le moteur de base de données l'applique automatiquement : toute tentative d'insérer une clé étrangère orpheline ou de supprimer une ligne référencée sera rejetée, sauf si une règle de cascade est définie.

### Que signifie ACID et pourquoi est-ce important ?
**ACID** signifie Atomicité, Cohérence, Isolation et Durabilité. Ces propriétés définissent les garanties qui rendent les transactions fiables. Sans ACID, des écritures concurrentes pourraient corrompre les données, des pannes partielles laisseraient la base dans un état invalide, et des modifications validées pourraient être perdues après un crash. C'est pourquoi les bases relationnelles sont utilisées pour les systèmes financiers, médicaux et autres applications critiques.

→ [Leçon 1.4 : Types de données de base](/fr/lesson/getting-started/basic-data-types)