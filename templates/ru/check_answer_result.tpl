{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['Отлично! Вы выполнили задание!', 'Чтобы сохранить свой прогресс, пожалуйста, <a href="" onClick="toggleLoginWindow(); return false;">войдите на сайт</a>.'],
        ['Круто! Вы сделали это!', 'Чтобы сохранить свой прогресс, <a href="" onClick="toggleLoginWindow(); return false;">войдите на сайт сейчас</a>.'],
        ['Вы справились! Молодец!', 'Чтобы убедиться, что ваша работа сохранена, <a href="" onClick="toggleLoginWindow(); return false;">войдите на сайт</a>.'],
        ['Поздравляем с завершением задания!', '<a href="" onClick="toggleLoginWindow(); return false;">Войдите на сайт</a> сейчас, чтобы сохранить свой прогресс.'],
        ['Вы круты! Вы все сделали!', 'Не забудьте <a href="" onClick="toggleLoginWindow(); return false;">войти на сайт</a>, чтобы сохранить свой прогресс в безопасности. 😎']
    ]}
    {$phrases[$phrase_id][0]}
    {if !$Logged}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
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
    {assign var="phrases" value=[
        ['К сожалению не верно. Стоит подумать и попробовать еще раз.'],
        ['Ошиблись - не сдавайтесь! Попробуйте другой вариант.'],
        ['Давайте попробуем другой подход.'],
        ['Близко, но к сожалению, не то. Попробуйте еще раз!'],
        ['Попробуте еще раз. Вы почти решили это!']
    ]}
    {$phrases[$phrase_id][0]}
    <p>Ошибка в задании? <a target="_blank" href="https://t.me/sqlize">Сообщите! Мы всё исправим :)</a></p>
{/if}
{assign var=referral_link_id value=0|mt_rand:11}
{assign var="referral_links" value=[
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/43dad3e496009351">Запишись на курс SkillFactory!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/b412b1200cd44461">Запишись на курс SkillBox!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/291bd04d7a9ef1a1">Запишись на курс Eduson ACADEMY!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/25a34bf9dae29e31">Запишись на курс Geek Brains!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/43dad3e496009351">Пройди курс от SkillFactory!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/b412b1200cd44461">Пройди курс от SkillBox!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/291bd04d7a9ef1a1">Пройди курс от Eduson ACADEMY!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/25a34bf9dae29e31">Пройди курс от Geek Brains!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/43dad3e496009351">Получи диплом от SkillFactory!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/b412b1200cd44461">Получи диплом от SkillBox!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/291bd04d7a9ef1a1">Получи диплом от Eduson ACADEMY!</a>'],
    ['Хочешь освоить SQL и стать востребованным специалистом? <a id="referral-link" onclick="ym(95990842,\'reachGoal\',\'referral-link\'); return true;" target="_blank" href="https://go.redav.online/25a34bf9dae29e31">Получи диплом от Geek Brains!</a>']
]}
<p style="font-size:large; margin-top: 5em;">{$referral_links[$referral_link_id][0]}</p>