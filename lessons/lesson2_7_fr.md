Cette leçon explore comment combiner les clauses `WHERE`, `ORDER BY` et `LIMIT` dans une seule requête SQL pour effectuer un filtrage et un tri précis des données. Vous apprendrez l'ordre syntaxique correct de ces clauses et comment elles fonctionnent ensemble pour affiner vos résultats — par exemple, en trouvant les "5 meilleurs" enregistrements qui répondent à des critères spécifiques. Maîtriser cette combinaison est essentiel pour créer des rapports ciblés et optimiser la récupération de données dans les applications de base de données réelles.

# Leçon 2.7 : Synthèse : WHERE, ORDER BY et LIMIT

Jusqu'à présent, nous avons appris à filtrer les lignes (`WHERE`), à les trier (`ORDER BY`) et à restreindre le nombre de résultats (`LIMIT`). Dans des scénarios réels, vous utiliserez presque toujours ces clauses ensemble pour obtenir exactement les données dont vous avez besoin.

## L'ordre des clauses

SQL impose un ordre strict pour l'apparition de ces clauses dans votre requête. Si vous les placez dans le mauvais ordre, la base de données renverra une erreur.

La séquence correcte est :
1.  **`SELECT`** (Quelles colonnes ?)
2.  **`FROM`** (Quelle table ?)
3.  **`WHERE`** (Filtrer les lignes d'abord)
4.  **`ORDER BY`** (Trier les lignes filtrées)
5.  **`LIMIT`** (Prendre les X premiers résultats de la liste triée)
6.  **`OFFSET`** (Sauter X lignes si nécessaire)

## Logique : Comment ça marche

Lorsque vous exécutez une requête combinée, la base de données la traite conceptuellement de cette manière :
1.  Elle examine la table spécifiée dans le **`FROM`**.
2.  Elle filtre les lignes qui ne correspondent pas à la condition **`WHERE`**.
3.  Elle prend les lignes restantes et les trie selon le **`ORDER BY`**.
4.  Enfin, elle examine le résultat trié et applique le **`LIMIT`** pour ne vous donner que la portion demandée.

## Exemples

### Exemple 1 : Trouver les 5 films d'action les plus courts (ou à petit prix)
Dans cet exemple, nous filtrons d'abord par coût de remplacement, puis nous trions par durée, et enfin nous limitons les résultats.

```sql
SELECT title, length, replacement_cost
FROM film
WHERE replacement_cost < 20.00
ORDER BY length ASC
LIMIT 5;
```

### Exemple 2 : Locations récentes de grande valeur
Cette requête trouve les 10 locations les plus récentes ayant duré plus de 5 jours.

```sql
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date - rental_date > 5
ORDER BY rental_date DESC
LIMIT 10;
```

### Exemple 3 : Rechercher des acteurs spécifiques
Trouver les 3 premiers acteurs dont le nom commence par 'B', triés par ordre alphabétique de leur prénom.

```sql
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'B%'
ORDER BY first_name
LIMIT 3;
```

## Pagination avec WHERE et ORDER BY

Dans la leçon précédente, nous avons vu la pagination de base avec `LIMIT` et `OFFSET`. Dans les applications réelles, vous paginez généralement sur une liste **filtrée** et **triée**.

### Pourquoi avons-nous besoin de WHERE et ORDER BY pour la pagination ?
1. **Filtrage :** Les utilisateurs veulent généralement voir un sous-ensemble spécifique de données (ex : produits "Actifs" ou films de "Comédie").
2. **Cohérence :** Sans `ORDER BY`, la base de données peut renvoyer les lignes dans un ordre différent à chaque passage à la page suivante, ce qui fait que certains éléments apparaissent deux fois tandis que d'autres sont manqués.

### Formule de pagination
Pour implémenter la pagination pour la "Page N" avec "S" résultats par page :
*   `LIMIT S`
*   `OFFSET (N - 1) * S`

### Exemple combiné : Page 2 des acteurs dont le prénom commence par 'A'
Si nous voulons afficher la deuxième page (5 résultats par page) des acteurs dont le prénom commence par 'A', triés par leur nom :

```sql
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'A%'
ORDER BY last_name
LIMIT 5 OFFSET 5; -- Page 2 : Sauter 5, prendre 5
```

---

**Points clés de cette leçon :**

*   Respectez l'ordre syntaxique strict : `WHERE` -> `ORDER BY` -> `LIMIT`.
*   Les conditions de la clause `WHERE` sont appliquées *avant* que le tri et la limitation ne se produisent.
*   Cette combinaison est le fondement de la plupart des rapports de données et des listes "top-X" des interfaces utilisateur.
*   Utilisez toujours `LIMIT` avec `ORDER BY` si vous voulez que vos résultats soient cohérents.

Dans le module suivant, nous irons au-delà de la simple récupération de lignes et explorerons les **fonctions d'agrégation**, qui nous permettent de calculer des totaux, des moyennes et des comptages sur des ensembles de données entiers.
