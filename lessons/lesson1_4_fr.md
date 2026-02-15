Apprenez-en davantage sur les valeurs NULL en SQL, en comprenant que NULL représente des données manquantes ou inconnues. Cette leçon explique en quoi NULL diffère de zéro ou d'une chaîne vide, l'importance des opérateurs IS NULL et IS NOT NULL, et comment NULL affecte les opérations et la logique de la base de données.

# Leçon 1.4 : Comprendre les valeurs NULL en SQL

Dans le monde des bases de données, vous rencontrerez souvent des situations où des données sont manquantes, inconnues ou non applicables. SQL utilise un marqueur spécial appelé **NULL** pour représenter ces cas. Comprendre NULL est essentiel car il se comporte différemment de toute autre valeur.

## Qu'est-ce que NULL ?

**NULL** n'est pas une valeur ; c'est un **état** ou un espace réservé indiquant qu'une valeur de donnée n'existe *pas* dans la base de données.

Il est important de se rappeler ce que NULL **N'EST PAS** :
*   **NULL n'est pas 0 :** Zéro est un nombre. NULL est l'absence de nombre.
*   **NULL n'est pas une chaîne vide ('') :** Une chaîne vide est un morceau de texte avec zéro caractère. NULL est l'absence de texte.
*   **NULL n'est pas "faux" (false) :** Dans la logique SQL, NULL reste "inconnu".

## Pourquoi utilisons-nous NULL ?
*   **Information inconnue :** Par exemple, nous pourrions ne pas encore connaître le deuxième prénom d'un client.
*   **Non applicable :** Une colonne "Identifiant fiscal de l'entreprise" serait NULL pour une personne physique.
*   **Données manquantes :** Données qui ont été oubliées lors de la saisie.

## Travailler avec NULL : IS NULL et IS NOT NULL

Comme NULL représente un état inconnu, vous ne pouvez pas utiliser les opérateurs de comparaison standard comme `=` ou `<>` avec lui. Toute comparaison avec NULL (ex : `valeur = NULL`) se soldera par un résultat "inconnu", et non "vrai" ou "faux".

Pour vérifier les valeurs NULL, vous devez utiliser des opérateurs spécifiques :

### 1. IS NULL
Utilisé pour trouver des enregistrements où une colonne n'a pas de valeur.
```sql
SELECT *
FROM address
WHERE address2 IS NULL;
```

### 2. IS NOT NULL
Utilisé pour trouver des enregistrements où une colonne contient *n'importe quelle* donnée.
```sql
SELECT *
FROM address
WHERE address2 IS NOT NULL;
```

## NULL dans les calculs

L'une des choses les plus importantes à retenir est que **NULL se propage**. Si vous effectuez une opération mathématique avec une valeur NULL, le résultat sera toujours NULL.

*   `10 + NULL = NULL`
*   `5 * NULL = NULL`
*   `'Bonjour ' + NULL = NULL`

## Points clés de cette leçon

*   **NULL** représente des données manquantes, inconnues ou non applicables.
*   Il est **différent** de zéro, des chaînes vides ou des espaces blancs.
*   Les comparaisons standard (`=` ou `<>`) **ne fonctionnent pas** avec NULL.
*   Utilisez **IS NULL** et **IS NOT NULL** pour filtrer les données manquantes.
*   La plupart des opérations mathématiques impliquant NULL donneront **NULL**.
