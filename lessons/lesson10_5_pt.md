---
title: "Como os Índices B-tree Funcionam em SQL: Estrutura, Busca e Intervalos"
description: "Entenda como os índices B-tree são estruturados em SQL, por que aceleram a busca para complexidade logarítmica e como usá-los em consultas práticas."
keywords: ["índice B-tree", "como funcionam os índices SQL", "índices SQL", "busca por índice", "busca de intervalo SQL", "desempenho de banco de dados"]
teaches: ["Como os níveis do índice B-tree são organizados", "Por que a busca por índice é executada rapidamente", "Como B-tree ajuda com igualdade, intervalos e ordenação", "Como ler o uso de B-tree em EXPLAIN", "Quais condições impedem que B-tree funcione com eficiência"]
about: ["SQL", "B-tree", "Índices", "Otimização de consultas", "Desempenho de banco de dados"]
---

_Lição 10.5 · Tempo de leitura: ~11 min_

Esta lição explica em detalhes como os índices B-tree funcionam em SQL no nível físico e lógico. Você aprenderá quais nós compõem a estrutura, como o banco de dados percorre a árvore e por que essa abordagem acelera a filtragem e a classificação. Veremos exemplos práticos nas tabelas Sakila e reforçaremos as regras de uso importantes. Ao final da lição, você entenderá melhor quando um índice B-tree realmente acelera as consultas.

# Como os Índices B-tree Funcionam

Na lição anterior, você aprendeu como criar índices. Agora vamos entender como um índice é organizado internamente e por que acelera a busca.

Entender B-tree ajudará você a ver quando um índice realmente funciona e quando não pode ser usado. Esse conhecimento será útil ao otimizar consultas lentas.

<img src="/images/lessons/lesson10_5-btree-index.svg" alt="Esquema de como os índices B-tree funcionam em SQL: raiz, nós internos, folhas e caminho de busca" width="100%">

---

## O que é um Índice B-tree

Um índice B-tree é como um índice em um livro. Em vez de ler todas as páginas em sequência, você abre o índice, encontra o capítulo que precisa e vai direto para lá.

Um B-tree tem três níveis:

- **nó raiz** - o ponto de partida da busca, como a capa de um índice;
- **nós intermediários** - sugerem qual direção seguir em seguida;
- **nós folha** - contêm os valores que você precisa e links para as linhas da tabela.

Toda a estrutura é classificada, então o banco de dados pode escolher rapidamente a direção certa em cada nível.

Aqui está o que parece:

```
                    [ ROOT ]
                   /   |   \
                  /    |    \
            [NODE A] [NODE B] [NODE C]
            / |  \    / | \    / | \
           /  |   \  /  |  \  /  |  \
         [L1][L2][L3][L4][L5][L6][L7][L8]
```

Cada nó contém valores que ajudam a selecionar o próximo nó. Os nós folha (L1–L8) contêm os dados que você precisa.

---

## Como a Busca por B-tree Funciona

Quando você busca `WHERE last_name = 'SMITH'`, o banco de dados:

1. começa pelo nó raiz;
2. seleciona o ramo onde nomes começando com 'S' podem estar;
3. desce, refinando a busca em cada nível;
4. encontra o nome que você precisa em um nó folha.

Graças a esse algoritmo, a busca é muito rápida — mesmo em uma tabela com milhões de linhas, você só precisa verificar alguns níveis.

---

## Quais Operações o B-tree Acelera Melhor

### Igualdade (`=`)

B-tree é bem adequado para buscas de valores exatos.

```sql
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

### Intervalos (`>`, `<`, `BETWEEN`)

Porque as chaves são classificadas, B-tree é eficiente para condições de intervalo.

```sql
SELECT
   payment_id,
   amount,
   payment_date
FROM payment
WHERE payment_date >= '2005-07-01'
  AND payment_date < '2005-08-01';
```

### Classificação (`ORDER BY`)

Se a ordem de classificação corresponder ao índice, o banco de dados muitas vezes pode evitar uma classificação separada cara.

```sql
SELECT
   payment_id,
   customer_id,
   payment_date
FROM payment
WHERE customer_id = 10
ORDER BY payment_date;
```

---

## Exemplo de um Índice B-tree Composto

Vamos criar um índice para um padrão comum de filtragem e classificação:

```sql
CREATE INDEX idx_payment_customer_date
ON payment (customer_id, payment_date);
```

Vamos verificar o plano:

```sql
EXPLAIN
SELECT
   payment_id,
   customer_id,
   payment_date,
   amount
FROM payment
WHERE customer_id = 10
  AND payment_date >= '2005-07-01'
ORDER BY payment_date;
```

*Resultado: geralmente o banco de dados usa o índice para filtrar por `customer_id` e o intervalo `payment_date`, bem como para leitura ordenada.*

---

## Regra do Prefixo Esquerdo para Índices Compostos

Se um índice for criado como `(customer_id, payment_date)`, o banco de dados o usa melhor se a condição filtrar **primeiro** por `customer_id`.

**Funciona bem:**
```sql
WHERE customer_id = 10
```

**Funciona bem:**
```sql
WHERE customer_id = 10 AND payment_date >= '2005-01-01'
```

**Funciona mal:**
```sql
WHERE payment_date >= '2005-01-01'
```

Esta regra é chamada de "prefixo esquerdo": o índice funciona melhor quando você usa as condições da esquerda para a direita.

---

## Quando um Índice Não Ajuda

Um índice não é usado se:

- você aplica uma função a uma coluna: `WHERE YEAR(payment_date) = 2005` — o índice não funciona;
- você usa uma máscara no início: `WHERE name LIKE '%SMITH'` — o índice não ajudará;
- a condição é muito geral e retorna muitas linhas — o índice pode ser mais lento que ler toda a tabela.

**Ruim (função impede o uso do índice):**
```sql
SELECT payment_id, payment_date
FROM payment
WHERE YEAR(payment_date) = 2005;
```

**Bom (o índice pode funcionar):**
```sql
SELECT payment_id, payment_date
FROM payment
WHERE payment_date >= '2005-01-01'
  AND payment_date < '2006-01-01';
```

---

## Recomendações Práticas

- Indexe campos que aparecem frequentemente em `WHERE`, `JOIN`, `ORDER BY`.
- Para índices compostos, coloque primeiro a coluna mais importante para filtragem.
- Verifique o uso real do índice através de `EXPLAIN`.
- Não crie índices redundantes: eles aumentam o custo das escritas.

---

**Pontos-chave desta lição:**

- B-tree é uma estrutura equilibrada que acelera a busca por chave.
- A principal força do B-tree: igualdade, intervalos e classificação por ordem de índice.
- Índices compostos seguem a regra do prefixo esquerdo.
- Uma forma de condição inadequada pode privar uma consulta dos benefícios do índice.
- `EXPLAIN` ajuda você a entender se B-tree é usado no plano de execução real.

## Perguntas de Entrevista

### Por que um índice B-tree geralmente é mais rápido que uma varredura completa?
Porque o banco de dados percorre a árvore ao longo dos ramos e encontra o intervalo necessário em um número logarítmico de passos, em vez de varrer todas as linhas da tabela.

### O que é a regra do prefixo esquerdo para um índice composto?
Esta regra significa que o otimizador usa o índice melhor quando começa pela primeira coluna da chave e procede em ordem.

### Como você verifica na prática que um índice B-tree está sendo usado?
Você executa `EXPLAIN` e observa o tipo de acesso, a chave escolhida e o número esperado de linhas em cada estágio de execução.

Na próxima lição, passaremos para o tratamento de erros e técnicas de depuração SQL.
