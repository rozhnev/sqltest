Esta lição é dedicada à instrução `UPDATE` — o comando que permite modificar registros existentes em uma tabela de banco de dados. Você aprenderá a sintaxe básica para atualizar uma ou mais colunas, como usar a cláusula `WHERE` para direcionar linhas específicas e as regras importantes para usar o `UPDATE` com segurança. Também abordaremos a atualização de várias linhas de uma vez e o uso dos valores atuais das colunas em expressões.

Title: Atualizando Dados

# Lição 8.2: A Instrução UPDATE

Na lição anterior, aprendemos a adicionar novas linhas com `INSERT INTO`. Agora vamos ver como **modificar dados já existentes** com a instrução `UPDATE`. Esta é uma das principais operações DML que mantém seu banco de dados atualizado e preciso.

## Sintaxe Básica

```sql
UPDATE nome_da_tabela
SET coluna1 = valor1, coluna2 = valor2, ...
WHERE condição;
```

*   `UPDATE nome_da_tabela` — especifica a tabela na qual você deseja alterar dados.
*   `SET coluna = valor` — atribui novos valores a uma ou mais colunas.
*   `WHERE condição` — determina quais linhas serão atualizadas.

---

## Regras Importantes

*   **Sempre use `WHERE`:** Sem a cláusula `WHERE`, a instrução `UPDATE` modificará **todas as linhas** da tabela. Este é um dos erros mais comuns e perigosos.
*   **Tipos de Dados:** Os novos valores devem corresponder ao tipo de dados da coluna.
*   **Strings e Datas:** Valores de texto e datas devem estar entre aspas simples (`'`).
*   **Números:** Valores numéricos não requerem aspas.
*   **Transações:** Em sistemas de produção, é recomendável executar o `UPDATE` dentro de uma transação para poder reverter as alterações em caso de erro.

---

## Exemplos

### Exemplo 1: Atualizando uma Única Coluna
Vamos alterar o endereço de e-mail de um cliente específico na tabela `customer`.

```sql
UPDATE customer
SET email = 'new.email@example.com'
WHERE customer_id = 1;
```

*Nota: A condição `WHERE customer_id = 1` garante que apenas um registro específico seja alterado.*

### Exemplo 2: Atualizando Várias Colunas Simultaneamente
Você pode listar várias colunas na cláusula `SET`, separadas por vírgulas.

```sql
UPDATE customer
SET first_name = 'ALICE',
    last_name  = 'COOPER',
    email      = 'alice.cooper@example.com'
WHERE customer_id = 42;
```

### Exemplo 3: Usando o Valor Atual em uma Expressão
A instrução `UPDATE` permite calcular um novo valor com base no atual. Por exemplo, vamos aumentar a taxa de aluguel de todos os filmes da categoria "Comedy" em 10%:

```sql
UPDATE film
SET rental_rate = rental_rate * 1.10
WHERE film_id IN (
    SELECT f.film_id
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c       ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy'
);
```

*Resultado: A taxa de aluguel de todos os filmes "Comedy" aumentará 10%.*

### Exemplo 4: Atualizando Várias Linhas por Condição
Vamos marcar todos os clientes inativos que não realizaram nenhum aluguel após uma determinada data:

```sql
UPDATE customer
SET active = 0
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM rental
    WHERE rental_date >= '2005-08-01'
);
```

### Exemplo 5: Definindo um Valor como NULL
Se uma coluna permite `NULL`, você pode limpá-la explicitamente:

```sql
UPDATE film
SET original_language_id = NULL
WHERE film_id = 10;
```

---

## Verificação Antes de Atualizar

Uma boa prática é executar primeiro um `SELECT` com a mesma condição `WHERE`, para confirmar que as linhas certas serão afetadas:

```sql
-- Primeiro, verifique o que o SELECT retorna
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id = 1;

-- Somente após verificar, execute o UPDATE
UPDATE customer
SET email = 'new.email@example.com'
WHERE customer_id = 1;
```

---

**Principais Conclusões desta Lição:**

*   A instrução `UPDATE` modifica linhas existentes em uma tabela.
*   Sem a cláusula `WHERE`, **todas** as linhas da tabela serão atualizadas — sempre verifique sua presença.
*   Várias colunas podem ser atualizadas em uma única cláusula `SET`, separadas por vírgulas.
*   Um novo valor de coluna pode ser calculado a partir do seu valor atual (ex.: `price = price * 1.1`).
*   Antes de executar um `UPDATE`, é recomendável executar um `SELECT` com a mesma condição para verificar as linhas afetadas.

Na próxima lição, exploraremos a instrução **DELETE** — como remover linhas de uma tabela de forma segura e controlada.
