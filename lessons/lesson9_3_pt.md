Esta lição apresenta as tabelas temporárias, um tipo especial de tabela que existe por tempo limitado e normalmente é usado para resultados intermediários de cálculos. Você vai aprender o que são tabelas temporárias, como criá-las, em que elas diferem das tabelas comuns e em quais tarefas são especialmente úteis. Ao final da lição, você conseguirá usar tabelas temporárias com confiança para simplificar cenários SQL complexos.

# Lição 9.3: Tabelas temporárias

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

O nome de uma tabela temporária não deve coincidir com o nome de uma tabela permanente já existente, por isso é recomendável usar um prefixo como `temp_`.

Depois disso, você pode trabalhar com a tabela temporária quase da mesma forma que com uma tabela comum: inserir dados, consultar, atualizar e remover.

## Exemplo de criação de tabela temporária

Suponha que queremos salvar a lista de clientes que fizeram mais de 30 pagamentos:

```sql
CREATE TEMPORARY TABLE tmp_active_customers AS
SELECT customer_id, COUNT(*) AS payment_count
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 30;
```

Agora podemos usar essa tabela temporária nas consultas seguintes:

```sql
SELECT ac.customer_id, ac.payment_count, c.first_name, c.last_name
FROM tmp_active_customers ac
JOIN customer c ON ac.customer_id = c.customer_id
ORDER BY ac.payment_count DESC;

SELECT COUNT(*) AS active_customer_count,
       AVG(payment_count) AS avg_payment_count,
       MAX(payment_count) AS max_payment_count
FROM tmp_active_customers;
```

*Resultado: na primeira consulta, obtemos a lista de clientes ativos, e na segunda calculamos métricas de resumo sobre o mesmo conjunto intermediário de dados. Essa é uma das principais vantagens de uma tabela temporária: ao contrário de uma subconsulta ou de um CTE, ela pode ser reutilizada em várias consultas separadas sem reescrever a mesma lógica.*

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

### 5. Durabilidade dos dados

- **Uma tabela comum** normalmente faz parte do armazenamento durável e é destinada à guarda permanente de dados.
- **Uma tabela temporária** normalmente não é tratada como armazenamento durável: seus dados são necessários apenas durante a sessão ou durante etapas intermediárias de processamento e, em geral, não devem sobreviver ao fim do trabalho.

---

## Quando tabelas temporárias são especialmente úteis

Vale usar tabelas temporárias quando:

- a consulta é muito complexa e fica melhor dividida em etapas;
- o mesmo resultado intermediário é necessário mais de uma vez;
- é preciso armazenar temporariamente dados limpos ou agregados;
- você quer simplificar a leitura e a manutenção de um script SQL.

Por exemplo, primeiro podemos montar uma tabela temporária com os filmes desejados e depois calcular métricas apenas para eles.

```sql
CREATE TEMPORARY TABLE tmp_expensive_films AS
SELECT film_id, title, rental_rate
FROM film
WHERE rental_rate >= 4.00;

SELECT COUNT(*) AS film_count, AVG(rental_rate) AS avg_rate
FROM tmp_expensive_films;
```

*Resultado: a lógica é separada em duas etapas claras, preparação dos dados e análise.*

---

## Tabela temporária e CTE comum

Em alguns casos, pode-se usar um CTE (`WITH`) ou uma subconsulta em vez de uma tabela temporária. A diferença é que:

- **um CTE** existe apenas dentro de uma única consulta;
- **uma subconsulta** também existe apenas dentro da consulta em que foi escrita;
- **uma tabela temporária** pode ser usada em várias consultas ao longo da sessão;
- **um CTE** é conveniente para uma lógica compacta dentro de uma instrução SQL;
- **uma tabela temporária** é conveniente quando o resultado intermediário precisa ser reutilizado em duas ou mais consultas separadas.

Se o resultado for necessário apenas uma vez, um CTE ou uma subconsulta costuma ser mais simples. Se ele for necessário em várias etapas, a tabela temporária normalmente é mais conveniente, porque não exige reescrever a mesma consulta intermediária em cada etapa seguinte.

---

## Tabelas temporárias em memória

Em alguns SGBDs, você pode criar explicitamente uma tabela temporária para que ela fique armazenada na memória RAM. Isso pode acelerar bastante o acesso aos dados, especialmente quando a tabela é pequena e usada intensamente em várias etapas do mesmo cenário.

Por exemplo, no MySQL ou MariaDB, você pode indicar explicitamente o mecanismo da tabela:

```sql
CREATE TEMPORARY TABLE tmp_fast_result (
    customer_id INT,
    total_amount DECIMAL(10, 2)
) ENGINE = MEMORY;
```

Essa abordagem exige a definição explícita do `ENGINE` adequado na criação da tabela. Ela deve ser usada com cuidado: a memória RAM é limitada, e tabelas temporárias muito grandes podem gerar carga desnecessária no servidor.

---

## Pontos de atenção

Ao trabalhar com tabelas temporárias, é útil lembrar algumas regras:

- não as use quando uma consulta simples já for suficiente;
- dê nomes claros às tabelas temporárias, refletindo sua finalidade, e use um prefixo como `tmp_` para nomes de tabelas temporárias;
- não espere das tabelas temporárias o mesmo nível de durabilidade que das tabelas comuns;
- coloque tabelas temporárias na memória apenas quando isso for realmente justificado pelo volume de dados e pela carga;
- observe quando exatamente a tabela será removida no seu SGBD;
- não mantenha dados em tabelas temporárias por mais tempo do que o necessário;
- verifique particularidades de sintaxe no seu SGBD, pois o comportamento de `TEMPORARY TABLE` pode variar.

Quando bem usada, uma tabela temporária torna um SQL complexo mais legível e gerenciável.

---

## Exemplo prático

Imagine que precisamos encontrar clientes que alugaram filmes da categoria `Action` e depois montar um relatório separado para eles.

```sql
CREATE TEMPORARY TABLE tmp_action_customers AS
SELECT DISTINCT r.customer_id
FROM rental r
JOIN inventory i      ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
WHERE c.name = 'Action';

SELECT ac.customer_id, cu.first_name, cu.last_name
FROM tmp_action_customers ac
JOIN customer cu ON ac.customer_id = cu.customer_id
ORDER BY cu.last_name, cu.first_name;

SELECT COUNT(*) AS action_customer_count
FROM tmp_action_customers;
```

Essa abordagem é especialmente útil se, após essa lista, você precisar executar várias consultas analíticas adicionais. Por exemplo, depois de obter a lista de clientes, você pode calcular imediatamente a quantidade total deles sem repetir toda a lógica original de seleção.

É exatamente essa a diferença importante em relação a subconsultas e CTEs: uma tabela temporária pode ser criada uma vez e depois reutilizada sequencialmente em várias consultas independentes.

---

**Principais conclusões desta lição:**

*   Tabelas temporárias são usadas para armazenamento temporário de dados intermediários.
*   Em geral, elas existem apenas no contexto da sessão ou transação atual e são removidas automaticamente, a menos que outra coisa seja definida na criação da tabela, mas na prática é melhor removê-las explicitamente.
*   Em sintaxe e uso, são parecidas com tabelas comuns, mas não são destinadas ao armazenamento permanente.
*   Tabelas temporárias normalmente não são usadas como armazenamento durável no sentido de `Durability`.
*   Tabelas temporárias são especialmente úteis em consultas complexas de múltiplas etapas e em cenários analíticos.
*   Em alguns SGBDs, pequenas tabelas temporárias podem ser colocadas na memória, mas isso deve ser feito com cuidado.
*   Se o resultado intermediário for necessário em apenas uma consulta, às vezes é melhor usar um CTE.

Na próxima lição, veremos como tabelas temporárias diferem de views e em quais casos é melhor usar cada uma dessas ferramentas.
