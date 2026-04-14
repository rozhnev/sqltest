Esta lição apresenta as views (`VIEW`), objetos SQL que permitem salvar uma consulta com um nome e depois usá-la como se fosse uma tabela comum. Você vai aprender o que são views, como criá-las, em que elas diferem de tabelas e de tabelas temporárias, e em quais tarefas elas são especialmente úteis. Ao final da lição, você conseguirá usar views com confiança para simplificar consultas complexas e reutilizar lógica.

# Lição 9.4: Views (`VIEW`)

Na lição anterior, falamos sobre tabelas temporárias, que ajudam a armazenar resultados intermediários durante uma sessão. Agora vamos analisar outra ferramenta importante do SQL: as **views**. Elas também ajudam a simplificar o trabalho com consultas complexas, mas fazem isso de outra forma.

Uma view permite salvar uma consulta `SELECT` com um nome separado e depois reutilizá-la. Isso é especialmente útil em relatórios, análises e cenários em que o mesmo conjunto de resultados precisa ser consultado muitas vezes.

<img src="/images/lessons/lesson9_4-sql-view.svg" alt="SQL Views" width="100%">

## O que é uma view

Uma view (`VIEW`) é um objeto do banco de dados que armazena não os dados em si, mas a consulta SQL usada para obtê-los.

Em termos simples, uma view pode ser vista como uma “tabela virtual”:

- ela tem um nome;
- pode ser consultada com `SELECT`;
- normalmente mostra dados de uma ou mais tabelas;
- ajuda a esconder uma lógica de consulta complexa atrás de uma interface mais simples.

Quando você consulta uma view, o SGBD normalmente executa a consulta armazenada e retorna o resultado atual com base nas tabelas de origem.

## Sintaxe básica

Uma view é criada com `CREATE VIEW`:

```sql
CREATE VIEW view_name AS
SELECT column1, column2, column3
FROM table_name
WHERE condition;
```

Depois disso, você pode consultar a view quase da mesma forma que uma tabela:

```sql
SELECT *
FROM view_name;
```

É importante entender que uma view comum armazena a lógica da consulta, e não uma cópia separada do resultado.

## Exemplo de criação de uma view

Suponha que queremos obter com frequência a lista de clientes com o valor total de seus pagamentos. Em vez de escrever a mesma consulta toda vez, podemos criar uma view:

```sql
CREATE VIEW customer_payment_summary AS
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_amount,
       COUNT(p.payment_id) AS payment_count
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

Agora fica muito mais simples reutilizar essa lógica:

```sql
SELECT customer_id, first_name, last_name, total_amount
FROM customer_payment_summary
ORDER BY total_amount DESC;

SELECT AVG(total_amount) AS avg_customer_revenue
FROM customer_payment_summary;
```

*Resultado: a agregação complexa é definida uma vez dentro da view, e depois você pode trabalhar com ela como com um conjunto de dados comum em várias consultas separadas.*

---

## Como uma view difere de uma tabela comum

Embora uma view muitas vezes pareça uma tabela, existem diferenças importantes entre elas.

### 1. Armazenamento de dados

- **Uma tabela comum** armazena dados fisicamente.
- **Uma view** normalmente armazena apenas a consulta SQL.

### 2. Origem do resultado

- **Uma tabela comum** contém suas próprias linhas.
- **Uma view** mostra dados obtidos de outras tabelas ou até de outras views.

### 3. Atualidade dos dados

- **Uma tabela comum** muda apenas depois de `INSERT`, `UPDATE` ou `DELETE`.
- **Uma view** normalmente mostra o estado atual das tabelas de origem no momento da consulta.

### 4. Finalidade

- **Uma tabela comum** é usada para armazenar dados de negócio.
- **Uma view** é usada para simplificar a leitura, a reutilização e a organização lógica das consultas.

### 5. Modificação de dados

- **Uma tabela comum** é diretamente destinada à inserção, atualização e remoção de linhas.
- **Uma view** em alguns casos também pode permitir modificação de dados, mas isso depende do SGBD específico e da complexidade da consulta dentro da `VIEW`.

---

## Quando views são especialmente úteis

Vale usar views se:

- a mesma consulta precisa ser repetida muitas vezes;
- você quer esconder `JOIN`s, filtros e agregações complexas atrás de um nome mais simples;
- é importante dar aos usuários ou relatórios acesso não à tabela inteira, mas apenas às colunas e linhas necessárias;
- você quer tornar o SQL analítico mais legível e fácil de manter.

Por exemplo, você pode criar uma view apenas para filmes caros:

```sql
CREATE VIEW expensive_films AS
SELECT film_id, title, rental_rate, rating
FROM film
WHERE rental_rate >= 4.00;

SELECT title, rental_rate
FROM expensive_films
ORDER BY rental_rate DESC, title;
```

*Resultado: a lógica principal de filtragem fica salva em um único lugar, e nas consultas seguintes não é necessário repetir toda vez a condição `WHERE rental_rate >= 4.00`.*

---

## View e tabela temporária

Views e tabelas temporárias podem resolver tarefas parecidas, mas existem diferenças importantes entre elas.

- **Uma tabela temporária** normalmente existe por um tempo limitado e armazena dados intermediários separadamente.
- **Uma view** normalmente é um objeto permanente do esquema e armazena apenas a consulta.
- **Uma tabela temporária** é conveniente quando você precisa manter fisicamente um resultado intermediário por várias etapas.
- **Uma view** é conveniente quando você precisa reutilizar muitas vezes a mesma lógica de seleção.
- **Uma tabela temporária** é usada com mais frequência dentro de um fluxo de processamento de dados.
- **Uma view** é usada com mais frequência como uma camada nomeada e conveniente de acesso aos dados.

Se você precisa de um resultado intermediário que deva existir separadamente e talvez ser processado novamente depois, a tabela temporária costuma ser a melhor escolha. Se você só precisa definir uma representação conveniente sobre dados existentes, `VIEW` normalmente é mais adequada.

---

## É possível modificar dados por meio de uma view

Em muitos SGBDs, views simples podem ser usadas não apenas para leitura, mas também para modificação de dados. Por exemplo, isso pode ser possível se a view for baseada em uma única tabela e não contiver agregações complexas, `GROUP BY`, `DISTINCT` ou junções entre várias tabelas.

Por exemplo, uma view simples pode ter esta forma:

```sql
CREATE VIEW active_customers_basic AS
SELECT customer_id, first_name, last_name, active
FROM customer
WHERE active = 1;
```

Em alguns SGBDs, é possível executar `UPDATE` por meio dessa view. Mas não vale tratar isso como uma regra universal: quanto mais complexa for a lógica da view, menor a chance de ela ser atualizável.

Na prática, views são mais usadas para leitura e simplificação de consultas.

---

## Pontos de atenção

Ao trabalhar com views, é útil lembrar algumas regras:

- dê às views nomes claros que reflitam seu significado;
- não esconda lógica demais em uma única view se isso a tornar difícil de ler;
- lembre-se de que o desempenho de uma consulta sobre uma view depende da consulta dentro dela e das tabelas de origem;
- não suponha automaticamente que qualquer view suporta `INSERT`, `UPDATE` ou `DELETE`;
- verifique se, em uma tarefa específica, um `SELECT` simples, um CTE ou uma tabela temporária não seria mais simples;
- considere particularidades do seu SGBD, como `CREATE OR REPLACE VIEW` ou as regras de atualizabilidade.

Uma view bem projetada torna o SQL mais curto, mais claro e mais fácil de reutilizar.

---

## Exemplo prático

Imagine que analistas precisem regularmente de uma lista de filmes com o nome da categoria. Em vez de escrever os mesmos `JOIN`s toda vez, você pode criar uma view:

```sql
CREATE VIEW film_category_details AS
SELECT f.film_id,
       f.title,
       f.rental_rate,
       c.name AS category_name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;
```

Depois disso, qualquer consulta fica mais simples:

```sql
SELECT title, category_name, rental_rate
FROM film_category_details
WHERE category_name = 'Comedy'
ORDER BY rental_rate DESC, title;

SELECT category_name, COUNT(*) AS film_count
FROM film_category_details
GROUP BY category_name
ORDER BY film_count DESC;
```

Essa abordagem é conveniente porque a relação complexa entre as tabelas é definida uma única vez. Depois disso, analistas, relatórios e aplicações podem usar uma camada lógica pronta sem repetir constantemente a mesma lógica de `JOIN`.

---

**Principais conclusões desta lição:**

*   Uma view (`VIEW`) armazena uma consulta SQL, e não uma cópia separada dos dados.
*   Você pode consultar uma view como uma tabela, o que simplifica a reutilização de lógica complexa.
*   Views são especialmente úteis para relatórios, análises e para esconder `JOIN`s e filtros complexos.
*   Ao contrário de tabelas temporárias, views normalmente são objetos permanentes do esquema e não se destinam ao armazenamento de dados intermediários.
*   Nem todas as views permitem modificação de dados, e isso depende do SGBD específico e da estrutura da consulta.
*   O desempenho de uma view depende de quão eficiente é a consulta definida dentro dela.

Na próxima lição, veremos views materializadas e entenderemos em que elas diferem das views comuns.