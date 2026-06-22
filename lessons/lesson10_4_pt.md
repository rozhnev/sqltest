---
title: "Introducao aos indices SQL: como acelerar consultas na pratica"
description: "Aprenda o que sao indices SQL, como eles afetam a velocidade de consultas SELECT e quais regras basicas evitam erros comuns de performance."
keywords: ["indices SQL", "introducao a indices", "performance SQL", "aceleracao de consultas", "CREATE INDEX", "EXPLAIN SQL"]
teaches: ["O que e um indice e por que ele importa", "Como indices aceleram leitura e impactam escrita", "Como criar indices simples e compostos", "Como validar uso de indice com EXPLAIN", "Quais padroes de consulta podem impedir uso de indice"]
about: ["SQL", "Indices", "Performance de banco de dados", "Otimizacao de consultas", "EXPLAIN"]
---

_Licao 10.4 · Tempo de leitura: ~10 min_

Esta licao introduz indices SQL e seu papel na performance de consultas. Voce vai aprender o que e um indice, como ele ajuda a encontrar dados mais rapido e por que, em alguns casos, pode deixar operacoes de modificacao mais lentas. Vamos ver exemplos basicos de criacao e verificacao de indices usando tabelas Sakila. Ao final da licao, voce conseguira usar indices de forma mais consciente para acelerar consultas reais.

# Introducao aos indices SQL

Na licao anterior, aprendemos a ler plano de execucao com `EXPLAIN` e encontrar gargalos. O proximo passo logico e entender o principal mecanismo de aceleracao de busca: indices.

Indices estao diretamente ligados a como o SGBD procura linhas. Sem indice, o servidor frequentemente varre a tabela inteira. Com um indice adequado, ele pode chegar aos dados relevantes muito mais rapido.

<img src="/images/lessons/lesson10_4-sql-indexes.svg" alt="Introducao a indices SQL e impacto dos indices na performance de consultas" width="100%">

---

## O que e um indice

Um indice SQL e uma estrutura de dados adicional que ajuda o SGBD a encontrar linhas mais rapidamente por valores de coluna.

Uma analogia simples e o indice de um livro. Em vez de ler todas as paginas, voce usa o indice e vai direto para a secao desejada.

Em bancos relacionais, indices B-tree sao os mais comuns e funcionam bem para:

- buscas exatas (`=`);
- intervalos (`>`, `<`, `BETWEEN`);
- ordenacao (`ORDER BY`) em colunas indexadas.

---

## Como o indice afeta a performance

### Acelera leitura (`SELECT`)

Quando a condicao `WHERE` usa uma coluna indexada, o SGBD pode localizar linhas sem varrer a tabela inteira.

### Pode deixar escrita mais lenta (`INSERT`, `UPDATE`, `DELETE`)

Todo indice precisa ser mantido atualizado. Quando os dados mudam, o SGBD atualiza a tabela e os indices relacionados.

### Ocupa espaco adicional

Indices sao armazenados separadamente e consomem disco. Criar indice em todas as colunas normalmente e uma estrategia ruim.

---

## Sintaxe basica

Criacao de indice simples:

```sql
CREATE INDEX idx_customer_last_name
ON customer (last_name);
```

Remocao de indice (sintaxe varia por SGBD):

```sql
DROP INDEX idx_customer_last_name ON customer;
```

*Observacao: no PostgreSQL, a forma e `DROP INDEX index_name;` sem nome de tabela.*

---

## Exemplo 1: acelerando filtro em uma coluna

Suponha que buscamos clientes por sobrenome com frequencia:

```sql
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

Sem indice em `last_name`, o SGBD pode fazer varredura completa de `customer`. Depois de criar o indice, o acesso costuma mudar para um tipo mais eficiente.

Validacao com `EXPLAIN`:

```sql
EXPLAIN
SELECT
   customer_id,
   first_name,
   last_name
FROM customer
WHERE last_name = 'SMITH';
```

*Resultado: no plano de execucao, voce deve ver uso de indice (`key`/`possible_keys` no MySQL ou `Index Scan` no PostgreSQL).* 

---

## Exemplo 2: indice composto

Se as consultas filtram com frequencia por dois campos juntos, um indice composto e util.

```sql
CREATE INDEX idx_payment_customer_date
ON payment (customer_id, payment_date);
```

Uma consulta que combina bem com esse indice:

```sql
SELECT
   payment_id,
   customer_id,
   amount,
   payment_date
FROM payment
WHERE customer_id = 15
  AND payment_date >= '2005-07-01'
ORDER BY payment_date;
```

*Observacao: a ordem das colunas no indice composto e importante. Em muitos casos, coloque primeiro o campo mais usado em filtro.*

---

## Quando um indice pode nao ser usado

Mesmo com indice criado, o otimizador pode ignora-lo. Causas comuns:

- funcao sobre coluna indexada no `WHERE` (`YEAR(payment_date)`);
- busca com `%` no inicio (`LIKE '%abc'`);
- baixa seletividade da coluna;
- ordem inadequada de colunas no indice composto.

Exemplo de condicao que frequentemente impede uso de indice:

```sql
SELECT
   payment_id,
   payment_date
FROM payment
WHERE YEAR(payment_date) = 2005;
```

Versao mais amigavel para indice:

```sql
SELECT
   payment_id,
   payment_date
FROM payment
WHERE payment_date >= '2005-01-01'
  AND payment_date < '2006-01-01';
```

---

## Recomendacoes praticas

- Adicione indices para consultas frequentes reais, nao "por garantia".
- Comece por colunas usadas em `WHERE`, `JOIN` e `ORDER BY`.
- Depois de criar indice, compare o plano com `EXPLAIN`.
- Mantenha equilibrio: indices demais podem piorar operacoes de escrita.

---

**Principais conclusoes desta licao:**

- Indice e uma estrutura que acelera busca de linhas.
- Indices geralmente aceleram `SELECT`, mas podem deixar `INSERT`, `UPDATE` e `DELETE` mais lentos.
- Indices simples e compostos atendem padroes de filtro diferentes.
- A ordem das colunas em indice composto e critica.
- `EXPLAIN` ajuda a confirmar se o SGBD usa o indice criado.

## Perguntas de entrevista

### O que e um indice SQL e por que ele e util?
Indice e uma estrutura de dados adicional que acelera busca de linhas por valor de coluna. Ele e util porque reduz tempo de leitura e volume de dados varridos.

### Por que um indice pode acelerar `SELECT` e ao mesmo tempo deixar `INSERT` mais lento?
Em leitura, o indice ajuda a localizar linhas rapidamente. Em escrita, o SGBD precisa atualizar dados da tabela e estruturas de indice, o que aumenta o trabalho.

### Como verificar se um indice esta sendo realmente usado?
Execute `EXPLAIN` na consulta e analise o plano: tipo de acesso, indice escolhido e estimativa de linhas.

Na proxima licao, veremos tratamento de erros e tecnicas de depuracao SQL para o trabalho do dia a dia.
