---
title: "SQL SELECT: seleção de dados e DISTINCT para valores únicos"
description: "Aprenda o básico de SELECT em SQL: escolher todas ou apenas algumas colunas, definir a ordem de saída e usar DISTINCT para remover duplicatas."
keywords: ["SQL SELECT", "selecao de dados SQL", "SELECT DISTINCT", "valores unicos SQL", "SQL basico", "Sakila"]
teaches: ["Como selecionar todas as colunas ou apenas as necessárias com SELECT", "Por que SELECT * nem sempre é a melhor opção", "Como usar DISTINCT para retornar valores únicos", "Como a ordem das colunas em SELECT afeta o resultado"]
about: ["SQL", "SELECT", "DISTINCT", "Sakila", "Banco de dados relacional"]
---

_Lição 2.1 · Tempo de leitura: ~6 min_

# Selecionando Dados de uma Tabela

## Selecionando Dados de uma Tabela

A operação mais fundamental em SQL é recuperar dados de uma tabela. A instrução `SELECT` é usada para esse propósito.

<img src="/images/lessons/lesson2_1-select-distinct.svg" alt="Guia visual de SQL SELECT e DISTINCT" width="100%">

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

## Selecionando Valores Únicos com `DISTINCT`

Às vezes, você não precisa de todas as linhas, mas apenas de valores únicos em uma coluna (ou em um conjunto de colunas). Para isso, use a palavra-chave `DISTINCT`.

### Sintaxe Básica

```sql
SELECT DISTINCT nome_da_coluna
FROM nome_da_tabela;
```

`DISTINCT` remove duplicatas do resultado e mantém apenas linhas únicas.

### Exemplo (Banco de Dados Sakila)

Vamos obter uma lista de classificações de filmes únicas:

```sql
SELECT DISTINCT rating
FROM film;
```

Esta consulta retorna cada valor de `rating` apenas uma vez.

### `DISTINCT` com Múltiplas Colunas

Você também pode aplicar `DISTINCT` a várias colunas. Nesse caso, a unicidade é determinada pela **combinação** dos valores.

```sql
SELECT DISTINCT rating, rental_duration
FROM film;
```

Aqui, as duplicatas são removidas com base no par `rating + rental_duration`.

### Quando Usar `DISTINCT`

`DISTINCT` é útil quando você:

*   monta listas de referência (por exemplo, categorias, status ou classificações únicas);
*   verifica a qualidade dos dados (existem valores repetidos inesperados?);
*   prepara dados para filtros e interfaces.

> Se você precisa apenas verificar alguns valores em uma coluna, `IN (...)` no `WHERE` costuma ser uma opção melhor. Use `DISTINCT` especificamente para remover duplicatas do conjunto de resultados.

## Ordem das Colunas em SELECT

A ordem em que você lista as colunas na instrução `SELECT` determina sua ordem no conjunto de resultados. No entanto, isso não altera a ordem das colunas na própria tabela.

### Exemplo (Banco de Dados Sakila)

```sql
SELECT last_name, first_name
FROM actor;
```

Neste caso, a coluna `last_name` aparecerá antes da coluna `first_name` na saída, mesmo que `first_name` possa ser definida anteriormente na estrutura da tabela. A ordem na instrução `SELECT` substitui a ordem padrão das colunas da tabela.

## Perguntas frequentes

### Posso usar `SELECT *` em projetos reais?
Sim, mas com intencao. Ele e util para testes rapidos e depuracao, enquanto em producao costuma ser mais seguro listar apenas as colunas necessarias.

### A ordem das colunas em `SELECT` muda a estrutura da tabela?
Nao. Ela muda apenas a ordem das colunas no resultado da consulta. A estrutura da tabela no banco permanece igual.

### Por que evitar `SELECT *` em APIs e relatorios?
Porque mudancas no esquema podem adicionar colunas automaticamente ao resultado. Isso pode quebrar contratos de API, relatorios ou codigo cliente que espera um conjunto fixo de campos.

## Perguntas de entrevista

### Qual e o risco pratico de `SELECT *`?
Os principais riscos sao transferencia desnecessaria de dados, menor estabilidade quando o esquema muda e menor legibilidade. Em codigo de producao, normalmente se espera lista explicita de colunas.

### Quando `DISTINCT` pode deixar a consulta mais lenta?
Em grandes volumes de dados, porque o banco precisa fazer trabalho extra para remover duplicatas (geralmente ordenacao ou hashing). Use `DISTINCT` quando a unicidade for realmente necessaria.

### O que `SELECT DISTINCT a, b` retorna?
Retorna pares unicos `(a, b)`, e nao valores unicos de cada coluna separadamente.

### Como escolher entre `DISTINCT` e filtro com `WHERE`?
Use `WHERE` para filtrar linhas por condicoes. Use `DISTINCT` para remover duplicatas das linhas que ja foram selecionadas.

---

**Principais Conclusões desta Lição:**

*   `SELECT *` recupera todas as colunas de uma tabela.
*   `SELECT coluna1, coluna2, ...` recupera apenas as colunas especificadas.
*   `SELECT DISTINCT nome_da_coluna` retorna apenas valores únicos, sem duplicatas.
*   A ordem das colunas na instrução `SELECT` determina a ordem no conjunto de resultados.