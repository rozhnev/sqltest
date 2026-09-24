{capture name="interviewer_question"}
    <p>Olá! Sou Elena Cho, diretora de Dados e Engenharia da Meridian Logistics. Obrigada por se candidatar à vaga de {$InterviewSession.position_label|escape}, nível {$InterviewSession.grade_label|escape}.</p>
    <p>Antes das perguntas, conte um pouco sobre você: qual é a sua experiência com SQL, com que tipos de tarefas e bancos de dados já trabalhou e do que mais gosta nesse trabalho?</p>
{/capture}
{capture name="elena_avatar"}<img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">{/capture}
{capture name="typing_row"}
    {* Shown on submit while the page waits for the reply (interview-session.tpl script). *}
    <div class="dialog-row" id="interviewer-typing" hidden>
        {$smarty.capture.elena_avatar}
        <div class="dialog-message">
            <p class="dialog-author">Elena Cho está digitando…</p>
            <div class="dialog-bubble"><span class="typing-dots" aria-label="Elena está digitando uma resposta"><span></span><span></span><span></span></span></div>
        </div>
    </div>
{/capture}
{assign var="status" value=$InterviewSession.status}
{assign var="analysis" value=$InterviewSession.self_intro_analysis|default:[]}
{assign var="followupQuestion" value=$analysis.followup_question|default:''}
<div class="interview-session-box lesson-wrapper">
    {if $status === 'intro' || $status === 'intro_followup' || $status === 'in_progress'}
        <h2>Entrevista na Meridian Logistics</h2>
        <div class="interview-dialog">
            <div class="dialog-row">
                {$smarty.capture.elena_avatar}
                <div class="dialog-message">
                    <p class="dialog-author">Elena Cho, diretora de Dados e Engenharia</p>
                    <div class="dialog-bubble">{$smarty.capture.interviewer_question}</div>
                </div>
            </div>
            <div class="dialog-row candidate">
                <div class="dialog-avatar candidate-avatar">Você</div>
                <div class="dialog-message">
                    <p class="dialog-author">Sua resposta</p>
                    {if $status === 'intro'}
                        <form method="post" class="dialog-bubble">
                            <textarea name="self_intro" required maxlength="4000" aria-label="Fale sobre você" placeholder="Por exemplo: trabalho com SQL há 2 anos, principalmente escrevendo relatórios e otimizando consultas lentas..."></textarea>
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
                                <p>Obrigada por falar sobre você! Vamos às perguntas.</p>
                            {/if}
                            {if $followupQuestion}
                                <p class="followup-question">{$followupQuestion|escape}</p>
                            {/if}
                        </div>
                    </div>
                </div>
                {if $followupQuestion}
                    <div class="dialog-row candidate">
                        <div class="dialog-avatar candidate-avatar">Você</div>
                        <div class="dialog-message">
                            <p class="dialog-author">Sua resposta</p>
                            {if $status === 'intro_followup'}
                                <form method="post" class="dialog-bubble">
                                    <textarea name="followup_answer" required maxlength="4000" aria-label="Resposta à pergunta da Elena" placeholder="Sua resposta..."></textarea>
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
                                <div class="dialog-bubble"><p>Obrigada, isso me ajuda a entender melhor a sua experiência. Agora vamos às perguntas.</p></div>
                            </div>
                        </div>
                    {/if}
                {/if}
            {/if}
        </div>
        {if $status === 'in_progress'}
            <p class="dialog-next">
                <a class="button blue" href="/{$Lang}/interview/{$InterviewSession.id}/question">Ir para as perguntas</a>
            </p>
        {/if}
    {else}
        <h2>Status da sessão: {$status|escape}</h2>
        <p>Cargo: {$InterviewSession.position_label|escape}, nível: {$InterviewSession.grade_label|escape}</p>
    {/if}
</div>
