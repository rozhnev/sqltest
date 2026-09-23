<div class="interview-progress">
    <span>Meridian Logistics &middot; {$InterviewSession.position_label|escape} &middot; {$InterviewSession.grade_label|escape}</span>
    <span>Вопрос {$InterviewQuestion.sequence} из {$InterviewQuestion.questions_count}</span>
</div>
<div class="interview-progress-bar"><span style="width: {$InterviewProgressPercent}%;"></span></div>

{if $InterviewQuestion.question_type == 'query'}
    <div class="interview-dialog">
        <div class="dialog-row">
            <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Дэниел Парк">
            <div class="dialog-message">
                <p class="dialog-author">Дэниел Парк, ведущий SQL-разработчик</p>
                <div class="dialog-bubble">
                    {if $InterviewQuestion.query_number == 1}
                        <p>Здравствуйте! Я Дэниел, веду в Meridian Logistics команду SQL-разработки. Елена попросила меня провести практическую часть — теперь проверим ваши знания SQL в деле.</p>
                        <p>Задачи решаются на настоящей базе данных: запрос можно запускать кнопкой «Выполнить» сколько угодно раз и смотреть на результат, но засчитывается первая отправка ответа. Не торопитесь — я подожду.</p>
                    {else}
                        <p>Отлично, двигаемся дальше. Вот следующая задача — как и раньше, сначала запустите запрос и проверьте результат, а потом отправляйте.</p>
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
        <p class="question-action">Отметьте все правильные ответы.</p>
    {elseif $InterviewQuestion.question_type == 'free_answer'}
        <p class="question-action">Напишите ответ в свободной форме.</p>
    {else}
        <p class="question-action">Напишите запрос, решающий задачу.</p>
    {/if}
</div>

<div class="question-wrapper">
    {if $InterviewQuestion.question_type == 'free_answer'}
        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" maxlength="4000" placeholder="Ваш ответ..."></textarea>
    {elseif $InterviewQuestion.question_type == 'query'}
        <div class="code-wrapper" id="sql-code"></div>
    {/if}
    {if $InterviewQuestion.question_type != 'query'}
        <p class="question-action" style="font-size: 0.9em;">Ответ засчитывается с первой отправки — как на настоящем собеседовании.</p>
    {/if}
    <div class="code-buttons">
        {if $InterviewQuestion.question_type == 'query'}
            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                <i class="run-query-icon"></i>
                <span>Выполнить</span>
            </button>
        {/if}
        <button class="button green" id="interviewSubmitBtn"
                data-url="/{$Lang}/interview/{$InterviewSession.id}/answer"
                data-question-id="{$QuestionID}"
                data-error-text="Что-то пошло не так. Попробуйте ещё раз."
                onClick="submitInterviewAnswer(this)">
            <i class="run-icon"></i>
            <span>Отправить ответ</span>
        </button>
    </div>
</div>

<div class="question-wrapper">
    <div class="code-result ace-xcode" id="code-result"></div>
</div>

{if $DBDescription}
    <details class="question-wrapper">
        <summary>Описание базы данных</summary>
        {include file=$DBDescription}
    </details>
{/if}
