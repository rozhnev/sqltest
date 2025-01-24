<div {if !$MobileView}style="width: 21vw;"{/if}>
    {if $User->logged()}
        {if $QuestionSolutions}
            <div class="question-title">{translate}my_solutions_title{/translate}</div><br>
            {foreach $QuestionSolutions as $id=>$solution}
                <div class="solution-wrapper" id="solution-wrapper-{$id}">
                    <div class="solution-title">{translate}solution_title{/translate}: {$solution.created_at} {translate}solution_query_cost{/translate}: {$solution.query_cost}</div>
                    <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
                    <div class="solution-footer">
                    <button class="button-small green" onClick="solutionRun('{$Lang}', {$QuestionID}, {$id})">{translate}solution_action_run{/translate}</button>
                        <button 
                            class="button-small red" 
                            onClick="solutionDelete('{$Lang}', {$QuestionID}, {$solution.id})"
                        >
                            {translate}solution_action_delete{/translate}
                        </button>
                    </div>
                </div>
            {/foreach}
        {else}
            <div class="solution-wrapper">
                <div style="padding: 2em;">
                    <p>{translate}no_solutions_yet{/translate}</p>
                </div>
            </div>
        {/if}
    {else}
        <div class="solution-wrapper">
            <div style="padding: 2em;">
                <p>{translate}login_needed{/translate}</p>
            </div>
        </div>
    {/if}
</div>