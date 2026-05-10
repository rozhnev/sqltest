---
title: "Valeurs NULL dans les bases relationnelles : sens, IS NULL et logique"
description: "Découvrez ce que signifie NULL dans les bases relationnelles, en quoi il diffère de 0 et d'une chaîne vide, et comment fonctionnent IS NULL, IS NOT NULL et les calculs."
keywords: ["NULL bases relationnelles", "IS NULL", "IS NOT NULL", "NULL et chaîne vide", "NULL logique SQL", "données manquantes"]
teaches: ["Ce que signifie NULL dans une base relationnelle", "Comment NULL se distingue de 0, d'une chaîne vide et de false", "Pourquoi les bases utilisent NULL", "Comment fonctionnent IS NULL et IS NOT NULL", "Comment NULL se comporte dans les calculs et comparaisons"]
about: ["NULL", "IS NULL", "IS NOT NULL", "Base de données relationnelle", "Données manquantes", "Logique ternaire"]
---

_Leçon 1.5 · Temps de lecture : ~7 min_

NULL est le marqueur spécial qu'une base relationnelle utilise lorsqu'une valeur est absente, inconnue ou non applicable. Dans cette leçon, vous allez comprendre ce que signifie réellement NULL, en quoi il diffère des valeurs ordinaires, et comment l'utiliser correctement dans les tests et les requêtes simples.

# Valeurs NULL dans les bases relationnelles : sens, IS NULL et logique

Dans les leçons précédentes, nous avons vu les concepts relationnels et les types de données. Il faut maintenant comprendre ce qui se passe lorsqu'une colonne ne contient pas de valeur exploitable.

<img src="/images/lessons/lesson1_5-sql.jpg" alt="Illustration montrant NULL comme une valeur absente ou inconnue dans des colonnes de base de données relationnelle" width="100%">

## Que signifie NULL dans une base relationnelle ?

**NULL** n'est pas une valeur ordinaire. C'est un marqueur spécial qui indique à la base de données qu'une valeur est absente, inconnue ou non applicable.

Cela est important, car NULL ne se comporte ni comme un texte, ni comme un nombre, ni comme un booléen. Il suit ses propres règles dans les comparaisons, les filtres et les calculs.

## Ce que NULL n'est pas

Pour éviter les confusions, retenez que NULL **n'est pas** :

* **NULL n'est pas 0** : zéro est une vraie valeur numérique.
* **NULL n'est pas une chaîne vide** : `''` reste une valeur texte, même sans caractère.
* **NULL n'est pas false** : dans la logique des bases de données, NULL signifie généralement **inconnu**.

## Pourquoi les bases utilisent-elles NULL ?

Les bases de données utilisent NULL lorsqu'une valeur ne peut pas être remplie normalement.

Cas typiques :

* **Information inconnue** : par exemple, on ne connaît pas encore le deuxième prénom d'un client.
* **Non applicable** : un identifiant fiscal d'entreprise ne s'applique pas à une personne physique.
* **Donnée manquante** : une information a été oubliée lors de la saisie.

## Comment fonctionnent IS NULL et IS NOT NULL ?

Comme NULL représente un état inconnu, les opérateurs de comparaison standard comme `=` et `<>` ne fonctionnent pas correctement avec lui.

Par exemple, `valeur = NULL` ne renverra pas vrai. Pour tester NULL correctement, il faut utiliser des opérateurs dédiés.

### IS NULL

`IS NULL` sert à trouver les lignes où une colonne ne contient pas de valeur :

```sql
SELECT *
FROM address
WHERE address2 IS NULL;
```

### IS NOT NULL

`IS NOT NULL` sert à trouver les lignes où une colonne contient une valeur :

```sql
SELECT *
FROM address
WHERE address2 IS NOT NULL;
```

## Comment NULL se comporte-t-il dans les calculs et la logique ?

L'une des règles les plus importantes est que **NULL se propage souvent**. Si NULL participe à un calcul, le résultat devient généralement NULL.

* `10 + NULL = NULL`
* `5 * NULL = NULL`
* `'Bonjour ' + NULL = NULL`

La même idée vaut pour les comparaisons. Comme NULL signifie « inconnu », beaucoup d'expressions contenant NULL ne renvoient ni vrai ni faux, mais un résultat inconnu.

---

**Points clés de cette leçon :**

* `NULL` représente des données absentes, inconnues ou non applicables.
* `NULL` est différent de zéro, d'une chaîne vide et de false.
* Les comparaisons standard comme `=` et `<>` ne conviennent pas pour tester NULL.
* Utilisez `IS NULL` et `IS NOT NULL` pour vérifier NULL correctement.
* Les calculs impliquant NULL donnent souvent NULL comme résultat.

---

## Foire aux questions

### NULL est-il la même chose qu'une chaîne vide ?
Non. Une chaîne vide reste une valeur texte de longueur nulle. `NULL` signifie qu'aucune valeur connue n'est stockée.

### Pourquoi `valeur = NULL` ne fonctionne-t-il pas ?
Parce que NULL signifie « inconnu », et les opérateurs de comparaison classiques ne sont pas conçus pour tester cet état. Il faut utiliser `IS NULL`.

### NULL peut-il apparaître dans une colonne numérique ?
Oui. NULL n'est pas limité à un type de données particulier. Une colonne numérique, texte ou date peut contenir NULL si aucune contrainte ne l'interdit.

## Questions d'entretien

### Comment expliqueriez-vous NULL en entretien ?
NULL est un marqueur spécial représentant une donnée absente, inconnue ou non applicable. Ce n'est ni zéro, ni false, ni une chaîne vide, et il suit des règles particulières dans les comparaisons et les calculs.

### Pourquoi utilise-t-on IS NULL au lieu de = NULL ?
Parce que NULL représente un état inconnu. Les opérateurs `=` et `<>` travaillent avec des valeurs ordinaires, alors que SQL fournit `IS NULL` et `IS NOT NULL` pour tester correctement cet état.

### Quelle erreur revient souvent quand on travaille avec NULL ?
Une erreur fréquente consiste à traiter NULL comme une valeur normale dans les filtres, conditions ou calculs. Cela produit souvent des résultats inattendus dans les requêtes.

Dans la prochaine leçon, nous introduirons SQL lui-même et la structure de base d'une requête.
