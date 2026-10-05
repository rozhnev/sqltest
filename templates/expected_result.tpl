{* Expected result of a query task (QUESTION_PAGE_UX_TODO.md, item 3), under the task on index.tpl / m.index.tpl.
   Level 1: column names and the row count. Level 2: the first rows, after ExpectedResult.unlock_after wrong checks,
   loaded by showSampleRows() from /{lang}/question/{id}/expected-sample. *}
{assign var="ExpectedRows" value=$ExpectedResult.rows}
{assign var="SampleSize" value=$ExpectedResult.sample_size}
{assign var="SampleFailedChecks" value=$ExpectedResult.failed_checks}
{assign var="SampleUnlockAfter" value=$ExpectedResult.unlock_after}
<details class="expected-result" id="expected-result"{if $ExpectedResult.sample} data-sample-loaded="1"{/if}>
    <summary>
        <i class="icon icon-table expected-result__icon" aria-hidden="true"></i>
        <span class="expected-result__title">{translate}expected_result_title{/translate}</span>
        <span class="expected-result__meta">{translate}expected_result_columns{/translate}: {$ExpectedResult.columns|@count} · {translate}expected_result_rows{/translate}: {$ExpectedResult.rows}</span>
    </summary>
    <div class="table-wrapper">
        <table class="result-table expected-result__table">
            <thead>
                <tr>
                    {foreach $ExpectedResult.columns as $column}
                        <th scope="col">{$column|escape}</th>
                    {/foreach}
                </tr>
            </thead>
            <tbody id="expected-result-rows">
                {if $ExpectedResult.sample}
                    {include file='expected_result_rows.tpl' ExpectedSample=$ExpectedResult.sample}
                {/if}
            </tbody>
        </table>
    </div>
    {if $ExpectedResult.in_open_test}
        <p class="expected-result__note">{translate}expected_result_sample_in_test{/translate}</p>
    {elseif $ExpectedResult.sample_size > 0}
        <p class="expected-result__note{if !$ExpectedResult.sample} hidden{/if}" data-sample-state="shown">{translate}expected_result_sample_note{/translate}</p>
        {if !$ExpectedResult.sample}
            <p class="expected-result__note{if !$ExpectedResult.unlocked} hidden{/if}" data-sample-state="available">
                <button type="button" class="text-button blue" onClick="showSampleRows('{$Lang}', {$QuestionID})">{translate}expected_result_show_sample{/translate}</button>
            </p>
            {if !$ExpectedResult.unlocked}
                <p class="expected-result__note" data-sample-state="locked">{translate}expected_result_sample_locked{/translate}</p>
            {/if}
        {/if}
    {/if}
</details>
