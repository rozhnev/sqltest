---
title: "Agrupando Dados em SQL com GROUP BY e Agregacoes"
description: "Aprenda GROUP BY: sintaxe, regras, agrupamento por uma ou multiplas colunas, exemplos praticos com Sakila."
keywords: ["GROUP BY SQL", "agrupamento dados", "funcoes agregacao", "HAVING", "Sakila"]
teaches: ["Usar GROUP BY para agrupar e agregar dados", "Entender a regra: todas as colunas SELECT em GROUP BY ou em funcao", "Agrupar por uma ou varias colunas"]
about: ["SQL", "GROUP BY", "Aggregation", "Sakila"]
---

_Tempo de leitura: ~7 minutos_

Agrupamento transforma linhas individuais em metricas categorizadas. GROUP BY e essencial para relatorios onde voce precisa de totais por categoria, data ou outra dimensao. Nesta licao, voce aprendera a sintaxe GROUP BY, a regra central e exemplos praticos com Sakila. Ao final, conseguira construir consultas analiticas com agrupamento.

# Agrupando Dados com GROUP BY

Na licao anterior, voce descobriu as funcoes de agregacao. Agora vamos ao proximo passo: aplicar essas funcoes a diferentes categorias de dados.

GROUP BY faz isso dividindo os dados em grupos e calculando metricas para cada grupo separadamente.

## Sintaxe do GROUP BY

Estrutura basica:

```sql
SELECT coluna1, FUNCAO_AGG(coluna2)
FROM tabela
GROUP BY coluna1;
```

## A Regra Central

Quando voce usa GROUP BY, **toda coluna em SELECT deve**:

- ou estar na lista GROUP BY;
- ou estar envolvida por uma funcao de agregacao (SUM, COUNT, AVG, MIN, MAX).

Essa regra impede ambiguidade: SQL precisa saber qual valor retornar quando um grupo tem multiplas linhas.

## Agrupamento por Uma Coluna

### Total de pagamentos por cliente

```sql
SELECT customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;
```

*Resultado: uma linha por cliente com a soma de seus pagamentos.*

### Numero de pagamentos por funcionario

```sql
SELECT staff_id, COUNT(*) AS payments_count
FROM payment
GROUP BY staff_id;
```

*Resultado: para cada funcionario, o numero de pagamentos processados.*

### Pagamento medio por data

```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY DATE(payment_date);
```

*Resultado: para cada data, o valor medio dos pagamentos.*

### Variante: GROUP BY com alias

```sql
SELECT DATE(payment_date) AS pay_date, AVG(amount) AS avg_payment
FROM payment
GROUP BY pay_date;
```

*Nota: isso funciona em MySQL/MariaDB, mas nao em todos os SGBDs. Para compatibilidade multi-SGBD, escreva `GROUP BY DATE(payment_date)` completamente.*

---

## Agrupamento por Multiplas Colunas

Voce pode agrupar por multiplos campos simultaneamente para uma analise mais detalhada.

### Total de pagamentos por funcionario e cliente

```sql
SELECT staff_id, customer_id, SUM(amount) AS total_paid
FROM payment
GROUP BY staff_id, customer_id;
```

*Resultado: uma linha por par (funcionario, cliente) com seu total de pagamentos.*

---

## Exemplos Praticos

### Relatorio de receita por dia

```sql
SELECT DATE(payment_date) AS pay_date, SUM(amount) AS total_sales
FROM payment
GROUP BY DATE(payment_date)
ORDER BY pay_date;
```

### Clientes mais ativos por numero de locacoes

```sql
SELECT customer_id, COUNT(*) AS rentals_count
FROM rental
GROUP BY customer_id
ORDER BY rentals_count DESC;
```

### Taxa media de aluguel por categoria de filme

```sql
SELECT category_id, AVG(rental_rate) AS avg_rental_rate
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY category_id;
```

---

## Perguntas Frequentes

### Por que nao posso selecionar qualquer coluna se usar GROUP BY?
Porque as funcoes de agregacao (SUM, COUNT, AVG) ja indicam como tratar todas as linhas do grupo. Se uma coluna nao for agregada, ela deve estar em GROUP BY para que SQL saiba qual valor escolher.

### Posso agrupar por uma expressao em vez de uma coluna?
Sim, por exemplo `GROUP BY DATE(payment_date)` ou `GROUP BY YEAR(payment_date)`. A expressao deve corresponder em SELECT e GROUP BY.

### O que acontece se GROUP BY estiver vazio?
E um erro de sintaxe. GROUP BY sempre precisa ter pelo menos uma coluna ou expressao.

---

## Perguntas de Entrevista

### O que e GROUP BY e por que precisamos dela?
GROUP BY combina linhas em que as colunas selecionadas tem valores identicos em um unico grupo. Voce pode entao aplicar funcoes de agregacao a cada grupo para obter estatisticas resumidas.

### Por que nao posso escolher arbitrariamente uma coluna com GROUP BY?
Porque um grupo pode ter multiplas linhas com valores diferentes naquela coluna. SQL precisa saber qual valor retornar, caso contrario o resultado e ambiguo. A coluna deve estar em GROUP BY ou dentro de uma funcao de agregacao.

### Qual e a diferenca entre WHERE e HAVING?
WHERE filtra linhas ANTES do agrupamento, enquanto HAVING filtra grupos DEPOIS do agrupamento. Por exemplo, `WHERE amount > 10` exclui linhas antes do agrupamento, enquanto `HAVING SUM(amount) > 100` exclui grupos cuja soma e menor que 100.

---

**Principais conclusoes desta licao:**

- GROUP BY divide dados em grupos e aplica agregacoes a cada um.
- Regra central: todas as colunas SELECT em GROUP BY ou em uma funcao de agregacao.
- Voce pode agrupar por uma ou multiplas colunas simultaneamente.
- Voce pode agrupar por expressoes, como `GROUP BY DATE(payment_date)`.
- GROUP BY alimenta relatorios, analise e resumos por categoria.

Na proxima licao, exploraremos o filtro de grupos com o operador HAVING.
