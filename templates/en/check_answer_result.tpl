{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['Great! You have completed the task!', 'To save your progress, please <a href="" onClick="toggleLoginWindow(); return false;">login</a>.'],
        ['Awesome! You finished the task!', 'To keep your progress safe, <a href="" onClick="toggleLoginWindow(); return false;">just log in now</a>.'],
        ['You did it! Way to go!', 'To make sure your awesome work is saved, <a href="" onClick="toggleLoginWindow(); return false;">just log in</a>.'],
        ['Congrats on finishing the task!', '<a href="" onClick="toggleLoginWindow(); return false;">Log in</a> now to save your progress.'],
        ['You rock! You\'re all done!', 'Don\'t forget to <a href="" onClick="toggleLoginWindow(); return false;">log in</a> to keep all your progress safe and sound. 😎']
    ] }
    <p>{$phrases[$phrase_id][0]}</p>
    {if !$User->logged()}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <div class="question-rate-panel">
        <div style="min-width:280px; flex: 2 1; margin-bottom: 9px 0;">Before starting the next test, please rate the difficulty of this task:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Too easy" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Too easy</label>
                <input type="radio" id="rate2" name="question_rate" value="Simple" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simple</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difficult" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difficult</label>
                <input type="radio" id="rate5" name="question_rate" value="Very hard" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Very hard</label>
            </div>
        </div>
    {/if}
{else}
    {assign var="phrases" value=[
        ['That\'s not it, but keep thinking! Try again.'],
        ['Not quite, but don\'t give up! Try again.'],
        ['Let\'s try a different approach.'],
        ['Almost, but not quite. Try again!'],
        ['Let\'s give that another go. You\'re almost there!']
    ]}
    {$phrases[$phrase_id][0]}
    <p>Error in task? <a target="_blank" href="https://t.me/sqlize">Report! We'll fix it 😊</a></p>
{/if}
{if isset($ReferralLink)}
    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
        <div class="referral-link">
            {$ReferralLink.content}
        </div>
    </a>
{/if}