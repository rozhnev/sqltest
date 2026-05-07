---
title: "SQL JOIN expliqué : comment relier des tables en SQL"
description: "Un SQL JOIN combine des lignes de deux tables ou plus via une colonne commune. Découvrez le concept, la clause ON, les alias de tables et des exemples pratiques avec la base Sakila."
keywords: ["SQL JOIN", "jointure SQL", "comment fonctionne JOIN", "clause ON SQL", "alias de table SQL", "exemples JOIN Sakila"]
teaches: ["Ce qu'est un SQL JOIN et pourquoi il est utile", "Comment la clause ON définit la relation entre les tables", "Comment utiliser des alias de tables pour des requêtes lisibles", "Comment joindre les tables customer et payment en pratique", "Comment joindre les tables film et language en pratique"]
about: ["SQL JOIN", "INNER JOIN", "Clause ON", "Alias de table", "Base de données relationnelle", "Base de données Sakila"]
---

_Leçon 5.1 · Temps de lecture : ~8 min_

Un **SQL JOIN** combine des lignes de deux tables ou plus via une colonne commune. Dans cette leçon, vous apprendrez le concept fondamental du JOIN, comment écrire une clause `ON`, pourquoi les alias de tables sont importants, et comment interroger des données liées dans la base Sakila pas à pas.

# SQL JOIN : comment relier des tables dans une base relationnelle

Dans les bases de données relationnelles, l'information est stockée sous forme de tables liées entre elles. Pour extraire des données pertinentes, il faut savoir les relier. L'opération `JOIN` en SQL sert à cela : elle permet de combiner des lignes de deux ou plusieurs tables selon une colonne commune.

Cette leçon pose les bases pour comprendre le `JOIN`, concept clé du travail avec des données relationnelles.

## Qu'est-ce qu'un SQL JOIN et comment fonctionne-t-il ?

Un `JOIN` permet de fusionner des lignes de différentes tables en un seul jeu de résultats, selon une condition (souvent sur des colonnes clés).

Imaginez deux tables : `customer` et `payment`. La table `payment` possède une colonne `customer_id` qui indique quel client a effectué le paiement. Un `JOIN` permet de "coller" les lignes de ces deux tables pour afficher, par exemple, le nom du client à côté de chaque paiement.

**Comment ça fonctionne :**
1.  Vous indiquez les deux tables à joindre.
2.  Vous définissez la condition de jointure dans la clause `ON`, par exemple `customer.customer_id = payment.customer_id`.
3.  La base de données parcourt les lignes, trouve les paires correspondantes et forme de nouvelles lignes combinées.

**Visualisation :**
```
  Table A (customer)      Table B (payment)
  +----+-------+            +----+----------+
  | id | nom   |            | id | montant  |
  +----+-------+            +----+----------+
  | 1  | Ivan  | <-----\    | 1  | 100.00   |
  | 2  | Maria |       \--->| 1  | 50.00    |
  | 3  | Pierre|            | 3  | 200.00   |
  +----+-------+            +----+----------+
```

*Les flèches montrent comment les lignes de la table `payment` trouvent leur client correspondant dans la table `customer` grâce à l'identifiant.*

## Comment utiliser JOIN en pratique : exemples Sakila

Voyons à quoi cela ressemble dans une requête SQL réelle (base Sakila).

1.  **Liste des clients et leurs paiements :**
    Cette requête joint les tables `customer` et `payment` pour afficher le prénom et nom du client à côté de chaque paiement.
    ```sql
    SELECT
        c.first_name,
        c.last_name,
        p.amount,
        p.payment_date
    FROM
        customer AS c
    JOIN
        payment AS p ON c.customer_id = p.customer_id;
    ```
    - `JOIN payment AS p` indique qu'on joint la table `payment`.
    - `ON c.customer_id = p.customer_id` définit la relation.
    - `c` et `p` sont des **alias** pour raccourcir et clarifier la requête.

2.  **Liste des films et leur langue :**
    On joint les tables `film` et `language` pour afficher le titre de chaque film et sa langue.
    ```sql
    SELECT
        f.title,
        l.name AS language
    FROM
        film AS f
    JOIN
        language AS l ON f.language_id = l.language_id;
    ```
    Ici, la relation s'établit via la clé `language_id`.

---

**Points clés de cette leçon :**

* Un **SQL JOIN** combine des lignes de deux tables ou plus en un seul jeu de résultats.
* La **clause ON** définit comment les lignes sont reliées — généralement par des colonnes-clés.
* Les **alias de tables** (`customer AS c`) raccourcissent les requêtes et améliorent leur lisibilité.
* `JOIN` ne modifie pas les données d'origine ; il crée un jeu de résultats temporaire.
* Dans les prochaines leçons, nous détaillerons `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` et `FULL JOIN`.

→ [Leçon 5.2 : INNER JOIN — Combiner les lignes correspondantes](/fr/lesson/joins/inner-join)

---

## Foire aux questions

### Quelle est la différence entre JOIN et INNER JOIN ?
En SQL, `JOIN` seul est un raccourci pour `INNER JOIN`. Les deux produisent des résultats identiques. La forme explicite `INNER JOIN` est souvent préférée pour la clarté, surtout quand on mélange différents types de jointures dans une même requête.

### Que se passe-t-il si la clause ON ne trouve aucune correspondance ?
Si aucune ligne ne satisfait la condition ON, un `INNER JOIN` renvoie un jeu de résultats vide. Aucune erreur n'est levée — la requête retourne simplement zéro lignes. Les autres types de jointures (`LEFT JOIN`, etc.) traitent les lignes sans correspondance différemment.

### Peut-on joindre plus de deux tables dans une seule requête ?
Oui. On peut chaîner plusieurs clauses `JOIN` dans une même requête, chacune avec sa propre condition `ON`. La base de données les traite de gauche à droite, en construisant progressivement le jeu de résultats.

---

## Questions d'entretien

### Comment expliquer JOIN à un collègue non technique ?
Un **JOIN** revient à utiliser un identifiant commun pour croiser des informations entre deux tableurs. Par exemple, si un tableur liste des clients avec des ID et un autre liste des paiements avec l'ID client, un JOIN permet de voir le nom du client à côté de chaque paiement — sans dupliquer les données.

### À quoi sert la clause ON et pourquoi est-elle obligatoire ?
La **clause ON** spécifie la condition qui relie les lignes des deux tables. Sans elle (ou sans condition valide), la base produirait un produit cartésien — chaque ligne de la première table avec chaque ligne de la seconde — ce qui est rarement utile et potentiellement très volumineux.

### Pourquoi utiliser des alias de tables dans les requêtes JOIN ?
Les **alias de tables** évitent toute ambiguïté lorsque deux tables ont des colonnes de même nom (p. ex. `id`). Ils permettent d'écrire `c.id` vs `p.id`, ce qui est clair pour le lecteur comme pour la base de données.
