Esta lição aborda a cláusula `ORDER BY` no SQL, usada para ordenar o conjunto de resultados de uma consulta. Você aprenderá como organizar os dados em ordem crescente ou decrescente, ordenar por múltiplas colunas e entender o impacto da ordenação na análise de dados. Dominar a cláusula `ORDER BY` é essencial para apresentar dados em uma sequência lógica e para preparar relatórios onde a ordem dos registros é importante, como produtos mais vendidos ou logs de atividades cronológicos.

# Lição 2.5: Ordenando Resultados

Por padrão, as linhas em uma tabela de banco de dados ou no conjunto de resultados de uma consulta não têm garantia de estar em nenhuma ordem específica. Para organizar as linhas de saída em uma sequência significativa, usamos a cláusula `ORDER BY`.

## A Cláusula ORDER BY

A cláusula `ORDER BY` é adicionada ao final de uma instrução `SELECT` para ordenar o conjunto de resultados com base em uma ou mais colunas.

### Sintaxe

```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
ORDER BY coluna1 [ASC|DESC], coluna2 [ASC|DESC], ...;
```

*   **`coluna1, coluna2, ...`**: As colunas pelas quais você deseja ordenar.
*   **`ASC`**: Ordena os dados em ordem crescente (do menor para o maior, de A a Z). Este é o padrão.
*   **`DESC`**: Ordena os dados em ordem decrescente (do maior para o menor, de Z a A).

## Ordenando por uma Única Coluna

Para ordenar por uma coluna, basta especificar seu nome após a palavra-chave `ORDER BY`.

### Exemplo: Ordenando Atores por Sobrenome
Esta consulta recupera todos os atores e os ordena alfabeticamente pelo sobrenome.

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name;
```

Se você quiser ordená-los em ordem alfabética inversa:

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name DESC;
```

## Ordenando por Múltiplas Colunas

Você pode ordenar por múltiplas colunas listando-as separadas por vírgulas. O banco de dados ordena primeiro pela primeira coluna e, se houver valores duplicados nessa coluna, ordena esses duplicados pela segunda coluna, e assim por diante.

### Exemplo: Ordenando por Sobrenome, depois por Nome
Isso é útil quando vários atores compartilham o mesmo sobrenome.

```sql
SELECT first_name, last_name
FROM actor
ORDER BY last_name, first_name; -- Primeiro por last_name, depois por first_name para empates
```

## Ordenando por Aliases ou Posições de Coluna

Na maioria dos dialetos SQL, você também pode ordenar pelo alias de uma coluna ou por sua posição numérica na lista `SELECT`.

### Exemplo: Ordenando por Alias
```sql
SELECT first_name || ' ' || last_name AS full_name
FROM actor
ORDER BY full_name;
```

### Exemplo: Ordenando por Posição
```sql
-- Ordena pela segunda coluna (last_name)
SELECT first_name, last_name
FROM actor
ORDER BY 2;
```

---

**Principais conclusões desta lição:**

*   Use `ORDER BY` para ordenar as linhas em seu conjunto de resultados.
*   `ASC` (padrão) ordena em ordem crescente; `DESC` ordena em ordem decrescente.
*   Você pode ordenar por múltiplas colunas para refinar ainda mais a ordem.
*   A ordenação também pode ser feita usando aliases de coluna ou posições numéricas.

Na próxima lição, aprenderemos sobre **Funções de Agregação**, que nos permitem realizar cálculos em conjuntos de dados.
