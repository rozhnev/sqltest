# Resumo da Aula de SQL: Funções Comuns de Data e Hora

O SQL fornece várias funções internas para trabalhar com datas e horários. Essas funções ajudam a extrair, manipular e formatar valores de data/hora em suas consultas. Aqui está um resumo das funções de data e hora mais comuns no SQL.

---

## 1. **CURRENT_DATE**
   - **Descrição**: Retorna a data atual (sem o horário) no formato `YYYY-MM-DD`.
   - **Exemplo**:
     ```sql
     SELECT CURRENT_DATE;
     ```
   - **Resultado**: `2025-04-20` (exemplo)

## 2. **CURRENT_TIME**
   - **Descrição**: Retorna a hora atual (sem a data) no formato `HH:MM:SS`.
   - **Exemplo**:
     ```sql
     SELECT CURRENT_TIME;
     ```
   - **Resultado**: `15:30:45` (exemplo)

## 3. **CURRENT_TIMESTAMP**
   - **Descrição**: Retorna a data e a hora atuais (parte da data e parte da hora) no formato `YYYY-MM-DD HH:MM:SS`.
   - **Exemplo**:
     ```sql
     SELECT CURRENT_TIMESTAMP;
     ```
   - **Resultado**: `2025-04-20 15:30:45` (exemplo)

## 4. **NOW()**
   - **Descrição**: Retorna a data e hora atuais, equivalente a `CURRENT_TIMESTAMP`.
   - **Exemplo**:
     ```sql
     SELECT NOW();
     ```
   - **Resultado**: `2025-04-20 15:30:45` (exemplo)

## 5. **DATE()**
   - **Descrição**: Extrai a parte da data de um valor de data ou data e hora.
   - **Exemplo**:
     ```sql
     SELECT DATE('2025-04-20 15:30:45');
     ```
   - **Resultado**: `2025-04-20`

## 6. **TIME()**
   - **Descrição**: Extrai a parte da hora de um valor de data ou data e hora.
   - **Exemplo**:
     ```sql
     SELECT TIME('2025-04-20 15:30:45');
     ```
   - **Resultado**: `15:30:45`

## 7. **YEAR()**
   - **Descrição**: Extrai o ano de um valor de data ou data e hora.
   - **Exemplo**:
     ```sql
     SELECT YEAR('2025-04-20');
     ```
   - **Resultado**: `2025`

## 8. **MONTH()**
   - **Descrição**: Extrai o mês de um valor de data ou data e hora.
   - **Exemplo**:
     ```sql
     SELECT MONTH('2025-04-20');
     ```
   - **Resultado**: `4` (para abril)

## 9. **DAY()**
   - **Descrição**: Extrai o dia do mês de um valor de data ou data e hora.
   - **Exemplo**:
     ```sql
     SELECT DAY('2025-04-20');
     ```
   - **Resultado**: `20`

## 10. **DATE_ADD()**
   - **Descrição**: Adiciona um intervalo de tempo especificado a uma data.
   - **Exemplo**:
     ```sql
     SELECT DATE_ADD('2025-04-20', INTERVAL 5 DAY);
     ```
   - **Resultado**: `2025-04-25`

## 11. **DATE_SUB()**
   - **Descrição**: Subtrai um intervalo de tempo especificado de uma data.
   - **Exemplo**:
     ```sql
     SELECT DATE_SUB('2025-04-20', INTERVAL 5 DAY);
     ```
   - **Resultado**: `2025-04-15`

## 12. **DATEDIFF()**
   - **Descrição**: Retorna o número de dias entre duas datas.
   - **Exemplo**:
     ```sql
     SELECT DATEDIFF('2025-04-20', '2025-04-15');
     ```
   - **Resultado**: `5`

## 13. **DATE_FORMAT()**
   - **Descrição**: Formata um valor de data ou data e hora de acordo com um formato específico.
   - **Exemplo**:
     ```sql
     SELECT DATE_FORMAT('2025-04-20', '%Y-%m-%d');
     ```
   - **Resultado**: `2025-04-20`

   **Especificadores de formato comuns**:
   - `%Y`: Ano (quatro dígitos)
   - `%m`: Mês (dois dígitos)
   - `%d`: Dia do mês (dois dígitos)
   - `%H`: Hora (formato de 24 horas)
   - `%i`: Minutos
   - `%s`: Segundos

## 14. **STRFTIME()** (SQLite e PostgreSQL)
   - **Descrição**: Semelhante ao `DATE_FORMAT()`, ela formata valores de data/hora de acordo com um formato específico.
   - **Exemplo**:
     ```sql
     SELECT STRFTIME('%Y-%m-%d', '2025-04-20');
     ```
   - **Resultado**: `2025-04-20`

## 15. **TIMESTAMPDIFF()**
   - **Descrição**: Retorna a diferença entre dois valores de data/hora, medida em uma unidade especificada (por exemplo, segundos, minutos, dias).
   - **Exemplo**:
     ```sql
     SELECT TIMESTAMPDIFF(DAY, '2025-04-15', '2025-04-20');
     ```
   - **Resultado**: `5`

## 16. **EXTRACT()**
   - **Descrição**: Extrai uma parte de um valor de data ou hora (como ano, mês, dia, hora, etc.).
   - **Exemplo**:
     ```sql
     SELECT EXTRACT(YEAR FROM '2025-04-20');
     ```
   - **Resultado**: `2025`

---

### Exemplos Práticos de Uso

1. **Encontrar usuários que se registraram nos últimos 30 dias**:
   ```sql
   SELECT * 
   FROM users 
   WHERE registration_date > DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
