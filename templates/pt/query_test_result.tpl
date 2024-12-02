{if $QueryTestResult.ok}
    <div style="font-size: larger; margin-bottom: 10px;">Ótimo! Você completou a tarefa!</div>
    <div style="display: flex;
    flex-flow: row;
    flex-wrap: wrap;
    line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            O custo de execução da sua consulta é {$QueryTestResult.cost} <span style="font-size: small;">(quanto menor o custo, mais eficaz é a consulta)</span>
            {if $QueryBestCost}
                <br>Custo da melhor solução: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Parabéns! Sua consulta está entre as melhores do nosso site!
                {elseif $QueryBestCost > $QueryTestResult.cost} Parabéns por melhorar nosso recorde!
                {else} Infelizmente, seu resultado está um pouco abaixo do recorde. Você tem algo para trabalhar! {/if}
            {/if}
            </div>
        {if $User->logged()}
            <div>
                <button class="button green" onClick="showSolutions({$QuestionID})">Mostre-me outras soluções!</button>
            </div>
        {/if}
     {/if}
     </div>
     {if !$User->logged()}
        <p class="question-action">
            Para salvar seu progresso e poder ver outras soluções, por favor <a href="" onClick="toggleLoginWindow(); return false;">faça login</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div style="min-width:280px;">Antes de iniciar o próximo teste, por favor avalie a dificuldade desta tarefa:</div>
            <div class="buttons">
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 1)"><span class="question-level rate1"></span>&nbsp;Muito fácil</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 2)"><span class="question-level rate2"></span>&nbsp;Simples</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 3)"><span class="question-level rate3"></span>&nbsp;Normal</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 4)"><span class="question-level rate4"></span>&nbsp;Difícil</button>
                <button class="button-small" onclick="rateQuestion({$QuestionID}, 5)"><span class="question-level rate5"></span>&nbsp;Muito difícil</button>
            </div>
        </div>
    {/if}
    {if isset($ReferralLink)}
        <div class="referral-link" style="margin-top: 1em;">
            {$ReferralLink}
        </div>
    {/if}
{else}
     Infelizmente incorreto.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Dica: a consulta retorna o erro: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>Dica: a tabela de resultados deve consistir em {$QueryTestResult.hints.columnsCount} colunas.</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>Dica: a tabela resultante deve consistir nas seguintes colunas: {$QueryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>Dica: o resultado deve conter {$QueryTestResult.hints.rowsCount} linhas.</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>Dica: a linha número {$QueryTestResult.hints.rowsData.rowNumber} da tabela de resultados deve conter os seguintes valores: 
                {$QueryTestResult.hints.rowsData.rowTable}
            </p>
            <p>seu resultado:
                {$QueryTestResult.hints.rowsData.resultTable}
            </p>
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Dica: sua consulta está vazia.</p>
        {/if}
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>Dica: sua consulta não atende aos requisitos descritos na tarefa. <a href="#" onclick="getHelp('pt', {$QuestionID}); return false;">Use a dica</a> e tente reescrevê-la.</p>
        {/if}
     {/if}
    Tente novamente.
    {if isset($ReferralLink)}
        <div class="referral-link" style="margin-top: 5em;">
            {$ReferralLink}
        </div>
    {/if}
{/if}