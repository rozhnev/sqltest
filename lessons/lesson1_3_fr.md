# Leçon 1.3 : Types de données de base en SQL

En SQL, les types de données spécifient le genre de données qui peuvent être stockées dans une colonne. Choisir le bon type de données est crucial pour l'intégrité des données, l'efficacité du stockage et les performances des requêtes. Cette leçon couvre les types de données courants et leurs sous-types utilisés dans les bases de données SQL, ainsi que leurs plages de valeurs.

## Types de données numériques

Les types de données numériques sont utilisés pour stocker des valeurs numériques.

### INTEGER (Entier)
*   Stocke des nombres entiers.
*   Sous-types :
    *   `INT` ou `INTEGER` : Généralement un entier de 4 octets.
    *   `SMALLINT` : Généralement un entier de 2 octets.
    *   `BIGINT` : Généralement un entier de 8 octets.
    *   `TINYINT` : Généralement un entier de 1 octet.
*   Plages (approximatives, peuvent varier selon le système de base de données) :
    *   `TINYINT` : -128 à 127 (signé) ou 0 à 255 (non signé)
    *   `SMALLINT` : -32 768 à 32 767
    *   `INT` : -2 147 483 648 à 2 147 483 647
    *   `BIGINT` : -9 223 372 036 854 775 808 à 9 223 372 036 854 775 807

### DECIMAL / NUMERIC
*   Stocke des valeurs numériques exactes avec une précision et une échelle spécifiées.
*   Précision : Le nombre total de chiffres.
*   Échelle : Le nombre de chiffres à droite de la virgule décimale.
*   Exemple : `DECIMAL(10, 2)` peut stocker des nombres avec 10 chiffres au total, dont 2 après la virgule.
*   Plage : Dépend de la précision et de l'échelle.

### FLOAT / REAL (Flottant / Réel)
*   Stocke des valeurs numériques approximatives avec une précision à virgule flottante.
*   Sous-types :
    *   `FLOAT` : Nombre à virgule flottante en simple précision.
    *   `DOUBLE` / `DOUBLE PRECISION` : Nombre à virgule flottante en double précision.
    *   `REAL` : Un synonyme de `FLOAT` dans certaines bases de données.
*   Plage : Varie selon l'implémentation spécifique, mais couvre généralement une large gamme de valeurs avec une précision limitée.

## Types de données de caractères / chaînes de caractères

Les types de données de caractères sont utilisés pour stocker du texte.

### CHAR
*   Stocke des chaînes de caractères de longueur fixe.
*   Vous spécifiez la longueur lors de la définition de la colonne.
*   Exemple : `CHAR(10)` stocke des chaînes d'exactement 10 caractères.
*   Si la chaîne stockée est plus courte que la longueur spécifiée, elle est complétée par des espaces.

### VARCHAR
*   Stocke des chaînes de caractères de longueur variable.
*   Vous spécifiez la longueur maximale lors de la définition de la colonne.
*   Exemple : `VARCHAR(255)` stocke des chaînes allant jusqu'à 255 caractères.
*   N'utilise que l'espace nécessaire pour stocker la chaîne réelle.

### TEXT
*   Stocke de grandes chaînes de caractères de longueur variable.
*   Souvent utilisé pour stocker des documents, des articles ou d'autres données textuelles volumineuses.
*   La longueur maximale est généralement beaucoup plus grande que celle de `VARCHAR`.

## Types de données de date et d'heure

Les types de données de date et d'heure sont utilisés pour stocker des valeurs temporelles.

### DATE
*   Stocke une date (année, mois, jour).
*   Format : Varie selon le système de base de données (ex : AAAA-MM-JJ, MM/JJ/AAAA).

### TIME (Heure)
*   Stocke une heure (heure, minute, seconde).
*   Format : Varie selon le système de base de données (ex : HH:MM:SS).

### DATETIME / TIMESTAMP
*   Stocke à la fois la date et l'heure.
*   Format : Varie selon le système de base de données (ex : AAAA-MM-JJ HH:MM:SS).
*   `TIMESTAMP` a souvent un comportement spécial lié aux fuseaux horaires et aux mises à jour automatiques.

## Type de données booléen

### BOOLEAN
*   Stocke des valeurs vrai/faux (true/false).
*   Certaines bases de données peuvent représenter les valeurs booléennes par des entiers (ex : 0 pour faux, 1 pour vrai).

## Autres types de données

### BLOB (Binary Large Object)
*   Stocke des données binaires, telles que des images, des fichiers audio ou vidéo.

### JSON
*   Stocke des données au format JSON (JavaScript Object Notation).
*   Permet de stocker des données semi-structurées dans une colonne de base de données.

## Valeurs NULL

Il est important de comprendre le concept de `NULL` en SQL. `NULL` représente une valeur manquante ou inconnue. Une colonne peut être définie pour autoriser ou interdire les valeurs `NULL`. Contrairement aux autres types de données, `NULL` n'est pas un type de données en soi, mais plutôt une propriété d'une colonne. Il est crucial de gérer correctement les valeurs `NULL` dans les requêtes pour éviter des résultats inattendus. Les comparaisons avec `NULL` doivent être effectuées en utilisant `IS NULL` ou `IS NOT NULL`.

## Choisir le bon type de données

*   Considérez le type de données que vous devez stocker (numérique, texte, date/heure, etc.).
*   Choisissez le plus petit type de données capable d'accueillir la plage de valeurs attendue.
*   Utilisez `VARCHAR` au lieu de `CHAR` à moins que vous n'ayez besoin de chaînes de longueur fixe.
*   Utilisez `DECIMAL` pour les valeurs numériques exactes, en particulier pour les devises.
*   Soyez conscient des types de données spécifiques et de leur comportement dans votre système de base de données.

En comprenant les types de données disponibles et leurs caractéristiques, vous pouvez concevoir des bases de données efficaces, fiables et faciles à entretenir.

**Points clés de cette leçon :**

*   **L'importance des types de données :** Choisir le type de données approprié est crucial pour l'intégrité des données, l'efficacité du stockage et les performances des requêtes.
*   **Types numériques :** `INTEGER`, `DECIMAL` et `FLOAT` sont utilisés pour stocker des données numériques, chacun avec des caractéristiques différentes en matière de précision et de plage.
*   **Types de chaînes :** `CHAR`, `VARCHAR` et `TEXT` sont utilisés pour stocker des données textuelles, avec des contraintes de longueur et des implications de stockage variables.
*   **Types de date/heure :** `DATE`, `TIME` et `DATETIME` sont utilisés pour stocker des données temporelles, avec des formats spécifiques qui varient selon les systèmes de base de données.
*   **Autres types :** `BOOLEAN`, `BLOB` et `JSON` permettent de stocker respectivement des valeurs booléennes, des données binaires et des données semi-structured.
*   **Valeurs NULL :** `NULL` représente une valeur manquante ou inconnue et n'est pas un type de données en soi. Il est crucial de gérer correctement les valeurs `NULL` dans les requêtes.
*   **Choisir judicieusement :** Tenez compte de la nature des données, de la précision requise et des implications de stockage lors du choix d'un type de données pour une colonne.
