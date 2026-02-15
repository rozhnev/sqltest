Cette leçon se concentre sur l'aliasing des colonnes en SQL, une technique puissante pour renommer les colonnes dans les résultats de vos requêtes. Vous apprendrez à utiliser le mot-clé `AS` pour créer des noms temporaires qui améliorent la lisibilité et la clarté de votre résultat. Nous explorerons les avantages de l'aliasing, tels que la simplification des noms de colonnes complexes, l'évitement de l'ambiguïté dans les jointures et la fourniture d'en-têtes conviviaux pour les colonnes calculées. À la fin de cette leçon, vous serez en mesure de personnaliser vos ensembles de résultats pour qu'ils soient plus descriptifs et plus faciles à comprendre pour l'analyse et le reporting.

# Leçon 2.4 : Aliasing des colonnes (Renommage)

Dans les leçons précédentes, nous avons appris à sélectionner des données dans les tables. Parfois, les noms de colonnes par défaut dans une base de données ne sont pas très descriptifs, ou vous pourriez vouloir donner un nouveau nom à une colonne que vous avez calculée. C'est là qu'intervient l'**aliasing de colonne**.

## Qu'est-ce que l'aliasing de colonne ?

L'aliasing de colonne vous permet d'attribuer un nom alternatif et temporaire à une colonne dans l'ensemble de résultats d'une requête `SELECT`. Cela ne modifie pas le nom réel de la colonne dans la table ; cela n'affecte que la façon dont la colonne est affichée dans le résultat de la requête.

## Syntaxe

Vous pouvez créer un alias de colonne en utilisant le mot-clé `AS`, bien qu'il soit souvent facultatif :

```sql
SELECT nom_colonne AS nom_alias
FROM nom_table;

-- OU (sans AS)

SELECT nom_colonne nom_alias
FROM nom_table;
```

*   **`nom_colonne`** : Le nom de la colonne que vous souhaitez renommer.
*   **`AS nom_alias`** : Le mot-clé `AS` suivi du nom d'alias souhaité.
*   **`nom_alias`** : Le nouveau nom temporaire de la colonne. Si l'alias contient des espaces ou des caractères spéciaux, il doit être entouré de guillemets doubles (`"`).

## Avantages de l'aliasing de colonne

L'utilisation d'alias offre plusieurs avantages pour la présentation des données et la construction des requêtes :

*   **Lisibilité accrue :** Les alias peuvent rendre les noms de colonnes plus descriptifs et plus faciles à comprendre, en particulier lors de requêtes complexes ou avec des colonnes calculées.
*   **Simplification des noms de colonnes :** Si un nom de colonne est long ou contient des tirets bas (underscores), un alias peut fournir un nom plus court et plus maniable pour l'ensemble de résultats.
*   **Évitement de l'ambiguïté :** Lors de la jointure de tables ayant des colonnes portant le même nom, les alias aident à les distinguer dans le résultat.
*   **Création d'un résultat plus convivial :** Les alias vous permettent de personnaliser les en-têtes de colonnes dans l'ensemble de résultats pour qu'ils soient plus explicites pour les utilisateurs finaux ou les outils de reporting.
*   **Utilisation de colonnes calculées :** Les alias sont essentiels lors de la création de colonnes calculées (par exemple, à l'aide de fonctions ou d'expressions), car ces colonnes n'ont pas de nom intrinsèque.

## Exemples

Voyons quelques exemples pratiques en utilisant la structure de la base de données Sakila.

### Exemple 1 : Aliasing de base
Cette requête sélectionne les colonnes `first_name` et `last_name` de la table `actor`, mais les affiche comme "Given Name" (Prénom) et "Surname" (Nom) dans l'ensemble de résultats. Notez l'utilisation de guillemets doubles car l'alias contient un espace.

```sql
SELECT first_name AS "Given Name", last_name AS "Surname"
FROM actor;
```

### Exemple 2 : Aliasing de colonnes calculées
Cette requête calcule la durée de location en jours et attribue l'alias `rental_duration` à la colonne calculée.

```sql
SELECT rental_date, return_date - rental_date AS rental_duration
FROM rental;
```

### Exemple 3 : Aliasing avec concaténation
Cette requête concatène les colonnes `first_name` et `last_name` pour créer un nom complet et attribue l'alias "Full Name" à la colonne résultante.

```sql
SELECT first_name || ' ' || last_name AS "Full Name"
FROM actor;
```

> **Note :** L'opérateur `||` est utilisé pour la concaténation de chaînes dans SQLite et PostgreSQL. D'autres bases de données peuvent utiliser des opérateurs ou des fonctions différents (ex : `+` dans SQL Server, fonction `CONCAT()` dans MySQL).

---

**Points clés de cette leçon :**

*   L'aliasing de colonne fournit des noms temporaires et descriptifs pour les colonnes dans l'ensemble de résultats d'une requête.
*   Utilisez le mot-clé `AS` (ou simplement un espace) pour créer un alias.
*   Entourez les alias contenant des espaces ou des caractères spéciaux par des guillemets doubles (`"`).
*   Les alias améliorent la lisibilité, simplifient les noms de colonnes, évitent l'ambiguïté et sont indispensables pour les colonnes calculées.
Dans le module suivant, nous explorerons comment utiliser les **fonctions** pour manipuler et transformer davantage les données au sein de nos requêtes.
