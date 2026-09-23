{if !$AnswerResult.saved}
    <div class="interview-feedback">
        <p>
        {if $AnswerResult.error === 'empty'}
            Your answer is empty — please write something before submitting.
        {elseif $AnswerResult.error === 'no_option'}
            Select at least one option.
        {elseif $AnswerResult.error === 'llm_unavailable'}
            We couldn't evaluate your answer right now. Please submit again in a minute — this attempt wasn't used up.
        {elseif $AnswerResult.error === 'rate_limit'}
            Too many requests. Please try again later.
        {else}
            This question is no longer active.
            <a href="/{$Lang}/interview/{$SessionId}/question">Go to the current question</a>
        {/if}
        </p>
    </div>
{else}
    {assign var="check" value=$AnswerResult.check}
    <div class="interview-feedback {if $AnswerResult.correct}correct{else}wrong{/if}">
        <p class="verdict">{if $AnswerResult.correct}✓ Answer accepted{else}✗ Incorrect answer{/if}</p>
        {if $AnswerResult.questionType === 'free_answer' && $check.comment}
            <p>{$check.comment|escape}</p>
        {/if}
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>The query is empty.</p>
            {/if}
            {if isset($check.hints.wrongQueryHints)}
                {foreach $check.hints.wrongQueryHints as $hint}
                    {if $hint}<p>{$hint}</p>{/if}
                {/foreach}
            {/if}
            {if isset($check.hints.queryError)}
                <p>The query returned an error: <span class="sql_error">{$check.hints.queryError|escape}</span></p>
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
        <p style="margin-top: 1rem;">
            {if $AnswerResult.nextQuestionId}
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">Next question</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">Finish and see the result</a>
            {/if}
        </p>
    </div>
{/if}
