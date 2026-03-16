Apprenez à utiliser SQL SELF JOIN pour joindre une table à elle-même. Cette leçon couvre le concept des données hiérarchiques, l'utilisation des alias pour distinguer les différentes instances d'une table, ainsi que des exemples pratiques, comme la recherche de paires d'enregistrements partageant les mêmes attributs. Maîtrisez des techniques avancées de jointure SQL pour gérer des relations de données complexes.

# Leçon 5.7 : SELF JOIN — joindre une table à elle-même

Un **SELF JOIN** n'est pas un type de jointure distinct. Il s'agit en réalité d'une jointure classique, généralement un `INNER JOIN` ou un `LEFT JOIN`, dans laquelle une table est jointe avec elle-même. Cette technique est utile pour interroger des données hiérarchiques ou pour comparer des lignes au sein d'une même table.

## Qu'est-ce qu'un SELF JOIN ?

Pour effectuer une self join, vous devez traiter une même table comme s'il s'agissait de deux tables différentes. Pour cela, vous **devez utiliser des alias de table** afin de donner un nom unique à chaque instance de la table. Sans alias, la base de données ne saura pas à quelle instance appartient chaque colonne.

**Visualisation (hiérarchie des employés) :**
Imaginez une table `employee` dans laquelle chaque ligne contient un `manager_id` pointant vers le `employee_id` de son supérieur.

```
   Table A (Employés)           Table B (Managers)
   +----+-------+---------+     +----+-------+
   | id | name  | mgr_id  |     | id | name  |
   +----+-------+---------+     +----+-------+
   | 1  | Alice | NULL    |     | 1  | Alice |
   | 2  | Bob   | 1       | <-> | 1  | Alice | (La manager de Bob est Alice)
   | 3  | Carol | 1       | <-> | 1  | Alice | (La manager de Carol est Alice)
   +----+-------+---------+     +----+-------+
```

## Syntaxe du SELF JOIN

```sql
SELECT
    e.name AS employee_name,
    m.name AS manager_name
FROM
    employee AS e
LEFT JOIN
    employee AS m ON e.manager_id = m.id;
```

- `employee AS e` : la première instance de la table, qui représente les employés.
- `employee AS m` : la deuxième instance, qui représente les managers.
- `ON e.manager_id = m.id` : la condition qui relie les deux instances.

## Exemples pratiques (base de données Sakila)

### 1. Trouver des films ayant la même durée
Supposons que nous voulions trouver des paires de films ayant exactement la même durée (`length`). Nous pouvons joindre la table `film` à elle-même.

```sql
SELECT
    f1.title AS film_1,
    f2.title AS film_2,
    f1.length
FROM
    film AS f1
INNER JOIN
    film AS f2 ON f1.length = f2.length
WHERE
    f1.film_id <> f2.film_id -- Évite d'associer un film avec lui-même
LIMIT 10;
```

*La condition `f1.film_id <> f2.film_id` est essentielle. Sans elle, chaque film correspondrait à lui-même, puisqu'un film a évidemment la même durée que lui-même.*

### 2. Trouver des clients habitant dans la même ville
Si nous voulons voir quels clients habitent dans la même ville, en nous basant sur `address_id` dans cet exemple simplifié :

```sql
SELECT
    c1.first_name AS cust_1_first,
    c1.last_name AS cust_1_last,
    c2.first_name AS cust_2_first,
    c2.last_name AS cust_2_last,
    c1.address_id
FROM
    customer AS c1
INNER JOIN
    customer AS c2 ON c1.address_id = c2.address_id
WHERE
    c1.customer_id < c2.customer_id; -- Utilise '<' au lieu de '<>' pour éviter les doublons (A-B et B-A)
```

## Points clés de cette leçon

- Un **SELF JOIN** est une table jointe avec elle-même.
- Les **alias de table** sont indispensables pour distinguer les deux instances de la même table.
- Utilisez les conditions `ON` pour définir la relation entre les lignes, par exemple une hiérarchie ou des attributs partagés.
- Utilisez des filtres dans `WHERE`, comme `id1 <> id2` ou `id1 < id2`, afin d'éviter d'associer une ligne avec elle-même ou de retourner des paires en double.
