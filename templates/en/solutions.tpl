<p>Look as another users solved this problem:</p>
{foreach $QuestionSolutions as $id=>$solution}
    <div class="question-wrapper">
        <div class="question-title">Решено: <span class="question-dates">{$solution.created_at} Стоимость запроса: {$solution.query_cost}</span></div>
        <div class="solutuon-block" id="solution-{$id}">{$solution.query}</div>
        <div class="question-footer"><span class="question-dates">Like / Dislike</span></div>
    </div>
{/foreach}