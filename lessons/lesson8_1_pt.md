Esta lição apresenta a instrução `INSERT INTO`, o comando principal usado para adicionar novos registros a uma tabela de banco de dados. Você aprenderá a sintaxe para inserir dados em todas as colunas, bem como especificar colunas específicas para a entrada de dados. Também abordaremos a inserção de múltiplas linhas e a importância da correspondência entre tipos de dados. Ao final desta lição, você será capaz de popular as tabelas do seu banco de dados com novas informações de forma precisa e eficiente.

# Lição 8.1: A Instrução INSERT INTO

Até agora, focamos em recuperar dados de tabelas existentes usando a instrução `SELECT`. Agora, começaremos a explorar a **Linguagem de Manipulação de Dados (DML)**, começando por como adicionar novos dados às suas tabelas usando a instrução `INSERT INTO`.

<img src="/images/lessons/lesson8_1-insert-into.svg" alt="Lesson illustration" width="100%">

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

## Inserindo Dados de Outra Consulta (`INSERT INTO ... SELECT`)

Às vezes, você não precisa inserir os dados manualmente, mas sim transferi-los de uma tabela para outra (ex: durante o arquivamento ou geração de relatórios). Para isso, utiliza-se a combinação de `INSERT INTO` e `SELECT`.

### Sintaxe

```sql
INSERT INTO tabela_destino (coluna1, coluna2, coluna3)
SELECT coluna_origem1, coluna_origem2, coluna_origem3
FROM tabela_origem
WHERE condicao;
```

### Flexibilidade na Formação de Dados

Uma característica importante deste comando é que, no bloco `SELECT`, você pode combinar diferentes tipos de valores:

1.  **Valores selecionados**: diretamente da tabela de origem (`coluna_origem1`).
2.  **Valores calculados**: resultado de fórmulas ou funções (ex: `amount * 0.1`).
3.  **Valores constantes**: dados fixos que não estão na tabela de origem (ex: data de inserção ou um status como uma string).

### Exemplo: Criando um Arquivo de Clientes Inativos

Suponha que tenhamos uma tabela `customer_archive` e queiramos transferir dados para lá a partir da tabela principal `customer`, adicionando a data de arquivamento e uma nota de status:

```sql
INSERT INTO customer_archive (customer_id, full_name, archived_at, status_note)
SELECT 
    customer_id, 
    CONCAT(first_name, ' ', last_name), -- Valor calculado (Nome Completo)
    CURRENT_DATE,                       -- Constante (data atual)
    'Auto-archived'                     -- Constante (etiqueta de texto)
FROM customer
WHERE active = 0;
```

*Nota: O número e a ordem das colunas em `INSERT INTO` devem corresponder estritamente ao número e à ordem das colunas retornadas no `SELECT`.*

---

**Principais Conclusões desta Lição:**

*   A instrução `INSERT INTO` é usada para adicionar novas linhas a uma tabela.
*   O comando `INSERT INTO ... SELECT` permite copiar dados de uma tabela para outra.
*   No bloco `SELECT`, você pode combinar dados reais da tabela, campos calculados e constantes.
*   Listar explicitamente os nomes das colunas é recomendado para melhor confiabilidade e legibilidade do código.
*   Valores de string e data devem estar entre aspas simples.
*   Você pode inserir várias linhas de uma só vez para melhorar o desempenho.
