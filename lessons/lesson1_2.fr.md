# Leçon 1.2 : Différents types de bases de données

Dans la leçon précédente, nous avons introduit l'idée générale d'une base de données et d'un SGBD. En pratique, cependant, toutes les bases de données ne sont pas construites de la même manière. Différents types de bases de données sont optimisés pour différents types de données, modèles de requêtes, exigences de scalabilité et besoins de cohérence.

Dans cette leçon, nous allons examiner les types de bases de données les plus courants, leurs différences clés, leurs cas d'usage typiques et des exemples concrets. Nous porterons également une attention particulière aux **bases de données relationnelles**, car elles resteront le principal focus de ce cours.

## Pourquoi existe-t-il différents types de bases de données ?

Un seul modèle de base de données n'est pas parfait pour toutes les applications.

Par exemple :

* Un système bancaire a besoin d'une forte cohérence et de transactions fiables.
* Un système de cache a besoin de recherches par clé extrêmement rapides.
* Un réseau social peut avoir besoin d'un stockage documentaire flexible et d'une analyse des relations de type graphe.
* Une plateforme analytique peut avoir besoin d'analyser efficacement des milliards de valeurs pour le reporting.

Parce que différents systèmes résolvent différents problèmes, plusieurs modèles de bases de données ont émergé au fil du temps.

## Principaux types de bases de données en un coup d'oeil

Voici une comparaison rapide avant d'examiner chaque type plus en détail :

| Type | Modèle de données | Forces | Cas d'usage courants | Exemples |
|------|-------------------|--------|----------------------|----------|
| **Relationnelle** | Tables avec lignes et colonnes | Cohérence forte, SQL, jointures, données structurées | Banque, ERP, CRM, e-commerce, reporting | PostgreSQL, MySQL, MariaDB, SQLite, Oracle |
| **Clé-valeur** | Clé associée à une valeur | Recherches très rapides, scalabilité simple | Cache, sessions, feature flags, paniers d'achat | Redis, Amazon DynamoDB, Riak |
| **Documentaire** | Documents de type JSON | Schéma flexible, données imbriquées | Gestion de contenu, profils utilisateurs, catalogues, applications web | MongoDB, Couchbase, Firestore |
| **À colonnes larges** | Lignes avec colonnes flexibles regroupées en familles | Haut débit d'écriture, scalabilité horizontale | Journalisation d'événements, IoT, charges distribuées à grande échelle | Apache Cassandra, HBase, ScyllaDB |
| **Graphe** | Noeuds et arêtes | Requêtes centrées sur les relations | Réseaux sociaux, détection de fraude, moteurs de recommandation | Neo4j, Amazon Neptune, ArangoDB |
| **Séries temporelles** | Enregistrements horodatés | Ingestion et agrégation efficaces dans le temps | Supervision, métriques, capteurs, données financières | InfluxDB, TimescaleDB, OpenTSDB |
| **Colonnaire analytique** | Données stockées par colonne plutôt que par ligne | Analyses et agrégations rapides | BI, tableaux de bord, entreposage de données, OLAP | ClickHouse, DuckDB, Amazon Redshift, BigQuery |
| **En mémoire** | Données stockées principalement en RAM | Latence extrêmement faible | Cache, classements, compteurs en temps réel | Redis, Memcached, SAP HANA |

## Bases de données relationnelles

Les bases de données relationnelles stockent les données dans des **tables** composées de **lignes** et de **colonnes**. Les tables peuvent être liées entre elles par des **relations**, généralement à l'aide de clés primaires et de clés étrangères.

Ce modèle est particulièrement adapté lorsque les données sont bien structurées et que l'exactitude, la cohérence et les requêtes complexes sont importantes.

### Propriétés fondamentales des bases de données relationnelles

**1. Schéma structuré**

Les bases de données relationnelles exigent généralement un schéma clairement défini. Avant de stocker les données, on définit les tables, les colonnes, les types de données, les contraintes et les relations.

Cela rend la structure prévisible et plus facile à valider.

**2. Relations entre les tables**

L'une des grandes forces des systèmes relationnels est la capacité à modéliser explicitement les relations.

Par exemple :

* Une table `customers` peut être liée à une table `orders`.
* Une table `orders` peut être liée à une table `order_items`.

Cela rend les bases relationnelles particulièrement adaptées aux systèmes métiers où les entités sont interconnectées.

**3. Prise en charge de SQL**

Les bases de données relationnelles sont généralement interrogées avec **SQL (Structured Query Language)**. SQL fournit une manière standard de filtrer, joindre, agréger, trier et modifier des données structurées.

**4. Transactions ACID**

Les bases de données relationnelles sont bien connues pour prendre en charge les propriétés **ACID** :

* **Atomicité :** Une transaction réussit entièrement ou échoue entièrement.
* **Cohérence :** Les données doivent rester valides selon les règles définies.
* **Isolation :** Les transactions concurrentes ne doivent pas interférer incorrectement les unes avec les autres.
* **Durabilité :** Une fois validées, les données restent stockées même après une panne.

Ces propriétés sont essentielles dans des systèmes comme la banque, la facturation, les réservations et la gestion des stocks.

**5. Contraintes d'intégrité des données**

Les bases de données relationnelles peuvent appliquer directement des règles au niveau de la base de données, par exemple :

* clés primaires
* clés étrangères
* contraintes d'unicité
* contraintes `NOT NULL`
* contraintes `CHECK`

Ces fonctionnalités aident à empêcher les données invalides ou incohérentes.

**6. Jointures puissantes et reporting**

Les bases de données relationnelles excellent lorsqu'il faut combiner des informations provenant de plusieurs tables. C'est l'une des raisons pour lesquelles elles restent centrales pour le reporting, l'analytique, la finance, les opérations et de nombreux systèmes transactionnels.

**7. Normalisation et réduction de la redondance**

La conception relationnelle utilise souvent la **normalisation**, c'est-à-dire l'organisation des données dans des tables liées afin de réduire la duplication et d'améliorer la cohérence.

Par exemple, les informations d'un client peuvent être stockées une seule fois dans une table `customers` au lieu d'être répétées dans chaque enregistrement de commande.

### Cas d'usage courants des bases de données relationnelles

Les bases de données relationnelles sont généralement le meilleur choix lorsque :

* les données sont structurées et clairement définies
* les relations entre entités sont importantes
* les transactions doivent être fiables
* la cohérence est plus importante que la flexibilité du schéma
* l'application a besoin de requêtes complexes et de reporting

### Exemples de bases de données relationnelles

* **PostgreSQL :** Base de données relationnelle open source puissante, avec un bon respect des standards et des fonctionnalités avancées.
* **MySQL :** Base de données relationnelle populaire, très utilisée dans les applications web.
* **MariaDB :** Fork communautaire de MySQL.
* **SQLite :** Base de données relationnelle légère intégrée, stockée dans un seul fichier.
* **Oracle Database :** Base de données relationnelle de niveau entreprise.
* **Microsoft SQL Server :** Base de données relationnelle largement utilisée dans les environnements d'entreprise.

## Bases de données clé-valeur

Les bases de données clé-valeur stockent les données sous la forme d'une paire simple : une **clé** et la **valeur** qui lui est associée.

La clé agit comme un identifiant unique, et la base récupère la valeur directement à partir de cette clé. Ce modèle est très simple et très rapide.

### Différences clés

* L'accès aux données repose généralement sur une seule clé plutôt que sur des jointures complexes.
* La base de données ne comprend souvent pas la structure interne de la valeur.
* Elle est optimisée pour des lectures et écritures extrêmement rapides.

### Cas d'usage typiques

* mise en cache de résultats de requêtes
* stockage des sessions utilisateur
* paniers d'achat
* feature flags
* limitation de débit
* classements et compteurs

### Exemples

* **Redis**
* **Amazon DynamoDB**
* **Riak**

## Bases de données documentaires

Les bases de données documentaires stockent les données sous forme de **documents**, généralement dans un format proche de JSON. Chaque document peut contenir des champs, des tableaux et des objets imbriqués.

Contrairement aux bases de données relationnelles, tous les documents n'ont pas besoin d'avoir exactement la même structure.

### Différences clés

* Le schéma est flexible ou semi-flexible.
* Les données liées peuvent souvent être stockées ensemble dans un même document.
* Elles sont pratiques pour les applications dont la structure évolue fréquemment.

### Cas d'usage typiques

* systèmes de gestion de contenu
* catalogues produits
* profils utilisateurs
* applications mobiles et web
* prototypage de systèmes avec exigences changeantes

### Exemples

* **MongoDB**
* **Couchbase**
* **Google Firestore**

## Bases de données à colonnes larges

Les bases de données à colonnes larges, parfois appelées **bases de données en familles de colonnes**, stockent les données en lignes, mais chaque ligne peut contenir un très grand nombre de colonnes flexibles. Elles sont conçues pour être distribuées sur de nombreux serveurs et pour offrir un haut débit d'écriture.

### Différences clés

* Le schéma est plus flexible que dans les bases de données relationnelles.
* Elles sont optimisées pour le stockage distribué à grande échelle.
* Elles gèrent bien les volumes massifs de données et les charges d'écriture importantes.
* Elles ne prennent généralement pas en charge les jointures relationnelles de la même manière que les bases SQL.

### Cas d'usage typiques

* journalisation d'événements
* télémétrie IoT
* systèmes de messagerie
* applications à forte écriture
* systèmes distribués géographiquement

### Exemples

* **Apache Cassandra**
* **Apache HBase**
* **ScyllaDB**

## Bases de données colonnaires analytiques

Une base de données **colonnaire** stocke ensemble sur disque les valeurs d'une même colonne au lieu de stocker une ligne complète. Cela est différent d'une base de données à colonnes larges.

Le stockage colonnaire est particulièrement efficace pour les requêtes analytiques qui lisent quelques colonnes dans un très grand jeu de données.

### Différences clés

* Optimisées pour analyser et agréger de grands volumes de données.
* Très efficaces pour le reporting et l'analytique.
* Généralement moins adaptées aux charges transactionnelles lourdes impliquant de nombreuses petites mises à jour de lignes.

### Cas d'usage typiques

* business intelligence
* tableaux de bord
* entreposage de données
* reporting analytique
* analyse de journaux à grande échelle

### Exemples

* **ClickHouse**
* **DuckDB**
* **Amazon Redshift**
* **Google BigQuery**

## Bases de données graphe

Les bases de données graphe sont conçues pour les données où les relations constituent la partie la plus importante du modèle. Elles stockent des **noeuds** (entités) et des **arêtes** (relations).

### Différences clés

* Le parcours des relations est rapide et naturel.
* Elles sont idéales lorsqu'il faut interroger des chemins, des réseaux et des données fortement connectées.
* Elles sont souvent mieux adaptées que les bases relationnelles pour les requêtes sur des relations à plusieurs sauts.

### Cas d'usage typiques

* réseaux sociaux
* détection de fraude
* systèmes de recommandation
* topologie réseau
* graphes de connaissances

### Exemples

* **Neo4j**
* **Amazon Neptune**
* **ArangoDB**

## Bases de données de séries temporelles

Les bases de données de séries temporelles sont spécialisées pour les points de données associés au temps. Elles sont optimisées pour des taux d'ingestion élevés, des politiques de rétention, la compression et l'agrégation basée sur le temps.

### Différences clés

* Chaque enregistrement est associé à un horodatage.
* Les requêtes se concentrent souvent sur des intervalles comme la dernière heure, le dernier jour ou le dernier mois.
* Elles permettent des agrégations efficaces sur des fenêtres temporelles.

### Cas d'usage typiques

* supervision de serveurs
* métriques applicatives
* données de capteurs
* données de marché boursier
* mesures industrielles

### Exemples

* **InfluxDB**
* **TimescaleDB**
* **OpenTSDB**

## Bases de données en mémoire

Les bases de données en mémoire stockent la plupart ou la totalité des données en RAM plutôt que sur disque. Cela les rend extrêmement rapides, même si la mémoire coûte plus cher que le stockage sur disque.

Certaines bases en mémoire sont utilisées uniquement comme caches temporaires, tandis que d'autres peuvent également persister les données sur disque.

### Cas d'usage typiques

* cache
* stockage de sessions
* compteurs en temps réel
* classements de jeux
* systèmes à très faible latence

### Exemples

* **Redis**
* **Memcached**
* **SAP HANA**

## Choisir le bon type de base de données

Lorsqu'on choisit une base de données, il faut se poser des questions comme :

* Les données sont-elles très structurées ou flexibles ?
* Ai-je besoin de transactions ACID fortes ?
* Vais-je exécuter des jointures complexes ?
* La recherche rapide par clé est-elle la priorité absolue ?
* La charge est-elle transactionnelle ou analytique ?
* Le système devra-t-il évoluer sur de nombreux serveurs ?
* Les relations entre entités sont-elles centrales dans l'application ?

Dans de nombreux systèmes réels, les organisations utilisent plus d'un type de base de données. Par exemple :

* une base de données relationnelle pour les données métier principales
* Redis pour le cache
* une base de données documentaire pour le contenu flexible
* un entrepôt colonnaire pour l'analytique

On appelle souvent cela la **persistance polyglotte**.

## Résumé des différences clés

Les principales différences entre les types de bases de données portent généralement sur :

* le **modèle de données** — tables, documents, paires clé-valeur, graphes ou enregistrements horodatés
* la **flexibilité du schéma** — structure fixe ou flexible
* le **style de requête** — SQL, recherche par clé, requêtes documentaires, parcours de graphes, analyse par fenêtres temporelles
* le **modèle de cohérence** — fortes garanties transactionnelles ou compromis orientés scalabilité
* le **profil de performance** — optimisé pour les transactions, l'analytique, les relations ou l'accès ultra-rapide

## Points clés de cette leçon

* Différents types de bases de données existent parce que différentes applications ont des besoins techniques et métiers différents.
* Les **bases de données relationnelles** sont surtout connues pour leurs schémas structurés, SQL, relations, contraintes d'intégrité et transactions ACID.
* Les **bases clé-valeur** sont excellentes pour les recherches rapides et le cache.
* Les **bases documentaires** sont utiles lorsque la structure des données est flexible ou évolue fréquemment.
* Les **bases à colonnes larges** sont conçues pour les charges distribuées, massives et à forte écriture.
* Les **bases colonnaires analytiques** sont optimisées pour le reporting et l'analytique à grande échelle.
* Les **bases graphe** sont idéales pour les données riches en relations.
* Les **bases de séries temporelles** sont spécialisées dans les métriques et événements liés au temps.
* De nombreux systèmes modernes utilisent plusieurs types de bases de données ensemble.

Dans la prochaine leçon, nous approfondirons la structure interne des **bases de données relationnelles**, notamment les tables, lignes, colonnes, clés et contraintes d'intégrité.