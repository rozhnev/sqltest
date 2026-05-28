---
title: "Utilisation pratique des fonctions de date et d'heure en SQL pour l'analyse des données"
description: "Apprenez à utiliser concrètement les fonctions de date et d'heure en SQL : métriques journalières et mensuelles, calcul d'intervalles, saisonnalité et reporting."
keywords: ["fonctions date et heure SQL", "DATE_FORMAT SQL", "TIMESTAMPDIFF SQL", "analyse temporelle SQL", "agrégation par date SQL", "SQL Sakila"]
teaches: ["Comment extraire des composantes de date et d'heure pour l'analyse", "Comment construire des métriques journalières, hebdomadaires et mensuelles", "Comment calculer des intervalles entre événements en SQL", "Comment analyser la dynamique des transactions et locations dans le temps", "Comment utiliser les fonctions de date et d'heure dans des rapports pratiques"]
about: ["SQL", "Date et heure", "Analyse de données", "Sakila", "Agrégation"]
---

_Leçon 12.2 · Temps de lecture : ~11 min_

Cette leçon est consacrée à l'utilisation pratique des fonctions de date et d'heure en SQL pour l'analytique. Vous allez apprendre à extraire des périodes depuis des champs temporels, agréger les données par jour et par mois, calculer des intervalles entre événements et construire des rapports basés sur des métriques temporelles. À la fin de la leçon, vous serez capable d'analyser de manière fiable la dynamique temporelle des données avec la base Sakila.

# Utilisation pratique des fonctions de date et d'heure pour l'analyse des données

Dans la leçon précédente, nous avons étudié le traitement pratique des chaînes. Nous passons maintenant à un autre type de données omniprésent dans les cas réels : la date et l'heure.

En analytique, il ne suffit pas d'afficher `payment_date` ou `rental_date`. En pratique, il faut répondre à des questions comme : comment l'activité évolue par jour, à quelles heures il y a le plus de transactions, combien de temps s'écoule entre location et retour, et s'il existe des pics saisonniers.

<img src="/images/lessons/lesson12_2-date-time-analysis.svg" alt="Analyse pratique des données avec les fonctions de date et d'heure en SQL" width="100%">

---

## Pourquoi les fonctions de date et d'heure sont essentielles en analytique

Presque chaque rapport possède une dimension temporelle. Même si la question métier est « combien de ventes » ou « combien de clients », il faut généralement ajouter un contexte temporel : par jour, semaine, mois, trimestre, ou période précise.

Les fonctions de date et d'heure permettent de :

- extraire la granularité nécessaire (jour, mois, heure) ;
- agréger les métriques dans le temps ;
- comparer des périodes entre elles ;
- calculer la durée des processus ;
- détecter des pics et des chutes anormales.

---

## Fonctions de base les plus utilisées

En MySQL, les fonctions suivantes sont particulièrement utiles pour l'analytique pratique :

- `DATE()` - conserver uniquement la date depuis un `DATETIME` ;
- `YEAR()`, `MONTH()`, `DAY()` - extraire des parties de date ;
- `HOUR()` - analyser l'activité horaire ;
- `DATE_FORMAT()` - créer une clé temporelle lisible ;
- `TIMESTAMPDIFF()` - calculer un intervalle entre deux instants ;
- `DATEDIFF()` - calculer un écart en jours.

Voyons des scénarios concrets sur les données Sakila.

---

## Agréger les paiements par jour

Premier scénario pratique : observer l'évolution du volume de paiements par jour.

```sql
SELECT
   DATE(payment_date) AS payment_day,
   COUNT(*) AS payments_count,
   SUM(amount) AS total_amount
FROM payment
GROUP BY DATE(payment_date)
ORDER BY payment_day;
```

*Résultat : vous obtenez la dynamique quotidienne du nombre de paiements et du chiffre d'affaires.*

Ce rapport est utile comme base de suivi d'activité et de détection des variations brutales.

---

## Comparaison mensuelle avec DATE_FORMAT

Quand une vue plus compacte est nécessaire, on agrège par mois.

```sql
SELECT
   DATE_FORMAT(payment_date, '%Y-%m') AS year_month,
   COUNT(*) AS payments_count,
   ROUND(SUM(amount), 2) AS revenue
FROM payment
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY year_month;
```

*Remarque : le format `%Y-%m` est pratique pour le tri et la visualisation BI.*

Si vous gardez seulement le numéro de mois sans l'année, les mêmes mois d'années différentes seront fusionnés.

---

## Analyse de l'activité par heure

Question pratique fréquente : à quelles heures les utilisateurs réalisent-ils le plus d'actions ?

```sql
SELECT
   HOUR(payment_date) AS payment_hour,
   COUNT(*) AS payments_count,
   ROUND(SUM(amount), 2) AS total_amount
FROM payment
GROUP BY HOUR(payment_date)
ORDER BY payment_hour;
```

*Résultat : vous obtenez la distribution de l'activité par heure de la journée.*

Cela aide à planifier la charge, le timing des campagnes et l'organisation opérationnelle.

---

## Calculer la durée d'une location

Les fonctions temporelles servent aussi à analyser le cycle de vie des événements. Dans Sakila, on peut mesurer le nombre d'heures entre la location et le retour.

```sql
SELECT
   rental_id,
   rental_date,
   return_date,
   TIMESTAMPDIFF(HOUR, rental_date, return_date) AS rental_duration_hours
FROM rental
WHERE return_date IS NOT NULL
ORDER BY rental_duration_hours DESC
LIMIT 10;
```

*Résultat : la requête affiche les locations terminées les plus longues.*

Pour une vue synthétique, il est utile d'agréger la durée via moyenne et médiane (si votre SGBD supporte la médiane).

---

## Rapport pratique : durée moyenne de retour par jour de semaine

Combinons maintenant fonctions temporelles et agrégation dans une requête appliquée.

```sql
SELECT
   DAYOFWEEK(rental_date) AS week_day,
   COUNT(*) AS rentals_count,
   ROUND(AVG(TIMESTAMPDIFF(HOUR, rental_date, return_date)), 2) AS avg_return_hours
FROM rental
WHERE return_date IS NOT NULL
GROUP BY DAYOFWEEK(rental_date)
ORDER BY week_day;
```

*Résultat : vous obtenez la durée moyenne de location par jour de semaine.*

Ce rapport aide à identifier des schémas de comportement et à adapter des règles opérationnelles selon les jours.

---

## Comparer la période courante et la période précédente

En analytique réelle, il faut non seulement calculer des métriques, mais aussi comparer les périodes. Même une comparaison simple entre deux intervalles apporte déjà un signal utile.

```sql
SELECT
   CASE
      WHEN payment_date >= '2005-07-01' AND payment_date < '2005-08-01' THEN 'period_1'
      WHEN payment_date >= '2005-08-01' AND payment_date < '2005-09-01' THEN 'period_2'
   END AS period_label,
   COUNT(*) AS payments_count,
   ROUND(SUM(amount), 2) AS revenue
FROM payment
WHERE payment_date >= '2005-07-01'
  AND payment_date < '2005-09-01'
GROUP BY period_label
ORDER BY period_label;
```

*Remarque : ce modèle s'adapte facilement au week-over-week, month-over-month et quarter-over-quarter.*

---

## Recommandations pratiques

- Définissez la granularité cible à l'avance : jour, semaine, mois ou heure.
- Pour un tri stable des périodes, utilisez un format triable lexicalement (`YYYY-MM`).
- Filtrez explicitement les événements incomplets (`return_date IS NOT NULL`) lors du calcul d'intervalles.
- Vérifiez le fuseau horaire source si vous analysez l'activité horaire.
- Pour comparer des périodes, utilisez des bornes claires `>=` et `<` afin d'éviter les chevauchements.

---

**Points clés de cette leçon :**

- Les fonctions de date et d'heure en SQL sont essentielles pour analyser tendances et saisonnalité.
- `DATE`, `DATE_FORMAT`, `HOUR`, `TIMESTAMPDIFF` et `DATEDIFF` couvrent la majorité des besoins pratiques.
- La granularité temporelle influence directement l'interprétation des métriques.
- L'analyse des intervalles entre événements aide à mesurer l'efficacité des processus.
- Même une comparaison simple de périodes fournit un signal utile pour la décision.

---

## Questions fréquentes

### Pourquoi utiliser `>= début` et `< fin` plutôt que `BETWEEN` ?
Parce que ce format crée des intervalles clairs et non chevauchants, surtout avec `DATETIME`. Cela réduit le risque de double comptage aux frontières.

### Quand utiliser `DATE_FORMAT` plutôt que `YEAR()` et `MONTH()` ?
`DATE_FORMAT` est pratique pour des clés de reporting prêtes à l'emploi (par exemple `2025-08`). `YEAR()` et `MONTH()` conviennent mieux quand on a besoin d'une logique séparée par année et mois.

### Qu'est-ce qui casse le plus souvent une analyse temporelle ?
Les causes classiques : fuseaux horaires mélangés, mauvaise granularité, enregistrements incomplets (`NULL` dans `return_date`) et frontières de période ambiguës.

## Questions d'entretien

### Comment expliquer la différence entre `DATEDIFF()` et `TIMESTAMPDIFF()` ?
`DATEDIFF()` renvoie un écart en jours entre deux dates. `TIMESTAMPDIFF()` permet de choisir l'unité (heures, minutes, jours, etc.) et convient mieux aux analyses d'intervalle précises.

### Pourquoi le choix de la granularité temporelle est-il crucial dans un rapport ?
Parce que la granularité détermine l'interprétation : l'analyse journalière montre les variations opérationnelles, l'analyse mensuelle montre la tendance. Un mauvais niveau d'agrégation peut masquer des signaux importants.

### Comment valider un rapport temporel avant publication ?
Je vérifie les bornes de période, le fuseau horaire, le traitement des `NULL`, l'absence de chevauchement d'intervalles, puis je compare les totaux à un échantillon de contrôle issu des données brutes.

Dans la prochaine leçon, nous passerons aux techniques de transformation des données pour l'analyse et verrons comment combiner calculs temporels et conditionnels dans une même requête.
