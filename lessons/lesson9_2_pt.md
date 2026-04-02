Esta lição apresenta as tabelas temporárias, um tipo especial de tabela que existe por tempo limitado e normalmente é usado para resultados intermediários de cálculos. Você vai aprender o que são tabelas temporárias, como criá-las, em que elas diferem das tabelas comuns e em quais tarefas são especialmente úteis. Ao final da lição, você conseguirá usar tabelas temporárias com confiança para simplificar cenários SQL complexos.

# Lição 9.2: Tabelas temporárias

Na lição anterior, falamos sobre a criação de tabelas com `CREATE TABLE`. Agora vamos analisar um tipo especial de tabela: as **tabelas temporárias**. Elas ajudam a armazenar dados intermediários dentro de uma sessão ou transação e são usadas com frequência em consultas analíticas, processos de ETL e processamento de dados em várias etapas.

Diferentemente das tabelas comuns, as tabelas temporárias não são destinadas ao armazenamento permanente de dados. Elas são criadas por um período limitado e depois são removidas automaticamente ou ficam indisponíveis após o encerramento da sessão.

## O que é uma tabela temporária

Uma tabela temporária é uma tabela criada para armazenar dados temporariamente durante o trabalho do usuário ou a execução de um script.

Normalmente, essas tabelas:

- existem apenas no contexto da conexão ou transação atual;
- são usadas para cálculos intermediários;
- permitem dividir uma lógica complexa em etapas mais claras;
- ajudam a reutilizar um resultado intermediário em várias consultas.

Em muitos SGBDs, tabelas temporárias são criadas com a palavra-chave `TEMPORARY` ou `TEMP`.

## Sintaxe básica

Uma das formas mais comuns de criar uma tabela temporária é a seguinte:

```sql
CREATE TEMPORARY TABLE table_name (
    column1 data_type,
    column2 data_type,
    column3 data_type
);
```

Depois disso, você pode trabalhar com a tabela temporária quase da mesma forma que com uma tabela comum: inserir dados, consultar, atualizar e remover.

## Exemplo de criação de tabela temporária

Suponha que queremos salvar a lista de clientes que fizeram mais de 30 pagamentos:

```sql
CREATE TEMPORARY TABLE active_customers AS
SELECT customer_id, COUNT(*) AS payment_count
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 30;
```

Agora podemos usar essa tabela temporária nas consultas seguintes:

```sql
SELECT ac.customer_id, ac.payment_count, c.first_name, c.last_name
FROM active_customers ac
JOIN customer c ON ac.customer_id = c.customer_id
ORDER BY ac.payment_count DESC;
```

*Resultado: obtemos a lista de clientes ativos e podemos reutilizar o conjunto de dados já preparado sem executar novamente a agregação original.*

---

## Como a tabela temporária difere da tabela comum

Embora tabelas temporárias e comuns sejam parecidas em estrutura, existem algumas diferenças importantes.

### 1. Tempo de vida

- **Uma tabela comum** permanece no banco de dados até que você a remova explicitamente.
- **Uma tabela temporária** existe por tempo limitado, geralmente até o fim da sessão ou da transação.

### 2. Finalidade

- **Uma tabela comum** é usada para armazenamento permanente de dados de negócio.
- **Uma tabela temporária** é usada para dados intermediários, técnicos ou preparatórios.

### 3. Escopo de visibilidade

- **Uma tabela comum** fica disponível para todos os usuários com as permissões necessárias.
- **Uma tabela temporária** normalmente é visível apenas na conexão atual.

### 4. Aplicação prática

- **Uma tabela comum** armazena clientes, pedidos, produtos, pagamentos e outras informações principais.
- **Uma tabela temporária** armazena resultados de filtragem intermediária, agregação ou preparação de dados para um relatório.

---

## Quando tabelas temporárias são especialmente úteis

Vale usar tabelas temporárias quando:

- a consulta é muito complexa e fica melhor dividida em etapas;
- o mesmo resultado intermediário é necessário mais de uma vez;
- é preciso armazenar temporariamente dados limpos ou agregados;
- você quer simplificar a leitura e a manutenção de um script SQL.

Por exemplo, primeiro podemos montar uma tabela temporária com os filmes desejados e depois calcular métricas apenas para eles.

```sql
CREATE TEMPORARY TABLE expensive_films AS
SELECT film_id, title, rental_rate
FROM film
WHERE rental_rate >= 4.00;

SELECT COUNT(*) AS film_count, AVG(rental_rate) AS avg_rate
FROM expensive_films;
```

*Resultado: a lógica é separada em duas etapas claras, preparação dos dados e análise.*

---

## Tabela temporária e CTE comum

Em alguns casos, pode-se usar um CTE (`WITH`) em vez de uma tabela temporária. A diferença é que:

- **um CTE** existe apenas dentro de uma única consulta;
- **uma tabela temporária** pode ser usada em várias consultas ao longo da sessão;
- **um CTE** é conveniente para uma lógica compacta dentro de uma instrução SQL;
- **uma tabela temporária** é conveniente quando o resultado intermediário precisa ser reutilizado.

Se o resultado for necessário apenas uma vez, o CTE costuma ser mais simples. Se ele for necessário em várias etapas, a tabela temporária normalmente é mais conveniente.

---

## Pontos de atenção

Ao trabalhar com tabelas temporárias, é útil lembrar algumas regras:

- não as use quando uma consulta simples já for suficiente;
- dê nomes claros às tabelas temporárias, refletindo sua finalidade;
- observe quando exatamente a tabela será removida no seu SGBD;
- não mantenha dados em tabelas temporárias por mais tempo do que o necessário;
- verifique particularidades de sintaxe no seu SGBD, pois o comportamento de `TEMPORARY TABLE` pode variar.

Quando bem usada, uma tabela temporária torna um SQL complexo mais legível e gerenciável.

---

## Exemplo prático

Imagine que precisamos encontrar clientes que alugaram filmes da categoria `Action` e depois montar um relatório separado para eles.

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

Essa abordagem é especialmente útil se, após essa lista, você precisar executar várias consultas analíticas adicionais.

---

**Principais conclusões desta lição:**

*   Tabelas temporárias são usadas para armazenamento temporário de dados intermediários.
*   Em geral, elas existem apenas no contexto da sessão ou transação atual.
*   Em sintaxe e uso, são parecidas com tabelas comuns, mas não são destinadas ao armazenamento permanente.
*   Tabelas temporárias são especialmente úteis em consultas complexas de múltiplas etapas e em cenários analíticos.
*   Se o resultado intermediário for necessário em apenas uma consulta, às vezes é melhor usar um CTE.

Na próxima lição, veremos como tabelas temporárias diferem de views e em quais casos é melhor usar cada uma dessas ferramentas.
