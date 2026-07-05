---
title: "Filtrando Dados Agrupados com HAVING em SQL"
description: "Aprenda HAVING: sintaxe, diferencas WHERE vs HAVING, filtragem de grupos apos agregacao, exemplos Sakila."
keywords: ["HAVING SQL", "filtro grupos", "GROUP BY", "funcoes agregacao", "Sakila"]
teaches: ["Usar HAVING para filtrar grupos apos agregacao", "Entender diferencas entre WHERE e HAVING", "Combinar multiplas condicoes no HAVING"]
about: ["SQL", "HAVING", "GROUP BY", "Aggregation", "Sakila"]
---

_Tempo de leitura: ~7 minutos_

Quando voce usa GROUP BY com agregacoes, frequentemente precisa filtrar grupos por seus resultados agregados. HAVING e o operador para filtrar grupos, assim como WHERE filtra linhas individuais. Nesta licao, voce aprendera as diferencas entre WHERE e HAVING, sintaxe e exemplos praticos com Sakila. Ao final, usara HAVING com confianca para analise profunda de dados.

# Filtrando Grupos com HAVING

Nas licoes anteriores, voce aprendeu GROUP BY para agrupar dados e aplicar agregacoes. Agora vem o proximo passo: filtrar os proprios grupos por condicoes em valores agregados.

HAVING faz isso permitindo condicoes apos agrupamento.

## WHERE vs HAVING

- **WHERE** filtra linhas **antes** do agrupamento
- **HAVING** filtra grupos **apos** agregacao

```sql
SELECT coluna1, COUNT(*) AS cnt
FROM tabela
WHERE coluna1 > 100          -- filtrar ANTES do agrupamento
GROUP BY coluna1
HAVING COUNT(*) > 10;        -- filtrar APOS o agrupamento
```

## Sintaxe do HAVING

Estrutura basica:

```sql
SELECT coluna1, FUNCAO_AGG(coluna2)
FROM tabela
GROUP BY coluna1
HAVING condicao;
```

A condicao em HAVING normalmente envolve uma funcao de agregacao.

---

## Exemplos com Uma Condicao

### Clientes com pagamentos totais acima de 100

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;
```

*Resultado: apenas clientes cujos pagamentos totais excedem 100.*

### Funcionarios que processaram mais de 50 pagamentos

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50;
```

*Resultado: funcionarios com mais de 50 pagamentos processados.*

### Clientes com pagamento medio >= 5

```sql
SELECT customer_id, AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
HAVING AVG(amount) >= 5;
```

*Resultado: clientes cuja media de pagamento e de pelo menos 5.*

---

## HAVING com Multiplas Condicoes

Voce pode combinar condicoes usando AND e OR:

```sql
SELECT staff_id, COUNT(*) AS cnt, SUM(amount) AS total
FROM payment
GROUP BY staff_id
HAVING COUNT(*) > 50 AND SUM(amount) > 500;
```

*Resultado: funcionarios com mais de 50 pagamentos E total acima de 500.*

### Com operador OR

```sql
SELECT customer_id, COUNT(*) AS rentals, SUM(amount) AS paid
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 100 OR SUM(amount) > 1000;
```

*Resultado: clientes com mais de 100 pagamentos OU total acima de 1000.*

---

## Exemplos Praticos

### Categorias de filmes com vendas acima de 2000

```sql
SELECT category_id, SUM(p.amount) AS total_sales
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
GROUP BY category_id
HAVING SUM(p.amount) > 2000;
```

### Paises com mais de 20 clientes

```sql
SELECT country, COUNT(*) AS customers_count
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY country
HAVING COUNT(*) > 20;
```

### Lojas com receita diaria acima de 500

```sql
SELECT store_id, DATE(payment_date) AS pay_date, SUM(amount) AS daily_revenue
FROM payment
GROUP BY store_id, DATE(payment_date)
HAVING SUM(amount) > 500;
```

---

## Perguntas Frequentes

### Por que nao posso usar WHERE em vez de HAVING?
WHERE funciona antes do agrupamento, entao nao pode verificar funcoes de agregacao. HAVING funciona apos agrupamento e pode analisar resultados de agregacao (COUNT, SUM, AVG, etc.).

### Posso usar uma coluna nao agregada em HAVING?
Sim, voce pode usar uma coluna do GROUP BY, mas geralmente nao e necessario. Por exemplo, `HAVING customer_id > 100` funciona, mas e mais natural escrever isso em WHERE antes do agrupamento.

### HAVING pode ser usado sem GROUP BY?
Tecnicamente em alguns SGBDs isso e possivel, mas e impratico pois HAVING foi projetado para filtrar grupos. Use WHERE para filtrar linhas individuais sem agrupamento.

---

## Perguntas de Entrevista

### O que e HAVING e como difere de WHERE?
HAVING filtra grupos apos agregacao, enquanto WHERE filtra linhas antes do agrupamento. WHERE nao pode funcionar com funcoes de agregacao, mas HAVING funciona apenas com elas.

### Posso usar WHERE e HAVING juntos em uma consulta?
Sim, e ate recomendado. WHERE filtra linhas antes do agrupamento e HAVING filtra grupos apos. Por exemplo, `WHERE amount > 10 GROUP BY customer_id HAVING SUM(amount) > 100` primeiro exclui pequenos pagamentos, depois agrupa e filtra grupos.

### Qual e a ordem de execucao: WHERE ou HAVING?
WHERE e aplicado primeiro (antes de GROUP BY), depois GROUP BY executa agrupamento, depois HAVING filtra grupos resultantes, e finalmente ORDER BY e LIMIT sao aplicados.

---

**Principais conclusoes desta licao:**

- HAVING filtra grupos **apos** agregacao, WHERE filtra linhas **antes** do agrupamento.
- HAVING e usado com funcoes de agregacao (COUNT, SUM, AVG, MIN, MAX).
- Voce pode combinar multiplas condicoes em HAVING usando AND/OR.
- Frequentemente WHERE e HAVING trabalham juntos: WHERE exclui linhas indesejadas, HAVING filtra grupos.
- HAVING permite consultas analiticas profundas com filtragem no nivel do grupo.

Na proxima licao, exploraremos ORDER BY para ordenar resultados.
