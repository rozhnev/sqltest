---
title: "Applications des CTE récursifs en SQL : Données hiérarchiques, nomenclatures, Organigrammes"
description: "Apprenez les CTE récursifs en SQL pour résoudre des problèmes pratiques. Travaillez avec des hiérarchies, des structures de catégories, des graphes organisationnels, des systèmes de menu et la recherche de chemins. Guide complet avec exemples."
keywords: "CTE récursif, hiérarchie SQL, arbre de catégories, nomenclature, organigramme, recherche de chemin, structure de menu, requête SQL récursive, WITH RECURSIVE"
lang: "fr"
region: "FR, BE, CH, CA, AF"
---

# Leçon 6.6 : Application des CTE récursifs aux problèmes du monde réel

Dans la leçon précédente, nous avons exploré les CTE ordinaires (non-récursifs)—un outil pour organiser et structurer les requêtes SQL. Maintenant, nous passons à leur variante la plus puissante : **les CTE récursifs**.

Les CTE récursifs vous permettent de travailler avec des structures de données hiérarchiques, arborescentes et réticulaires. Ils résolvent de nombreux problèmes du monde réel qui nécessitaient traditionnellement du code procédural ou des procédures stockées complexes.

<img src="/images/lessons/lesson6_6_recursive-cte.jpg" alt="Recursive CTE" width="100%">

## Qu'est-ce qu'un CTE récursif ?

Un **CTE récursif** est un CTE qui se référence lui-même, vous permettant de traverser des structures hiérarchiques niveau par niveau.

La structure d'un CTE récursif :

```sql
WITH RECURSIVE nom_cte AS (
    -- MEMBRE D'ANCRAGE (cas de base)
    SELECT ... 
    WHERE condition_ancrage
    
    UNION ALL
    
    -- MEMBRE RÉCURSIF (comment passer au niveau suivant)
    SELECT ...
    FROM nom_cte
    WHERE condition_arrêt
)
SELECT * FROM nom_cte;
```

**Composants clés :**
1. **Membre d'ancrage** — le point de départ de la récursion (généralement les enregistrements racine)
2. **UNION ALL** — combine les résultats de l'ancrage et de la récursion
3. **Membre récursif** — comment passer d'un niveau à l'autre
4. **Condition d'arrêt** — quand arrêter la récursion

## Exemple 1 : Hiérarchie de catégories

L'une des applications les plus courantes consiste à travailler avec des hiérarchies de catégories de produits dans le commerce électronique.

**Structure de la table :**
```sql
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    parent_id INT,
    name VARCHAR(100),
    FOREIGN KEY (parent_id) REFERENCES categories(category_id)
);

INSERT INTO categories VALUES
(1, NULL, 'Électronique'),
(2, 1, 'Ordinateurs'),
(3, 1, 'Téléphones mobiles'),
(4, 2, 'Ordinateurs portables'),
(5, 2, 'Ordinateurs de bureau'),
(6, 4, 'Ordinateurs portables Dell'),
(7, 4, 'Ordinateurs portables HP'),
(8, 3, 'Smartphones'),
(9, 3, 'Tablettes');
```

**Tâche : Obtenir la hiérarchie complète des catégories de la racine aux feuilles**

```sql
WITH RECURSIVE hierarchie_categories AS (
    -- Membre d'ancrage : commencer par les catégories racine
    SELECT
        category_id,
        parent_id,
        name,
        1 AS niveau,
        name AS chemin_complet
    FROM
        categories
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    -- Membre récursif : ajouter les catégories enfants
    SELECT
        c.category_id,
        c.parent_id,
        c.name,
        hc.niveau + 1,
        CONCAT(hc.chemin_complet, ' → ', c.name)
    FROM
        categories c
    JOIN
        hierarchie_categories hc ON c.parent_id = hc.category_id
)
SELECT
    category_id,
    REPEAT('  ', niveau - 1) AS retrait,
    name,
    niveau,
    chemin_complet
FROM
    hierarchie_categories
ORDER BY
    niveau,
    category_id;
```

**Résultat :**
```
category_id | retrait | name                    | niveau | chemin_complet
1           |         | Électronique            | 1      | Électronique
2           |     | Ordinateurs             | 2      | Électronique → Ordinateurs
4           |         | Ordinateurs portables   | 3      | Électronique → Ordinateurs → Ordinateurs portables
6           |             | Ordinateurs portables Dell | 4 | Électronique → Ordinateurs → Ordinateurs portables → Ordinateurs portables Dell
7           |             | Ordinateurs portables HP | 4  | Électronique → Ordinateurs → Ordinateurs portables → Ordinateurs portables HP
5           |         | Ordinateurs de bureau   | 3      | Électronique → Ordinateurs → Ordinateurs de bureau
3           |     | Téléphones mobiles      | 2      | Électronique → Téléphones mobiles
8           |         | Smartphones             | 3      | Électronique → Téléphones mobiles → Smartphones
9           |         | Tablettes               | 3      | Électronique → Téléphones mobiles → Tablettes
```

**Ce qui se passe :**
- Le membre d'ancrage trouve uniquement `Électronique` (parent_id IS NULL)
- Le membre récursif trouve `Ordinateurs` et `Téléphones mobiles` (enfants d'Électronique)
- Le processus se répète jusqu'à ce que toutes les feuilles soient trouvées

## Exemple 2 : Organigramme

Souvent, vous devez afficher la structure de l'entreprise avec une chaîne de commandement.

**Structure de la table :**
```sql
CREATE TABLE employes (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (manager_id) REFERENCES employes(employee_id)
);

INSERT INTO employes VALUES
(1, 'Jean Dupont', 'Directeur général', NULL, 150000),
(2, 'Anne Martin', 'Directeur des ventes', 1, 100000),
(3, 'Pierre Bernard', 'Directeur IT', 1, 120000),
(4, 'Marie Petit', 'Responsable ventes', 2, 60000),
(5, 'Alexis Durand', 'Responsable ventes', 2, 60000),
(6, 'Serge Roux', 'Développeur senior', 3, 90000),
(7, 'Olga Laurent', 'Développeur', 6, 70000),
(8, 'Dmitri Blanc', 'Développeur', 6, 70000);
```

**Tâche : Afficher la structure organisationnelle avec la chaîne de commandement**

```sql
WITH RECURSIVE organigramme AS (
    -- Ancrage : Directeur général
    SELECT
        employee_id,
        name,
        position,
        manager_id,
        salary,
        1 AS niveau,
        name AS chaine_commandement
    FROM
        employes
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    -- Récursion : ajouter les subordonnés
    SELECT
        e.employee_id,
        e.name,
        e.position,
        e.manager_id,
        e.salary,
        o.niveau + 1,
        CONCAT(o.chaine_commandement, ' → ', e.name)
    FROM
        employes e
    JOIN
        organigramme o ON e.manager_id = o.employee_id
    WHERE
        o.niveau < 10  -- Protection contre la récursion infinie
)
SELECT
    employee_id,
    REPEAT('│ ', niveau - 1) AS hierarchie,
    name,
    position,
    salary,
    chaine_commandement
FROM
    organigramme
ORDER BY
    niveau,
    employee_id;
```

**Résultat :**
```
employee_id | hierarchie | name           | position          | salary | chaine_commandement
1           |            | Jean Dupont    | Directeur général | 150000 | Jean Dupont
2           | │          | Anne Martin    | Directeur ventes  | 100000 | Jean Dupont → Anne Martin
4           | │ │        | Marie Petit    | Responsable ventes| 60000  | Jean Dupont → Anne Martin → Marie Petit
5           | │ │        | Alexis Durand  | Responsable ventes| 60000  | Jean Dupont → Anne Martin → Alexis Durand
3           | │          | Pierre Bernard | Directeur IT      | 120000 | Jean Dupont → Pierre Bernard
6           | │ │        | Serge Roux     | Développeur senior| 90000  | Jean Dupont → Pierre Bernard → Serge Roux
7           | │ │ │      | Olga Laurent   | Développeur       | 70000  | Jean Dupont → Pierre Bernard → Serge Roux → Olga Laurent
8           | │ │ │      | Dmitri Blanc   | Développeur       | 70000  | Jean Dupont → Pierre Bernard → Serge Roux → Dmitri Blanc
```

**Application : Calculer le budget du département**

```sql
WITH RECURSIVE organigramme AS (
    SELECT
        employee_id,
        name,
        position,
        salary,
        1 AS niveau
    FROM
        employes
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    SELECT
        e.employee_id,
        e.name,
        e.position,
        e.salary,
        o.niveau + 1
    FROM
        employes e
    JOIN
        organigramme o ON e.manager_id = o.employee_id
)
SELECT
    name AS poste,
    COUNT(*) AS nombre_employes,
    SUM(salary) AS salaire_total,
    ROUND(AVG(salary), 2) AS salaire_moyen
FROM
    organigramme
GROUP BY
    employee_id,
    name
ORDER BY
    SUM(salary) DESC;
```

## Exemple 3 : Nomenclature (Bill of Materials - BOM)

En fabrication, vous devez savoir de quels composants est constitué un produit.

**Structure de la table :**
```sql
CREATE TABLE bom (
    product_id INT,
    component_id INT,
    quantity INT,
    PRIMARY KEY (product_id, component_id)
);

INSERT INTO bom VALUES
(1, 2, 1),      -- Ordinateur portable composé de 1 carte mère
(1, 3, 2),      -- et 2 barrettes RAM
(1, 4, 1),      -- et 1 disque dur
(2, 5, 1),      -- Carte mère composée de 1 chipset
(2, 6, 20),     -- et 20 résistances
(4, 7, 1);      -- Disque dur composé de 1 broche
```

**Tâche : Développer la nomenclature en liste complète des composants**

```sql
WITH RECURSIVE nomenclature_developpee AS (
    -- Ancrage : produits finis (non utilisés comme composants)
    SELECT
        product_id,
        product_id AS component_id,
        1 AS quantity,
        0 AS level,
        CAST(product_id AS CHAR(100)) AS chemin
    FROM
        (SELECT DISTINCT product_id FROM bom
         UNION
         SELECT DISTINCT component_id FROM bom) AS produits
    
    UNION ALL
    
    -- Récursion : développer chaque composant
    SELECT
        nd.product_id,
        b.component_id,
        nd.quantity * b.quantity,
        nd.level + 1,
        CONCAT(nd.chemin, ' → ', b.component_id)
    FROM
        nomenclature_developpee nd
    JOIN
        bom b ON nd.component_id = b.product_id
    WHERE
        nd.level < 10
)
SELECT
    product_id,
    component_id,
    quantity,
    level,
    chemin
FROM
    nomenclature_developpee
WHERE
    level > 0
ORDER BY
    product_id,
    level,
    component_id;
```

## Exemple 4 : Structure de menu (Menus arborescents)

Les sites de commerce électronique et les applications Web ont souvent des menus multi-niveaux.

**Structure de la table :**
```sql
CREATE TABLE menu (
    menu_id INT PRIMARY KEY,
    parent_menu_id INT,
    title VARCHAR(100),
    url VARCHAR(255),
    sort_order INT,
    FOREIGN KEY (parent_menu_id) REFERENCES menu(menu_id)
);

INSERT INTO menu VALUES
(1, NULL, 'Accueil', '/', 1),
(2, NULL, 'Catalogue', '/catalogue', 2),
(3, NULL, 'À propos', '/apropos', 3),
(4, 2, 'Ordinateurs', '/catalogue/ordinateurs', 1),
(5, 2, 'Accessoires', '/catalogue/accessoires', 2),
(6, 4, 'Ordinateurs portables', '/catalogue/ordinateurs/portables', 1),
(7, 4, 'Ordinateurs de bureau', '/catalogue/ordinateurs/bureau', 2),
(8, 5, 'Souris', '/catalogue/accessoires/souris', 1),
(9, 5, 'Claviers', '/catalogue/accessoires/claviers', 2),
(10, 3, 'Historique', '/apropos/historique', 1),
(11, 3, 'Équipe', '/apropos/equipe', 2);
```

**Tâche : Afficher le menu sous forme d'arborescence avec indentation**

```sql
WITH RECURSIVE arborescence_menu AS (
    -- Ancrage : éléments de menu principaux
    SELECT
        menu_id,
        parent_menu_id,
        title,
        url,
        1 AS niveau,
        title AS fil_ariane
    FROM
        menu
    WHERE
        parent_menu_id IS NULL
    ORDER BY
        sort_order
    
    UNION ALL
    
    -- Récursion : sous-menus
    SELECT
        m.menu_id,
        m.parent_menu_id,
        m.title,
        m.url,
        am.niveau + 1,
        CONCAT(am.fil_ariane, ' > ', m.title)
    FROM
        menu m
    JOIN
        arborescence_menu am ON m.parent_menu_id = am.menu_id
)
SELECT
    menu_id,
    REPEAT('  ', niveau - 1) AS retrait,
    title,
    url,
    fil_ariane
FROM
    arborescence_menu
ORDER BY
    niveau,
    menu_id;
```

**Résultat :**
```
menu_id | retrait | title                   | url                              | fil_ariane
1       |         | Accueil                 | /                                | Accueil
2       |         | Catalogue               | /catalogue                       | Catalogue
4       |     | Ordinateurs             | /catalogue/ordinateurs           | Catalogue > Ordinateurs
6       |         | Ordinateurs portables   | /catalogue/ordinateurs/portables | Catalogue > Ordinateurs > Ordinateurs portables
7       |         | Ordinateurs de bureau   | /catalogue/ordinateurs/bureau    | Catalogue > Ordinateurs > Ordinateurs de bureau
5       |     | Accessoires             | /catalogue/accessoires           | Catalogue > Accessoires
8       |         | Souris                  | /catalogue/accessoires/souris    | Catalogue > Accessoires > Souris
9       |         | Claviers                | /catalogue/accessoires/claviers  | Catalogue > Accessoires > Claviers
3       |         | À propos                | /apropos                         | À propos
10      |     | Historique              | /apropos/historique              | À propos > Historique
11      |     | Équipe                  | /apropos/equipe                  | À propos > Équipe
```

## Exemple 5 : Recherche de chemins dans un graphe

Les CTE récursifs sont utilisés pour trouver tous les chemins entre deux nœuds dans un graphe (par exemple, les routes de livraison dans un système logistique).

**Structure de la table :**
```sql
CREATE TABLE villes (
    city_id INT PRIMARY KEY,
    nom VARCHAR(100)
);

CREATE TABLE trajets (
    from_city_id INT,
    to_city_id INT,
    distance INT,
    PRIMARY KEY (from_city_id, to_city_id),
    FOREIGN KEY (from_city_id) REFERENCES villes(city_id),
    FOREIGN KEY (to_city_id) REFERENCES villes(city_id)
);

INSERT INTO villes VALUES (1, 'Paris'), (2, 'Chartres'), (3, 'Orléans'), (4, 'Blois');

INSERT INTO trajets VALUES
(1, 2, 85),    -- Paris → Chartres
(2, 3, 90),    -- Chartres → Orléans
(1, 4, 175),   -- Paris → Blois
(4, 3, 115);   -- Blois → Orléans
```

**Tâche : Trouver tous les trajets de Paris à Orléans**

```sql
WITH RECURSIVE recherche_trajets AS (
    -- Ancrage : commencer de Paris (city_id = 1)
    SELECT
        from_city_id,
        to_city_id,
        distance,
        1 AS sauts,
        CAST(to_city_id AS CHAR(1000)) AS chemin,
        distance AS distance_totale
    FROM
        trajets
    WHERE
        from_city_id = 1
    
    UNION ALL
    
    -- Récursion : continuer de chaque destination
    SELECT
        rt.from_city_id,
        t.to_city_id,
        t.distance,
        rt.sauts + 1,
        CONCAT(rt.chemin, ',', t.to_city_id),
        rt.distance_totale + t.distance
    FROM
        recherche_trajets rt
    JOIN
        trajets t ON rt.to_city_id = t.from_city_id
    WHERE
        rt.sauts < 10  -- Prévenir les cycles
        AND rt.chemin NOT LIKE CONCAT('%,', t.to_city_id, '%')  -- Éviter les boucles
)
SELECT
    from_city_id,
    to_city_id,
    sauts,
    chemin,
    distance_totale,
    ROUND(distance_totale / sauts, 2) AS distance_moyenne_entre_villes
FROM
    recherche_trajets
WHERE
    to_city_id = 3  -- Destination : Orléans
ORDER BY
    sauts,
    distance_totale;
```

## Meilleures pratiques et optimisation

### 1. Toujours définir une condition d'arrêt

La récursion sans condition d'arrêt entraînera des boucles infinies :

```sql
-- ❌ MAUVAIS : Peut entraîner une récursion infinie
WITH RECURSIVE mauvaise_recursion AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM mauvaise_recursion
)
SELECT * FROM mauvaise_recursion;

-- ✅ BON : Condition d'arrêt incluse
WITH RECURSIVE bonne_recursion AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM bonne_recursion
    WHERE n < 1000
)
SELECT * FROM bonne_recursion;
```

### 2. Utiliser UNION ALL au lieu de UNION

`UNION ALL` n'élimine pas les doublons et s'exécute plus rapidement :

```sql
-- ❌ Plus lent
WITH RECURSIVE cte AS (
    SELECT ...
    UNION  -- Élimine les doublons
    SELECT ...
)

-- ✅ Plus rapide
WITH RECURSIVE cte AS (
    SELECT ...
    UNION ALL  -- N'élimine pas les doublons
    SELECT ...
)
```

### 3. Éviter les références circulaires

Utilisez une vérification de chemin pour prévenir les cycles :

```sql
WITH RECURSIVE recursion_securisee AS (
    SELECT
        id,
        parent_id,
        CAST(id AS CHAR(1000)) AS chemin
    FROM
        table_name
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        CONCAT(rs.chemin, ',', t.id)
    FROM
        table_name t
    JOIN
        recursion_securisee rs ON t.parent_id = rs.id
    WHERE
        rs.chemin NOT LIKE CONCAT('%,', t.id, '%')  -- Vérification de cycle
        AND rs.chemin NOT LIKE CONCAT(t.id, ',%')
)
SELECT * FROM recursion_securisee;
```

### 4. Limiter la profondeur de récursion

Limiter explicitement la profondeur maximale :

```sql
WITH RECURSIVE recursion_limitee AS (
    SELECT
        id,
        parent_id,
        0 AS niveau
    FROM table_name
    WHERE parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        rl.niveau + 1
    FROM
        table_name t
    JOIN
        recursion_limitee rl ON t.parent_id = rl.id
    WHERE
        rl.niveau < 20  -- Maximum 20 niveaux
)
SELECT * FROM recursion_limitee;
```

## Matrice d'application des CTE récursifs

| Tâche | Exemple | Complexité |
|-------|---------|-----------|
| Hiérarchie de catégories | Catégories de produits dans un magasin | Faible |
| Organigramme | Structure organisationnelle, chaîne de commandement | Faible |
| Nomenclature (BOM) | Composition des produits fabriqués | Moyenne |
| Structure de menu | Arbres de navigation de sites web | Faible |
| Recherche de chemins | Routes de livraison, graphes relationnels | Élevée |
| Arborescence des commentaires | Commentaires imbriqués dans les réseaux sociaux | Moyenne |
| Graphes de dépendances | Projets et sous-tâches | Moyenne |
| Traçabilité | Suivi de l'origine des matériaux | Moyenne |

## Points clés à retenir

- **Les CTE récursifs** sont des outils puissants pour travailler avec des données hiérarchiques
- **Structure** : membre d'ancrage + membre récursif + condition d'arrêt
- **Membre d'ancrage** définit les lignes initiales
- **Membre récursif** ajoute de nouvelles lignes basées sur les précédentes
- **Condition d'arrêt** empêche les boucles infinies
- **Applications pratiques** : catégories, structures organisationnelles, nomenclatures, menus, recherche de chemins
- **Performance** : Plus la structure est simple, plus l'exécution est rapide
- **Alternatives** : Du code procédural peut être utilisé, mais les CTE récursifs sont souvent plus simples et clairs

Les CTE récursifs transforment les requêtes hiérarchiques complexes de puzzles en SQL compréhensible. Ils sont un outil indispensable pour quiconque travaille avec des structures de données arborescentes et réticulaires.

Dans les leçons suivantes, nous explorerons des techniques d'optimisation avancées et des fonctions SQL spécialisées.
