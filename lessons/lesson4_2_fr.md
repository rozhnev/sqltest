---
title: "Regrouper les donnees en SQL avec GROUP BY et les agregations"
description: "Apprenez GROUP BY: syntaxe, regles, regroupement sur une ou plusieurs colonnes, exemples pratiques Sakila."
keywords: ["GROUP BY SQL", "regroupement donnees", "fonctions d'aggregation", "HAVING", "Sakila"]
teaches: ["Utiliser GROUP BY pour regrouper et agreger les donnees", "Comprendre la regle: toutes les colonnes SELECT soit en GROUP BY soit en fonction", "Regrouper par une ou plusieurs colonnes"]
about: ["SQL", "GROUP BY", "Aggregation", "Sakila"]
---

_Temps de lecture: ~7 minutes_

Le regroupement transforme les lignes individuelles en metriques categorisees. GROUP BY est essentiel pour les rapports ou vous avez besoin de totaux par categorie, date ou autre dimension. Dans cette lecon, vous apprendrez la syntaxe GROUP BY, la regle centrale et des exemples pratiques sur Sakila. A la fin, vous saurez construire des requetes analytiques avec regroupement.

# Regrouper les donnees avec GROUP BY

Dans la lecon precedente, vous avez decouvert les fonctions d'aggregation. Maintenant passons a l etape suivante: appliquer ces fonctions a differentes categories de donnees.

GROUP BY fait cela en divisant les donnees en groupes et en calculant les metriques pour chaque groupe separement.

## Syntaxe de GROUP BY

Structure de base:

```sql
SELECT colonne1, FONCTION_AGG(colonne2)
FROM table
GROUP BY colonne1;
```

## La regle centrale

Quand vous utilisez GROUP BY, **chaque colonne de SELECT doit**:

- soit etre dans la liste GROUP BY;
- soit etre encapsulee dans une fonction d agregation (SUM, COUNT, AVG, MIN, MAX).

Cette regle previent l ambiguite: SQL doit savoir quelle valeur retourner quand un groupe a plusieurs lignes.

## Regroupement par une seule colonne

### Total des paiements par client

```sql
SELECT customer_id, SUM(amount) AS total_paye
FROM payment
GROUP BY customer_id;
```

*Resultat: une ligne par client avec la somme de ses paiements.*

### Nombre de paiements par employe

```sql
SELECT staff_id, COUNT(*) AS nb_paiements
FROM payment
GROUP BY staff_id;
```

*Resultat: pour chaque employe, le nombre de paiements traites.*

### Paiement moyen par date

```sql
SELECT DATE(payment_date) AS date_paiement, AVG(amount) AS paiement_moyen
FROM payment
GROUP BY DATE(payment_date);
```

*Resultat: pour chaque date, le montant moyen des paiements.*

### Variante: GROUP BY avec alias

```sql
SELECT DATE(payment_date) AS date_paiement, AVG(amount) AS paiement_moyen
FROM payment
GROUP BY date_paiement;
```

*Note: cela fonctionne en MySQL/MariaDB mais pas dans tous les SGBD. Pour la compatibilite multi-SGBD, ecrivez `GROUP BY DATE(payment_date)` completement.*

---

## Regroupement par plusieurs colonnes

Vous pouvez regrouper par plusieurs champs a la fois pour une analyse plus detaillee.

### Total des paiements par employe et client

```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paye
FROM payment
GROUP BY staff_id, customer_id;
```

*Resultat: une ligne par paire (employe, client) avec leur total de paiements.*

---

## Exemples pratiques

### Rapport de chiffre d affaires par jour

```sql
SELECT DATE(payment_date) AS pay_date, SUM(amount) AS total_sales
FROM payment
GROUP BY DATE(payment_date)
ORDER BY pay_date;
```

### Clients les plus actifs par nombre de locations

```sql
SELECT customer_id, COUNT(*) AS rentals_count
FROM rental
GROUP BY customer_id
ORDER BY rentals_count DESC;
```

### Tarif moyen de location par categorie

```sql
SELECT category_id, AVG(rental_rate) AS avg_rental_rate
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY category_id;
```

---

## Questions frequentes

### Pourquoi ne peux-je pas selectionner n importe quelle colonne si j utilise GROUP BY?
Parce que les fonctions d aggregation (SUM, COUNT, AVG) indiquent deja comment traiter toutes les lignes du groupe. Si une colonne n est pas agregee, elle doit etre en GROUP BY pour que SQL sache quelle valeur choisir.

### Puis-je regrouper par une expression plutot que par une colonne?
Oui, par exemple `GROUP BY DATE(payment_date)` ou `GROUP BY YEAR(payment_date)`. L expression doit correspondre en SELECT et GROUP BY.

### Que se passe-t-il si GROUP BY est vide?
C est une erreur de syntaxe. GROUP BY doit toujours avoir au moins une colonne ou une expression.

---

## Questions d entretien

### Qu est-ce que GROUP BY et pourquoi en avons-nous besoin?
GROUP BY combine les lignes ou les colonnes selectionnees ont les memes valeurs en un seul groupe. Vous pouvez alors appliquer des fonctions d aggregation a chaque groupe pour obtenir des statistiques recapitulatives.

### Pourquoi ne peux-je pas choisir arbitrairement une colonne avec GROUP BY?
Parce qu un groupe peut contenir plusieurs lignes avec des valeurs differentes dans cette colonne. SQL doit savoir quelle valeur retourner, sinon le resultat est ambigu. La colonne doit donc soit etre en GROUP BY, soit dans une fonction d aggregation.

### Quelle est la difference entre WHERE et HAVING?
WHERE filtre les lignes AVANT le regroupement, tandis que HAVING filtre les groupes APRES le regroupement. Par exemple, `WHERE amount > 10` exclut les lignes avant regroupement, tandis que `HAVING SUM(amount) > 100` exclut les groupes dont la somme est inferieure a 100.

---

**Points cles de cette lecon:**

- GROUP BY divise les donnees en groupes et applique les agregats a chacun.
- Regle centrale: toutes les colonnes SELECT soit en GROUP BY soit en fonction d aggregation.
- Vous pouvez regrouper par une ou plusieurs colonnes simultanement.
- Vous pouvez regrouper par des expressions, comme `GROUP BY DATE(payment_date)`.
- GROUP BY alimente les rapports, l analyse et les syntheses par categorie.

Dans la prochaine lecon, nous explorerons le filtrage des groupes avec l operateur HAVING.
