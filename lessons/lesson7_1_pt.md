Esta lição apresenta a instrução `INSERT INTO`, o comando principal usado para adicionar novos registros a uma tabela de banco de dados. Você aprenderá a sintaxe para inserir dados em todas as colunas, bem como especificar colunas específicas para a entrada de dados. Também abordaremos a inserção de múltiplas linhas e a importância da correspondência entre tipos de dados. Ao final desta lição, você será capaz de popular as tabelas do seu banco de dados com novas informações de forma precisa e eficiente.

# Lição 7.1: A Instrução INSERT INTO

Até agora, focamos em recuperar dados de tabelas existentes usando a instrução `SELECT`. Agora, começaremos a explorar a **Linguagem de Manipulação de Dados (DML)**, começando por como adicionar novos dados às suas tabelas usando a instrução `INSERT INTO`.

## A Sintaxe Básica

Existem duas formas principais de usar a instrução `INSERT INTO`.

### 1. Especificando Colunas (Recomendado)
Este é o método mais seguro e comum. Você lista explicitamente as colunas que deseja preencher, seguidas pelos valores para essas colunas.

```sql
INSERT INTO nome_da_tabela (coluna1, coluna2, coluna3)
VALUES (valor1, valor2, valor3);
```

### 2. Sem Especificar Colunas
Se você estiver fornecendo valores para **todas** as colunas da tabela na ordem exata em que foram definidas, poderá omitir os nomes das colunas. No entanto, isso é menos flexível e pode levar a erros se a estrutura da tabela for alterada.

```sql
INSERT INTO nome_da_tabela
VALUES (valor1, valor2, valor3, ...);
```

---

## Regras Importantes para Inserção de Dados
*   **Tipos de Dados:** Os valores que você fornece devem corresponder ao tipo de dados da coluna correspondente (por exemplo, você não pode inserir texto em uma coluna numérica).
*   **Strings e Datas:** Assim como na cláusula `WHERE`, os valores de string (texto) e data devem estar entre aspas simples (`'`).
*   **Números:** Valores numéricos não requerem aspas.
*   **Valores NULL:** Se uma coluna permitir `NULL` e você não fornecer um valor para ela, ela será preenchida com `NULL` (ou um valor padrão, se definido).

---

## Exemplos

### Exemplo 1: Inserindo um Novo Ator
Vamos adicionar um novo ator à tabela `actor` no banco de dados Sakila.

```sql
INSERT INTO actor (first_name, last_name)
VALUES ('JOHNNY', 'DEPP');
```
*Nota: Não especificamos o `actor_id` porque ele geralmente é gerado automaticamente pelo banco de dados.*

### Exemplo 2: Inserindo em Colunas Específicas
Se tivermos uma tabela com muitas colunas, mas quisermos preencher apenas algumas:

```sql
INSERT INTO customer (first_name, last_name, email, store_id, address_id)
VALUES ('ALICE', 'JOHNSON', 'alice.j@example.com', 1, 5);
```

### Exemplo 3: Inserção de Múltiplas Linhas
A maioria dos bancos de dados modernos permite inserir várias linhas em uma única instrução, separando os conjuntos de valores por vírgulas.

```sql
INSERT INTO actor (first_name, last_name)
VALUES 
    ('TOM', 'HANKS'),
    ('MERYL', 'STREEP'),
    ('LEONARDO', 'DICAPRIO');
```

---

**Principais Conclusões desta Lição:**

*   A instrução `INSERT INTO` é usada para adicionar novas linhas a uma tabela.
*   Listar explicitamente os nomes das colunas é recomendado para melhor confiabilidade e legibilidade do código.
*   Valores de string e data devem estar entre aspas simples.
*   Você pode inserir várias linhas de uma só vez para melhorar o desempenho e reduzir o código.

Na próxima lição, aprenderemos como **Criar Tabelas** do zero e definir sua estrutura.
