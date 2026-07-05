---
title: "Vues SQL (VIEW) : creation, utilisation et cas pratiques"
description: "Apprenez les vues SQL : syntaxe CREATE VIEW, differences avec les tables classiques et temporaires, mises a jour et exemples pratiques avec Sakila."
keywords: ["SQL VIEW", "vue SQL", "CREATE VIEW", "table virtuelle", "Sakila"]
teaches: ["Creer et interroger des vues avec CREATE VIEW", "Distinguer VIEW, table classique et table temporaire", "Reutiliser une logique SQL complexe via des vues"]
about: ["SQL", "VIEW", "Database design", "Sakila"]
---

_Temps de lecture : ~8 minutes_

Cette leçon présente les vues (`VIEW`), des objets SQL qui permettent d’enregistrer une requête sous un nom puis de l’utiliser comme s’il s’agissait d’une table classique. Vous découvrirez comment créer des vues, en quoi elles diffèrent des tables et des tables temporaires, et dans quels cas elles sont particulièrement utiles. À la fin de cette leçon, vous saurez utiliser les vues avec assurance pour simplifier des requêtes complexes et réutiliser une même logique.

# Vues (`VIEW`) en SQL

Dans la leçon précédente, nous avons parlé des tables temporaires, qui aident à conserver des résultats intermédiaires pendant une session. Examinons maintenant un autre outil important de SQL : les **vues**. Elles aussi simplifient le travail avec des requêtes complexes, mais d’une autre manière.

Une vue permet d’enregistrer une requête `SELECT` sous un nom distinct, puis de la réutiliser ensuite. C’est particulièrement utile dans les rapports, l’analyse de données et les scénarios où le même jeu de résultats doit être consulté plusieurs fois.

<img src="/images/lessons/lesson9_4-sql-view.svg" alt="SQL Views" width="100%">

## Qu’est-ce qu’une vue

Une vue (`VIEW`) est un objet de base de données qui stocke non pas les données elles-mêmes, mais la requête SQL servant à les obtenir.

Autrement dit, on peut considérer une vue comme une « table virtuelle » :

- elle possède un nom ;
- on peut l’interroger avec `SELECT` ;
- elle présente généralement des données issues d’une ou plusieurs tables ;
- elle permet de masquer une logique de requête complexe derrière une interface plus simple.

Lorsque vous interrogez une vue, le SGBD exécute généralement la requête enregistrée et renvoie le résultat actuel à partir des tables sources.

## Syntaxe de base

Une vue se crée avec `CREATE VIEW` :

```sql
CREATE VIEW view_name AS
SELECT column1, column2, column3
FROM table_name
WHERE condition;
```

Ensuite, vous pouvez interroger la vue presque comme une table :

```sql
SELECT *
FROM view_name;
```

Il est important de comprendre qu’une vue classique stocke la logique de la requête, et non une copie distincte du résultat.

Si une vue n’est plus nécessaire, vous pouvez la supprimer avec `DROP VIEW` :

```sql
DROP VIEW view_name;
```

Dans de nombreux SGBD, vous pouvez utiliser `DROP VIEW IF EXISTS view_name;` pour supprimer l’objet uniquement s’il existe et éviter des erreurs dans les scripts de deploiement.

## Exemple de création d’une vue

Supposons que nous voulions souvent obtenir la liste des clients avec le montant total de leurs paiements. Au lieu d’écrire la même requête à chaque fois, nous pouvons créer une vue :

```sql
CREATE VIEW customer_payment_summary AS
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_amount,
       COUNT(p.payment_id) AS payment_count
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

Cette logique devient alors beaucoup plus simple à réutiliser :

```sql
SELECT customer_id, first_name, last_name, total_amount
FROM customer_payment_summary
ORDER BY total_amount DESC;

SELECT AVG(total_amount) AS avg_customer_revenue
FROM customer_payment_summary;
```

*Résultat : l’agrégation complexe est définie une seule fois dans la vue, puis vous pouvez travailler avec elle comme avec un jeu de données classique dans plusieurs requêtes distinctes.*

---

## En quoi une vue diffère d’une table classique

Même si une vue ressemble souvent à une table, il existe entre elles des différences importantes.

### 1. Stockage des données

- **Une table classique** stocke physiquement les données.
- **Une vue** stocke généralement uniquement la requête SQL.

### 2. Source du résultat

- **Une table classique** contient ses propres lignes.
- **Une vue** présente des données obtenues à partir d’autres tables ou même d’autres vues.

### 3. Actualité des données

- **Une table classique** ne change qu’après `INSERT`, `UPDATE` ou `DELETE`.
- **Une vue** montre généralement l’état actuel des tables sources au moment de l’exécution de la requête.

### 4. Finalité

- **Une table classique** sert à stocker des données métier.
- **Une vue** sert à simplifier la lecture, la réutilisation et l’organisation logique des requêtes.

### 5. Modification des données

- **Une table classique** est directement destinée à l’insertion, à la mise à jour et à la suppression de lignes.
- **Une vue** peut, dans certains cas, aussi permettre la modification des données, mais cela dépend du SGBD utilisé et de la complexité de la requête à l’intérieur de la `VIEW`.

---

## Quand les vues sont particulièrement utiles

Il est utile d’utiliser des vues si :

- la même requête doit être répétée de nombreuses fois ;
- vous voulez masquer des `JOIN`, filtres et agrégations complexes derrière un nom plus simple ;
- vous voulez donner aux utilisateurs ou aux rapports accès non pas à toute la table, mais seulement aux colonnes et lignes nécessaires ;
- vous voulez rendre le SQL analytique plus lisible et plus facile à maintenir.

Par exemple, vous pouvez créer une vue contenant uniquement les films coûteux :

```sql
CREATE VIEW expensive_films AS
SELECT film_id, title, rental_rate, rating
FROM film
WHERE rental_rate >= 4.00;

SELECT title, rental_rate
FROM expensive_films
ORDER BY rental_rate DESC, title;
```

*Résultat : la logique principale de filtrage est enregistrée à un seul endroit, et dans les requêtes suivantes il n’est plus nécessaire de répéter à chaque fois la condition `WHERE rental_rate >= 4.00`.*

---

## Vue et table temporaire

Les vues et les tables temporaires peuvent résoudre des besoins similaires, mais il existe entre elles des différences importantes.

- **Une table temporaire** existe généralement pendant une durée limitée et stocke séparément les données intermédiaires.
- **Une vue** est généralement un objet permanent du schéma et ne stocke que la requête.
- **Une table temporaire** est pratique lorsque vous devez conserver physiquement un résultat intermédiaire pour plusieurs étapes.
- **Une vue** est pratique lorsque vous devez réutiliser de nombreuses fois la même logique de sélection.
- **Une table temporaire** est plus souvent utilisée à l’intérieur d’un processus de traitement de données.
- **Une vue** est plus souvent utilisée comme une couche d’accès nommée et pratique au-dessus des données.

Si vous avez besoin d’un résultat intermédiaire qui doit exister séparément et éventuellement être retraité ensuite, une table temporaire est souvent plus adaptée. Si vous devez simplement définir une représentation pratique au-dessus de données existantes, `VIEW` est généralement un meilleur choix.

---

## Peut-on modifier des données via une vue

Dans de nombreux SGBD, les vues simples peuvent servir non seulement à lire, mais aussi à modifier des données. Par exemple, cela peut être possible si la vue repose sur une seule table et ne contient ni agrégats complexes, ni `GROUP BY`, ni `DISTINCT`, ni jointures entre plusieurs tables.

Par exemple, une vue simple peut ressembler à ceci :

```sql
CREATE VIEW active_customers_basic AS
SELECT customer_id, first_name, last_name, active
FROM customer
WHERE active = 1;
```

Dans certains SGBD, il est possible d’exécuter `UPDATE` via une telle vue. Mais il ne faut pas considérer cela comme une règle universelle : plus la logique de la vue est complexe, moins elle a de chances d’être modifiable.

En pratique, les vues sont plus souvent utilisées pour la lecture et la simplification des requêtes.

---

## Points d’attention

Lors du travail avec des vues, il est utile de garder plusieurs règles à l’esprit :

- donnez aux vues des noms clairs qui reflètent leur sens ;
- ne cachez pas trop de logique dans une seule vue si cela la rend difficile à lire ;
- rappelez-vous que les performances d’une requête sur une vue dépendent de la requête qu’elle contient et des tables sources ;
- ne supposez pas automatiquement qu’une vue prend en charge `INSERT`, `UPDATE` ou `DELETE` ;
- vérifiez si, dans une tâche donnée, un simple `SELECT`, un CTE ou une table temporaire ne serait pas plus simple ;
- tenez compte des particularités de votre SGBD, comme `CREATE OR REPLACE VIEW` ou les règles de mise à jour des vues.

Une vue bien conçue rend le SQL plus court, plus clair et plus facile à réutiliser.

---

## Exemple pratique

Imaginons que les analystes aient régulièrement besoin d’une liste de films avec le nom de leur catégorie. Au lieu d’écrire les mêmes `JOIN` à chaque fois, vous pouvez créer une vue :

```sql
CREATE VIEW film_category_details AS
SELECT f.film_id,
       f.title,
       f.rental_rate,
       c.name AS category_name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;
```

Après cela, chaque requête devient plus simple :

```sql
SELECT title, category_name, rental_rate
FROM film_category_details
WHERE category_name = 'Comedy'
ORDER BY rental_rate DESC, title;

SELECT category_name, COUNT(*) AS film_count
FROM film_category_details
GROUP BY category_name
ORDER BY film_count DESC;
```

Cette approche est pratique, car la relation complexe entre les tables est définie une seule fois. Ensuite, les analystes, les rapports et les applications peuvent utiliser une couche logique prête à l’emploi sans répéter en permanence la même logique de `JOIN`.

---

## Questions frequentes

### Une vue stocke-t-elle les donnees ou seulement la requete ?
Dans le cas standard, une `VIEW` stocke seulement la definition SQL et non une copie separee des lignes. Au moment de l execution, le SGBD calcule le resultat a partir des tables sources.

### Quand choisir une vue plutot qu une table temporaire ?
Une `VIEW` convient mieux quand vous devez reutiliser la meme logique de lecture plusieurs fois. Une table temporaire convient mieux quand vous devez conserver physiquement un resultat intermediaire sur plusieurs etapes.

### Une vue ameliore-t-elle automatiquement les performances ?
Pas automatiquement. Les performances dependent de la requete definie dans la `VIEW`, des index des tables sources et du plan d execution.

---

## Questions d entretien

### Qu est-ce qu une vue SQL et comment fonctionne-t-elle ?
Une vue est une requete SQL nommee enregistree comme objet du schema. Quand vous executez un `SELECT` dessus, le SGBD evalue sa definition et renvoie un resultat de type table virtuelle.

### Quelle est la difference entre une vue et une table classique ?
Une table classique stocke les donnees physiquement. Une vue stocke en general la logique de requete et sert a simplifier l acces et la reutilisation des requetes complexes.

### Dans quels cas une vue peut-elle etre modifiable ?
En general, lorsqu elle repose sur une seule table sans `GROUP BY`, agregats, `DISTINCT` ni jointures complexes. Les regles exactes dependent du SGBD.

---

**Points clés de cette leçon :**

*   Une vue (`VIEW`) stocke une requête SQL plutôt qu’une copie distincte des données.
*   Vous pouvez interroger une vue comme une table, ce qui facilite la réutilisation d’une logique complexe.
*   Les vues sont particulièrement utiles pour les rapports, l’analyse et pour masquer des `JOIN` et filtres complexes.
*   Contrairement aux tables temporaires, les vues sont généralement des objets permanents du schéma et ne sont pas destinées au stockage de données intermédiaires.
*   Toutes les vues ne prennent pas en charge la modification des données, et cela dépend du SGBD et de la structure de la requête.
*   Les performances d’une vue dépendent de l’efficacité de la requête qu’elle contient.

Dans la prochaine leçon, nous verrons les vues matérialisées et comprendrons en quoi elles diffèrent des vues classiques.