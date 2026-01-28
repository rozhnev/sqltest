{if $QueryTestResult.ok}
    <div style="font-size: larger; margin-bottom: 10px;">Отлично! Вы выполнили задание!</div>
    <div style="display: flex; flex-flow: row; flex-wrap: wrap; line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            Стоимость выполнения вашего запроса составляет {$QueryTestResult.cost} <span style="font-size: small;">(чем ниже стоимость, тем эффективнее запрос)</span>
            {if $QueryBestCost}
                <br>Стоимость лучшего решения: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Поздравляем! Ваш запрос входит в число лучших на нашем сайте!
                {elseif $QueryBestCost > $QueryTestResult.cost} Поздравляем с обновлением рекорда!
                {else} К сожалению, ваш результат немного ниже рекорда. Есть над чем поработать! {/if}
            {/if}
            </div>
        {/if}
    </div>
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('maxAttemptsReached', $QueryTestResult.hints)}
    {assign var="NextQuestion" value="{$QueryTestResult.nextQuestion}"}
    {translate}maximum_attempts_reached{/translate}{if $QueryTestResult.nextQuestion} {translate}go_to_next_task{/translate}{/if}
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('timeOut', $QueryTestResult.hints)}
    {translate}test_time_out{/translate} {translate}go_to_rate{/translate}
{else}
     К сожалению, неверно.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Подсказка: запрос возвращает ошибку: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>Подсказка: результирующая таблица должна содержать {$QueryTestResult.hints.columnsCount} столбцов.</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>Подсказка: результирующая таблица должна состоять из следующих столбцов: {$QueryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>Подсказка: результирующая таблица должна содержать {$QueryTestResult.hints.rowsCount} строк.</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>Подсказка: строка №{$QueryTestResult.hints.rowsData.rowNumber} должна содержать значения:
                {$QueryTestResult.hints.rowsData.rowTable}
            </p>
            <p>ваш результат:
                {$QueryTestResult.hints.rowsData.resultTable}
            </p>
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Подсказка: ваш запрос пуст.</p>
        {/if}
     {/if}
    Попробуйте снова.
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{/if}
