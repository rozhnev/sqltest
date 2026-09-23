<div class="interview-progress">
    <span>Meridian Logistics &middot; {$InterviewSession.position_label|escape} &middot; {$InterviewSession.grade_label|escape}</span>
    <span>Question {$InterviewQuestion.sequence} of {$InterviewQuestion.questions_count}</span>
</div>
<div class="interview-progress-bar"><span style="width: {$InterviewProgressPercent}%;"></span></div>

{if $InterviewQuestion.question_type == 'query'}
    <div class="interview-dialog">
        <div class="dialog-row">
            <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
            <div class="dialog-message">
                <p class="dialog-author">Daniel Park, Lead SQL Developer</p>
                <div class="dialog-bubble">
                    {if $InterviewQuestion.query_number == 1}
                        <p>Hi! I'm Daniel, I lead the SQL development team at Meridian Logistics. Elena asked me to run the practical part — now let's see your SQL skills in action.</p>
                        <p>The tasks run against a real database: you can run your query with the "Run query" button as many times as you like and check the result, but only your first submitted answer counts. Take your time — I'll wait.</p>
                    {else}
                        <p>Great, let's keep going. Here's the next task — as before, run your query and check the result first, then submit.</p>
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/if}

<div class="question-wrapper">
    <div class="question-title-bar" style="display: flex;">
        <div class="question-title">
            <div class="question-level rate{$InterviewQuestion.rate}" title="{$InterviewQuestion.question_rate|escape}" style="margin-top: 3px;"></div>
            <span>{$InterviewQuestion.title|escape}</span>
        </div>
    </div>
    <div class="question">{$InterviewQuestion.task}</div>
    {if $InterviewQuestion.question_type == 'answer'}
        <div class="answers" id="answers-list">
        {foreach $InterviewQuestion.answers as $answer}
            <div class="answer">
                <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}">
                <label for="answer-{$answer.id}"> {$answer.answer}</label>
            </div>
        {/foreach}
        </div>
        <p class="question-action">Mark all correct answers.</p>
    {elseif $InterviewQuestion.question_type == 'free_answer'}
        <p class="question-action">Write your answer in free form.</p>
    {else}
        <p class="question-action">Write a query that solves the task.</p>
    {/if}
</div>

<div class="question-wrapper">
    {if $InterviewQuestion.question_type == 'free_answer'}
        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" maxlength="4000" placeholder="Your answer..."></textarea>
    {elseif $InterviewQuestion.question_type == 'query'}
        <div class="code-wrapper" id="sql-code"></div>
    {/if}
    {if $InterviewQuestion.question_type != 'query'}
        <p class="question-action" style="font-size: 0.9em;">Your first submission counts — just like in a real interview.</p>
    {/if}
    <div class="code-buttons">
        {if $InterviewQuestion.question_type == 'query'}
            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                <i class="run-query-icon"></i>
                <span>Run query</span>
            </button>
        {/if}
        <button class="button green" id="interviewSubmitBtn"
                data-url="/{$Lang}/interview/{$InterviewSession.id}/answer"
                data-question-id="{$QuestionID}"
                data-error-text="Something went wrong. Please try again."
                onClick="submitInterviewAnswer(this)">
            <i class="run-icon"></i>
            <span>Submit answer</span>
        </button>
    </div>
</div>

<div class="question-wrapper">
    <div class="code-result ace-xcode" id="code-result"></div>
</div>

{if $DBDescription}
    <details class="question-wrapper">
        <summary>Database description</summary>
        {include file=$DBDescription}
    </details>
{/if}
