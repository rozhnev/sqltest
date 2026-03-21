---
title: "Aplicações de CTEs Recursivos em SQL: Dados Hierárquicos, BOM, Organogramas"
description: "Aprenda CTEs recursivos em SQL para resolver problemas práticos. Trabalhe com hierarquias, estruturas de categorias, grafos organizacionais, sistemas de menu e busca de caminhos. Guia completo com exemplos."
keywords: "CTE recursivo, hierarquia SQL, árvore de categorias, BOM, organograma, busca de caminho, estrutura de menu, consulta SQL recursiva, WITH RECURSIVE"
lang: "pt"
region: "PT, BR, AO, MZ, ST, CV, GQ, TL"
---

# Lição 6.6: Aplicações de CTEs Recursivos a Problemas do Mundo Real

Na lição anterior, exploramos CTEs comuns (não-recursivos)—uma ferramenta para organizar e estruturar consultas SQL. Agora passamos para sua variante mais poderosa: **CTEs recursivos**.

CTEs recursivos permitem trabalhar com estruturas de dados hierárquicas, em árvore e em rede. Eles resolvem muitos problemas do mundo real que tradicionalmente exigiam código procedural ou procedimentos armazenados complexos.

<img src="/images/lessons/lesson6_6_recursive-cte.jpg" alt="Recursive CTE" width="100%">

## O que é um CTE Recursivo?

Um **CTE recursivo** é um CTE que se referencia a si mesmo, permitindo percorrer estruturas hierárquicas nível após nível.

A estrutura de um CTE recursivo:

```sql
WITH RECURSIVE nome_cte AS (
    -- MEMBRO ÂNCORA (caso base)
    SELECT ... 
    WHERE condicao_ancora
    
    UNION ALL
    
    -- MEMBRO RECURSIVO (como passar ao próximo nível)
    SELECT ...
    FROM nome_cte
    WHERE condicao_parada
)
SELECT * FROM nome_cte;
```

**Componentes principais:**
1. **Membro âncora** — o ponto de partida da recursão (geralmente registros raiz)
2. **UNION ALL** — combina resultados da âncora e da recursão
3. **Membro recursivo** — como transitar de um nível para outro
4. **Condição de parada** — quando terminar a recursão

## Exemplo 1: Hierarquia de Categorias

Uma das aplicações mais comuns é trabalhar com hierarquias de categorias de produtos no comércio eletrônico.

**Estrutura da tabela:**
```sql
CREATE TABLE categorias (
    category_id INT PRIMARY KEY,
    parent_id INT,
    name VARCHAR(100),
    FOREIGN KEY (parent_id) REFERENCES categorias(category_id)
);

INSERT INTO categorias VALUES
(1, NULL, 'Eletrônicos'),
(2, 1, 'Computadores'),
(3, 1, 'Telefones móveis'),
(4, 2, 'Notebooks'),
(5, 2, 'PCs de desktop'),
(6, 4, 'Notebooks Dell'),
(7, 4, 'Notebooks HP'),
(8, 3, 'Smartphones'),
(9, 3, 'Tablets');
```

**Tarefa: Obter a hierarquia completa de categorias da raiz até as folhas**

```sql
WITH RECURSIVE hierarquia_categorias AS (
    -- Membro âncora: começar com categorias raiz
    SELECT
        category_id,
        parent_id,
        name,
        1 AS nivel,
        name AS caminho_completo
    FROM
        categorias
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    -- Membro recursivo: adicionar categorias filhas
    SELECT
        c.category_id,
        c.parent_id,
        c.name,
        hc.nivel + 1,
        CONCAT(hc.caminho_completo, ' → ', c.name)
    FROM
        categorias c
    JOIN
        hierarquia_categorias hc ON c.parent_id = hc.category_id
)
SELECT
    category_id,
    REPEAT('  ', nivel - 1) AS indentacao,
    name,
    nivel,
    caminho_completo
FROM
    hierarquia_categorias
ORDER BY
    nivel,
    category_id;
```

**Resultado:**
```
category_id | indentacao | name                | nivel | caminho_completo
1           |            | Eletrônicos         | 1     | Eletrônicos
2           |        | Computadores        | 2     | Eletrônicos → Computadores
4           |            | Notebooks           | 3     | Eletrônicos → Computadores → Notebooks
6           |                | Notebooks Dell      | 4     | Eletrônicos → Computadores → Notebooks → Notebooks Dell
7           |                | Notebooks HP        | 4     | Eletrônicos → Computadores → Notebooks → Notebooks HP
5           |            | PCs de desktop      | 3     | Eletrônicos → Computadores → PCs de desktop
3           |        | Telefones móveis    | 2     | Eletrônicos → Telefones móveis
8           |            | Smartphones         | 3     | Eletrônicos → Telefones móveis → Smartphones
9           |            | Tablets             | 3     | Eletrônicos → Telefones móveis → Tablets
```

**O que acontece:**
- O membro âncora encontra apenas `Eletrônicos` (parent_id IS NULL)
- O membro recursivo encontra `Computadores` e `Telefones móveis` (filhas de Eletrônicos)
- O processo se repete até que todas as folhas sejam encontradas

## Exemplo 2: Organograma

Frequentemente, você precisa exibir a estrutura da empresa com uma cadeia de comando.

**Estrutura da tabela:**
```sql
CREATE TABLE funcionarios (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (manager_id) REFERENCES funcionarios(employee_id)
);

INSERT INTO funcionarios VALUES
(1, 'João Silva', 'Diretor Executivo', NULL, 150000),
(2, 'Anna Santos', 'Diretora de Vendas', 1, 100000),
(3, 'Pedro Oliveira', 'Diretor de TI', 1, 120000),
(4, 'Maria Costa', 'Gerente de Vendas', 2, 60000),
(5, 'Alex Martins', 'Gerente de Vendas', 2, 60000),
(6, 'Sergio Pereira', 'Desenvolvedor Senior', 3, 90000),
(7, 'Olga Sousa', 'Desenvolvedora', 6, 70000),
(8, 'Dmitri Ribeiro', 'Desenvolvedor', 6, 70000);
```

**Tarefa: Exibir a estrutura organizacional com cadeia de comando**

```sql
WITH RECURSIVE organograma AS (
    -- Âncora: Diretor Executivo
    SELECT
        employee_id,
        name,
        position,
        manager_id,
        salary,
        1 AS nivel,
        name AS cadeia_comando
    FROM
        funcionarios
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    -- Recursão: adicionar subordinados
    SELECT
        f.employee_id,
        f.name,
        f.position,
        f.manager_id,
        f.salary,
        o.nivel + 1,
        CONCAT(o.cadeia_comando, ' → ', f.name)
    FROM
        funcionarios f
    JOIN
        organograma o ON f.manager_id = o.employee_id
    WHERE
        o.nivel < 10  -- Proteção contra recursão infinita
)
SELECT
    employee_id,
    REPEAT('│ ', nivel - 1) AS hierarquia,
    name,
    position,
    salary,
    cadeia_comando
FROM
    organograma
ORDER BY
    nivel,
    employee_id;
```

**Resultado:**
```
employee_id | hierarquia | name           | position            | salary | cadeia_comando
1           |            | João Silva     | Diretor Executivo   | 150000 | João Silva
2           | │          | Anna Santos    | Diretora de Vendas  | 100000 | João Silva → Anna Santos
4           | │ │        | Maria Costa    | Gerente de Vendas   | 60000  | João Silva → Anna Santos → Maria Costa
5           | │ │        | Alex Martins   | Gerente de Vendas   | 60000  | João Silva → Anna Santos → Alex Martins
3           | │          | Pedro Oliveira | Diretor de TI       | 120000 | João Silva → Pedro Oliveira
6           | │ │        | Sergio Pereira | Desenvolvedor Senior| 90000  | João Silva → Pedro Oliveira → Sergio Pereira
7           | │ │ │      | Olga Sousa     | Desenvolvedora      | 70000  | João Silva → Pedro Oliveira → Sergio Pereira → Olga Sousa
8           | │ │ │      | Dmitri Ribeiro | Desenvolvedor       | 70000  | João Silva → Pedro Oliveira → Sergio Pereira → Dmitri Ribeiro
```

**Aplicação: Calcular orçamento do departamento**

```sql
WITH RECURSIVE organograma AS (
    SELECT
        employee_id,
        name,
        position,
        salary,
        1 AS nivel
    FROM
        funcionarios
    WHERE
        manager_id IS NULL
    
    UNION ALL
    
    SELECT
        f.employee_id,
        f.name,
        f.position,
        f.salary,
        o.nivel + 1
    FROM
        funcionarios f
    JOIN
        organograma o ON f.manager_id = o.employee_id
)
SELECT
    name AS cargo,
    COUNT(*) AS numero_funcionarios,
    SUM(salary) AS salario_total,
    ROUND(AVG(salary), 2) AS salario_medio
FROM
    organograma
GROUP BY
    employee_id,
    name
ORDER BY
    SUM(salary) DESC;
```

## Exemplo 3: Lista de Materiais (Bill of Materials - BOM)

Na fabricação, você precisa saber de quais componentes um produto é feito.

**Estrutura da tabela:**
```sql
CREATE TABLE bom (
    product_id INT,
    component_id INT,
    quantity INT,
    PRIMARY KEY (product_id, component_id)
);

INSERT INTO bom VALUES
(1, 2, 1),      -- Notebook consiste de 1 placa-mãe
(1, 3, 2),      -- e 2 pentes de RAM
(1, 4, 1),      -- e 1 disco rígido
(2, 5, 1),      -- Placa-mãe consiste de 1 chipset
(2, 6, 20),     -- e 20 resistores
(4, 7, 1);      -- Disco rígido consiste de 1 eixo
```

**Tarefa: Expandir BOM para lista completa de componentes**

```sql
WITH RECURSIVE bom_expandido AS (
    -- Âncora: produtos acabados (não utilizados como componentes)
    SELECT
        product_id,
        product_id AS component_id,
        1 AS quantity,
        0 AS nivel,
        CAST(product_id AS CHAR(100)) AS caminho
    FROM
        (SELECT DISTINCT product_id FROM bom
         UNION
         SELECT DISTINCT component_id FROM bom) AS produtos
    
    UNION ALL
    
    -- Recursão: expandir cada componente
    SELECT
        be.product_id,
        b.component_id,
        be.quantity * b.quantity,
        be.nivel + 1,
        CONCAT(be.caminho, ' → ', b.component_id)
    FROM
        bom_expandido be
    JOIN
        bom b ON be.component_id = b.product_id
    WHERE
        be.nivel < 10
)
SELECT
    product_id,
    component_id,
    quantity,
    nivel,
    caminho
FROM
    bom_expandido
WHERE
    nivel > 0
ORDER BY
    product_id,
    nivel,
    component_id;
```

## Exemplo 4: Estrutura de Menu (Árvores de Menu)

Sites de comércio eletrônico e aplicações web frequentemente têm menus multinível.

**Estrutura da tabela:**
```sql
CREATE TABLE menu (
    menu_id INT PRIMARY KEY,
    parent_menu_id INT,
    title VARCHAR(100),
    url VARCHAR(255),
    sort_order INT,
    FOREIGN KEY (parent_menu_id) REFERENCES menu(menu_id)
);

INSERT INTO menu VALUES
(1, NULL, 'Início', '/', 1),
(2, NULL, 'Catálogo', '/catalogo', 2),
(3, NULL, 'Sobre Nós', '/sobre', 3),
(4, 2, 'Computadores', '/catalogo/computadores', 1),
(5, 2, 'Acessórios', '/catalogo/acessorios', 2),
(6, 4, 'Notebooks', '/catalogo/computadores/notebooks', 1),
(7, 4, 'PCs Desktop', '/catalogo/computadores/desktop', 2),
(8, 5, 'Mouses', '/catalogo/acessorios/mouses', 1),
(9, 5, 'Teclados', '/catalogo/acessorios/teclados', 2),
(10, 3, 'Histórico', '/sobre/historico', 1),
(11, 3, 'Equipe', '/sobre/equipe', 2);
```

**Tarefa: Exibir menu como árvore com indentação**

```sql
WITH RECURSIVE arvore_menu AS (
    -- Âncora: itens de menu principal
    SELECT
        menu_id,
        parent_menu_id,
        title,
        url,
        1 AS nivel,
        title AS miolo_pao
    FROM
        menu
    WHERE
        parent_menu_id IS NULL
    ORDER BY
        sort_order
    
    UNION ALL
    
    -- Recursão: submenus
    SELECT
        m.menu_id,
        m.parent_menu_id,
        m.title,
        m.url,
        am.nivel + 1,
        CONCAT(am.miolo_pao, ' > ', m.title)
    FROM
        menu m
    JOIN
        arvore_menu am ON m.parent_menu_id = am.menu_id
)
SELECT
    menu_id,
    REPEAT('  ', nivel - 1) AS indentacao,
    title,
    url,
    miolo_pao
FROM
    arvore_menu
ORDER BY
    nivel,
    menu_id;
```

**Resultado:**
```
menu_id | indentacao | title            | url                          | miolo_pao
1       |            | Início           | /                            | Início
2       |            | Catálogo         | /catalogo                    | Catálogo
4       |        | Computadores     | /catalogo/computadores       | Catálogo > Computadores
6       |            | Notebooks        | /catalogo/computadores/notebooks | Catálogo > Computadores > Notebooks
7       |            | PCs Desktop      | /catalogo/computadores/desktop | Catálogo > Computadores > PCs Desktop
5       |        | Acessórios       | /catalogo/acessorios         | Catálogo > Acessórios
8       |            | Mouses           | /catalogo/acessorios/mouses  | Catálogo > Acessórios > Mouses
9       |            | Teclados         | /catalogo/acessorios/teclados | Catálogo > Acessórios > Teclados
3       |            | Sobre Nós        | /sobre                       | Sobre Nós
10      |        | Histórico        | /sobre/historico             | Sobre Nós > Histórico
11      |        | Equipe           | /sobre/equipe                | Sobre Nós > Equipe
```

## Exemplo 5: Busca de Caminhos em Grafos

CTEs recursivos são usados para encontrar todos os caminhos entre dois nós em um grafo (por exemplo, rotas de entrega em um sistema logístico).

**Estrutura da tabela:**
```sql
CREATE TABLE cidades (
    city_id INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE rotas (
    from_city_id INT,
    to_city_id INT,
    distancia INT,
    PRIMARY KEY (from_city_id, to_city_id),
    FOREIGN KEY (from_city_id) REFERENCES cidades(city_id),
    FOREIGN KEY (to_city_id) REFERENCES cidades(city_id)
);

INSERT INTO cidades VALUES (1, 'São Paulo'), (2, 'Sorocaba'), (3, 'Ribeirão Preto'), (4, 'Campinas');

INSERT INTO rotas VALUES
(1, 2, 110),   -- São Paulo → Sorocaba
(2, 3, 280),   -- Sorocaba → Ribeirão Preto
(1, 4, 100),   -- São Paulo → Campinas
(4, 3, 220);   -- Campinas → Ribeirão Preto
```

**Tarefa: Encontrar todas as rotas de São Paulo para Ribeirão Preto**

```sql
WITH RECURSIVE busca_rotas AS (
    -- Âncora: começar de São Paulo (city_id = 1)
    SELECT
        from_city_id,
        to_city_id,
        distancia,
        1 AS saltos,
        CAST(to_city_id AS CHAR(1000)) AS caminho,
        distancia AS distancia_total
    FROM
        rotas
    WHERE
        from_city_id = 1
    
    UNION ALL
    
    -- Recursão: continuar de cada destino
    SELECT
        br.from_city_id,
        r.to_city_id,
        r.distancia,
        br.saltos + 1,
        CONCAT(br.caminho, ',', r.to_city_id),
        br.distancia_total + r.distancia
    FROM
        busca_rotas br
    JOIN
        rotas r ON br.to_city_id = r.from_city_id
    WHERE
        br.saltos < 10  -- Prevenir ciclos
        AND br.caminho NOT LIKE CONCAT('%,', r.to_city_id, '%')  -- Evitar loops
)
SELECT
    from_city_id,
    to_city_id,
    saltos,
    caminho,
    distancia_total,
    ROUND(distancia_total / saltos, 2) AS distancia_media_entre_cidades
FROM
    busca_rotas
WHERE
    to_city_id = 3  -- Destino: Ribeirão Preto
ORDER BY
    saltos,
    distancia_total;
```

## Melhores Práticas e Otimização

### 1. Sempre Defina uma Condição de Parada

Recursão sem condição de parada resultará em loops infinitos:

```sql
-- ❌ RUIM: Pode resultar em recursão infinita
WITH RECURSIVE ma_recursao AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM ma_recursao
)
SELECT * FROM ma_recursao;

-- ✅ BOM: Condição de parada incluída
WITH RECURSIVE boa_recursao AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM boa_recursao
    WHERE n < 1000
)
SELECT * FROM boa_recursao;
```

### 2. Use UNION ALL Ao Invés de UNION

`UNION ALL` não remove duplicatas e executa mais rápido:

```sql
-- ❌ Mais lento
WITH RECURSIVE cte AS (
    SELECT ...
    UNION  -- Remove duplicatas
    SELECT ...
)

-- ✅ Mais rápido
WITH RECURSIVE cte AS (
    SELECT ...
    UNION ALL  -- Não remove duplicatas
    SELECT ...
)
```

### 3. Evitar Referências Circulares

Use verificação de caminho para prevenir ciclos:

```sql
WITH RECURSIVE recursao_segura AS (
    SELECT
        id,
        parent_id,
        CAST(id AS CHAR(1000)) AS caminho
    FROM
        table_name
    WHERE
        parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        CONCAT(rs.caminho, ',', t.id)
    FROM
        table_name t
    JOIN
        recursao_segura rs ON t.parent_id = rs.id
    WHERE
        rs.caminho NOT LIKE CONCAT('%,', t.id, '%')  -- Verificação de ciclo
        AND rs.caminho NOT LIKE CONCAT(t.id, ',%')
)
SELECT * FROM recursao_segura;
```

### 4. Limitar Profundidade de Recursão

Limitar explicitamente a profundidade máxima:

```sql
WITH RECURSIVE recursao_limitada AS (
    SELECT
        id,
        parent_id,
        0 AS nivel
    FROM table_name
    WHERE parent_id IS NULL
    
    UNION ALL
    
    SELECT
        t.id,
        t.parent_id,
        rl.nivel + 1
    FROM
        table_name t
    JOIN
        recursao_limitada rl ON t.parent_id = rl.id
    WHERE
        rl.nivel < 20  -- Máximo 20 níveis
)
SELECT * FROM recursao_limitada;
```

## Matriz de Aplicação de CTEs Recursivos

| Tarefa | Exemplo | Complexidade |
|--------|---------|-------------|
| Hierarquia de categorias | Categorias de produtos em uma loja | Baixa |
| Organograma | Estrutura da empresa, cadeia de comando | Baixa |
| BOM (Lista de Materiais) | Composição de produtos fabricados | Média |
| Estrutura de menu | Árvores de navegação de sites | Baixa |
| Busca de caminhos | Rotas de entrega, grafos de relacionamento | Alta |
| Árvore de comentários | Comentários aninhados em redes sociais | Média |
| Grafos de dependências | Projetos e subtarefas | Média |
| Rastreabilidade | Rastreamento de origem de material | Média |

## Pontos-Chave para Lembrar

- **CTEs recursivos** são ferramentas poderosas para trabalhar com dados hierárquicos
- **Estrutura**: membro âncora + membro recursivo + condição de parada
- **Membro âncora** define as linhas iniciais
- **Membro recursivo** adiciona novas linhas com base nas anteriores
- **Condição de parada** previne loops infinitos
- **Aplicações práticas**: categorias, estruturas organizacionais, BOMs, menus, busca de caminhos
- **Desempenho**: Quanto mais simples a estrutura, mais rápida a execução
- **Alternativas**: Código procedural pode ser usado, mas CTEs recursivos são frequentemente mais simples e claros

CTEs recursivos transformam consultas hierárquicas complexas de quebra-cabeças em SQL compreensível. Eles são uma ferramenta indispensável para quem trabalha com estruturas de dados em árvore e em rede.

Nas próximas lições, exploraremos técnicas de otimização avançada e funções SQL especializadas.
