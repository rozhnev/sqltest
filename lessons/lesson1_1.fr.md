---
title: "Qu'est-ce qu'une base de données ? Introduction aux BDD et SGBD"
description: "Une base de données est un ensemble organisé de données géré par un SGBD. Découvrez les types de BDD, les fonctions d'un SGBD et pourquoi SQL est le langage universel des données."
keywords: ["qu'est-ce qu'une base de données", "SGBD", "système de gestion de bases de données", "base de données relationnelle", "SQL débutant", "types de bases de données"]
---

_Leçon 1.1 · Temps de lecture : ~8 min_

Une **base de données** est un ensemble organisé de données structurées, stockées électroniquement et gérées par un logiciel appelé **SGBD (Système de Gestion de Bases de Données)**. Dans cette leçon, vous apprendrez ce qu'est une base de données, comment fonctionne un SGBD, quels types de bases de données existent et pourquoi SQL reste le langage universel pour travailler avec les données.

# Introduction aux bases de données : qu'est-ce qu'une BDD et un SGBD ?

Les applications modernes — des boutiques en ligne aux tableaux de bord analytiques — s'appuient toutes sur des bases de données pour stocker et traiter les données. Comprendre le fonctionnement des bases de données et des SGBD est le point de départ indispensable pour apprendre SQL et travailler avec des données dans des projets réels.

<img src="/images/lessons/lesson1_1-dbms.jpg" alt="Schéma montrant des utilisateurs et des applications accédant aux données via un SGBD qui gère la couche de stockage physique" width="100%">

## Qu'est-ce qu'une base de données ?

Au cœur du sujet, une **base de données** est une collection organisée d'informations structurées, stockées électroniquement dans un système informatique. Imaginez-la comme un classeur numérique sophistiqué — au lieu de documents papier éparpillés, une base de données offre un moyen structuré de stocker, gérer et récupérer l'information efficacement.

**Caractéristiques clés d'une base de données :**

* **Organisée :** les données sont structurées d'une manière spécifique, ce qui facilite leur recherche et leur gestion — souvent sous forme de tables avec lignes et colonnes.
* **Persistante :** les données restent enregistrées même lorsque l'application est fermée ou l'ordinateur éteint.
* **Partagée :** plusieurs utilisateurs et applications peuvent accéder simultanément à la même base de données.
* **Gérée :** un SGBD est le logiciel qui permet de définir, créer, maintenir et accéder aux bases de données. Exemples : MariaDB, PostgreSQL, MySQL, SQLite, Oracle, Microsoft SQL Server.

## Pourquoi les bases de données sont-elles importantes dans le développement moderne ?

Les bases de données constituent l'épine dorsale d'innombrables applications et systèmes que nous utilisons au quotidien. Raisons principales :

* **Stockage des données :** stockage fiable et efficace de grands volumes d'informations.
* **Récupération des données :** recherche rapide d'enregistrements spécifiques selon des critères définis.
* **Gestion des données :** outils pour organiser, mettre à jour et maintenir l'intégrité des données.
* **Partage des données :** accès contrôlé pour plusieurs utilisateurs et applications.
* **Analyse des données :** les données structurées sont le fondement des rapports, de l'analytique et de la business intelligence.
* **Développement d'applications :** des réseaux sociaux au e-commerce — toute application moderne stocke ses données dans une base de données.

## Types de bases de données : aperçu rapide

Ce cours se concentre sur les **bases de données relationnelles**, mais il est utile de savoir en quoi elles diffèrent des autres types :

* **Bases relationnelles (BDR) :** stockent les données en tables reliées par des clés. Exemples : <a href="https://mariadb.org/" target="_blank">MariaDB</a>, <a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a>, <a href="https://mysql.com/" target="_blank">MySQL</a>, <a href="https://www.sqlite.org/" target="_blank">SQLite</a>. C'est le type sur lequel porte ce cours.
* **Bases NoSQL :** catégorie large qui ne suit pas le modèle relationnel. Utilisées pour les données non structurées et la scalabilité distribuée. Exemples : MongoDB, Cassandra, Redis.
* **Bases en mémoire :** stockent les données en RAM pour une latence minimale. Utilisées pour le cache et les scénarios à fort débit. Exemples : Redis, Memcached.

## Qu'est-ce qu'un SGBD (Système de Gestion de Bases de Données) ?

Un **SGBD** est un logiciel qui agit comme intermédiaire entre les utilisateurs (ou les applications) et la base de données. Il fournit un moyen systématique et contrôlé de créer, lire, mettre à jour et supprimer des données, tout en garantissant sécurité, cohérence et performance. En anglais, l'acronyme utilisé est DBMS (Database Management System).

**Fonctions principales d'un SGBD :**

* **Définition des données :** créer des tables, spécifier les types de données, définir des contraintes et des relations.
* **Manipulation des données :** insérer, mettre à jour, supprimer et interroger les données — généralement via SQL.
* **Gestion du stockage :** gérer le stockage physique sur disque, y compris l'indexation, la mise en cache et l'optimisation.
* **Gestion des transactions :** garantir qu'une série d'opérations réussit entièrement ou est entièrement annulée. Régie par les propriétés **ACID** : Atomicité, Cohérence, Isolation, Durabilité.
* **Contrôle de la concurrence :** gérer les accès simultanés de plusieurs utilisateurs, en évitant les conflits et la corruption des données.
* **Contrôle d'accès et sécurité :** authentification et autorisation — qui peut se connecter et quelles opérations sont autorisées.
* **Sauvegarde et récupération :** outils pour sauvegarder les données et restaurer la base après une panne.
* **Intégrité des données :** contraintes qui maintiennent l'exactitude et la validité des données — unicité, intégrité référentielle, etc.

SGBD bien connus : **MariaDB**, **PostgreSQL**, **MySQL**, **SQLite**, **Oracle Database**, **Microsoft SQL Server**.

---

## Outils GUI pour SGBD — Et leur différence avec le SGBD

Un **outil GUI (Graphical User Interface, interface graphique) pour SGBD** est une application distincte (bureau ou web) qui fournit une interface visuelle pour interagir avec un SGBD. Le SGBD est le moteur qui stocke et traite les données ; l'outil GUI est simplement un **client** qui se connecte au SGBD et envoie des commandes en votre nom.

**Outils GUI populaires pour les bases de données :**

| Outil | Compatible avec |
|-------|----------------|
| **DBeaver** | MariaDB, PostgreSQL, MySQL, SQLite, et bien d'autres |
| **TablePlus** | MariaDB, PostgreSQL, MySQL, SQLite, et d'autres |
| **pgAdmin** | PostgreSQL |
| **MySQL Workbench** | MySQL / MariaDB |
| **DataGrip** | La plupart des grands SGBD |
| **HeidiSQL** | MariaDB, MySQL, PostgreSQL |
| **DB Browser for SQLite** | SQLite |

**Différences clés entre un SGBD et un outil GUI :**

| Aspect | SGBD | Outil GUI |
|--------|------|-----------|
| **Rôle** | Moteur de BDD — stocke, gère et traite les données | Application cliente — se connecte au SGBD pour afficher et éditer |
| **Obligatoire ?** | Oui — impossible de stocker ou d'interroger sans lui | Non — outil optionnel |
| **S'exécute où ?** | Sur un serveur (ou localement pour SQLite) | Sur la machine du développeur ou de l'administrateur |
| **Interface** | Ligne de commande / API | Fenêtres visuelles, éditeur de requêtes, navigateur de tables |
| **Capacités** | Contrôle total sur le stockage, les transactions, la sécurité | Sous-ensemble des fonctionnalités du SGBD, présenté visuellement |

En résumé, le **SGBD est le moteur** et l'**outil GUI est le tableau de bord**. Tout au long de ce cours, nous interagirons avec les bases de données directement en **SQL** — le langage compris par tout SGBD — quelle que soit l'outil GUI que vous utilisez.

---

## Bases relationnelles : notre focus

Dans ce cours, nous approfondirons les **bases de données relationnelles** et le **SQL (Structured Query Language)** utilisé pour interagir avec elles. Le modèle relationnel, avec sa structure claire et ses puissantes capacités de requêtage, reste un pilier de la gestion et de l'analyse des données.

---

**Points clés de cette leçon :**

* Une **base de données** est une collection organisée et persistante de données structurées.
* Les bases de données sont essentielles pour stocker, gérer, récupérer et partager des informations.
* Un **SGBD** est le moteur logiciel qui stocke, gère et contrôle l'accès à une base de données — définition des données, manipulation, gestion des transactions, sécurité, et plus encore.
* Un **outil GUI pour SGBD** est une application cliente optionnelle avec une interface visuelle — distincte du SGBD lui-même.
* Ce cours se concentre sur les **bases relationnelles (BDR)** et **SQL**.

---

## Questions fréquentes

### Quelle est la différence entre une base de données et un SGBD ?
Une **base de données** représente les données elles-mêmes — tables et enregistrements. Un **SGBD** est le logiciel (par ex. PostgreSQL, MariaDB) qui stocke, gère et donne accès à ces données. Sans SGBD, une base de données est inaccessible.

### Qu'est-ce que SQL et pourquoi l'apprendre ?
**SQL (Structured Query Language)** est le langage standard pour créer, interroger, mettre à jour et supprimer des données dans les bases relationnelles. SQL est utilisé dans plus de 90 % des systèmes commerciaux et analytiques — c'est l'une des compétences les plus demandées en développement et en analyse de données.

### Quelle base de données un débutant devrait-il apprendre en premier ?
Pour les débutants, **SQLite** (aucune installation, basé sur un fichier) ou **PostgreSQL** (gratuit, puissant, utilisé en production) sont d'excellents points de départ. Les deux sont bien documentés et largement utilisés dans des projets réels.

## Questions d'entretien

### Comment définiriez-vous une base de données lors d'un entretien technique ?
Une **base de données** est une collection organisée et persistante de données structurées, gérée par un **SGBD**. Elle permet à plusieurs utilisateurs et applications de stocker, récupérer et manipuler des données de manière fiable, avec des garanties de cohérence et d'intégrité.

### Quelles sont les fonctions principales d'un SGBD ?
Un **SGBD** assure : la définition des données (schéma, tables, contraintes), la manipulation des données (CRUD via SQL), la gestion des transactions (propriétés ACID), le contrôle de la concurrence, la sécurité et l'autorisation, la sauvegarde et la récupération, ainsi que l'application des contraintes d'intégrité.

### Que signifie ACID et pourquoi est-ce important ?
**ACID** désigne quatre propriétés transactionnelles : **Atomicité** (une transaction réussit entièrement ou est annulée), **Cohérence** (les données restent valides après chaque transaction), **Isolation** (les transactions concurrentes ne s'interfèrent pas), **Durabilité** (les données validées survivent aux pannes). Ces propriétés sont critiques dans les systèmes bancaires, de facturation ou tout système où l'exactitude des données est obligatoire.

### Quelle est la différence entre une base relationnelle et NoSQL ?
Une **base relationnelle** stocke les données dans des tables structurées avec lignes et colonnes, utilise SQL et impose des transactions ACID. Les **bases NoSQL** (clé-valeur, documentaires, graphes, colonnes larges) sacrifient certaines garanties de cohérence pour plus de flexibilité ou de scalabilité horizontale. Le bon choix dépend de la structure des données et de la charge.

### Quelle est la différence entre un SGBD et un outil comme DBeaver ou pgAdmin ?
Un **SGBD** (ex. PostgreSQL, MariaDB) est le moteur — il stocke, gère et traite les données. Un **outil GUI** (DBeaver, pgAdmin) est une application cliente optionnelle qui se connecte au SGBD et offre une interface visuelle pour écrire des requêtes et parcourir les données. Le SGBD est indispensable ; l'outil GUI ne l'est pas.

→ [Leçon 1.2: Différents types de bases de données](/fr/lesson/getting-started/type-of-databases)

