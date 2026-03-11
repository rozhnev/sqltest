# Leçon 1.1 : Introduction aux bases de données

Bienvenue dans le monde passionnant des bases de données ! Dans cette première leçon, nous poserons les bases en expliquant ce qu'est une base de données, pourquoi elle est essentielle dans notre monde axé sur les données, et les concepts fondamentaux que nous aborderons tout au long de ce cours.

## Qu'est-ce qu'une base de données ?

Au cœur, une base de données est une collection organisée d'informations structurées, ou de données, généralement stockées électroniquement dans un système informatique. Pensez-y comme à un classeur numérique sophistiqué. Plutôt que des documents papier éparpillés, une base de données offre un moyen structuré de stocker, gérer et récupérer l'information de façon efficace.

**Caractéristiques clés d'une base de données :**

* **Organisée :** Les données sont structurées d'une manière spécifique, ce qui facilite leur recherche et leur gestion. Cette structure repose souvent sur des tables avec lignes et colonnes.
* **Persistante :** Les données stockées dans une base de données sont en général persistantes, c'est-à-dire qu'elles restent enregistrées même lorsque l'application qui les utilise est fermée ou que l'ordinateur est éteint.
* **Partagée :** Plusieurs utilisateurs et applications peuvent souvent accéder et interagir avec la même base de données simultanément.
* **Gérée :** Les systèmes de gestion de bases de données (SGBD) sont des applications logicielles qui permettent de définir, créer, maintenir et accéder aux bases de données. Exemples : MariaDB, PostgreSQL, MySQL, SQLite, Oracle, Microsoft SQL Server.

## Pourquoi les bases de données sont-elles importantes ?

Les bases de données sont la colonne vertébrale de nombreuses applications et systèmes que nous utilisons quotidiennement. Voici quelques raisons de leur importance :

* **Stockage des données :** Elles offrent un moyen fiable et efficace de stocker de grands volumes de données.
* **Récupération des données :** Elles permettent d'extraire rapidement des informations précises selon des critères définis.
* **Gestion des données :** Les SGBD fournissent des outils pour organiser, mettre à jour et maintenir l'intégrité des données.
* **Partage des données :** Elles autorisent l'accès et le partage des données entre utilisateurs et applications de manière contrôlée.
* **Analyse des données :** Les données structurées en bases sont essentielles pour effectuer des analyses, générer des rapports et obtenir des insights.
* **Développement d'applications :** La plupart des applications modernes s'appuient sur des bases de données pour stocker et gérer leurs données, des réseaux sociaux aux sites e-commerce.

## Types de bases de données (aperçu)

Bien que ce cours se focalise principalement sur les **bases de données relationnelles**, il est utile de connaître d'autres types :

* **Bases relationnelles (BDR) :** Organisent les données en tables (lignes/colonnes) et définissent des relations via des clés. Exemples : <a href="https://mariadb.org/" target="_blank">MariaDB</a>, <a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a>, <a href="https://mysql.com/" target="_blank">MySQL</a>,  <a href="https://www.sqlite.org/" target="_blank">SQLite</a>. C'est notre principal sujet.
* **Bases NoSQL :** Catégorie large qui n'adhère pas au modèle relationnel classique, utilisée pour des données semi-structurées ou non structurées et pour l'évolutivité. Exemples : MongoDB, Cassandra, Redis.
* **Bases en mémoire :** Stockent les données principalement en RAM pour un accès très rapide, souvent pour le cache ou des applications à très faible latence. Exemples : Redis, Memcached.

## Qu'est-ce qu'un SGBD ?

Un **Système de Gestion de Bases de Données (SGBD)** est un logiciel qui agit comme intermédiaire entre les utilisateurs (ou les applications) et la base de données elle-même. Il fournit un moyen systématique et contrôlé de créer, lire, mettre à jour et supprimer des données, tout en assurant la sécurité, la cohérence et l'efficacité.

**Fonctions principales d'un SGBD :**

* **Définition des données :** Permet de définir la structure (schéma) de la base de données — créer des tables, spécifier les types de données, définir des contraintes et établir des relations.
* **Manipulation des données :** Fournit des mécanismes pour insérer, mettre à jour, supprimer et interroger les données (généralement via SQL).
* **Gestion du stockage :** Gère la façon dont les données sont physiquement stockées sur disque, notamment l'indexation, la mise en cache et l'optimisation du stockage pour un accès rapide.
* **Gestion des transactions :** Garantit qu'une série d'opérations réussit entièrement ou échoue entièrement, maintenant la base de données dans un état cohérent. Ceci est régi par les propriétés **ACID** : Atomicité, Cohérence, Isolation et Durabilité.
* **Contrôle de la concurrence :** Gère l'accès simultané de plusieurs utilisateurs ou applications, évitant les conflits et la corruption des données lorsque plusieurs personnes modifient les données en même temps.
* **Contrôle d'accès et sécurité :** Applique l'authentification et l'autorisation — contrôle qui peut se connecter à la base de données et quelles opérations ils sont autorisés à effectuer.
* **Sauvegarde et récupération :** Fournit des outils et mécanismes pour sauvegarder les données et restaurer la base de données dans un état cohérent après une panne.
* **Intégrité des données :** Applique des règles (contraintes) qui maintiennent l'exactitude et la validité des données, par exemple en garantissant l'unicité d'une valeur ou qu'une référence à une autre table existe réellement (intégrité référentielle).

Les SGBD bien connus incluent **MariaDB**, **PostgreSQL**, **MySQL**, **SQLite**, **Oracle Database** et **Microsoft SQL Server**.

## Outils GUI pour SGBD — Et leur différence avec le SGBD

Un **outil GUI (Interface Graphique Utilisateur) pour SGBD** est une application de bureau ou web distincte qui fournit une interface visuelle et conviviale pour interagir avec un SGBD. Alors que le SGBD est le moteur qui stocke et traite réellement les données, un outil GUI est simplement un **client** qui se connecte au SGBD et envoie des commandes en votre nom.

**Exemples d'outils GUI populaires pour SGBD :**

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

| Aspect | SGBD | Outil GUI pour SGBD |
|--------|------|---------------------|
| **Rôle** | Le moteur de base de données — stocke, gère et traite les données | Une application cliente — se connecte au SGBD pour afficher et éditer les données |
| **Obligatoire ?** | Oui — impossible de stocker ou d'interroger des données sans lui | Non — outil de commodité optionnel ; le SGBD fonctionne sans lui |
| **S'exécute où ?** | Généralement sur un serveur (ou localement pour SQLite) | Sur la machine du développeur ou de l'administrateur |
| **Interface** | Ligne de commande / API programmatique | Fenêtres visuelles, éditeurs de requêtes, navigateurs de tables |
| **Capacités** | Contrôle complet du stockage, des transactions, de la sécurité | Sous-ensemble des fonctionnalités du SGBD, présenté visuellement |

En résumé, le **SGBD est le moteur** et l'**outil GUI est le tableau de bord**. On peut conduire sans tableau de bord, mais le tableau de bord facilite grandement la compréhension de ce qui se passe et le contrôle. Tout au long de ce cours, nous interagirons principalement avec les bases de données en utilisant directement le **SQL** — le langage compris par tout SGBD — quelle que soit l'outil GUI que vous pourriez choisir d'utiliser.

## Bases relationnelles : notre focus

Dans ce cours, nous approfondirons les **bases relationnelles** et le **SQL (Structured Query Language)** utilisé pour interagir avec elles. Le modèle relationnel, avec sa structure claire et ses puissantes capacités de requêtage, reste un pilier de la gestion et de l'analyse des données.

Dans la leçon suivante, nous explorerons les concepts fondamentaux des bases relationnelles : tables, colonnes, lignes, et le rôle crucial des clés.

**Points clés de cette leçon :**

* Une base de données est une collection organisée et persistante de données structurées.
* Les bases de données sont essentielles pour stocker, gérer, récupérer et partager des informations.
* Un **SGBD** est le moteur logiciel qui stocke, gère et contrôle l'accès à une base de données — assurant la définition des données, la manipulation, la gestion des transactions, la sécurité, et plus encore.
* Un **outil GUI pour SGBD** est une application cliente optionnelle qui fournit une interface visuelle vers un SGBD — elle est distincte du SGBD lui-même.
* Ce cours se concentre principalement sur les bases relationnelles (BDR) et le SQL.

Bienvenue à bord ! Poursuivons notre voyage dans le monde du SQL.