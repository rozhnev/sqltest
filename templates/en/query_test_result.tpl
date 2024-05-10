{if $QueryTestResult.ok}
     <b>Great! You have completed the task!</b>
     {if $QueryTestResult.cost > 0}
        <p>The cost of executing your query is {$QueryTestResult.cost} (the lower the cost, the more effective the query)</p>
        {if $QueryBestCost}
            The best query has a cost: {$QueryBestCost}
            {if $QueryBestCost == $QueryTestResult.cost} Congratulations! Your request is among the best on our website!
            {elseif $QueryBestCost > $QueryTestResult.cost} Congratulations on improving our record!
            {else} Unfortunately, your result is a little low of the record. You have something to work on! {/if}
        {/if}
     {/if}
     {if !$Logged}
        <p class="question-action">
            To save your progress and be able to see other solutions, please <a href="" onClick="toggleLoginWindow(); return false;">login</a>
        </p>
    {else}
        <p class="question-action">
        Before starting the next test, please rate the difficulty of this task:
        <select onchange="rateQuestion({$QuestionID}, this.value)">
             <option value="0" disabled selected>---</option>
             <option value="1">Too easy</option>
             <option value="2">Simple</option>
             <option value="3">Normal</option>
             <option value="4">Difficult</option>
             <option value="5">Very hard</option>
        </select>
        </p>
        <p class="question-action">
            <button onClick="showSolutions({$QuestionID})">Show me other solutions!</button>
        </p>
    {/if}
{else}
     Unfortunately incorrect.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Hint: the query returns the error: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>Hint: the result table must consist of {$QueryTestResult.hints.columnsCount} columns.</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>Hint: the resulting table should consist of the following columns: {$QueryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>Hint: the result must contain {$QueryTestResult.hints.rowsCount} rows.</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>Hint: the row number {$QueryTestResult.hints.rowsData.rowNumber} of the results table should contain the following values: 
                {$QueryTestResult.hints.rowsData.rowTable}
            </p>
            <p>your result:
                {$QueryTestResult.hints.rowsData.resultTable}
            </p>
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Hint: your query is empty.</p>
        {/if}
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>Hint: your request does not meet the requirements described in the task. <a href="#" onclick="getHelp('ru', {$QuestionID}); return false;">Use the hint</a> and try to rewrite it.</p>
        {/if}
     {/if}
    Try again.
{/if}