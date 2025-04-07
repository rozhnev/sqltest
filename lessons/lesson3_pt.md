# Lição 3: Visão Geral do SQL

## O que é SQL?
SQL (Structured Query Language) é uma linguagem padrão usada para gerenciar e manipular dados em sistemas de gerenciamento de banco de dados relacional (SGBDR). Ele fornece uma maneira poderosa e flexível de interagir com bancos de dados, permitindo que os usuários executem várias operações, como consultas, inserção, atualização e exclusão de dados.

O SQL foi desenvolvido no início da década de 1970 pela IBM e, desde então, tornou-se o padrão de fato para gerenciamento de bancos de dados relacionais. É amplamente utilizado em vários setores e aplicações, tornando-se uma habilidade essencial para analistas de dados, desenvolvedores e administradores de banco de dados.
O SQL foi projetado para ser fácil de aprender e usar, com uma sintaxe que é legível tanto para humanos quanto para máquinas. Ele permite que os usuários expressem consultas e operações complexas de forma simples, tornando-o acessível tanto para usuários técnicos quanto não técnicos.

## Principais Características do SQL
*   **Linguagem Declarativa:** SQL é uma linguagem declarativa, o que significa que os usuários especificam o que desejam obter ou modificar, sem detalhar como fazê-lo. Essa abstração simplifica a escrita e otimização de consultas.
*   **Operações Baseadas em Conjuntos:** SQL opera em conjuntos de dados, em vez de registros individuais, o que permite o processamento eficiente de grandes conjuntos de dados.

## Subconjuntos do SQL
O SQL é dividido em vários subconjuntos, cada um servindo a um propósito específico:
*   **Linguagem de Consulta de Dados (DQL):** Usada para consultar dados de bancos de dados. O comando principal é SELECT.
*   **Linguagem de Definição de Dados (DDL):** Usada para definir e gerenciar estruturas de banco de dados. Os comandos incluem CREATE, ALTER e DROP.
*   **Linguagem de Manipulação de Dados (DML):** Usada para manipular dados em um banco de dados. Os comandos incluem INSERT, UPDATE e DELETE.
*   **Linguagem de Controle de Dados (DCL):** Usada para controlar o acesso aos dados em um banco de dados. Os comandos incluem GRANT e REVOKE.
*   **Linguagem de Controle de Transações (TCL):** Usada para gerenciar transações em um banco de dados. Os comandos incluem COMMIT, ROLLBACK e SAVEPOINT.

## Objetos SQL
O SQL opera em vários objetos em um banco de dados, incluindo:
*   **Tabelas:** A estrutura primária para armazenar dados em um banco de dados relacional. As tabelas consistem em linhas e colunas, onde cada linha representa um registro e cada coluna representa um atributo desse registro.
*   **Visões:** Tabelas virtuais que fornecem uma maneira de apresentar dados de uma ou mais tabelas em um formato específico. As visões podem simplificar consultas complexas e aumentar a segurança, restringindo o acesso a determinados dados.
*   **Índices:** Estruturas que melhoram a velocidade das operações de recuperação de dados em uma tabela de banco de dados. Os índices são criados em uma ou mais colunas de uma tabela para melhorar o desempenho da consulta.
*   **Procedimentos Armazenados:** Código SQL predefinido que pode ser executado como uma única unidade. Os procedimentos armazenados podem encapsular lógica complexa e melhorar o desempenho, reduzindo o tráfego de rede.
*   **Gatilhos:** Tipos especiais de procedimentos armazenados que são executados automaticamente em resposta a determinados eventos em uma tabela, como operações INSERT, UPDATE ou DELETE. Os gatilhos podem impor regras de negócios e manter a integridade dos dados.
*   **Esquemas:** Contêineres lógicos para objetos de banco de dados, como tabelas, visões e índices. Os esquemas ajudam a organizar e gerenciar objetos de banco de dados, fornecendo uma maneira de agrupar objetos relacionados.
*   **Restrições:** Regras aplicadas às colunas da tabela para impor a integridade dos dados. As restrições comuns incluem PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL e CHECK.
*   **Transações:** Uma sequência de uma ou mais operações SQL que são tratadas como uma única unidade de trabalho. As transações garantem a integridade e consistência dos dados, permitindo que várias operações sejam confirmadas ou revertidas como um grupo.
*   **Tipos de Dados:** Definem o tipo de dados que podem ser armazenados em uma coluna, como INTEGER, VARCHAR, DATE e BOOLEAN. Os tipos de dados garantem que os dados armazenados em uma tabela sejam consistentes e válidos.

## Convenções Básicas do SQL
A unidade do SQL é a **consulta**. Uma consulta é uma solicitação ao SGBD para recuperar ou modificar dados.

A estrutura básica de uma consulta SQL consiste nos seguintes componentes:
*   **Instruções:** Palavras reservadas que têm um significado específico em SQL. Os exemplos incluem SELECT, FROM, WHERE e JOIN.
*   **Cláusulas:** Componentes de uma instrução SQL que especificam a ação a ser executada. As cláusulas comuns incluem SELECT, FROM, WHERE, GROUP BY e ORDER BY.
*   **Expressões:** Combinações de valores, operadores e funções que avaliam para um único valor. As expressões podem ser usadas em várias partes de uma instrução SQL, como a lista SELECT ou a cláusula WHERE.
*   **Identificadores:** Nomes usados para se referir a objetos de banco de dados, como tabelas, colunas e visões. Os identificadores podem ser simples (por exemplo, nome_da_tabela) ou qualificados (por exemplo, nome_do_esquema.nome_da_tabela).
*   **Comentários:** Texto não executável dentro do código SQL que fornece explicações ou notas. Os comentários podem ser de linha única (usando --) ou de várias linhas (usando /* ... */).

## Escrevendo sua Primeira Consulta SQL

Uma consulta SQL básica consiste em uma instrução SELECT, uma cláusula FROM e uma cláusula WHERE opcional. Por exemplo:

```sql
SELECT coluna1, coluna2
FROM nome_da_tabela
WHERE condição;
```