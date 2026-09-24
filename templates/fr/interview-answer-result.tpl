{if !$AnswerResult.saved}
    <div class="interview-feedback">
        <p>
        {if $AnswerResult.error === 'empty'}
            Votre réponse est vide — écrivez quelque chose avant de l'envoyer.
        {elseif $AnswerResult.error === 'no_option'}
            Sélectionnez au moins une option.
        {elseif $AnswerResult.error === 'llm_unavailable'}
            Nous n'avons pas pu évaluer votre réponse pour le moment. Réessayez dans une minute — cette tentative n'a pas été décomptée.
        {else}
            Cette question n'est plus active.
            <a href="/{$Lang}/interview/{$SessionId}/question">Aller à la question en cours</a>
        {/if}
        </p>
    </div>
{else}
    {assign var="check" value=$AnswerResult.check}
    {assign var="feedback" value=$AnswerResult.feedback}
    <div class="interview-feedback {if $AnswerResult.correct}correct{elseif !$AnswerResult.final}retry{else}wrong{/if}">
        <p class="verdict">
            {if $AnswerResult.correct}✓ Réponse acceptée{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {elseif !$AnswerResult.final}Presque ! Tentative {$AnswerResult.attempt} sur {$AnswerResult.maxAttempts}
            {else}✗ Réponse incorrecte{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {/if}
        </p>
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>La requête est vide.</p>
            {/if}
            {if isset($check.hints.queryError)}
                <p>La requête a renvoyé une erreur : <span class="sql_error">{$check.hints.queryError|escape}</span></p>
            {/if}
            {* Detailed diagnostics would give the answer away while a retry is still open. *}
            {if $AnswerResult.final && !$feedback}
                {if isset($check.hints.wrongQueryHints)}
                    {foreach $check.hints.wrongQueryHints as $hint}
                        {if $hint}<p>{$hint}</p>{/if}
                    {/foreach}
                {/if}
                {if isset($check.hints.multipleResults)}
                    <p>La requête a renvoyé plusieurs jeux de résultats ; un seul est attendu.</p>
                {/if}
                {if isset($check.hints.columnsCount)}
                    <p>Le résultat doit comporter {$check.hints.columnsCount} colonnes.</p>
                {/if}
                {if isset($check.hints.columnsList)}
                    <p>Colonnes attendues : {$check.hints.columnsList}.</p>
                {/if}
                {if isset($check.hints.rowsCount)}
                    <p>Le résultat doit comporter {$check.hints.rowsCount} lignes.</p>
                {/if}
                {if isset($check.hints.rowsData)}
                    <p>La ligne {$check.hints.rowsData.rowNumber} devrait être :</p>
                    {$check.hints.rowsData.rowTable}
                    <p>Votre résultat :</p>
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
                            <p><em>Corrigez votre réponse et envoyez-la à nouveau.</em></p>
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
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">Question suivante</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">Terminer et voir le résultat</a>
            {/if}
        </p>
    {/if}
{/if}
