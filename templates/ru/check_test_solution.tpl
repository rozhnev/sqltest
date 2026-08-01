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
{/if}
{* {if isset($ReferralLink)}
    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
        <div class="referral-link">
            {$ReferralLink.content}
        </div>
    </a>
{/if} *}
{if $User->logged() &&  $User->getAuthProvider() ==='vk'}
    <div style="margin-top: 0.85rem; padding: 0.9rem 1rem; border-radius: 0.85rem; background: rgba(0, 119, 255, 0.08); border: 1px solid rgba(0, 119, 255, 0.18);">
        <div style="font-weight: 600; line-height: 1.5; color: var(--question-text, #f0f6fc);">
            Если sqltest.online помогает вам практиковать SQL, поделитесь им во VK — так другие студенты тоже быстрее найдут удобную площадку для тренировки.
        </div>
        <a class="button" target="_blank" rel="noopener noreferrer" href="https://vk.com/share.php?url=https%3A%2F%2Fsqltest.online%2F" style="margin-top: 0.75rem; display: inline-flex; align-items: center; gap: 8px; background: #0077FF; border-color: #0077FF; color: #fff;">
            <span style="display: inline-flex; align-items: center; gap: 6px;">
                <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true" focusable="false" fill="currentColor"><path d="M12.06 2C6.53 2 2 6.53 2 12.06c0 5.52 4.53 10.06 10.06 10.06 5.52 0 10.06-4.54 10.06-10.06C22.12 6.53 17.58 2 12.06 2Zm4.76 14.34h-1.84c-.56 0-.74-.45-1.76-1.47-.89-.84-1.28-1.03-1.5-1.03-.31 0-.4.08-.4.5v1.34c0 .36-.12.58-1.08.58-1.58 0-3.33-.96-4.56-2.74-.92-1.26-1.61-2.92-1.61-3.27 0-.2.07-.39.45-.39h1.84c.34 0 .47.15.6.48.66 1.66 1.76 3.12 2.2 3.12.17 0 .25-.08.25-.55v-2.28c-.06-1-.58-1.08-.58-1.43 0-.18.14-.36.36-.36h2.9c.28 0 .38.15.38.53v3.1c0 .34.15.46.24.46.17 0 .33-.12.66-.45 1.03-1.15 1.76-2.9 1.76-2.9.1-.23.24-.44.58-.44h1.84c.56 0 .68.29.56.68-.2.92-2.16 3.67-2.16 3.67-.17.27-.23.4 0 .69.17.23.71.69 1.06 1.06.64.64 1.13 1.19 1.27 1.57.14.39-.08.59-.63.59Z"/></svg>
                <span>Поделиться с группой во VK</span>
            </span>
        </a>
    </div>
{/if}