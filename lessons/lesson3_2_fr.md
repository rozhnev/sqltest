# Leçon 3.2 : Fonctions de chaîne courantes en SQL

Les fonctions de chaîne en SQL sont utilisées pour manipuler et transformer des données textuelles. Elles sont essentielles pour nettoyer, formater et extraire des informations à partir de colonnes de texte dans une base de données. Cette leçon présente certaines des fonctions de chaîne les plus courantes et propose des exemples pratiques.

## Fonctions de chaîne courantes

### `UPPER()` - Convertit une chaîne en majuscules.

**Syntaxe :**
```sql
UPPER(string)
```

**Exemple :**
```sql
SELECT UPPER(first_name) AS uppercase_name
FROM employees;
```
**Résultat :** Convertit toutes les valeurs de `first_name` en majuscules.

### `LOWER()` - Convertit une chaîne en minuscules.

**Syntaxe :**
```sql
LOWER(string)
```

**Exemple :**
```sql
SELECT LOWER(last_name) AS lowercase_name
FROM employees;
```
**Résultat :** Convertit toutes les valeurs de `last_name` en minuscules.

### `LENGTH()`, `CHAR_LENGTH()` ou `LEN()` - Renvoie la longueur d'une chaîne (en caractères ou en octets, selon le SGBD).

**Syntaxe :**
```sql
CHAR_LENGTH(string) -- Nombre de caractères (par exemple, dans MySQL)
LENGTH(string)      -- Dans MySQL : longueur en octets
LEN(string)         -- Dans SQL Server : longueur en caractères
```

Important : selon le SGBD, la « longueur d'une chaîne » peut désigner des choses différentes. Certaines fonctions renvoient une longueur en caractères, d'autres en octets. Vérifiez donc toujours l'unité utilisée par la fonction dans votre SGBD.

**Quand `LENGTH()` et `CHAR_LENGTH()` peuvent différer (par exemple, dans MySQL) :**
- Pour des chaînes composées uniquement de lettres latines et de chiffres, les valeurs coïncident souvent.
- Pour des chaînes contenant des caractères multioctets (cyrillique, emoji, idéogrammes), `LENGTH()` est généralement supérieur à `CHAR_LENGTH()`, car il compte les octets.

**Exemple rapide :**
- `'SQL'` : `LENGTH` = 3, `CHAR_LENGTH` = 3
- `'Привет'` : `LENGTH` = 12, `CHAR_LENGTH` = 6

**Exemple :**
```sql
SELECT CHAR_LENGTH(product_name) AS name_length
FROM products;
```
**Résultat :** Renvoie le nombre de caractères dans chaque valeur de `product_name`.

### `SUBSTRING()` ou `SUBSTR()` - Extrait une partie d'une chaîne.

**Syntaxe :**
```sql
SUBSTRING(string, start_position, length) -- Pour la plupart des bases de données
SUBSTR(string, start_position, length)    -- Pour Oracle et d'autres
```

**Exemple :**
```sql
SELECT SUBSTRING(email, 1, 5) AS email_prefix
FROM users;
```
**Résultat :** Extrait les 5 premiers caractères de la colonne `email`.

### `CONCAT()` - Concatène deux chaînes ou plus en une seule.

**Syntaxe :**
```sql
CONCAT(string1, string2, ...)
```

**Exemple :**
```sql
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;
```
**Résultat :** Combine `first_name` et `last_name` en une seule valeur `full_name`.

**Important :** le comportement de `CONCAT()` face à `NULL` dépend du SGBD. Par exemple, dans MySQL et MariaDB, si au moins un argument vaut `NULL`, le résultat de `CONCAT()` est également `NULL`.

### `CONCAT_WS()` - Concatène des chaînes avec un séparateur et ignore généralement les valeurs `NULL`.

**Syntaxe :**
```sql
CONCAT_WS(separator, string1, string2, ...)
```

**Exemple :**
```sql
SELECT CONCAT_WS(' ', first_name, last_name) AS full_name
FROM employees;
```
**Résultat :** Combine `first_name` et `last_name` avec un espace, en ignorant les valeurs `NULL` dans les arguments.

Si vous avez besoin d'une concaténation NULL-safe sans séparateur, vous pouvez utiliser `CONCAT_WS('', string1, string2, ...)`.

### `TRIM()` - Supprime les caractères au début et à la fin d'une chaîne, le plus souvent des espaces.

**Syntaxe :**
```sql
TRIM(string)
TRIM([characters FROM] string)
```

**Exemple :**
```sql
SELECT TRIM('   SQL Basics   ') AS trimmed_string;
```
**Résultat :** Renvoie `'SQL Basics'` sans espaces au début ni à la fin.

Dans le cas le plus simple, `TRIM()` supprime les espaces aux deux extrémités de la chaîne. Dans certains SGBD, la fonction permet aussi d'indiquer explicitement quels caractères doivent être supprimés.

### `REPLACE()` - Remplace les occurrences d'une sous-chaîne dans une chaîne.

**Syntaxe :**
```sql
REPLACE(string, old_substring, new_substring)
```

**Exemple :**
```sql
SELECT REPLACE(phone_number, '-', '') AS cleaned_phone
FROM contacts;
```
**Résultat :** Supprime les tirets des valeurs `phone_number`.

### `INSTR()` ou `CHARINDEX()` - Trouve la position d'une sous-chaîne dans une chaîne.

**Syntaxe :**
```sql
INSTR(string, substring)       -- Pour la plupart des bases de données
CHARINDEX(substring, string)   -- Pour SQL Server
```

**Exemple :**
```sql
SELECT INSTR(email, '@') AS at_position
FROM users;
```
**Résultat :** Renvoie la position du symbole `@` dans la colonne `email`.

### `LEFT()` et `RIGHT()` - Extraient un nombre spécifié de caractères depuis le début ou la fin d'une chaîne.

**Syntaxe :**
```sql
LEFT(string, number_of_characters)
RIGHT(string, number_of_characters)
```

**Exemple :**
```sql
SELECT LEFT(product_code, 3) AS product_prefix,
       RIGHT(product_code, 4) AS product_suffix
FROM products;
```
**Résultat :** Extrait les 3 premiers caractères et les 4 derniers caractères de `product_code`.

### `FORMAT()` ou `TO_CHAR()` - Formate une chaîne ou un nombre dans un format spécifique.

**Syntaxe :**
```sql
FORMAT(value, format)       -- Pour SQL Server
TO_CHAR(value, format)      -- Pour Oracle
```

**Exemple :**
```sql
SELECT FORMAT(salary, 'C') AS formatted_salary
FROM employees;
```
**Résultat :** Formate la colonne `salary` comme une devise.

## Cas d'utilisation pratiques

1. **Nettoyage des données :**
   Utilisez `TRIM()` et `REPLACE()` pour nettoyer des données désordonnées, par exemple pour supprimer des espaces superflus ou des caractères indésirables.

2. **Mise en forme du résultat :**
   Utilisez `UPPER()`, `LOWER()`, `CONCAT()` et `CONCAT_WS()` pour standardiser et formater du texte dans des rapports.

3. **Extraction d'informations :**
   Utilisez `SUBSTRING()`, `LEFT()` et `RIGHT()` pour extraire des parties précises d'une chaîne, comme des préfixes ou des noms de domaine.

4. **Validation des données :**
   Utilisez des fonctions qui comptent les caractères (par exemple `CHAR_LENGTH()` ou `LEN()`) ainsi que `INSTR()` pour valider la structure des chaînes, par exemple la longueur des numéros de téléphone ou la présence du symbole `@` dans les adresses e-mail.

**Points clés de cette leçon :**

Les fonctions de chaîne sont des outils essentiels pour travailler avec des données textuelles en SQL. En les maîtrisant, vous pourrez nettoyer, formater et extraire des informations utiles à partir de vos données. Entraînez-vous à les utiliser dans des scénarios réels afin d'améliorer vos compétences en SQL.