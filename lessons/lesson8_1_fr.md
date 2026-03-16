Cette leçon présente l’instruction `CREATE TABLE`, la commande principale du langage de définition de données (DDL) utilisée pour créer de nouvelles tables dans une base de données. Vous apprendrez la syntaxe de base, comment définir les colonnes et leurs types de données, ainsi que l’utilisation de contraintes importantes telles que `PRIMARY KEY`, `NOT NULL` et `DEFAULT`. À la fin de cette leçon, vous serez capable de créer des tables avec une structure claire et fiable.

# Leçon 8.1 : L’instruction CREATE TABLE

Jusqu’à présent, nous avons principalement travaillé avec des tables déjà existantes et récupéré des données à partir de celles-ci. Mais dans un vrai travail sur une base de données, il ne suffit pas de lire les données : il faut aussi savoir **créer la structure qui va les stocker**. C’est précisément le rôle de l’instruction `CREATE TABLE`.

`CREATE TABLE` appartient au **langage de définition de données (DDL, Data Definition Language)**. Elle permet de décrire la structure d’une table : quelles colonnes elle contiendra, quels types de données seront utilisés, et quelles règles s’appliqueront aux valeurs stockées.

## Syntaxe de base

La forme la plus simple de l’instruction est la suivante :

```sql
CREATE TABLE table_name (
    column1 data_type,
    column2 data_type,
    column3 data_type
);
```

Après le nom de la table, les colonnes sont listées entre parenthèses. Pour chaque colonne, vous devez préciser :

- le nom de la colonne ;
- le type de données ;
- et, si nécessaire, des contraintes comme `NOT NULL`, `PRIMARY KEY`, `DEFAULT` et d’autres.

## Exemple d’une table simple

Créons une table `students` :

```sql
CREATE TABLE students (
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    created_at TIMESTAMP
);
```

Dans cet exemple :

- `student_id` est un entier ;
- `first_name` et `last_name` sont des valeurs textuelles jusqu’à 50 caractères ;
- `birth_date` stocke la date de naissance ;
- `created_at` stocke la date et l’heure de création de l’enregistrement.

Après l’exécution de cette commande, la table sera créée, mais elle restera vide.

---

## Types de données fréquemment utilisés

Lors de la création de tables, il est important de choisir des types de données adaptés. Voici quelques-uns des plus courants :

- `INT` pour les nombres entiers ;
- `VARCHAR(n)` pour les chaînes de longueur variable jusqu’à `n` caractères ;
- `TEXT` pour les textes longs ;
- `DATE` pour les dates ;
- `TIMESTAMP` pour la date et l’heure, souvent utilisé pour enregistrer le moment de création ou de modification d’une ligne ;
- `DECIMAL(p, s)` pour les valeurs numériques exactes, par exemple les montants financiers ;
- `BOOLEAN` pour les valeurs logiques `TRUE` ou `FALSE`.

Le bon choix du type de données permet d’économiser de l’espace, d’améliorer la qualité des données et d’éviter des erreurs.

---

## Contraintes de colonne

Les contraintes définissent les règles appliquées aux données stockées dans une table.

### 1. `PRIMARY KEY`
Une clé primaire identifie de manière unique chaque ligne d’une table.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

La colonne `student_id` ne peut contenir ni doublons ni valeurs `NULL`.

### 2. `NOT NULL`
Cette contrainte impose qu’une colonne contienne toujours une valeur.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
```

Désormais, `first_name` et `last_name` ne peuvent plus être laissés vides.

### 3. `DEFAULT`
Elle permet de définir une valeur par défaut qui sera utilisée si aucune valeur n’est fournie lors de l’insertion.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) DEFAULT 0.00
);
```

Si aucun prix n’est fourni lors de l’ajout d’un produit, la base de données utilisera automatiquement `0.00`.

---

## Exemple d’une table avec plusieurs règles

Voici un exemple plus réaliste d’une table `employees` :

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 0.00
);
```

Voici ce que cela signifie :

- `employee_id` est l’identifiant unique de l’employé ;
- `first_name` et `last_name` sont obligatoires ;
- `email` doit être unique ;
- `hire_date` est obligatoire ;
- `salary` vaut `0.00` par défaut.

Cette structure reflète déjà mieux les contraintes du monde réel.

---

## Utilisation de `IF NOT EXISTS`

Dans de nombreux systèmes de gestion de bases de données, vous pouvez éviter une erreur si la table existe déjà en utilisant `IF NOT EXISTS` :

```sql
CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
```

C’est pratique lorsque vous relancez des scripts d’apprentissage ou des migrations.

---

## Points auxquels il faut faire attention

Lors de la création de tables, il est utile de garder quelques règles en tête :

- choisissez les types de données de façon réfléchie, au lieu d’utiliser des types trop génériques partout ;
- définissez une `PRIMARY KEY` pour les tables où chaque ligne doit être identifiée de manière unique ;
- utilisez `NOT NULL` pour les champs réellement obligatoires ;
- utilisez `DEFAULT` lorsqu’une colonne possède une valeur naturelle par défaut ;
- essayez de rendre la structure claire et prévisible dès le départ.

Une table bien conçue réduit les erreurs et facilite le travail futur avec `INSERT`, `UPDATE` et `SELECT`.

---

## Exemple pratique

Imaginons que nous voulions créer une table pour stocker des livres :

```sql
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    published_date DATE,
    price DECIMAL(8, 2) DEFAULT 0.00
);
```

Une fois cette table créée, nous pourrons commencer à y ajouter des lignes avec `INSERT INTO`.

---

**Points clés de cette leçon :**

*   L’instruction `CREATE TABLE` est utilisée pour créer de nouvelles tables dans une base de données.
*   Chaque colonne doit avoir un nom et un type de données.
*   Des contraintes comme `PRIMARY KEY`, `NOT NULL`, `UNIQUE` et `DEFAULT` aident à contrôler la qualité des données.
*   Une table bien conçue rend le travail avec les données plus simple et plus fiable.
*   `IF NOT EXISTS` permet d’éviter des erreurs lors de créations répétées de la même table.

Dans la prochaine leçon, nous verrons comment ajouter de nouvelles lignes dans les tables avec l’instruction `INSERT INTO`.
