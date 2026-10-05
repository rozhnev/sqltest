{* Task list of one menu group (menu.tpl). Rendered with the page for the current group only; the others are
   loaded when expanded or searched (Controller::menu with ?group=, loadMenuGroups() in script.js).
   Params: panel - a group of $Questionnire.menu, categoryId - its id *}
<ol>
{foreach $panel.questions as $question}
<li>
    <div class="question-row">
        <a class="question-link {if isset($QuestionID) && $QuestionID == $question[1]} current-question{/if}{if $question[2]} solved{/if}" href="/{$Lang}/question/{$panel.sef}/{$question[3]}">
            <span class="question-number">{$question[5]}.&nbsp;</span>
            {$question[0]}
            {if $question[4]}
                <span class="question-star favored" title="{translate}favorite{/translate}">★</span>
            {/if}
        </a>
        {if $User->isAdmin()}
            <span class="question-reorder">
                <button type="button" class="question-reorder__btn" title="Move up" onClick="event.preventDefault(); moveQuestionPosition({$question[1]}, {$categoryId}, 'up'); return false;">&#9650;</button>
                <button type="button" class="question-reorder__btn" title="Move down" onClick="event.preventDefault(); moveQuestionPosition({$question[1]}, {$categoryId}, 'down'); return false;">&#9660;</button>
            </span>
        {/if}
    </div>
</li>
{/foreach}
</ol>
