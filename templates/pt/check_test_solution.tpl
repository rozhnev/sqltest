{if $QueryTestResult.ok}
    <div style="font-size: larger; margin-bottom: 10px;">Excelente! Você concluiu a tarefa!</div>
    <div style="display: flex; flex-flow: row; flex-wrap: wrap; line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            O custo de execução da sua consulta é {$QueryTestResult.cost} <span style="font-size: small;">(quanto menor o custo, mais eficaz é a consulta)</span>
            {if $QueryBestCost}
                <br>Custo da melhor solução: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Parabéns! Sua consulta está entre as melhores do nosso site!
                {elseif $QueryBestCost > $QueryTestResult.cost} Parabéns por melhorar nosso recorde!
                {else} Infelizmente, o seu resultado ficou um pouco abaixo do recorde. Há espaço para melhorar! {/if}
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
     Infelizmente incorreto.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Dica: a consulta gera o erro: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>Dica: a tabela resultante deve conter {$QueryTestResult.hints.columnsCount} colunas.</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>Dica: a tabela resultante deve conter as seguintes colunas: {$QueryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>Dica: a tabela resultante deve conter {$QueryTestResult.hints.rowsCount} linhas.</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>Dica: a linha número {$QueryTestResult.hints.rowsData.rowNumber} deve conter os valores:
                {$QueryTestResult.hints.rowsData.rowTable}
            </p>
            <p>seu resultado:
                {$QueryTestResult.hints.rowsData.resultTable}
            </p>
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Dica: a sua consulta está vazia.</p>
        {/if}
     {/if}
    Tente novamente.
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{/if}
