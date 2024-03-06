{* {var_dump($QeryTestResult)} *}
{if $QeryTestResult.ok}
    <b>Отлично! Вы справились с задачей!</b>
    {if !$Logged}
        <p class="question-action">
            Для сохранения вашего прогресса выполните <a href="" onClick="toggleLoginWindow(); return false;">вход на сайт</a>
        </p>
    {else}
        <p class="question-action">
        Прежде чем приступить к следующему тесту, пожалуйста оцените сложность этого задания:
        <select onchange="rateQuestion({$QuestionID}, this.value)">
            <option value="0" disabled selected>---</option>
            <option value="1">Слишком просто</option>
            <option value="2">Просто</option>
            <option value="3">Нормально</option>
            <option value="4">Сложно</option>
            <option value="5">Очень сложно</option>
        </select>
        </p>
    {/if}
{else}
    К сожалению неверно. 
    {if array_key_exists('hints', $QeryTestResult) }
        {if array_key_exists('queryError', $QeryTestResult.hints) }
            <p>Подсказка: запрос вернул ошибку: <span class="sql_error">{$QeryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QeryTestResult.hints) }
            <p>Подсказка: результирующая таблица должна состоять из {$QeryTestResult.hints.columnsCount} колонок.</p>
        {/if}
        {if array_key_exists('columnsList', $QeryTestResult.hints) }
            <p>Подсказка: результирующая таблица должна состоять из следующих колонок: {$QeryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QeryTestResult.hints) }
            <p>Подсказка: результат должен содержать {$QeryTestResult.hints.rowsCount} строк.</p>
        {/if}
        {if array_key_exists('rowsData', $QeryTestResult.hints) }
            <p>Подсказка: строка номер {$QeryTestResult.hints.rowsData.rowNumber} таблицы результатов должна содержать следующие значения: {$QeryTestResult.hints.rowsData.rowData}.</p>
        {/if}
        {if array_key_exists('emptyQuery', $QeryTestResult.hints) }
            <p>Подсказка: ваш запрос пуст.</p>
        {/if}
        {if array_key_exists('wrongQuery', $QeryTestResult.hints) }
            <p>Подсказка: ваш запрос не соответствует требованиям описанным в задаче. Попробуйте переписать его.</p>
        {/if}
    {/if}
   Попробуйте ещё раз. Нашли ошибку в задании - <a target="_blank" href="https://t.me/sqlize">сообщите!</a>
{/if}
