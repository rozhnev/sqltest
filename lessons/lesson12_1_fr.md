---
title: "Traitement pratique des chaînes en SQL : nettoyage, normalisation et extraction"
description: "Apprenez à traiter du texte en SQL de façon pratique : nettoyer des chaînes, extraire des domaines e-mail, créer des libellés et vérifier la qualité des données."
keywords: ["traitement de chaînes SQL", "nettoyage de texte SQL", "normalisation de chaînes SQL", "SUBSTRING_INDEX SQL", "analyse de texte SQL", "SQL Sakila"]
teaches: ["Comment nettoyer et normaliser des champs texte en SQL", "Comment extraire des parties utiles d'une chaîne pour l'analyse", "Comment construire des champs et libellés textuels analytiques", "Comment contrôler la qualité des données textuelles dans des requêtes pratiques", "Comment résoudre des cas réels d'analyse de texte avec Sakila"]
about: ["SQL", "Fonctions de chaîne", "Nettoyage des données", "Analyse de données", "Base de données Sakila"]
---

_Leçon 12.1 · Temps de lecture : ~10 min_

Cette leçon est consacrée au traitement pratique des chaînes en SQL. Vous allez apprendre à nettoyer des valeurs textuelles, normaliser la casse, extraire des fragments utiles et construire des champs lisibles pour l'analyse et le reporting. Nous verrons des scénarios concrets sur la base Sakila. À la fin de la leçon, vous serez capable de préparer des données textuelles pour l'analyse directement en SQL.

# Traitement pratique des chaînes en SQL

Dans le module précédent, nous avons parlé de la qualité du code SQL et de la performance des requêtes. Nous passons maintenant à l'analytique appliquée : dans les données réelles, les champs texte ne doivent pas seulement être affichés, ils doivent d'abord être mis en forme.

Le traitement pratique des chaînes est nécessaire pour les rapports, la segmentation des utilisateurs, le nettoyage des référentiels, la préparation des exports et les contrôles de qualité des données. Ce sont précisément les tâches que rencontrent les analystes et développeurs au quotidien.

<img src="/images/lessons/lesson11_1-string-processing.svg" alt="Traitement pratique des chaînes en SQL : nettoyage de texte, extraction de domaines e-mail et construction de champs analytiques" width="100%">

---

## Pourquoi le traitement pratique des chaînes est important

Les fonctions de chaîne de base sont utiles, mais leur vraie valeur apparaît lorsqu'on les applique à une tâche concrète. Par exemple, une même valeur d'e-mail peut servir à la vérification de qualité, à la segmentation par domaine et à la préparation d'un rapport marketing.

En pratique, le traitement de chaînes en SQL se résume souvent à quatre types de tâches :

- nettoyer le texte des espaces inutiles et des motifs répétitifs ;
- normaliser la casse et le format ;
- extraire des parties de chaîne pour l'analyse ;
- construire de nouveaux champs textuels pour les interfaces et les rapports.

---

## Approche de base du traitement des chaînes

Le plus souvent, on traite le texte par étapes :

1. d'abord nettoyer la valeur ;
2. ensuite la normaliser dans un format unique ;
3. puis extraire les parties nécessaires ;
4. enfin utiliser le résultat dans l'analyse ou le reporting.

Cette approche rend les requêtes plus prévisibles et plus simples à déboguer.

```sql
SELECT
   LOWER(TRIM(email)) AS email_normalized
FROM customer
LIMIT 5;
```

*Résultat : l'e-mail est nettoyé des espaces en bordure et converti en minuscules.*

---

## Nettoyage et normalisation du texte

Le scénario le plus courant consiste à préparer une chaîne pour une analyse ultérieure. Pour cela, on utilise généralement `TRIM()`, `LOWER()`, `UPPER()` et `REPLACE()`.

### Exemple : normalisation d'e-mail

```sql
SELECT
   customer_id,
   email,
   LOWER(TRIM(email)) AS email_normalized
FROM customer
LIMIT 10;
```

*Remarque : même si les données semblent déjà propres, la normalisation est utile pour la comparaison, le regroupement et les traitements automatiques.*

### Exemple : nettoyage d'adresses

```sql
SELECT
   address_id,
   address,
   TRIM(REPLACE(address, 'Street', 'St.')) AS address_cleaned
FROM address
LIMIT 10;
```

*Résultat : l'adresse devient plus courte et plus homogène, ce qui est pratique pour les rapports et les interfaces.*

---

## Extraction de parties utiles d'une chaîne

Après le nettoyage, il faut souvent conserver uniquement la partie utile de la chaîne pour l'analyse. En MySQL, `SUBSTRING()`, `LEFT()`, `RIGHT()` et `SUBSTRING_INDEX()` sont particulièrement pratiques.

### Exemple : extraction du domaine e-mail

```sql
SELECT
   customer_id,
   email,
   SUBSTRING_INDEX(LOWER(TRIM(email)), '@', -1) AS email_domain
FROM customer
LIMIT 10;
```

*Résultat : la partie domaine est extraite de l'e-mail, par exemple `example.com`.*

### Exemple : extraction d'un préfixe de titre de film

```sql
SELECT
   film_id,
   title,
   LEFT(title, 5) AS title_prefix,
   RIGHT(title, 5) AS title_suffix
FROM film
LIMIT 10;
```

*Remarque : ces fragments sont utiles pour des heuristiques rapides, des contrôles de convention de nommage ou la création de libellés courts.*

---

## Construction de champs textuels analytiques

En analytique, on a souvent besoin de libellés lisibles plutôt que de champs bruts. Pour cela, `CONCAT()` et `CONCAT_WS()` sont très utiles.

### Exemple : libellé client pour un rapport

```sql
SELECT
   customer_id,
   CONCAT_WS(
      ' | ',
      CONCAT_WS(' ', first_name, last_name),
      LOWER(TRIM(email)),
      CONCAT('store=', store_id)
   ) AS customer_label
FROM customer
LIMIT 10;
```

*Résultat : vous obtenez un champ texte compact, pratique pour les rapports d'administration, les exports et les outils internes.*

---

## Vérification de la qualité des données textuelles

Le traitement de chaînes ne sert pas seulement au formatage, mais aussi à la validation de base. SQL ne remplace pas un système de validation complet, mais il permet de trouver rapidement des valeurs suspectes.

### Exemple : rechercher les e-mails sans `@`

```sql
SELECT
   customer_id,
   email
FROM customer
WHERE INSTR(LOWER(TRIM(email)), '@') = 0;
```

*Résultat : la requête retourne les enregistrements où l'e-mail ne contient pas le séparateur obligatoire.*

### Exemple : vérifier la longueur des titres de films

```sql
SELECT
   film_id,
   title,
   CHAR_LENGTH(title) AS title_length
FROM film
WHERE CHAR_LENGTH(title) > 20
ORDER BY title_length DESC
LIMIT 10;
```

*Remarque : ce type de contrôle est utile pour repérer des valeurs trop longues pour des cartes, des écrans d'interface ou des limites d'export.*

---

## Exemple pratique : segmentation clients par domaine e-mail

Regroupons maintenant plusieurs techniques dans une seule requête analytique. Supposons que nous voulions identifier les domaines les plus fréquents chez les clients.

```sql
SELECT
   SUBSTRING_INDEX(LOWER(TRIM(email)), '@', -1) AS email_domain,
   COUNT(*) AS customer_count
FROM customer
WHERE email IS NOT NULL
  AND INSTR(LOWER(TRIM(email)), '@') > 0
GROUP BY SUBSTRING_INDEX(LOWER(TRIM(email)), '@', -1)
ORDER BY customer_count DESC, email_domain
LIMIT 15;
```

*Résultat : vous obtenez la distribution des clients par domaine e-mail. Cette requête est utile pour l'exploration d'audience, la détection d'anomalies et la préparation de segments de communication.*

Cet exemple illustre une idée importante : les fonctions de chaîne sont particulièrement puissantes en chaîne. On nettoie d'abord la valeur, on vérifie ensuite sa structure, on extrait le domaine, puis on agrège.

---

## Recommandations pratiques

- Normalisez le texte avant de comparer et de regrouper.
- Si une fonction est utilisée plusieurs fois dans la même requête, envisagez un `CTE` ou une sous-requête pour améliorer la lisibilité.
- `SUBSTRING_INDEX()` est pratique en MySQL, mais d'autres SGBD peuvent exiger une syntaxe différente.
- N'essayez pas de résoudre toute la logique de nettoyage en une seule ligne ; traitez le texte par étapes.

---

**Points clés de cette leçon :**

- Le traitement pratique des chaînes en SQL est nécessaire pour nettoyer, normaliser, extraire et valider les données textuelles.
- `TRIM`, `LOWER`, `REPLACE`, `SUBSTRING_INDEX`, `LEFT`, `RIGHT` et `CONCAT_WS` sont particulièrement utiles au quotidien.
- Avant l'analyse, le texte doit être normalisé dans un format cohérent, sinon les regroupements et comparaisons peuvent être erronés.
- SQL permet non seulement de formater les chaînes, mais aussi de détecter rapidement des problèmes de qualité de données.
- Le plus grand bénéfice vient de l'application séquentielle de fonctions dans un scénario de travail clair.

---

## Questions fréquentes

### Pourquoi normaliser du texte si les valeurs de la table semblent déjà correctes ?
Parce que même des données visuellement propres peuvent contenir des espaces en trop, une casse incohérente ou de petites anomalies de format. La normalisation rend le filtrage, les comparaisons et les regroupements plus fiables.

### Pourquoi extraire le domaine d'un e-mail est utile pour l'analyse ?
Le domaine permet de segmenter rapidement les utilisateurs, d'identifier des adresses d'entreprise et de repérer des anomalies. C'est un moyen simple de transformer un champ texte brut en variable analytique.

### Quand vaut-il mieux construire des champs texte en SQL plutôt que dans l'application ?
Lorsque ces champs sont nécessaires pour des rapports, des interfaces d'administration, des exports ou des analyses intermédiaires. Dans ces cas, la construction de libellés côté SQL réduit la post-traitance et rapproche la logique des données.

## Questions d'entretien

### Quels types de tâches résolvez-vous avec des fonctions de chaîne en SQL analytique ?
En général : **nettoyage du texte**, **normalisation du format**, **extraction de caractéristiques** et **validation des données**. En pratique, ces fonctions sont souvent utilisées avant les regroupements, segmentations et constructions de champs de rapport.

### Pourquoi est-il utile d'appliquer `TRIM()` et `LOWER()` avant un `GROUP BY` sur un champ texte ?
Sans normalisation, une même valeur peut se retrouver dans plusieurs groupes à cause d'une casse différente ou d'espaces superflus. Le pré-nettoyage améliore la justesse de l'agrégation et réduit les faux écarts.

### Comment expliqueriez-vous l'intérêt de `SUBSTRING_INDEX()` avec un exemple pratique ?
En MySQL, cette fonction est pratique pour **extraire rapidement une partie de chaîne selon un séparateur**. Par exemple, on peut extraire le domaine d'un e-mail et l'utiliser immédiatement pour la segmentation utilisateurs ou le reporting analytique.

Dans la prochaine leçon, nous passerons à l'utilisation de SQL pour l'analyse et le reporting, et nous verrons comment transformer des données préparées en insights métier utiles.
