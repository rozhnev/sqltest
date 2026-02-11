Esta lição explora como combinar as cláusulas `WHERE`, `ORDER BY` e `LIMIT` em uma única consulta SQL para realizar filtragem e ordenação de dados precisas. Você aprenderá a ordem sintática correta para essas cláusulas e como elas trabalham juntas para refinar seus resultados — por exemplo, encontrando os "top 5" registros que atendem a critérios específicos. Dominar essa combinação é essencial para criar relatórios direcionados e otimizar a recuperação de dados em aplicações de banco de dados do mundo real.

# Lição 2.7: Juntando Tudo: WHERE, ORDER BY e LIMIT

Até agora, aprendemos como filtrar linhas (`WHERE`), ordená-las (`ORDER BY`) e restringir o número de resultados (`LIMIT`). Em cenários do mundo real, você quase sempre usará essas cláusulas juntas para obter exatamente os dados de que precisa.

## A Ordem das Cláusulas

O SQL possui uma ordem estrita para como essas cláusulas devem aparecer em sua consulta. Se você as colocar na ordem errada, o banco de dados retornará um erro.

A sequência correta é:
1.  **`SELECT`** (Quais colunas?)
2.  **`FROM`** (Qual tabela?)
3.  **`WHERE`** (Filtre as linhas primeiro)
4.  **`ORDER BY`** (Ordene as linhas filtradas)
5.  **`LIMIT`** (Pegue os primeiros X resultados da lista ordenada)
6.  **`OFFSET`** (Pule X linhas, se necessário)

## Lógica: Como Funciona

Quando você executa uma consulta combinada, o banco de dados a processa conceitualmente assim:
1.  Ele olha para a tabela no **`FROM`**.
2.  Ele filtra as linhas que não correspondem à condição **`WHERE`**.
3.  Ele pega as linhas restantes e as ordena de acordo com o **`ORDER BY`**.
4.  Finalmente, ele olha para o resultado ordenado e aplica o **`LIMIT`** para fornecer apenas a parte que você solicitou.

## Exemplos

### Exemplo 1: Encontrando os 5 Filmes Mais Curtos e Baratos
Neste exemplo, filtramos pelo custo de substituição primeiro, depois ordenamos pela duração e, finalmente, limitamos os resultados.

```sql
SELECT title, length, replacement_cost
FROM film
WHERE replacement_cost < 20.00
ORDER BY length ASC
LIMIT 5;
```

### Exemplo 2: Aluguéis de Alto Valor Mais Recentes
Esta consulta encontra os 10 aluguéis mais recentes que duraram mais de 5 dias.

```sql
SELECT rental_id, rental_date, return_date
FROM rental
WHERE return_date - rental_date > 5
ORDER BY rental_date DESC
LIMIT 10;
```

### Exemplo 3: Pesquisando por Atores Específicos
Encontre os primeiros 3 atores cujo sobrenome começa com 'B', ordenados alfabeticamente pelo primeiro nome.

```sql
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'B%'
ORDER BY first_name
LIMIT 3;
```

## Paginação com WHERE e ORDER BY

Na lição anterior, vimos a paginação básica usando `LIMIT` e `OFFSET`. Em aplicações reais, você geralmente pagina uma lista **filtrada** e **ordenada**.

### Por que precisamos de WHERE e ORDER BY para paginação?
1. **Filtragem:** Os usuários geralmente desejam ver um subconjunto específico de dados (por exemplo, produtos "Ativos" ou filmes de "Comédia").
2. **Consistência:** Sem `ORDER BY`, o banco de dados pode retornar linhas em uma ordem diferente toda vez que você for para a próxima página, fazendo com que alguns itens apareçam duas vezes e outros sejam perdidos.

### Fórmula de Paginação
Para implementar a paginação para a "Página N" com "S" resultados por página:
*   `LIMIT S`
*   `OFFSET (N - 1) * S`

### Exemplo Combinado: Página 2 de Atores com 'A'
Se quisermos mostrar a segunda página (5 resultados por página) de atores cujo primeiro nome começa com 'A', ordenados pelo sobrenome:

```sql
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'A%'
ORDER BY last_name
LIMIT 5 OFFSET 5; -- Página 2: Pula 5, pega 5
```

---

**Principais conclusões desta lição:**

*   Siga a ordem sintática estrita: `WHERE` -> `ORDER BY` -> `LIMIT`.
*   As condições da cláusula `WHERE` são aplicadas *antes* que a ordenação e a limitação ocorram.
*   Esta combinação é a base para a maioria dos relatórios de dados e listas "top-X" de interfaces de usuário.
*   Sempre use `LIMIT` com `ORDER BY` se quiser que seus resultados sejam consistentes.

No próximo módulo, iremos além da simples recuperação de linhas e exploraremos as **Funções de Agregação**, que nos permitem calcular totais, médias e contagens em conjuntos de dados inteiros.
