Aprenda a usar o SQL CROSS JOIN para criar um Produto Cartesiano de duas tabelas. Esta lição explica quando cada linha de uma tabela é combinada com cada linha de outra, as implicações de desempenho de grandes conjuntos de dados e casos de uso práticos, como gerar combinações ou dados de teste. Domine o comportamento do CROSS JOIN usando o banco de dados Sakila.

# Lição 5.6: CROSS JOIN - O Produto Cartesiano

Enquanto a maioria das junções exige uma condição de correspondência específica (a cláusula `ON`), o **CROSS JOIN** é diferente. Ele retorna todas as combinações possíveis de linhas das tabelas unidas. Esse resultado é conhecido matematicamente como um **Produto Cartesiano**.

## O que é um CROSS JOIN?

Um `CROSS JOIN` produz um conjunto de resultados onde o número de linhas é o resultado da multiplicação do número de linhas na primeira tabela pelo número de linhas na segunda tabela. Nenhuma condição é usada para corresponder às linhas; cada linha na Tabela A simplesmente encontra cada linha na Tabela B.

**Visualização:**
```
   Tabela A (Cores)             Tabela B (Tamanhos)
   +-----------+                +-----------+
   | cor       |                | tamanho   |
   +-----------+                +-----------+
   | Vermelho  |  --\           | Pequeno   |
   | Azul      |  ---|------>   | Médio     |
   +-----------+  --/           | Grande    |
                                +-----------+

   Resultado (Combinações):
   Vermelho, Pequeno
   Vermelho, Médio
   Vermelho, Grande
   Azul, Pequeno
   Azul, Médio
   Azul, Grande
```
*Se a Tabela A tiver 2 linhas e a Tabela B tiver 3 linhas, o resultado terá 2 x 3 = 6 linhas.*

## Sintaxe do CROSS JOIN

Existem duas maneiras de escrever um CROSS JOIN. A forma explícita é preferida para maior clareza:

```sql
-- Sintaxe Explícita (Recomendada)
SELECT
    table1.column,
    table2.column
FROM
    table1
CROSS JOIN
    table2;

-- Sintaxe Implícita (Estilo Antigo)
SELECT
    table1.column,
    table2.column
FROM
    table1,
    table2;
```

> **Aviso:** Seja extremamente cuidadoso ao usar `CROSS JOIN` em tabelas grandes. Unir duas tabelas com 1.000 linhas cada produzirá 1.000.000 de linhas!

## Exemplos Práticos (Banco de Dados Sakila)

### 1. Gerando Todas as Combinações Possíveis
Imagine que queiramos criar um relatório ou uma grade que mostre todas as categorias de filmes para cada loja, mesmo que essa loja não tenha filmes nessa categoria no momento.

```sql
SELECT
    s.store_id,
    c.name AS nome_categoria
FROM
    store AS s
CROSS JOIN
    category AS c;
```
*Isso produz uma lista de todas as categorias para a Loja 1, seguida de todas as categorias para a Loja 2.*

### 2. Criando Dados de Teste ou Matrizes
O `CROSS JOIN` é frequentemente usado para gerar grandes conjuntos de permutações para testes ou para construir calendários/agendas onde você precisa ver todos os intervalos de tempo para todos os usuários.

## Quando Usar CROSS JOIN

- **Gerando Permutações:** Quando você precisa de uma lista de todas as combinações possíveis (ex: todas as cores de produtos vs. todos os tamanhos de produtos).
- **Preenchendo Lacunas:** Quando usado com `LEFT JOIN`, pode ajudar a identificar combinações ausentes em seus dados.
- **Relatórios:** Para criar o "esqueleto" de um relatório que deve incluir todas as categorias, mesmo aquelas com valores zero.

## Principais Conclusões desta Lição

- **CROSS JOIN** retorna o **Produto Cartesiano** de duas tabelas.
- Ele **não** usa uma cláusula `ON` (sem condição de correspondência).
- O número de linhas no resultado é o **produto** da contagem de linhas de ambas as tabelas.
- Use-o com cautela em grandes conjuntos de dados para evitar problemas de desempenho.
