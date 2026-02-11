Aprenda sobre os valores NULL no SQL, entendendo que o NULL representa dados ausentes ou desconhecidos. Esta lição aborda como o NULL difere de zero ou de uma string vazia, a importância dos operadores IS NULL e IS NOT NULL e como o NULL afeta as operações e a lógica do banco de dados.

# Lição 1.4: Entendendo os Valores NULL no SQL

No mundo dos bancos de dados, você encontrará frequentemente situações em que os dados estão ausentes, são desconhecidos ou não se aplicam. O SQL usa um marcador especial chamado **NULL** para representar esses casos. Entender o NULL é fundamental porque ele se comporta de maneira diferente de qualquer outro valor.

## O que é NULL?

**NULL** não é um valor; é um **estado** ou um espaço reservado indicando que um valor de dado *não existe* no banco de dados.

É importante lembrar o que o NULL **NÃO** é:
*   **NULL não é 0:** Zero é um número. NULL é a ausência de um número.
*   **NULL não é uma string vazia (' '):** Uma string vazia é um pedaço de texto com zero caracteres. NULL é a ausência de texto.
*   **NULL não é "falso":** Na lógica SQL, o NULL permanece como "desconhecido".

## Por que usamos NULL?
*   **Informação desconhecida:** Por exemplo, podemos ainda não saber o nome do meio de um cliente.
*   **Não aplicável:** Uma coluna "CNPJ da Empresa" seria NULL para uma pessoa física.
*   **Dados ausentes:** Dados que foram esquecidos durante a entrada.

## Trabalhando com NULL: IS NULL e IS NOT NULL

Como o NULL representa um estado desconhecido, você não pode usar operadores de comparação padrão como `=` ou `<>` com ele. Qualquer comparação com NULL (ex: `valor = NULL`) resultará em "desconhecido", não em "verdadeiro" ou "falso".

Para verificar valores NULL, você deve usar operadores específicos:

### 1. IS NULL
Usado para encontrar registros onde uma coluna não tem valor.
```sql
SELECT *
FROM address
WHERE address2 IS NULL;
```

### 2. IS NOT NULL
Usado para encontrar registros onde uma coluna contém *qualquer* dado.
```sql
SELECT *
FROM address
WHERE address2 IS NOT NULL;
```

## NULL em Cálculos

Uma das coisas mais importantes a lembrar é que o **NULL se propaga**. Se você realizar uma operação matemática com um valor NULL, o resultado será sempre NULL.

*   `10 + NULL = NULL`
*   `5 * NULL = NULL`
*   `'Olá ' + NULL = NULL`

## Principais Conclusões desta Lição

*   **NULL** representa dados ausentes, desconhecidos ou não aplicáveis.
*   É **diferente** de zero, strings vazias ou espaços em branco.
*   Comparações padrão (`=` ou `<>`) **não funcionam** com NULL.
*   Use **IS NULL** e **IS NOT NULL** para filtrar dados ausentes.
*   A maioria das operações matemáticas envolvendo NULL resultará em **NULL**.
