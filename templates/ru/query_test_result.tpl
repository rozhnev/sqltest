{if $QueryTestResult.ok}
    <div style="font-size: larger; margin-bottom: 10px;">Отлично! Вы справились с задачей!</div>
    <div style="display: flex;
    flex-flow: row;
    flex-wrap: wrap;
    line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            Стоимость выполнения вашего запроса — {$QueryTestResult.cost} <span style="font-size: small;">(чем ниже тем эффективней запрос)</span>.
            {if $QueryBestCost}
                <br>Стоимость лучшего решения — {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Поздравляем! Ваш вариант запроса в числе лучших на нашем сайте!
                {elseif $QueryBestCost > $QueryTestResult.cost} Поздравляем вам удалось улучшить наш рекорд!
                {else} К сожалению, ваш результат немного недотягивает до рекорда. Вам есть над чем поработать! {/if}
            {/if}
            </div>
        {/if}
        {if $User->logged()}
            <div>
                <button class="button green" onClick="showOthersSolutions({$QuestionID})">Покажите мне другие решения!</button>
            </div>
        {/if}
    </div>
    {if !$User->logged()}
        <p class="question-action">
            Для сохранения вашего прогресса и возможности увидеть другие варианты решения выполните <a href="" onClick="toggleLoginWindow(); return false;">вход на сайт</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div style="min-width:280px; flex: 2 1;">Прежде чем двигаться дальше, пожалуйста оцените сложность этого задания:</div>
            <div class="buttons">
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 1)"><span class="question-level rate1"></span>&nbsp;Легко</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 2)"><span class="question-level rate2"></span>&nbsp;Просто</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 3)"><span class="question-level rate3"></span>&nbsp;Нормально</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 4)"><span class="question-level rate4"></span>&nbsp;Сложно</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 5)"><span class="question-level rate5"></span>&nbsp;Очень сложно</button>
            </div>
        </div>
    {/if}
    {if isset($ReferralLink)}
        <div class="referral-link" style="margin-top: 1em;">
            {$ReferralLink}
        </div>
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
    {if isset($ReferralLink)}
        <div class="referral-link" style="margin-top: 5em;">
            {$ReferralLink}
        </div>
    {/if}
{/if}