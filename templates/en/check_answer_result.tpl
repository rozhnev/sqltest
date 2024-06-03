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
    {if !$Logged}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <p class="question-action">
        Before starting the next test, please rate the difficulty of this task:
        <select onchange="rateQuestion({$QuestionID}, this.value)">
             <option value="0" disabled selected>---</option>
             <option value="1">Too easy</option>
             <option value="2">Simple</option>
             <option value="3">Normal</option>
             <option value="4">Difficult</option>
             <option value="5">Very hard</option>
        </select>
        </p>
    {/if}
{else}
    {assign var="phrases" value=[
        ['That\'s not it, but keep thinking! Try again.'],
        ['Not quite, but don\'t give up! Try again.'],
        ['Let\'s try a different approach.'],
        ['Almost, but not quite. Try again!'],
        ['Let\'s give that another go. You're almost there!']
    ]}
    {$phrases[$phrase_id][0]}
    <p>Error in task? <a target="_blank" href="https://t.me/sqlize">Report! We'll fix it :)</a></p>
{/if}