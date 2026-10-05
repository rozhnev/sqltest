{* The first rows of the expected result (Question::getExpectedSample()), the tbody of expected_result.tpl *}
{foreach $ExpectedSample as $row}
    <tr>
        {foreach $row as $value}
            <td>{$value|escape}</td>
        {/foreach}
    </tr>
{/foreach}
