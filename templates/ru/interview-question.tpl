<div class="interview-progress">
    <span>Meridian Logistics &middot; {$InterviewSession.position_label|escape} &middot; {$InterviewSession.grade_label|escape}</span>
    <span>Вопрос {$InterviewQuestion.sequence} из {$InterviewQuestion.questions_count}</span>
</div>
<div class="interview-progress-bar"><span style="width: {$InterviewProgressPercent}%;"></span></div>

{* On a retry Daniel's reaction to the previous attempt (below) replaces the intro. *}
{if $InterviewQuestion.question_type == 'query' && $InterviewQuestion.attempt_number == 1}
    <div class="interview-dialog">
        <div class="dialog-row">
            <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Дэниел Парк">
            <div class="dialog-message">
                <p class="dialog-author">Дэниел Парк, ведущий SQL-разработчик</p>
                <div class="dialog-bubble">
                    {if $InterviewQuestion.query_number == 1}
                        <p>Здравствуйте! Я Дэниел, веду в Meridian Logistics команду SQL-разработки. Елена попросила меня провести практическую часть — теперь проверим ваши знания SQL в деле.</p>
                        <p>Задачи решаются на настоящей базе данных: запрос можно запускать кнопкой «Выполнить» сколько угодно раз и смотреть на результат. Когда будете уверены — отправляйте ответ. Если решение окажется близким к верному, я подскажу, где ошибка, и дам ещё одну попытку. Не торопитесь — я подожду.</p>
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
                <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}"{if in_array($answer.id, $InterviewQuestion.selected_answers|default:[])} checked{/if}>
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
        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" maxlength="4000" placeholder="Ваш ответ...">{$InterviewQuestion.answer_text|escape}</textarea>
    {elseif $InterviewQuestion.question_type == 'query'}
        <div class="code-wrapper" id="sql-code">{$InterviewQuestion.last_query|escape}</div>
    {/if}
    {if $InterviewQuestion.question_type != 'query' && $InterviewQuestion.attempt_number == 1}
        <p class="question-action" style="font-size: 0.9em;">Как на настоящем собеседовании: если ответ будет близок к верному, интервьюер подскажет и даст ещё одну попытку.</p>
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
    <div id="interview-answer-feedback">
        {if $InterviewQuestion.attempt_number > 1 && $InterviewQuestion.llm_feedback}
            <div class="interview-feedback retry">
                <p class="verdict">Почти! Попытка {$InterviewQuestion.attempt_number} из {$InterviewQuestion.max_attempts}</p>
            </div>
            <div class="interview-dialog interview-reaction">
                <div class="dialog-row">
                    {if $InterviewQuestion.question_type == 'query'}
                        <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Дэниел Парк">
                    {else}
                        <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Елена Чо">
                    {/if}
                    <div class="dialog-message">
                        <p class="dialog-author">{if $InterviewQuestion.question_type == 'query'}Дэниел Парк{else}Елена Чо{/if}</p>
                        <div class="dialog-bubble">
                            <p class="pre-wrap">{$InterviewQuestion.llm_feedback|escape}</p>
                            <p><em>Исправьте ответ и отправьте ещё раз.</em></p>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
    {* Shown in #interview-answer-feedback while the answer is being checked (interview-question.tpl script). *}
    <template id="interviewer-typing">
        <div class="interview-dialog interview-reaction">
            <div class="dialog-row">
                {if $InterviewQuestion.question_type == 'query'}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Дэниел Парк">
                {else}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Елена Чо">
                {/if}
                <div class="dialog-message">
                    <p class="dialog-author">{if $InterviewQuestion.question_type == 'query'}Дэниел печатает…{else}Елена печатает…{/if}</p>
                    <div class="dialog-bubble"><span class="typing-dots" aria-label="Интервьюер печатает ответ"><span></span><span></span><span></span></span></div>
                </div>
            </div>
        </div>
    </template>
</div>

<div class="question-wrapper">
    <div class="code-result ace-xcode" id="code-result"></div>
</div>

