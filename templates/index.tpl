{include file='header.tpl'}

<body>
    <div class="container">
        {include file='popups.tpl'}
        {if $MobileView}
            {include file='m.top-menu.tpl' path="/question/{$Question.category_sef}/{$Question.question_sef}"}
        {else}
            {include file='top-menu.tpl' path="/question/{$Question.category_sef}/{$Question.question_sef}"}
        {/if}
        {include file='menu.tpl'}
        {include file='splitter.tpl'}
        <div class="main">
            <div class="question-wrapper">
                <div class="question-title-bar" style="display: flex;">
                    <div class="question-title">
                        <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                        <span title="({$QuestionID})">{translate}question_title{/translate}&nbsp;{$Question.number}:</span>
                        {if $LoggedAsAdmin}
                            <a href="/admin/question/{$NextQuestionId}" title="Edit" style="color:#333">&#9998;</a>
                        {/if}
                        <span class="question-dates">
                            {if $Question.solved_date}
                                {translate}question_solved_at{/translate}: {$Question.solved_date}
                            {elseif $Question.last_attempt_date}
                                {translate}question_last_attempt_date{/translate}: {$Question.last_attempt_date}
                            {/if}
                        </span>
                    </div>
                    {if $PreviousQuestionId}
                        <div class="question-navigate" style="border-right: 1px solid var(--text-block-border-color);">
                            <a href="/{$Lang}/question/{$Question.category_sef}/{$PreviousQuestionId}"
                                title="Previous task"><i class="arrow arrow-left"></i></a>
                        </div>
                    {/if}
                    {if $NextQuestionId}
                        <div class="question-navigate">
                            <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="Next task"><i
                                    class="arrow arrow-right"></i></a>
                        </div>
                    {/if}
                </div>
                <div class="question">
                    {$Question.task}
                </div>
                {if isset($Question.answers)}
                    <div class="answers">
                        {foreach $Question.answers as $answer}
                            <div class="answer">
                                <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}"
                                    {if $answer.id|in_array:$Question.last_query} checked{/if}>
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
                    <button
                        onClick="copyCode(`{translate}toast_sql_copied_to_buffer{/translate}`)">{translate}question_action_copy_code{/translate}</button>
                    <button onClick="clearEditor()">{translate}question_action_clear_editor{/translate}</button>
                </div>
                <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
            {/if}
            <div class="code-buttons">
                <button class="button" id="getHelpBtn"
                    onClick="getHelp('{$Lang}', {$QuestionID})">{translate}question_action_get_help{/translate}</button>
                {if !isset($Question.answers)}
                    <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})"
                        title="CTRL+Enter">{translate}question_action_run_query{/translate}</button>
                    <button class="button green" id="testQueryBtn"
                        onClick="testQuery('{$Lang}', {$QuestionID})">{translate}question_action_test_query{/translate}</button>
                {else}
                    <button class="button green" id="checkAnswersBtn"
                        onClick="checkAnswers('{$Lang}', {$QuestionID})">{translate}question_action_check_answers{/translate}</button>
                {/if}
                {if $NextQuestionId}
                    <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="Next task"
                        class="button green hidden">{translate}question_action_next{/translate}</a>
                {/if}
            </div>
            <div class="code-result ace-xcode" id="code-result"></div>
        </div>

        <div class="right" id="right-panel">
            <div class="text-block user-solutions-count">
                {assign var="QuestionsCountRounded" value="{floor(($QuestionsCount - 1)/10) * 10}"}
                <p>{translate}user_solutions_count{/translate}</p>
                {if $Logged}
                    {if $SolvedQuestionsCount < ($QuestionsCount/2)}
                        {assign var="YouHaveSolved" value="{translate}you_have_solved{/translate}"}
                    {else}
                        {assign var="YouHaveSolved" value="{translate}you_have_already_solved{/translate}"}
                    {/if}
                    <p>
                        {translate}user_solutions_count_logged{/translate}
                        {if $SolvedQuestionsCount < $QuestionsCount}
                            {translate}keep_going{/translate}
                        {/if}
                    </p>
                {else}
                    <p>{translate}user_solutions_count_not_logged{/translate}</p>
                    <button class="button blue" onClick="toggleLoginWindow()">{translate}top_menu_login{/translate}</button>
                {/if}
            </div>
            {include file="{$Lang}/{$DB}.tpl"}
        </div>
{include file='footer.tpl'}