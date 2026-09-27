{if !$AnswerResult.saved}
    <div class="interview-feedback">
        <p>
        {if $AnswerResult.error === 'empty'}
            Your answer is empty — please write something before submitting.
        {elseif $AnswerResult.error === 'no_option'}
            Select at least one option.
        {elseif $AnswerResult.error === 'llm_unavailable'}
            We couldn't evaluate your answer right now. Please submit again in a minute — this attempt wasn't used up.
        {else}
            This question is no longer active.
            <a href="/{$Lang}/interview/{$SessionId}/question">Go to the current question</a>
        {/if}
        </p>
    </div>
{else}
    {assign var="check" value=$AnswerResult.check}
    {assign var="feedback" value=$AnswerResult.feedback}
    <div class="interview-feedback {if $AnswerResult.correct}correct{elseif !$AnswerResult.final}retry{else}wrong{/if}">
        <p class="verdict">
            {if $AnswerResult.correct}✓ Answer accepted{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {elseif !$AnswerResult.final}Almost! Attempt {$AnswerResult.attempt} of {$AnswerResult.maxAttempts}
            {else}✗ Incorrect answer{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {/if}
        </p>
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>The query is empty.</p>
            {/if}
            {if isset($check.hints.queryError)}
                <p>The query returned an error: <span class="sql_error">{$check.hints.queryError|escape}</span></p>
            {/if}
            {* Detailed diagnostics would give the answer away while a retry is still open. *}
            {if $AnswerResult.final && !$feedback}
                {if isset($check.hints.wrongQueryHints)}
                    {foreach $check.hints.wrongQueryHints as $hint}
                        {if $hint}<p>{$hint}</p>{/if}
                    {/foreach}
                {/if}
                {if isset($check.hints.multipleResults)}
                    <p>The query returned several result sets; one is expected.</p>
                {/if}
                {if isset($check.hints.columnsCount)}
                    <p>The result should have {$check.hints.columnsCount} columns.</p>
                {/if}
                {if isset($check.hints.columnsList)}
                    <p>Expected columns: {$check.hints.columnsList}.</p>
                {/if}
                {if isset($check.hints.rowsCount)}
                    <p>The result should have {$check.hints.rowsCount} rows.</p>
                {/if}
                {if isset($check.hints.rowsData)}
                    <p>Row {$check.hints.rowsData.rowNumber} should be:</p>
                    {$check.hints.rowsData.rowTable}
                    <p>Your result:</p>
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
                            <p><em>Fix your answer and submit it again.</em></p>
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
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">Next question</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">Finish and see the result</a>
            {/if}
        </p>
    {/if}
{/if}
