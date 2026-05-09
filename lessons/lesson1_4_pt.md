---
title: "Tipos de Dados SQL Explicados: INTEGER, VARCHAR, DATE e Mais"
description: "Os tipos de dados SQL definem quais valores uma coluna pode guardar. Aprenda tipos numéricos, texto, data/hora e regras práticas para escolher corretamente."
keywords: ["tipos de dados SQL", "INTEGER VARCHAR DECIMAL", "tipos de data SQL", "CHAR vs VARCHAR", "escolher tipo de dados SQL", "tipos de coluna SQL"]
teaches: ["Quais são os tipos numéricos em SQL e quando usar INTEGER, DECIMAL e FLOAT", "A diferença entre CHAR, VARCHAR e TEXT", "O que armazenam DATE, TIME e TIMESTAMP", "Quando usar BOOLEAN, BLOB e JSON", "Como escolher o tipo de dados certo para cada coluna"]
about: ["Tipos de dados SQL", "INTEGER", "VARCHAR", "DECIMAL", "DATE", "TIMESTAMP", "BOOLEAN"]
---

_Lição 1.4 · Tempo de leitura: ~8 min_

Os tipos de dados definem que tipo de valor cada coluna pode armazenar numa base de dados relacional. Nesta lição, vai aprender os tipos SQL mais comuns, quando usar cada um e como escolhas corretas melhoram a qualidade dos dados, o armazenamento e o desempenho das consultas.

# Tipos de Dados SQL Explicados: INTEGER, VARCHAR, DATE e Mais

Na lição anterior, vimos tabelas, chaves, restrições e ACID. Agora vamos para uma decisão prática de modelação: escolher o tipo de dados certo para cada coluna.

<img src="/images/lessons/lesson1_3-datatypes.jpg" alt="Comparação entre tipos SQL numéricos, de texto e de data/hora para definir colunas de tabelas" width="100%">

Antes de entrar nos subtipos, veja os principais grupos de tipos de dados em SQL:

* **Tipos numéricos**: `TINYINT`, `INT`, `BIGINT`, `DECIMAL`, `FLOAT`
* **Tipos de texto**: `CHAR`, `VARCHAR`, `TEXT`
* **Tipos de data e hora**: `DATE`, `TIME`, `DATETIME`, `TIMESTAMP`
* **Tipos especializados**: `BOOLEAN`, `BLOB`, `JSON`

## Quais são os tipos numéricos em SQL?

Os tipos numéricos armazenam números, mas cada grupo resolve um problema diferente:

* inteiros para valores sem casas decimais,
* decimais exatos para finanças,
* ponto flutuante para cálculos aproximados.

### Família INTEGER

Tipos inteiros armazenam apenas números sem parte decimal.

| Tipo | Tamanho típico | Intervalo assinado aproximado |
| :--- | :------------- | :---------------------------- |
| `TINYINT` | 1 byte | -128 a 127 |
| `SMALLINT` | 2 bytes | -32.768 a 32.767 |
| `INTEGER` / `INT` | 4 bytes | -2.147.483.648 a 2.147.483.647 |
| `BIGINT` | 8 bytes | -9.223.372.036.854.775.808 a 9.223.372.036.854.775.807 |

Os limites exatos podem variar consoante o SGBD e o suporte a signed/unsigned.

### DECIMAL / NUMERIC

`DECIMAL` guarda valores exatos com precisão fixa.

* `DECIMAL(p, s)` significa:
  * `p` = total de dígitos,
  * `s` = dígitos após a vírgula.
* Exemplo: `DECIMAL(10, 2)` permite valores até 99.999.999,99.
* É o tipo recomendado para preços, impostos, saldos e faturação.

### FLOAT / REAL / DOUBLE

Tipos de ponto flutuante armazenam valores aproximados.

* Úteis em cálculos científicos e medições.
* Não são ideais para dinheiro devido a possíveis diferenças de arredondamento.
* `DOUBLE` costuma oferecer mais precisão que `FLOAT`.

## Quais são os tipos de texto em SQL?

Os tipos de texto diferem principalmente no comportamento de comprimento e armazenamento.

### CHAR

* Cadeia de comprimento fixo.
* `CHAR(10)` reserva sempre 10 caracteres.
* Se o valor for menor, muitos SGBDs completam com espaços.
* Bom para códigos de tamanho fixo.

### VARCHAR

* Cadeia de comprimento variável com limite máximo.
* `VARCHAR(255)` armazena apenas os caracteres necessários.
* Boa escolha padrão para nomes, emails e títulos.

### TEXT

* Texto longo de comprimento variável.
* Indicado para descrições extensas, comentários e conteúdo editorial.
* Regras de indexação podem mudar conforme o SGBD.

## Quais são os tipos de data e hora?

Tipos temporais devem ser usados sempre que a coluna representa data, hora ou instante de evento.

### DATE

Armazena apenas a data (ano, mês e dia).

### TIME

Armazena apenas a hora (hora, minuto e segundo).

### DATETIME / TIMESTAMP

Armazena data e hora em conjunto.

Dependendo do SGBD, `TIMESTAMP` pode ter comportamento relacionado com fuso horário, enquanto `DATETIME` costuma ser neutro. Confirme esse detalhe antes de modelar tabelas de auditoria e eventos.

## Que outros tipos de dados convém conhecer?

Muitas bases relacionais também oferecem tipos especializados:

* `BOOLEAN`: valores verdadeiro/falso.
* `BLOB`: dados binários, como imagens e ficheiros.
* `JSON`: documentos JSON semiestruturados.

## Como escolher o tipo de dados certo?

Checklist prático:

* Escolha o menor tipo que cubra com segurança os valores esperados.
* Use `DECIMAL` para finanças e evite `FLOAT` para dinheiro.
* Prefira `VARCHAR` para texto variável; use `CHAR` apenas para formatos fixos.
* Use tipos temporais próprios em vez de texto para datas e horas.
* Verifique detalhes do seu SGBD: timezone, defaults, indexação e suporte a JSON.

Escolher bem os tipos na modelação inicial reduz migrações futuras, erros de aplicação e regressões de desempenho.

---

**Principais conclusões desta lição:**

* Os tipos de dados definem os valores permitidos numa coluna e impactam diretamente a qualidade dos dados.
* Tipos numéricos servem objetivos diferentes: inteiros, valores exatos e valores aproximados.
* `CHAR`, `VARCHAR` e `TEXT` devem ser escolhidos com base no tamanho esperado e no comportamento de armazenamento.
* Campos temporais devem usar `DATE`, `TIME` e `TIMESTAMP`, não texto simples.
* Escolher bem os tipos desde o início evita erros, retrabalho e problemas de desempenho.

---

## Perguntas Frequentes

### Qual é a diferença entre DECIMAL e FLOAT?
`DECIMAL` guarda valores exatos e é indicado para dinheiro. `FLOAT` guarda valores aproximados e pode introduzir diferenças de arredondamento.

### Devo usar CHAR ou VARCHAR para nomes e emails?
Na maioria dos casos, use `VARCHAR`, porque nomes e emails têm tamanho variável. `CHAR` faz mais sentido para campos de tamanho fixo.

### NULL é um tipo de dados?
Não. `NULL` representa um valor ausente ou desconhecido. É um marcador especial, não um tipo de dados.

## Questões de Entrevista

### Como escolher entre SMALLINT, INTEGER e BIGINT?
A escolha deve considerar o intervalo de valores esperado. Use o menor tipo que cubra esse intervalo sem risco de overflow.

### Porque DECIMAL é preferido para valores monetários?
Porque `DECIMAL` preserva precisão exata e evita erros de arredondamento típicos de tipos de ponto flutuante.

### Que problemas podem surgir ao escolher tipos de dados errados?
Problemas comuns incluem conversões incorretas, ordenação/filtragem erradas, desperdício de armazenamento, consultas mais lentas e lógica de aplicação mais complexa.

→ [Lição 1.5: Entendendo os Valores NULL no SQL](/pt/lesson/getting-started/null-values)