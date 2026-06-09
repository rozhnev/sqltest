---
title: "Fonctions SQL intégrées : syntaxe, catégories et exemples pratiques"
description: "Découvrez comment utiliser les fonctions SQL intégrées dans SELECT et WHERE, avec des exemples concrets basés sur la base Sakila."
keywords: ["fonctions sql", "fonctions SQL intégrées", "exemples de fonctions SQL", "fonctions dans SELECT", "fonctions dans WHERE", "SQL Sakila"]
teaches: ["Comprendre ce que sont les fonctions SQL intégrées", "Utiliser les fonctions SQL dans SELECT et WHERE", "Choisir le bon type de fonction pour le texte, les nombres et les dates", "Éviter les erreurs fréquentes lors de l'utilisation des fonctions SQL"]
about: ["SQL", "Fonctions intégrées", "Traitement des données", "Base de données Sakila", "Base de données relationnelle"]
---

_Leçon 3.1 · Temps de lecture : ~8 min_

Dans cette leçon, vous étudierez le thème « fonctions sql » et verrez comment les fonctions intégrées permettent de transformer les données directement dans une requête. Nous allons couvrir la syntaxe de base, les principales catégories de fonctions et des exemples pratiques sur Sakila. À la fin, vous saurez utiliser les fonctions SQL avec assurance dans des cas réels d'analyse.

# Fonctions SQL intégrées

Dans les leçons précédentes, vous avez appris à sélectionner, filtrer et trier des lignes. L'étape suivante consiste à calculer et transformer des valeurs dans la requête, sans traitement supplémentaire côté application.

Les fonctions SQL intégrées sont idéales pour cela : elles rendent les requêtes plus expressives, réduisent la logique répétitive et accélèrent la préparation des rapports.

<img src="/images/lessons/lesson3_1-built-in-functions.svg" alt="Fonctions SQL intégrées" width="100%">

---

## Qu'est-ce qu'une fonction SQL intégrée

Une fonction SQL intégrée est une opération prédéfinie fournie par le SGBD. Elle reçoit des arguments et retourne une nouvelle valeur : texte, nombre, date ou résultat booléen.

On utilise des fonctions quand il faut :

- normaliser des valeurs textuelles ;
- effectuer des calculs directement en SQL ;
- extraire une partie d'une chaîne ou d'une date ;
- convertir des valeurs d'un type vers un autre.

---

## Syntaxe de base

```sql
FUNCTION_NAME(argument1, argument2, ...)
```

Où :

- `FUNCTION_NAME` est le nom de la fonction ;
- `argument1, argument2, ...` sont des colonnes, des littéraux ou des résultats d'autres fonctions.

Exemple d'appel simple de fonction :

```sql
SELECT
	UPPER(first_name) AS upper_name
FROM customer
LIMIT 5;
```

*Résultat : chaque valeur de `first_name` est convertie en majuscules.*

Vous pouvez aussi utiliser des appels imbriqués, où le résultat d'une fonction est passé en argument à une autre.

Exemple d'appel imbriqué :

```sql
SELECT
	UPPER(TRIM(first_name)) AS normalized_name
FROM customer
LIMIT 5;
```

*Résultat : les espaces en début/fin sont supprimés, puis le nom est converti en majuscules.*

---

## Où les fonctions sont le plus utilisées

### Fonctions dans SELECT

Dans `SELECT`, les fonctions servent à façonner la sortie.

```sql
SELECT
	customer_id,
	CONCAT(first_name, ' ', last_name) AS full_name,
	UPPER(email) AS email_upper
FROM customer
LIMIT 10;
```

*Remarque : cet exemple utilise une seule table et montre comment les fonctions formatent les colonnes de sortie directement dans `SELECT`.*

### Fonctions dans WHERE

Dans `WHERE`, les fonctions aident à filtrer selon des conditions calculées.

```sql
SELECT
	title,
	rental_duration
FROM film
WHERE LENGTH(title) >= 15
  AND ABS(rental_duration - 5) <= 2
ORDER BY title;
```

*Résultat : renvoie les films avec des titres plus longs et une durée de location proche de 5 jours.*

---

## Principaux types de fonctions SQL

### Fonctions de chaîne

Exemples : `UPPER`, `LOWER`, `TRIM`, `SUBSTRING`, `CONCAT`.

Utilisées pour nettoyer et formater le texte.

### Fonctions mathématiques

Exemples : `ROUND`, `ABS`, `CEILING`, `FLOOR`, `MOD`.

Utilisées pour les calculs, les arrondis et le contrôle numérique.

### Fonctions de date et d'heure

Exemples : `NOW`, `CURRENT_DATE`, `YEAR`, `MONTH`, `DATE_ADD`, `DATEDIFF`.

Utilisées pour l'analyse temporelle et les intervalles.

### Fonctions de conversion de type

Exemples : `CAST`, `CONVERT`.

Utilisées quand un cast explicite est nécessaire.

---

## Recommandations pratiques

- Vérifiez toujours le comportement des fonctions dans votre SGBD : la syntaxe et les détails peuvent varier.
- Utilisez des alias `AS` pour rendre les colonnes calculées plus lisibles.
- Tenez compte des `NULL`, car le résultat d'une fonction peut devenir `NULL`.
- Évitez les requêtes avec des fonctions trop imbriquées ; découpez la logique en étapes.

---

**Points clés de cette leçon :**

- Les fonctions SQL intégrées permettent de traiter les données directement dans les requêtes.
- Les fonctions dans `SELECT` structurent la sortie, celles dans `WHERE` rendent le filtrage plus précis.
- Les fonctions de chaîne, mathématiques, temporelles et de conversion couvrent la majorité des besoins de base.
- Une bonne gestion des types de données et des `NULL` est indispensable pour des résultats prévisibles.
- Bien utilisées, les fonctions rendent les requêtes SQL plus courtes, plus claires et plus utiles en analytique.

## Questions d'entretien

### Qu'est-ce qu'une fonction SQL intégrée et pourquoi est-elle utile ?
Une fonction SQL intégrée est une opération prédéfinie fournie par le SGBD. Elle est utile car elle permet de transformer, calculer et formater les données directement dans une requête.

### Pourquoi utilise-t-on souvent des fonctions SQL dans `SELECT` et dans `WHERE` ?
Dans `SELECT`, les fonctions servent à formater ou calculer les valeurs de sortie. Dans `WHERE`, elles servent à filtrer les lignes avec des conditions calculées.

### Qu'est-ce qu'un appel de fonction imbriqué et quand l'utiliser ?
Un appel imbriqué consiste à passer le résultat d'une fonction à une autre. C'est utile quand les données doivent être transformées en plusieurs étapes, par exemple `UPPER(TRIM(first_name))`.

Dans la prochaine leçon, nous étudierons en détail les fonctions de chaîne SQL pour nettoyer et transformer efficacement les données textuelles.
