# Leçon 1.5 : Présentation de SQL

## Qu'est-ce que SQL ?
SQL (Structured Query Language - Langage de requête structuré) est un langage utilisé pour gérer et manipuler les données dans les systèmes de gestion de bases de données relationnelles (SGBDR). Il offre un moyen puissant et flexible d'interagir avec les bases de données, permettant aux utilisateurs d'effectuer diverses opérations telles que l'interrogation, l'insertion, la mise à jour et la suppression de données.

SQL a été développé au début des années 1970 par IBM et est devenu depuis la norme de facto pour la gestion des bases de données relationnelles. Il est largement utilisé dans divers secteurs et applications, ce qui en fait une compétence essentielle pour les analystes de données, les développeurs et les administrateurs de bases de données.
SQL est conçu pour être facile à apprendre et à utiliser, avec une syntaxe à la fois lisible par l'homme et par la machine. Il permet aux utilisateurs d'exprimer des requêtes et des opérations complexes de manière simple, ce qui le rend accessible aux utilisateurs techniques et non techniques.

## Principales caractéristiques de SQL
*   **Langage déclaratif :** SQL est un langage déclaratif, ce qui signifie que les utilisateurs spécifient ce qu'ils souhaitent récupérer ou manipuler sans détailler comment le faire. Cette abstraction permet une écriture et une optimisation plus faciles des requêtes.
*   **Opérations basées sur les ensembles :** SQL opère sur des ensembles de données plutôt que sur des enregistrements individuels, ce qui permet un traitement efficace de grands ensembles de données.

## Sous-ensembles de SQL
SQL est divisé en plusieurs sous-ensembles, chacun servant un objectif spécifique :
*   **Data Query Language (DQL - Langage de requête de données) :** Utilisé pour interroger les données des bases de données. La commande principale est SELECT.
*   **Data Definition Language (DDL - Langage de définition de données) :** Utilisé pour définir et gérer les structures de base de données. Les commandes incluent CREATE, ALTER et DROP.
*   **Data Manipulation Language (DML - Langage de manipulation de données) :** Utilisé pour manipuler les données au sein de la base de données. Les commandes incluent INSERT, UPDATE et DELETE.
*   **Data Control Language (DCL - Langage de contrôle de données) :** Utilisé pour contrôler l'accès aux données au sein de la base de données. Les commandes incluent GRANT et REVOKE.
*   **Transaction Control Language (TCL - Langage de contrôle des transactions) :** Utilisé pour gérer les transactions dans la base de données. Les commandes incluent COMMIT, ROLLBACK et SAVEPOINT.

## Objets de SQL
SQL opère sur divers objets au sein d'une base de données, notamment :
*   **Tables :** La structure principale pour stocker les données dans une base de données relationnelle. Les tables sont composées de lignes et de colonnes, où chaque ligne représente un enregistrement et chaque colonne représente un attribut de cet enregistrement.
*   **Vues (Views) :** Tables virtuelles qui permettent de présenter les données d'une ou plusieurs tables dans un format spécifique. Les vues peuvent simplifier les requêtes complexes et améliorer la sécurité en restreignant l'accès à certaines données.
*   **Index :** Structures qui améliorent la vitesse des opérations de récupération de données sur une table de base de données. Des index sont créés sur une ou plusieurs colonnes d'une table pour améliorer les performances des requêtes.
*   **Procédures stockées (Stored Procedures) :** Code SQL prédéfini qui peut être exécuté comme une seule unité. Les procédures stockées peuvent encapsuler une logique complexe et améliorer les performances en réduisant le trafic réseau.
*   **Déclencheurs (Triggers) :** Types spéciaux de procédures stockées qui s'exécutent automatiquement en réponse à certains événements sur une table, tels que des opérations INSERT, UPDATE ou DELETE. Les déclencheurs peuvent appliquer des règles métier et maintenir l'intégrité des données.
*   **Schémas (Schemas) :** Conteneurs logiques pour les objets de base de données, tels que les tables, les vues et les index. Les schémas aident à organiser et à gérer les objets de base de données, offrant un moyen de regrouper les objets connexes.
*   **Contraintes (Constraints) :** Règles appliquées aux colonnes de table pour assurer l'intégrité des données. Les contraintes courantes incluent PRIMARY KEY (Clé primaire), FOREIGN KEY (Clé étrangère), UNIQUE, NOT NULL et CHECK.
*   **Transactions :** Une séquence d'une ou plusieurs opérations SQL traitées comme une seule unité de travail. Les transactions garantissent l'intégrité et la cohérence des données en permettant à plusieurs opérations d'être validées (committed) ou annulées (rolled back) en tant que groupe.
*   **Types de données :** Définissent le type de données pouvant être stockées dans une colonne, comme INTEGER, VARCHAR, DATE et BOOLEAN. Les types de données garantissent que les données stockées dans une table sont cohérentes et valides.

## Conventions de base de SQL
L'unité de SQL est la **requête** (query). Une requête est une demande adressée au SGBDR pour récupérer ou modifier des données.

La structure de base d'une requête SQL se compose des éléments suivants :
*   **Mots-clés (Statements/Statements) :** Mots réservés qui ont une signification spécifique en SQL. Exemples : SELECT, FROM, WHERE et JOIN.
*   **Clauses :** Composants d'une instruction SQL qui spécifient l'action à effectuer. Les clauses courantes incluent SELECT, FROM, WHERE, GROUP BY et ORDER BY.
*   **Expressions :** Combinaisons de valeurs, d'opérateurs et de fonctions qui s'évaluent en une valeur unique. Les expressions peuvent être utilisées dans diverses parties d'une instruction SQL, telles que la liste SELECT ou la clause WHERE.
*   **Identifiants :** Noms utilisés pour désigner les objets de la base de données, tels que les tables, les colonnes et les vues. Les identifiants peuvent être simples (ex : nom_table) ou qualifiés (ex : nom_schema.nom_table).
*   **Commentaires :** Texte non exécutable dans le code SQL qui fournit des explications ou des notes. Les commentaires peuvent être sur une seule ligne (en utilisant --) ou sur plusieurs lignes (en utilisant /* ... */).


## Écrire votre première requête SQL

Une requête SQL de base se compose d'une instruction SELECT, d'une clause FROM et d'une clause WHERE facultative. Par exemple :

```sql
SELECT colonne1, colonne2
FROM nom_table
WHERE condition;
```
