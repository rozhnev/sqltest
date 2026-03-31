Cette leçon présente les tables temporaires, un type spécial de table qui existe pendant une durée limitée et qui est généralement utilisé pour des résultats intermédiaires de calcul. Vous découvrirez ce que sont les tables temporaires, comment les créer, en quoi elles diffèrent des tables classiques et dans quels cas elles sont particulièrement utiles. À la fin de cette leçon, vous saurez utiliser les tables temporaires avec assurance pour simplifier des scénarios SQL complexes.

# Leçon 8.2 : Tables temporaires

Dans la leçon précédente, nous avons vu la création de tables avec `CREATE TABLE`. Examinons maintenant un type particulier de table : les **tables temporaires**. Elles permettent de stocker des données intermédiaires au sein d’une session ou d’une transaction et sont souvent utilisées dans les requêtes analytiques, les processus ETL et les traitements de données en plusieurs étapes.

Contrairement aux tables classiques, les tables temporaires ne sont pas destinées au stockage permanent des données. Elles sont créées pour une durée limitée, puis supprimées automatiquement ou rendues indisponibles à la fin de la session.

## Qu’est-ce qu’une table temporaire

Une table temporaire est une table créée pour stocker temporairement des données pendant le travail d’un utilisateur ou l’exécution d’un script.

En général, ces tables :

- existent uniquement dans le cadre de la connexion ou de la transaction en cours ;
- servent aux calculs intermédiaires ;
- permettent de découper une logique complexe en plusieurs étapes plus lisibles ;
- aident à réutiliser un résultat intermédiaire dans plusieurs requêtes.

Dans de nombreux SGBD, les tables temporaires sont créées avec le mot-clé `TEMPORARY` ou `TEMP`.

## Syntaxe de base

Une des formes courantes de création d’une table temporaire est la suivante :

```sql
CREATE TEMPORARY TABLE table_name (
    column1 data_type,
    column2 data_type,
    column3 data_type
);
```

Ensuite, vous pouvez travailler avec la table temporaire presque comme avec une table classique : insérer des données, les lire, les mettre à jour et les supprimer.

## Exemple de création d’une table temporaire

Supposons que nous voulions enregistrer la liste des clients ayant effectué plus de 30 paiements :

```sql
CREATE TEMPORARY TABLE active_customers AS
SELECT customer_id, COUNT(*) AS payment_count
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 30;
```

Nous pouvons maintenant utiliser cette table temporaire dans les requêtes suivantes :

```sql
SELECT ac.customer_id, ac.payment_count, c.first_name, c.last_name
FROM active_customers ac
JOIN customer c ON ac.customer_id = c.customer_id
ORDER BY ac.payment_count DESC;
```

*Résultat : nous obtenons la liste des clients actifs et pouvons réutiliser l’ensemble de données déjà préparé sans relancer l’agrégation initiale.*

---

## En quoi une table temporaire diffère d’une table classique

Même si les tables temporaires et les tables classiques se ressemblent par leur structure, il existe plusieurs différences importantes.

### 1. Durée de vie

- **Une table classique** reste dans la base de données tant que vous ne la supprimez pas explicitement.
- **Une table temporaire** existe pendant une durée limitée, généralement jusqu’à la fin d’une session ou d’une transaction.

### 2. Objectif

- **Une table classique** sert au stockage permanent des données métier.
- **Une table temporaire** sert à des données intermédiaires, techniques ou préparatoires.

### 3. Portée de visibilité

- **Une table classique** est accessible à tous les utilisateurs disposant des droits nécessaires.
- **Une table temporaire** est généralement visible uniquement dans la connexion en cours.

### 4. Utilisation pratique

- **Une table classique** stocke les clients, commandes, produits, paiements et autres informations principales.
- **Une table temporaire** stocke les résultats d’un filtrage intermédiaire, d’une agrégation ou d’une préparation de données pour un rapport.

---

## Quand les tables temporaires sont particulièrement utiles

Les tables temporaires sont utiles si :

- la requête est trop complexe et plus facile à découper en étapes ;
- le même résultat intermédiaire est nécessaire plusieurs fois ;
- il faut stocker temporairement des données nettoyées ou agrégées ;
- vous voulez simplifier la lecture et la maintenance d’un script SQL.

Par exemple, vous pouvez d’abord constituer une table temporaire avec les films souhaités, puis calculer des métriques uniquement sur cet ensemble.

```sql
CREATE TEMPORARY TABLE expensive_films AS
SELECT film_id, title, rental_rate
FROM film
WHERE rental_rate >= 4.00;

SELECT COUNT(*) AS film_count, AVG(rental_rate) AS avg_rate
FROM expensive_films;
```

*Résultat : la logique est divisée en deux étapes claires, préparation des données puis analyse.*

---

## Table temporaire et CTE classique

Dans certains cas, on peut utiliser un CTE (`WITH`) au lieu d’une table temporaire. La différence est la suivante :

- **un CTE** n’existe que dans le cadre d’une seule requête ;
- **une table temporaire** peut être utilisée dans plusieurs requêtes pendant la session ;
- **un CTE** est pratique pour une logique compacte dans une seule instruction SQL ;
- **une table temporaire** est pratique si le résultat intermédiaire doit être réutilisé.

Si le résultat n’est nécessaire qu’une seule fois, un CTE est souvent plus simple. S’il est nécessaire à plusieurs étapes, une table temporaire est généralement plus pratique.

---

## Points d’attention

Lors de l’utilisation des tables temporaires, il est utile de retenir quelques règles :

- ne les utilisez pas lorsqu’une requête simple suffit ;
- donnez aux tables temporaires des noms explicites qui reflètent leur rôle ;
- vérifiez à quel moment la table est supprimée dans votre SGBD ;
- ne conservez pas les données dans des tables temporaires plus longtemps que nécessaire ;
- vérifiez les particularités de syntaxe de votre SGBD, car le comportement de `TEMPORARY TABLE` peut varier.

Bien utilisée, une table temporaire rend un SQL complexe plus lisible et plus facile à maintenir.

---

## Exemple pratique

Imaginons que nous devions trouver les clients qui ont loué des films de la catégorie `Action`, puis construire un rapport séparé pour eux.

```sql
CREATE TEMPORARY TABLE action_customers AS
SELECT DISTINCT r.customer_id
FROM rental r
JOIN inventory i      ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
WHERE c.name = 'Action';

SELECT ac.customer_id, cu.first_name, cu.last_name
FROM action_customers ac
JOIN customer cu ON ac.customer_id = cu.customer_id
ORDER BY cu.last_name, cu.first_name;
```

Cette approche est particulièrement pratique si, après cette liste, vous devez exécuter plusieurs autres requêtes analytiques.

---

**Points clés de cette leçon :**

*   Les tables temporaires servent au stockage temporaire de données intermédiaires.
*   Elles existent généralement uniquement dans le cadre de la session ou de la transaction en cours.
*   Leur syntaxe et leur usage sont proches des tables classiques, mais elles ne sont pas destinées au stockage permanent.
*   Les tables temporaires sont particulièrement utiles dans les requêtes complexes en plusieurs étapes et dans les scénarios analytiques.
*   Si un résultat intermédiaire n’est nécessaire que dans une seule requête, un CTE peut être préférable.

Dans la prochaine leçon, nous verrons en quoi les tables temporaires diffèrent des vues et dans quels cas il vaut mieux utiliser chacun de ces outils.
