Esta lição apresenta as instruções `TRUNCATE` e `DROP TABLE`, usadas para remover dados ou tabelas de um banco de dados. Você aprenderá em que elas diferem entre si e em relação a `DELETE`, em quais situações usar cada uma e quais riscos é importante considerar. Ao final desta lição, você será capaz de escolher a instrução correta para limpar ou remover uma tabela.

# Lição 9.2: As instruções TRUNCATE e DROP TABLE

Na lição anterior, aprendemos a criar tabelas com `CREATE TABLE`. Mas, no trabalho real com bancos de dados, é importante não apenas criar a estrutura, mas também entender como limpar tabelas ou removê-las completamente. Para isso, o SQL oferece as instruções `TRUNCATE` e `DROP TABLE`.

As duas pertencem à Linguagem de Definição de Dados (DDL), mas resolvem tarefas diferentes. `TRUNCATE` remove rapidamente todas as linhas de uma tabela, enquanto `DROP TABLE` remove a própria tabela junto com sua estrutura.

## O que `TRUNCATE` faz

A instrução `TRUNCATE` remove todas as linhas de uma tabela, mas a própria tabela continua existindo.

Depois de executar `TRUNCATE`:

- a estrutura da tabela é preservada;
- os nomes das colunas, os tipos de dados e as restrições permanecem;
- a tabela fica vazia;
- em muitos SGBDs, a operação é mais rápida do que um `DELETE` em massa.

### Sintaxe de `TRUNCATE`

```sql
TRUNCATE TABLE table_name;
```

### Exemplo de `TRUNCATE`

```sql
TRUNCATE TABLE logs;
```

Depois disso, a tabela `logs` continuará existindo no banco de dados, mas todas as suas linhas terão sido removidas.

---

## O que `DROP TABLE` faz

A instrução `DROP TABLE` remove uma tabela completamente.

Depois de executar `DROP TABLE`:

- todos os dados da tabela são removidos;
- a estrutura da tabela é removida;
- a tabela deixa de existir no banco de dados;
- ela não poderá mais ser usada em consultas futuras até ser criada novamente.

### Sintaxe de `DROP TABLE`

```sql
DROP TABLE table_name;
```

### Exemplo de `DROP TABLE`

```sql
DROP TABLE old_reports;
```

Depois disso, a tabela `old_reports` será removida completamente do banco de dados.

---

## Como `TRUNCATE` difere de `DROP TABLE`

Embora ambas as instruções removam dados, existe uma diferença fundamental entre elas.

### 1. O que exatamente é removido

- `TRUNCATE` remove apenas as linhas.
- `DROP TABLE` remove tanto as linhas quanto a própria tabela.

### 2. Se a tabela ainda pode ser usada

- Depois de `TRUNCATE`, a tabela continua existindo e novos dados podem ser inseridos nela novamente.
- Depois de `DROP TABLE`, a tabela deixa de existir, e ela precisa ser recriada antes de voltar a ser usada.

### 3. Quando usar

- `TRUNCATE` é adequado quando você precisa limpar rapidamente uma tabela, mas quer manter sua estrutura.
- `DROP TABLE` é adequado quando a tabela não será mais necessária.

---

## Como `TRUNCATE` difere de `DELETE`

Iniciantes frequentemente comparam `TRUNCATE` com `DELETE`, porque ambos podem remover dados de uma tabela.

As principais diferenças são:

- `DELETE` pode ser usado com `WHERE`, removendo apenas parte das linhas;
- `TRUNCATE` remove todas as linhas da tabela de uma vez;
- `DELETE` pertence ao DML, enquanto `TRUNCATE` normalmente é tratado como DDL;
- `TRUNCATE` costuma ser mais rápido em muitos SGBDs quando a tabela inteira precisa ser esvaziada;
- o comportamento de log, rollback e reinicialização de contadores de identidade depende do SGBD específico.

Se você precisa remover apenas parte dos dados, normalmente a escolha certa é `DELETE`. Se precisa limpar rapidamente a tabela inteira, mantendo sua estrutura, `TRUNCATE` costuma ser mais conveniente.

---

## Pontos de atenção

Ao usar `TRUNCATE` e `DROP TABLE`, é importante lembrar algumas regras:

- sempre verifique se você precisa remover apenas os dados ou toda a estrutura da tabela;
- não use `DROP TABLE` se a estrutura da tabela ainda será necessária;
- não substitua `DELETE` por `TRUNCATE` se for preciso remover apenas parte das linhas;
- lembre-se de que, em alguns SGBDs, `TRUNCATE` não pode ser executado se a tabela for referenciada por chaves estrangeiras;
- tenha em mente que o comportamento de `TRUNCATE` e a possibilidade de rollback dependem do SGBD específico.

O uso incorreto dessas instruções pode levar à perda de dados ou da estrutura da tabela.

---

## Exemplo prático

Imagine que temos uma tabela auxiliar chamada `daily_import`, na qual dados intermediários de um sistema externo são carregados todos os dias.

Se a tabela é usada regularmente, mas precisa ser completamente esvaziada antes de cada nova carga, `TRUNCATE` é uma boa escolha:

```sql
TRUNCATE TABLE daily_import;
```

Depois disso, a estrutura da tabela permanece e novos dados podem ser carregados nela novamente.

Se a tabela foi criada apenas para uma tarefa pontual e não será mais necessária, ela pode ser removida completamente:

```sql
DROP TABLE daily_import;
```

No primeiro caso, preparamos a tabela existente para reutilização. No segundo, removemos completamente do banco de dados um objeto que não é mais necessário.

---

**Principais conclusões desta lição:**

*   `TRUNCATE` remove todas as linhas de uma tabela, mas mantém sua estrutura.
*   `DROP TABLE` remove tanto os dados quanto a própria tabela.
*   `TRUNCATE` e `DELETE` resolvem problemas parecidos, mas funcionam de forma diferente.
*   Antes de usar essas instruções, é importante entender se você precisa limpar uma tabela ou removê-la por completo.
*   O comportamento de `TRUNCATE` e `DROP TABLE` pode variar um pouco entre diferentes SGBDs.

Na próxima lição, veremos as tabelas temporárias e entenderemos em quais casos elas são úteis para resultados intermediários.
