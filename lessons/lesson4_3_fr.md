# Leçon 4.3 : Filtrer les données groupées avec HAVING en SQL

Lorsque vous travaillez avec des données groupées en SQL, vous devez souvent filtrer les résultats de l'agrégation. La clause `HAVING` permet de spécifier des conditions sur les groupes créés par `GROUP BY`, de la même façon que `WHERE` filtre les lignes individuelles. Dans cette leçon, vous apprendrez à utiliser `HAVING` pour filtrer les résultats agrégés, avec des exemples pratiques sur la base Sakila.

## Le rôle de HAVING

- `WHERE` filtre les lignes avant le regroupement.
- `HAVING` filtre les groupes après l'agrégation. `HAVING` est le plus souvent utilisé avec des fonctions d'agrégation, mais peut également s'appliquer à des colonnes non agrégées (en général des colonnes du `GROUP BY`).

### Syntaxe

```sql
SELECT colonne1, FONCTION_AGG(colonne2)
FROM table
GROUP BY colonne1
HAVING condition;
```

## Exemple : Clients avec un total de paiements supérieur à un seuil

```sql
SELECT customer_id, SUM(amount) AS total_paye
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```
**Résultat :** Retourne uniquement les clients dont le total des paiements dépasse 100.

## Exemple : Employés ayant traité plus de 50 paiements

```sql
SELECT staff_id, COUNT(*) AS nb_paiements
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```
**Résultat :** Affiche seulement les employés ayant traité plus de 50 paiements.

## Exemple : Filtrer par montant moyen de paiement

```sql
SELECT customer_id, AVG(amount) AS paiement_moyen
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```
**Résultat :** Liste les clients dont le paiement moyen est d'au moins 5.

## Utiliser HAVING avec plusieurs conditions

Vous pouvez combiner plusieurs conditions dans la clause `HAVING` avec `AND`/`OR`.

```sql
SELECT staff_id, COUNT(*) AS nb_paiements, SUM(amount) AS total_paye
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```
**Résultat :** Retourne les employés ayant traité plus de 50 paiements et dont le total dépasse 500.

## Utilisation pratique

1. **Catégories de films les plus vendues :**
   ```sql
   SELECT c.name AS categorie, SUM(p.amount) AS ventes_totales
   FROM payment p
   JOIN rental r ON p.rental_id = r.rental_id
   JOIN inventory i ON r.inventory_id = i.inventory_id
   JOIN film f ON i.film_id = f.film_id
   JOIN film_category fc ON f.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   GROUP BY c.name
   HAVING SUM(p.amount) > 500;
   ```
2. **Pays avec plus de 20 clients :**
   ```sql
   SELECT country, COUNT(*) AS nb_clients
   FROM customer cu
   JOIN address a ON cu.address_id = a.address_id
   JOIN city ci ON a.city_id = ci.city_id
   JOIN country co ON ci.country_id = co.country_id
   GROUP BY country
   HAVING COUNT(*) > 20;
   ```

## Points clés de cette leçon

La clause `HAVING` permet de filtrer les groupes après l'agrégation, là où `WHERE` ne peut pas intervenir. Elle est indispensable pour affiner les résultats groupés et obtenir des analyses précises. Pratiquez HAVING avec la base Sakila pour maîtriser le filtrage des données agrégées.
