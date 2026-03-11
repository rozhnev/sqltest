# Lição 1.1: Introdução a Bases de Dados

Bem-vindo ao excitante mundo das bases de dados! Nesta primeira lição, vamos estabelecer as bases, compreendendo o que são as bases de dados, porque são cruciais no mundo atual orientado por dados e os conceitos fundamentais que exploraremos ao longo deste curso.

## O Que é uma Base de Dados?

No seu núcleo, uma base de dados é uma coleção organizada de informação estruturada, ou dados, tipicamente armazenada eletronicamente num sistema informático. Pense nela como um sofisticado arquivo digital. Em vez de documentos em papel espalhados por todo o lado, uma base de dados fornece uma maneira estruturada de armazenar, gerir e recuperar informações de forma eficiente.

**Características Chave de uma Base de Dados:**

* **Organizada:** Os dados são estruturados de uma maneira específica, facilitando a sua localização e gestão. Esta estrutura é muitas vezes baseada em tabelas com linhas e colunas.
* **Persistente:** Os dados armazenados numa base de dados são tipicamente persistentes, o que significa que permanecem armazenados mesmo quando a aplicação que os utiliza é fechada ou o computador é desligado.
* **Partilhada:** Vários utilizadores e aplicações podem muitas vezes aceder e interagir com a mesma base de dados simultaneamente.
* **Gerida:** Sistemas de Gestão de Bases de Dados (SGBD) são aplicações de software que permitem definir, criar, manter e aceder a bases de dados. Exemplos incluem MariaDB, PostgreSQL, MySQL, SQLite, Oracle e Microsoft SQL Server.

## Por Que as Bases de Dados São Importantes?

As bases de dados são a espinha dorsal de inúmeras aplicações e sistemas que usamos todos os dias. Aqui estão apenas algumas razões pelas quais são tão importantes:

* **Armazenamento de Dados:** Fornecem uma maneira fiável e eficiente de armazenar grandes volumes de dados.
* **Recuperação de Dados:** Permitem a recuperação rápida e fácil de informações específicas com base em critérios definidos.
* **Gestão de Dados:** Os SGBD fornecem ferramentas para organizar, atualizar e manter a integridade dos dados.
* **Partilha de Dados:** Permitem que vários utilizadores e aplicações acedam e partilhem dados de forma controlada.
* **Análise de Dados:** Dados estruturados em bases de dados são essenciais para realizar análises, gerar relatórios e obter informações valiosas.
* **Desenvolvimento de Aplicações:** A maioria das aplicações modernas depende de bases de dados para armazenar e gerir os seus dados, desde plataformas de redes sociais a websites de comércio eletrónico.

## Tipos de Bases de Dados (Breve Visão Geral)

Embora este curso se concentre principalmente em **Bases de Dados Relacionais**, é útil ter uma compreensão básica de outros tipos:

* **Bases de Dados Relacionais (BDR):** Organizam os dados em tabelas com linhas e colunas, estabelecendo relações entre tabelas através de chaves. Exemplos: <a href="https://mariadb.org/" target="_blank">MariaDB</a>, <a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a>, <a href="https://mysql.com/" target="_blank">MySQL</a>,  <a href="https://www.sqlite.org/" target="_blank">SQLite</a>. Este é o tipo em que nos focaremos.
* **Bases de Dados NoSQL:** Uma ampla categoria de bases de dados que não seguem o modelo relacional tradicional. São frequentemente usadas para lidar com dados não estruturados ou semiestruturados e para escalabilidade em ambientes distribuídos. Exemplos: MongoDB, Cassandra, Redis.
* **Bases de Dados em Memória:** Armazenam dados principalmente na memória do computador para acesso mais rápido. Frequentemente usadas para caching ou aplicações que exigem latência muito baixa. Exemplos: Redis (também pode ser persistente), Memcached.

## O Que é um SGBD?

Um **Sistema de Gestão de Bases de Dados (SGBD)** é um software que atua como intermediário entre os utilizadores (ou aplicações) e a própria base de dados. Fornece uma forma sistemática e controlada de criar, ler, atualizar e eliminar dados, garantindo simultaneamente segurança, consistência e eficiência.

<img src="/images/lessons/lesson1_1-dbms.jpg" alt="DBMS overview" width="100%">

**Funções Principais de um SGBD:**

* **Definição de Dados:** Permite definir a estrutura (esquema) da base de dados — criar tabelas, especificar tipos de dados, definir restrições e estabelecer relações.
* **Manipulação de Dados:** Fornece mecanismos para inserir, atualizar, eliminar e consultar dados (tipicamente através de SQL).
* **Gestão do Armazenamento de Dados:** Gere a forma como os dados são fisicamente armazenados em disco, incluindo indexação, buffers e otimização do armazenamento para acesso rápido.
* **Gestão de Transações:** Garante que uma série de operações seja inteiramente bem-sucedida ou inteiramente cancelada, mantendo a base de dados num estado consistente. Isto é regido pelas propriedades **ACID**: Atomicidade, Consistência, Isolamento e Durabilidade.
* **Controlo de Concorrência:** Gere o acesso simultâneo de vários utilizadores ou aplicações, prevenindo conflitos e corrupção de dados quando várias pessoas modificam dados ao mesmo tempo.
* **Controlo de Acesso e Segurança:** Aplica autenticação e autorização — controla quem pode ligar-se à base de dados e que operações estão autorizados a executar.
* **Backup e Recuperação:** Fornece ferramentas e mecanismos para fazer backup dos dados e restaurar a base de dados para um estado consistente após uma falha.
* **Integridade dos Dados:** Aplica regras (restrições) que mantêm os dados precisos e válidos, como garantir que um valor é único ou que uma referência a outra tabela realmente existe (integridade referencial).

Exemplos conhecidos de SGBD incluem **MariaDB**, **PostgreSQL**, **MySQL**, **SQLite**, **Oracle Database** e **Microsoft SQL Server**.

## Ferramentas GUI para SGBD — E a Sua Diferença do SGBD

Uma **ferramenta GUI (Interface Gráfica do Utilizador) para SGBD** é uma aplicação de ambiente de trabalho ou web separada que fornece uma interface visual e fácil de usar para interagir com um SGBD. Enquanto o SGBD é o motor que armazena e processa os dados, uma ferramenta GUI é simplesmente um **cliente** que se liga ao SGBD e envia comandos em seu nome.

**Exemplos de ferramentas GUI populares para SGBD:**

| Ferramenta | Compatível com |
|------------|---------------|
| **DBeaver** | MariaDB, PostgreSQL, MySQL, SQLite, e muito mais |
| **TablePlus** | MariaDB, PostgreSQL, MySQL, SQLite, e mais |
| **pgAdmin** | PostgreSQL |
| **MySQL Workbench** | MySQL / MariaDB |
| **DataGrip** | A maioria dos principais SGBD |
| **HeidiSQL** | MariaDB, MySQL, PostgreSQL |
| **DB Browser for SQLite** | SQLite |

**Principais diferenças entre um SGBD e uma ferramenta GUI:**

| Aspeto | SGBD | Ferramenta GUI para SGBD |
|--------|------|---------------------------|
| **Papel** | O motor da base de dados — armazena, gere e processa dados | Uma aplicação cliente — liga-se ao SGBD para exibir e editar dados |
| **Obrigatório?** | Sim — não é possível armazenar ou consultar dados sem ele | Não — ferramenta de conveniência opcional; o SGBD funciona sem ela |
| **Executa onde?** | Tipicamente num servidor (ou localmente para SQLite) | Na máquina do programador ou administrador |
| **Interface** | Linha de comandos / API programática | Janelas visuais, editores de consultas, navegadores de tabelas |
| **Capacidades** | Controlo total sobre armazenamento, transações, segurança | Subconjunto das funcionalidades do SGBD, apresentado visualmente |

Em resumo, o **SGBD é o motor** e a **ferramenta GUI é o painel de instrumentos**. Pode-se conduzir sem painel de instrumentos, mas o painel torna muito mais fácil ver o que está a acontecer e controlar as coisas. Ao longo deste curso, interagiremos principalmente com bases de dados usando diretamente **SQL** — a linguagem compreendida por qualquer SGBD — independentemente da ferramenta GUI que possa escolher usar.

## Bases de Dados Relacionais: O Nosso Foco

Para este curso, vamos mergulhar fundo nas **Bases de Dados Relacionais** e na **SQL (Structured Query Language)** usada para interagir com elas. O modelo relacional, com a sua estrutura bem definida e poderosas capacidades de consulta, continua a ser a pedra angular da gestão e análise de dados.

Na próxima lição, vamos aprofundar os conceitos fundamentais das bases de dados relacionais, incluindo tabelas, colunas, linhas e o papel crucial das chaves.

**Principais Conclusões Desta Lição:**

* Uma base de dados é uma coleção organizada e persistente de dados estruturados.
* As bases de dados são essenciais para armazenar, gerir, recuperar e partilhar informações.
* Um **SGBD** é o motor de software que armazena, gere e controla o acesso a uma base de dados — fornecendo definição de dados, manipulação, gestão de transações, segurança, e muito mais.
* Uma **ferramenta GUI para SGBD** é uma aplicação cliente opcional que fornece uma interface visual para um SGBD — é separada do próprio SGBD.
* Concentrar-nos-emos principalmente em Bases de Dados Relacionais (BDR) e SQL neste curso.

Bem-vindo a bordo! Vamos continuar a nossa jornada no mundo do SQL.