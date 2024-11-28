<div {if !$MobileView}style="width: 21vw;"{/if}>
    {if $User->logged()}
        {if !$QuestionSolved} 
            <div class="solution-wrapper">
                <div style="padding: 2em;">
                    <p>{translate}qustion_should_be_solved{/translate}</p>
                </div>
            </div>
        {elseif $QuestionSolutions}
            <p>{translate}solutions_title{/translate}</p>
            {foreach $QuestionSolutions as $id=>$solution}
                <div class="solution-wrapper" id="solution-wrapper-{$id}">
                    <div class="solution-title">{translate}solution_title{/translate}: {$solution.created_at} {translate}solution_query_cost{/translate}: {$solution.query_cost}</div>
                    <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
                    <div class="solution-footer">
                    <button class="button-small green" onClick="solutionRun('{$Lang}', {$QuestionID}, {$id})">{translate}solution_action_run{/translate}</button>
                        {* <button class="button-small green" onClick="solutionLike({$solution.id})">Like it! ({$solution.likes})</button>
                        <button class="button-small yellow" onClick="solutionDislike({$solution.id})">Dislike ({$solution.dislikes})</button> *}
                        <button class="button-small red" onClick="solutionReport('{$Lang}', {$QuestionID}, {$solution.id})">{translate}solution_action_report{/translate}</button>
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