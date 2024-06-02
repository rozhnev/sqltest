{if $AnswerResult.ok}
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
    Это не совсем так. Давай еще раз попробуем.
    <p>Ошибка в задании? <a target="_blank" href="https://t.me/sqlize">Сообщите! Мы всё исправим :)</a></p>
{/if}
