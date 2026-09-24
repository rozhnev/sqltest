<div class="interview-progress">
    <span>Meridian Logistics &middot; {$InterviewSession.position_label|escape} &middot; {$InterviewSession.grade_label|escape}</span>
    <span>Pregunta {$InterviewQuestion.sequence} de {$InterviewQuestion.questions_count}</span>
</div>
<div class="interview-progress-bar"><span style="width: {$InterviewProgressPercent}%;"></span></div>

{* On a retry Daniel's reaction to the previous attempt (below) replaces the intro. *}
{if $InterviewQuestion.question_type == 'query' && $InterviewQuestion.attempt_number == 1}
    <div class="interview-dialog">
        <div class="dialog-row">
            <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
            <div class="dialog-message">
                <p class="dialog-author">Daniel Park, desarrollador SQL principal</p>
                <div class="dialog-bubble">
                    {if $InterviewQuestion.query_number == 1}
                        <p>¡Hola! Soy Daniel, dirijo el equipo de desarrollo SQL en Meridian Logistics. Elena me ha pedido que lleve la parte práctica: ahora veamos tus habilidades de SQL en acción.</p>
                        <p>Las tareas se ejecutan sobre una base de datos real: puedes ejecutar tu consulta con el botón «Ejecutar» tantas veces como quieras y revisar el resultado. Envía tu respuesta cuando estés seguro. Si tu solución se acerca, te indicaré dónde está el error y te daré otro intento. Tómate tu tiempo, yo espero.</p>
                    {else}
                        <p>Genial, sigamos. Aquí está la siguiente tarea: como antes, ejecuta primero tu consulta y revisa el resultado, y después envíala.</p>
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
        <p class="question-action">Marca todas las respuestas correctas.</p>
    {elseif $InterviewQuestion.question_type == 'free_answer'}
        <p class="question-action">Escribe tu respuesta con tus propias palabras.</p>
    {else}
        <p class="question-action">Escribe una consulta que resuelva la tarea.</p>
    {/if}
</div>

<div class="question-wrapper">
    {if $InterviewQuestion.question_type == 'free_answer'}
        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" maxlength="4000" placeholder="Tu respuesta...">{$InterviewQuestion.answer_text|escape}</textarea>
    {elseif $InterviewQuestion.question_type == 'query'}
        <div class="code-wrapper" id="sql-code">{$InterviewQuestion.last_query|escape}</div>
    {/if}
    {if $InterviewQuestion.question_type != 'query' && $InterviewQuestion.attempt_number == 1}
        <p class="question-action" style="font-size: 0.9em;">Como en una entrevista real: si tu respuesta se acerca, el entrevistador te dará una pista y otro intento.</p>
    {/if}
    <div class="code-buttons">
        {if $InterviewQuestion.question_type == 'query'}
            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                <i class="run-query-icon"></i>
                <span>Ejecutar</span>
            </button>
        {/if}
        <button class="button green" id="interviewSubmitBtn"
                data-url="/{$Lang}/interview/{$InterviewSession.id}/answer"
                data-question-id="{$QuestionID}"
                data-error-text="Algo salió mal. Inténtalo de nuevo."
                onClick="submitInterviewAnswer(this)">
            <i class="run-icon"></i>
            <span>Enviar respuesta</span>
        </button>
    </div>
    <div id="interview-answer-feedback">
        {if $InterviewQuestion.attempt_number > 1 && $InterviewQuestion.llm_feedback}
            <div class="interview-feedback retry">
                <p class="verdict">¡Casi! Intento {$InterviewQuestion.attempt_number} de {$InterviewQuestion.max_attempts}</p>
            </div>
            <div class="interview-dialog interview-reaction">
                <div class="dialog-row">
                    {if $InterviewQuestion.question_type == 'query'}
                        <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
                    {else}
                        <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                    {/if}
                    <div class="dialog-message">
                        <p class="dialog-author">{if $InterviewQuestion.question_type == 'query'}Daniel Park{else}Elena Cho{/if}</p>
                        <div class="dialog-bubble">
                            <p class="pre-wrap">{$InterviewQuestion.llm_feedback|escape}</p>
                            <p><em>Corrige tu respuesta y envíala de nuevo.</em></p>
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
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
                {else}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                {/if}
                <div class="dialog-message">
                    <p class="dialog-author">{if $InterviewQuestion.question_type == 'query'}Daniel está escribiendo…{else}Elena está escribiendo…{/if}</p>
                    <div class="dialog-bubble"><span class="typing-dots" aria-label="El entrevistador está escribiendo una respuesta"><span></span><span></span><span></span></span></div>
                </div>
            </div>
        </div>
    </template>
</div>

<div class="question-wrapper">
    <div class="code-result ace-xcode" id="code-result"></div>
</div>

