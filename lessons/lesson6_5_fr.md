---
title: "CTE Récursives SQL : Tutoriel sur les Données Hiérarchiques avec Exemples"
description: "Maîtrisez les expressions de table commune récursives SQL pour les données hiérarchiques. Apprenez la syntaxe des CTE récursives, exemples avec organigrammes, nomenclatures et techniques de parcours d'arbres."
keywords: "CTE récursive SQL, données hiérarchiques SQL, requête récursive, WITH RECURSIVE, structure arborescente SQL, parent-enfant SQL, organigramme SQL, tutoriel SQL"
lang: "fr"
region: "FR, BE, CH, CA"
---

# Leçon 6.5 : CTE Récursives pour les Données Hiérarchiques

Les CTE récursives sont l'une des fonctionnalités les plus puissantes de SQL, permettant de travailler avec des données hiérarchiques et des structures arborescentes. Dans cette leçon, nous explorerons comment utiliser les expressions de table commune récursives pour interroger des données ayant des relations parent-enfant, telles que les organigrammes, les arborescences de catégories et les nomenclatures.

## Qu'est-ce qu'une CTE Récursive ?

Une **CTE récursive** est une expression de table commune qui se référence elle-même, permettant de parcourir des structures de données hiérarchiques. Contrairement aux CTE ordinaires qui s'exécutent une fois, les CTE récursives s'exécutent de manière itérative jusqu'à ce qu'une condition de terminaison soit remplie.

Cas d'utilisation courants des CTE récursives :
- **Hiérarchies organisationnelles** : Relations employé-manager
- **Arborescences de catégories** : Catégories de produits avec sous-catégories
- **Nomenclatures (BOM)** : Relations pièces et sous-pièces
- **Structures de systèmes de fichiers** : Dossiers et sous-dossiers
- **Réseaux sociaux** : Relations ami d'ami
- **Hiérarchies géographiques** : Pays > État > Ville

## Syntaxe des CTE Récursives

La syntaxe générale d'une CTE récursive est :

```sql
WITH RECURSIVE nom_cte AS (
    -- Membre ancre (cas de base)
    SELECT ...
    FROM table
    WHERE condition
    
    UNION ALL
    
    -- Membre récursif (cas récursif)
    SELECT ...
    FROM table
    JOIN nom_cte ON condition
)
SELECT * FROM nom_cte;
```

**Composants :**
- **WITH RECURSIVE** : Mot-clé qui introduit une CTE récursive
- **Membre ancre** : La requête initiale qui retourne les lignes de départ (cas de base)
- **UNION ALL** : Combine les membres ancre et récursif
- **Membre récursif** : La requête qui référence la CTE elle-même
- **Terminaison** : La récursion s'arrête lorsque le membre récursif ne retourne aucune ligne

## Comment Fonctionnent les CTE Récursives

Le processus d'exécution :

1. **Exécuter le membre ancre** : Obtient l'ensemble initial de lignes
2. **Exécuter le membre récursif** : Utilise les résultats de l'étape 1
3. **Répéter l'étape 2** : Utilise les résultats de l'itération précédente
4. **Continuer jusqu'à** : Le membre récursif ne retourne aucune ligne
5. **Retourner tous les résultats** : Résultats combinés de toutes les itérations

## Exemple de Base : Séquence de Nombres

Commençons par un exemple simple qui génère une séquence de nombres :

```sql
WITH RECURSIVE sequence_nombres AS (
    -- Membre ancre : commencer avec 1
    SELECT 1 AS n
    
    UNION ALL
    
    -- Membre récursif : ajouter 1 à la valeur précédente
    SELECT n + 1
    FROM sequence_nombres
    WHERE n < 10
)
SELECT n
FROM sequence_nombres;
```

**Résultat :**
```
n
--
1
2
3
4
5
6
7
8
9
10
```

**Comment cela fonctionne :**
1. Ancre : Retourne `1`
2. Itération 1 : `1 + 1 = 2`
3. Itération 2 : `2 + 1 = 3`
4. ... continue jusqu'à ce que `n < 10` soit faux
5. Dernière itération : Retourne `10`, mais `10 < 10` est faux, donc la récursion s'arrête

## Exemple de Hiérarchie d'Employés

Créons une table représentant une structure organisationnelle :

```sql
-- Table d'employés exemple
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT,
    title VARCHAR(100)
);

-- Données exemple
INSERT INTO employee VALUES
    (1, 'Alice Johnson', NULL, 'PDG'),
    (2, 'Bob Smith', 1, 'VP Ingénierie'),
    (3, 'Carol White', 1, 'VP Ventes'),
    (4, 'David Brown', 2, 'Responsable Ingénierie'),
    (5, 'Eve Davis', 2, 'Responsable Ingénierie'),
    (6, 'Frank Miller', 3, 'Responsable Ventes'),
    (7, 'Grace Wilson', 4, 'Développeur Senior'),
    (8, 'Henry Moore', 4, 'Développeur'),
    (9, 'Ivy Taylor', 5, 'Développeur'),
    (10, 'Jack Anderson', 6, 'Représentant Commercial');
```

### Trouver Tous les Subordonnés

Pour trouver tous les employés qui relèvent d'un manager spécifique (directement ou indirectement) :

```sql
WITH RECURSIVE subordonnes AS (
    -- Ancre : Commencer avec le manager
    SELECT
        employee_id,
        employee_name,
        manager_id,
        title,
        0 AS niveau
    FROM
        employee
    WHERE
        employee_name = 'Bob Smith'
    
    UNION ALL
    
    -- Récursif : Trouver les rapports directs
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.title,
        s.niveau + 1
    FROM
        employee e
    INNER JOIN
        subordonnes s ON e.manager_id = s.employee_id
)
SELECT
    employee_id,
    employee_name,
    title,
    niveau
FROM
    subordonnes
ORDER BY
    niveau, employee_name;
```

**Résultat :**
```
employee_id | employee_name   | title                  | niveau
------------|-----------------|------------------------|--------
2           | Bob Smith       | VP Ingénierie          | 0
4           | David Brown     | Responsable Ingénierie | 1
5           | Eve Davis       | Responsable Ingénierie | 1
7           | Grace Wilson    | Développeur Senior     | 2
8           | Henry Moore     | Développeur            | 2
9           | Ivy Taylor      | Développeur            | 2
```

### Construire l'Organigramme Complet

Pour afficher la hiérarchie complète depuis le PDG :

```sql
WITH RECURSIVE organigramme AS (
    -- Ancre : Commencer avec le PDG (pas de manager)
    SELECT
        employee_id,
        employee_name,
        manager_id,
        title,
        0 AS niveau,
        CAST(employee_name AS VARCHAR(1000)) AS chemin
    FROM
        employee
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    -- Récursif : Ajouter chaque niveau
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.title,
        oc.niveau + 1,
        CONCAT(oc.chemin, ' > ', e.employee_name)
    FROM
        employee e
    INNER JOIN
        organigramme oc ON e.manager_id = oc.employee_id
)
SELECT
    REPEAT('  ', niveau) || employee_name AS hierarchie,
    title,
    niveau,
    chemin
FROM
    organigramme
ORDER BY
    chemin;
```

**Résultat :**
```
hierarchie                     | title                  | niveau | chemin
-------------------------------|------------------------|--------|----------------------------------
Alice Johnson                  | PDG                    | 0      | Alice Johnson
  Bob Smith                    | VP Ingénierie          | 1      | Alice Johnson > Bob Smith
    David Brown                | Responsable Ingénierie | 2      | Alice Johnson > Bob Smith > David Brown
      Grace Wilson             | Développeur Senior     | 3      | Alice Johnson > Bob Smith > David Brown > Grace Wilson
      Henry Moore              | Développeur            | 3      | Alice Johnson > Bob Smith > David Brown > Henry Moore
    Eve Davis                  | Responsable Ingénierie | 2      | Alice Johnson > Bob Smith > Eve Davis
      Ivy Taylor               | Développeur            | 3      | Alice Johnson > Bob Smith > Eve Davis > Ivy Taylor
  Carol White                  | VP Ventes              | 1      | Alice Johnson > Carol White
    Frank Miller               | Responsable Ventes     | 2      | Alice Johnson > Carol White > Frank Miller
      Jack Anderson            | Représentant Commercial| 3      | Alice Johnson > Carol White > Frank Miller > Jack Anderson
```

## Exemple d'Arborescence de Catégories

Travaillons avec une hiérarchie de catégories de produits :

```sql
-- Table de catégories exemple
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    parent_category_id INT
);

-- Données exemple
INSERT INTO category VALUES
    (1, 'Électronique', NULL),
    (2, 'Ordinateurs', 1),
    (3, 'Téléphones', 1),
    (4, 'Portables', 2),
    (5, 'Bureautique', 2),
    (6, 'Portables Gaming', 4),
    (7, 'Portables Professionnels', 4),
    (8, 'Smartphones', 3),
    (9, 'Téléphones Basiques', 3);
```

### Trouver Toutes les Sous-Catégories

Pour trouver toutes les sous-catégories sous "Ordinateurs" :

```sql
WITH RECURSIVE arbre_categories AS (
    -- Ancre : Commencer avec Ordinateurs
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS profondeur,
        CAST(category_name AS VARCHAR(1000)) AS chemin
    FROM
        category
    WHERE
        category_name = 'Ordinateurs'
    
    UNION ALL
    
    -- Récursif : Obtenir toutes les sous-catégories
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.profondeur + 1,
        CONCAT(ct.chemin, ' > ', c.category_name)
    FROM
        category c
    INNER JOIN
        arbre_categories ct ON c.parent_category_id = ct.category_id
)
SELECT
    category_id,
    REPEAT('  ', profondeur) || category_name AS hierarchie_categorie,
    profondeur,
    chemin
FROM
    arbre_categories
ORDER BY
    chemin;
```

**Résultat :**
```
category_id | hierarchie_categorie        | profondeur | chemin
------------|----------------------------|------------|--------------------------------------
2           | Ordinateurs                | 0          | Ordinateurs
4           |   Portables                | 1          | Ordinateurs > Portables
6           |     Portables Gaming       | 2          | Ordinateurs > Portables > Portables Gaming
7           |     Portables Professionnels| 2         | Ordinateurs > Portables > Portables Professionnels
5           |   Bureautique              | 1          | Ordinateurs > Bureautique
```

## Trouver les Ancêtres

Pour trouver toutes les catégories parentes d'une catégorie spécifique :

```sql
WITH RECURSIVE ancetres_categorie AS (
    -- Ancre : Commencer avec Portables Gaming
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS niveau_superieur
    FROM
        category
    WHERE
        category_name = 'Portables Gaming'
    
    UNION ALL
    
    -- Récursif : Obtenir les catégories parentes
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ca.niveau_superieur + 1
    FROM
        category c
    INNER JOIN
        ancetres_categorie ca ON c.category_id = ca.parent_category_id
)
SELECT
    category_id,
    category_name,
    niveau_superieur
FROM
    ancetres_categorie
ORDER BY
    niveau_superieur;
```

**Résultat :**
```
category_id | category_name     | niveau_superieur
------------|-------------------|------------------
6           | Portables Gaming  | 0
4           | Portables         | 1
2           | Ordinateurs       | 2
1           | Électronique      | 3
```

## Exemple de Nomenclature (Bill of Materials)

Un cas d'utilisation classique des CTE récursives est l'exploration des nomenclatures (pièces et sous-pièces) :

```sql
-- Table de pièces exemple
CREATE TABLE parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100),
    quantity INT
);

-- Table de nomenclature exemple
CREATE TABLE bom (
    parent_part_id INT,
    child_part_id INT,
    quantity_needed INT,
    PRIMARY KEY (parent_part_id, child_part_id)
);

-- Données exemple
INSERT INTO parts VALUES
    (1, 'Vélo', 1),
    (2, 'Cadre', 1),
    (3, 'Roue', 2),
    (4, 'Pneu', 1),
    (5, 'Jante', 1),
    (6, 'Rayon', 36);

INSERT INTO bom VALUES
    (1, 2, 1),  -- Vélo nécessite 1 Cadre
    (1, 3, 2),  -- Vélo nécessite 2 Roues
    (3, 4, 1),  -- Roue nécessite 1 Pneu
    (3, 5, 1),  -- Roue nécessite 1 Jante
    (5, 6, 36); -- Jante nécessite 36 Rayons
```

### Calculer le Total de Pièces Nécessaires

Pour trouver toutes les pièces nécessaires pour construire un vélo :

```sql
WITH RECURSIVE explosion_pieces AS (
    -- Ancre : Commencer avec le produit de niveau supérieur
    SELECT
        p.part_id,
        p.part_name,
        1 AS quantite,
        0 AS niveau,
        CAST(p.part_name AS VARCHAR(1000)) AS chemin
    FROM
        parts p
    WHERE
        p.part_name = 'Vélo'
    
    UNION ALL
    
    -- Récursif : Exploser la nomenclature
    SELECT
        p.part_id,
        p.part_name,
        pe.quantite * b.quantity_needed,
        pe.niveau + 1,
        CONCAT(pe.chemin, ' > ', p.part_name)
    FROM
        explosion_pieces pe
    INNER JOIN
        bom b ON pe.part_id = b.parent_part_id
    INNER JOIN
        parts p ON b.child_part_id = p.part_id
)
SELECT
    part_id,
    REPEAT('  ', niveau) || part_name AS hierarchie_pieces,
    quantite,
    niveau,
    chemin
FROM
    explosion_pieces
ORDER BY
    chemin;
```

**Résultat :**
```
part_id | hierarchie_pieces | quantite | niveau | chemin
--------|-------------------|----------|--------|------------------------
1       | Vélo              | 1        | 0      | Vélo
2       |   Cadre           | 1        | 1      | Vélo > Cadre
3       |   Roue            | 2        | 1      | Vélo > Roue
4       |     Pneu          | 2        | 2      | Vélo > Roue > Pneu
5       |     Jante         | 2        | 2      | Vélo > Roue > Jante
6       |       Rayon       | 72       | 3      | Vélo > Roue > Jante > Rayon
```

Notez que nous avons besoin de 72 rayons au total : 2 roues × 1 jante par roue × 36 rayons par jante = 72 rayons.

## Prévenir les Boucles Infinies

Les CTE récursives peuvent créer des boucles infinies s'il y a des références circulaires dans vos données. Voici des stratégies pour éviter cela :

### 1. Limiter la Profondeur Maximum

```sql
WITH RECURSIVE recursion_limitee AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS profondeur
    FROM
        category
    WHERE
        parent_category_id IS NULL
    
    UNION ALL
    
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        lr.profondeur + 1
    FROM
        category c
    INNER JOIN
        recursion_limitee lr ON c.parent_category_id = lr.category_id
    WHERE
        lr.profondeur < 10  -- Limite de profondeur maximum
)
SELECT * FROM recursion_limitee;
```

### 2. Suivre les Nœuds Visités

```sql
WITH RECURSIVE parcours_securise AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        ARRAY[category_id] AS ids_visites
    FROM
        category
    WHERE
        parent_category_id IS NULL
    
    UNION ALL
    
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        st.ids_visites || c.category_id
    FROM
        category c
    INNER JOIN
        parcours_securise st ON c.parent_category_id = st.category_id
    WHERE
        NOT (c.category_id = ANY(st.ids_visites))  -- Prévenir les cycles
)
SELECT * FROM parcours_securise;
```

## Considérations de Performance

### 1. Indexer les Colonnes Parent-Enfant

Toujours indexer les colonnes utilisées dans les jointures récursives :

```sql
CREATE INDEX idx_employee_manager ON employee(manager_id);
CREATE INDEX idx_category_parent ON category(parent_category_id);
```

### 2. Limiter les Ensembles de Résultats

Utilisez des clauses WHERE pour limiter la portée de la récursion :

```sql
WITH RECURSIVE subordonnes AS (
    SELECT employee_id, employee_name, manager_id, 0 AS niveau
    FROM employee
    WHERE employee_name = 'Bob Smith'
    
    UNION ALL
    
    SELECT e.employee_id, e.employee_name, e.manager_id, s.niveau + 1
    FROM employee e
    INNER JOIN subordonnes s ON e.manager_id = s.employee_id
    WHERE s.niveau < 3  -- Aller seulement 3 niveaux de profondeur
)
SELECT * FROM subordonnes;
```

### 3. Utiliser les Types de Jointure Appropriés

- Utilisez `INNER JOIN` lorsque vous voulez seulement des lignes correspondantes
- Utilisez `LEFT JOIN` lorsque vous voulez inclure des nœuds feuilles sans enfants

## Cas d'Utilisation Pratique : Système de Fils/Commentaires

Un modèle courant d'application web est les commentaires imbriqués ou les fils de forum :

```sql
CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    parent_comment_id INT,
    user_name VARCHAR(100),
    comment_text TEXT,
    created_at TIMESTAMP
);

WITH RECURSIVE fil_commentaires AS (
    -- Ancre : Commentaires de premier niveau
    SELECT
        comment_id,
        parent_comment_id,
        user_name,
        comment_text,
        0 AS profondeur,
        CAST(comment_id AS VARCHAR(1000)) AS chemin_tri
    FROM
        comments
    WHERE
        parent_comment_id IS NULL
    
    UNION ALL
    
    -- Récursif : Réponses imbriquées
    SELECT
        c.comment_id,
        c.parent_comment_id,
        c.user_name,
        c.comment_text,
        ct.profondeur + 1,
        CONCAT(ct.chemin_tri, '-', LPAD(c.comment_id::TEXT, 10, '0'))
    FROM
        comments c
    INNER JOIN
        fil_commentaires ct ON c.parent_comment_id = ct.comment_id
)
SELECT
    REPEAT('  ', profondeur) || user_name AS utilisateur_indente,
    comment_text,
    profondeur
FROM
    fil_commentaires
ORDER BY
    chemin_tri;
```

## Points Clés à Retenir

- Les **CTE récursives** permettent de parcourir des données hiérarchiques avec des relations parent-enfant
- La syntaxe **WITH RECURSIVE** inclut un membre ancre et un membre récursif
- Le **membre ancre** définit le point de départ (cas de base)
- Le **membre récursif** référence la CTE elle-même et traite chaque itération
- La **terminaison** se produit lorsque le membre récursif ne retourne aucune ligne
- **Cas d'utilisation courants** : Organigrammes, arborescences de catégories, nomenclatures, systèmes de fichiers
- **Suivi de niveau** : Incluez une colonne profondeur/niveau pour comprendre la position hiérarchique
- **Construction de chemin** : Concaténez les chemins pour montrer la lignée complète
- **Prévention de boucle infinie** : Utilisez des limites de profondeur ou suivez les nœuds visités
- **Performance** : Indexez les colonnes parentes et limitez la profondeur de récursion si possible
- **Polyvalent** : Fonctionne avec n'importe quelle structure de table auto-référencée

Les CTE récursives sont un outil essentiel pour travailler avec des données structurées en arbre et hiérarchiques en SQL. Elles transforment des opérations complexes multi-requêtes en solutions élégantes à requête unique.

Dans le module suivant, nous explorerons les fonctions de fenêtrage pour une analyse de données avancée.
