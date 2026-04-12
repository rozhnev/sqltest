Cette leçon est consacrée à l'instruction `DELETE` — la commande qui supprime des lignes existantes d'une table de base de données. Vous apprendrez la syntaxe de base de la suppression, comment utiliser la clause `WHERE` en toute sécurité, verrez des exemples de suppression ciblée ou en masse et découvrirez comment vérifier une requête avant de l'exécuter. À la fin de cette leçon, vous serez capable de supprimer des données de manière réfléchie et sûre.

Title: Suppression des données

# Leçon 8.3 : L'instruction DELETE

Dans la leçon précédente, nous avons appris à modifier des enregistrements avec `UPDATE`. Voyons maintenant comment **supprimer des lignes inutiles ou obsolètes** grâce à l'instruction `DELETE`. C'est une commande DML importante qu'il faut utiliser avec une attention particulière, car les données supprimées ne peuvent pas toujours être récupérées facilement.

## Syntaxe de base

```sql
DELETE FROM nom_de_table
WHERE condition;
```

*   `DELETE FROM nom_de_table` — indique la table dont les lignes doivent être supprimées.
*   `WHERE condition` — détermine quelles lignes seront supprimées.

Si `WHERE` est omis, **toutes les lignes** de la table seront supprimées.

---

## Règles importantes

*   **Vérifiez toujours la clause `WHERE` :** une erreur dans la condition peut supprimer les mauvaises données ou trop de lignes.
*   **Exécutez d'abord un `SELECT` :** avant d'utiliser `DELETE`, il est recommandé d'exécuter un `SELECT` avec la même condition pour vérifier que le résultat est correct.
*   **La structure de la table reste intacte :** `DELETE` supprime uniquement les données, pas la table ni ses colonnes.
*   **Attention aux données liées :** si des clés étrangères sont définies, la base peut empêcher la suppression de lignes référencées par d'autres tables.
*   **Transactions :** dans les systèmes en production, il est plus sûr d'exécuter les suppressions importantes à l'intérieur d'une transaction.

---

## Exemples

### Exemple 1 : Supprimer une seule ligne
Supprimons un client à l'aide de son identifiant :

```sql
DELETE FROM customer
WHERE customer_id = 1;
```

*Remarque : grâce à `WHERE customer_id = 1`, une seule ligne précise sera supprimée.*

### Exemple 2 : Supprimer plusieurs lignes selon une condition
Supprimons les paiements effectués avant une certaine date :

```sql
DELETE FROM payment
WHERE payment_date < '2005-05-25';
```

*Résultat : toutes les lignes de `payment` dont la date de paiement est antérieure à la date indiquée seront supprimées.*

### Exemple 3 : Supprimer avec une sous-requête
Parfois, il faut supprimer des lignes en fonction d'une condition provenant d'une autre table. Par exemple, supprimons les paiements des clients inactifs :

```sql
DELETE FROM payment
WHERE customer_id IN (
    SELECT customer_id
    FROM customer
    WHERE active = 0
);
```

*Résultat : tous les paiements des clients marqués comme inactifs seront supprimés.*

### Exemple 4 : Supprimer toutes les lignes d'une table
Si vous devez vider complètement une table, `DELETE` peut aussi être utilisé sans `WHERE` :

```sql
DELETE FROM temp_import;
```

*Remarque : la table `temp_import` existera toujours, mais toutes ses lignes auront été supprimées.*

---

## Vérifier avant de supprimer

Une bonne pratique consiste à examiner d'abord les lignes concernées :

```sql
-- D'abord vérifier les lignes
SELECT customer_id, first_name, last_name, active
FROM customer
WHERE active = 0;

-- Seulement après vérification, exécuter le DELETE
DELETE FROM customer
WHERE active = 0;
```

Cette approche aide à éviter la suppression accidentelle de données supplémentaires.

---

## Quand `DELETE` est particulièrement utile

- nettoyer des données temporaires ou de test ;
- supprimer des enregistrements obsolètes selon une date ;
- supprimer des lignes qui ne respectent plus les règles métier ;
- préparer des tables à un nouveau chargement de données.

---

**Points clés de cette leçon :**

*   `DELETE` supprime des lignes existantes d'une table.
*   Sans `WHERE`, **toutes** les lignes de la table seront supprimées.
*   Avant de supprimer, il est conseillé d'exécuter un `SELECT` avec la même condition.
*   `DELETE` conserve la structure de la table — seules les données sont supprimées.
*   Dans les cas importants, il est plus sûr d'utiliser des transactions et de tenir compte des clés étrangères.
