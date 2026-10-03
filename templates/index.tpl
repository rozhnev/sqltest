{include file='header.tpl'}
<body>
    <div class="container">
        {include file='popups.tpl'}
        <header>
        {if $MobileView}
            {include file='m.top-menu.tpl' path="/question/{$Question.category_sef}/{$Question.question_sef}"}
        {else}
            {include file='top-menu.tpl' path="/question/{$Question.category_sef}/{$Question.question_sef}"}
        {/if}
        </header>
        <main3 id="main3">
            <div class="column">
                {include file='menu.tpl'}
            </div>
            <main class="column">
                {if $User->logged() && $NewAchievement}
                    {include file='new_achievement.tpl'}
                {/if}
                <section class="question-wrapper">
                    <div class="question-title-bar" style="display: flex;">
                        <div class="question-title">
                            <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                            <span title="({$QuestionID})">{translate}question_title{/translate}{if $Question.number}&nbsp;{$Question.number}:{/if}</span>
                            <h1 class="question-heading">{$Question.title|escape}</h1>
                            {if !isset($Question.answers) && $Question.question_type != 'free_answer'}<span class="question-dbms" title="{translate}question_action_use_syntax{/translate}">{$DBMS|escape}</span>{/if}
                            {if $User->logged()}
                                <span id="favoriteStar" class="question-star{if isset($Question.favored) && $Question.favored} favored{/if}" title="{if isset($Question.favored) && $Question.favored}{translate}favorite{/translate}{else}{translate}add_to_favorites{/translate}{/if}" onClick="toggleFavorites('{$Lang}', {$QuestionID})">★</span>
                            {/if}
                            <span class="question-dates">
                                {if $Question.solved_date}
                                    {translate}question_solved_at{/translate}: {$Question.solved_date}
                                {elseif $Question.last_attempt_date}
                                    {translate}question_last_attempt_date{/translate}: {$Question.last_attempt_date}
                                {/if}
                            </span>
                        </div>
                        {if $User->isAdmin()}
                            <div class="question-navigate" style="border-right: 1px solid var(--text-block-border-color);">
                                <a href="/admin/question/{$QuestionID}" title="Edit" style="color:white; text-decoration: none;"><i>✎</i></a>
                            </div>
                        {/if}
                        {if $PreviousQuestionId}
                            <div class="question-navigate" style="border-right: 1px solid var(--text-block-border-color);">
                                <a href="/{$Lang}/question/{$Question.category_sef}/{$PreviousQuestionId}" title="{translate}question_action_previous_title{/translate}">
                                    <i class="arrow arrow-left"></i>
                                </a>
                            </div>
                        {/if}
                        {if $NextQuestionId}
                            <div class="question-navigate">
                                <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="{translate}question_action_next_title{/translate}">
                                    <i class="arrow arrow-right"></i>
                                </a>
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
                                    <input type="{if $Question.question_type == 'single_answer'}radio{else}checkbox{/if}" id="answer-{$answer.id}" name="answers" value="{$answer.id}"
                                        {if $answer.id|in_array:$Question.last_query} checked{/if}>
                                    <label for="answer-{$answer.id}"> {$answer.answer}</label>
                                </div>
                            {/foreach}
                        </div>
                        <p class="question-action">{if $Question.question_type == 'single_answer'}{translate}question_action_choose_one_answer{/translate}{else}{translate}question_action_mark_all_answers{/translate}{/if}</p>
                    {elseif $Question.question_type == 'free_answer'}
                        <p class="question-action">{translate}question_action_write_free_answer{/translate}</p>
                        {if $Question.solved_date}
                            <p class="question-action question-solved">{translate}you_already_solved_this_task{/translate}</p>
                        {/if}
                    {else}
                        {* The dialect is the badge next to the title *}
                        <p class="question-action">{translate}question_action_write_query{/translate}</p>
                        {if $Question.solved_date}
                            <p class="question-action question-solved">{translate}you_already_solved_this_task{/translate}. <button type="button" class="text-button blue question-solved__solutions" onClick="showMySolutions({$QuestionID})">{translate}view_solutions{/translate}</button></p>
                        {/if}
                    {/if}
                </section>
                <div class="question-wrapper">
                    <div class="code-actions-upper" id="code-actions">
                        <div>
                            {if isset($Question.tutorial_link)}
                                <a 
                                    id="tutorialLink" 
                                    target="_blank" 
                                    href="{$Question.tutorial_link}" 
                                    title="{translate}question_action_tutorial{/translate}"
                                    class="text-button blue"
                                >
                                    <i class="icon icon-tutorial" aria-hidden="true"></i>
                                    <span>{translate}question_action_tutorial{/translate}</span>
                                </a>
                            {/if}
                            <span class="text-button blue" id="getHelpBtn" onClick="getHelp('{$Lang}', {$QuestionID})">
                                <i class="icon icon-hint" aria-hidden="true"></i>
                                <span>{translate}question_action_get_hint{/translate}</span>
                            </span>
                        </div>
                        <div>
                            {if $Question.question_type == 'free_answer'}
                                <span class="text-button blue" id="voiceInputBtn" onClick="toggleVoiceInput('{$Lang}')">
                                    <i class="icon icon-microphone" aria-hidden="true"></i>
                                    <span class="voice-label-idle">{translate}question_action_voice_input{/translate}</span>
                                    <span class="voice-label-listening">{translate}question_action_voice_input_stop{/translate}</span>
                                </span>
                                <span class="text-button red" onClick="clearFreeAnswer()">
                                    <i class="icon-trash"></i>
                                    <span>{translate}question_action_clear_answer{/translate}</span>
                                </span>
                            {elseif !isset($Question.answers)}
                                <span class="text-button blue" onClick="copyCode(`{translate}toast_sql_copied_to_buffer{/translate}`)">
                                    <i class="icon-copy"></i>
                                    <span>{translate}question_action_copy_code{/translate}</span>
                                </span>
                                <span class="text-button red" onClick="clearEditor()">
                                    <i class="icon-trash"></i>
                                    <span>{translate}question_action_clear_editor{/translate}</span>
                                </span>
                            {/if}
                        </div>
                    </div>
                    {include file='hint_panel.tpl'}
                    {if $Question.question_type == 'free_answer'}
                        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" name="free-answer-input" placeholder="{translate}free_answer_placeholder{/translate}">{$Question.last_query|escape:"html"}</textarea>
                    {elseif !isset($Question.answers)}
                        <div class="code-wrapper" id="sql-code" label="sql-code" name="sql-code" data-placeholder="{translate}sql_editor_placeholder{/translate}">{$Question.last_query|escape:"html"}</div>
                    {/if}
                    <div class="code-buttons">
                        {if $Question.question_type == 'free_answer'}
                            {if $User->logged()}
                                {* Checks are paid from the AI token balance; checkFreeAnswer() refreshes it after each check *}
                                <span class="free-answer-tokens">{translate}free_answer_tokens_left{/translate} <b id="free-answer-tokens-remaining">{$AiQuota.remaining_text}</b></span>
                                <a class="button{if !$AiQuota.low} hidden{/if}" id="buyTokensBtn" href="/{$Lang}/buy-tokens">{translate}tokens_buy_button{/translate}</a>
                                <button class="button green" id="checkFreeAnswerBtn" onClick="checkFreeAnswer('{$Lang}', {$QuestionID})">
                                    <i class="run-icon"></i>
                                    <span>{translate}question_action_check_free_answer{/translate}</span>
                                </button>
                            {else}
                                <span class="free-answer-tokens">{translate}free_answer_login_remark{/translate}</span>
                                <button class="button green" id="freeAnswerLoginBtn" onClick="toggleLoginWindow()">{translate}free_answer_login_button{/translate}</button>
                            {/if}
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
                            <button class="button green" id="checkAnswersBtn"  onClick="checkAnswers('{$Lang}', {$QuestionID})">
                                <i class="run-icon"></i>
                                <span>{translate}question_action_check_answers{/translate}</span>
                            </button>
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
                                <span class="code-result-empty-shortcut"><kbd>Ctrl</kbd>+<kbd>Enter</kbd> - {translate}question_action_run_query{/translate}</span>
                            {/if}
                        </div>
                        {/if}
                    </div>
                </div>
                {if $NextQuestionId}
                    <div class="code-buttons">
                        <div id="nextTaskBtn" class="hidden">
                            <a class="button green" href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="{translate}question_action_next_title{/translate}">
                                <i class="run-icon"></i>
                                <span>{translate}question_action_next{/translate}</span>
                            </a>
                        </div>
                    </div>
                {/if}
            </main>
            <aside class="column" id="right-panel">
                {if 
                    $Domain !== 'sqltest.online' && 
                    $Lang === 'ru' &&
                    ($User->logged() &&  in_array($User->getAuthProvider(), ['google', 'linkedin', 'github'])) && 
                    !$User->getEmail()
                }
                    <div style="background:#fff3cd;color:#856404;border-left:6px solid #ffc107;padding:12px 16px;margin-bottom:16px;border-radius:4px;display:flex;gap:12px;align-items:flex-start;font-size:14px;line-height:1.4;">
                        <div style="font-size:20px;line-height:1;margin-top:2px;">⚠️</div>
                        <div>
                            <strong style="display:block;margin-bottom:6px;">Внимание!</strong>
                            <div>В соответствии с требованиями законодательства РФ вход через сторонние сервисы (Google, Github, Linkedin) будет отключён с 31 июля. Чтобы не потерять доступ к аккаунту, пожалуйста, <a href="/{$Lang}/user/profile"><b style="color:#856404;">зайдите в профиль</b></a> и укажите актуальный адрес электронной почты и пароль. Они понадобятся для обычной авторизации.</div>
                            <div style="margin-top:8px;font-weight:600;">Пожалуйста, обновите данные заранее, чтобы сохранить бесперебойный доступ к сервису.</div>
                        </div>
                    </div>
                {/if}
                {if $User->logged()}
                    <div style="padding-right: 6px;">
                        {include file="my_progress.tpl"}
                    </div>
                {/if}
                <div class="question-wrapper" style="margin-right: 6px;">
                {include file="{$Lang}/{$DB}.tpl"}
                </div>
            </aside>
        </main3>
        {include file="{$Lang}/consent_banner.tpl"}
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>