# Leçon 4.2 : Regrouper les données avec GROUP BY en SQL

Regrouper les données est un outil clé pour l'analyse et la synthèse en SQL. La clause `GROUP BY` permet de combiner les lignes ayant les mêmes valeurs dans des colonnes spécifiées et d'appliquer des fonctions d'agrégation à chaque groupe. Dans cette leçon, vous apprendrez à utiliser `GROUP BY` pour le reporting et l'analyse avec des exemples issus de la base Sakila.

## Bases de l'utilisation de GROUP BY

### Syntaxe
```sql
SELECT colonne1, FONCTION_AGG(colonne2)
FROM table
GROUP BY colonne1;
```

### Règle importante

Lors de l'utilisation de `GROUP BY`, chaque colonne présente dans `SELECT` doit :

- soit être incluse dans la clause `GROUP BY` ;
- soit être encapsulée dans une fonction d'agrégation (`SUM`, `COUNT`, `AVG`, `MIN`, `MAX`, etc.).

### Exemple : Total des paiements par client
```sql
SELECT customer_id, SUM(amount) AS total_paye
FROM payment
GROUP BY customer_id;
```
**Résultat :** Retourne l'identifiant du client et le montant total des paiements pour chaque client.

### Exemple : Nombre de paiements par employé
```sql
SELECT staff_id, COUNT(*) AS nb_paiements
FROM payment
GROUP BY staff_id;
```
**Résultat :** Retourne l'identifiant de l'employé et le nombre de paiements traités par chaque employé.

### Exemple : Paiement moyen par date
```sql
SELECT DATE(payment_date) AS date_paiement, AVG(amount) AS paiement_moyen
FROM payment
GROUP BY DATE(payment_date);
```
**Résultat :** Retourne le montant moyen des paiements pour chaque date.

### Variante : GROUP BY avec alias
```sql
SELECT DATE(payment_date) AS date_paiement, AVG(amount) AS paiement_moyen
FROM payment
GROUP BY date_paiement;
```

Cette variante fonctionne en MySQL/MariaDB, où l'utilisation d'un alias dans `GROUP BY` est autorisée.
Mais ce comportement n'est pas universel dans tous les SGBD et n'est pas considéré comme du SQL standard portable.
Pour des requêtes multi-SGBD, il est plus sûr d'utiliser la forme complète `GROUP BY DATE(payment_date)`.

## Utiliser GROUP BY avec plusieurs colonnes

Vous pouvez regrouper les données par plusieurs colonnes pour une analyse plus détaillée.

### Exemple : Total des paiements par employé et client
```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paye
FROM payment
GROUP BY staff_id, customer_id;
```
**Résultat :** Retourne l'identifiant de l'employé, l'identifiant du client et le montant total des paiements pour chaque paire employé-client.

## Utilisation pratique

1. **Analyse des ventes par catégorie de film :**
   ```sql
   SELECT c.name AS categorie, SUM(p.amount) AS ventes_totales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name;
   ```
2. **Nombre de clients par pays :**
   ```sql
   SELECT co.country, COUNT(*) AS nb_clients
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY co.country;
   ```

## Points clés de cette leçon

La clause `GROUP BY` permet de regrouper les données et d'appliquer des fonctions d'agrégation à chaque groupe. C'est un outil puissant pour le reporting et l'analyse en SQL. Pratiquez `GROUP BY` avec des exemples de la base Sakila pour obtenir rapidement des données synthétiques et construire des requêtes analytiques.
