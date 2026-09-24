{capture name="interviewer_question"}
    <p>¡Hola! Soy Elena Cho, directora de Datos e Ingeniería en Meridian Logistics. Gracias por postularte al puesto de {$InterviewSession.position_label|escape}, nivel {$InterviewSession.grade_label|escape}.</p>
    <p>Antes de pasar a las preguntas, cuéntame un poco sobre ti: ¿qué experiencia tienes con SQL, con qué tipos de tareas y bases de datos has trabajado y qué es lo que más te gusta de este trabajo?</p>
{/capture}
{capture name="elena_avatar"}<img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">{/capture}
{capture name="typing_row"}
    {* Shown on submit while the page waits for the reply (interview-session.tpl script). *}
    <div class="dialog-row" id="interviewer-typing" hidden>
        {$smarty.capture.elena_avatar}
        <div class="dialog-message">
            <p class="dialog-author">Elena Cho está escribiendo…</p>
            <div class="dialog-bubble"><span class="typing-dots" aria-label="Elena está escribiendo una respuesta"><span></span><span></span><span></span></span></div>
        </div>
    </div>
{/capture}
{assign var="status" value=$InterviewSession.status}
{assign var="analysis" value=$InterviewSession.self_intro_analysis|default:[]}
{assign var="followupQuestion" value=$analysis.followup_question|default:''}
<div class="interview-session-box lesson-wrapper">
    {if $status === 'intro' || $status === 'intro_followup' || $status === 'in_progress'}
        <h2>Entrevista en Meridian Logistics</h2>
        <div class="interview-dialog">
            <div class="dialog-row">
                {$smarty.capture.elena_avatar}
                <div class="dialog-message">
                    <p class="dialog-author">Elena Cho, directora de Datos e Ingeniería</p>
                    <div class="dialog-bubble">{$smarty.capture.interviewer_question}</div>
                </div>
            </div>
            <div class="dialog-row candidate">
                <div class="dialog-avatar candidate-avatar">Tú</div>
                <div class="dialog-message">
                    <p class="dialog-author">Tu respuesta</p>
                    {if $status === 'intro'}
                        <form method="post" class="dialog-bubble">
                            <textarea name="self_intro" required maxlength="4000" aria-label="Háblanos de ti" placeholder="Por ejemplo: trabajo con SQL desde hace 2 años, sobre todo escribiendo informes y optimizando consultas lentas..."></textarea>
                            {if $SelfIntroError}
                                <p class="error-text">{$SelfIntroError|escape}</p>
                            {/if}
                            <div class="dialog-actions">
                                <button type="submit" class="button blue">Enviar</button>
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
                                <p>¡Gracias por hablarme de ti! Pasemos a las preguntas.</p>
                            {/if}
                            {if $followupQuestion}
                                <p class="followup-question">{$followupQuestion|escape}</p>
                            {/if}
                        </div>
                    </div>
                </div>
                {if $followupQuestion}
                    <div class="dialog-row candidate">
                        <div class="dialog-avatar candidate-avatar">Tú</div>
                        <div class="dialog-message">
                            <p class="dialog-author">Tu respuesta</p>
                            {if $status === 'intro_followup'}
                                <form method="post" class="dialog-bubble">
                                    <textarea name="followup_answer" required maxlength="4000" aria-label="Respuesta a la pregunta de Elena" placeholder="Tu respuesta..."></textarea>
                                    {if $SelfIntroError}
                                        <p class="error-text">{$SelfIntroError|escape}</p>
                                    {/if}
                                    <div class="dialog-actions">
                                        <button type="submit" class="button blue">Enviar</button>
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
                                <div class="dialog-bubble"><p>Gracias, eso me ayuda a entender mejor tu experiencia. Ahora pasemos a las preguntas.</p></div>
                            </div>
                        </div>
                    {/if}
                {/if}
            {/if}
        </div>
        {if $status === 'in_progress'}
            <p class="dialog-next">
                <a class="button blue" href="/{$Lang}/interview/{$InterviewSession.id}/question">Ir a las preguntas</a>
            </p>
        {/if}
    {else}
        <h2>Estado de la sesión: {$status|escape}</h2>
        <p>Puesto: {$InterviewSession.position_label|escape}, nivel: {$InterviewSession.grade_label|escape}</p>
    {/if}
</div>
