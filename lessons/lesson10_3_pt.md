---
title: "EXPLAIN e plano de execucao: encontrando gargalos em consultas SQL"
description: "O plano de execucao mostra como o SGBD executa SQL. Aprenda EXPLAIN, tipos de acesso e metricas-chave para diagnosticar consultas lentas."
keywords: ["EXPLAIN SQL", "plano de execucao", "otimizacao SQL", "Full Table Scan", "indices SQL", "diagnostico de consultas"]
teaches: ["O que um plano de execucao mostra", "Como ler saida do EXPLAIN", "Como identificar Full Table Scan e gargalos", "Como interpretar type, key e rows", "Como definir direcao de otimizacao com base no plano"]
about: ["SQL", "EXPLAIN", "Plano de execucao", "Otimizador de SGBD", "Performance de consultas"]
---

_Licao 10.3 · Tempo de leitura: ~9 min_

Esta licao apresenta ferramentas praticas para analise e otimizacao de consultas SQL. Voce vai aprender como o banco "le" sua consulta, o que e um plano de execucao e como encontrar gargalos. Vamos usar `EXPLAIN` e interpretar os campos mais importantes. Ao final, voce conseguira diagnosticar com seguranca por que uma consulta esta lenta.

# Licao 10.3: Entendendo metodos de otimizacao de consultas

Na licao anterior, vimos principios para escrever SQL eficiente. Mas e se a consulta continuar lenta? Em vez de adivinhar, precisamos analisar. Sempre que uma consulta e executada, o otimizador do SGBD monta um plano de execucao.

Entender esse plano e a chave para uma otimizacao mais profunda. Nesta licao, vamos olhar para dentro do mecanismo do banco usando a principal ferramenta de diagnostico: o plano de execucao.

<img src="/images/lessons/lesson10_3-query-optimization.svg" alt="Diagrama de analise de plano de execucao SQL com EXPLAIN para identificar gargalos de desempenho" width="100%">

---

## O que e plano de execucao

Plano de execucao e um conjunto detalhado de etapas que o SGBD prepara para executar uma consulta SQL. Ele descreve:

- A ordem de juncoes entre tabelas.
- Metodos de acesso (varredura de tabela ou busca por indice).
- Quantidade estimada de linhas em cada etapa.
- Custo estimado (`cost`) das operacoes.

---

## Usando `EXPLAIN`

Nos principais SGBDs relacionais (MySQL, PostgreSQL, MariaDB), a principal ferramenta de analise e `EXPLAIN`.

### Sintaxe basica

Basta adicionar `EXPLAIN` antes da consulta:

```sql
EXPLAIN
SELECT customer_id, first_name, last_name
FROM customer
WHERE active = 1;
```

*Resultado: o SGBD retorna uma tabela em que cada linha representa uma etapa de execucao.*

---

## O que observar na analise

### 1. Tipo de acesso (`type` ou `access_type`)

Esse campo mostra como as linhas sao buscadas:

- **`const` / `eq_ref`**: excelente.
- **`ref`**: muito bom.
- **`range`**: bom.
- **`index`**: mediano.
- **`ALL`**: arriscado em tabelas grandes (varredura completa).

### 2. Indices usados (`key` / `possible_keys`)

Mostra qual indice o otimizador escolheu. Se `key` for `NULL`, nenhum indice adequado foi usado.

### 3. Quantidade de linhas (`rows`)

E a estimativa de linhas que o SGBD precisa examinar. Quanto menor, menor tende a ser o trabalho.

---

## Exemplo pratico: encontrando o problema

Suponha a consulta abaixo:

```sql
EXPLAIN
SELECT * 
FROM payment 
WHERE payment_date = '2005-05-25 11:30:37';
```

Se `type` mostrar `ALL` e `key` mostrar `NULL`, o indice por data esta ausente ou nao esta sendo usado.

**Direcao de correcao:**
O passo mais comum e criar indice na coluna usada no `WHERE`. Na proxima licao veremos indices em detalhe, mas e o `EXPLAIN` que evidencia a necessidade.

---

## Tecnicas de otimizacao em tempo real

1. **Otimizacao de subconsultas:** trocar subconsultas aninhadas por `JOIN` pode gerar plano melhor.
2. **Materializacao:** para logicas pesadas e reutilizadas, considere views materializadas ou tabelas temporarias.
3. **Simplificacao de logica:** `DISTINCT` e `ORDER BY` desnecessarios podem bloquear melhorias do otimizador.

---

**Principais conclusoes desta licao:**

*   O plano de execucao e o principal documento de como o SGBD executa sua consulta.
*   Use `EXPLAIN` para ver como os dados sao acessados de fato.
*   Evite `ALL` (Full Table Scan) em tabelas grandes.
*   `rows` ajuda a estimar a carga de processamento.
*   Se `key` for `NULL`, revise indices e predicados SARGable.

---

## Perguntas frequentes

### Por que rodar `EXPLAIN` se a consulta ja esta rapida?
Porque ele mostra riscos antes de o volume de dados crescer. Uma consulta aceitavel hoje pode degradar bastante depois.

### Qual sinal mais preocupante no plano?
Em tabelas grandes, `ALL` costuma ser sinal de alerta por indicar varredura completa.

### Por que `rows` e tao importante?
`rows` estima quanto trabalho o SGBD espera fazer. Valores altos normalmente apontam por onde comecar a otimizacao.

## Perguntas de entrevista

### O que e um plano de execucao SQL?
E a estrategia montada pelo **otimizador do SGBD** para produzir o resultado. Mostra ordem de operacoes, metodos de acesso e custos estimados.

### Quais campos do EXPLAIN voce verifica primeiro?
Comeco por **type/access_type**, **key/possible_keys** e **rows**. Esses campos revelam rapidamente uso de indice e possiveis gargalos.

### Como identificar, pelo EXPLAIN, que falta indice?
Se `key` aparece como `NULL` com frequencia e o acesso indica varredura, vale revisar indexacao nas colunas de `WHERE` e `JOIN`.

Na proxima licao, vamos para o recurso mais poderoso de aceleracao: indices.

-> [Indice do curso](course.md)
