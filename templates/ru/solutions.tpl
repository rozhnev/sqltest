<p>Посмотрите, как другие пользователи решили эту задачу:</p>
{foreach $QuestionSolutions as $id=>$solution}
    <div class="solution-wrapper">
        <div class="solution-title">Решено: {$solution.created_at} Стоимость: {$solution.query_cost}</div>
        <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
        {* <div class="solution-footer">
            <button class="button-small green" onClick="solutionLike({$solution.id})">Нравится! ({$solution.likes})</button> 
            <button class="button-small yellow" onClick="solutionDislike({$solution.id})">Не нравится ({$solution.dislikes})</button>
            <button class="button-small red" onClick="solutionReport({$solution.id})">Не верно!</button>
        </div> *}
    </div>
{/foreach}