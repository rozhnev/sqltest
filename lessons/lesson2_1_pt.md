# Lição 2.1: Selecionando Dados de uma Tabela

## Selecionando Dados de uma Tabela

A operação mais fundamental em SQL é recuperar dados de uma tabela. A instrução `SELECT` é usada para esse propósito.

## Sintaxe Básica (Selecionando Todas as Colunas)

Para selecionar todas as colunas de uma tabela, você usa a sintaxe `SELECT *`:

```sql
SELECT *
FROM nome_da_tabela;
```

*   `SELECT`: Esta palavra-chave recupera dados da tabela.
*   `*` (Asterisco): Indica que todas as colunas da tabela devem ser recuperadas. O asterisco (*) atua como um caractere curinga representando todas as colunas na tabela.
*   `FROM nome_da_tabela`: Especifica a tabela da qual os dados devem ser recuperados. Substitua `nome_da_tabela` pelo nome real da tabela que você está consultando.

### Exemplo (Banco de Dados Sakila)

Para selecionar todas as colunas da tabela `actor` no banco de dados Sakila:

```sql
SELECT *
FROM actor;
```

Esta consulta retornará todas as linhas e todas as colunas (por exemplo, `actor_id`, `first_name`, `last_name`, `last_update`) da tabela `actor`.

### Evite Usar `*` para Selecionar Todas as Colunas

Usar `*` para selecionar todas as colunas geralmente não é recomendado. Embora possa parecer conveniente, pode levar a vários problemas:

*   **Impacto no Desempenho:** Recuperar todas as colunas pode aumentar a quantidade de dados transferidos, especialmente se a tabela tiver muitas colunas ou grandes conjuntos de dados.
*   **Alterações Não Intencionais:** Se o esquema da tabela for alterado (por exemplo, novas colunas forem adicionadas), as consultas que usam `*` podem retornar resultados inesperados.
*   **Legibilidade e Manutenção:** Especificar explicitamente as colunas torna a consulta mais fácil de entender e manter.

Em vez de usar `*`, é uma prática recomendada listar explicitamente as colunas de que você precisa. Essa abordagem garante clareza, reduz o risco de resultados não intencionais e melhora o desempenho da consulta.

## Selecionando Colunas Específicas

Para recuperar colunas específicas, liste seus nomes na instrução `SELECT`, separados por vírgulas:

```sql
SELECT coluna1, coluna2, coluna3
FROM nome_da_tabela;
```

*   `SELECT coluna1, coluna2, coluna3`: Especifica as colunas a serem recuperadas. Substitua `coluna1`, `coluna2` e `coluna3` pelos nomes reais das colunas.
*   `FROM nome_da_tabela`: Indica a tabela da qual recuperar os dados.

### Exemplo (Banco de Dados Sakila)

Para recuperar apenas as colunas `first_name` e `last_name` da tabela `actor`:

```sql
SELECT first_name, last_name
FROM actor;
```

Esta consulta retornará todas as linhas, mas apenas as colunas `first_name` e `last_name` para cada ator.

## Ordem das Colunas em SELECT

A ordem em que você lista as colunas na instrução `SELECT` determina sua ordem no conjunto de resultados. No entanto, isso não altera a ordem das colunas na própria tabela.

### Exemplo (Banco de Dados Sakila)

```sql
SELECT last_name, first_name
FROM actor;
```

Neste caso, a coluna `last_name` aparecerá antes da coluna `first_name` na saída, mesmo que `first_name` possa ser definida anteriormente na estrutura da tabela. A ordem na instrução `SELECT` substitui a ordem padrão das colunas da tabela.

**Principais Conclusões desta Lição:**

*   `SELECT *` recupera todas as colunas de uma tabela.
*   `SELECT coluna1, coluna2, ...` recupera apenas as colunas especificadas.
*   A ordem das colunas na instrução `SELECT` determina a ordem no conjunto de resultados.