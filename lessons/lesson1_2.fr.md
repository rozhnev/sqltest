---
title: "Types de bases de données : relationnelle, NoSQL, clé-valeur et plus"
description: "Découvrez les principaux types de bases de données — relationnelles, clé-valeur, documentaires, graphes, séries temporelles et colonnaires — avec leurs différences et cas d'usage."
keywords: ["types de bases de données", "base de données relationnelle vs NoSQL", "comparaison types BDD", "base de données relationnelle", "types NoSQL", "choisir une base de données"]
---

_Leçon 1.2 · Temps de lecture : ~15 min_

Il existe de nombreux **types de bases de données**, chacun optimisé pour un type de données, un modèle de requête ou des exigences de scalabilité spécifiques. Dans cette leçon, vous découvrirez les principaux modèles de bases de données — relationnelles, clé-valeur, documentaires, à colonnes larges, graphes, séries temporelles et colonnaires — avec leurs différences clés, leurs cas d'usage typiques et des exemples de systèmes réels.

# Types de bases de données : relationnelles, NoSQL et au-delà

Dans la leçon précédente, nous avons introduit l'idée générale d'une base de données et d'un SGBD. En pratique, toutes les bases de données ne sont pas construites de la même manière. Différents types sont optimisés pour différents types de données, modèles de requêtes, exigences de scalabilité et besoins de cohérence.

Nous porterons également une attention particulière aux **bases de données relationnelles**, car elles resteront le principal focus de ce cours.

<img src="/images/lessons/lesson1_2-database-types.svg" alt="Schéma présentant les principaux types de bases de données, dont les bases relationnelles, clé-valeur, documentaires, graphe, séries temporelles, colonnaires, à colonnes larges, en mémoire et de recherche" width="100%">

## Pourquoi Existe-t-il Différents Types de Bases de Données ?

Aucun modèle de base de données n'est parfait pour toutes les applications.

Par exemple :

* Un système bancaire a besoin d'une forte cohérence et de transactions fiables.
* Un système de cache a besoin de recherches par clé extrêmement rapides.
* Un réseau social peut avoir besoin d'un stockage documentaire flexible et d'une analyse des relations de type graphe.
* Une plateforme analytique peut avoir besoin d'analyser efficacement des milliards de valeurs pour le reporting.

Parce que différents systèmes résolvent différents problèmes, plusieurs modèles de bases de données ont émergé au fil du temps.

## Principaux Types de Bases de Données : Tableau Comparatif

Voici une comparaison rapide avant d'examiner chaque type plus en détail :

| Type | Modèle de données | Forces | Cas d'usage courants | Exemples |
|------|-------------------|--------|----------------------|----------|
| **Relationnelle** | Tables avec lignes et colonnes | Cohérence forte, SQL, jointures, données structurées | Banque, ERP, CRM, e-commerce, reporting | PostgreSQL, MySQL, MariaDB, SQLite, Oracle |
| **Clé-valeur** | Clé associée à une valeur | Recherches très rapides, scalabilité simple | Cache, sessions, feature flags, paniers d'achat | Redis, Amazon DynamoDB, Riak |
| **Documentaire** | Documents de type JSON | Schéma flexible, données imbriquées | Gestion de contenu, profils utilisateurs, catalogues | MongoDB, Couchbase, Firestore |
| **À colonnes larges** | Lignes avec colonnes flexibles en familles | Haut débit d'écriture, scalabilité horizontale | Journalisation, IoT, charges distribuées à grande échelle | Apache Cassandra, HBase, ScyllaDB |
| **Graphe** | Nœuds et arêtes | Requêtes centrées sur les relations | Réseaux sociaux, détection de fraude, recommandations | Neo4j, Amazon Neptune, ArangoDB |
| **Séries temporelles** | Enregistrements horodatés | Ingestion et agrégation efficaces dans le temps | Supervision, métriques, capteurs, données financières | InfluxDB, TimescaleDB, OpenTSDB |
| **Colonnaire analytique** | Données stockées par colonne | Analyses et agrégations rapides | BI, tableaux de bord, data warehousing, OLAP | ClickHouse, DuckDB, Amazon Redshift, BigQuery |
| **En mémoire** | Données principalement en RAM | Latence extrêmement faible | Cache, classements, compteurs en temps réel | Redis, Memcached, SAP HANA |

## Bases de Données Relationnelles

Les bases de données relationnelles stockent les données dans des **tables** composées de **lignes** et de **colonnes**. Les tables peuvent être liées entre elles par des **relations**, généralement à l'aide de clés primaires et de clés étrangères.

Ce modèle est particulièrement adapté lorsque les données sont bien structurées et que l'exactitude, la cohérence et les requêtes complexes sont importantes.

### Propriétés Fondamentales des Bases Relationnelles

**1. Schéma structuré** — exige un schéma clairement défini avec tables, colonnes, types de données, contraintes et relations. La structure est prévisible et facile à valider.

**2. Relations entre les tables** — capacité à modéliser explicitement les relations entre entités (ex. `customers` → `orders` → `order_items`). Idéal pour les systèmes métiers.

**3. Prise en charge de SQL** — standard pour filtrer, joindre, agréger, trier et modifier des données structurées.

**4. Transactions ACID** :
* **Atomicité :** une transaction réussit entièrement ou échoue entièrement.
* **Cohérence :** les données restent valides selon les règles définies.
* **Isolation :** les transactions concurrentes ne s'interfèrent pas incorrectement.
* **Durabilité :** les données validées sont conservées même après une panne.

**5. Contraintes d'intégrité** — clés primaires, clés étrangères, unicité, `NOT NULL`, `CHECK` pour prévenir les données invalides.

**6. Jointures puissantes** — idéales pour combiner des données de plusieurs tables en reporting et analytique.

**7. Normalisation** — réduction de la duplication via des tables liées.

### Cas d'Usage Courants

Les bases relationnelles sont le meilleur choix quand les données sont structurées, les relations importantes, les transactions fiables requises et les requêtes complexes nécessaires.

### Exemples

* **PostgreSQL**, **MySQL**, **MariaDB**, **SQLite**, **Oracle Database**, **Microsoft SQL Server**

## Bases de Données Clé-Valeur

Stockent les données comme une paire **clé** + **valeur**. Accès direct par clé — modèle très simple et très rapide.

**Cas d'usage :** cache, sessions, paniers, feature flags, classements.

**Exemples :** **Redis**, **Amazon DynamoDB**, **Riak**

## Bases de Données Documentaires

Stockent les données sous forme de **documents** JSON. Chaque document peut avoir une structure différente.

**Cas d'usage :** gestion de contenu, catalogues produits, profils utilisateurs, applications web et mobiles.

**Exemples :** **MongoDB**, **Couchbase**, **Google Firestore**

## Bases de Données à Colonnes Larges

Stockent les données en lignes avec un ensemble flexible de colonnes. Conçues pour la distribution sur de nombreux serveurs et un haut débit d'écriture.

**Cas d'usage :** journalisation d'événements, IoT, messagerie, systèmes distribués géographiquement.

**Exemples :** **Apache Cassandra**, **Apache HBase**, **ScyllaDB**

## Bases de Données Colonnaires Analytiques

Stockent les valeurs d'une même colonne ensemble sur disque — différent des bases à colonnes larges. Efficaces pour les requêtes analytiques lisant peu de colonnes sur de très grands volumes.

**Cas d'usage :** business intelligence, data warehousing, dashboards, analyses de logs.

**Exemples :** **ClickHouse**, **DuckDB**, **Amazon Redshift**, **Google BigQuery**

## Bases de Données Graphe

Conçues pour les données où les relations sont la partie la plus importante. Stockent des **nœuds** (entités) et des **arêtes** (relations). Parcours des relations rapide et naturel.

**Cas d'usage :** réseaux sociaux, détection de fraude, recommandations, graphes de connaissances.

**Exemples :** **Neo4j**, **Amazon Neptune**, **ArangoDB**

## Bases de Données de Séries Temporelles

Spécialisées pour les données associées au temps, optimisées pour l'ingestion, la rétention et l'agrégation temporelle.

**Cas d'usage :** supervision de serveurs, métriques, données de capteurs, données boursières.

**Exemples :** **InfluxDB**, **TimescaleDB**, **OpenTSDB**

## Bases de Données en Mémoire

Stockent la plupart des données en RAM plutôt que sur disque — extrêmement rapides, mais mémoire plus coûteuse.

**Cas d'usage :** cache, sessions, compteurs en temps réel, classements de jeux.

**Exemples :** **Redis**, **Memcached**, **SAP HANA**

---

## Comment Choisir le Bon Type de Base de Données ?

Questions à se poser :

* Les données sont-elles très structurées ou flexibles ?
* Ai-je besoin de transactions ACID fortes ?
* Vais-je exécuter des jointures complexes ?
* La recherche rapide par clé est-elle la priorité absolue ?
* La charge est-elle transactionnelle ou analytique ?
* Le système devra-t-il évoluer sur de nombreux serveurs ?
* Les relations entre entités sont-elles centrales ?

Dans de nombreux systèmes réels, on utilise plusieurs types de bases de données — c'est la **persistance polyglotte** : relationnelle pour les données métier, Redis pour le cache, documentaire pour le contenu flexible, colonnaire pour l'analytique.

## Résumé : Différences Clés Entre Types de Bases de Données

* **Modèle de données** — tables, documents, clé-valeur, graphes, enregistrements horodatés
* **Flexibilité du schéma** — fixe ou flexible
* **Style de requête** — SQL, clé, documents, graphes, fenêtres temporelles
* **Modèle de cohérence** — ACID fort ou compromis pour la scalabilité
* **Profil de performance** — transactions, analytique, relations ou accès ultra-rapide

---

**Points clés :**

* Différents types de bases de données existent car différentes applications ont des besoins différents.
* Les **bases relationnelles** excellent pour les schémas structurés, SQL, relations, intégrité et ACID.
* Les **bases clé-valeur** sont idéales pour le cache et les recherches rapides.
* Les **bases documentaires** sont utiles pour les données flexibles ou changeantes.
* Les **bases à colonnes larges** sont conçues pour les charges distribuées et massives.
* Les **bases colonnaires analytiques** s'optimisent pour le reporting et l'analytique.
* Les **bases graphe** sont parfaites pour les données riches en relations.
* Les **bases de séries temporelles** spécialisent les métriques et événements liés au temps.
* La **persistance polyglotte** combine plusieurs types selon les besoins.

---

## Questions Fréquentes

### Quelle est la différence entre bases relationnelles et NoSQL ?
Les **bases relationnelles** utilisent un schéma fixe, des transactions ACID et SQL. **NoSQL** est un terme générique pour les modèles clé-valeur, documentaires, à colonnes larges et graphes — ils échangent certaines garanties de cohérence contre flexibilité ou scalabilité. Le bon choix dépend de vos données et de votre charge.

### Quand utiliser une base documentaire plutôt que relationnelle ?
Utilisez une **base documentaire** quand les données ont une structure imbriquée variable et que les jointures entre collections sont rares. Utilisez une **base relationnelle** quand les données sont structurées, les entités interreliées, et que vous avez besoin de transactions fiables et de requêtes multi-tables complexes.

### Une application peut-elle utiliser plusieurs types de bases de données ?
Oui — c'est la **persistance polyglotte**. C'est courant en production : PostgreSQL pour les données transactionnelles, Redis pour le cache, ClickHouse pour l'analytique. Chaque type est utilisé là où il excelle.

→ [Leçon 1.3 : Structure d'une base relationnelle — tables, lignes, colonnes et clés](lesson1_3.fr.md)
