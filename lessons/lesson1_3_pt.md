# Lição 1.3: Tipos de Dados Básicos em SQL

Em SQL, os tipos de dados especificam o tipo de dados que podem ser armazenados em uma coluna. Escolher o tipo de dados correto é crucial para a integridade dos dados, eficiência de armazenamento e desempenho da consulta. Esta lição aborda os tipos de dados comuns e seus subtipos usados em bancos de dados SQL, juntamente com seus intervalos de valores.

## Tipos de Dados Numéricos

Os tipos de dados numéricos são usados para armazenar valores numéricos.

### INTEGER
*   Armazena números inteiros.
*   Subtipos:
    *   `INT` ou `INTEGER`: Tipicamente um inteiro de 4 bytes.
    *   `SMALLINT`: Tipicamente um inteiro de 2 bytes.
    *   `BIGINT`: Tipicamente um inteiro de 8 bytes.
    *   `TINYINT`: Tipicamente um inteiro de 1 byte.
*   Intervalos (aproximados, podem variar de acordo com o sistema de banco de dados):
    *   `TINYINT`: -128 a 127 (com sinal) ou 0 a 255 (sem sinal)
    *   `SMALLINT`: -32.768 a 32.767
    *   `INT`: -2.147.483.648 a 2.147.483.647
    *   `BIGINT`: -9.223.372.036.854.775.808 a 9.223.372.036.854.775.807

### DECIMAL / NUMERIC
*   Armazena valores numéricos exatos com uma precisão e escala especificadas.
*   Precisão: O número total de dígitos.
*   Escala: O número de dígitos à direita do ponto decimal.
*   Exemplo: `DECIMAL(10, 2)` pode armazenar números com 10 dígitos totais, 2 dos quais estão após o ponto decimal.
*   Intervalo: Depende da precisão e escala.

### FLOAT / REAL
*   Armazena valores numéricos aproximados com precisão de ponto flutuante.
*   Subtipos:
    *   `FLOAT`: Número de ponto flutuante de precisão simples.
    *   `DOUBLE` / `DOUBLE PRECISION`: Número de ponto flutuante de precisão dupla.
    *   `REAL`: Um sinônimo para `FLOAT` em alguns bancos de dados.
*   Intervalo: Varia dependendo da implementação específica, mas geralmente cobre uma ampla gama de valores com precisão limitada.

## Tipos de Dados de Caractere / String

Os tipos de dados de caractere são usados para armazenar texto.

### CHAR
*   Armazena strings de caracteres de comprimento fixo.
*   Você especifica o comprimento ao definir a coluna.
*   Exemplo: `CHAR(10)` armazena strings de exatamente 10 caracteres.
*   Se a string armazenada for menor que o comprimento especificado, ela será preenchida com espaços.

### VARCHAR
*   Armazena strings de caracteres de comprimento variável.
*   Você especifica o comprimento máximo ao definir a coluna.
*   Exemplo: `VARCHAR(255)` armazena strings de até 255 caracteres.
*   Usa apenas o espaço necessário para armazenar a string real.

### TEXT
*   Armazena strings de caracteres de comprimento variável grandes.
*   Frequentemente usado para armazenar documentos, artigos ou outros dados de texto grandes.
*   O comprimento máximo é normalmente muito maior que `VARCHAR`.

## Tipos de Dados de Data e Hora

Os tipos de dados de data e hora são usados para armazenar valores temporais.

### DATE
*   Armazena uma data (ano, mês, dia).
*   Formato: Varia dependendo do sistema de banco de dados (por exemplo, AAAA-MM-DD, MM/DD/AAAA).

### TIME
*   Armazena uma hora (hora, minuto, segundo).
*   Formato: Varia dependendo do sistema de banco de dados (por exemplo, HH:MM:SS).

### DATETIME / TIMESTAMP
*   Armazena data e hora.
*   Formato: Varia dependendo do sistema de banco de dados (por exemplo, AAAA-MM-DD HH:MM:SS).
*   `TIMESTAMP` geralmente tem um comportamento especial relacionado a fusos horários e atualizações automáticas.

## Tipo de Dados Booleano

### BOOLEAN
*   Armazena valores verdadeiro/falso.
*   Alguns bancos de dados podem representar valores booleanos como inteiros (por exemplo, 0 para falso, 1 para verdadeiro).

## Outros Tipos de Dados

### BLOB (Binary Large Object)
*   Armazena dados binários, como imagens, arquivos de áudio ou vídeo.

### JSON
*   Armazena dados JSON (JavaScript Object Notation).
*   Permite armazenar dados semiestruturados em uma coluna de banco de dados.

## Valores NULL

É importante entender o conceito de `NULL` em SQL. `NULL` representa um valor ausente ou desconhecido. Uma coluna pode ser definida para permitir ou não valores `NULL`. Ao contrário de outros tipos de dados, `NULL` não é um tipo de dados em si, mas sim uma propriedade de uma coluna. É crucial lidar com valores `NULL` corretamente em consultas para evitar resultados inesperados. Comparações com `NULL` devem ser feitas usando `IS NULL` ou `IS NOT NULL`.

## Escolhendo o Tipo de Dados Certo

*   Considere o tipo de dados que você precisa armazenar (numérico, texto, data/hora, etc.).
*   Escolha o menor tipo de dados que possa acomodar o intervalo de valores que você espera.
*   Use `VARCHAR` em vez de `CHAR`, a menos que precise de strings de comprimento fixo.
*   Use `DECIMAL` para valores numéricos exatos, especialmente ao lidar com moeda.
*   Esteja ciente dos tipos de dados específicos e seu comportamento em seu sistema de banco de dados.

Ao entender os tipos de dados disponíveis e suas características, você pode projetar bancos de dados que sejam eficientes, confiáveis e fáceis de manter.

**Principais Conclusões desta Lição:**

*   **Tipos de Dados Importam:** Selecionar o tipo de dados apropriado é crucial para a integridade dos dados, eficiência de armazenamento e desempenho da consulta.
*   **Tipos Numéricos:** `INTEGER`, `DECIMAL` e `FLOAT` são usados para armazenar dados numéricos, cada um com diferentes características em relação à precisão e intervalo.
*   **Tipos de String:** `CHAR`, `VARCHAR` e `TEXT` são usados para armazenar dados de texto, com diferentes restrições de comprimento e implicações de armazenamento.
*   **Tipos de Data/Hora:** `DATE`, `TIME` e `DATETIME` são usados para armazenar dados temporais, com formatos específicos que variam entre os sistemas de banco de dados.
*   **Outros Tipos:** `BOOLEAN`, `BLOB` e `JSON` fornecem suporte para armazenar valores booleanos, dados binários e dados semiestruturados, respectivamente.
*   **Valores NULL:** `NULL` representa um valor ausente ou desconhecido e não é um tipo de dados em si. É crucial lidar com valores `NULL` corretamente em consultas.
*   **Escolhendo Sabiamente:** Considere a natureza dos dados, a precisão necessária e as implicações de armazenamento ao selecionar um tipo de dados para uma coluna.