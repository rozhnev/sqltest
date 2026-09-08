{if $QueryTestResult.ok}
    {assign var="successPhrases" value=[
        "Отличный запрос!",
        "Отлично! Задание выполнено безупречно!",
        "Так держать! Вы на правильном пути!",
        "Прекрасный результат!",
        "Отличная работа — продолжайте в том же духе!"
    ]}
    {assign var="successIndex" value=$successPhrases|@array_rand}
    {assign var="successPhrase" value=$successPhrases[$successIndex]}
    <style>
        .qts-celebration { position: relative; padding: 1.25rem 1.5rem 1rem; border-radius: 1rem; background: radial-gradient(circle at 25% -10%, rgba(255,255,255,.85), rgba(255,255,255,0) 55%), linear-gradient(135deg, var(--text-block-background-color, #fff), var(--block-background-color, #466cbd) 70%); border: 1px solid var(--border-color, #0B4FCC); color: var(--question-text, #33196f); box-shadow: 0 15px 38px rgba(29,7,74,.18); overflow: hidden; margin-bottom: 1rem; }
        .qts-message { font-size: 1.35rem; font-weight: 700; color: inherit; }
        .qts-message-glimmer { display: inline-flex; margin-left: .5rem; animation: qts-glimmer 2.8s ease-in-out infinite; color: var(--achievement-linkedin-fg, #f7b733); }
        .qts-confetti { position: absolute; inset: 0; pointer-events: none; }
        .qts-confetti-piece { position: absolute; top: -20px; width: 8px; height: 18px; border-radius: 3px; background: var(--color, #ffd166); animation: qts-confetti-drop var(--duration, 2.4s) linear infinite; animation-delay: var(--delay, 0s); left: var(--x-start, 10%); }
        @keyframes qts-confetti-drop { 0% { transform: translate3d(0,0,0) rotate(0); opacity: 1; } 100% { transform: translate3d(var(--x-end, 60px),280px,0) rotate(360deg); opacity: 0; } }
        @keyframes qts-glimmer { 0%,100% { opacity: .4; transform: scale(.9); } 50% { opacity: 1; transform: scale(1.1); } }
        .qts-badge { display: inline-flex; margin-top: .5rem; padding: .25rem .75rem; border-radius: 999px; border: 1px solid var(--border-color, #0B4FCC); background: var(--text-block-background-color, rgba(255,255,255,.85)); color: var(--question-text, #4b2d9f); font-size: .85rem; font-weight: 600; }
        .qts-error-card { position: relative; overflow: hidden; margin-bottom: 1rem; padding: 1.25rem 1.5rem; border: 1px solid var(--border-color, #0B4FCC); border-radius: 1rem; background: linear-gradient(200deg, rgba(251,125,125,.3), rgba(173,48,64,.55)); color: var(--regular-text-color, #f0f6fc); box-shadow: 0 18px 42px rgba(77,9,16,.35); }
        .qts-error-body { position: relative; z-index: 1; }
        .qts-error-message { color: var(--accordion-hover-border, #F0F6FC); font-size: 1.3rem; font-weight: 700; }
        .qts-error-hints { margin-top: .8rem; color: var(--question-text, #f0f6fc); line-height: 1.4; }
        .qts-error-hints p { margin: .3rem 0; }
        .qts-error-cta { margin-top: .6rem; color: var(--accordion-active, #006EF5); font-weight: 600; }
        .qts-error-referral { margin-top: .85rem; }
        .qts-error-referral .referral-link { padding: .7rem 1.1rem; border: 1px dashed rgba(255,255,255,.5); border-radius: .75rem; background: rgba(255,255,255,.07); text-align: center; }
    </style>
    <div class="qts-celebration">
        <div class="qts-message">{$successPhrase}<span class="qts-message-glimmer">✨</span></div>
        <div class="qts-badge">Задание выполнено</div>
        <div class="qts-confetti" aria-hidden="true">
            <span class="qts-confetti-piece" style="--x-start:5%;--x-end:40px;--delay:0s;--color:#ff6262"></span>
            <span class="qts-confetti-piece" style="--x-start:25%;--x-end:-20px;--delay:.25s;--color:#f7b733"></span>
            <span class="qts-confetti-piece" style="--x-start:45%;--x-end:60px;--delay:.45s;--color:#2ecc71"></span>
            <span class="qts-confetti-piece" style="--x-start:65%;--x-end:-50px;--delay:.15s;--color:#3498db"></span>
            <span class="qts-confetti-piece" style="--x-start:85%;--x-end:30px;--delay:.35s;--color:#1abc9c"></span>
        </div>
    </div>
    <div style="display:flex; flex-flow:row; flex-wrap:wrap; line-height:1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex:2 1;">Стоимость выполнения вашего запроса составляет {$QueryTestResult.cost} <span style="font-size:small;">(чем ниже стоимость, тем эффективнее запрос)</span>
            {if $QueryBestCost}<br>Стоимость лучшего решения: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Поздравляем! Ваш запрос входит в число лучших на нашем сайте!
                {elseif $QueryBestCost > $QueryTestResult.cost} Поздравляем с обновлением рекорда!
                {else} К сожалению, результат немного ниже рекорда. Есть над чем поработать! {/if}
            {/if}</div>
        {/if}
        {if array_key_exists('answerResult', $QueryTestResult)}
            <p>Представленный ответ будет оценен жюри.</p>
        {/if}
    </div>
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('maxAttemptsReached', $QueryTestResult.hints)}
    {assign var="NextQuestion" value="{$QueryTestResult.nextQuestion}"}
    {translate}maximum_attempts_reached{/translate}{if $QueryTestResult.nextQuestion} {translate}go_to_next_task{/translate}{/if}
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('timeOut', $QueryTestResult.hints)}
    {translate}test_time_out{/translate} {translate}go_to_rate{/translate}
{else}
    {assign var="errorPhrases" value=[
        "Попробуйте еще раз — небольшая правка приведет к успеху!",
        "Почти получилось! Немного доработайте запрос.",
        "Вы близки к цели — попробуйте еще раз!",
        "Небольшая правка, и ответ будет точным.",
        "Хорошая попытка — внесите небольшое изменение и запустите снова."
    ]}
    {assign var="errorIndex" value=$errorPhrases|@array_rand}
    {assign var="errorPhrase" value=$errorPhrases[$errorIndex]}
    <div class="qts-error-card" role="status" aria-live="polite">
        <div class="qts-error-body">
            <div class="qts-error-message">{$errorPhrase}</div>
            {if array_key_exists('hints', $QueryTestResult)}
                <div class="qts-error-hints">
                    {if array_key_exists('queryError', $QueryTestResult.hints)}<p>Подсказка: запрос возвращает ошибку: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>{/if}
                    {if array_key_exists('columnsCount', $QueryTestResult.hints)}<p>Подсказка: результирующая таблица должна содержать {$QueryTestResult.hints.columnsCount} столбцов.</p>{/if}
                    {if array_key_exists('columnsList', $QueryTestResult.hints)}<p>Подсказка: результирующая таблица должна состоять из следующих столбцов: {$QueryTestResult.hints.columnsList}.</p>{/if}
                    {if array_key_exists('rowsCount', $QueryTestResult.hints)}<p>Подсказка: результат должен содержать {$QueryTestResult.hints.rowsCount} строк.</p>{/if}
                    {if array_key_exists('rowsData', $QueryTestResult.hints)}<p>Подсказка: строка №{$QueryTestResult.hints.rowsData.rowNumber} должна содержать значения: {$QueryTestResult.hints.rowsData.rowTable}</p><p>Ваш результат: {$QueryTestResult.hints.rowsData.resultTable}</p>{/if}
                    {if array_key_exists('emptyQuery', $QueryTestResult.hints)}<p>Подсказка: ваш запрос пуст.</p>{/if}
                </div>
            {/if}
            <div class="qts-error-cta">Продолжайте — вы почти у цели.</div>
            {if isset($ReferralLink)}<div class="qts-error-referral"><a id="referral-link" target="_blank" href="{$ReferralLink.link}"><div class="referral-link">{$ReferralLink.content}</div></a></div>{/if}
        </div>
    </div>
{/if}
