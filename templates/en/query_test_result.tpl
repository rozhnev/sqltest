{if $QeryTestResult.ok}
     <b>Great! You can proceed to the next test.</b>
     {if !$Logged}
        <p class="question-action">
            To save your progress, please <a href="" onClick="toggleLoginWindow(); return false;">login</a>
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
    {/if}
{else}
     Unfortunately incorrect.
     {if array_key_exists('hints', $QeryTestResult) }
        {if array_key_exists('queryError', $QeryTestResult.hints) }
            <p>Hint: the query returns the error: <span class="sql_error">{$QeryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QeryTestResult.hints) }
            <p>Hint: the result table must consist of {$QeryTestResult.hints.columnsCount} columns.</p>
        {/if}
        {if array_key_exists('columnsList', $QeryTestResult.hints) }
            <p>Hint: the resulting table should consist of the following columns: {$QeryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QeryTestResult.hints) }
            <p>Hint: the result must contain {$QeryTestResult.hints.rowsCount} rows.</p>
        {/if}
        {if array_key_exists('rowsData', $QeryTestResult.hints) }
            <p>Hint: the row number {$QeryTestResult.hints.rowsData.rowNumber} of the results table should contain the following values: {$QeryTestResult.hints.rowsData.rowData}.</p>
        {/if}
        {if array_key_exists('emptyQuery', $QeryTestResult.hints) }
            <p>Hint: your query is empty.</p>
        {/if}
        {if array_key_exists('wrongQuery', $QeryTestResult.hints) }
            <p>Hint: your request does not meet the requirements described in the task. Try to rewrite it.</p>
        {/if}
     {/if}
    Try again.
{/if}