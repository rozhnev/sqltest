{include file='../header.tpl'}
<body>
<div class="mobile-container">
    {include file='popups.tpl'}
    {include file='m.top-menu.tpl'}
    {include file='../m.menu.tpl'}
    <div class="main">
        <div class="question-wrapper" id="question-wrapper">
            <div class="question-title">
                <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                Task {$Question.number}:
                {if $LoggedAsAdmin}
                    <a href="/admin/question/{$NextQuestionId}" title="Edit" style="color:#333">&#9998;</a>
                {/if}
                <span class="question-dates">
                    {if $Question.solved_date}
                        Solved at: {$Question.solved_date}
                    {elseif $Question.last_attempt_date}
                        Last Attempt Date: {$Question.last_attempt_date}
                    {/if}
                </span>
                <span class="question-navigate">
                    {if $PreviousQuestionId}
                        <a href="/{$Lang}/question/{$Question.category_sef}/{$PreviousQuestionId}#question-wrapper" title="Previous task"><i class="arrow arrow-left"></i></a>
                    {/if}
                    {if $NextQuestionId}
                        <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}#question-wrapper" title="Next task"><i class="arrow arrow-right"></i></a>
                    {/if}
                </span>
            </div>
            <div class="question">
                {$Question.task}
            </div>
            {if isset($Question.answers)}
                <div class="question">
                {foreach $Question.answers as $answer}
                    <div class="answer">
                        <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}">
                        <label for="answer-{$answer.id}"> {$answer.answer}</label>
                    </div>
                {/foreach}
                </div>
                <p class="question-action">
                    Mark ALL correct answers and click the "Check it!" button
                </p>
            {else}
                <p class="question-action">
                    Write your request in the field below and click the "Check it!" button.{* (If there is an error, you will have to review the ad unit)*}
                </p>
                <p class="question-action">
                    To write the answer, use {$Question.dbms} syntax.<br>
                    Descriptions of the tables are given at the bottom of screen.
                </p>
            {/if}
        </div>
        {if !isset($Question.answers)}
            <div class="code-actions">
                <button onClick="copyCode(`SQL code copied to buffer`)">Copy code</button> <button onClick="clearEditor()">Clear editor</button>
            </div>
            <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
        {/if}
        <div class="code-buttons">
            <button class="button" id="getHelpBtn" onClick="getHelp('{$Lang}', {$QuestionID})">Get help</button>
            {if !isset($Question.answers)}
                <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="CTRL+Enter">Run query</button>
                <button class="button green" id="testQueryBtn" onClick="testQuery('{$Lang}', {$QuestionID})">Check it!</button>
            {else}
                <button class="button green" id="checkAnswersBtn" onClick="checkAnswers('{$Lang}', {$QuestionID})">Check it!</button>
            {/if}
            {if $NextQuestionId}
                <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="Следующее задание" class="button green hidden">Next</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>
    <div class="right">
        {include file="{$DB}.tpl"}
    </div>
    {include file='m.footer.tpl'}
