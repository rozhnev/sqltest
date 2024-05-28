{if $QuestionSolutions}
    <p>Посмотрите, как другие пользователи решили эту задачу:</p>
    {foreach $QuestionSolutions as $id=>$solution}
        <div class="solution-wrapper" id="solution-wrapper-{$id}">
            <div class="solution-title">Решено: {$solution.created_at} Стоимость: {$solution.query_cost}</div>
            <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
            <div class="solution-footer">
                <button class="button-small green" onClick="solutionRun('ru', {$QuestionID}, {$id})">Выполнить</button>
                {* <button class="button-small green" onClick="solutionLike({$solution.id})">Нравится! ({$solution.likes})</button> 
                <button class="button-small yellow" onClick="solutionDislike({$solution.id})">Не нравится ({$solution.dislikes})</button> *}
                <button class="button-small red" onClick="solutionReport('ru', {$QuestionID}, {$solution.id})">Не верно!</button>
            </div>
        </div>
    {/foreach}
{else}
    <div class="solution-wrapper">
        <div style="padding: 2em;">
            <p>Извините, но пока не опубликовано ни одно из решений этой задачи.</p>
        </div>
    </div>
{/if}