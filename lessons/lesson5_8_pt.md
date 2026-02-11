Domine cenários práticos de SQL JOIN para resolver problemas reais de análise de dados. Esta lição aborda a junção de múltiplas tabelas, o uso de funções agregadas com junções para relatórios e a identificação de dados ausentes. Aprenda a combinar JOIN e GROUP BY para extrair insights profundos do banco de dados Sakila.

# Lição 5.8: Cenários e Técnicas Práticas de JOIN

Até agora, exploramos a mecânica de diferentes tipos de junção. Nesta lição, iremos além do básico e veremos como aplicar as junções para resolver problemas de negócios comuns, lidar com múltiplas tabelas e combinar junções com agregação.

## 1. Unindo Múltiplas Tabelas (3+)

Em bancos de dados complexos, os dados de que você precisa estão frequentemente distribuídos em três ou mais tabelas conectadas por tabelas de junção (junction tables).

**Cenário:** Queremos ver uma lista de atores e os títulos dos filmes em que apareceram.
Isso requer três tabelas: `actor`, `film_actor` (a ponte) e `film`.

```sql
SELECT
    a.first_name,
    a.last_name,
    f.title
FROM
    actor AS a
INNER JOIN
    film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN
    film AS f ON fa.film_id = f.film_id
ORDER BY
    a.last_name
LIMIT 10;
```

**Como funciona:**
- Cada `JOIN` cria uma nova tabela virtual que o próximo `JOIN` pode usar.
- A ordem das junções geralmente segue o caminho de relacionamento no ERD (Diagrama do Banco de Dados).

## 2. Usando Funções Agregadas com JOINs

Um dos usos mais poderosos das junções é calcular estatísticas em tabelas relacionadas. Você pode usar funções como `COUNT`, `SUM` e `AVG` após a junção.

**Cenário:** Calcular o valor total gasto por cada cliente.

```sql
SELECT
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_gasto
FROM
    customer AS c
INNER JOIN
    payment AS p ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    total_gasto DESC;
```
*Nota: Ao usar `GROUP BY` com junções, sempre inclua a chave primária (`customer_id`) para garantir resultados únicos caso dois clientes tenham o mesmo nome.*

## 3. Encontrando Dados Ausentes (O "Anti-Join")

Podemos usar o `LEFT JOIN` combinado com uma cláusula `WHERE` para encontrar registros que **não** possuem uma entrada correspondente em outra tabela.

**Cenário:** Encontrar todos os filmes que NÃO estão no nosso inventário no momento (significa que temos o registro, mas não temos cópias físicas).

```sql
SELECT
    f.title
FROM
    film AS f
LEFT JOIN
    inventory AS i ON f.film_id = i.film_id
WHERE
    i.inventory_id IS NULL;
```

## 4. A Armadilha do Filtro: WHERE vs. ON

Um erro comum é colocar um filtro na cláusula `WHERE` ao usar um `LEFT JOIN`, o que acidentalmente o transforma de volta em um `INNER JOIN`.

**Incorreto:**
```sql
-- Isso remove clientes sem pagamentos porque p.payment_date é verificado APÓS a junção
SELECT c.last_name, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_date > '2005-08-01';
```

**Correto (mantendo todos os clientes):**
```sql
-- Isso mantém todos os clientes, mas só une dados de pagamento que correspondam à data
SELECT c.last_name, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id 
    AND p.payment_date > '2005-08-01';
```

## Principais Conclusões desta Lição

- **Encadeamento de Junções:** Você pode unir quantas tabelas forem necessárias adicionando mais instruções `JOIN`.
- **Relatórios:** Combinar `JOIN` com `GROUP BY` permite relatórios complexos entre entidades de negócios.
- **Auditoria de Dados:** Use `LEFT JOIN ... WHERE ... IS NULL` para encontrar lacunas em seus dados.
- **Precisão Lógica:** Tenha cuidado onde coloca seus filtros (em `ON` vs. `WHERE`) ao trabalhar com junções externas.
