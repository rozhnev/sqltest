    {include file='header.tpl'}
    <body>
    <div class="mobile-container">
        {include file='popups.tpl'}
        <header>
            {include file='m.top-menu.tpl' path="/question/{$Question.category_sef}/{$Question.question_sef}"}
        </header>
        {* The task list is a drawer, closed by default, so the task and the editor are on the first screen *}
        <div style="padding: 6px 6px 0;">
            <details class="question-wrapper nav-drawer task-drawer" ontoggle="if (this.open) scrollQuestionPanel()">
                <summary class="nav-drawer-summary">
                    <span class="nav-drawer-title">{translate}tasks{/translate}</span>
                    <span class="nav-drawer-current">{$Question.category_title|escape}{if $User->logged()} · {$SolvedQuestionsCount}/{$QuestionsCount}{/if}</span>
                </summary>
                {if $User->logged()}
                    {include file="my_progress.tpl"}
                {/if}
                {include file='menu.tpl'}
            </details>
        </div>
        <div class="main" style="padding: 6px;">
            <div class="question-wrapper" id="question-wrapper">
                <div class="question-title-bar" style="display: flex; flex-direction: row; justify-content: space-between;">
                    <div class="question-title">
                        <span>
                            <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                            <span title="({$QuestionID})">{translate}question_title{/translate}&nbsp;{$Question.number}:</span>
                            {if !isset($Question.answers) && $Question.question_type != 'free_answer'}<span class="question-dbms" title="{translate}question_action_use_syntax{/translate}">{$DBMS|escape}</span>{/if}
                        </span>
                        {* <span class="question-dates">
                            {if $Question.solved_date}
                                {translate}question_solved_at{/translate}: {$Question.solved_date}
                            {elseif $Question.last_attempt_date}
                                {translate}question_last_attempt_date{/translate}: {$Question.last_attempt_date}
                            {/if}
                        </span> *}
                    </div>
                    {if $PreviousQuestionId}
                        <div class="question-navigate" style="border-right: 1px solid var(--text-block-border-color);">
                            <a href="/{$Lang}/question/{$Question.category_sef}/{$PreviousQuestionId}#question-wrapper" title="Previous task"><i class="arrow arrow-left"></i></a>
                        </div>
                    {/if}
                    {if $NextQuestionId}
                        <div class="question-navigate">
                            <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}#question-wrapper" title="Next task"><i class="arrow arrow-right"></i></a>
                        </div>
                    {/if}
                </div>
                <div class="question">
                    {$Question.task}
                </div>
                {if isset($Question.answers)}
                    <div class="question">
                    {foreach $Question.answers as $answer}
                        <div class="answer">
                            <input type="{if $Question.question_type == 'single_answer'}radio{else}checkbox{/if}" id="answer-{$answer.id}" name="answers" value="{$answer.id}" {if $answer.id|in_array:$Question.last_query} checked{/if}>
                            <label for="answer-{$answer.id}"> {$answer.answer}</label>
                        </div>
                    {/foreach}
                    </div>
                    <p class="question-action">{if $Question.question_type == 'single_answer'}{translate}question_action_choose_one_answer{/translate}{else}{translate}question_action_mark_all_answers{/translate}{/if}</p>
                {elseif $Question.question_type == 'free_answer'}
                    <p class="question-action">{translate}question_action_write_free_answer{/translate}</p>
                {else}
                    {* The dialect is the badge next to the title *}
                    <p class="question-action">{translate}question_action_write_query_mobile{/translate}</p>
                {/if}
            </div>
            <div class="question-wrapper">
                {if !isset($Question.answers)}
                    <div class="code-actions-upper">
                        <button type="button" class="text-button blue" id="getHelpBtn" onClick="getHelp('{$Lang}', {$QuestionID})">
                            <i class="icon icon-hint" aria-hidden="true"></i>
                            <span>{translate}question_action_get_hint{/translate}</span>
                        </button>
                        {if $Question.question_type == 'free_answer'}
                            <button type="button" class="text-button blue" id="voiceInputBtn" onClick="toggleVoiceInput('{$Lang}')">
                                <i class="icon icon-microphone" aria-hidden="true"></i>
                                <span class="voice-label-idle">{translate}question_action_voice_input{/translate}</span>
                                <span class="voice-label-listening">{translate}question_action_voice_input_stop{/translate}</span>
                            </button>
                            <button type="button" class="text-button red" onClick="clearFreeAnswer()">
                                <i class="icon-trash"></i>
                                <span>{translate}question_action_clear_answer{/translate}</span>
                            </button>
                        {else}
                            <button type="button" class="text-button blue" onClick="copyCode(`{translate}toast_sql_copied_to_buffer{/translate}`)">
                                <i class="icon-copy"></i>
                                <span>{translate}question_action_copy_code{/translate}</span>
                            </button>
                            <button type="button" class="text-button red" onClick="clearEditor()">
                                <i class="icon-trash"></i>
                                <span>{translate}question_action_clear_editor{/translate}</span>
                            </button>
                        {/if}
                    </div>
                    {include file='hint_panel.tpl'}
                    {if $Question.question_type == 'free_answer'}
                        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" name="free-answer-input" placeholder="{translate}free_answer_placeholder{/translate}">{$Question.last_query|escape:"html"}</textarea>
                    {else}
                        <div class="code-wrapper" id="sql-code" name="sql-code" data-placeholder="{translate}sql_editor_placeholder{/translate}">{$Question.last_query}</div>
                    {/if}
                {/if}
                <div class="code-buttons">
                    {if $Question.question_type == 'free_answer'}
                        <button class="button green" id="checkFreeAnswerBtn" onClick="{if $User->logged()}checkFreeAnswer('{$Lang}', {$QuestionID}){else}toggleLoginWindow(){/if}">{translate}question_action_check_free_answer{/translate}</button>
                    {elseif !isset($Question.answers)}
                        <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                            <i class="run-query-icon"></i>
                            <span>{translate}question_action_run_query{/translate}</span>
                        </button>
                        <button class="button green" id="testQueryBtn" onClick="testQuery('{$Lang}', {$QuestionID})">
                            <i class="run-icon"></i>
                            <span>{translate}question_action_test_query{/translate}</span>
                        </button>
                    {else}
                        <button class="button green" id="checkAnswersBtn" onClick="checkAnswers('{$Lang}', {$QuestionID})">{translate}question_action_check_answers{/translate}</button>
                    {/if}
                </div>
            </div>
            <div class="question-wrapper">
            {* data-*: labels and the "Explain the error" AI button for SQL errors (enhanceSqlErrors() in script.js) *}
            <div class="code-result ace-xcode" id="code-result"
                data-location-label="{translate}sql_error_location{/translate}" data-goto-label="{translate}sql_error_goto{/translate}"
                data-logged="{if $User->logged()}1{else}0{/if}" data-login-text="{translate}sql_error_explain_login{/translate}"
                data-login-button="{translate}sql_error_explain_login_button{/translate}"
                {if $QueryErrorAssistant}
                data-explain-url="/{$Lang}/question/{$QuestionID}/explain-error"
                data-explain-label="{translate}sql_error_explain{/translate}" data-explain-loading="{translate}sql_error_explain_loading{/translate}"
                data-explain-hint="{translate}sql_error_explain_hint{/translate}" data-tokens-left-label="{translate}free_answer_tokens_left{/translate}"
                {/if}>
                {* Empty state, replaced by the first result, hint or error *}
                {if $Question.question_type == 'free_answer' && $Question.last_feedback}
                    {include file='free_answer_last_check.tpl' Feedback=$Question.last_feedback CheckedAt=$Question.last_attempt_date}
                {else}
                <div class="code-result-empty">
                    {if $Question.question_type == 'free_answer'}
                        {translate}result_empty_free_answer{/translate}
                    {elseif isset($Question.answers)}
                        {translate}result_empty_answers{/translate}
                    {else}
                        {translate}result_empty_query{/translate}
                    {/if}
                </div>
                {/if}
            </div>
                {if $NextQuestionId}
                    <div class="code-buttons">
                        <div id="nextTaskBtn" class="hidden">
                            <a class="button green" href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}#question-wrapper" title="{translate}question_action_next_title{/translate}">
                                <i class="run-icon"></i>
                                <span>{translate}question_action_next{/translate}</span>
                            </a>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
        <div class="right" id="right-panel" style="padding: 0 6px;">
            <div class="question-wrapper">
                {include file="{$Lang}/{$DB}.tpl"}
            </div>
        </div>
        <footer>
            {include file='m.footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>