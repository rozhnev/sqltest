---
title: "Sous-requetes SQL dans WHERE: IN, EXISTS, ANY et ALL"
description: "Les sous-requetes dans WHERE permettent un filtrage dynamique des donnees. Decouvrez IN, NOT IN, EXISTS, NOT EXISTS, ANY et ALL avec Sakila."
keywords: ["SQL subquery", "WHERE", "EXISTS", "NOT EXISTS", "IN", "ANY ALL"]
teaches: ["Choisir l'operateur selon le type de resultat de sous-requete", "Utiliser correctement EXISTS et NOT EXISTS", "Comprendre la difference entre ANY et ALL"]
about: ["SQL", "Subquery", "WHERE clause", "Sakila"]
---

_Temps de lecture: ~8 minutes_

Une sous-requete dans `WHERE` permet de filtrer les lignes en s'appuyant sur le resultat intermediaire d'une autre requete. Dans cette lecon, vous verrez quand utiliser les operateurs de comparaison, `IN`, `NOT IN`, `EXISTS`, `NOT EXISTS`, `ANY` et `ALL`, et comment choisir l'option la plus sure en pratique.

# Sous-requetes dans la clause WHERE

Dans la lecon precedente, nous avons vu l'idee generale des sous-requetes. Ici, nous nous concentrons sur le cas le plus frequent: le filtrage dans `WHERE`, lorsque la requete externe depend de valeurs calculees dynamiquement.

En pratique, c'est utile partout: de la recherche de clients sans paiements jusqu'a la comparaison d'une ligne avec un ensemble de resultats.

## Sous-requetes scalaires et operateurs de comparaison

Si une sous-requete retourne exactement une valeur, on parle de sous-requete scalaire. Dans ce cas, vous pouvez utiliser les operateurs classiques `=`, `<>`, `>`, `>=`, `<`, `<=`.

**Scenario:** trouver les acteurs qui ont le meme prenom que l'acteur avec `actor_id = 10`.

```sql
SELECT
    first_name,
    last_name
FROM
    actor
WHERE
    first_name = (
        SELECT first_name
        FROM actor
        WHERE actor_id = 10
    )
    AND actor_id <> 10;
```

*Remarque: si la requete interne retourne plusieurs lignes, la requete echoue avec une erreur.*

---

## Sous-requetes multi-lignes: IN et NOT IN

Quand une sous-requete retourne une liste de valeurs (une colonne, plusieurs lignes), utilisez `IN`.

**Scenario:** trouver les films de la categorie `Action`.

```sql
SELECT
    f.title
FROM
    film AS f
WHERE
    f.film_id IN (
        SELECT
            fc.film_id
        FROM
            film_category AS fc
        WHERE
            fc.category_id = (
                SELECT
                    c.category_id
                FROM
                    category AS c
                WHERE
                    c.name = 'Action'
            )
    );
```

*Resultat: vous obtenez tous les films relies a la categorie `Action` via la table `film_category`.*

`NOT IN` fait le filtrage inverse, mais gardez un point important en tete: si le resultat de la sous-requete contient `NULL`, la condition peut produire un resultat vide inattendu. Dans ce cas, `NOT EXISTS` est souvent plus fiable.

---

## Verification d'existence: EXISTS et NOT EXISTS

`EXISTS` verifie la presence d'au moins une ligne dans la sous-requete. Le moteur peut s'arreter des la premiere correspondance, donc cette approche est souvent efficace sur de grandes tables.

### EXISTS

**Scenario:** trouver les clients qui ont au moins un paiement.

```sql
SELECT
    c.first_name,
    c.last_name
FROM
    customer AS c
WHERE
    EXISTS (
        SELECT
            1
        FROM
            payment AS p
        WHERE
            p.customer_id = c.customer_id
    );
```

*Remarque: avec `EXISTS`, on ecrit souvent `SELECT 1`, car seul le fait qu'une ligne existe est important.*

### NOT EXISTS

**Scenario:** trouver les clients qui n'ont effectue aucun paiement.

```sql
SELECT
    c.first_name,
    c.last_name
FROM
    customer AS c
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            payment AS p
        WHERE
            p.customer_id = c.customer_id
    );
```

*Resultat: seules les lignes de clients sans aucune entree correspondante dans `payment` sont retournees.*

---

## Comparaison avec un ensemble: ANY et ALL

- `ANY`: la condition est vraie si elle est satisfaite pour au moins une valeur de la sous-requete.
- `ALL`: la condition est vraie uniquement si elle est satisfaite pour toutes les valeurs de la sous-requete.

**Scenario:** comparer la duree d'un film avec les durees des films de la categorie `Comedy`.

```sql
SELECT
    f.title,
    f.length
FROM
    film AS f
WHERE
    f.length > ANY (
        SELECT
            f2.length
        FROM
            film AS f2
        INNER JOIN film_category AS fc ON f2.film_id = fc.film_id
        INNER JOIN category AS c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Comedy'
    );
```

*Resultat: le film est retenu s'il est plus long qu'au moins un film de `Comedy`.*

```sql
SELECT
    f.title,
    f.length
FROM
    film AS f
WHERE
    f.length > ALL (
        SELECT
            f2.length
        FROM
            film AS f2
        INNER JOIN film_category AS fc ON f2.film_id = fc.film_id
        INNER JOIN category AS c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Comedy'
    );
```

*Resultat: le film est retenu seulement s'il est plus long que chaque film de `Comedy`.*

---

## Points d'attention dans les requetes reelles

- Pour une seule valeur, utilisez une sous-requete scalaire avec un operateur de comparaison.
- Pour une liste de valeurs, utilisez `IN` ou `EXISTS` selon le besoin.
- Pour trouver des relations absentes, privilegiez `NOT EXISTS`, surtout si des `NULL` sont possibles.
- Verifiez toujours si la sous-requete peut retourner plus de lignes que prevu.

---

**Points cles de cette lecon:**

- `WHERE` avec sous-requete permet un filtrage dynamique sans substitution manuelle de valeurs.
- `IN` est pratique pour verifier l'appartenance a une liste de valeurs.
- `EXISTS` et `NOT EXISTS` sont efficaces pour verifier la presence ou l'absence de lignes liees.
- `ANY` et `ALL` permettent de comparer une ligne a un ensemble de valeurs.
- Le bon choix d'operateur rend les requetes plus precises, plus lisibles et plus fiables.

## Questions frequemment posees

### Que vaut-il mieux utiliser pour trouver des relations absentes: NOT IN ou NOT EXISTS?
Dans la plupart des cas pratiques, `NOT EXISTS` est plus sur. Si la sous-requete de `NOT IN` retourne `NULL`, le resultat peut devenir inattendu et filtrer trop de lignes.

### Pourquoi ecrit-on souvent SELECT 1 dans EXISTS et non SELECT *?
Parce que `EXISTS` verifie uniquement la presence de lignes. Le contenu des colonnes n'est pas utilise, donc `SELECT 1` est une forme standard et claire.

### Quand utiliser ANY et quand utiliser ALL?
Utilisez `ANY` quand la condition doit etre vraie pour au moins une valeur de la sous-requete. Utilisez `ALL` quand la condition doit etre vraie pour chaque valeur de l'ensemble.

## Questions d'entretien

### Quelle est la difference entre IN et EXISTS en SQL?
`IN` compare une valeur a une liste retournee par une sous-requete, tandis que `EXISTS` verifie la presence d'au moins une ligne correspondante. Sur de gros volumes, `EXISTS` est souvent plus performant dans des scenarios correles, car il peut s'arreter a la premiere correspondance.

### Comment expliquer la difference entre une sous-requete scalaire et une sous-requete multi-lignes?
Une **sous-requete scalaire** retourne une seule valeur et s'utilise avec des operateurs comme `=` ou `>`. Une **sous-requete multi-lignes** retourne un ensemble de valeurs et s'utilise generalement avec `IN`, `ANY` ou `ALL`.

### Pourquoi une requete avec l'operateur = et une sous-requete peut-elle echouer?
L'operateur `=` attend une seule valeur a droite. Si la sous-requete retourne plus d'une ligne, le moteur SQL ne peut pas faire une comparaison non ambigue et retourne une erreur.

Dans la prochaine lecon, nous verrons les sous-requetes correlees et comment elles sont executees ligne par ligne dans la requete externe.
