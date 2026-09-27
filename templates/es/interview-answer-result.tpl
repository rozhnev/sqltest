{if !$AnswerResult.saved}
    <div class="interview-feedback">
        <p>
        {if $AnswerResult.error === 'empty'}
            Tu respuesta está vacía: escribe algo antes de enviarla.
        {elseif $AnswerResult.error === 'no_option'}
            Selecciona al menos una opción.
        {elseif $AnswerResult.error === 'llm_unavailable'}
            No pudimos evaluar tu respuesta en este momento. Vuelve a enviarla dentro de un minuto: este intento no se ha gastado.
        {else}
            Esta pregunta ya no está activa.
            <a href="/{$Lang}/interview/{$SessionId}/question">Ir a la pregunta actual</a>
        {/if}
        </p>
    </div>
{else}
    {assign var="check" value=$AnswerResult.check}
    {assign var="feedback" value=$AnswerResult.feedback}
    <div class="interview-feedback {if $AnswerResult.correct}correct{elseif !$AnswerResult.final}retry{else}wrong{/if}">
        <p class="verdict">
            {if $AnswerResult.correct}✓ Respuesta aceptada{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {elseif !$AnswerResult.final}¡Casi! Intento {$AnswerResult.attempt} de {$AnswerResult.maxAttempts}
            {else}✗ Respuesta incorrecta{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {/if}
        </p>
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>La consulta está vacía.</p>
            {/if}
            {if isset($check.hints.queryError)}
                <p>La consulta devolvió un error: <span class="sql_error">{$check.hints.queryError|escape}</span></p>
            {/if}
            {* Detailed diagnostics would give the answer away while a retry is still open. *}
            {if $AnswerResult.final && !$feedback}
                {if isset($check.hints.wrongQueryHints)}
                    {foreach $check.hints.wrongQueryHints as $hint}
                        {if $hint}<p>{$hint}</p>{/if}
                    {/foreach}
                {/if}
                {if isset($check.hints.multipleResults)}
                    <p>La consulta devolvió varios conjuntos de resultados; se esperaba uno.</p>
                {/if}
                {if isset($check.hints.columnsCount)}
                    <p>El resultado debe tener {$check.hints.columnsCount} columnas.</p>
                {/if}
                {if isset($check.hints.columnsList)}
                    <p>Columnas esperadas: {$check.hints.columnsList}.</p>
                {/if}
                {if isset($check.hints.rowsCount)}
                    <p>El resultado debe tener {$check.hints.rowsCount} filas.</p>
                {/if}
                {if isset($check.hints.rowsData)}
                    <p>La fila {$check.hints.rowsData.rowNumber} debería ser:</p>
                    {$check.hints.rowsData.rowTable}
                    <p>Tu resultado:</p>
                    {$check.hints.rowsData.resultTable}
                {/if}
            {/if}
        {/if}
    </div>

    {if $feedback && ($feedback.comment || $feedback.hint)}
        <div class="interview-dialog interview-reaction">
            <div class="dialog-row">
                {if $AnswerResult.questionType === 'query'}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
                {else}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                {/if}
                <div class="dialog-message">
                    <p class="dialog-author">{if $AnswerResult.questionType === 'query'}Daniel Park{else}Elena Cho{/if}</p>
                    <div class="dialog-bubble">
                        {if !$AnswerResult.final}
                            <p class="pre-wrap">{$feedback.hint|default:$feedback.comment|escape}</p>
                            <p><em>Corrige tu respuesta y envíala de nuevo.</em></p>
                        {else}
                            <p class="pre-wrap">{$feedback.comment|default:$feedback.hint|escape}</p>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    {/if}

    {if $AnswerResult.final}
        <p class="interview-next">
            {if $AnswerResult.nextQuestionId}
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">Siguiente pregunta</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">Terminar y ver el resultado</a>
            {/if}
        </p>
    {/if}
{/if}
