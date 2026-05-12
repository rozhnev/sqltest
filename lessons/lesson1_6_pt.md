---
title: "O que é SQL: linguagem de consulta e estrutura de uma query SQL"
description: "SQL é a linguagem padrão para bancos relacionais. Veja como ela é organizada, quais são seus subconjuntos e como montar uma consulta básica."
keywords: ["o que é SQL", "visão geral do SQL", "estrutura de query SQL", "SELECT FROM WHERE", "subconjuntos do SQL"]
teaches: ["Entender o papel do SQL em SGBDR", "Diferenciar DQL, DDL, DML, DCL e TCL", "Ler a estrutura de uma consulta SQL básica", "Reconhecer os principais objetos de banco de dados"]
about: ["SQL", "Banco de dados relacional", "SGBDR", "SELECT", "DDL", "DML", "Transações"]
---

_Lição 1.6 · Tempo de leitura: ~8 min_

SQL (Structured Query Language) é a principal linguagem para trabalhar com bancos de dados relacionais. Nesta lição, você verá como o SQL é organizado, quais tarefas ele resolve e como é uma primeira consulta básica. Ao final, você conseguirá ler construções SQL simples com segurança e entender o propósito de cada parte.

# O que é SQL: visão geral da linguagem e estrutura de consultas

Na lição anterior, vimos valores NULL e regras para lidar com dados ausentes. Agora, vamos para a visão geral: o que é SQL e por que quase toda análise prática em bancos relacionais depende dessa linguagem.

SQL não é importante apenas para desenvolvedores. Ele também é essencial para analistas, engenheiros de dados e qualquer pessoa que extrai, valida e transforma dados no trabalho diário.

<img src="/images/lessons/lesson1_5-sql.jpg" alt="Diagrama mostrando SQL como linguagem para consultar e modificar dados em um banco relacional" width="100%">

---

## O que é SQL e por que ele é útil?

**SQL** (Structured Query Language) é a linguagem usada para conversar com um SGBDR e ler, inserir, atualizar e excluir dados.

O SQL surgiu na década de 1970 na IBM e se tornou o padrão de fato para bancos relacionais. Sua sintaxe é rígida o suficiente para execução por máquina e, ao mesmo tempo, legível para humanos, o que torna seu uso prático no dia a dia.

Na prática, o SQL resolve três grupos principais de tarefas:

* obter dados de tabelas;
* alterar dados e estrutura do banco;
* controlar acesso e transações.

---

## Principais características do SQL

* **Linguagem declarativa:** você descreve o resultado desejado, não o algoritmo passo a passo.
* **Operações em conjuntos:** SQL processa várias linhas de uma vez, não um registro por vez.
* **Sintaxe padronizada:** as construções centrais são parecidas em diferentes SGBDRs.

---

## Subconjuntos do SQL

O SQL é dividido em vários subconjuntos, cada um com um objetivo específico:

* **Linguagem de Consulta de Dados (DQL):** usada para consultar dados. O comando principal é SELECT.
* **Linguagem de Definição de Dados (DDL):** usada para definir e gerenciar estruturas do banco. Os comandos incluem CREATE, ALTER e DROP.
* **Linguagem de Manipulação de Dados (DML):** usada para manipular dados no banco. Os comandos incluem INSERT, UPDATE e DELETE.
* **Linguagem de Controle de Dados (DCL):** usada para controlar permissões de acesso. Os comandos incluem GRANT e REVOKE.
* **Linguagem de Controle de Transações (TCL):** usada para gerenciar transações. Os comandos incluem COMMIT, ROLLBACK e SAVEPOINT.

---

## Objetos principais em SQL

O SQL opera sobre vários objetos no banco de dados, incluindo:

* **Tabelas:** estrutura principal para armazenar dados em linhas e colunas.
* **Visões (views):** tabelas virtuais baseadas em consultas.
* **Índices:** estruturas que melhoram a velocidade de busca e filtragem.
* **Procedimentos armazenados:** código SQL predefinido executado como uma unidade.
* **Gatilhos:** procedimentos especiais executados automaticamente em eventos como INSERT, UPDATE ou DELETE.
* **Esquemas:** contêineres lógicos para organizar objetos do banco.
* **Restrições:** regras de integridade como PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL e CHECK.
* **Transações:** sequência de operações SQL tratada como uma única unidade de trabalho.
* **Tipos de dados:** definem o tipo de valor aceito em cada coluna, como INTEGER, VARCHAR, DATE e BOOLEAN.

Entender esses objetos é importante porque as consultas SQL sempre se apoiam neles.

---

## Convenções básicas do SQL

A unidade básica no SQL é a **consulta**. Uma consulta é uma solicitação ao SGBDR para recuperar ou modificar dados.

A estrutura básica de uma consulta SQL inclui os seguintes componentes:

* **Instruções (statements):** palavras reservadas com significado específico, como SELECT, FROM, WHERE e JOIN.
* **Cláusulas (clauses):** partes da instrução SQL que definem a ação a executar, como FROM, WHERE, GROUP BY e ORDER BY.
* **Expressões (expressions):** combinações de valores, operadores e funções que resultam em um único valor.
* **Identificadores (identifiers):** nomes de objetos de banco, como tabelas, colunas, visões e esquemas.
* **Comentários:** texto não executável usado para documentação no código SQL.

---

## Escrevendo sua primeira consulta SQL

Um modelo básico de consulta normalmente inclui SELECT, FROM e, quando necessário, WHERE:

```sql
SELECT coluna1,
	   coluna2
FROM nome_da_tabela
WHERE condicao;
```

*Resultado: a consulta retorna apenas as linhas de nome_da_tabela que atendem a condicao e mostra as colunas coluna1 e coluna2.*

Mesmo esse modelo simples já é útil, pois mostra a lógica geral da maioria das consultas analíticas em SQL.

---

**Principais conclusões desta lição:**

* SQL é a linguagem central para trabalhar com bancos de dados relacionais.
* SQL é declarativo: você descreve o resultado, não o algoritmo de execução.
* SQL possui subconjuntos: DQL, DDL, DML, DCL e TCL.
* Consultas são formadas por instruções, cláusulas, expressões e identificadores.
* O esqueleto de uma consulta básica é SELECT ... FROM ... WHERE ....

---

## Perguntas frequentes

### SQL é linguagem de programação ou linguagem de consulta?
SQL é normalmente classificado como linguagem de consulta. Não é de propósito geral, mas é o padrão para trabalhar com dados relacionais.

### Por que é importante conhecer os subconjuntos do SQL?
Eles ajudam a entender rapidamente o objetivo de um comando: consultar dados, alterar estrutura, controlar permissões ou gerenciar transações.

### Posso escrever SQL exatamente igual em qualquer SGBDR?
As construções básicas são parecidas, mas detalhes de sintaxe e funções podem mudar entre MariaDB, PostgreSQL, SQL Server e outros sistemas.

## Perguntas de entrevista

### Como explicar SQL de forma curta em uma entrevista?
**SQL** é a linguagem padrão para consultar e gerenciar dados em bancos relacionais. Ele serve para ler e alterar dados, administrar estruturas e controlar transações.

### Qual é a diferença entre DDL e DML?
**DDL** define e altera a estrutura do banco (tabelas, índices, esquemas), enquanto **DML** manipula os dados das tabelas (INSERT, UPDATE, DELETE).

### Quais são as partes principais de uma consulta SQL básica?
Uma consulta básica geralmente inclui **SELECT** (o que retornar), **FROM** (de qual tabela ler) e **WHERE** (quais linhas filtrar).

Na próxima lição, veremos os tipos de comandos SQL e como eles são aplicados em tarefas práticas.