---
title: "CTEs Recursivas SQL: Tutorial de Dados Hierárquicos com Exemplos"
description: "Domine as Expressões de Tabela Comum recursivas SQL para dados hierárquicos. Aprenda sintaxe de CTE recursiva, exemplos com organogramas, lista de materiais e técnicas de travessia de árvore."
keywords: "CTE recursiva SQL, dados hierárquicos SQL, consulta recursiva, WITH RECURSIVE, estrutura de árvore SQL, pai-filho SQL, organograma SQL, tutorial SQL"
lang: "pt"
region: "BR, PT"
---

# Lição 6.5: CTEs Recursivas para Dados Hierárquicos

As CTEs recursivas são uma das funcionalidades mais poderosas do SQL, permitindo trabalhar com dados hierárquicos e estruturas em árvore. Nesta lição, exploraremos como usar Expressões de Tabela Comum recursivas para consultar dados que possuem relações pai-filho, como organogramas, árvores de categorias e listas de materiais.

## O que são CTEs Recursivas?

Uma **CTE Recursiva** é uma Expressão de Tabela Comum que se referencia a si mesma, permitindo percorrer estruturas de dados hierárquicas. Ao contrário das CTEs regulares que executam uma vez, as CTEs recursivas executam iterativamente até que uma condição de terminação seja atendida.

Casos de uso comuns para CTEs recursivas:
- **Hierarquias organizacionais**: Relações empregado-gerente
- **Árvores de categorias**: Categorias de produtos com subcategorias
- **Lista de Materiais (BOM)**: Relações de peças e subpeças
- **Estruturas de sistema de arquivos**: Pastas e subpastas
- **Redes sociais**: Relações de amigo-de-amigo
- **Hierarquias geográficas**: País > Estado > Cidade

## Sintaxe de CTE Recursiva

A sintaxe geral para uma CTE recursiva é:

```sql
WITH RECURSIVE nome_cte AS (
    -- Membro âncora (caso base)
    SELECT ...
    FROM tabela
    WHERE condicao
    
    UNION ALL
    
    -- Membro recursivo (caso recursivo)
    SELECT ...
    FROM tabela
    JOIN nome_cte ON condicao
)
SELECT * FROM nome_cte;
```

**Componentes:**
- **WITH RECURSIVE**: Palavra-chave que introduz uma CTE recursiva
- **Membro âncora**: A consulta inicial que retorna as linhas iniciais (caso base)
- **UNION ALL**: Combina membros âncora e recursivo
- **Membro recursivo**: A consulta que referencia a própria CTE
- **Terminação**: A recursão para quando o membro recursivo não retorna linhas

## Como Funcionam as CTEs Recursivas

O processo de execução:

1. **Executar membro âncora**: Obtém o conjunto inicial de linhas
2. **Executar membro recursivo**: Usa resultados do passo 1
3. **Repetir passo 2**: Usa resultados da iteração anterior
4. **Continuar até**: O membro recursivo não retornar linhas
5. **Retornar todos os resultados**: Resultados combinados de todas as iterações

## Exemplo Básico: Sequência de Números

Vamos começar com um exemplo simples que gera uma sequência de números:

```sql
WITH RECURSIVE sequencia_numeros AS (
    -- Membro âncora: começar com 1
    SELECT 1 AS n
    
    UNION ALL
    
    -- Membro recursivo: adicionar 1 ao valor anterior
    SELECT n + 1
    FROM sequencia_numeros
    WHERE n < 10
)
SELECT n
FROM sequencia_numeros;
```

**Resultado:**
```
n
--
1
2
3
4
5
6
7
8
9
10
```

**Como funciona:**
1. Âncora: Retorna `1`
2. Iteração 1: `1 + 1 = 2`
3. Iteração 2: `2 + 1 = 3`
4. ... continua até `n < 10` ser falso
5. Última iteração: Retorna `10`, mas `10 < 10` é falso, então a recursão para

## Exemplo de Hierarquia de Funcionários

Vamos criar uma tabela representando uma estrutura organizacional:

```sql
-- Tabela de funcionários exemplo
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT,
    title VARCHAR(100)
);

-- Dados exemplo
INSERT INTO employee VALUES
    (1, 'Alice Johnson', NULL, 'CEO'),
    (2, 'Bob Smith', 1, 'VP de Engenharia'),
    (3, 'Carol White', 1, 'VP de Vendas'),
    (4, 'David Brown', 2, 'Gerente de Engenharia'),
    (5, 'Eve Davis', 2, 'Gerente de Engenharia'),
    (6, 'Frank Miller', 3, 'Gerente de Vendas'),
    (7, 'Grace Wilson', 4, 'Desenvolvedor Sênior'),
    (8, 'Henry Moore', 4, 'Desenvolvedor'),
    (9, 'Ivy Taylor', 5, 'Desenvolvedor'),
    (10, 'Jack Anderson', 6, 'Representante de Vendas');
```

### Encontrando Todos os Subordinados

Para encontrar todos os funcionários que se reportam a um gerente específico (direta ou indiretamente):

```sql
WITH RECURSIVE subordinados AS (
    -- Âncora: Começar com o gerente
    SELECT
        employee_id,
        employee_name,
        manager_id,
        title,
        0 AS nivel
    FROM
        employee
    WHERE
        employee_name = 'Bob Smith'
    
    UNION ALL
    
    -- Recursivo: Encontrar subordinados diretos
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.title,
        s.nivel + 1
    FROM
        employee e
    INNER JOIN
        subordinados s ON e.manager_id = s.employee_id
)
SELECT
    employee_id,
    employee_name,
    title,
    nivel
FROM
    subordinados
ORDER BY
    nivel, employee_name;
```

**Resultado:**
```
employee_id | employee_name   | title                  | nivel
------------|-----------------|------------------------|-------
2           | Bob Smith       | VP de Engenharia       | 0
4           | David Brown     | Gerente de Engenharia  | 1
5           | Eve Davis       | Gerente de Engenharia  | 1
7           | Grace Wilson    | Desenvolvedor Sênior   | 2
8           | Henry Moore     | Desenvolvedor          | 2
9           | Ivy Taylor      | Desenvolvedor          | 2
```

### Construindo o Organograma Completo

Para exibir a hierarquia completa desde o CEO:

```sql
WITH RECURSIVE organograma AS (
    -- Âncora: Começar com o CEO (sem gerente)
    SELECT
        employee_id,
        employee_name,
        manager_id,
        title,
        0 AS nivel,
        CAST(employee_name AS VARCHAR(1000)) AS caminho
    FROM
        employee
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    -- Recursivo: Adicionar cada nível
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.title,
        oc.nivel + 1,
        CONCAT(oc.caminho, ' > ', e.employee_name)
    FROM
        employee e
    INNER JOIN
        organograma oc ON e.manager_id = oc.employee_id
)
SELECT
    REPEAT('  ', nivel) || employee_name AS hierarquia,
    title,
    nivel,
    caminho
FROM
    organograma
ORDER BY
    caminho;
```

**Resultado:**
```
hierarquia                     | title                   | nivel | caminho
-------------------------------|-------------------------|-------|----------------------------------
Alice Johnson                  | CEO                     | 0     | Alice Johnson
  Bob Smith                    | VP de Engenharia        | 1     | Alice Johnson > Bob Smith
    David Brown                | Gerente de Engenharia   | 2     | Alice Johnson > Bob Smith > David Brown
      Grace Wilson             | Desenvolvedor Sênior    | 3     | Alice Johnson > Bob Smith > David Brown > Grace Wilson
      Henry Moore              | Desenvolvedor           | 3     | Alice Johnson > Bob Smith > David Brown > Henry Moore
    Eve Davis                  | Gerente de Engenharia   | 2     | Alice Johnson > Bob Smith > Eve Davis
      Ivy Taylor               | Desenvolvedor           | 3     | Alice Johnson > Bob Smith > Eve Davis > Ivy Taylor
  Carol White                  | VP de Vendas            | 1     | Alice Johnson > Carol White
    Frank Miller               | Gerente de Vendas       | 2     | Alice Johnson > Carol White > Frank Miller
      Jack Anderson            | Representante de Vendas | 3     | Alice Johnson > Carol White > Frank Miller > Jack Anderson
```

## Exemplo de Árvore de Categorias

Vamos trabalhar com uma hierarquia de categorias de produtos:

```sql
-- Tabela de categorias exemplo
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    parent_category_id INT
);

-- Dados exemplo
INSERT INTO category VALUES
    (1, 'Eletrônicos', NULL),
    (2, 'Computadores', 1),
    (3, 'Telefones', 1),
    (4, 'Notebooks', 2),
    (5, 'Desktops', 2),
    (6, 'Notebooks Gamer', 4),
    (7, 'Notebooks Profissionais', 4),
    (8, 'Smartphones', 3),
    (9, 'Telefones Básicos', 3);
```

### Encontrando Todas as Subcategorias

Para encontrar todas as subcategorias sob "Computadores":

```sql
WITH RECURSIVE arvore_categorias AS (
    -- Âncora: Começar com Computadores
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS profundidade,
        CAST(category_name AS VARCHAR(1000)) AS caminho
    FROM
        category
    WHERE
        category_name = 'Computadores'
    
    UNION ALL
    
    -- Recursivo: Obter todas as subcategorias
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.profundidade + 1,
        CONCAT(ct.caminho, ' > ', c.category_name)
    FROM
        category c
    INNER JOIN
        arvore_categorias ct ON c.parent_category_id = ct.category_id
)
SELECT
    category_id,
    REPEAT('  ', profundidade) || category_name AS hierarquia_categoria,
    profundidade,
    caminho
FROM
    arvore_categorias
ORDER BY
    caminho;
```

**Resultado:**
```
category_id | hierarquia_categoria         | profundidade | caminho
------------|------------------------------|--------------|--------------------------------------
2           | Computadores                 | 0            | Computadores
4           |   Notebooks                  | 1            | Computadores > Notebooks
6           |     Notebooks Gamer          | 2            | Computadores > Notebooks > Notebooks Gamer
7           |     Notebooks Profissionais  | 2            | Computadores > Notebooks > Notebooks Profissionais
5           |   Desktops                   | 1            | Computadores > Desktops
```

## Encontrando Ancestrais

Para encontrar todas as categorias pai de uma categoria específica:

```sql
WITH RECURSIVE ancestrais_categoria AS (
    -- Âncora: Começar com Notebooks Gamer
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS nivel_acima
    FROM
        category
    WHERE
        category_name = 'Notebooks Gamer'
    
    UNION ALL
    
    -- Recursivo: Obter categorias pai
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ca.nivel_acima + 1
    FROM
        category c
    INNER JOIN
        ancestrais_categoria ca ON c.category_id = ca.parent_category_id
)
SELECT
    category_id,
    category_name,
    nivel_acima
FROM
    ancestrais_categoria
ORDER BY
    nivel_acima;
```

**Resultado:**
```
category_id | category_name    | nivel_acima
------------|------------------|-------------
6           | Notebooks Gamer  | 0
4           | Notebooks        | 1
2           | Computadores     | 2
1           | Eletrônicos      | 3
```

## Exemplo de Lista de Materiais (Bill of Materials)

Um caso de uso clássico para CTEs recursivas é explorar listas de materiais (peças e subpeças):

```sql
-- Tabela de peças exemplo
CREATE TABLE parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100),
    quantity INT
);

-- Tabela de lista de materiais exemplo
CREATE TABLE bom (
    parent_part_id INT,
    child_part_id INT,
    quantity_needed INT,
    PRIMARY KEY (parent_part_id, child_part_id)
);

-- Dados exemplo
INSERT INTO parts VALUES
    (1, 'Bicicleta', 1),
    (2, 'Quadro', 1),
    (3, 'Roda', 2),
    (4, 'Pneu', 1),
    (5, 'Aro', 1),
    (6, 'Raio', 36);

INSERT INTO bom VALUES
    (1, 2, 1),  -- Bicicleta precisa de 1 Quadro
    (1, 3, 2),  -- Bicicleta precisa de 2 Rodas
    (3, 4, 1),  -- Roda precisa de 1 Pneu
    (3, 5, 1),  -- Roda precisa de 1 Aro
    (5, 6, 36); -- Aro precisa de 36 Raios
```

### Calculando o Total de Peças Necessárias

Para encontrar todas as peças necessárias para construir uma bicicleta:

```sql
WITH RECURSIVE explosao_pecas AS (
    -- Âncora: Começar com o produto de nível superior
    SELECT
        p.part_id,
        p.part_name,
        1 AS quantidade,
        0 AS nivel,
        CAST(p.part_name AS VARCHAR(1000)) AS caminho
    FROM
        parts p
    WHERE
        p.part_name = 'Bicicleta'
    
    UNION ALL
    
    -- Recursivo: Explodir a BOM
    SELECT
        p.part_id,
        p.part_name,
        pe.quantidade * b.quantity_needed,
        pe.nivel + 1,
        CONCAT(pe.caminho, ' > ', p.part_name)
    FROM
        explosao_pecas pe
    INNER JOIN
        bom b ON pe.part_id = b.parent_part_id
    INNER JOIN
        parts p ON b.child_part_id = p.part_id
)
SELECT
    part_id,
    REPEAT('  ', nivel) || part_name AS hierarquia_pecas,
    quantidade,
    nivel,
    caminho
FROM
    explosao_pecas
ORDER BY
    caminho;
```

**Resultado:**
```
part_id | hierarquia_pecas | quantidade | nivel | caminho
--------|------------------|------------|-------|------------------------
1       | Bicicleta        | 1          | 0     | Bicicleta
2       |   Quadro         | 1          | 1     | Bicicleta > Quadro
3       |   Roda           | 2          | 1     | Bicicleta > Roda
4       |     Pneu         | 2          | 2     | Bicicleta > Roda > Pneu
5       |     Aro          | 2          | 2     | Bicicleta > Roda > Aro
6       |       Raio       | 72         | 3     | Bicicleta > Roda > Aro > Raio
```

Observe que precisamos de 72 raios no total: 2 rodas × 1 aro por roda × 36 raios por aro = 72 raios.

## Prevenindo Loops Infinitos

CTEs recursivas podem criar loops infinitos se houver referências circulares em seus dados. Aqui estão estratégias para prevenir isso:

### 1. Limitar Profundidade Máxima

```sql
WITH RECURSIVE recursao_limitada AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS profundidade
    FROM
        category
    WHERE
        parent_category_id IS NULL
    
    UNION ALL
    
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        lr.profundidade + 1
    FROM
        category c
    INNER JOIN
        recursao_limitada lr ON c.parent_category_id = lr.category_id
    WHERE
        lr.profundidade < 10  -- Limite máximo de profundidade
)
SELECT * FROM recursao_limitada;
```

### 2. Rastrear Nós Visitados

```sql
WITH RECURSIVE travessia_segura AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        ARRAY[category_id] AS ids_visitados
    FROM
        category
    WHERE
        parent_category_id IS NULL
    
    UNION ALL
    
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        st.ids_visitados || c.category_id
    FROM
        category c
    INNER JOIN
        travessia_segura st ON c.parent_category_id = st.category_id
    WHERE
        NOT (c.category_id = ANY(st.ids_visitados))  -- Prevenir ciclos
)
SELECT * FROM travessia_segura;
```

## Considerações de Performance

### 1. Indexar Colunas Pai-Filho

Sempre indexe as colunas usadas em junções recursivas:

```sql
CREATE INDEX idx_employee_manager ON employee(manager_id);
CREATE INDEX idx_category_parent ON category(parent_category_id);
```

### 2. Limitar Conjuntos de Resultados

Use cláusulas WHERE para limitar o escopo da recursão:

```sql
WITH RECURSIVE subordinados AS (
    SELECT employee_id, employee_name, manager_id, 0 AS nivel
    FROM employee
    WHERE employee_name = 'Bob Smith'
    
    UNION ALL
    
    SELECT e.employee_id, e.employee_name, e.manager_id, s.nivel + 1
    FROM employee e
    INNER JOIN subordinados s ON e.manager_id = s.employee_id
    WHERE s.nivel < 3  -- Apenas 3 níveis de profundidade
)
SELECT * FROM subordinados;
```

### 3. Usar Tipos de Junção Apropriados

- Use `INNER JOIN` quando você quiser apenas linhas correspondentes
- Use `LEFT JOIN` quando você quiser incluir nós folha sem filhos

## Caso de Uso Prático: Sistema de Thread/Comentários

Um padrão comum de aplicação web são comentários aninhados ou threads de fórum:

```sql
CREATE TABLE comments (
    comment_id INT PRIMARY KEY,
    parent_comment_id INT,
    user_name VARCHAR(100),
    comment_text TEXT,
    created_at TIMESTAMP
);

WITH RECURSIVE thread_comentarios AS (
    -- Âncora: Comentários de nível superior
    SELECT
        comment_id,
        parent_comment_id,
        user_name,
        comment_text,
        0 AS profundidade,
        CAST(comment_id AS VARCHAR(1000)) AS caminho_ordenacao
    FROM
        comments
    WHERE
        parent_comment_id IS NULL
    
    UNION ALL
    
    -- Recursivo: Respostas aninhadas
    SELECT
        c.comment_id,
        c.parent_comment_id,
        c.user_name,
        c.comment_text,
        ct.profundidade + 1,
        CONCAT(ct.caminho_ordenacao, '-', LPAD(c.comment_id::TEXT, 10, '0'))
    FROM
        comments c
    INNER JOIN
        thread_comentarios ct ON c.parent_comment_id = ct.comment_id
)
SELECT
    REPEAT('  ', profundidade) || user_name AS usuario_indentado,
    comment_text,
    profundidade
FROM
    thread_comentarios
ORDER BY
    caminho_ordenacao;
```

## Principais Conclusões

- **CTEs recursivas** permitem percorrer dados hierárquicos com relações pai-filho
- A sintaxe **WITH RECURSIVE** inclui um membro âncora e um membro recursivo
- O **membro âncora** define o ponto de partida (caso base)
- O **membro recursivo** referencia a própria CTE e processa cada iteração
- A **terminação** ocorre quando o membro recursivo não retorna linhas
- **Casos de uso comuns**: Organogramas, árvores de categorias, listas de materiais, sistemas de arquivos
- **Rastreamento de nível**: Inclua uma coluna de profundidade/nível para entender a posição hierárquica
- **Construção de caminho**: Concatene caminhos para mostrar a linhagem completa
- **Prevenção de loop infinito**: Use limites de profundidade ou rastreie nós visitados
- **Performance**: Indexe colunas pai e limite a profundidade da recursão quando possível
- **Versátil**: Funciona com qualquer estrutura de tabela autorreferenciada

CTEs recursivas são uma ferramenta essencial para trabalhar com dados estruturados em árvore e hierárquicos em SQL. Elas transformam operações complexas de múltiplas consultas em soluções elegantes de consulta única.

No próximo módulo, exploraremos Funções de Janela para análise avançada de dados.
