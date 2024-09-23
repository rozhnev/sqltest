{include file='../header.tpl'}
<body>
<div class="container">
    {include file='popups.tpl'}
    {include file='top-menu.tpl'}
    <div class="menu" id="menu">
        <div id="test-timer" style="padding:5px 15px; border: 1px solid white; margin: 5px;"><span style="font-size:small;">Time to complete this test is</span> <span id="test-timer-time"></span></div>
        <script>
            const showTimer = ()=>{ldelim}
                const time = Math.floor(Math.abs(new Date('{$Question.closed_at}') - new Date())/60000)
                document.getElementById('test-timer-time').innerText = time + ' ' + (time>1 ? 'minutes': minute);
            {rdelim};
            showTimer();
            setInterval(showTimer,  60000);
        </script>
        {foreach $Questionnire.menu as $categoryId => $panel}
        <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
            {$panel.title}
        </button>
        <div class="panel {if $categoryId eq $QuestionCategoryID}active{/if}">
            <ol>
            {foreach $panel.questions as $question}
            <li>
                <a class="question-link {if $QuestionID == $question[1]} current-question{/if}{if $question[2]} solved{/if}" href="/{$Lang}/test/{$TestId}/{$question[1]}">
                    {$question[0]}
                </a>
            </li>
            {/foreach}
            </ol>
        </div>
        {/foreach}
        <div style="display: flex;   align-items: center; justify-content: center; margin-top: 1em;">
        <button class="button green" id="doneTest" onClick="doneTest('{$TestId}')">I am Done! Show my rate</button>
        </div>
    </div>
    {include file='../splitter.tpl'}
    <div class="main">
        <div class="question-wrapper">
            <div class="question-title-bar" style="display: flex;">
                <div class="question-title">
                    <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                    Task&nbsp;{$Question.number}:
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
                </div>
                {if $Question.previous_question_id}
                    <div class="question-navigate" style="border-right: 1px solid var(--text-block-border-color);">
                        <a href="/{$Lang}/test/{$TestId}/{$Question.previous_question_id}" title="Previous task"><i class="arrow arrow-left"></i></a>
                    </div>
                {/if}
                {if $Question.next_question_id}
                    <div class="question-navigate">
                        <a href="/{$Lang}/test/{$TestId}/{$Question.next_question_id}" title="Next task"><i class="arrow arrow-right"></i></a>
                    </div>
                {/if}
            </div>
            <div class="question">
                {$Question.task}
            </div>
            {if isset($Question.answers)}
                <div class="answers" id="answers-list">
                {foreach $Question.answers as $answer}
                    <div class="answer">
                        <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}" {if $answer.id|in_array:$Question.last_query} checked{/if}>
                        <label for="answer-{$answer.id}"> {$answer.answer}</label>
                    </div>
                {/foreach}
                </div>
                <p class="question-action">
                    Mark ALL correct answers and click the "Check it!" button
                </p>
            {else}
                <p class="question-action">
                    Write your request in the field below and click the "Check it!" button.
                </p>
                <p class="question-action">
                    To write the answer, use {$Question.dbms} syntax. Descriptions of the tables are given in the right panel.
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
            {if !isset($Question.answers)}
                <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="CTRL+Enter">Run query</button>
            {/if}
            {if {$Question.possible_attempts} > 0}
                <button class="button green" id="checkSolutionBtn" onClick="checkSolution('/{$Lang}/test/{$TestId}/check/{$QuestionID}')">Check it! ({$Question.possible_attempts})</button>
            {/if}
            {if $Question.next_question_id}
                <a href="/{$Lang}/test/{$TestId}/{$Question.next_question_id}" title="Mext task" class="button green hidden">Next</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>

    <div class="right" id="right-panel">
        {include file="{$DB}.tpl"}
    </div> 
    {include file='footer.tpl'}
