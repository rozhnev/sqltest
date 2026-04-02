Cette leçon présente la commande `INSERT INTO`, utilisée pour ajouter de nouveaux enregistrements dans une table SQL. Vous apprendrez la syntaxe pour insérer des données dans toutes les colonnes ou dans des colonnes spécifiques, l'insertion de plusieurs lignes et l'importance de respecter les types de données. À la fin, vous saurez remplir vos tables de façon précise et efficace.

# Leçon 8.1 : La commande INSERT INTO

Jusqu'à présent, nous nous sommes concentrés sur la récupération de données à l'aide de la commande `SELECT`. Nous allons maintenant explorer le **langage de manipulation de données (DML)**, en commençant par l'ajout de nouvelles données dans vos tables avec la commande `INSERT INTO`.

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

**Points clés de cette leçon :**

*   La commande `INSERT INTO` permet d'ajouter de nouvelles lignes dans une table.
*   Il est recommandé de lister explicitement les noms de colonnes pour plus de fiabilité et de lisibilité.
*   Les valeurs de type texte ou date doivent être entourées de guillemets simples.
*   Vous pouvez insérer plusieurs lignes à la fois pour améliorer les performances et réduire le code.

Dans la prochaine leçon, nous apprendrons à **créer des tables** et à définir leur structure.
