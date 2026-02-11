Aprenda a usar SQL SELF JOIN para unir uma tabela a si mesma. Esta lição aborda o conceito de dados hierárquicos, o uso de aliases para distinguir instâncias de tabelas e exemplos práticos, como encontrar pares de registros com atributos correspondentes. Domine técnicas avançadas de junção SQL para relacionamentos de dados complexos.

# Lição 5.7: SELF JOIN — Unindo uma Tabela a si Mesma

Um **SELF JOIN** não é uma palavra-chave de junção diferente. Em vez disso, é uma junção regular (geralmente um `INNER JOIN` или `LEFT JOIN`) onde uma tabela é unida a si mesma. Isso é útil para consultar dados hierárquicos ou comparar linhas dentro da mesma tabela.

## O que é um SELF JOIN?

Para realizar um self-join, você deve tratar uma tabela como se fossem duas tabelas separadas. Para fazer isso, você **deve usar aliases de tabela** para dar a cada instância da tabela um nome exclusivo. Sem aliases, o banco de dados não saberá qual coluna pertence a qual instância da tabela.

**Visualização (Hierarquia de Funcionários):**
Imagine uma tabela `employee` onde cada linha tem um `manager_id` que aponta para o `employee_id` de seu supervisor.

```
   Tabela A (Funcionários)      Tabela B (Gerentes)
   +----+-------+---------+     +----+-------+
   | id | nome  | mgr_id  |     | id | nome  |
   +----+-------+---------+     +----+-------+
   | 1  | Alice | NULL    |     | 1  | Alice |
   | 2  | Bob   | 1       | <-> | 1  | Alice | (O gerente de Bob é Alice)
   | 3  | Carol | 1       | <-> | 1  | Alice | (A gerente de Carol é Alice)
   +----+-------+---------+     +----+-------+
```

## Sintaxe do SELF JOIN

```sql
SELECT
    e.name AS nome_funcionario,
    m.name AS nome_gerente
FROM
    funcionario AS e
LEFT JOIN
    funcionario AS m ON e.manager_id = m.id;
```

- `funcionario AS e`: A primeira instância (representando os funcionários).
- `funcionario AS m`: A segunda instância (representando os gerentes).
- `ON e.manager_id = m.id`: A condição que os vincula.

## Exemplos Práticos (Banco de Dados Sakila)

### 1. Encontrando Filmes com a Mesma Duração
Suponha que queiramos encontrar pares de filmes que tenham exatamente a mesma duração (`length`). Podemos unir a tabela `film` a si mesma.

```sql
SELECT
    f1.title AS filme_1,
    f2.title AS filme_2,
    f1.length
FROM
    film AS f1
INNER JOIN
    film AS f2 ON f1.length = f2.length
WHERE
    f1.film_id <> f2.film_id -- Garante que não combinemos um filme com ele mesmo
LIMIT 10;
```
*A condição `f1.film_id <> f2.film_id` é crítica. Sem ela, cada filme corresponderia a si mesmo (pois tem a mesma duração que si mesmo).*

### 2. Encontrando Clientes da Mesma Cidade
Se quisermos ver quais clientes moram no mesmo endereço (com base no `address_id` neste exemplo simplificado):

```sql
SELECT
    c1.first_name AS nome_1,
    c1.last_name AS sobrenome_1,
    c2.first_name AS nome_2,
    c2.last_name AS sobrenome_2,
    c1.address_id
FROM
    customer AS c1
INNER JOIN
    customer AS c2 ON c1.address_id = c2.address_id
WHERE
    c1.customer_id < c2.customer_id; -- Use '<' em vez de '<>' para evitar pares duplicados (A-B e B-A)
```

## Principais Conclusões desta Lição

- Um **SELF JOIN** é uma tabela unida a si mesma.
- **Aliases de Tabela** são obrigatórios para distinguir entre as duas instâncias da tabela.
- Use condições `ON` para definir o relacionamento entre as linhas (ex: hierarquia ou atributos compartilhados).
- Use condições de filtro `WHERE` como `id1 <> id2` или `id1 < id2` para evitar combinar uma linha consigo mesma ou retornar pares redundantes.
