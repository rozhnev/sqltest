{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['Отлично! Вы выполнили задание!', 'Чтобы сохранить свой прогресс, пожалуйста, <a href="" onClick="toggleLoginWindow(); return false;">войдите на сайт</a>.'],
        ['Круто! Вы сделали это!', 'Чтобы сохранить свой прогресс, <a href="" onClick="toggleLoginWindow(); return false;">войдите на сайт сейчас</a>.'],
        ['Вы справились! Молодец!', 'Чтобы убедиться, что ваша работа сохранена, <a href="" onClick="toggleLoginWindow(); return false;">войдите на сайт</a>.'],
        ['Поздравляем с завершением задания!', '<a href="" onClick="toggleLoginWindow(); return false;">Войдите на сайт</a> сейчас, чтобы сохранить свой прогресс.'],
        ['Вы круты! Вы все сделали!', 'Не забудьте <a href="" onClick="toggleLoginWindow(); return false;">войти на сайт</a>, чтобы сохранить свой прогресс в безопасности. 😎']
    ]}
    <p style="font-size: x-large;">{$phrases[$phrase_id][0]}</p>
    {if !$User->logged()}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <div class="question-rate-panel">
            <div style="min-width:280px; flex: 2 1; margin-bottom: 9px 0;">Прежде чем двигаться дальше, пожалуйста оцените сложность этого задания:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Совсем легко" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Совсем легко</label>
                <input type="radio" id="rate2" name="question_rate" value="Просто" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Просто</label>
                <input type="radio" id="rate3" name="question_rate" value="Средне" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Средне</label>
                <input type="radio" id="rate4" name="question_rate" value="Сложно" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Сложно</label>
                <input type="radio" id="rate5" name="question_rate" value="Очень сложно" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Очень сложно</label>
            </div>
        </div>
    {/if}
{else}
    {assign var="phrases" value=[
        ['К сожалению не верно. Стоит подумать и попробовать еще раз.'],
        ['Ошиблись - не сдавайтесь! Попробуйте другой вариант.'],
        ['Давайте попробуем другой подход.'],
        ['Близко, но к сожалению, не то. Попробуйте еще раз!'],
        ['Попробуте еще раз. Вы почти решили это!']
    ]}
    {$phrases[$phrase_id][0]}
    <p>Ошибка в задании? <a target="_blank" href="https://telegram.me/sqlize">Сообщите! Мы всё исправим 😊</a></p>
{/if}
{if isset($ReferralLink)}
    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
        <div class="referral-link">
            {$ReferralLink.content}
        </div>
    </a>
{/if}