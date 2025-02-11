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
        <div class="main">
            <div class="text-block user-solutions-count">
                {assign var="QuestionsCountRounded" value="{floor(($QuestionsCount - 1)/10) * 10}"}
                <span>{translate}user_solutions_count{/translate}</span>
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
                {/if}
                
            </div>
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
                    {if $LoggedAsAdmin}
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
                    <p class="question-action">{translate}question_action_use_syntax{/translate}</p>
                    {if $Question.solved_date}
                        <span class="question-action">{translate}you_already_solved_this_task{/translate}&nbsp;{$Question.solved_date}.&nbsp;<button class="button-small blue" onClick="showMySolutions({$QuestionID})">{translate}view_solutions{/translate}</button></span>
                    {else}
                        <span class="question-action">{translate}question_action_write_your_request{/translate}</span>
                    {/if}
                {/if}
            </div>
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
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M9 3.25C5.82436 3.25 3.25 5.82436 3.25 9V16.1069C3.25 16.5211 3.58579 16.8569 4 16.8569C4.41421 16.8569 4.75 16.5211 4.75 16.1069V9C4.75 6.65279 6.65279 4.75 9 4.75H16.0129C16.4271 4.75 16.7629 4.41421 16.7629 4C16.7629 3.58579 16.4271 3.25 16.0129 3.25H9Z" fill="#0069E6"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M18.4026 6.79315C15.1616 6.43093 11.8384 6.43093 8.59748 6.79315C7.6742 6.89634 6.93227 7.62293 6.82344 8.55337C6.43906 11.8399 6.43906 15.1599 6.82344 18.4464C6.93227 19.3769 7.6742 20.1034 8.59748 20.2066C11.8384 20.5689 15.1616 20.5689 18.4026 20.2066C19.3258 20.1034 20.0678 19.3769 20.1766 18.4464C20.561 15.1599 20.561 11.8399 20.1766 8.55337C20.0678 7.62293 19.3258 6.89634 18.4026 6.79315ZM8.76409 8.28387C11.8943 7.93402 15.1057 7.93402 18.2359 8.28387C18.4733 8.31039 18.6599 8.4981 18.6867 8.72762C19.0576 11.8983 19.0576 15.1015 18.6867 18.2722C18.6599 18.5017 18.4733 18.6894 18.2359 18.7159C15.1057 19.0658 11.8943 19.0658 8.76409 18.7159C8.52674 18.6894 8.34013 18.5017 8.31329 18.2722C7.94245 15.1015 7.94245 11.8983 8.31329 8.72762C8.34013 8.4981 8.52674 8.31039 8.76409 8.28387Z" fill="#0069E6"/>
                            </svg>
                            <span>{translate}question_action_copy_code{/translate}</span>
                        </span>
                        <span class="text-button red" onClick="clearEditor()">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M10 2.25C9.58579 2.25 9.25 2.58579 9.25 3V3.75H5C4.58579 3.75 4.25 4.08579 4.25 4.5C4.25 4.91421 4.58579 5.25 5 5.25H19C19.4142 5.25 19.75 4.91421 19.75 4.5C19.75 4.08579 19.4142 3.75 19 3.75H14.75V3C14.75 2.58579 14.4142 2.25 14 2.25H10Z" fill="#E60000"/>
                                <path d="M10 10.6499C10.4142 10.6499 10.75 10.9857 10.75 11.3999V18.3999C10.75 18.8141 10.4142 19.1499 10 19.1499C9.58579 19.1499 9.25 18.8141 9.25 18.3999V11.3999C9.25 10.9857 9.58579 10.6499 10 10.6499Z" fill="#E60000"/>
                                <path d="M14.75 11.3999C14.75 10.9857 14.4142 10.6499 14 10.6499C13.5858 10.6499 13.25 10.9857 13.25 11.3999V18.3999C13.25 18.8141 13.5858 19.1499 14 19.1499C14.4142 19.1499 14.75 18.8141 14.75 18.3999V11.3999Z" fill="#E60000"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M5.99142 7.91718C6.03363 7.53735 6.35468 7.25 6.73684 7.25H17.2632C17.6453 7.25 17.9664 7.53735 18.0086 7.91718L18.2087 9.71852C18.5715 12.9838 18.5715 16.2793 18.2087 19.5446L18.189 19.722C18.045 21.0181 17.0404 22.0517 15.7489 22.2325C13.2618 22.5807 10.7382 22.5807 8.25108 22.2325C6.95954 22.0517 5.955 21.0181 5.81098 19.722L5.79128 19.5446C5.42846 16.2793 5.42846 12.9838 5.79128 9.71852L5.99142 7.91718ZM7.40812 8.75L7.2821 9.88417C6.93152 13.0394 6.93152 16.2238 7.2821 19.379L7.3018 19.5563C7.37011 20.171 7.84652 20.6612 8.45905 20.747C10.8082 21.0758 13.1918 21.0758 15.5409 20.747C16.1535 20.6612 16.6299 20.171 16.6982 19.5563L16.7179 19.379C17.0685 16.2238 17.0685 13.0394 16.7179 9.88417L16.5919 8.75H7.40812Z" fill="#E60000"/>
                            </svg>
                            <span>{translate}question_action_clear_editor{/translate}</span>
                        </span>
                    {/if}
                </div>
            </div>
            {if !isset($Question.answers)}
                <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
            {/if}
            <div class="code-buttons">
                {if !isset($Question.answers)}
                    <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M6.54518 8.16266C6.32996 8.10588 6.15108 7.95644 6.05692 7.75475C5.96276 7.55306 5.96305 7.31997 6.05771 7.11852L7.71846 3.58413C7.84222 3.32074 8.10717 3.15272 8.39819 3.15308C8.6892 3.15344 8.95373 3.32212 9.07684 3.58581L9.80947 5.15504C9.83566 5.14475 9.86271 5.13582 9.89054 5.12836C14.2378 3.9635 18.7064 6.5434 19.8712 10.8907C21.0361 15.2381 18.4562 19.7066 14.1089 20.8715C9.76155 22.0363 5.29302 19.4564 4.12815 15.1091C3.75772 13.7266 3.76606 12.3298 4.09049 11.031C4.19088 10.6292 4.59804 10.3848 4.9999 10.4852C5.40177 10.5855 5.64616 10.9927 5.54577 11.3946C5.28148 12.4526 5.27419 13.5906 5.57704 14.7209C6.52749 18.268 10.1735 20.373 13.7206 19.4226C17.2678 18.4721 19.3728 14.8261 18.4224 11.279C17.4874 7.78983 13.9444 5.69602 10.4528 6.53307L11.192 8.11637C11.3151 8.38006 11.2745 8.69117 11.088 8.9145C10.9014 9.13783 10.6025 9.23307 10.3211 9.15884L6.54518 8.16266Z" fill="#338FFF"/>
                        </svg>
                        <span>{translate}question_action_run_query{/translate}</span>
                    </button>
                    <button class="button green" id="testQueryBtn" onClick="testQuery('{$Lang}', {$QuestionID})"  title="Shift+Enter">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                        </svg>                        
                        <span>{translate}question_action_test_query{/translate}</span>
                    </button>
                {else}
                    <button class="button green" id="checkAnswersBtn"  onClick="checkAnswers('{$Lang}', {$QuestionID})">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                        </svg>
                        <span>{translate}question_action_check_answers{/translate}</span>
                    </button>
                {/if}
            </div>
            <div class="code-result ace-xcode" id="code-result"></div>
            {if $NextQuestionId}
                <div class="code-buttons">
                    <a id="nextTaskBtn" href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="{translate}question_action_next_title{/translate}" class="button green hidden">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                        </svg>
                        <span>{translate}question_action_next{/translate}</span>
                    </a>
                </div>
            {/if}
        </div>

        <div class="right" id="right-panel">
            {include file="{$Lang}/{$DB}.tpl"}
        </div>
{include file='footer.tpl'}