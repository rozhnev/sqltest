{include file='header.tpl'}
<body>
<div class="container">
    {include file='popups.tpl'}
    {if $MobileView}
        {include file='m.top-menu.tpl' path="/test/{$TestId}"}
    {else}
        {include file='top-menu.tpl' path="/test/{$TestId}"}
    {/if}
    <div class="menu" id="menu">
        {foreach $Questionnire.menu as $categoryId => $panel}
        <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
            <span class="accordion-title">{$panel.title}</span>
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
        <div id="test-timer" style="padding:5px 15px; border: 1px solid white; margin: 5px; display: flex; flex-direction: column; justify-items: center;">
            <div  style="display: flex; flex-direction: row; justify-items: center; margin: 1em 0;">
                <span>{translate}test_time_to_complete{/translate}: &nbsp;</span>
                <span id="test-timer-time"></span>
            </div>
            <span style="padding-bottom: 1em;">{translate}tasks_completed{/translate}: {$TestData.solved_questions_count} из {$TestData.questions_count}</span>
        </div>

        <div style="display: flex; align-items: center; justify-content: center; margin-top: 1em;">
            <a class="button green" style="text-decoration: none;" id="doneTest" href="/{$Lang}/test/{$TestId}/result">{translate}test_show_result{/translate}</a>
        </div>
    </div>
    {include file='splitter.tpl'}
    <div class="main">
        <div class="question-wrapper">
            <div class="question-title-bar" style="display: flex;">
                <div class="question-title">
                    <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                    <span title="({$QuestionID})">{translate}question_title{/translate}&nbsp;{$Question.number}:</span>
                    <span class="question-dates">
                        {if $Question.solved_date}
                            {translate}question_solved_at{/translate}: {$Question.solved_date}
                        {elseif $Question.last_attempt_at}
                            {translate}question_last_attempt_date{/translate}: {$Question.last_attempt_at}
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
                <p class="question-action">{translate}question_action_mark_all_answers{/translate}</p>
            {else}
                <p class="question-action">{translate}question_action_write_your_request{/translate}</p>
                <p class="question-action">{translate}question_action_use_syntax{/translate}</p>
            {/if}
        </div>
        {if !isset($Question.answers)}
        <div class="code-actions">
            <button onClick="copyCode(`{translate}toast_sql_copied_to_buffer{/translate}`)">{translate}question_action_copy_code{/translate}</button>
            <button onClick="clearEditor()">{translate}question_action_clear_editor{/translate}</button>
        </div>
        <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
        {/if}
        {* {var_export($TestData)} *}
        <div class="code-buttons">
            {if !isset($Question.answers)}
                <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="CTRL+Enter">{translate}question_action_run_query{/translate}</button>
            {/if}
            {if isset($TestData.timeout) && $TestData.timeout}
                <button class="button red">
                    {translate}test_time_out{/translate}
                </button>
            {elseif {$Question.possible_attempts} > 0}
                <button class="button green" id="checkSolutionBtn" onClick="checkSolution('/{$Lang}/test/{$TestId}/check/{$QuestionID}')">
                    {if !isset($Question.answers)}{translate}question_action_check_answers{/translate}{else}{translate}question_action_test_query{/translate}{/if} (<span id="attemptsCount">{$Question.possible_attempts}</span>)
                </button>
            {else}
                <button class="button gray">
                    {translate}question_maximum_attempts_used{/translate}
                </button>
            {/if}
            {if $Question.next_question_id}
            <a href="/{$Lang}/test/{$TestId}/{$Question.next_question_id}" title="Mext task" class="button green{if {$Question.possible_attempts} > 0} hidden{/if}" id="nextQuestionBtn">{translate}question_action_next{/translate}</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>
    <script>
        const showTimer = ()=>{ldelim}
            const time = Math.floor((new Date('{$Question.closed_at}') - new Date())/60000) + ((new Date()).getTimezoneOffset());
            if (time > 0) {ldelim}
                const minutes = time % 60;
                const hours = (time - minutes) / 60;
                document.getElementById('test-timer-time').innerText = (hours > 0 ? `${ldelim}hours{rdelim} ` :'') + (hours === 1 ? 'hour ': 'hours ') + minutes + ' ' + (minutes>1 ? 'minutes': 'minute');
            {rdelim} else {ldelim}
                document.getElementById('test-timer').innerText = '{translate}test_time_over{/translate}'
            {rdelim}
        {rdelim};
        showTimer();
        setInterval(showTimer,  60000);
    </script>
    <div class="right" id="right-panel">
        {include file="{$Lang}/{$DB}.tpl"}
    </div> 
    {include file='footer.tpl'}
