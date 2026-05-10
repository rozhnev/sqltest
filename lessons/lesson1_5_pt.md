---
title: "Valores NULL em Bases de Dados Relacionais: Significado, IS NULL e Lógica"
description: "Saiba o que NULL significa em bases de dados relacionais, como difere de 0 e de uma string vazia, e como funcionam IS NULL, IS NOT NULL e os cálculos."
keywords: ["NULL bases de dados relacionais", "IS NULL", "IS NOT NULL", "NULL e string vazia", "NULL lógica SQL", "dados ausentes"]
teaches: ["O que NULL significa numa base de dados relacional", "Como NULL difere de 0, string vazia e false", "Porque as bases de dados usam NULL", "Como funcionam IS NULL e IS NOT NULL", "Como NULL se comporta em cálculos e comparações"]
about: ["NULL", "IS NULL", "IS NOT NULL", "Base de dados relacional", "Dados ausentes", "Lógica ternária"]
---

_Lição 1.5 · Tempo de leitura: ~7 min_

NULL é o marcador especial que uma base de dados relacional usa quando um valor está ausente, é desconhecido ou não se aplica. Nesta lição, vai perceber o que NULL realmente significa, como se distingue dos valores normais e como trabalhar com ele com segurança em testes e consultas simples.

# Valores NULL em Bases de Dados Relacionais: Significado, IS NULL e Lógica

Nas lições anteriores, vimos conceitos relacionais e tipos de dados. Agora é importante entender o que acontece quando uma coluna não tem um valor útil armazenado.

<img src="/images/lessons/lesson1_5-sql.jpg" alt="Ilustração mostrando NULL como valor ausente ou desconhecido em colunas de uma base de dados relacional" width="100%">

## O que significa NULL numa base de dados relacional?

**NULL** não é um valor normal. É um marcador especial que informa a base de dados de que o valor está ausente, é desconhecido ou não se aplica.

Isto é importante porque NULL não se comporta como texto, número ou valor booleano. Ele segue regras próprias em comparações, filtros e cálculos.

## O que NULL não é?

Para evitar confusão, lembre-se de que NULL **não é**:

* **NULL não é 0**: zero é um valor numérico real.
* **NULL não é uma string vazia**: `''` continua a ser texto, mesmo sem caracteres.
* **NULL não é false**: na lógica das bases de dados, NULL normalmente significa **desconhecido**.

## Porque é que as bases de dados usam NULL?

As bases de dados usam NULL quando um valor não pode ser preenchido normalmente.

Casos típicos:

* **Informação desconhecida**: por exemplo, ainda não sabemos o nome do meio de um cliente.
* **Não aplicável**: o NIF de empresa não se aplica a uma pessoa singular.
* **Dados em falta**: alguma informação foi omitida durante a introdução.

## Como funcionam IS NULL e IS NOT NULL?

Como NULL representa um estado desconhecido, operadores de comparação padrão como `=` e `<>` não funcionam corretamente com ele.

Por exemplo, `valor = NULL` não devolve verdadeiro. Para testar NULL corretamente, deve usar operadores específicos.

### IS NULL

`IS NULL` é usado para encontrar linhas onde uma coluna não contém valor:

```sql
SELECT *
FROM address
WHERE address2 IS NULL;
```

### IS NOT NULL

`IS NOT NULL` é usado para encontrar linhas onde uma coluna contém algum valor:

```sql
SELECT *
FROM address
WHERE address2 IS NOT NULL;
```

## Como é que NULL se comporta em cálculos e lógica?

Uma das regras mais importantes é que **NULL propaga-se frequentemente**. Se NULL participa num cálculo, o resultado costuma ser NULL.

* `10 + NULL = NULL`
* `5 * NULL = NULL`
* `'Olá ' + NULL = NULL`

A mesma ideia afeta comparações. Como NULL significa "desconhecido", muitas expressões com NULL não devolvem verdadeiro nem falso, mas um resultado desconhecido.

---

**Principais conclusões desta lição:**

* `NULL` representa dados ausentes, desconhecidos ou não aplicáveis.
* `NULL` é diferente de zero, string vazia e false.
* Comparações padrão como `=` e `<>` não servem para testar NULL.
* Use `IS NULL` e `IS NOT NULL` para verificar NULL corretamente.
* Cálculos com NULL muitas vezes devolvem NULL como resultado.

---

## Perguntas Frequentes

### NULL é o mesmo que uma string vazia?
Não. Uma string vazia continua a ser um valor de texto com comprimento zero. `NULL` significa que não existe um valor conhecido armazenado.

### Porque `valor = NULL` não funciona?
Porque NULL representa um estado desconhecido, e os operadores de comparação normais não foram feitos para testar esse estado. Para isso, usa-se `IS NULL`.

### NULL pode aparecer numa coluna numérica?
Sim. NULL não pertence a um único tipo de dados. Uma coluna numérica, de texto ou de data pode conter NULL, desde que uma restrição não o impeça.

## Questões de Entrevista

### Como explicaria NULL numa entrevista?
NULL é um marcador especial que representa dados ausentes, desconhecidos ou não aplicáveis. Não é o mesmo que zero, false ou string vazia, e segue regras próprias em comparações e cálculos.

### Porque se usa IS NULL em vez de = NULL?
Porque NULL representa um estado desconhecido. Os operadores `=` e `<>` funcionam com valores normais, enquanto SQL fornece `IS NULL` e `IS NOT NULL` para testar NULL corretamente.

### Qual é um erro comum ao trabalhar com NULL?
Um erro comum é tratar NULL como um valor normal em filtros, condições ou cálculos. Isso costuma gerar resultados inesperados em consultas.

Na próxima lição, vamos introduzir o próprio SQL e ver a estrutura básica de uma consulta.
