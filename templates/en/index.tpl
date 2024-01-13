{include file='../header.tpl'}
{include file='top-menu.tpl'}
{include file='../menu.tpl'}
<div class="splitter">
    <a href="" onClick="return toggleInfoPanel();" title="Toggle panel">
        ⯈
    </a>
    <a href="" class="hidden" onClick="return toggleInfoPanel();" title="Toggle panel">
        ⯇
    </a>
</div>
<div class="main">
    <div class="question-wrapper">
        <div class="question-title">Task {$Question.number}:
            <span class="question-dates">
                {if $Question.solved_date}
                    Solved at: {$Question.solved_date}
                {elseif $Question.last_attempt_date}
                    Last Attempt Date: {$Question.last_attempt_date}
                {/if}
            </span>
            <span class="question-navigate">
                {if $PreviousQuestionId}
                    <a href="/{$Lang}/{$DB}/{$PreviousQuestionId}" title="Previous task"><i class="arrow arrow-left"></i></a>
                {/if}
                {if $NextQuestionId}
                    <a href="/{$Lang}/{$DB}/{$NextQuestionId}" title="Next task"><i class="arrow arrow-right"></i></a>
                {/if}
            </span>
        </div>
        <div class="question">
            {$Question.task}
        </div>
        <p class="question-action">
        Write your request in the field below and click the "Check it!" button. (If there is an error, you will have to review the ad unit)
        </p>
        <p class="question-action">
             To write the answer, use MySQL syntax. Descriptions of the tables are given in the right panel.
        </p>
    </div>
    <div class="code-actions">
        <button onClick="copyCode(`SQL code copied to buffer`)">Copy code</button> <button onClick="clearEditor()">Clear editor</button>
    </div>
    <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
    <div class="code-buttons">
        <button class="button" onClick="getHelp('{$Lang}', '{$DB}', {$QuestionID})">Get help</button>
        <button class="button" onClick="runQuery('{$Lang}', '{$DB}', {$QuestionID})">Run query</button>
        <button class="button test" onClick="testQuery('{$Lang}', '{$DB}', {$QuestionID})">Check it!</button>
        {if $NextQuestionId}
            <a href="/{$Lang}/{$DB}/{$NextQuestionId}" title="Следующее задание" class="button test hidden">Next</a>
        {/if}
    </div>
    <div class="code-result" id="code-result"></div>
</div>

<div class="right">
    {include file="{$DB}.tpl"}
</div>
{include file='../footer.tpl'}
