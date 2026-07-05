---
title: "Filtrer les donnees groupees avec HAVING en SQL"
description: "Apprenez HAVING: syntaxe, differences WHERE vs HAVING, filtrage des groupes apres agregation, exemples Sakila."
keywords: ["HAVING SQL", "filtrage groupes", "GROUP BY", "fonctions d'aggregation", "Sakila"]
teaches: ["Utiliser HAVING pour filtrer les groupes apres agregation", "Comprendre les differences entre WHERE et HAVING", "Combiner plusieurs conditions dans HAVING"]
about: ["SQL", "HAVING", "GROUP BY", "Aggregation", "Sakila"]
---

_Temps de lecture: ~7 minutes_

Quand vous utilisez GROUP BY avec les agregations, vous devez souvent filtrer les groupes par leurs resultats agregues. HAVING est l operateur pour filtrer les groupes, comme WHERE filtre les lignes individuelles. Dans cette lecon, vous apprendrez les differences entre WHERE et HAVING, la syntaxe et des exemples pratiques sur Sakila. A la fin, vous utiliserez HAVING avec assurance pour l analyse approfondie des donnees.

# Filtrer les groupes avec HAVING

Dans les lecons precedentes, vous avez appris GROUP BY pour grouper les donnees et appliquer les agregations. Vient maintenant l etape suivante: filtrer les groupes eux-memes par des conditions sur les valeurs agregues.

HAVING fait cela en permettant des conditions apres le regroupement.

## WHERE vs HAVING

- **WHERE** filtre les lignes **avant** le regroupement
- **HAVING** filtre les groupes **apres** l agregation

```sql
SELECT colonne1, COUNT(*) AS cnt
FROM table
WHERE colonne1 > 100          -- filtrer AVANT le regroupement
GROUP BY colonne1
HAVING COUNT(*) > 10;         -- filtrer APRES le regroupement
```

## Syntaxe de HAVING

Structure de base:

```sql
SELECT colonne1, FONCTION_AGG(colonne2)
FROM table
GROUP BY colonne1
HAVING condition;
```

La condition en HAVING implique generalement une fonction d agregation.

---

## Exemples avec une seule condition

### Clients avec paiements totaux au-dessus de 100

```sql
SELECT customer_id, SUM(amount) AS total_paye
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```

*Resultat: uniquement les clients dont les paiements totaux depassent 100.*

### Employes ayant traite plus de 50 paiements

```sql
SELECT staff_id, COUNT(*) AS nb_paiements
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```

*Resultat: employes avec plus de 50 paiements traites.*

### Clients avec paiement moyen >= 5

```sql
SELECT customer_id, AVG(amount) AS paiement_moyen
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```

*Resultat: clients dont le paiement moyen est d au moins 5.*

---

## HAVING avec plusieurs conditions

Vous pouvez combiner les conditions avec AND et OR:

```sql
SELECT staff_id, COUNT(*) AS cnt, SUM(amount) AS total
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```

*Resultat: employes avec plus de 50 paiements ET total au-dessus de 500.*

### Avec l operateur OR

```sql
SELECT customer_id, COUNT(*) AS rentals, SUM(amount) AS paid
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 100 OR SUM(amount) > 1000;
```

*Resultat: clients avec plus de 100 paiements OU total au-dessus de 1000.*

---

## Exemples pratiques

### Categories de films avec ventes au-dessus de 2000

```sql
SELECT category_id, SUM(p.amount) AS total_ventes
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
GROUP BY category_id
HAVING SUM(p.amount) > 2000;
```

### Pays avec plus de 20 clients

```sql
SELECT country, COUNT(*) AS nb_clients
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY country
HAVING COUNT(*) > 20;
```

### Magasins avec revenus quotidiens au-dessus de 500

```sql
SELECT store_id, DATE(payment_date) AS date_paiement, SUM(amount) AS revenus_quotidiens
FROM payment
GROUP BY store_id, DATE(payment_date)
HAVING SUM(amount) > 500;
```

---

## Questions frequentes

### Pourquoi ne peux-je pas utiliser WHERE au lieu de HAVING?
WHERE fonctionne avant le regroupement, il ne peut donc pas verifier les fonctions d agregation. HAVING fonctionne apres le regroupement et peut analyser les resultats d agregation (COUNT, SUM, AVG, etc.).

### Puis-je utiliser une colonne non agregee dans HAVING?
Oui, vous pouvez utiliser une colonne de GROUP BY, mais cela n est generalement pas necessaire. Par exemple, `HAVING customer_id > 100` fonctionne, mais il est plus naturel d ecrire cela dans WHERE avant le regroupement.

### HAVING peut-il etre utilise sans GROUP BY?
Techniquement dans certains SGBD c est possible, mais c est impratique car HAVING est concu pour filtrer les groupes. Utilisez WHERE pour filtrer les lignes individuelles sans regroupement.

---

## Questions d entretien

### Qu est-ce que HAVING et en quoi differe-t-il de WHERE?
HAVING filtre les groupes apres agregation, tandis que WHERE filtre les lignes avant regroupement. WHERE ne peut pas fonctionner avec les fonctions d agregation, mais HAVING fonctionne uniquement avec elles.

### Puis-je utiliser WHERE et HAVING ensemble dans une requete?
Oui, c est meme recommande. WHERE filtre les lignes avant regroupement et HAVING filtre les groupes apres. Par exemple, `WHERE amount > 10 GROUP BY customer_id HAVING SUM(amount) > 100` exclut d abord les petits paiements, puis regroupe et filtre les groupes.

### Quel est l ordre d execution: WHERE ou HAVING?
WHERE est applique en premier (avant GROUP BY), puis GROUP BY effectue le regroupement, puis HAVING filtre les groupes resultants, et enfin ORDER BY et LIMIT sont appliques.

---

**Points cles de cette lecon:**

- HAVING filtre les groupes **apres** agregation, WHERE filtre les lignes **avant** regroupement.
- HAVING est utilise avec les fonctions d agregation (COUNT, SUM, AVG, MIN, MAX).
- Vous pouvez combiner plusieurs conditions dans HAVING en utilisant AND/OR.
- Souvent WHERE et HAVING fonctionnent ensemble: WHERE exclut les lignes inutiles, HAVING filtre les groupes.
- HAVING permet des requetes analytiques profondes avec filtrage au niveau du groupe.

Dans la prochaine lecon, nous explorerons ORDER BY pour trier les resultats.
