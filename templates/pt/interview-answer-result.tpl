{if !$AnswerResult.saved}
    <div class="interview-feedback">
        <p>
        {if $AnswerResult.error === 'empty'}
            Sua resposta está vazia — escreva algo antes de enviar.
        {elseif $AnswerResult.error === 'no_option'}
            Selecione pelo menos uma opção.
        {elseif $AnswerResult.error === 'llm_unavailable'}
            Não foi possível avaliar sua resposta agora. Envie novamente em um minuto — esta tentativa não foi contada.
        {else}
            Esta pergunta não está mais ativa.
            <a href="/{$Lang}/interview/{$SessionId}/question">Ir para a pergunta atual</a>
        {/if}
        </p>
    </div>
{else}
    {assign var="check" value=$AnswerResult.check}
    {assign var="feedback" value=$AnswerResult.feedback}
    <div class="interview-feedback {if $AnswerResult.correct}correct{elseif !$AnswerResult.final}retry{else}wrong{/if}">
        <p class="verdict">
            {if $AnswerResult.correct}✓ Resposta aceita{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {elseif !$AnswerResult.final}Quase! Tentativa {$AnswerResult.attempt} de {$AnswerResult.maxAttempts}
            {else}✗ Resposta incorreta{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {/if}
        </p>
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>A consulta está vazia.</p>
            {/if}
            {if isset($check.hints.queryError)}
                <p>A consulta retornou um erro: <span class="sql_error">{$check.hints.queryError|escape}</span></p>
            {/if}
            {* Detailed diagnostics would give the answer away while a retry is still open. *}
            {if $AnswerResult.final && !$feedback}
                {if isset($check.hints.wrongQueryHints)}
                    {foreach $check.hints.wrongQueryHints as $hint}
                        {if $hint}<p>{$hint}</p>{/if}
                    {/foreach}
                {/if}
                {if isset($check.hints.multipleResults)}
                    <p>A consulta retornou vários conjuntos de resultados; esperava-se apenas um.</p>
                {/if}
                {if isset($check.hints.columnsCount)}
                    <p>O resultado deve ter {$check.hints.columnsCount} colunas.</p>
                {/if}
                {if isset($check.hints.columnsList)}
                    <p>Colunas esperadas: {$check.hints.columnsList}.</p>
                {/if}
                {if isset($check.hints.rowsCount)}
                    <p>O resultado deve ter {$check.hints.rowsCount} linhas.</p>
                {/if}
                {if isset($check.hints.rowsData)}
                    <p>A linha {$check.hints.rowsData.rowNumber} deveria ser:</p>
                    {$check.hints.rowsData.rowTable}
                    <p>Seu resultado:</p>
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
                            <p><em>Corrija a resposta e envie de novo.</em></p>
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
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">Próxima pergunta</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">Concluir e ver o resultado</a>
            {/if}
        </p>
    {/if}
{/if}
