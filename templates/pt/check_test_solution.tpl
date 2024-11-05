{if $QueryTestResult.ok}
    <div style="font-size: larger; margin-bottom: 10px;">Great! You have completed the task!</div>
    <div style="display: flex;
    flex-flow: row;
    flex-wrap: wrap;
    line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            The cost of executing your query is {$QueryTestResult.cost} <span style="font-size: small;">(the lower the cost, the more effective the query)</span>
            {if $QueryBestCost}
                <br>Cost of the best solution: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Congratulations! Your request is among the best on our website!
                {elseif $QueryBestCost > $QueryTestResult.cost} Congratulations on improving our record!
                {else} Unfortunately, your result is a little low of the record. You have something to work on! {/if}
            {/if}
            </div>
     {/if}
     </div>
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('maxAttemptsReached', $QueryTestResult.hints)}
    Maximum attempt count reached.
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
    {if isset($ReferralLink)}
        <div class="referral_link" style="font-size:large; margin-top: 5em; padding: 1em; border: solid 1px; border-radius: 3px;">
            {$ReferralLink}
        </div>
    {/if}
{/if}