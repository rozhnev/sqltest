{if $QueryTestResult.ok}
    {assign var="successVariants" value=[
        "Отлично! Вы справились с задачей!",
        "Поздравляем! Задание выполнено успешно!",
        "Превосходно! Ваш запрос дал верный результат!",
        "Здорово! Вы решили задачу правильно!",
        "Молодец! Ваше решение верно!"
    ]}
    {assign var="successIndex" value=$successVariants|@array_rand}
    <div class="query-success-title">
        {$successVariants[$successIndex]}
    </div>
    <div class="query-success-body">
        {if $QueryTestResult.cost > 0}
            <div class="query-cost">
                Стоимость выполнения вашего запроса: <span class="query-cost-value{if $QueryBestCost < $QueryTestResult.cost} worse{/if}">{$QueryTestResult.cost}</span> <span class="query-cost-hint">(чем ниже тем эффективней запрос)</span>.
                {if $QueryBestCost}
                    <br>Стоимость лучшего решения: <span class="query-cost-value">{$QueryBestCost}</span>
                    {if $QueryBestCost == $QueryTestResult.cost} 
                        <p class="query-cost-note">
                            <i class="icon icon-flame" aria-hidden="true"></i>
                            Поздравляем! Ваш вариант запроса в числе лучших на нашем сайте!
                        </p>
                    {elseif $QueryBestCost > $QueryTestResult.cost} 
                        <p class="query-cost-note">
                            <i class="icon icon-flame" aria-hidden="true"></i>
                            Поздравляем, вам удалось улучшить наш рекорд!
                        </p>
                    {else}
                        <p class="query-cost-note worse">
                            К сожалению, ваш результат немного недотягивает до рекорда. Вам есть над чем поработать! {/if}
                        </p>
                {/if}
            </div>
        {/if}
        <div>
            <button class="button green" onClick="showOthersSolutions({$QuestionID})">Покажите мне другие решения!</button>
        </div>
    </div>
    {if !$User->logged()}
        <p class="question-action">
            Для сохранения вашего прогресса и возможности увидеть другие варианты решения выполните <a href="" onClick="toggleLoginWindow(); return false;">вход на сайт</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div class="question-rate-panel__title">Прежде чем двигаться дальше, пожалуйста, оцените сложность этого задания:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Совсем легко" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Совсем легко</label>
                <input type="radio" id="rate2" name="question_rate" value="Просто" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Просто</label>
                <input type="radio" id="rate3" name="question_rate" value="Средне" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Средне</label>
                <input type="radio" id="rate4" name="question_rate" value="Сложно" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Сложно</label>
                <input type="radio" id="rate5" name="question_rate" value="Очень сложно" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Очень сложно</label>
            </div>
        </div>
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
                Если sqltest.online помогает вам изучать SQL, расскажите о проекте в VK — так другие студенты тоже быстрее найдут удобную площадку для тренировки.
            </div>
            <a class="button" target="_blank" rel="noopener noreferrer" href="https://vk.com/share.php?url=https%3A%2F%2Fsqltest.online%2Fru%2F" style="margin-top: 0.75rem; display: inline-flex; align-items: center; gap: 8px; background: #0077FF; border-color: #0077FF; color: #fff !important;">
                <span style="display: inline-flex; align-items: center; gap: 6px;">
                    <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true" focusable="false" fill="currentColor"><path d="M12.06 2C6.53 2 2 6.53 2 12.06c0 5.52 4.53 10.06 10.06 10.06 5.52 0 10.06-4.54 10.06-10.06C22.12 6.53 17.58 2 12.06 2Zm4.76 14.34h-1.84c-.56 0-.74-.45-1.76-1.47-.89-.84-1.28-1.03-1.5-1.03-.31 0-.4.08-.4.5v1.34c0 .36-.12.58-1.08.58-1.58 0-3.33-.96-4.56-2.74-.92-1.26-1.61-2.92-1.61-3.27 0-.2.07-.39.45-.39h1.84c.34 0 .47.15.6.48.66 1.66 1.76 3.12 2.2 3.12.17 0 .25-.08.25-.55v-2.28c-.06-1-.58-1.08-.58-1.43 0-.18.14-.36.36-.36h2.9c.28 0 .38.15.38.53v3.1c0 .34.15.46.24.46.17 0 .33-.12.66-.45 1.03-1.15 1.76-2.9 1.76-2.9.1-.23.24-.44.58-.44h1.84c.56 0 .68.29.56.68-.2.92-2.16 3.67-2.16 3.67-.17.27-.23.4 0 .69.17.23.71.69 1.06 1.06.64.64 1.13 1.19 1.27 1.57.14.39-.08.59-.63.59Z"/></svg>
                    <span>Поделиться ссылкой с друзьями</span>
                </span>
            </a>
        </div>
    {/if}
{else}
    К сожалению неверно. 
    {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>
                Результат запроса корректен, однако сам запрос не соответствует требованиям задачи{if array_key_exists('wrongQueryHints', $QueryTestResult.hints)}:
                    <ul>
                    {foreach from=$QueryTestResult.hints.wrongQueryHints item=wrongQueryHint}
                        <li>{$wrongQueryHint}</li>
                    {/foreach}
                    </ul>
                {else}.
                {/if}
                <button type="button" class="text-button blue" onclick="getHelp('{$Lang}', {$QuestionID})">
                    <i class="icon icon-hint" aria-hidden="true"></i>
                    Воспользуйтесь подсказкой и попробуйте переписать его.
                </button>
            </p>
        {/if}
        {if array_key_exists('multipleResults', $QueryTestResult.hints) }
            <p>Подсказка: Возвращено несколько наборов результатов. Ожидается только один набор результатов.</p>
        {/if}
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Запрос вернул ошибку: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
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
            <p>Подсказка: строка {$QueryTestResult.hints.rowsData.rowNumber} вашего результата отличается от ожидаемой:</p>
            {include file='row_diff.tpl' RowDiff=$QueryTestResult.hints.rowsData}
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Подсказка: ваш запрос пуст.</p>
        {/if}
    {/if}
    {include file='expected_sample_link.tpl'}
    <div style="display: flex; flex-direction: column; align-items: flex-start; margin-top: 10px;">
        Попробуйте ещё раз.<br>
        <p style="display: flex; margin-top: 2em; column-gap: 6px; font-style: italic;">
            Нашли ошибку в задании?&nbsp;
            <a style="display: flex; column-gap: 6px; justify-content: center; align-items: center;" target="_blank" href="https://telegram.me/sqltest_online" class="">
                <span class="tg-icon">
                    <span class=""> </span>
                </span>
                сообщите!
            </a>
        </p>
    </div>
    {* {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if} *}
{/if}
