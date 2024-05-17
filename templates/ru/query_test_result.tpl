{if $QueryTestResult.ok}
    <b>Отлично! Вы справились с задачей!</b>
    {if $QueryTestResult.cost > 0}
        <p>Стоимость выполнения вашего запроса — {$QueryTestResult.cost} (чем меньше стоимость тем эффективней запрос)</p>
        {if $QueryBestCost}
            Стоимость лучшего решения: {$QueryBestCost}
            {if $QueryBestCost == $QueryTestResult.cost} Поздравляем! Ваш вариант запроса в числе лучших на нашем сайте!
            {elseif $QueryBestCost > $QueryTestResult.cost} Поздравляем вам удалось улучшить наш рекорд!
            {else} К сожалению, ваш результат немного недотягивает до рекорда. Вам есть над чем поработать! {/if}
        {/if}
    {/if}
    {if !$Logged}
        <p class="question-action">
            Для сохранения вашего прогресса и возможности увидеть другие варианты решения выполните <a href="" onClick="toggleLoginWindow(); return false;">вход на сайт</a>
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
        <p class="question-action">
             <button class="button green" onClick="showSolutions({$QuestionID})">Покажите мне другие решения!</button>
        </p>
    {/if}
{else}
    К сожалению неверно. 
    {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Подсказка: запрос вернул ошибку: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>Подсказка: результирующая таблица должна состоять из {$QueryTestResult.hints.columnsCount} колонок.</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>Подсказка: результирующая таблица должна состоять из следующих колонок: {$QueryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>Подсказка: результат должен содержать {$QueryTestResult.hints.rowsCount} строк.</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>Подсказка: строка номер {$QueryTestResult.hints.rowsData.rowNumber} таблицы результатов должна содержать следующие значения: 
                {$QueryTestResult.hints.rowsData.rowTable}
            </p>
            <p>ваш результат:
                {$QueryTestResult.hints.rowsData.resultTable}
            </p>
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Подсказка: ваш запрос пуст.</p>
        {/if}
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>Подсказка: ваш запрос не соответствует требованиям описанным в задаче. <a href="#" onclick="getHelp('ru', {$QuestionID}); return false;">Воспользуйтесь подсказкой</a> и попробуйте переписать его.</p>
        {/if}
    {/if}
   Попробуйте ещё раз. Нашли ошибку в задании - <a target="_blank" href="https://t.me/sqlize">сообщите!</a>
{/if}
