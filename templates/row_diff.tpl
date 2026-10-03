{* The first differing row of a wrong result: expected vs the user's values under the column names, differing cells
   highlighted (hints.rowsData of Question::checkQueryResult()). Pass it as RowDiff. *}
<div class="table-wrapper">
    <table class="result-table row-diff">
        <thead>
            <tr>
                <th></th>
                {foreach $RowDiff.columns as $column}
                    <th scope="col">{$column|escape}</th>
                {/foreach}
            </tr>
        </thead>
        <tbody>
            <tr>
                <th scope="row">{translate}row_diff_expected{/translate}</th>
                {foreach $RowDiff.expected as $i => $value}
                    <td{if $RowDiff.diff[$i]} class="row-diff__cell row-diff__cell--expected"{/if}>{$value|escape}</td>
                {/foreach}
            </tr>
            <tr>
                <th scope="row">{translate}row_diff_yours{/translate}</th>
                {foreach $RowDiff.actual as $i => $value}
                    <td{if $RowDiff.diff[$i]} class="row-diff__cell row-diff__cell--yours"{/if}>{$value|escape}</td>
                {/foreach}
            </tr>
        </tbody>
    </table>
</div>
