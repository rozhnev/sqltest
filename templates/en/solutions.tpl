<p>Look as another users solved this problem:</p>
{foreach $QuestionSolutions as $id=>$solution}
    <div class="solution-wrapper">
        <div class="solution-title">Solved at: {$solution.created_at} Query cost: {$solution.query_cost}</div>
        <div class="solution-block" id="solution-{$id}">{$solution.query}</div>
        <div class="solution-footer">
            <button class="button-small green" onClick="solutionLike({$solution.id})>Like it! ({$solution.likes})</button>
            <button class="button-small yellow" onClick="solutionUnike({$solution.id})>Dislike ({$solution.dislikes})</button>
            <button class="button-small red" onClick="solutionReport({$solution.id})>Wrong solution!</button>
        </div>
    </div>
{/foreach}