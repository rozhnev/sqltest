Esta lição apresenta a instrução `CREATE TABLE`, o principal comando da Linguagem de Definição de Dados (DDL) usado para criar novas tabelas em um banco de dados. Você aprenderá a sintaxe básica, como definir colunas e seus tipos de dados, e como usar restrições importantes e parâmetros de coluna, como `PRIMARY KEY`, `NOT NULL`, `DEFAULT`, `CHARACTER SET` e `COLLATE`. Ao final desta lição, você será capaz de criar tabelas com uma estrutura clara e confiável.

# Lição 9.1: A Instrução CREATE TABLE

Até agora, trabalhamos principalmente com tabelas já existentes e consultamos dados a partir delas. Mas, no trabalho real com bancos de dados, é importante não apenas ler informações, mas também saber **criar a estrutura onde esses dados serão armazenados**. É exatamente para isso que serve a instrução `CREATE TABLE`.

`CREATE TABLE` faz parte da **Linguagem de Definição de Dados (DDL, Data Definition Language)**. Com ela, descrevemos como uma tabela será estruturada: quais colunas ela terá, quais tipos de dados essas colunas usarão e quais regras serão aplicadas aos valores armazenados.

## Sintaxe Básica

A forma mais simples da instrução é esta:

```sql
CREATE TABLE table_name (
    column1 data_type,
    column2 data_type,
    column3 data_type
);
```

Após o nome da tabela, as colunas são listadas entre parênteses. Para cada coluna, você precisa especificar:

- o nome da coluna (obrigatório);
- o tipo de dado (obrigatório);
- e, quando necessário, características adicionais como codificação, restrições, comentários e outras.

## Exemplo de uma Tabela Simples

Vamos criar uma tabela `students`:

```sql
CREATE TABLE students (
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    created_at TIMESTAMP
);
```

Neste exemplo:

- `student_id` é um número inteiro;
- `first_name` e `last_name` são valores de texto com até 50 caracteres;
- `birth_date` armazena a data de nascimento;
- `created_at` armazena a data e a hora de criação do registro.

Depois de executar esse comando, a tabela será criada, mas continuará vazia.

---

## Tipos de Dados Comuns

Ao criar tabelas, é importante escolher tipos de dados adequados. Aqui estão alguns dos mais usados:

- `INT` para números inteiros;
- `VARCHAR(n)` para strings de tamanho variável com até `n` caracteres;
- `TEXT` para textos longos;
- `DATE` para datas;
- `TIMESTAMP` para data e hora, frequentemente usado para registrar quando uma linha foi criada ou alterada;
- `DECIMAL(p, s)` para valores numéricos exatos, como quantias em dinheiro;
- `BOOLEAN` para valores lógicos `TRUE` ou `FALSE`.

Escolher o tipo de dado correto ajuda a economizar espaço, manter a qualidade dos dados e evitar erros. Você pode ler mais sobre tipos de dados <a href="/pt/lesson/getting-started/basic-data-types">aqui</a>.

---

## Restrições de Coluna

As restrições definem regras para os dados armazenados em uma tabela.

### 1. `PRIMARY KEY`
Uma chave primária identifica de forma única cada linha da tabela.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

A coluna `student_id` não pode conter valores duplicados nem `NULL`.

### 2. `NOT NULL`
Essa restrição exige que uma coluna sempre contenha um valor.

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
```

Agora `first_name` e `last_name` não podem ficar vazios.

### 3. `CHECK`
A restrição `CHECK` define uma condição que os valores de uma coluna devem satisfazer.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) CHECK (price >= 0)
);
```

Neste exemplo, o banco de dados não permitirá salvar um produto com preço negativo.

---

## Parâmetros adicionais de coluna

Além das restrições, as colunas podem ter parâmetros extras. Eles não proíbem nem permitem valores diretamente, mas ajudam a definir o comportamento da coluna com mais precisão.

### 1. `DEFAULT`
O parâmetro `DEFAULT` define o valor que será usado caso nenhum valor seja informado durante a inserção.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) DEFAULT 0.00
);
```

Se nenhum preço for informado ao adicionar um produto, o banco de dados usará automaticamente `0.00`.

### 2. `CHARACTER SET` e `COLLATE`
Para colunas de texto, você pode definir explicitamente o conjunto de caracteres e as regras de comparação.

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    last_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
);
```

Aqui, `CHARACTER SET` define a codificação usada para armazenar dados de texto, enquanto `COLLATE` define como as strings serão comparadas e ordenadas. Isso é especialmente importante quando uma tabela precisa funcionar corretamente com diferentes idiomas e caracteres.

---

## Exemplo de uma Tabela com Várias Regras

Aqui está um exemplo mais realista de uma tabela `employees`:

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 0.00
);
```

O que está acontecendo aqui:

- `employee_id` é o identificador único do funcionário;
- `first_name` e `last_name` são obrigatórios;
- `email` deve ser único;
- `hire_date` é obrigatório;
- `salary` assume `0.00` por padrão.

Essa estrutura já reflete melhor requisitos reais de dados.

---

## Usando `IF NOT EXISTS`

Em muitos sistemas de banco de dados, você pode evitar um erro caso a tabela já exista usando `IF NOT EXISTS`:

```sql
CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
```

Isso é útil ao executar novamente scripts de estudo ou migrações.

---

## Pontos de Atenção

Ao criar tabelas, vale a pena lembrar algumas regras:

- escolha os tipos de dados com cuidado, em vez de deixar tudo genérico demais;
- defina uma `PRIMARY KEY` para tabelas em que cada linha precisa ser identificada de forma única;
- use `NOT NULL` para campos realmente obrigatórios;
- use `DEFAULT` quando uma coluna tiver um valor padrão natural;
- para campos de texto, defina `CHARACTER SET` e `COLLATE` explicitamente quando necessário;
- tente tornar a estrutura clara e previsível desde o início.

Uma tabela bem projetada reduz erros e facilita o trabalho posterior com `INSERT`, `UPDATE` e `SELECT`.

---

## Exemplo Prático

Imagine que queremos criar uma tabela para armazenar livros:

```sql
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    published_date DATE,
    price DECIMAL(8, 2) DEFAULT 0.00
);
```

Depois que essa tabela for criada, poderemos começar a adicionar linhas usando `INSERT INTO`.

---

**Principais Conclusões desta Lição:**

*   A instrução `CREATE TABLE` é usada para criar novas tabelas em um banco de dados.
*   Cada coluna deve ter um nome e um tipo de dado.
*   Restrições como `PRIMARY KEY`, `NOT NULL`, `UNIQUE` e `CHECK` ajudam a controlar a qualidade dos dados.
*   Parâmetros adicionais de coluna, como `DEFAULT`, `CHARACTER SET` e `COLLATE`, ajudam a ajustar com mais precisão o armazenamento e o comportamento dos dados.
*   Uma tabela bem projetada torna o trabalho futuro com dados mais simples e confiável.
*   `IF NOT EXISTS` ajuda a evitar erros ao criar a mesma tabela mais de uma vez.
