<p>Посмотрите, как другие пользователи решили эту задачу:</p>
{foreach $QuestionSolutions as $id=>$solution}
    <div class="solution-wrapper">
        <div class="solution-title">Решено: {$solution.created_at} Стоимость: {$solution.query_cost}</div>
        <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
        <div class="solution-footer">Like / Dislike</div>
    </div>
{/foreach}