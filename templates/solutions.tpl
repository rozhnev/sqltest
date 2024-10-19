<div style="width: 21vw;">
    {if $QuestionSolutions}
        <p>{translate}solutions_title{/translate}</p>
        {foreach $QuestionSolutions as $id=>$solution}
            <div class="solution-wrapper" id="solution-wrapper-{$id}">
                <div class="solution-title">{translate}solution_title{/translate}: {$solution.created_at} {translate}solution_query_cost{/translate}: {$solution.query_cost}</div>
                <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
                <div class="solution-footer">
                    <button class="button-small green" onClick="solutionRun('en', {$QuestionID}, {$id})">Run it</button>
                    {* <button class="button-small green" onClick="solutionLike({$solution.id})">Like it! ({$solution.likes})</button>
                    <button class="button-small yellow" onClick="solutionDislike({$solution.id})">Dislike ({$solution.dislikes})</button> *}
                    <button class="button-small red" onClick="solutionReport('en', {$QuestionID}, {$solution.id})">Wrong solution!</button>
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
</div>