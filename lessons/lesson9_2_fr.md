Cette leçon est consacrée à l'instruction `UPDATE` — la commande qui permet de modifier des enregistrements existants dans une table de base de données. Vous apprendrez la syntaxe de base pour mettre à jour une ou plusieurs colonnes, comment utiliser la clause `WHERE` pour cibler des lignes précises, et les règles importantes pour utiliser `UPDATE` en toute sécurité. Nous verrons également comment mettre à jour plusieurs lignes à la fois et utiliser les valeurs actuelles des colonnes dans des expressions.

Title: Mise à jour des données

# Leçon 9.2 : L'instruction UPDATE

Dans la leçon précédente, nous avons appris à ajouter de nouvelles lignes avec `INSERT INTO`. Voyons maintenant comment **modifier des données déjà existantes** grâce à l'instruction `UPDATE`. Il s'agit de l'une des opérations DML essentielles qui permet de maintenir votre base de données à jour.

## Syntaxe de base

```sql
UPDATE nom_de_table
SET colonne1 = valeur1, colonne2 = valeur2, ...
WHERE condition;
```

*   `UPDATE nom_de_table` — indique la table dans laquelle vous souhaitez modifier des données.
*   `SET colonne = valeur` — définit les nouvelles valeurs pour une ou plusieurs colonnes.
*   `WHERE condition` — détermine quelles lignes seront mises à jour.

---

## Règles importantes

*   **Utilisez toujours `WHERE` :** Sans clause `WHERE`, l'instruction `UPDATE` modifiera **toutes les lignes** de la table. Il s'agit de l'une des erreurs les plus courantes et les plus dangereuses.
*   **Types de données :** Les nouvelles valeurs doivent correspondre au type de données de la colonne.
*   **Chaînes et dates :** Les valeurs textuelles et les dates doivent être entre guillemets simples (`'`).
*   **Nombres :** Les valeurs numériques ne nécessitent pas de guillemets.
*   **Transactions :** Dans les systèmes en production, il est recommandé d'exécuter `UPDATE` dans une transaction afin de pouvoir annuler les modifications en cas d'erreur.

---

## Exemples

### Exemple 1 : Mise à jour d'une seule colonne
Modifions l'adresse e-mail d'un client spécifique dans la table `customer`.

```sql
UPDATE customer
SET email = 'new.email@example.com'
WHERE customer_id = 1;
```

*Remarque : La condition `WHERE customer_id = 1` garantit que seul un enregistrement précis sera modifié.*

### Exemple 2 : Mise à jour de plusieurs colonnes simultanément
Vous pouvez lister plusieurs colonnes dans la clause `SET`, séparées par des virgules.

```sql
UPDATE customer
SET first_name = 'ALICE',
    last_name  = 'COOPER',
    email      = 'alice.cooper@example.com'
WHERE customer_id = 42;
```

### Exemple 3 : Utilisation de la valeur actuelle dans une expression
L'instruction `UPDATE` permet de calculer une nouvelle valeur à partir de la valeur actuelle. Par exemple, augmentons le tarif de location de tous les films de la catégorie « Comedy » de 10 % :

```sql
UPDATE film
SET rental_rate = rental_rate * 1.10
WHERE film_id IN (
    SELECT f.film_id
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c       ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy'
);
```

*Résultat : Le tarif de location de tous les films « Comedy » augmentera de 10 %.*

### Exemple 4 : Mise à jour de plusieurs lignes selon une condition
Marquons tous les clients inactifs qui n'ont pas effectué de location après une certaine date :

```sql
UPDATE customer
SET active = 0
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM rental
    WHERE rental_date >= '2005-08-01'
);
```

### Exemple 5 : Réinitialisation d'une valeur à NULL
Si une colonne autorise `NULL`, vous pouvez explicitement l'effacer :

```sql
UPDATE film
SET original_language_id = NULL
WHERE film_id = 10;
```

---

## Vérification avant la mise à jour

Une bonne pratique consiste à exécuter d'abord un `SELECT` avec la même condition `WHERE`, afin de s'assurer que les bonnes lignes seront affectées :

```sql
-- D'abord, vérifier ce que retourne SELECT
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id = 1;

-- Seulement après vérification, exécuter l'UPDATE
UPDATE customer
SET email = 'new.email@example.com'
WHERE customer_id = 1;
```

---

**Points clés de cette leçon :**

*   L'instruction `UPDATE` modifie les lignes existantes dans une table.
*   Sans clause `WHERE`, **toutes** les lignes de la table seront mises à jour — vérifiez toujours sa présence.
*   Plusieurs colonnes peuvent être mises à jour dans une seule clause `SET`, séparées par des virgules.
*   Une nouvelle valeur de colonne peut être calculée à partir de sa valeur actuelle (ex. : `price = price * 1.1`).
*   Avant d'exécuter un `UPDATE`, il est recommandé d'effectuer un `SELECT` avec la même condition pour vérifier les lignes affectées.

Dans la prochaine leçon, nous étudierons l'instruction **DELETE** — comment supprimer des lignes d'une table de façon sûre et contrôlée.
