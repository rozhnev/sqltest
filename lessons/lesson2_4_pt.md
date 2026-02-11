Esta lição foca em alias (apelidos) de colunas em SQL, uma técnica poderosa para renomear colunas nos resultados de suas consultas. Você aprenderá como usar a palavra-chave `AS` para criar nomes temporários que melhoram a legibilidade e a clareza da saída. Exploraremos as vantagens do uso de alias, como simplificar nomes de colunas complexos, evitar ambiguidades em junções e fornecer cabeçalhos amigáveis para colunas calculadas. Ao final desta lição, você será capaz de personalizar seus conjuntos de resultados para torná-los mais descritivos e fáceis de entender para análise e relatórios.

# Lição 2.4: Alias para Colunas

Nas lições anteriores, aprendemos como selecionar dados de tabelas. Às vezes, os nomes das colunas padrão em um banco de dados não são muito descritivos, ou você pode querer dar um novo nome a uma coluna que calculou. É aqui que entra o **Alias de Coluna**.

## O que é um Alias para Colunas?

O alias para colunas permite que você atribua um nome temporário e alternativo a uma coluna no conjunto de resultados de uma consulta `SELECT`. Isso não altera o nome real da coluna na tabela; afeta apenas como a coluna é exibida na saída da consulta.

## Sintaxe

Você pode criar um alias para uma coluna usando a palavra-chave `AS`, embora muitas vezes seja opcional:

```sql
SELECT column_name AS alias_name
FROM table_name;

-- OU (sem AS)

SELECT column_name alias_name
FROM table_name;
```

*   **`column_name`**: O nome da coluna para a qual você deseja criar um alias.
*   **`AS alias_name`**: A palavra-chave `AS` seguida pelo nome desejado do alias.
*   **`alias_name`**: O novo nome temporário para a coluna. Se o alias contiver espaços ou caracteres especiais, ele deve ser colocado entre aspas duplas (`"`).

## Vantagens de Usar Alias para Colunas

O uso de aliases oferece vários benefícios para a apresentação de dados e a construção de consultas:

*   **Melhor Legibilidade:** Os aliases podem tornar os nomes das colunas mais descritivos e fáceis de entender, especialmente ao lidar com consultas complexas ou colunas calculadas.
*   **Nomes de Colunas Simplificados:** Se o nome de uma coluna for longo ou contiver sublinhados, um alias pode fornecer um nome mais curto e gerenciável para uso no conjunto de resultados.
*   **Evitar Ambiguidade:** Ao unir tabelas com colunas que possuem o mesmo nome, os aliases podem ajudar a diferenciá-las na saída.
*   **Criar Saídas Mais Amigáveis:** Os aliases permitem personalizar os cabeçalhos das colunas no conjunto de resultados para torná-los mais significativos para usuários finais ou ferramentas de relatórios.
*   **Trabalhar com Colunas Calculadas:** Os aliases são essenciais ao criar colunas calculadas (por exemplo, usando funções ou expressões), pois essas colunas não possuem nomes próprios.

## Exemplos

Vamos ver alguns exemplos práticos usando a estrutura do banco de dados Sakila.

### Exemplo 1: Alias Básico
Esta consulta seleciona as colunas `first_name` e `last_name` da tabela `actor`, mas as exibe como "Nome Próprio" e "Sobrenome" no conjunto de resultados. Observe o uso de aspas duplas porque o alias contém um espaço.

```sql
SELECT first_name AS "Nome Próprio", last_name AS "Sobrenome"
FROM actor;
```

### Exemplo 2: Alias de Colunas Calculadas
Esta consulta calcula a duração do aluguel em dias e atribui o alias `rental_duration` à coluna calculada.

```sql
SELECT rental_date, return_date - rental_date AS rental_duration
FROM rental;
```

### Exemplo 3: Alias com Concatenação
Esta consulta concatena as colunas `first_name` e `last_name` para criar um nome completo e atribui o alias "Nome Completo" à coluna resultante.

```sql
SELECT first_name || ' ' || last_name AS "Nome Completo"
FROM actor;
```

> **Nota:** O operador `||` é usado para concatenação de strings no SQLite e PostgreSQL. Outros bancos de dados podem usar operadores ou funções diferentes (ex: `+` no SQL Server, função `CONCAT()` no MySQL).

---

**Principais conclusões desta lição:**

*   O alias de coluna fornece nomes temporários e descritivos para colunas no conjunto de resultados de uma consulta.
*   Use a palavra-chave `AS` (ou apenas um espaço) para criar um alias.
*   Coloque aliases com espaços ou caracteres especiais entre aspas duplas (`"`).
*   Os aliases melhoram a legibilidade, simplificam os nomes das colunas, evitam ambiguidades e são essenciais para colunas calculadas.

No próximo módulo, exploraremos como usar **Funções** para manipular e transformar ainda mais os dados em nossas consultas.
