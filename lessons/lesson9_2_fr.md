Cette leçon présente les instructions `TRUNCATE` et `DROP TABLE`, utilisées pour supprimer des données ou des tables dans une base de données. Vous apprendrez en quoi elles diffèrent l’une de l’autre et de `DELETE`, dans quels cas utiliser chacune d’elles et quels risques il faut garder à l’esprit. À la fin de cette leçon, vous saurez choisir l’instruction adaptée pour vider ou supprimer une table.

# Leçon 9.2 : Les instructions TRUNCATE et DROP TABLE

Dans la leçon précédente, nous avons appris à créer des tables avec `CREATE TABLE`. Mais dans un vrai travail sur une base de données, il est important non seulement de créer la structure, mais aussi de comprendre comment vider des tables ou les supprimer complètement. Pour cela, SQL fournit les instructions `TRUNCATE` et `DROP TABLE`.

Les deux appartiennent au langage de définition de données (DDL), mais elles répondent à des besoins différents. `TRUNCATE` supprime rapidement toutes les lignes d’une table, tandis que `DROP TABLE` supprime la table elle-même avec sa structure.

## Ce que fait `TRUNCATE`

L’instruction `TRUNCATE` supprime toutes les lignes d’une table, mais la table elle-même reste en place.

Après l’exécution de `TRUNCATE` :

- la structure de la table est conservée ;
- les noms de colonnes, les types de données et les contraintes restent inchangés ;
- la table devient vide ;
- dans de nombreux SGBD, l’opération est plus rapide qu’un `DELETE` massif.

### Syntaxe de `TRUNCATE`

```sql
TRUNCATE TABLE table_name;
```

### Exemple de `TRUNCATE`

```sql
TRUNCATE TABLE logs;
```

Après cela, la table `logs` existera toujours dans la base de données, mais toutes ses lignes seront supprimées.

---

## Ce que fait `DROP TABLE`

L’instruction `DROP TABLE` supprime complètement une table.

Après l’exécution de `DROP TABLE` :

- toutes les données de la table sont supprimées ;
- la structure de la table est supprimée ;
- la table n’existe plus dans la base de données ;
- elle ne peut plus être utilisée dans les requêtes suivantes tant qu’elle n’a pas été recréée.

### Syntaxe de `DROP TABLE`

```sql
DROP TABLE table_name;
```

### Exemple de `DROP TABLE`

```sql
DROP TABLE old_reports;
```

Après cela, la table `old_reports` sera entièrement supprimée de la base de données.

---

## En quoi `TRUNCATE` diffère de `DROP TABLE`

Même si ces deux instructions suppriment des données, la différence entre elles est fondamentale.

### 1. Ce qui est supprimé exactement

- `TRUNCATE` supprime uniquement les lignes.
- `DROP TABLE` supprime à la fois les lignes et la table elle-même.

### 2. Peut-on encore utiliser la table

- Après `TRUNCATE`, la table reste disponible et on peut y réinsérer des données.
- Après `DROP TABLE`, la table a disparu, et il faut la recréer avant de pouvoir l’utiliser de nouveau.

### 3. Quand l’utiliser

- `TRUNCATE` convient lorsqu’il faut vider rapidement une table tout en conservant sa structure.
- `DROP TABLE` convient lorsque la table n’est plus du tout nécessaire.

---

## En quoi `TRUNCATE` diffère de `DELETE`

Les débutants comparent souvent `TRUNCATE` à `DELETE`, car les deux commandes peuvent supprimer des données d’une table.

Les principales différences sont les suivantes :

- `DELETE` peut être utilisé avec `WHERE` pour supprimer seulement une partie des lignes ;
- `TRUNCATE` supprime toutes les lignes de la table d’un seul coup ;
- `DELETE` appartient au DML, tandis que `TRUNCATE` est généralement classé dans le DDL ;
- `TRUNCATE` est souvent plus rapide dans de nombreux SGBD lorsqu’il faut vider entièrement une table ;
- le comportement en matière de journalisation, d’annulation et de réinitialisation des compteurs d’identité dépend du SGBD utilisé.

S’il faut supprimer seulement une partie des données, on utilise généralement `DELETE`. S’il faut vider rapidement toute la table tout en conservant sa structure, `TRUNCATE` est souvent plus pratique.

---

## Points d’attention

Lors de l’utilisation de `TRUNCATE` et `DROP TABLE`, il est important de retenir quelques règles :

- vérifiez toujours s’il faut supprimer seulement les données ou toute la structure de la table ;
- n’utilisez pas `DROP TABLE` si la structure de la table est encore nécessaire ;
- ne remplacez pas `DELETE` par `TRUNCATE` si vous devez supprimer seulement une partie des lignes ;
- gardez à l’esprit que, dans certains SGBD, `TRUNCATE` ne peut pas être exécuté si la table est référencée par des clés étrangères ;
- souvenez-vous que le comportement de `TRUNCATE` et la possibilité d’annuler l’opération dépendent du SGBD utilisé.

Une mauvaise utilisation de ces instructions peut entraîner une perte de données ou de structure.

---

## Exemple pratique

Imaginons que nous ayons une table auxiliaire `daily_import` dans laquelle des données intermédiaires provenant d’un système externe sont chargées chaque jour.

Si cette table est utilisée régulièrement, mais qu’elle doit être complètement vidée avant chaque nouveau chargement, `TRUNCATE` convient :

```sql
TRUNCATE TABLE daily_import;
```

Après cela, la structure de la table est conservée et de nouvelles données peuvent y être chargées.

Si la table a été créée uniquement pour une tâche ponctuelle et qu’elle n’est plus nécessaire, on peut la supprimer complètement :

```sql
DROP TABLE daily_import;
```

Dans le premier cas, nous préparons la table existante pour une nouvelle utilisation. Dans le second, nous supprimons complètement un objet devenu inutile de la base de données.

---

**Points clés de cette leçon :**

*   `TRUNCATE` supprime toutes les lignes d’une table mais conserve sa structure.
*   `DROP TABLE` supprime à la fois les données et la table elle-même.
*   `TRUNCATE` et `DELETE` répondent à des besoins proches, mais fonctionnent différemment.
*   Avant de les utiliser, il faut bien comprendre s’il faut vider une table ou la supprimer complètement.
*   Le comportement de `TRUNCATE` et `DROP TABLE` peut légèrement varier selon les SGBD.

Dans la prochaine leçon, nous étudierons les tables temporaires et verrons dans quels cas elles sont utiles pour des résultats intermédiaires.
