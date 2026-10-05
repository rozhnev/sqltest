{if $QueryTestResult.ok}
    {assign var="successVariants" value=[
        "Great job! You solved the task!",
        "Congratulations! The task was completed successfully!",
        "Excellent! Your query produced the correct result!",
        "Awesome! You solved the task correctly!",
        "Well done! Your solution is correct!"
    ]}
    {assign var="successIndex" value=$successVariants|@array_rand}
    <div class="query-success-title">
        {$successVariants[$successIndex]}
    </div>
    <div class="query-success-body">
        {if $QueryTestResult.cost > 0}
            <div class="query-cost">
            The cost of executing your query is <span class="query-cost-value{if $QueryBestCost < $QueryTestResult.cost} worse{/if}">{$QueryTestResult.cost}</span> <span class="query-cost-hint">(the lower the cost, the more effective the query)</span>
            {if $QueryBestCost}
                <br>Cost of the best solution: <span class="query-cost-value">{$QueryBestCost}</span>
                {if $QueryBestCost == $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        Congratulations! Your query is among the best on our website!
                    </p>
                {elseif $QueryBestCost > $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        Congratulations on improving our record!
                    </p>
                {else}
                    <p class="query-cost-note worse">
                        Your query costs more than the best solution, so there's room to optimize it.
                    </p>
                {/if}
            {/if}
            </div>
        {/if}
        <div>
            <button class="button green" onClick="showOthersSolutions({$QuestionID})">Show me other solutions!</button>
        </div>
     </div>
     {if !$User->logged()}
        <p class="question-action">
            To save your progress and be able to see other solutions, please <a href="" onClick="toggleLoginWindow(); return false;">login</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div class="question-rate-panel__title">Before moving on to the next task, please rate the difficulty of this one:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Too easy" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Too easy</label>
                <input type="radio" id="rate2" name="question_rate" value="Simple" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simple</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difficult" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difficult</label>
                <input type="radio" id="rate5" name="question_rate" value="Very hard" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Very hard</label>
            </div>
        </div>
    {/if}
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{else}
     Unfortunately incorrect.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>
                The result of the query is correct, but the query itself does not meet the task requirements{if array_key_exists('wrongQueryHints', $QueryTestResult.hints)}:
                    <ul>
                    {foreach from=$QueryTestResult.hints.wrongQueryHints item=wrongQueryHint}
                        <li>{$wrongQueryHint}</li>
                    {/foreach}
                    </ul>
                {else}.
                {/if}
                <button type="button" class="text-button blue" onclick="getHelp('{$Lang}', {$QuestionID})">
                    <i class="icon icon-hint" aria-hidden="true"></i>
                    Use the hint and try to rewrite it.
                </button>
            </p>
        {/if}
        {if array_key_exists('multipleResults', $QueryTestResult.hints) }
            <p>Hint: Multiple result sets returned. Only one result set is expected.</p>
        {/if}
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
            <p>Hint: row {$QueryTestResult.hints.rowsData.rowNumber} of your result differs from the expected one:</p>
            {include file='row_diff.tpl' RowDiff=$QueryTestResult.hints.rowsData}
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Hint: your query is empty.</p>
        {/if}
     {/if}
     {include file='expected_sample_link.tpl'}
     <div style="display: flex; flex-direction: column; align-items: flex-start; margin-top: 10px;">
        Try again.<br>
        <p style="display: flex; margin-top: 2em; column-gap: 6px; font-style: italic;">
            Found a mistake in the task?&nbsp;
            <a style="display: flex; column-gap: 6px; justify-content: center; align-items: center;" target="_blank" href="https://telegram.me/sqltest_online" class=""> 
                <span class="tg-icon">
                    <span class=""> </span>
                </span>
                let us know!
            </a>
        </p>
    </div>
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{/if}