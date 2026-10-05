{* In a wrong check result ({$Lang}/query_test_result.tpl): opens the sample rows of the expected result block *}
{if isset($SampleRowsAvailable) && $SampleRowsAvailable}
    <p>
        <button type="button" class="text-button blue" onClick="showSampleRows('{$Lang}', {$QuestionID})">{translate}expected_result_show_sample{/translate}</button>
    </p>
{/if}
