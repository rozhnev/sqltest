{if $QueryTestResult.ok}
    {assign var="successVariants" value=[
        "Ótimo! Você resolveu a tarefa!",
        "Parabéns! A tarefa foi concluída com sucesso!",
        "Excelente! Sua consulta retornou o resultado correto!",
        "Legal! Você resolveu a tarefa corretamente!",
        "Muito bem! Sua solução está correta!"
    ]}
    {assign var="successIndex" value=$successVariants|@array_rand}
    <div class="query-success-title">
        {$successVariants[$successIndex]}
    </div>
    <div class="query-success-body">
        {if $QueryTestResult.cost > 0}
            <div class="query-cost">
            O custo de execução da sua consulta é <span class="query-cost-value{if $QueryBestCost < $QueryTestResult.cost} worse{/if}">{$QueryTestResult.cost}</span> <span class="query-cost-hint">(quanto menor o custo, mais eficaz é a consulta)</span>
            {if $QueryBestCost}
                <br>Custo da melhor solução: <span class="query-cost-value">{$QueryBestCost}</span>
                {if $QueryBestCost == $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        Parabéns! Sua consulta está entre as melhores do nosso site!
                    </p>
                {elseif $QueryBestCost > $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        Parabéns por melhorar nosso recorde!
                    </p>
                {else}
                    <p class="query-cost-note worse">
                        Sua consulta custa mais que a melhor solução, então ainda há espaço para otimizá-la. 
                    </p>
                {/if}
            {/if}
            </div>
        {/if}
        <div>
            <button class="button green" onClick="showOthersSolutions({$QuestionID})">Mostre-me outras soluções!</button>
        </div>
     </div>
     {if !$User->logged()}
        <p class="question-action">
            Para salvar seu progresso e poder ver outras soluções, por favor <a href="" onClick="toggleLoginWindow(); return false;">faça login</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div class="question-rate-panel__title">Antes de prosseguir, classifique a dificuldade desta tarefa:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Muito fácil" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Muito fácil</label>
                <input type="radio" id="rate2" name="question_rate" value="Simples" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simples</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3>Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difícil" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difícil</label>
                <input type="radio" id="rate5" name="question_rate" value="Muito difícil" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Muito difícil</label>
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
     Infelizmente incorreto.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>
                O resultado da consulta está correto, mas a consulta em si não corresponde aos requisitos da tarefa{if array_key_exists('wrongQueryHints', $QueryTestResult.hints)}:
                    <ul>
                    {foreach from=$QueryTestResult.hints.wrongQueryHints item=wrongQueryHint}
                        <li>{$wrongQueryHint}</li>
                    {/foreach}
                    </ul>
                {else}.
                {/if}
                <button type="button" class="text-button blue" onclick="getHelp('{$Lang}', {$QuestionID})">
                    <i class="icon icon-hint" aria-hidden="true"></i>
                    Obter dica e tente reescrevê-la.
                </button>
            </p>
        {/if}
        {if array_key_exists('multipleResults', $QueryTestResult.hints) }
            <p>Dica: múltiplos conjuntos de resultados retornados. Apenas um conjunto de resultados é esperado.</p>
        {/if}
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
            <p>Dica: a linha {$QueryTestResult.hints.rowsData.rowNumber} do seu resultado é diferente da esperada:</p>
            {include file='row_diff.tpl' RowDiff=$QueryTestResult.hints.rowsData}
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Dica: sua consulta está vazia.</p>
        {/if}
     {/if}
     {include file='expected_sample_link.tpl'}
    <div style="display: flex; flex-direction: column; align-items: flex-start; margin-top: 10px;">
        Tente novamente.<br>
        <p style="display: flex; margin-top: 2em; column-gap: 6px; font-style: italic;">
            Encontrou um erro na tarefa?&nbsp;
            <a style="display: flex; column-gap: 6px; justify-content: center; align-items: center;" target="_blank" href="https://telegram.me/sqltest_online" class="">
                <span class="tg-icon">
                    <span class=""> </span>
                </span>
                avise-nos!
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