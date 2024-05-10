<p>Посмотрите, как другие пользователи решили эту задачу:</p>
{foreach $QuestionSolutions as $id=>$solution}
    <div class="question-wrapper">
        <div class="question-title"><span class="question-dates">Solved at: {$solution.created_at} Query cost: {$solution.query_cost}</span></div>
        <div class="solutuon-block" id="solution-{$id}">{$solution.query}</div>
        <div class="question-footer"><span class="question-dates">Like / Dislike</span></div>
    </div>
{/foreach}