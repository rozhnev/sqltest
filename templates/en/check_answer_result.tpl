{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['Great! You have completed the task!', 'To save your progress, please <a href="" onClick="toggleLoginWindow(); return false;">login</a>.'],
        ['Awesome! You finished the task!', 'To keep your progress safe, <a href="" onClick="toggleLoginWindow(); return false;">just log in now</a>.'],
        ['You did it! Way to go!', 'To make sure your awesome work is saved, <a href="" onClick="toggleLoginWindow(); return false;">just log in</a>.'],
        ['Congrats on finishing the task!', '<a href="" onClick="toggleLoginWindow(); return false;">Log in</a> now to save your progress.'],
        ['You rock! You\'re all done!', 'Don\'t forget to <a href="" onClick="toggleLoginWindow(); return false;">log in</a> to keep all your progress safe and sound. 😎']
    ] }
    {$phrases[$phrase_id][0]}
    {if !$User->logged()}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <div class="question-rate-panel">
            <div style="min-width:280px;">Before starting the next test, please rate the difficulty of this task:</div>
            <div class="buttons">
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 1)"><span class="question-level rate1"></span>&nbsp;Too easy</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 2)"><span class="question-level rate2"></span>&nbsp;Simple</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 3)"><span class="question-level rate3"></span>&nbsp;Normal</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 4)"><span class="question-level rate4"></span>&nbsp;Difficult</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 5)"><span class="question-level rate5"></span>&nbsp;Very hard</button>
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
    <div class="referral_link" style="font-size:large; margin-top: 3em; padding: 1em; border: solid 1px; border-radius: 3px;">
        {$ReferralLink}
    </div>
{/if}