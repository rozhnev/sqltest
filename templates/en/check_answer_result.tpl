{if $AnswerResult.ok}
     {* <b>Great! You have completed the task!</b> *}
     <b>Awesome! You finished the task!</b>
     {* <b>You did it! Way to go!</b>
     <b>Congrats on finishing the task!</b>
     <b>You rock! You're all done!</b> *}
     {if !$Logged}
        {* <p class="question-action">
            To save your progress, please <a href="" onClick="toggleLoginWindow(); return false;">login</a>
        </p> *}
        <p class="question-action">
            To keep your progress safe, <a href="" onClick="toggleLoginWindow(); return false;">just log in now</a>.
        </p>
        {* <p class="question-action">
            To make sure your awesome work is saved, <a href="" onClick="toggleLoginWindow(); return false;">just log in</a>.
        </p>
        <p class="question-action">
            <a href="" onClick="toggleLoginWindow(); return false;">Log in</a> now to save your progress.
        </p>
        <p class="question-action">
            Don't forget to <a href="" onClick="toggleLoginWindow(); return false;">log in</a> to keep all your progress safe and sound. 😎
        </p> *}
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
    That's not quite right. Let's try again.
{/if}