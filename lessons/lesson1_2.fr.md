# Leçon 1.2 : Concepts des bases relationnelles

Dans la leçon précédente, nous avons introduit le concept de base de données. Maintenant, nous allons approfondir les composants centraux des **bases relationnelles**, essentiels pour comprendre comment les données sont organisées et consultées via SQL.

<img src="/images/lessons/lesson1_2-rdb.jpg" alt="DBMS overview" width="100%">

## Tables, colonnes et lignes

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

## Les clés : garantir l'intégrité des données

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

## ACID : des transactions fiables en base de données

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

## Importance de ces concepts

* Ils définissent la structure et l'organisation des données.
* Ils facilitent l'interrogation et la récupération efficace des informations.
* Les clés assurent l'intégrité et relient les données entre elles.
* Les propriétés ACID garantissent des modifications de données correctes et fiables, même en cas de pannes ou d'accès concurrents.

Dans les leçons suivantes, nous exploiterons ces notions pour apprendre à utiliser SQL avec des bases relationnelles.