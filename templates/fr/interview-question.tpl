<div class="interview-progress">
    <span>Meridian Logistics &middot; {$InterviewSession.position_label|escape} &middot; {$InterviewSession.grade_label|escape}</span>
    <span>Question {$InterviewQuestion.sequence} sur {$InterviewQuestion.questions_count}</span>
</div>
<div class="interview-progress-bar"><span style="width: {$InterviewProgressPercent}%;"></span></div>

{* On a retry Daniel's reaction to the previous attempt (below) replaces the intro. *}
{if $InterviewQuestion.question_type == 'query' && $InterviewQuestion.attempt_number == 1}
    <div class="interview-dialog">
        <div class="dialog-row">
            <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
            <div class="dialog-message">
                <p class="dialog-author">Daniel Park, développeur SQL principal</p>
                <div class="dialog-bubble">
                    {if $InterviewQuestion.query_number == 1}
                        <p>Bonjour ! Je suis Daniel, je dirige l'équipe de développement SQL chez Meridian Logistics. Elena m'a demandé de mener la partie pratique — voyons maintenant vos compétences SQL en action.</p>
                        <p>Les tâches s'exécutent sur une vraie base de données : vous pouvez lancer votre requête avec le bouton « Exécuter » autant de fois que vous le souhaitez et vérifier le résultat. Envoyez votre réponse quand vous êtes sûr de vous. Si votre solution est proche, je vous indiquerai où se trouve l'erreur et vous aurez une nouvelle tentative. Prenez votre temps — j'attends.</p>
                    {else}
                        <p>Parfait, continuons. Voici la tâche suivante — comme précédemment, exécutez d'abord votre requête et vérifiez le résultat, puis envoyez-la.</p>
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
        <p class="question-action">Cochez toutes les bonnes réponses.</p>
    {elseif $InterviewQuestion.question_type == 'free_answer'}
        <p class="question-action">Rédigez votre réponse librement.</p>
    {else}
        <p class="question-action">Écrivez une requête qui résout la tâche.</p>
    {/if}
</div>

<div class="question-wrapper">
    {if $InterviewQuestion.question_type == 'free_answer'}
        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" maxlength="4000" placeholder="Votre réponse...">{$InterviewQuestion.answer_text|escape}</textarea>
    {elseif $InterviewQuestion.question_type == 'query'}
        <div class="code-wrapper" id="sql-code">{$InterviewQuestion.last_query|escape}</div>
    {/if}
    {if $InterviewQuestion.question_type != 'query' && $InterviewQuestion.attempt_number == 1}
        <p class="question-action" style="font-size: 0.9em;">Comme dans un vrai entretien : si votre réponse est proche, le recruteur vous donnera un indice et une nouvelle tentative.</p>
    {/if}
    <div class="code-buttons">
        {if $InterviewQuestion.question_type == 'query'}
            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                <i class="run-query-icon"></i>
                <span>Exécuter</span>
            </button>
        {/if}
        <button class="button green" id="interviewSubmitBtn"
                data-url="/{$Lang}/interview/{$InterviewSession.id}/answer"
                data-question-id="{$QuestionID}"
                data-error-text="Une erreur s'est produite. Veuillez réessayer."
                onClick="submitInterviewAnswer(this)">
            <i class="run-icon"></i>
            <span>Envoyer la réponse</span>
        </button>
    </div>
    <div id="interview-answer-feedback">
        {if $InterviewQuestion.attempt_number > 1 && $InterviewQuestion.llm_feedback}
            <div class="interview-feedback retry">
                <p class="verdict">Presque ! Tentative {$InterviewQuestion.attempt_number} sur {$InterviewQuestion.max_attempts}</p>
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
                            <p><em>Corrigez votre réponse et envoyez-la à nouveau.</em></p>
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
                    <p class="dialog-author">{if $InterviewQuestion.question_type == 'query'}Daniel est en train d'écrire…{else}Elena est en train d'écrire…{/if}</p>
                    <div class="dialog-bubble"><span class="typing-dots" aria-label="Le recruteur est en train d'écrire une réponse"><span></span><span></span><span></span></span></div>
                </div>
            </div>
        </div>
    </template>
</div>

<div class="question-wrapper">
    <div class="code-result ace-xcode" id="code-result"></div>
</div>

