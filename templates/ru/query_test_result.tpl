{assign var=referral_link_id value=0|mt_rand:6}
{assign var="referral_links" value=[
    ['Хочешь освоить SQL с и получить навыки работы со сложными запросами и функциями? <a id="referral-link" target="_blank" href="https://go.redav.online/febbce86d82c0a30?erid=LdtCKgHnn&m=1">Запишись на курс «SQL для анализа данных» от SkillFactory с максимальной скидкой!</a><p style="font-size:xx-small;">Реклама. ООО Скилфэктори, ИНН 9702009530, erid: LdtCKgHnn</p>'],
    ['Хочешь начать карьеру в IT? Бесплатный мини-курс по программированию: <a id="referral-link" target="_blank" href="https://go.redav.online/111a96ed04609360?erid=LdtCKEwqn&m=1">«SQL и Excel для новичков: учимся работать с данными»</a><p style="font-size:xx-small;">Реклама. ЧОУ ЧАСТНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ДОПОЛНИТЕЛЬНОГО ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ОБРАЗОВАТЕЛЬНЫЕ ТЕХНОЛОГИИ СКИЛБОКС (КОРОБКА НАВЫКОВ), ИНН 9704088880, erid: LdtCKEwqn</p>'],
    ['Хочешь знать язык SQL и его расширение PL/SQL? <a id="referral-link" target="_blank" href="https://go.redav.online/0ed3924b563904c0?erid=LdtCKEwqn&m=1">Запишись на курс «SQL-разработчик» от SkillBox  и получи максимальную скидку!</a><p style="font-size:xx-small;">Реклама. ЧОУ ЧАСТНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ДОПОЛНИТЕЛЬНОГО ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ОБРАЗОВАТЕЛЬНЫЕ ТЕХНОЛОГИИ СКИЛБОКС (КОРОБКА НАВЫКОВ), ИНН 9704088880, erid: LdtCKEwqn</p>'],
    ['Хочешь попробовать себя в новой роли? <a id="referral-link" target="_blank" href="	https://go.redav.online/48397ad6e2aa41b0?erid=LdtCKEwqn">Запишись бесплатный мини-курс: «Data Science с нуля»</a><p style="font-size:xx-small;">Реклама. ЧОУ ЧАСТНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ДОПОЛНИТЕЛЬНОГО ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ОБРАЗОВАТЕЛЬНЫЕ ТЕХНОЛОГИИ СКИЛБОКС (КОРОБКА НАВЫКОВ), ИНН 9704088880, erid: LdtCKEwqn</p>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" target="_blank" href="https://go.redav.online/ca966215c62eb060?erid=LdtCKXSTq&m=1">Запишись на курс «SQL с нуля для анализа данных» от Eduson ACADEMY</a> и получи максимальную скидку!<p style="font-size:xx-small;">Реклама. ООО Эдюсон, ИНН 7729779476, erid: LdtCKXSTq</p>'],
    ['Аналитик?! Хочешь освоить SQL и повысить свою ценность? <a id="referral-link" target="_blank" href="https://go.redav.online/e1ad0b14a1ac8c50?erid=LdtCKEwqn&m=1">Запишись на курс «SQL для анализа данных» от SkillBox с максимальной скидкой!</a><p style="font-size:xx-small;">Реклама. ЧОУ ЧАСТНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ДОПОЛНИТЕЛЬНОГО ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ОБРАЗОВАТЕЛЬНЫЕ ТЕХНОЛОГИИ СКИЛБОКС (КОРОБКА НАВЫКОВ), ИНН 9704088880, erid: LdtCKEwqn</p>'],
    ['Разработчик?! Хочешь уметь использовать, проектировать и оптимизировать базы данных? <a id="referral-link" target="_blank" href="https://go.redav.online/9c71a99b3ea3b9f0?erid=LdtCKEwqn&m=1">Запишись на курс «Базы данных для разработчиков» от SkillBox с максимальной скидкой!</a><p style="font-size:xx-small;">Реклама. ЧОУ ЧАСТНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ДОПОЛНИТЕЛЬНОГО ПРОФЕССИОНАЛЬНОГО ОБРАЗОВАНИЯ ОБРАЗОВАТЕЛЬНЫЕ ТЕХНОЛОГИИ СКИЛБОКС (КОРОБКА НАВЫКОВ), ИНН 9704088880, erid: LdtCKEwqn</p>']
]}

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
        {if $Logged}
            <div>
                <button class="button green" onClick="showSolutions({$QuestionID})">Покажите мне другие решения!</button>
            </div>
        {/if}
    </div>
    {if !$Logged}
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
    <div class="referral_link" style="font-size:large; margin-top: 1em; padding: 1em; border: solid 1px; border-radius: 3px;">
        {$referral_links[$referral_link_id][0]}
    </div>
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
    <div class="referral_link" style="font-size:large; margin-top: 5em; padding: 1em; border: solid 1px; border-radius: 3px;">
        {$referral_links[$referral_link_id][0]}
    </div>
{/if}