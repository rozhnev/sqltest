<div {if !$MobileView}class="solutions"{/if}>
    {if $User->logged()}
        {if $QuestionSolutions}
            <div class="solutions-title">{translate}my_solutions_title{/translate}</div><br>
            {foreach $QuestionSolutions as $id=>$solution}
                <div class="solution-wrapper" id="solution-wrapper-{$id}">
                    <div class="solution-title">{translate}solution_title{/translate}: {$solution.created_at} {translate}solution_query_cost{/translate}: {$solution.query_cost}</div>
                    <div class="solution-block" id="solution-{$id}">{$solution.query|escape:"html"}</div>
                    <div class="solution-footer">
                        <div class="likes-count" {if $solution.likes === 0}style="visibility: hidden;"{/if}>
                            {if $solution.likes > 0}
                                <span style="color: white" id="solution-likes-count-{$solution.id}">{$solution.likes}</span>
                                <span style="color: gold; cursor: pointer; font-size: x-large;">♦</span>
                            {/if}
                        </div>
                        <div style="display: flex; column-gap: 1rem;">
                            <button class="button green" onClick="solutionRun('{$Lang}', {$QuestionID}, {$id})">{translate}solution_action_run{/translate}</button>
                            <button 
                                class="button red" 
                                onClick="solutionDelete('{$Lang}', {$QuestionID}, {$solution.id})"
                            >
                                {translate}solution_action_delete{/translate}
                            </button>
                        </div>
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
    {translate}menu_small_add_placeholder{/translate}
</div>