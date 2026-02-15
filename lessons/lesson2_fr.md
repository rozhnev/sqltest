Cette leçon SQL essentielle approfondit les éléments de base des bases de données relationnelles : les tables, les colonnes et les lignes. Apprenez comment les données sont structurées et organisées dans une base de données. Comprenez le rôle crucial des clés de base de données, notamment les clés primaires, les clés étrangères et les clés uniques, dans l'établissement de relations et la garantie de l'intégrité des données. Ces connaissances sont fondamentales pour l'interrogation SQL efficace et la conception de bases de données. Maîtrisez les bases de la gestion de bases de données relationnelles et préparez-vous aux concepts SQL avancés.

# Leçon 2 : Concepts de base de données relationnelle

Dans la leçon précédente, nous avons introduit le concept de bases de données. Nous allons maintenant approfondir les composants essentiels des **bases de données relationnelles**, qui sont fondamentaux pour comprendre comment les données sont organisées et consultées à l'aide de SQL.

## Tables, Colonnes et Lignes

Les bases de données relationnelles organisent les données dans des structures appelées **tables**. Imaginez une table comme une feuille de calcul (tableur) :

* **Table :** Une collection de données connexes. Par exemple, une table peut stocker des informations sur les clients, les produits ou les commandes.
* **Colonne :** Un ensemble vertical de données au sein d'une table. Chaque colonne représente un attribut ou une caractéristique spécifique des données. Par exemple, dans une table "Clients", les colonnes pourraient être "IDClient", "Prénom", "Nom" et "Email".
* **Ligne (Enregistrement) :** Un ensemble horizontal de données au sein d'une table. Chaque ligne représente une instance unique ou un enregistrement de données. Dans une table "Clients", chaque ligne représenterait un seul client.

**Exemple :**

Visualisons une table simple "Clients" :

|   IDClient     |   Prénom      |   Nom        |   Email                |
| :------------- | :------------ | :----------- | :--------------------- |
|   1            |   John        |   Doe        |   john.doe@example.com   |
|   2            |   Jane        |   Smith      |   jane.smith@example.com   |
|   3            |   David       |   Lee        |   david.lee@example.com    |

* L'ensemble de la structure est la **table** nommée "Clients".
* "IDClient", "Prénom", "Nom" et "Email" sont les **colonnes**.
* Chaque ligne (ex : "1 | John | Doe | john.doe@example.com") est une **ligne** (ou enregistrement).

## Clés : Garantir l'intégrité des données

Les **clés** sont un concept critique dans les bases de données relationnelles. Elles sont utilisées pour établir des relations entre les tables et appliquer l'intégrité des données. Voici les principaux types de clés :

### Clé primaire (Primary Key)

* Une **clé primaire** est une colonne (ou un ensemble de colonnes) qui identifie de manière unique chaque ligne d'une table.
* **Caractéristiques d'une clé primaire :**
    * **Unique :** Deux lignes ne peuvent pas avoir la même valeur de clé primaire.
    * **Non nulle (Not Null) :** Une colonne de clé primaire ne peut pas contenir de valeurs NULL.
* Dans notre table "Clients", "IDClient" est un bon candidat pour la clé primaire car chaque client a un identifiant unique et il ne peut pas être vide.

### Clé étrangère (Foreign Key)

* Une **clé étrangère** est une colonne (ou un ensemble de colonnes) dans une table qui fait référence à la clé primaire d'une autre table.
* Les clés étrangères établissent des relations entre les tables.
* Par exemple, si nous avons une table "Commandes", elle pourrait avoir une colonne "IDClient" qui est une clé étrangère référençant l' "IDClient" de la table "Clients". Cela lie chaque commande au client qui l'a passée.

### Clé unique (Unique Key)

* Une **clé unique** est une colonne (ou un ensemble de colonnes) qui garantit que les valeurs de la ou des colonnes sont uniques pour toutes les lignes de la table.
* **Différence avec la clé primaire :**
    * Une table ne peut avoir qu'une seule clé primaire, mais elle peut avoir plusieurs clés uniques.
    * Les colonnes de clé unique *peuvent* autoriser des valeurs NULL (bien que les implémentations varient légèrement).
* Dans notre table "Clients", "Email" pourrait être une clé unique, garantissant que chaque client possède une adresse e-mail unique.

## Importance de ces concepts

Comprendre les tables, les colonnes, les lignes et les clés est fondamental pour travailler avec des bases de données relationnelles.

* Ils définissent comment les données sont structurées et organisées.
* Ils nous permettent d'interroger et de récupérer des informations spécifiques de manière efficace.
* Les clés garantissent l'intégrité des données et établissent des relations entre différents ensembles de données.

Dans les leçons suivantes, nous nous appuierons sur ces concepts pour apprendre à utiliser SQL afin d'interagir avec les bases de données relationnelles.
