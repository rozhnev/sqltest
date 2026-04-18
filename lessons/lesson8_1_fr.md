Cette leçon présente la commande `INSERT INTO`, utilisée pour ajouter de nouveaux enregistrements dans une table SQL. Vous apprendrez la syntaxe pour insérer des données dans toutes les colonnes ou dans des colonnes spécifiques, l'insertion de plusieurs lignes et l'importance de respecter les types de données. À la fin, vous saurez remplir vos tables de façon précise et efficace.

# Leçon 8.1 : La commande INSERT INTO

Jusqu'à présent, nous nous sommes concentrés sur la récupération de données à l'aide de la commande `SELECT`. Nous allons maintenant explorer le **langage de manipulation de données (DML)**, en commençant par l'ajout de nouvelles données dans vos tables avec la commande `INSERT INTO`.

<img src="/images/lessons/lesson8_1-insert-into.svg" alt="Lesson illustration" width="100%">

## Syntaxe de base

Il existe deux façons principales d'utiliser la commande `INSERT INTO`.

### 1. Spécifier les colonnes (recommandé)
C'est la méthode la plus sûre et la plus courante. Vous listez explicitement les colonnes à remplir, suivies des valeurs correspondantes.

```sql
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);
```

### 2. Sans spécifier les colonnes
Si vous fournissez des valeurs pour **toutes** les colonnes de la table dans l'ordre exact de leur définition, vous pouvez omettre les noms de colonnes. Cette méthode est moins flexible et peut provoquer des erreurs si la structure de la table change.

```sql
INSERT INTO table_name
VALUES (value1, value2, value3, ...);
```

---

## Règles importantes pour l'insertion de données
*   **Types de données :** Les valeurs doivent correspondre au type de données de chaque colonne (par exemple, impossible d'insérer du texte dans une colonne numérique).
*   **Chaînes et dates :** Comme dans la clause `WHERE`, les valeurs de type texte ou date doivent être entourées de guillemets simples (`'`).
*   **Nombres :** Les valeurs numériques n'ont pas besoin de guillemets.
*   **Valeurs NULL :** Si une colonne accepte `NULL` et que vous ne fournissez pas de valeur, elle sera remplie par `NULL` (ou une valeur par défaut si définie).

---

## Exemples

### Exemple 1 : Ajouter un nouvel acteur
Ajoutons un nouvel acteur dans la table `actor` de la base Sakila.

```sql
INSERT INTO actor (first_name, last_name)
VALUES ('JOHNNY', 'DEPP');
```
*Remarque : Nous n'avons pas spécifié `actor_id` car il est généralement généré automatiquement par la base.*

### Exemple 2 : Insertion dans des colonnes spécifiques
Si une table possède de nombreuses colonnes mais que vous souhaitez n'en remplir que quelques-unes :

```sql
INSERT INTO customer (first_name, last_name, email, store_id, address_id)
VALUES ('ALICE', 'JOHNSON', 'alice.j@example.com', 1, 5);
```

### Exemple 3 : Insertion de plusieurs lignes
La plupart des bases modernes permettent d'insérer plusieurs lignes en une seule commande, en séparant les ensembles de valeurs par des virgules.

```sql
INSERT INTO actor (first_name, last_name)
VALUES 
    ('TOM', 'HANKS'),
    ('MERYL', 'STREEP'),
    ('LEONARDO', 'DICAPRIO');
```

---

## Insérer des données à partir d'une autre requête (`INSERT INTO ... SELECT`)

Parfois, vous n'avez pas besoin de saisir les données manuellement, mais plutôt de les transférer d'une table à une autre (par exemple, lors de l'archivage ou de la génération de rapports). Pour cela, on utilise une combinaison de `INSERT INTO` et `SELECT`.

### Syntaxe

```sql
INSERT INTO target_table (column1, column2, column3)
SELECT source_column1, source_column2, source_column3
FROM source_table
WHERE condition;
```

### Flexibilité dans la formation des données

Une caractéristique importante de cette commande est que dans le bloc `SELECT`, vous pouvez combiner différents types de valeurs :

1.  **Valeurs sélectionnées** : directement à partir de la table source (`source_column1`).
2.  **Valeurs calculées** : le résultat de formules ou de fonctions (par exemple, `amount * 0.1`).
3.  **Valeurs constantes** : des données fixes qui ne sont pas dans la table source (par exemple, la date d'insertion ou un statut sous forme de chaîne).

### Exemple : Création d'une archive de clients inactifs

Supposons que nous ayons une table `customer_archive` et que nous souhaitions y transférer des données de la table principale `customer`, en ajoutant la date d'archivage et une note de statut :

```sql
INSERT INTO customer_archive (customer_id, full_name, archived_at, status_note)
SELECT 
    customer_id, 
    CONCAT(first_name, ' ', last_name), -- Valeur calculée (Nom Complet)
    CURRENT_DATE,                       -- Constante (date actuelle)
    'Auto-archived'                     -- Constante (étiquette texte)
FROM customer
WHERE active = 0;
```

*Remarque : Le nombre et l'ordre des colonnes dans `INSERT INTO` doivent correspondre strictement au nombre et à l'ordre des colonnes renvoyées dans le `SELECT`.*

---

## Travailler avec NULL et les valeurs par défaut

Lors de l'insertion d'une ligne, il n'est pas toujours nécessaire de fournir une valeur pour chaque colonne. La base de données gère les valeurs manquantes de deux façons : via `NULL` et via les valeurs par défaut des colonnes.

### Insérer NULL explicitement

Si une colonne accepte `NULL`, vous pouvez passer le mot-clé `NULL` directement comme valeur :

```sql
INSERT INTO customer (first_name, last_name, email, store_id, address_id)
VALUES ('BOB', 'SMITH', NULL, 1, 5);
```

Ici, la colonne `email` sera stockée avec la valeur `NULL`, ce qui signifie « aucune valeur connue ».

### S'appuyer sur les valeurs par défaut

Si une colonne possède une valeur `DEFAULT` définie dans le schéma de la table, vous pouvez l'omettre entièrement de la liste des colonnes. La base de données la remplira automatiquement :

```sql
INSERT INTO actor (first_name, last_name)
VALUES ('CATE', 'BLANCHETT');
```

Les colonnes comme `actor_id` (auto-incrément) et `last_update` (horodatage par défaut) sont remplies par la base de données sans aucune saisie explicite.

### Utiliser DEFAULT explicitement

Vous pouvez également utiliser le mot-clé `DEFAULT` pour déclencher la valeur par défaut d'une colonne tout en la maintenant dans la liste :

```sql
INSERT INTO actor (actor_id, first_name, last_name, last_update)
VALUES (DEFAULT, 'CATE', 'BLANCHETT', DEFAULT);
```

C'est utile lorsque votre instruction liste toutes les colonnes mais que vous souhaitez que la base de données en gère certaines.

---

**Points clés de cette leçon :**

*   La commande `INSERT INTO` permet d'ajouter de nouvelles lignes dans une table.
*   La commande `INSERT INTO ... SELECT` permet de copier des données d'une table à une autre.
*   Dans le bloc `SELECT`, vous pouvez combiner des données réelles de la table, des champs calculés et des constantes.
*   Il est recommandé de lister explicitement les noms de colonnes pour plus de fiabilité et de lisibilité.
*   Les valeurs de type texte ou date doivent être entourées de guillemets simples.
*   Vous pouvez insérer plusieurs lignes à la fois pour améliorer les performances.
*   Les colonnes acceptant `NULL` ou ayant une valeur `DEFAULT` peuvent être omises ou transmises explicitement à l'aide des mots-clés `NULL` et `DEFAULT`.

Dans la prochaine leçon, nous verrons comment **modifier des enregistrements existants** avec la commande `UPDATE`.
