{include file='header.tpl'}
<body>
    {include file="{$Lang}/consent_banner.tpl"}
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
            <div class="column">
                {include file="{$Lang}/adblock_banner.tpl"}
                {if $User->logged() && $NewAchievement}
                    <div class="user-solutions-count" id="userInfo" style="background: var(--db-description-background-color); color: white; padding: 12px 16px; margin-bottom: 16px; border-radius: 4px; display: flex; align-items: center; gap: 12px;">
                        <div style="font-size: 20px;">🏆</div>
                        <div>
                            {translate}new_achievement_unlocked{/translate}!&nbsp;
                            <a href="/{$Lang}/achievement/{$NewAchievement.user_achievement_id}" style="color: #00CED1; text-decoration: underline;">
                                <strong>{$NewAchievement.title}</strong>
                            </a>
                        </div>
                    </div>
                {/if}
                <div class="question-wrapper">
                    <div class="question-title-bar" style="display: flex;">
                        <div class="question-title">
                            <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                            <span style="line-height: 17px;" title="({$QuestionID})">{translate}question_title{/translate}{if $Question.number}&nbsp;{$Question.number}:{/if}</span>
                            {if $User->logged()}
                                <span id="favoriteStar" class="question-star{if isset($Question.favored) && $Question.favored} favored{/if}" title="{if isset($Question.favored) && $Question.favored}{translate}favorite{/translate}{else}{translate}add_to_favorites{/translate}{/if}" onClick="toggleFavorites('{$Lang}', {$QuestionID})">★</span>
                            {/if}
                            <span class="question-dates">
                                {if !$Question.solved_date && $Question.last_attempt_date}
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
                                    <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}"
                                        {if $answer.id|in_array:$Question.last_query} checked{/if}>
                                    <label for="answer-{$answer.id}"> {$answer.answer}</label>
                                </div>
                            {/foreach}
                        </div>
                        <p class="question-action">{translate}question_action_mark_all_answers{/translate}</p>
                    {else}
                        <p class="question-action">{translate}question_action_use_syntax{/translate} {translate}question_action_see_definitions{/translate}</p>
                        {if $Question.solved_date}
                            <span class="question-action" style="display: flex; align-items: center; font-weight: bold; color: #2EA043 !important;">{translate}you_already_solved_this_task{/translate}.&nbsp;<button class="button green" onClick="showMySolutions({$QuestionID})">{translate}view_solutions{/translate}</button></span>
                        {else}
                            <span class="question-action">{translate}question_action_write_your_request{/translate}</span>
                        {/if}
                    {/if}
                </div>
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
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M8.25 8C8.25 7.58579 8.58579 7.25 9 7.25H16C16.4142 7.25 16.75 7.58579 16.75 8C16.75 8.41421 16.4142 8.75 16 8.75H9C8.58579 8.75 8.25 8.41421 8.25 8Z" fill="#0069E6"/>
                                        <path d="M9 10.25C8.58579 10.25 8.25 10.5858 8.25 11C8.25 11.4142 8.58579 11.75 9 11.75H14C14.4142 11.75 14.75 11.4142 14.75 11C14.75 10.5858 14.4142 10.25 14 10.25H9Z" fill="#0069E6"/>
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M8.5 3.25C5.87665 3.25 3.75 5.37665 3.75 8V18C3.75 20.0711 5.42893 21.75 7.5 21.75H18.5C19.4665 21.75 20.25 20.9665 20.25 20V5C20.25 4.0335 19.4665 3.25 18.5 3.25H8.5ZM18.75 14.25V5C18.75 4.86193 18.6381 4.75 18.5 4.75H8.5C6.70507 4.75 5.25 6.20507 5.25 8V14.9997C5.87675 14.529 6.6558 14.25 7.5 14.25H18.75ZM18.75 15.75H7.5C6.25736 15.75 5.25 16.7574 5.25 18C5.25 19.2426 6.25736 20.25 7.5 20.25H18.5C18.6381 20.25 18.75 20.1381 18.75 20V15.75Z" fill="#0069E6"/>
                                    </svg>
                                    <span>{translate}question_action_tutorial{/translate}</span>
                                </a>
                            {/if}
                            <span class="text-button blue" id="getHelpBtn" onClick="getHelp('{$Lang}', {$QuestionID})">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M12 3.75C8.52397 3.75 5.75 6.46727 5.75 9.76594C5.75 11.7705 6.57093 13.4993 8.03534 14.576C8.3581 14.8133 8.63421 15.1672 8.73996 15.6162C8.82675 15.9847 8.92608 16.4337 9.02447 16.9095H14.9755C15.0739 16.4337 15.1732 15.9847 15.26 15.6162C15.3658 15.1672 15.6419 14.8133 15.9647 14.576C17.4291 13.4993 18.25 11.7705 18.25 9.76594C18.25 6.46727 15.476 3.75 12 3.75ZM14.6887 18.4095H9.31128C9.42169 19.0471 9.50831 19.6509 9.53454 20.0844C9.56215 20.5408 9.90326 20.9498 10.4062 21.0585L10.6022 21.1009C11.5226 21.2997 12.4774 21.2997 13.3978 21.1009L13.5938 21.0585C14.0967 20.9498 14.4379 20.5408 14.4655 20.0844C14.4917 19.6509 14.5783 19.0471 14.6887 18.4095ZM4.25 9.76594C4.25 5.59116 7.74404 2.25 12 2.25C16.256 2.25 19.75 5.59116 19.75 9.76594C19.75 12.1898 18.7464 14.3926 16.8532 15.7845C16.7668 15.848 16.7307 15.9148 16.7201 15.9601C16.6017 16.4627 16.4575 17.128 16.326 17.8029C16.1432 18.7412 15.9944 19.6512 15.9627 20.175C15.8927 21.3332 15.0406 22.2805 13.9106 22.5247L13.7146 22.567C12.5854 22.811 11.4146 22.811 10.2854 22.567L10.0894 22.5247C8.95941 22.2805 8.10735 21.3332 8.03727 20.175C8.00558 19.6512 7.85678 18.7412 7.67399 17.8029C7.5425 17.128 7.3983 16.4627 7.27991 15.9601C7.26925 15.9148 7.23315 15.848 7.14681 15.7845C5.25357 14.3926 4.25 12.1898 4.25 9.76594Z" fill="#0069E6"/>
                                </svg>
                                <span>{translate}question_action_get_hint{/translate}</span>
                            </span>
                        </div>
                        <div>
                            {if !isset($Question.answers)}
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
                    {if !isset($Question.answers)}
                        <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query|escape:"html"}</div>
                    {/if}
                    <div class="code-buttons">
                        {if !isset($Question.answers)}
                            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M6.54518 8.16266C6.32996 8.10588 6.15108 7.95644 6.05692 7.75475C5.96276 7.55306 5.96305 7.31997 6.05771 7.11852L7.71846 3.58413C7.84222 3.32074 8.10717 3.15272 8.39819 3.15308C8.6892 3.15344 8.95373 3.32212 9.07684 3.58581L9.80947 5.15504C9.83566 5.14475 9.86271 5.13582 9.89054 5.12836C14.2378 3.9635 18.7064 6.5434 19.8712 10.8907C21.0361 15.2381 18.4562 19.7066 14.1089 20.8715C9.76155 22.0363 5.29302 19.4564 4.12815 15.1091C3.75772 13.7266 3.76606 12.3298 4.09049 11.031C4.19088 10.6292 4.59804 10.3848 4.9999 10.4852C5.40177 10.5855 5.64616 10.9927 5.54577 11.3946C5.28148 12.4526 5.27419 13.5906 5.57704 14.7209C6.52749 18.268 10.1735 20.373 13.7206 19.4226C17.2678 18.4721 19.3728 14.8261 18.4224 11.279C17.4874 7.78983 13.9444 5.69602 10.4528 6.53307L11.192 8.11637C11.3151 8.38006 11.2745 8.69117 11.088 8.9145C10.9014 9.13783 10.6025 9.23307 10.3211 9.15884L6.54518 8.16266Z" fill="#338FFF"/>
                                </svg>
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
                    <div class="code-result ace-xcode" id="code-result"></div>
                </div>
                {if $NextQuestionId}
                    <div class="code-buttons">
                        <div id="nextTaskBtn" class="hidden">
                            <a class="button green hidden" href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="{translate}question_action_next_title{/translate}">
                                <i class="run-icon"></i>
                                <span>{translate}question_action_next{/translate}</span>
                            </a>
                        </div>
                    </div>
                {/if}
                <div class="text-block user-solutions-count">
                    {assign var="QuestionsCountRounded" value="{floor(($QuestionsCount - 1)/10) * 10}"}
                    {if $User->logged()}
                        <span>
                            {if $SolvedQuestionsCount < ($QuestionsCount/2)}
                                {assign var="YouHaveSolved" value="{translate}you_have_solved{/translate}"}
                            {else}
                                {assign var="YouHaveSolved" value="{translate}you_have_already_solved{/translate}"}
                            {/if}
                            
                            {translate}user_solutions_count_logged{/translate}
                            {if $SolvedQuestionsCount < $QuestionsCount}
                                {translate}keep_going{/translate}
                            {/if}
                        </span>

                        <button class="button-small green" onClick="location.href = '/{$Lang}/test/start';">
                            {if !$User->grade()}
                                {translate}check_your_skills{/translate}
                            {elseif $User->grade() == 'Senior'}
                                {$User->grade()}, {translate}confirm_you_grade{/translate}
                            {else}
                                {$User->grade()}, {translate}level_up{/translate}
                            {/if}
                        </button>
                    {else}
                        <span>{translate}user_solutions_count{/translate}</span>
                    {/if}
                </div>
            </div>
            <div class="column" id="right-panel">
                {if $User->logged() &&  $User->getAuthProvider() === 'vk' && !$User->getEmail()}
                    <div style="background:#fff3cd;color:#856404;border-left:6px solid #ffc107;padding:12px 16px;margin-bottom:16px;border-radius:4px;display:flex;gap:12px;align-items:flex-start;font-size:14px;line-height:1.4;">
                        <div style="font-size:20px;line-height:1;margin-top:2px;">⚠️</div>
                        <div>
                            <strong style="display:block;margin-bottom:6px;">Внимание!</strong>
                            <div>После 28 февраля 2026 года вход через ВКонтакте может стать недоступен. Чтобы не потерять доступ к аккаунту, пожалуйста, <a href="/{$Lang}/user/profile"><b style="color:#856404;">зайдите в профиль</b></a> и укажите адрес электронной почты и пароль — они понадобятся для авторизации, если вход через ВКонтакте будет отключён.</div>
                            <div style="margin-top:8px;font-weight:600;">Мы прилагаем все усилия, чтобы предотвратить возможные неудобства и сохранить ваш доступ к сервису.</div>
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
            </div>
        </main3>
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>