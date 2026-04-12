Esta lição é dedicada à instrução `DELETE` — o comando que remove linhas existentes de uma tabela de banco de dados. Você aprenderá a sintaxe básica de remoção, como usar a cláusula `WHERE` com segurança, verá exemplos de exclusão pontual e em massa e descobrirá como verificar uma consulta antes de executá-la. Ao final desta lição, você será capaz de remover dados com mais segurança e confiança.

Title: Excluindo Dados

# Lição 8.3: A Instrução DELETE

Na lição anterior, aprendemos a modificar registros com `UPDATE`. Agora vamos ver como **remover linhas desnecessárias ou desatualizadas** com a instrução `DELETE`. Esta é uma importante operação DML que deve ser usada com bastante cuidado, porque nem sempre é fácil recuperar dados excluídos.

## Sintaxe Básica

```sql
DELETE FROM nome_da_tabela
WHERE condição;
```

*   `DELETE FROM nome_da_tabela` — especifica a tabela da qual as linhas serão removidas.
*   `WHERE condição` — determina quais linhas serão excluídas.

Se `WHERE` for omitido, **todas as linhas** da tabela serão removidas.

---

## Regras Importantes

*   **Sempre verifique a cláusula `WHERE`:** um erro na condição pode excluir os dados errados ou linhas demais.
*   **Execute um `SELECT` primeiro:** antes de usar `DELETE`, é uma boa prática executar um `SELECT` com a mesma condição para confirmar que o resultado está correto.
*   **A estrutura da tabela permanece:** `DELETE` remove apenas os dados, não a tabela nem suas colunas.
*   **Atenção aos dados relacionados:** se houver chaves estrangeiras definidas, o banco pode impedir a exclusão de linhas referenciadas por outras tabelas.
*   **Transações:** em sistemas de produção, é mais seguro executar exclusões importantes dentro de uma transação.

---

## Exemplos

### Exemplo 1: Excluindo uma linha
Vamos remover um cliente pelo seu identificador:

```sql
DELETE FROM customer
WHERE customer_id = 1;
```

*Observação: graças a `WHERE customer_id = 1`, apenas uma linha específica será excluída.*

### Exemplo 2: Excluindo várias linhas por condição
Vamos excluir registros de pagamento feitos antes de uma determinada data:

```sql
DELETE FROM payment
WHERE payment_date < '2005-05-25';
```

*Resultado: todas as linhas em `payment` cuja data de pagamento seja anterior à data especificada serão removidas.*

### Exemplo 3: Excluindo com uma subconsulta
Às vezes, é necessário excluir linhas com base em uma condição de outra tabela. Por exemplo, vamos remover os pagamentos de clientes inativos:

```sql
DELETE FROM payment
WHERE customer_id IN (
    SELECT customer_id
    FROM customer
    WHERE active = 0
);
```

*Resultado: todos os pagamentos dos clientes marcados como inativos serão excluídos.*

### Exemplo 4: Excluindo todas as linhas de uma tabela
Se você precisar limpar completamente uma tabela, `DELETE` também pode ser usado sem `WHERE`:

```sql
DELETE FROM temp_import;
```

*Observação: a tabela `temp_import` continuará existindo, mas todas as suas linhas serão removidas.*

---

## Verificação antes de excluir

Uma boa prática é primeiro verificar quais linhas serão afetadas:

```sql
-- Primeiro verificamos as linhas
SELECT customer_id, first_name, last_name, active
FROM customer
WHERE active = 0;

-- Só depois da verificação executamos o DELETE
DELETE FROM customer
WHERE active = 0;
```

Essa abordagem ajuda a evitar a exclusão acidental de dados extras.

---

## Quando `DELETE` é especialmente útil

- limpar dados temporários ou de teste;
- remover registros desatualizados por data;
- excluir linhas que não atendem mais às regras de negócio;
- preparar tabelas para um novo carregamento de dados.

---

**Principais conclusões desta lição:**

*   `DELETE` remove linhas existentes de uma tabela.
*   Sem `WHERE`, **todas** as linhas da tabela serão excluídas.
*   Antes de excluir, é recomendável executar um `SELECT` com a mesma condição.
*   `DELETE` preserva a estrutura da tabela — apenas os dados são removidos.
*   Em cenários importantes, é mais seguro usar transações e considerar as chaves estrangeiras.
