<div {if !$MobileView}class="solutions"{/if}>
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
                    <div class="solution-block" id="solution-{$id}">{$solution.query|escape:"html"}</div>
                    <div class="solution-footer" style="display: flex; justify-content: space-between; align-items: center;">
                        <div class="likes-count">
                            <span style="color: white" id="solution-likes-count-{$solution.id}">{$solution.likes}</span>
                            <span id="solution-likes-{$solution.id}">
                                <span class="{if $solution.liked} hidden{/if}"  title="{translate}solution_like{/translate}" style="color:#2EA043; cursor: pointer; font-size: large;" onClick="solutionLike({$solution.id})" >▲</span>
                                <span class="{if !$solution.liked} hidden{/if}" title="{translate}solution_unlike{/translate}" style="color: darkred; cursor: pointer; font-size: large;" onClick="solutionUnlike({$solution.id})" >▼</span>
                            </span>
                        </div>
                        <div style="display: flex; column-gap: 1rem;">
                            <button class="button green" onClick="solutionRun('{$Lang}', {$QuestionID}, {$id})">{translate}solution_action_run{/translate}</button>
                            <button 
                                class="button red" 
                                {if (!$User->isAdmin() && $User->grade() neq 'Middle' && $User->grade() neq 'Senior')} disabled style="opacity:0.4;" title="{translate}low_grades_restricted{/translate} {if $User->grade()}{translate}up_your_level{/translate}{else}{translate}determine_your_level{/translate}{/if}" {/if}
                                onClick="solutionReport('{$Lang}', {$QuestionID}, {$solution.id})"
                            >
                                {translate}solution_action_report{/translate}
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