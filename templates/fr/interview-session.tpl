{capture name="interviewer_question"}
    <p>Bonjour ! Je suis Elena Cho, directrice Données et Ingénierie chez Meridian Logistics. Merci d'avoir postulé au poste de {$InterviewSession.position_label|escape}, niveau {$InterviewSession.grade_label|escape}.</p>
    <p>Avant de passer aux questions, parlez-moi un peu de vous : quelle est votre expérience de SQL, sur quels types de tâches et de bases de données avez-vous travaillé, et qu'est-ce qui vous plaît le plus dans ce travail ?</p>
{/capture}
{capture name="elena_avatar"}<img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">{/capture}
{capture name="typing_row"}
    {* Shown on submit while the page waits for the reply (interview-session.tpl script). *}
    <div class="dialog-row" id="interviewer-typing" hidden>
        {$smarty.capture.elena_avatar}
        <div class="dialog-message">
            <p class="dialog-author">Elena Cho est en train d'écrire…</p>
            <div class="dialog-bubble"><span class="typing-dots" aria-label="Elena est en train d'écrire une réponse"><span></span><span></span><span></span></span></div>
        </div>
    </div>
{/capture}
{assign var="status" value=$InterviewSession.status}
{assign var="analysis" value=$InterviewSession.self_intro_analysis|default:[]}
{assign var="followupQuestion" value=$analysis.followup_question|default:''}
<div class="interview-session-box lesson-wrapper">
    {if $status === 'intro' || $status === 'intro_followup' || $status === 'in_progress'}
        <h2>Entretien chez Meridian Logistics</h2>
        <div class="interview-dialog">
            <div class="dialog-row">
                {$smarty.capture.elena_avatar}
                <div class="dialog-message">
                    <p class="dialog-author">Elena Cho, directrice Données et Ingénierie</p>
                    <div class="dialog-bubble">{$smarty.capture.interviewer_question}</div>
                </div>
            </div>
            <div class="dialog-row candidate">
                <div class="dialog-avatar candidate-avatar">Vous</div>
                <div class="dialog-message">
                    <p class="dialog-author">Votre réponse</p>
                    {if $status === 'intro'}
                        <form method="post" class="dialog-bubble">
                            <textarea name="self_intro" required maxlength="4000" aria-label="Parlez-nous de vous" placeholder="Par exemple : je travaille avec SQL depuis 2 ans, surtout sur des rapports et l'optimisation de requêtes lentes..."></textarea>
                            {if $SelfIntroError}
                                <p class="error-text">{$SelfIntroError|escape}</p>
                            {/if}
                            <div class="dialog-actions">
                                <button type="submit" class="button blue">Envoyer</button>
                            </div>
                        </form>
                    {else}
                        <div class="dialog-bubble"><p class="pre-wrap">{$InterviewSession.self_intro|escape}</p></div>
                    {/if}
                </div>
            </div>
            {if $status === 'intro'}
                {$smarty.capture.typing_row}
            {else}
                <div class="dialog-row">
                    {$smarty.capture.elena_avatar}
                    <div class="dialog-message">
                        <p class="dialog-author">Elena Cho</p>
                        <div class="dialog-bubble">
                            {if $analysis.interviewer_message|default:''}
                                <p class="pre-wrap">{$analysis.interviewer_message|escape}</p>
                            {elseif !$followupQuestion}
                                <p>Merci de vous être présenté ! Passons aux questions.</p>
                            {/if}
                            {if $followupQuestion}
                                <p class="followup-question">{$followupQuestion|escape}</p>
                            {/if}
                        </div>
                    </div>
                </div>
                {if $followupQuestion}
                    <div class="dialog-row candidate">
                        <div class="dialog-avatar candidate-avatar">Vous</div>
                        <div class="dialog-message">
                            <p class="dialog-author">Votre réponse</p>
                            {if $status === 'intro_followup'}
                                <form method="post" class="dialog-bubble">
                                    <textarea name="followup_answer" required maxlength="4000" aria-label="Réponse à la question d'Elena" placeholder="Votre réponse..."></textarea>
                                    {if $SelfIntroError}
                                        <p class="error-text">{$SelfIntroError|escape}</p>
                                    {/if}
                                    <div class="dialog-actions">
                                        <button type="submit" class="button blue">Envoyer</button>
                                    </div>
                                </form>
                            {else}
                                <div class="dialog-bubble"><p class="pre-wrap">{$analysis.followup.answer|default:''|escape}</p></div>
                            {/if}
                        </div>
                    </div>
                    {if $status === 'intro_followup'}
                        {$smarty.capture.typing_row}
                    {else}
                        <div class="dialog-row">
                            {$smarty.capture.elena_avatar}
                            <div class="dialog-message">
                                <p class="dialog-author">Elena Cho</p>
                                <div class="dialog-bubble"><p>Merci, cela m'aide à mieux comprendre votre expérience. Passons maintenant aux questions.</p></div>
                            </div>
                        </div>
                    {/if}
                {/if}
            {/if}
        </div>
        {if $status === 'in_progress'}
            <p class="dialog-next">
                <a class="button blue" href="/{$Lang}/interview/{$InterviewSession.id}/question">Passer aux questions</a>
            </p>
        {/if}
    {else}
        <h2>Statut de la session : {$status|escape}</h2>
        <p>Poste : {$InterviewSession.position_label|escape}, niveau : {$InterviewSession.grade_label|escape}</p>
    {/if}
</div>
