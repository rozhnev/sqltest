---
title: "Requetes SQL efficaces : ecrire des requetes plus rapides et plus legeres"
description: "Des requetes SQL efficaces reduisent la charge serveur et accelerent les rapports. Apprenez le filtrage, JOIN, SARGable et LIMIT en pratique."
keywords: ["requetes SQL efficaces", "optimisation SQL", "SARGable SQL", "performance JOIN", "performance des requetes", "SQL pour analystes"]
teaches: ["Pourquoi SELECT * ralentit les requetes", "Comment filtrer plus tot pour accelerer", "Comment ecrire des conditions SARGable", "Quand utiliser EXISTS plutot que JOIN", "Comment utiliser LIMIT pendant le debogage"]
about: ["SQL", "Optimisation de requetes", "Performance base de donnees", "SARGable", "JOIN"]
---

_Lecon 10.2 · Temps de lecture : ~10 min_

Cette lecon presente les bases de l'ecriture de requetes SQL performantes. Vous allez apprendre a eviter la charge inutile sur la base, comprendre pourquoi `SELECT *` ralentit souvent l'execution, et filtrer les donnees correctement. Nous allons etudier des techniques pratiques pour accelerer les requetes sur de gros volumes. A la fin, vous saurez ecrire un SQL efficace et respectueux des ressources serveur.

# Lecon 10.2 : Ecriture de requetes SQL efficaces

Dans la lecon precedente, nous avons parle de lisibilite pour les humains. Mais une requete SQL doit aussi etre efficace pour le moteur de base de donnees. Meme un code bien formate peut etre lent s'il force le serveur a faire trop de travail.

L'efficacite d'une requete impacte directement la vitesse des applications et des rapports. Sur des systemes a forte charge, la difference entre une requete "fonctionnelle" et "optimisee" peut etre enorme.

Les SGBD modernes disposent d'optimiseurs puissants, mais ils ne connaissent pas votre logique metier et ne corrigent pas tout. La responsabilite de la qualite SQL reste cote developpeur.

<img src="/images/lessons/lesson10_2-efficient-queries.svg" alt="Schema des techniques pour accelerer les requetes SQL : filtrage, index, optimisation des JOIN et limitation des resultats" width="100%">

---

## Regle d'or : ne recuperer que le necessaire

Une cause frequente de lenteur est le transfert de donnees inutiles entre serveur et client.

### Eviter `SELECT *`

`SELECT *` est pratique pour explorer, mais il faut l'eviter dans le code final.

- **Trafic inutile :** vous envoyez des colonnes non necessaires.
- **Moins de plans index-friendly :** les index couvrants deviennent moins exploitables.
- **Code fragile :** l'ajout d'une colonne peut impacter comportement et performance.

```sql
-- Mauvais
SELECT * FROM film;

-- Mieux
SELECT film_id, title, release_year
FROM film;
```

---

## Optimisation du filtrage

La facon de limiter les lignes determine le volume de travail du SGBD.

### Filtrer le plus tot possible

Appliquez `WHERE` avant les operations lourdes. Moins de lignes en amont signifie des `JOIN` et `GROUP BY` plus rapides.

### Eviter les fonctions dans `WHERE` (requetes SARGable)

Pour profiter des index, les predicates `WHERE` doivent etre **SARGable**. Si vous appliquez une fonction sur une colonne indexee, l'optimiseur risque de ne pas utiliser l'index efficacement.

```sql
-- Lent (Non-SARGable)
SELECT count(*) 
FROM rental 
WHERE YEAR(rental_date) = 2005;

-- Rapide (SARGable)
SELECT count(*) 
FROM rental 
WHERE rental_date >= '2005-01-01' AND rental_date < '2006-01-01';
```

---

## Travail avec les `JOIN`

Les jointures sont parmi les operations les plus couteuses.

- **Filtrer avant de joindre** quand c'est possible.
- **Verifier les index** sur les cles de jointure.
- **Eviter `CROSS JOIN`** sans besoin reel.
- **Utiliser `EXISTS`** pour des verifications d'existence simples.

```sql
-- Moins efficace
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id;

-- Plus efficace pour un test d'existence
SELECT c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
    SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id
);
```

---

## Utiliser `LIMIT` pendant les tests

Pendant le debogage, utilisez `LIMIT` pour eviter de retourner des millions de lignes.

```sql
SELECT customer_id, first_name, last_name
FROM customer
WHERE active = 1
LIMIT 10;
```

---

## Exemple pratique : optimisation d'un rapport

Supposons que nous cherchions les films loues plus de 30 fois dans une categorie donnee.

**Approche moins efficace :**
```sql
SELECT f.title, COUNT(r.rental_id)
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
GROUP BY f.title
HAVING COUNT(r.rental_id) > 30;
```

**Approche plus efficace :**
Si l'ID de categorie est connu, on evite une jointure inutile.

```sql
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE fc.category_id = 1 -- Utiliser l'ID plutot que la chaine
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) > 30;
```

*Remarque : filtrer sur un identifiant numerique est souvent plus rapide que filtrer sur un libelle texte.*

---

**Points cles a retenir de cette lecon :**

*   Evitez `SELECT *` en production.
*   Filtrez les donnees le plus tot possible.
*   Ecrivez des conditions **SARGable** pour exploiter les index.
*   Preferez `EXISTS` a `JOIN` pour des tests d'existence.
*   Utilisez `LIMIT` pour l'exploration et le debug.
*   Preferez les filtres sur cles numeriques.

---

## Questions frequentes

### Pourquoi `SELECT *` est-il problematique en production ?
Il retourne des colonnes inutiles, augmente le trafic et peut degrader les plans d'execution. Lister explicitement les colonnes est plus sur.

### Que signifie SARGable en pratique ?
Une condition SARGable permet une recherche via index. Les fonctions appliquees aux colonnes indexees bloquent souvent cet avantage.

### Quand utiliser `EXISTS` plutot que `JOIN` ?
Quand vous voulez seulement verifier l'existence d'une ligne liee, sans recuperer de colonnes de la table secondaire.

## Questions d'entretien

### Quelles sont vos premieres actions face a une requete SQL lente ?
Je verifie `SELECT *`, la selectivite des filtres `WHERE`, puis les predicates non SARGable. Ensuite j'analyse les jointures et le volume de lignes traitees.

### Pourquoi filtrer tot accelere l'execution ?
Parce que cela reduit les lignes impliquees dans les jointures, tris et agregations, ce qui baisse le cout global du plan.

### Difference performance entre `JOIN` et `EXISTS` ?
`JOIN` combine les jeux de lignes et est necessaire si vous avez besoin de colonnes des deux tables. `EXISTS` est souvent plus efficace pour un simple test oui/non.

Dans la prochaine lecon, nous allons analyser l'execution plus en profondeur et voir comment les index accelerent les requetes au niveau physique.

-> [Lecon 10.3 : Comprendre les methodes d'optimisation des requetes](lesson10_3_fr.md)
