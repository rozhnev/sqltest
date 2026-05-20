---
title: "Consultas SQL eficientes: como escrever SQL mais rapido e leve"
description: "Consultas SQL eficientes reduzem carga no servidor e aceleram relatorios. Aprenda tecnicas praticas de filtro, JOIN, SARGable e LIMIT."
keywords: ["consultas SQL eficientes", "otimizacao SQL", "SARGable SQL", "performance JOIN", "desempenho de consultas", "SQL para analistas"]
teaches: ["Por que SELECT * piora consultas de producao", "Como filtrar cedo para acelerar", "Como escrever condicoes SARGable", "Quando usar EXISTS em vez de JOIN", "Como usar LIMIT com seguranca durante depuracao"]
about: ["SQL", "Otimizacao de consultas", "Performance de banco", "SARGable", "JOIN"]
---

_Licao 10.2 · Tempo de leitura: ~10 min_

Esta licao apresenta fundamentos para escrever consultas SQL de alto desempenho. Voce vai aprender como evitar carga desnecessaria no banco, por que `SELECT *` costuma prejudicar performance e como filtrar dados de forma eficiente. Tambem veremos tecnicas praticas para acelerar consultas em grandes volumes. Ao final, voce conseguira escrever SQL eficiente e responsavel com recursos do servidor.

# Licao 10.2: Escrita de consultas SQL eficientes

Na licao anterior, focamos em legibilidade para pessoas. Mas o SQL tambem precisa ser eficiente para o mecanismo do banco. Ate uma consulta bem formatada pode ser lenta se obrigar o servidor a executar trabalho desnecessario.

A eficiencia de consulta afeta diretamente a velocidade de aplicacoes e relatorios. Em cenarios de alto volume, a diferenca entre "funciona" e "otimizado" pode ser enorme.

SGBDs modernos possuem otimizadores potentes, mas eles nao conhecem toda a logica de negocio e nao corrigem tudo automaticamente. Qualidade de SQL continua sendo responsabilidade do desenvolvedor.

<img src="/images/lessons/lesson10_2-efficient-queries.svg" alt="Diagrama com tecnicas para acelerar consultas SQL: filtragem, indices, otimizacao de JOIN e limite de resultados" width="100%">

---

## Regra de ouro: busque apenas o necessario

Uma causa comum de lentidao e transferir dados demais entre servidor e cliente.

### Evite `SELECT *`

`SELECT *` e util em exploracao inicial, mas deve ser evitado no SQL final.

- **Trafego extra:** voce retorna colunas que nao precisa.
- **Menos chance de plano com indice cobrindo colunas:** pedir tudo dificulta planos mais eficientes.
- **Codigo fragil:** novas colunas podem alterar performance e comportamento.

```sql
-- Ruim
SELECT * FROM film;

-- Melhor
SELECT film_id, title, release_year
FROM film;
```

---

## Otimizacao de filtragem

A forma de limitar linhas determina quanto trabalho o SGBD vai fazer.

### Filtre no servidor o quanto antes

Aplique `WHERE` antes de operacoes pesadas. Quanto menos linhas seguirem para `JOIN` e `GROUP BY`, melhor.

### Evite funcoes em `WHERE` (consultas SARGable)

Para aproveitar indices, predicados devem ser **SARGable**. Se voce envolve uma coluna indexada em funcao, o otimizador pode deixar de usar o indice de forma eficiente.

```sql
-- Lento (Non-SARGable)
SELECT count(*) 
FROM rental 
WHERE YEAR(rental_date) = 2005;

-- Rapido (SARGable)
SELECT count(*) 
FROM rental 
WHERE rental_date >= '2005-01-01' AND rental_date < '2006-01-01';
```

---

## Trabalhando com `JOIN`

Juncoes estao entre as operacoes mais custosas em SQL.

- **Filtre antes de juntar** sempre que possivel.
- **Verifique indices** nas chaves de relacao.
- **Evite `CROSS JOIN`** sem necessidade real.
- **Use `EXISTS`** para testes de existencia.

```sql
-- Menos eficiente
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id;

-- Mais eficiente para existencia
SELECT c.first_name, c.last_name
FROM customer c
WHERE EXISTS (
    SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id
);
```

---

## Use `LIMIT` durante validacao

Ao depurar, use `LIMIT` para evitar retorno acidental de milhoes de linhas.

```sql
SELECT customer_id, first_name, last_name
FROM customer
WHERE active = 1
LIMIT 10;
```

---

## Exemplo pratico: otimizando um relatorio

Suponha que precisamos encontrar filmes alugados mais de 30 vezes em uma categoria especifica.

**Abordagem menos eficiente:**
```sql
SELECT f.title, COUNT(r.rental_id)
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'
GROUP BY f.title
HAVING COUNT(r.rental_id) > 30;
```

**Abordagem mais eficiente:**
Se soubermos o ID da categoria, podemos evitar um `JOIN` adicional.

```sql
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE fc.category_id = 1 -- Usa ID em vez de busca textual
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) > 30;
```

*Observacao: filtrar por ID numerico costuma ser mais rapido do que filtrar por nome textual e pode reduzir joins desnecessarios.*

---

**Principais conclusoes desta licao:**

*   Evite `SELECT *` em consultas de producao.
*   Filtre cedo com `WHERE`.
*   Escreva condicoes **SARGable** para permitir uso de indices.
*   Use `EXISTS` para verificacao de existencia.
*   Use `LIMIT` na exploracao e depuracao.
*   Prefira filtros por chaves numericas.

---

## Perguntas frequentes

### Por que `SELECT *` e ruim em producao?
Ele retorna colunas desnecessarias, aumenta trafego e pode piorar planos de execucao. Listar colunas explicitamente e mais seguro.

### O que significa SARGable na pratica?
Significa permitir busca eficiente por indice. Funcoes em colunas indexadas costumam atrapalhar isso.

### Quando usar `EXISTS` em vez de `JOIN`?
Quando voce so precisa saber se existe linha relacionada e nao precisa retornar colunas da tabela secundária.

## Perguntas de entrevista

### Quais primeiros passos voce toma ao encontrar consulta SQL lenta?
Verifico `SELECT *`, seletividade de `WHERE` e predicados nao SARGable. Depois avalio estrategia de join e volume de linhas processadas.

### Por que filtrar cedo melhora desempenho?
Porque reduz linhas envolvidas em joins, ordenacoes e agregacoes, diminuindo o custo total do plano.

### Diferenca de performance entre `JOIN` e `EXISTS`?
`JOIN` combina conjuntos de linhas e e necessario quando voce precisa de colunas de ambas as tabelas. `EXISTS` costuma ser melhor para verificacoes sim/nao.

Na proxima licao, vamos aprofundar a analise de execucao e ver como indices aceleram consultas no nivel fisico.

-> [Licao 10.3: Entendendo metodos de otimizacao de consultas](lesson10_3_pt.md)
