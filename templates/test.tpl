{include file='header.tpl'}
<body>
<div class="container">
    {include file='popups.tpl'}
    <header>
        {if $MobileView}
            {include file='m.top-menu.tpl' path="/test/{$TestId}/question/{$QuestionID}"}
        {else}
            {include file='top-menu.tpl' path="/test/{$TestId}/question/{$QuestionID}"}
        {/if}
    </header>
    <main3 id="main3">
        <div class="column">
            <div class="menu" id="menu">
                <div id="menu-content" class="menu-content">
                    {foreach $Questionnire.menu as $categoryId => $panel}
                    <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
                        <span class="accordion-title">{$panel.title}</span>
                    </button>
                    <div class="panel {if $categoryId eq $QuestionCategoryID}active{/if}">
                        <ol>
                        {foreach $panel.questions as $question}
                        <li>
                            <a class="question-link {if $QuestionID == $question[1]} current-question{/if}{if $question[2]} solved{/if}" href="/{$Lang}/test/{$TestId}/question/{$question[1]}">
                                <span class="question-number">&nbsp;</span>
                                {$question[0]}
                            </a>
                        </li>
                        {/foreach}
                        </ol>
                    </div>
                    {/foreach}
                </div>
                <div id="test-timer" style="
                    color: var(--menu-link-color); 
                    background-color: var(--accordion-panel-bg-color);
                    padding:5px 15px; border: 1px solid var(--menu-link-color); margin: 5px; display: flex; flex-direction: column; justify-items: center;">
                    <div  style="display: flex; flex-direction: row; justify-items: center; margin: 1em 0;">
                        <span>{translate}test_time_to_complete{/translate}: &nbsp;</span>
                        <span id="test-timer-time" style="white-space: nowrap;"></span>
                    </div>
                    <span style="padding-bottom: 1em;">{translate}tasks_completed{/translate}: {$TestData.solved_questions_count} из {$TestData.questions_count}</span>
                </div>

                <div style="display: flex; align-items: center; justify-content: center; margin-top: 1em;">
                    <a class="button green" style="text-decoration: none;" id="doneTest" href="/{$Lang}/test/{$TestId}/result">{translate}test_show_result{/translate}</a>
                </div>

                <div class="menu-ad">
                    <div id="yandex_rtb_R-A-4716552-2">
                    </div>
                </div>
            </div>
        </div>
        <div class="column">
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
                            <a href="/{$Lang}/test/{$TestId}/question/{$Question.previous_question_id}" title="Previous task"><i class="arrow arrow-left"></i></a>
                        </div>
                    {/if}
                    {if $Question.next_question_id}
                        <div class="question-navigate">
                            <a href="/{$Lang}/test/{$TestId}/question/{$Question.next_question_id}" title="Next task"><i class="arrow arrow-right"></i></a>
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
                    <p class="question-action">{translate}question_action_use_syntax{/translate} {translate}question_action_see_definitions{/translate}</p>
                {/if}
            </div>
            {if !isset($Question.answers)}
                <div class="code-actions-upper" id="code-actions">
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
                </div>
                <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
            {/if}
            
            {* {var_export($TestData)} *}
            <div class="code-buttons">
                {if !isset($Question.answers)}
                    <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6.54518 8.16266C6.32996 8.10588 6.15108 7.95644 6.05692 7.75475C5.96276 7.55306 5.96305 7.31997 6.05771 7.11852L7.71846 3.58413C7.84222 3.32074 8.10717 3.15272 8.39819 3.15308C8.6892 3.15344 8.95373 3.32212 9.07684 3.58581L9.80947 5.15504C9.83566 5.14475 9.86271 5.13582 9.89054 5.12836C14.2378 3.9635 18.7064 6.5434 19.8712 10.8907C21.0361 15.2381 18.4562 19.7066 14.1089 20.8715C9.76155 22.0363 5.29302 19.4564 4.12815 15.1091C3.75772 13.7266 3.76606 12.3298 4.09049 11.031C4.19088 10.6292 4.59804 10.3848 4.9999 10.4852C5.40177 10.5855 5.64616 10.9927 5.54577 11.3946C5.28148 12.4526 5.27419 13.5906 5.57704 14.7209C6.52749 18.268 10.1735 20.373 13.7206 19.4226C17.2678 18.4721 19.3728 14.8261 18.4224 11.279C17.4874 7.78983 13.9444 5.69602 10.4528 6.53307L11.192 8.11637C11.3151 8.38006 11.2745 8.69117 11.088 8.9145C10.9014 9.13783 10.6025 9.23307 10.3211 9.15884L6.54518 8.16266Z" fill="#338FFF"/>
                    </svg>
                    <span>{translate}question_action_run_query{/translate}</span>
                </button>
                {/if}
                {if isset($TestData.timeout) && $TestData.timeout}
                    <button class="button red">
                        {translate}test_time_out{/translate}
                    </button>
                {elseif {$Question.possible_attempts} > 0}
                    <button class="button green" id="checkSolutionBtn" onClick="checkSolution('/{$Lang}/test/{$TestId}/check/{$QuestionID}')">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                        </svg>
                        <span>
                        {if !isset($Question.answers)}
                            {translate}question_action_check_answers{/translate}
                        {else}
                            {translate}question_action_test_query{/translate}
                        {/if} 
                        (<span id="attemptsCount">{$Question.possible_attempts}</span>)
                        </span>
                    </button>
                {else}
                    <button class="button gray">
                        {translate}question_maximum_attempts_used{/translate}
                    </button>
                {/if}
                {if $Question.next_question_id}
                    <a href="/{$Lang}/test/{$TestId}/question/{$Question.next_question_id}" title="Mext task" class="button green{if {$Question.possible_attempts} > 0} hidden{/if}" id="nextQuestionBtn">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                        </svg>
                        <span>
                            {translate}question_action_next{/translate}
                        </span>
                    </a>
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
                        document.getElementById('test-timer-time').innerText = (hours > 0 ? `${ldelim}hours{rdelim} ` + (hours === 1 ? 'hour ': 'hours ') :'') + minutes + ' min';
                    {rdelim} else {ldelim}
                        document.getElementById('test-timer').innerText = '{translate}test_time_over{/translate}'
                    {rdelim}
                {rdelim};
                showTimer();
                setInterval(showTimer,  60000);
            </script>
            <div class="column" id="right-panel">
                {include file="{$Lang}/{$DB}.tpl"}
            </div> 
        </main3>
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>
