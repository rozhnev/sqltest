<p>Look as another users solved this problem:</p>
{foreach $QuestionSolutions as $id=>$solution}
    <div class="solution-wrapper">
        <div class="solution-title">Solved at: {$solution.created_at} Query cost: {$solution.query_cost}</div>
        <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
        <div class="solution-footer">Like / Dislike</div>
    </div>
{/foreach}