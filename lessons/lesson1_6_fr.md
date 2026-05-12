---
title: "Qu'est-ce que SQL : langage de requête et structure d'une requête SQL"
description: "SQL est le langage standard des bases relationnelles. Découvrez son organisation, ses sous-ensembles et la structure d'une requête SQL de base."
keywords: ["qu'est-ce que SQL", "présentation SQL", "structure requête SQL", "SELECT FROM WHERE", "sous-ensembles SQL"]
teaches: ["Comprendre le rôle de SQL dans les SGBDR", "Distinguer DQL, DDL, DML, DCL et TCL", "Lire la structure d'une requête SQL de base", "Identifier les principaux objets de base de données"]
about: ["SQL", "Base de données relationnelle", "SGBDR", "SELECT", "DDL", "DML", "Transactions"]
---

_Leçon 1.6 · Temps de lecture : ~8 min_

SQL (Structured Query Language) est le langage principal pour travailler avec des bases de données relationnelles. Dans cette leçon, vous verrez comment SQL est organisé, quels types de tâches il permet de résoudre et à quoi ressemble une première requête simple. À la fin de la leçon, vous pourrez lire des constructions SQL de base avec assurance et comprendre leur rôle.

# Qu'est-ce que SQL : vue d'ensemble du langage et structure des requêtes

Dans la leçon précédente, nous avons étudié les valeurs NULL et la gestion des données manquantes. Il est maintenant utile de passer à une vue d'ensemble : ce qu'est SQL et pourquoi l'essentiel de l'analyse de données en base relationnelle repose sur ce langage.

SQL n'est pas réservé aux développeurs. Il est aussi indispensable aux analystes, aux ingénieurs data et à toute personne qui extrait, vérifie et transforme des données au quotidien.

<img src="/images/lessons/lesson1_5-sql.jpg" alt="Schéma montrant SQL comme langage pour interroger et modifier des données dans une base relationnelle" width="100%">

---

## Qu'est-ce que SQL et pourquoi est-il utile ?

**SQL** (Structured Query Language) est le langage utilisé pour communiquer avec un SGBDR afin de lire, ajouter, modifier et supprimer des données.

SQL a été développé dans les années 1970 chez IBM et est devenu le standard de facto des bases de données relationnelles. Sa syntaxe est suffisamment rigoureuse pour l'exécution machine tout en restant lisible pour l'humain, ce qui le rend pratique dans le travail quotidien sur les données.

En pratique, SQL sert principalement à :

* récupérer des données dans des tables ;
* modifier les données et la structure de la base ;
* gérer les accès et les transactions.

---

## Principales caractéristiques de SQL

* **Langage déclaratif :** vous décrivez le résultat attendu plutôt que l'algorithme étape par étape.
* **Traitement par ensembles :** SQL manipule des ensembles de lignes, pas un enregistrement à la fois.
* **Syntaxe standardisée :** les constructions principales sont proches d'un SGBDR à l'autre.

---

## Sous-ensembles de SQL

SQL est divisé en plusieurs sous-ensembles, chacun servant un objectif spécifique :

* **Data Query Language (DQL - Langage de requête de données) :** utilisé pour interroger les données. La commande principale est SELECT.
* **Data Definition Language (DDL - Langage de définition de données) :** utilisé pour définir et gérer les structures de base. Les commandes incluent CREATE, ALTER et DROP.
* **Data Manipulation Language (DML - Langage de manipulation de données) :** utilisé pour modifier les données. Les commandes incluent INSERT, UPDATE et DELETE.
* **Data Control Language (DCL - Langage de contrôle de données) :** utilisé pour gérer les droits d'accès. Les commandes incluent GRANT et REVOKE.
* **Transaction Control Language (TCL - Langage de contrôle des transactions) :** utilisé pour gérer les transactions. Les commandes incluent COMMIT, ROLLBACK et SAVEPOINT.

---

## Objets principaux en SQL

SQL opère sur divers objets au sein d'une base de données, notamment :

* **Tables :** structure principale de stockage des données. Une table est composée de lignes et de colonnes.
* **Vues :** tables virtuelles présentant les données d'une ou plusieurs tables dans un format spécifique.
* **Index :** structures qui accélèrent la recherche et le filtrage.
* **Procédures stockées :** code SQL prédéfini exécutable comme une seule unité.
* **Déclencheurs :** procédures spéciales exécutées automatiquement lors d'événements comme INSERT, UPDATE ou DELETE.
* **Schémas :** conteneurs logiques pour organiser les objets de base de données.
* **Contraintes :** règles d'intégrité comme PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL et CHECK.
* **Transactions :** groupe d'opérations SQL traité comme une seule unité logique.
* **Types de données :** formats de données autorisés dans une colonne, par exemple INTEGER, VARCHAR, DATE et BOOLEAN.

Comprendre ces objets est essentiel, car les requêtes SQL s'appuient toujours sur eux.

---

## Conventions de base de SQL

L'unité de base de SQL est la **requête**. Une requête est une demande adressée au SGBDR pour lire ou modifier des données.

La structure de base d'une requête SQL se compose des éléments suivants :

* **Instructions :** mots réservés ayant une signification précise en SQL, comme SELECT, FROM, WHERE et JOIN.
* **Clauses :** parties d'une instruction SQL qui précisent l'action à exécuter, par exemple FROM, WHERE, GROUP BY et ORDER BY.
* **Expressions :** combinaisons de valeurs, d'opérateurs et de fonctions qui s'évaluent en une valeur unique.
* **Identifiants :** noms d'objets de base de données (tables, colonnes, vues, schémas).
* **Commentaires :** texte non exécutable servant à expliquer le code SQL.

---

## Écrire votre première requête SQL

Un modèle de requête de base inclut généralement SELECT, FROM et éventuellement WHERE :

```sql
SELECT colonne1,
	   colonne2
FROM nom_table
WHERE condition;
```

*Résultat : la requête renvoie uniquement les lignes de nom_table qui respectent condition et affiche les colonnes colonne1 et colonne2.*

Même ce modèle court est utile : il montre la logique générale de la plupart des requêtes SQL analytiques.

---

**Points clés de cette leçon :**

* SQL est le langage principal des bases de données relationnelles.
* SQL est déclaratif : on décrit le résultat attendu, pas l'algorithme d'exécution.
* SQL comprend plusieurs sous-ensembles : DQL, DDL, DML, DCL et TCL.
* Les requêtes sont construites avec des instructions, des clauses, des expressions et des identifiants.
* Le schéma d'une requête simple est SELECT ... FROM ... WHERE ....

---

## Questions fréquentes

### SQL est-il un langage de programmation ou un langage de requête ?
SQL est généralement considéré comme un langage de requête. Ce n'est pas un langage généraliste, mais c'est le standard pour manipuler des données relationnelles.

### Pourquoi est-il important de connaître les sous-ensembles SQL ?
Ils permettent de comprendre rapidement le rôle d'une commande : lecture de données, modification du schéma, gestion des droits ou contrôle de transaction.

### Peut-on écrire SQL exactement de la même façon dans tous les SGBDR ?
Les constructions de base sont proches, mais des différences existent selon les moteurs (MariaDB, PostgreSQL, SQL Server, etc.).

## Questions d'entretien

### Comment définir SQL en entretien technique ?
**SQL** est le langage standard pour interroger et gérer des données dans des bases relationnelles. Il sert à lire et modifier les données, gérer la structure et contrôler les transactions.

### Quelle est la différence entre DDL et DML ?
**DDL** sert à définir/modifier la structure de la base (tables, index, schémas), tandis que **DML** sert à manipuler les données des tables (INSERT, UPDATE, DELETE).

### Quelles sont les parties d'une requête SQL de base ?
Une requête de base contient généralement **SELECT** (quoi retourner), **FROM** (depuis quelle table) et **WHERE** (quelles lignes filtrer).

Dans la prochaine leçon, nous passerons aux types de commandes SQL et verrons comment les appliquer dans des cas pratiques.
