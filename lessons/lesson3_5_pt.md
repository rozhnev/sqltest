# Lição 3.5: Operador condicional `CASE WHEN ... THEN ... END` em SQL

O operador `CASE` em SQL permite aplicar lógica condicional diretamente na consulta. Com ele, você pode criar categorias, gerar rótulos legíveis, filtrar dados com regras diferentes e definir ordenações personalizadas. É uma das ferramentas mais úteis quando você quer consultas mais inteligentes sem mover a lógica para o código da aplicação.

Nesta lição, vamos ver:

- como `CASE` funciona;
- como usar em `SELECT`;
- como aplicar `CASE` em `WHERE`;
- como criar ordenação personalizada com `CASE` em `ORDER BY`.

## Sintaxe do `CASE`

`CASE` tem duas formas principais.

### 1) Forma simples (`simple CASE`)

```sql
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END
```

Essa forma compara uma expressão (`expression`) com vários valores.

### 2) Forma pesquisada (`searched CASE`)

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

Aqui, cada `WHEN` contém uma condição completa. Essa forma é mais flexível e mais usada.

Comportamento importante:

- as condições são avaliadas de cima para baixo;
- a primeira condição `WHEN` verdadeira é retornada;
- se nenhuma condição for atendida, usa-se `ELSE`;
- se `ELSE` não for informado, o resultado é `NULL`.

## `CASE` no `SELECT`

O uso mais comum é adicionar uma coluna calculada com categoria ou status.

### Exemplo: categorização de pagamentos

```sql
SELECT
    payment_id,
    amount,
    CASE
        WHEN amount < 2 THEN 'Pagamento baixo'
        WHEN amount BETWEEN 2 AND 6 THEN 'Pagamento médio'
        ELSE 'Pagamento alto'
    END AS payment_level
FROM payment
LIMIT 10;
```

**O que a consulta faz:**

- avalia `amount` em cada linha de `payment`;
- atribui uma entre três categorias;
- retorna a categoria em uma nova coluna `payment_level`.

### Exemplo: status de aluguel mais legível

```sql
SELECT
    rental_id,
    rental_date,
    return_date,
    CASE
        WHEN return_date IS NULL THEN 'Não devolvido'
        ELSE 'Devolvido'
    END AS rental_status
FROM rental
LIMIT 10;
```

Essa abordagem é útil em relatórios e dashboards, onde valores brutos precisam virar status claros.

## `CASE` no `WHERE`

Embora `CASE` seja mais comum em `SELECT`, ele também pode ser usado para filtrar dados. Isso ajuda quando a regra de filtro depende de outra coluna ou de limites diferentes por situação.

### Exemplo: limite de valor diferente por funcionário

```sql
SELECT
    payment_id,
    staff_id,
    amount
FROM payment
WHERE amount >= CASE
    WHEN staff_id = 1 THEN 5
    WHEN staff_id = 2 THEN 3
    ELSE 4
END;
```

**Lógica do filtro:**

- para `staff_id = 1`, entram pagamentos com `amount >= 5`;
- para `staff_id = 2`, entram pagamentos com `amount >= 3`;
- para os demais, o limite é `amount >= 4`.

### Quando uma alternativa é melhor

Para condições simples, `OR` costuma ser mais fácil de ler. Mas `CASE` no `WHERE` é útil quando a regra realmente se ramifica e deve permanecer em uma única expressão.

## `CASE` no `ORDER BY`

Uma necessidade comum é ordenar por prioridade de negócio, e não por ordem alfabética ou numérica. `CASE` resolve isso muito bem.

### Exemplo: ordenação personalizada para classificação de filmes

```sql
SELECT
    title,
    rating
FROM film
ORDER BY CASE rating
    WHEN 'G' THEN 1
    WHEN 'PG' THEN 2
    WHEN 'PG-13' THEN 3
    WHEN 'R' THEN 4
    WHEN 'NC-17' THEN 5
    ELSE 6
END,
 title;
```

**Resultado:** filmes com classificação mais leve aparecem primeiro, depois os mais restritos, independentemente da ordenação padrão por texto.

### Exemplo: mostrar primeiro os aluguéis não devolvidos

```sql
SELECT
    rental_id,
    rental_date,
    return_date
FROM rental
ORDER BY CASE
    WHEN return_date IS NULL THEN 0
    ELSE 1
END,
 rental_date DESC
LIMIT 20;
```

Assim, os registros mais importantes aparecem no topo do resultado.

## Aplicações práticas

1. **Segmentação de clientes por gasto:**
   ```sql
   SELECT
       customer_id,
       SUM(amount) AS total_spent,
       CASE
           WHEN SUM(amount) < 50 THEN 'Básico'
           WHEN SUM(amount) < 100 THEN 'Ativo'
           ELSE 'VIP'
       END AS customer_segment
   FROM payment
   GROUP BY customer_id;
   ```

2. **Contagem de registros por grupos condicionais:**
   ```sql
   SELECT
       SUM(CASE WHEN amount < 2 THEN 1 ELSE 0 END) AS low_count,
       SUM(CASE WHEN amount BETWEEN 2 AND 6 THEN 1 ELSE 0 END) AS medium_count,
       SUM(CASE WHEN amount > 6 THEN 1 ELSE 0 END) AS high_count
   FROM payment;
   ```

3. **Prioridade personalizada para relatório:**
   ```sql
   SELECT
       title,
       replacement_cost
   FROM film
   ORDER BY CASE
       WHEN replacement_cost >= 25 THEN 1
       WHEN replacement_cost >= 20 THEN 2
       ELSE 3
   END,
   replacement_cost DESC;
   ```

## Principais conclusões desta lição

`CASE WHEN ... THEN ... END` é uma ferramenta universal de lógica condicional em SQL.

Pontos principais:

- em `SELECT`, ajuda a criar categorias e status;
- em `WHERE`, permite lógica de filtro com ramificações;
- em `ORDER BY`, dá controle total sobre a ordem personalizada;
- na maioria dos casos, vale incluir `ELSE` para evitar `NULL` inesperado.

Ao dominar `CASE`, suas consultas SQL ficam mais flexíveis, mais legíveis e mais próximas da lógica de negócio.
