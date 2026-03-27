# Leçon 3.3 : Fonctions mathematiques essentielles en SQL

Les fonctions mathematiques en SQL sont utilisees pour effectuer differents calculs sur des donnees numeriques. Elles permettent d'arrondir des valeurs, de trouver des minimums et des maximums, de calculer des restes de division, et bien plus encore. Cette lecon presente les fonctions mathematiques les plus courantes, avec des exemples bases sur la base Sakila.

Important : les donnees numeriques en SQL peuvent avoir des types differents (`INTEGER`, `REAL`/`FLOAT`, `DECIMAL`/`NUMERIC`). Une meme formule peut produire des resultats differents selon le type de donnee (par exemple a cause de la division entiere, de l'arrondi et de la precision de stockage). Si le type n'est pas pris en compte, le resultat peut etre different de celui attendu.

## Fonctions mathematiques courantes

### `ABS()` - Renvoie la valeur absolue d'un nombre.

**Syntaxe :**
```sql
ABS(number)
```

**Exemple :**
```sql
SELECT ABS(amount - 5) AS abs_difference
FROM payment
LIMIT 3;
```
**Resultat :** Renvoie la difference absolue entre `amount` et 5.

### `CEIL()` / `CEILING()` - Arrondit un nombre vers le haut (a l'entier le plus proche).

**Syntaxe :**
```sql
CEIL(number)
CEILING(number)
```

**Exemple :**
```sql
SELECT CEIL(amount) AS rounded_up
FROM payment
LIMIT 3;
```
**Resultat :** Arrondit `amount` vers le haut a l'entier le plus proche.

### `FLOOR()` - Arrondit un nombre vers le bas (a l'entier le plus proche).

**Syntaxe :**
```sql
FLOOR(number)
```

**Exemple :**
```sql
SELECT FLOOR(amount) AS rounded_down
FROM payment
LIMIT 3;
```
**Resultat :** Arrondit `amount` vers le bas a l'entier le plus proche.

### `ROUND()` - Arrondit un nombre a un nombre defini de decimales.

**Syntaxe :**
```sql
ROUND(number, decimals)
```

**Exemple :**
```sql
SELECT ROUND(amount, 1) AS rounded_amount
FROM payment
LIMIT 3;
```
**Resultat :** Arrondit `amount` a une decimale.

### `POWER()` / `POW()` - Eleve un nombre a une puissance.

**Syntaxe :**
```sql
POWER(number, exponent)
POW(number, exponent)
```

**Exemple :**
```sql
SELECT POWER(amount, 2) AS squared_amount
FROM payment
LIMIT 3;
```
**Resultat :** Met `amount` au carre.

### `SQRT()` - Renvoie la racine carree d'un nombre.

**Syntaxe :**
```sql
SQRT(number)
```

**Exemple :**
```sql
SELECT SQRT(amount) AS sqrt_amount
FROM payment
LIMIT 3;
```
**Resultat :** Renvoie la racine carree de `amount`.

### `MOD()` - Renvoie le reste d'une division.

**Syntaxe :**
```sql
MOD(dividend, divisor)
```

**Exemple :**
```sql
SELECT MOD(payment_id, 5) AS mod_result
FROM payment
LIMIT 3;
```
**Resultat :** Renvoie le reste de la division de `payment_id` par 5.

### `SIGN()` - Renvoie le signe d'un nombre (-1, 0 ou 1).

**Syntaxe :**
```sql
SIGN(number)
```

**Exemple :**
```sql
SELECT SIGN(amount - 5) AS sign_value
FROM payment
LIMIT 3;
```
**Resultat :** Renvoie -1 si le resultat est negatif, 0 s'il est nul, et 1 s'il est positif.

### `GREATEST()` - Renvoie la plus grande valeur parmi les valeurs fournies (MySQL, PostgreSQL).

**Syntaxe :**
```sql
GREATEST(value1, value2, ...)
```

**Exemple :**
```sql
SELECT GREATEST(amount, 5) AS max_value
FROM payment
LIMIT 3;
```
**Resultat :** Renvoie la plus grande des deux valeurs : `amount` ou 5.

**Important (`NULL`) :** le comportement de `GREATEST()` depend du SGBD.
- En MySQL/MariaDB, si au moins un argument vaut `NULL`, le resultat est generalement `NULL`.
- En PostgreSQL, les arguments `NULL` sont ignores, et `NULL` n'est renvoye que si tous les arguments sont `NULL`.

### `LEAST()` - Renvoie la plus petite valeur parmi les valeurs fournies (MySQL, PostgreSQL).

**Syntaxe :**
```sql
LEAST(value1, value2, ...)
```

**Exemple :**
```sql
SELECT LEAST(amount, 5) AS min_value
FROM payment
LIMIT 3;
```
**Resultat :** Renvoie la plus petite des deux valeurs : `amount` ou 5.

**Important (`NULL`) :** pour `LEAST()`, les memes differences entre SGBD s'appliquent que pour `GREATEST()`.

Pour rendre le comportement previsible dans des requetes multi-SGBD, on utilise souvent `COALESCE()`, par exemple :
```sql
SELECT GREATEST(COALESCE(value1, 0), COALESCE(value2, 0));
```

### `RAND()` - Renvoie un nombre aleatoire entre 0 et 1.

**Syntaxe :**
```sql
RAND()
```

**Exemple :**
```sql
SELECT RAND() AS random_value
FROM payment
LIMIT 3;
```
**Resultat :** Renvoie un nombre aleatoire entre 0 et 1.

**Important :** il ne faut pas supposer que `RAND()` sera systematiquement recalcule pour chaque ligne dans tous les contextes. Selon le SGBD, le plan d'execution, l'utilisation de CTE/sous-requetes et d'autres facteurs, une meme valeur aleatoire peut etre reutilisee pour plusieurs lignes.

Si vous avez absolument besoin de valeurs differentes par ligne, verifiez le comportement sur votre SGBD et avec la forme exacte de la requete.

## Cas d'utilisation pratiques

1. **Arrondir les montants de paiement :**
   Utilisez `ROUND(amount, 0)` pour arrondir les montants a l'entier.

2. **Trouver des enregistrements via un reste de division :**
   Utilisez `MOD(payment_id, 2)` pour distinguer les identifiants pairs et impairs.

3. **Calculer une racine carree :**
   Utilisez `SQRT(amount)` pour analyser la distribution des paiements.

4. **Comparer des valeurs :**
   Utilisez `GREATEST()` et `LEAST()` pour choisir la valeur maximale ou minimale parmi plusieurs valeurs.

5. **Controler le type de donnees :**
   Si la precision est importante, convertissez explicitement vers le type souhaite (par exemple `CAST(value AS DECIMAL(10,2))`) afin d'eviter les surprises liees aux calculs entiers et a l'arrondi.

## Points cles de cette lecon

Les fonctions mathematiques SQL permettent de calculer, d'analyser et de transformer des donnees numeriques. Maitrisez ces fonctions pour travailler efficacement avec des nombres dans vos requetes SQL. Entrainez-vous avec des exemples bases sur Sakila pour consolider vos competences.
