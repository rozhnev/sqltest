{* The last AI check of a free answer (user_questions.last_feedback), in the result area until the next check.
   Pass it as Feedback, with CheckedAt (the last attempt date). *}
<div class="free-answer-last-check">
    <div class="free-answer-last-check__title">
        {translate}free_answer_last_check{/translate}{if $CheckedAt} ({$CheckedAt}){/if}:
        <span class="free-answer-last-check__verdict{if !$Feedback.ok} failed{/if}">
            {if $Feedback.ok}{translate}free_answer_passed{/translate}{else}{translate}free_answer_not_passed{/translate}{/if}
        </span>
        {if $Feedback.score !== null}
            <span class="free-answer-last-check__score">{translate}free_answer_score{/translate}: {$Feedback.score}/100</span>
        {/if}
    </div>
    {if $Feedback.comment}
        <p>{$Feedback.comment|escape}</p>
    {/if}
</div>
