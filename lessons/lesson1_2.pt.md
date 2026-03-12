# Lição 1.2: Diferentes Tipos de Bases de Dados

Na lição anterior, introduzimos a ideia geral de uma base de dados e de um SGBD. Na prática, porém, nem todas as bases de dados são construídas da mesma forma. Diferentes tipos de bases de dados são otimizados para diferentes tipos de dados, padrões de consulta, requisitos de escalabilidade e necessidades de consistência.

Nesta lição, vamos analisar os tipos de bases de dados mais comuns, as suas principais diferenças, casos de uso típicos e exemplos do mundo real. Também vamos olhar com mais atenção para as **Bases de Dados Relacionais**, porque continuarão a ser o nosso principal foco ao longo deste curso.

## Porque Existem Diferentes Tipos de Bases de Dados?

Nenhum único modelo de base de dados é perfeito para todas as aplicações.

Por exemplo:

* Um sistema bancário precisa de forte consistência e transações fiáveis.
* Um sistema de caching precisa de pesquisas por chave extremamente rápidas.
* Uma rede social pode precisar de armazenamento documental flexível e de análise de relações em estilo grafo.
* Uma plataforma analítica pode precisar de analisar milhares de milhões de valores de forma eficiente para relatórios.

Como sistemas diferentes resolvem problemas diferentes, vários modelos de bases de dados surgiram ao longo do tempo.

## Principais Tipos de Bases de Dados Num Relance

Aqui está uma comparação rápida antes de analisarmos cada tipo com mais detalhe:

| Tipo | Modelo de Dados | Pontos Fortes | Casos de Uso Comuns | Exemplos |
|------|-----------------|---------------|---------------------|----------|
| **Relacional** | Tabelas com linhas e colunas | Forte consistência, SQL, joins, dados estruturados | Banca, ERP, CRM, e-commerce, relatórios | PostgreSQL, MySQL, MariaDB, SQLite, Oracle |
| **Chave-Valor** | Chave associada a um valor | Pesquisas muito rápidas, escalabilidade simples | Caching, sessões, feature flags, carrinhos de compras | Redis, Amazon DynamoDB, Riak |
| **Documental** | Documentos do tipo JSON | Esquema flexível, dados aninhados | Gestão de conteúdo, perfis de utilizador, catálogos, aplicações web | MongoDB, Couchbase, Firestore |
| **Colunas Largas** | Linhas com colunas flexíveis agrupadas em famílias | Elevada taxa de escrita, escalabilidade horizontal | Registo de eventos, IoT, cargas distribuídas em grande escala | Apache Cassandra, HBase, ScyllaDB |
| **Grafo** | Nós e arestas | Consultas centradas em relações | Redes sociais, deteção de fraude, motores de recomendação | Neo4j, Amazon Neptune, ArangoDB |
| **Séries Temporais** | Registos com marca temporal | Ingestão e agregação eficientes ao longo do tempo | Monitorização, métricas, sensores, dados financeiros | InfluxDB, TimescaleDB, OpenTSDB |
| **Colunar Analítica** | Dados armazenados por coluna em vez de por linha | Análises e agregações rápidas | BI, dashboards, data warehousing, OLAP | ClickHouse, DuckDB, Amazon Redshift, BigQuery |
| **Em Memória** | Dados armazenados principalmente em RAM | Latência extremamente baixa | Caching, leaderboards, contadores em tempo real | Redis, Memcached, SAP HANA |

## Bases de Dados Relacionais

As bases de dados relacionais armazenam os dados em **tabelas** compostas por **linhas** e **colunas**. As tabelas podem ser ligadas entre si através de **relações**, normalmente usando chaves primárias e chaves estrangeiras.

Este modelo é especialmente adequado quando os dados estão bem estruturados e quando a correção, a consistência e as consultas complexas são importantes.

### Propriedades Fundamentais das Bases de Dados Relacionais

**1. Esquema estruturado**

As bases de dados relacionais exigem normalmente um esquema claramente definido. Antes de armazenar dados, definem-se tabelas, colunas, tipos de dados, restrições e relações.

Isto torna a estrutura previsível e mais fácil de validar.

**2. Relações entre tabelas**

Uma grande força dos sistemas relacionais é a capacidade de modelar relações de forma explícita.

Por exemplo:

* Uma tabela `customers` pode estar relacionada com uma tabela `orders`.
* Uma tabela `orders` pode estar relacionada com uma tabela `order_items`.

Isto torna as bases de dados relacionais muito adequadas para sistemas de negócio em que as entidades estão interligadas.

**3. Suporte a SQL**

As bases de dados relacionais são normalmente consultadas usando **SQL (Structured Query Language)**. O SQL fornece uma forma padrão de filtrar, juntar, agregar, ordenar e modificar dados estruturados.

**4. Transações ACID**

As bases de dados relacionais são bem conhecidas por suportarem as propriedades **ACID**:

* **Atomicidade:** Uma transação é totalmente bem-sucedida ou falha por completo.
* **Consistência:** Os dados têm de permanecer válidos segundo as regras definidas.
* **Isolamento:** Transações concorrentes não devem interferir incorretamente umas com as outras.
* **Durabilidade:** Depois de confirmados, os dados permanecem armazenados mesmo após falhas.

Estas propriedades são críticas em sistemas como banca, faturação, reservas e controlo de inventário.

**5. Restrições de integridade dos dados**

As bases de dados relacionais podem aplicar regras diretamente ao nível da base de dados, por exemplo:

* chaves primárias
* chaves estrangeiras
* restrições de unicidade
* restrições `NOT NULL`
* restrições `CHECK`

Estas funcionalidades ajudam a evitar dados inválidos ou inconsistentes.

**6. Joins poderosos e relatórios**

As bases de dados relacionais destacam-se quando é necessário combinar informação de várias tabelas. Esta é uma das razões pelas quais continuam a ser centrais em relatórios, análise, finanças, operações e muitos sistemas transacionais.

**7. Normalização e redução de redundância**

A conceção relacional recorre frequentemente à **normalização**, o que significa organizar os dados em tabelas relacionadas para reduzir a duplicação e melhorar a consistência.

Por exemplo, a informação de um cliente pode ser armazenada uma única vez numa tabela `customers` em vez de ser repetida em cada registo de encomenda.

### Casos de Uso Comuns para Bases de Dados Relacionais

As bases de dados relacionais são normalmente a melhor escolha quando:

* os dados são estruturados e claramente definidos
* as relações entre entidades são importantes
* as transações têm de ser fiáveis
* a consistência é mais importante do que a flexibilidade do esquema
* a aplicação precisa de consultas complexas e relatórios

### Exemplos de Bases de Dados Relacionais

* **PostgreSQL:** Poderosa base de dados relacional open source com forte suporte a standards e funcionalidades avançadas.
* **MySQL:** Base de dados relacional popular, amplamente usada em aplicações web.
* **MariaDB:** Fork comunitário do MySQL.
* **SQLite:** Base de dados relacional leve e embebida, armazenada num único ficheiro.
* **Oracle Database:** Base de dados relacional de nível empresarial.
* **Microsoft SQL Server:** Base de dados relacional amplamente usada em ambientes empresariais.

## Bases de Dados Chave-Valor

As bases de dados chave-valor armazenam os dados como um par simples: uma **chave** e o respetivo **valor**.

A chave funciona como um identificador único, e a base de dados recupera o valor diretamente a partir dessa chave. Este modelo é muito simples e muito rápido.

### Principais Diferenças

* O acesso aos dados baseia-se normalmente numa única chave, em vez de joins complexos.
* A base de dados muitas vezes não compreende a estrutura interna do valor.
* Está otimizada para leituras e escritas extremamente rápidas.

### Casos de Uso Típicos

* caching de resultados de consultas
* armazenamento de sessões de utilizador
* carrinhos de compras
* feature flags
* limitação de taxa
* leaderboards e contadores

### Exemplos

* **Redis**
* **Amazon DynamoDB**
* **Riak**

## Bases de Dados Documentais

As bases de dados documentais armazenam dados como **documentos**, normalmente num formato semelhante a JSON. Cada documento pode conter campos, arrays e objetos aninhados.

Ao contrário das bases de dados relacionais, nem todos os documentos precisam de ter exatamente a mesma estrutura.

### Principais Diferenças

* O esquema é flexível ou semi-flexível.
* Dados relacionados podem muitas vezes ser armazenados em conjunto no mesmo documento.
* São convenientes para aplicações cuja estrutura evolui com frequência.

### Casos de Uso Típicos

* sistemas de gestão de conteúdo
* catálogos de produtos
* perfis de utilizador
* aplicações móveis e web
* prototipagem de sistemas com requisitos em mudança

### Exemplos

* **MongoDB**
* **Couchbase**
* **Google Firestore**

## Bases de Dados de Colunas Largas

As bases de dados de colunas largas, por vezes chamadas **bases de dados de família de colunas**, armazenam dados em linhas, mas cada linha pode ter um conjunto muito grande e flexível de colunas. São concebidas para distribuição por muitos servidores e para elevada taxa de escrita.

### Principais Diferenças

* O esquema é mais flexível do que nas bases de dados relacionais.
* Estão otimizadas para armazenamento distribuído em grande escala.
* Lidam bem com conjuntos de dados massivos e cargas pesadas de escrita.
* Tipicamente não suportam joins relacionais da mesma forma que as bases de dados SQL.

### Casos de Uso Típicos

* registo de eventos
* telemetria IoT
* sistemas de mensagens
* aplicações com muita escrita
* sistemas distribuídos geograficamente

### Exemplos

* **Apache Cassandra**
* **Apache HBase**
* **ScyllaDB**

## Bases de Dados Colunares Analíticas

Uma base de dados **colunar** armazena os valores da mesma coluna juntos em disco, em vez de armazenar uma linha completa. Isto é diferente de uma base de dados de colunas largas.

O armazenamento colunar é especialmente eficiente para consultas analíticas que leem algumas colunas de um conjunto de dados muito grande.

### Principais Diferenças

* Otimizadas para analisar e agregar grandes volumes de dados.
* Muito eficientes para relatórios e análise.
* Normalmente menos adequadas para cargas transacionais intensas com muitas pequenas atualizações de linhas.

### Casos de Uso Típicos

* business intelligence
* dashboards
* data warehousing
* relatórios analíticos
* análise de logs em grande escala

### Exemplos

* **ClickHouse**
* **DuckDB**
* **Amazon Redshift**
* **Google BigQuery**

## Bases de Dados em Grafo

As bases de dados em grafo são concebidas para dados em que as relações são a parte mais importante do modelo. Armazenam **nós** (entidades) e **arestas** (relações).

### Principais Diferenças

* A navegação por relações é rápida e natural.
* São ideais quando é necessário consultar caminhos, redes e dados ligados.
* São frequentemente mais adequadas do que as bases de dados relacionais para consultas com múltiplos saltos entre relações.

### Casos de Uso Típicos

* redes sociais
* deteção de fraude
* sistemas de recomendação
* topologia de rede
* grafos de conhecimento

### Exemplos

* **Neo4j**
* **Amazon Neptune**
* **ArangoDB**

## Bases de Dados de Séries Temporais

As bases de dados de séries temporais são especializadas em pontos de dados associados ao tempo. Estão otimizadas para elevadas taxas de ingestão, políticas de retenção, compressão e agregação baseada no tempo.

### Principais Diferenças

* Cada registo está associado a um timestamp.
* As consultas focam-se frequentemente em intervalos como a última hora, o último dia ou o último mês.
* Fornecem agregações eficientes sobre janelas temporais.

### Casos de Uso Típicos

* monitorização de servidores
* métricas de aplicações
* dados de sensores
* dados do mercado bolsista
* medições industriais

### Exemplos

* **InfluxDB**
* **TimescaleDB**
* **OpenTSDB**

## Bases de Dados em Memória

As bases de dados em memória armazenam a maioria ou a totalidade dos dados em RAM em vez de em disco. Isto torna-as extremamente rápidas, embora a memória seja mais cara do que o armazenamento em disco.

Algumas bases de dados em memória são usadas apenas como caches temporárias, enquanto outras também podem persistir dados em disco.

### Casos de Uso Típicos

* caching
* armazenamento de sessões
* contadores em tempo real
* leaderboards de jogos
* sistemas de latência ultra-baixa

### Exemplos

* **Redis**
* **Memcached**
* **SAP HANA**

## Escolher o Tipo Certo de Base de Dados

Ao selecionar uma base de dados, convém fazer perguntas como estas:

* Os dados são altamente estruturados ou flexíveis?
* Preciso de transações ACID fortes?
* Vou executar joins complexos?
* A pesquisa por chave com baixa latência é a principal prioridade?
* A carga é transacional ou analítica?
* O sistema vai escalar por muitos servidores?
* As relações entre entidades são centrais para a aplicação?

Em muitos sistemas reais, as organizações usam mais do que um tipo de base de dados. Por exemplo:

* uma base de dados relacional para os principais dados de negócio
* Redis para caching
* uma base de dados documental para conteúdo flexível
* um armazém colunar para análise

Isto é frequentemente chamado de **persistência poliglota**.

## Resumo das Principais Diferenças

As principais diferenças entre tipos de bases de dados normalmente envolvem:

* o **modelo de dados** — tabelas, documentos, pares chave-valor, grafos ou registos com marca temporal
* a **flexibilidade do esquema** — estrutura fixa versus flexível
* o **estilo de consulta** — SQL, pesquisa por chave, consultas documentais, navegação em grafo, análise por janelas temporais
* o **modelo de consistência** — fortes garantias transacionais versus compromissos orientados para escalabilidade
* o **perfil de desempenho** — otimizado para transações, análise, relações ou acesso ultra-rápido

## Principais Conclusões Desta Lição

* Existem diferentes tipos de bases de dados porque diferentes aplicações têm diferentes requisitos técnicos e de negócio.
* As **Bases de Dados Relacionais** são mais conhecidas pelos seus esquemas estruturados, SQL, relações, restrições de integridade e transações ACID.
* As **bases de dados chave-valor** são excelentes para pesquisas rápidas e caching.
* As **bases de dados documentais** são úteis quando a estrutura dos dados é flexível ou evolui com frequência.
* As **bases de dados de colunas largas** são construídas para cargas distribuídas, de grande escala e com muita escrita.
* As **bases de dados colunares analíticas** são otimizadas para relatórios e análise em grande escala.
* As **bases de dados em grafo** são ideais para dados ricos em relações.
* As **bases de dados de séries temporais** especializam-se em métricas e eventos baseados no tempo.
* Muitos sistemas modernos usam vários tipos de bases de dados em conjunto.

Na próxima lição, vamos aprofundar a estrutura interna das **Bases de Dados Relacionais**, incluindo tabelas, linhas, colunas, chaves e restrições de integridade.