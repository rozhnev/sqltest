---
title: "Operações sobre conjuntos de dados em SQL: UNION, INTERSECT e EXCEPT"
description: "As operações sobre conjuntos de dados permitem combinar, intersectar e subtrair resultados de consultas. Aprenda UNION, INTERSECT e EXCEPT com exemplos Sakila."
keywords: ["operações sobre conjuntos SQL", "UNION", "INTERSECT", "EXCEPT", "UNION ALL", "set operations"]
teaches: ["Combinar resultados de várias consultas com UNION e UNION ALL", "Encontrar interseções e diferenças com INTERSECT e EXCEPT", "Reescrever condições OR complexas com UNION quando isso melhora a clareza", "Entender os requisitos de compatibilidade de colunas e tipos", "Escolher o operador certo para tarefas analíticas práticas"]
about: ["SQL", "UNION", "UNION ALL", "INTERSECT", "EXCEPT"]
---

_Lição 5.10 · Tempo de leitura: ~8 min_

Esta lição apresenta as operações sobre conjuntos de dados em SQL. Você vai aprender a combinar resultados de várias consultas, encontrar linhas em comum e excluir valores desnecessários. Vamos ver `UNION`, `UNION ALL`, `INTERSECT` e `EXCEPT` com exemplos Sakila. Ao final da lição, você conseguirá escolher o operador certo para diferentes cenários analíticos.

# Operações sobre conjuntos de dados

Nas lições anteriores, você aprendeu a juntar tabelas com `JOIN` e a entender como o mecanismo executa essas junções. Agora passamos para uma ideia diferente: às vezes você não quer conectar linhas por chaves, mas sim combinar e comparar conjuntos inteiros de resultados.

As operações sobre conjuntos de dados são úteis quando você quer reunir dados de várias consultas, encontrar a sobreposição entre públicos ou remover linhas que já aparecem em outra lista. Na prática, isso surge com frequência em relatórios, validação de dados e preparação de listas finais.

<img src="/images/lessons/lesson5_10-dataset-operations.svg" alt="SQL dataset operations UNION INTERSECT EXCEPT" width="100%">

---

## O que são operações sobre conjuntos de dados

As operações sobre conjuntos de dados não trabalham com linhas de uma única tabela, mas com os **resultados de duas ou mais consultas**. Em termos de SQL, cada `SELECT` retorna um conjunto de linhas, e operadores como `UNION` ou `INTERSECT` combinam esses conjuntos segundo regras específicas.

Os quatro operadores mais usados são:

- `UNION` - combina resultados e remove duplicatas;
- `UNION ALL` - combina resultados e mantém duplicatas;
- `INTERSECT` - mantém apenas as linhas que aparecem em ambos os conjuntos;
- `EXCEPT` - retorna as linhas do primeiro conjunto que não existem no segundo.

> **Importante:** nem todos os bancos de dados suportam esses operadores exatamente da mesma forma. Ao mover consultas entre mecanismos, sempre verifique a versão e a compatibilidade.

## Regras gerais

Para usar uma operação de conjunto, as duas consultas `SELECT` precisam retornar resultados compatíveis.

### Requisitos da consulta

- o mesmo número de colunas;
- tipos de dados compatíveis nas posições correspondentes;
- a mesma ordem das colunas;
- se possível, o mesmo significado de negócio para os valores.

Se você precisar ordenar o resultado final, escreva `ORDER BY` no fim de toda a expressão.

```sql
SELECT column1, column2
FROM table_a
UNION
SELECT column1, column2
FROM table_b
ORDER BY column1;
```

## UNION e UNION ALL

`UNION` e `UNION ALL` parecem semelhantes, mas resolvem problemas diferentes.

- `UNION` remove duplicatas do resultado final.
- `UNION ALL` mantém todas as linhas, mesmo que se repitam.

### Exemplo: uma lista única de cidades para clientes e funcionários

Suponha que queremos uma lista única das cidades onde vivem clientes e funcionários do Sakila.

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
UNION
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Resultado: você obtém uma lista única de cidades, sem duplicatas, mesmo que clientes e funcionários vivam na mesma cidade.*

Se você quiser manter todas as fontes, use `UNION ALL`:

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
UNION ALL
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Observação: `UNION ALL` é útil quando duplicatas têm significado, por exemplo se você pretende contar linhas da lista combinada depois.*

### Quando escolher UNION ALL

`UNION ALL` normalmente é mais rápido que `UNION`, porque o banco não gasta tempo removendo duplicatas. Então, se você não precisa de unicidade, `UNION ALL` costuma ser a melhor escolha.

## INTERSECT

`INTERSECT` retorna apenas as linhas que aparecem em **ambos** os conjuntos de resultados. Isso é útil quando você precisa da sobreposição entre duas listas.

### Exemplo: cidades onde vivem clientes e funcionários

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
INTERSECT
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Resultado: você vê apenas as cidades que aparecem tanto entre clientes quanto entre funcionários.*

### Onde isso ajuda

`INTERSECT` é útil para encontrar a parte comum entre dois públicos, comparar listas de sistemas diferentes ou verificar se duas extrações se sobrepõem.

## EXCEPT

`EXCEPT` retorna as linhas do primeiro conjunto que **não** existem no segundo. É o operador de diferença de conjuntos.

### Exemplo: cidades onde vivem clientes, mas não funcionários

```sql
SELECT
    ci.city
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
EXCEPT
SELECT
    ci.city
FROM staff AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
ORDER BY city;
```

*Resultado: você obtém a lista de cidades onde há clientes, mas não há funcionários.*

### Observação importante

Em alguns bancos de dados, `EXCEPT` pode se chamar `MINUS` ou estar disponível apenas em certas versões. Se você escreve SQL portátil, vale verificar isso separadamente.

## Uso prático

As operações sobre conjuntos são especialmente úteis em análise e validação de dados.

- `UNION` ajuda a construir uma lista de referência única a partir de várias fontes.
- `UNION ALL` é útil para combinar fluxos de dados antes de uma agregação posterior.
- `INTERSECT` mostra a sobreposição ou linhas correspondentes.
- `EXCEPT` ajuda a encontrar diferenças, lacunas e valores extras.

Às vezes, operações sobre conjuntos podem ser substituídas por `JOIN`, mas isso nem sempre é conveniente. Se você precisa comparar **resultados de consultas** em vez de conectar tabelas por chaves, as operações de conjunto costumam ser mais fáceis de ler.

### Quando várias condições `OR` ficam melhores reescritas com `UNION`

Às vezes, uma cláusula `WHERE` longa com várias condições `OR` fica difícil de ler e manter. Nesse caso, você pode separar a lógica em ramos distintos e combiná-los com `UNION`.

Essa abordagem é especialmente útil quando:

- cada ramo representa uma regra de negócio diferente;
- as condições têm significados bem diferentes;
- você quer deixar a consulta mais fácil de ler e manter.

**Exemplo:** encontrar filmes que tenham classificação `R` ou duração maior que 180 minutos.

```sql
SELECT
    title,
    rating,
    length
FROM film
WHERE rating = 'R'

UNION

SELECT
    title,
    rating,
    length
FROM film
WHERE length > 180
ORDER BY title;
```

*Resultado: em vez de uma cláusula única `WHERE ... OR ...`, você obtém duas consultas claras, mais fáceis de ler, alterar e testar. Se uma linha puder corresponder aos dois ramos, `UNION` remove duplicatas automaticamente. Se duplicatas não forem um problema e os ramos não se sobrepuserem, você pode usar `UNION ALL`.*

*Observação: se as condições se aplicam à mesma coluna, `IN (...)` muitas vezes já basta. `UNION` é mais útil quando os ramos são logicamente diferentes ou dependem de colunas diferentes.*

## Perguntas de entrevista

### Qual é a diferença entre `UNION` e `UNION ALL`?
`UNION` combina os resultados de duas consultas e remove duplicatas, enquanto `UNION ALL` mantém todas as linhas. Na prática, `UNION ALL` normalmente é mais rápido porque não faz o trabalho extra de encontrar repetições.

### Por que operações de conjunto exigem consultas `SELECT` compatíveis?
Porque o SQL combina os resultados pela posição das colunas, não pelo nome. Se duas consultas retornam quantidade diferente de colunas ou tipos incompatíveis, o banco não consegue montar um conjunto final válido.

### Quando devo usar `INTERSECT` e quando devo usar `EXCEPT`?
`INTERSECT` é ideal quando você quer as linhas que aparecem nas duas listas. `EXCEPT` é útil quando você deseja subtrair a segunda lista da primeira e manter apenas os valores restantes.

### Em que as operações de conjunto diferem de `JOIN`?
`JOIN` conecta linhas por chaves e normalmente adiciona colunas de outra tabela. As operações de conjunto trabalham com resultados completos de consultas e os comparam como conjuntos, o que é útil para combinar listas, encontrar sobreposição e identificar diferenças.

---

## Principais Conclusões desta Lição

- `UNION` combina resultados e remove duplicatas.
- `UNION ALL` combina resultados sem remover duplicatas.
- `INTERSECT` mantém apenas as linhas comuns de dois conjuntos.
- `EXCEPT` retorna linhas que existem no primeiro conjunto e não no segundo.
- Todas as operações de conjunto exigem consultas `SELECT` compatíveis com o mesmo número de colunas.
- `ORDER BY` do resultado final deve ficar no fim de toda a expressão.
- Em análise prática, essas operações são úteis para combinar listas, encontrar sobreposição e comparar dados entre fontes.

Na próxima lição, passaremos para subconsultas e veremos como usar `SELECT` aninhados para condições e cálculos mais flexíveis.
