---
title: "Lisibilite du code SQL : bonnes pratiques de formatage et de maintenance"
description: "Un SQL lisible accelere les revues et reduit les erreurs. Apprenez les regles de formatage, de nommage et de commentaires pour maintenir des requetes complexes."
keywords: ["lisibilite SQL", "bonnes pratiques SQL", "formatage SQL", "conventions de nommage SQL", "SQL maintenable", "SQL pour analystes"]
teaches: ["Pourquoi les standards SQL sont importants en equipe", "Comment formater les requetes pour mieux les lire", "Comment choisir des noms et alias clairs", "Quand et comment commenter du code SQL", "Comment rendre des requetes complexes maintenables"]
about: ["SQL", "Lisibilite du code", "Maintenance du code", "Formatage SQL", "Revue de code"]
---

_Lecon 10.1 · Temps de lecture : ~9 min_

Cette lecon presente les bases pour ecrire un code SQL de qualite, facile a lire et a maintenir. Vous allez apprendre les standards de formatage, les regles de nommage des objets et l'utilisation des commentaires. Nous verrons comment rendre des requetes complexes plus claires pour vos collegues et pour vous-meme dans le futur. A la fin de cette lecon, vous saurez structurer vos scripts SQL de facon professionnelle et coherente.

# Lecon 10.1 : Bonnes pratiques pour un code SQL lisible et maintenable

Dans le module precedent, nous avons etudie des outils avances, comme les vues et les tables temporaires. Maintenant que vos requetes deviennent plus longues et plus complexes, la qualite du code devient prioritaire. En pratique, le code SQL est lu beaucoup plus souvent qu'il n'est ecrit.

Un code bien structure reduit les erreurs, simplifie le debogage et fait gagner du temps a toute l'equipe. Ce n'est pas seulement une question de style : c'est une competence essentielle pour tout developpeur SQL ou analyste de donnees.

<img src="/images/lessons/lesson10_1-code-readability.svg" alt="Comparaison entre une requete SQL non structuree et une requete bien formatee pour la lisibilite" width="100%">

---

## Pourquoi le style du code est important

Quand une requete contient 5 a 10 lignes, sa logique est souvent evidente. Mais avec des rapports complexes qui utilisent plusieurs `JOIN`, des sous-requetes ou des `CTE`, le code peut devenir charge et difficile a relire, meme pour son auteur quelques jours plus tard.

Le respect de standards vous aide a :

- **Trouver plus vite les erreurs :** un filtre incorrect ou un `JOIN` oublie se voit plus facilement.
- **Faire evoluer les solutions :** un code structure est plus simple a completer avec de nouveaux champs ou conditions.
- **Mieux collaborer :** les collegues peuvent faire la revue et maintenir les scripts avec moins de friction.

---

## Formatage et indentation

Un style de formatage coherent est la base de la lisibilite. SQL n'est pas sensible aux espaces ou a la casse, mais certaines conventions sont largement adoptees.

### Casse des mots-cles

Il est recommande d'ecrire les mots-cles SQL (`SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`) en **majuscules**. Cela separe visuellement les commandes SQL des noms de tables et de colonnes.

```sql
-- Mauvais
select name, price from products where category_id = 1;

-- Mieux
SELECT name, price
FROM products
WHERE category_id = 1;
```

### Retours a la ligne et indentation

Chaque clause principale doit commencer sur une nouvelle ligne. Si `SELECT` ou `GROUP BY` contient beaucoup de colonnes, placez chaque colonne sur sa propre ligne.

```sql
SELECT 
    customer_id,
    first_name,
    last_name,
    email
FROM customer
WHERE active = 1
ORDER BY last_name;
```

---

## Conventions de nommage

Bien choisir les noms de tables, colonnes et variables est essentiel pour garder un code clair.

### Minuscule et snake_case

En SQL, la convention la plus courante est d'utiliser les **minuscules** et des underscores pour separer les mots. Plusieurs SGBD normalisent differemment la casse des identifiants, et `snake_case` limite les ambiguitees.

- **Mauvais :** `CustomerOrders`, `TotalAmount`
- **Mieux :** `customer_orders`, `total_amount`

### Prefixes selon le type d'objet

Certaines equipes utilisent des prefixes pour identifier rapidement le type d'objet.

Exemples :
- `v_` pour les vues : `v_active_customers`
- `tmp_` pour les tables temporaires : `tmp_monthly_report`
- `t_` pour les tables de base (moins courant)

```sql
-- On voit tout de suite qu'il s'agit d'une vue preparee
SELECT * 
FROM v_customer_payment_summary
WHERE total_amount > 100;
```

---

## Nommage et alias

Des noms et alias clairs rendent une requete auto-documentee.

### Alias de table explicites

Utilisez des alias courts mais explicites, surtout avec `JOIN`. Evitez `t1`, `t2`, `a`, `b`.

```sql
-- Peu clair
SELECT 
    t1.name, 
    t2.amount
FROM table_a t1
JOIN table_b t2 ON t1.id = t2.ref_id;

-- Clair
SELECT 
    c.first_name, 
    p.amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id;
```

### Alias explicites pour les champs calcules

Donnez toujours des noms explicites aux agregats et colonnes calculees. Une colonne `count(*)` dans un rapport parait peu professionnelle.

```sql
SELECT 
    category_id,
    COUNT(*) AS total_films_in_category,
    AVG(replacement_cost) AS average_replacement_cost
FROM film
GROUP BY category_id;
```

---

## Commenter le code SQL

Les commentaires expliquent *pourquoi* une logique existe quand l'intention n'est pas evidente.

- **Commentaires ligne (`--`) :** pour expliquer un filtre ou une formule precise.
- **Commentaires bloc (`/* ... */`) :** pour documenter le but du script, l'auteur et la date.

```sql
/*
  Script: Monthly active customer spending
  Author: Ivanov I.
  Date: 2026-04-16
*/

SELECT 
    customer_id,
    SUM(amount) AS monthly_spent
FROM payment
WHERE payment_date >= '2026-01-01' -- Filter from start of year
  AND payment_date < '2026-02-01'
GROUP BY customer_id;
```

---

## Exemple pratique : nettoyer une requete desordonnee

Comparons une version difficile a lire et une version maintenable.

**Avant (difficile a lire) :**
```sql
select f.title,c.name,count(r.rental_id) from film f join film_category fc on f.film_id=fc.film_id join category c on fc.category_id=c.category_id join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id group by f.title,c.name having count(r.rental_id)>30 order by count(r.rental_id) desc;
```

**Apres (facile a maintenir) :**
```sql
SELECT 
    f.title,
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
JOIN inventory i      ON f.film_id = i.film_id
JOIN rental r         ON i.inventory_id = r.inventory_id
GROUP BY f.title, c.name
HAVING COUNT(r.rental_id) > 30
ORDER BY rental_count DESC;
```

*Remarque : dans la seconde version, la structure des relations, les agregats et les filtres sont immediatement lisibles.*

---

**Points cles a retenir de cette lecon :**

*   Ecrivez les mots-cles SQL en majuscules pour rendre la structure visible.
*   Utilisez des retours a la ligne et une indentation coherente pour les longues requetes.
*   Donnez des alias explicites aux tables et aux champs calcules.
*   Appliquez des conventions de nommage stables comme `snake_case`.
*   Commentez les regles metier non evidentes et les filtres complexes.
*   Maintenez un style commun dans l'equipe pour accelerer revue, debug et evolutions.

---

## Questions frequentes

### Faut-il toujours ecrire les mots-cles SQL en majuscules ?
Il n'y a pas d'obligation technique. Le SGBD comprend aussi les minuscules. Mais un style coherent (`SELECT`, `FROM`, `WHERE`, `JOIN`) ameliore la lisibilite.

### Quand les commentaires SQL sont-ils vraiment utiles ?
Ils sont surtout utiles quand la logique n'est pas evidente : regles metier, filtres atypiques, contraintes techniques. Si le code est deja clair, evitez les commentaires superflus.

### Qu'est-ce qui compte le plus pour la maintenance : formatage ou nommage ?
Les deux. Le formatage montre la structure, et le nommage rend l'intention claire sans explication supplementaire.

## Questions d'entretien

### Quelles caracteristiques definissent un SQL maintenable ?
Un SQL maintenable a un formatage coherent, des noms clairs, des alias explicites et des commentaires concis dans les zones non evidentes. Il est plus simple a relire et a faire evoluer.

### Pourquoi un mauvais nommage devient-il un probleme d'equipe ?
Des noms ambigus ralentissent les revues et augmentent les risques d'erreur pendant les modifications. De bons noms reduisent la charge cognitive.

### Comment ameliorer une requete SQL desordonnee en pratique ?
Commencez par separer la requete en blocs (`SELECT`, `FROM`, `JOIN`, `WHERE`, `GROUP BY`, `ORDER BY`) avec une indentation propre. Ensuite, remplacez les alias ambigus et nommez clairement les champs calcules.

Dans la prochaine lecon, nous passerons a l'optimisation technique pour ecrire des requetes SQL a la fois propres et rapides.

-> [Lecon 10.2 : Ecriture de requetes SQL efficaces](lesson10_2_fr.md)
