---
title: "EXPLAIN et plan d'execution : trouver les goulots d'etranglement SQL"
description: "Le plan d'execution montre comment le SGBD execute SQL. Apprenez EXPLAIN, les types d'acces et les metriques cles pour diagnostiquer les lenteurs."
keywords: ["EXPLAIN SQL", "plan d'execution", "optimisation SQL", "Full Table Scan", "index SQL", "diagnostic de requetes"]
teaches: ["Ce que montre un plan d'execution", "Comment lire la sortie EXPLAIN", "Comment detecter Full Table Scan et goulots", "Comment interpreter type, key et rows", "Comment choisir un axe d'optimisation"]
about: ["SQL", "EXPLAIN", "Plan d'execution", "Optimiseur SGBD", "Performance des requetes"]
---

_Lecon 10.3 · Temps de lecture : ~9 min_

Cette lecon presente les outils d'analyse et d'optimisation des requetes SQL. Vous allez voir comment le SGBD lit votre code, ce qu'est un plan d'execution et comment detecter les zones lentes. Nous utiliserons `EXPLAIN` et interpreterons ses champs principaux. A la fin, vous pourrez diagnostiquer les causes de lenteur de facon professionnelle.

# Lecon 10.3 : Comprendre les methodes d'optimisation des requetes

Dans la lecon precedente, nous avons vu les regles de base pour ecrire du SQL efficace. Mais si la requete reste lente, il faut analyser au lieu de supposer. A chaque execution, l'optimiseur du SGBD construit un plan.

Comprendre ce plan est la cle d'une optimisation avancee. Dans cette lecon, nous regardons la "cuisine interne" du serveur grace a l'outil principal : le plan d'execution.

<img src="/images/lessons/lesson10_3-query-optimization.svg" alt="Schema d'analyse d'un plan d'execution SQL avec EXPLAIN pour identifier les goulots de performance" width="100%">

---

## Qu'est-ce qu'un plan d'execution

Un plan d'execution est une suite d'etapes detaillees preparees par le SGBD pour executer une requete SQL. Il precise :

- L'ordre des jointures entre tables.
- Les methodes d'acces (scan de table ou recherche indexee).
- Le nombre de lignes estime a chaque etape.
- Le cout estime (`cost`) de chaque operation.

---

## Utiliser `EXPLAIN`

Dans les principaux SGBD relationnels (MySQL, PostgreSQL, MariaDB), `EXPLAIN` est la commande de reference.

### Syntaxe de base

Ajoutez `EXPLAIN` au debut de la requete :

```sql
EXPLAIN
SELECT customer_id, first_name, last_name
FROM customer
WHERE active = 1;
```

*Resultat : le SGBD retourne un tableau ou chaque ligne decrit une etape d'execution.*

---

## Points essentiels a verifier

### 1. Type d'acces (`type` ou `access_type`)

Ce champ indique comment les lignes sont lues :

- **`const` / `eq_ref`** : excellent.
- **`ref`** : tres bon.
- **`range`** : bon.
- **`index`** : moyen.
- **`ALL`** : risque de scan complet de table.

### 2. Index utilises (`key` / `possible_keys`)

On voit l'index choisi. Si `key` vaut `NULL`, aucun index adapte n'a ete retenu.

### 3. Nombre de lignes (`rows`)

C'est une estimation du volume de lignes a verifier. Plus c'est faible, plus l'execution est generalement rapide.

---

## Exemple pratique : identifier le probleme

Supposons la requete suivante :

```sql
EXPLAIN
SELECT * 
FROM payment 
WHERE payment_date = '2005-05-25 11:30:37';
```

Si `type` affiche `ALL` et `key` affiche `NULL`, l'index sur la date est absent ou non utilise.

**Direction de correction :**
En general, on cree un index sur la colonne du `WHERE`. Nous verrons le design d'index dans la prochaine lecon, mais c'est `EXPLAIN` qui revele le besoin.

---

## Techniques d'optimisation "a chaud"

1. **Optimiser les sous-requetes :** remplacer certaines sous-requetes par des `JOIN` peut ameliorer le plan.
2. **Materialisation :** pour des calculs lourds reutilises, envisager vues materialisees ou tables temporaires.
3. **Simplifier la logique :** `DISTINCT` ou `ORDER BY` inutiles peuvent bloquer de meilleures optimisations.

---

**Points cles a retenir de cette lecon :**

*   Le plan d'execution est la reference de ce que le SGBD va faire.
*   `EXPLAIN` montre comment les donnees sont reellement lues.
*   Evitez `ALL` (scan complet) sur les grandes tables.
*   `rows` aide a estimer la charge de traitement.
*   Si `key` est `NULL`, verifiez index et predicates SARGable.

---

## Questions frequentes

### Pourquoi lancer `EXPLAIN` si la requete semble deja rapide ?
Parce qu'il permet de detecter des risques avant la croissance des donnees. Une requete correcte aujourd'hui peut devenir lente demain.

### Quel est le signal le plus inquietant dans un plan ?
Sur de grandes tables, `ALL` est souvent un signal d'alerte, car il indique un scan complet.

### Pourquoi le champ `rows` est-il crucial ?
`rows` estime le volume de travail attendu. De grandes valeurs indiquent souvent ou commencer l'optimisation.

## Questions d'entretien

### Qu'est-ce qu'un plan d'execution SQL ?
C'est la strategie construite par l'**optimiseur SGBD** pour produire le resultat. On y voit l'ordre des operations, les methodes d'acces et les couts estimes.

### Quels champs EXPLAIN verifier en premier ?
Je commence par **type/access_type**, **key/possible_keys** et **rows**. Ensemble, ils donnent une vue rapide de l'utilisation des index et du cout probable.

### Comment savoir qu'un index manque en lisant EXPLAIN ?
Si `key` reste souvent `NULL` et que l'acces passe en scan, il faut reevaluer l'indexation des colonnes `WHERE` et `JOIN`.

Dans la prochaine lecon, nous passerons a l'outil le plus puissant d'acceleration : les index.

-> [Plan du cours](course.md)
