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

* **Bases relationnelles (SGBDR) :** Organisent les données en tables (lignes/colonnes) et définissent des relations via des clés. Exemples : <a href="https://mariadb.org/" target="_blank">MariaDB</a>, <a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a>, <a href="https://mysql.com/" target="_blank">MySQL</a>,  <a href="https://www.sqlite.org/" target="_blank">SQLite</a>. C'est notre principal sujet.
* **Bases NoSQL :** Catégorie large qui n'adhère pas au modèle relationnel classique, utilisée pour des données semi-structurées ou non structurées et pour l'évolutivité. Exemples : MongoDB, Cassandra, Redis.
* **Bases en mémoire :** Stockent les données principalement en RAM pour un accès très rapide, souvent pour le cache ou des applications à très faible latence. Exemples : Redis, Memcached.

## Bases relationnelles : notre focus

Dans ce cours, nous approfondirons les **bases relationnelles** et le **SQL (Structured Query Language)** utilisé pour interagir avec elles. Le modèle relationnel, avec sa structure claire et ses puissantes capacités de requêtage, reste un pilier de la gestion et de l'analyse des données.

Dans la leçon suivante, nous explorerons les concepts fondamentaux des bases relationnelles : tables, colonnes, lignes, et le rôle crucial des clés.

**Points clés de cette leçon :**

* Une base de données est une collection organisée et persistante de données structurées.
* Les bases de données sont essentielles pour stocker, gérer, récupérer et partager des informations.
* Ce cours se concentre principalement sur les bases relationnelles (SGBDR).
* Les SGBD sont des logiciels utilisés pour interagir avec les bases.

Bienvenue à bord ! Poursuivons notre voyage dans le monde du SQL.