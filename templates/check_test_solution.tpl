{if $QueryTestResult.ok}
    <div style="font-size: larger; margin-bottom: 10px;">Great! You have completed the task!</div>
    <div style="display: flex; flex-flow: row; flex-wrap: wrap; line-height: 1.5em;">
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
    {assign var="NextQuestion" value="{$QueryTestResult.nextQuestion}"}
    {translate}maximum_attempts_reached{/translate}{if $QueryTestResult.nextQuestion} {translate}go_to_next_task{/translate}{/if}
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('timeOut', $QueryTestResult.hints)}
    {translate}test_time_out{/translate} {translate}go_to_rate{/translate}
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
     {/if}
    Try again.
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link" style="margin-top: 5em;">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{/if}