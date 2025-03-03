{if $QueryTestResult.ok}
    <div style="font-size: larger; margin-bottom: 10px;">Ótimo! Você completou a tarefa!</div>
    <div style="display: flex;
    flex-flow: row;
    flex-wrap: wrap;
    line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            O custo de execução da sua consulta é <span style="color: {if $QueryBestCost < $QueryTestResult.cost} #E60000;{else}#11926E;{/if} font-weight: bold;">{$QueryTestResult.cost}</span> <span style="font-size: small;">(quanto menor o custo, mais eficaz é a consulta)</span>
            {if $QueryBestCost}
                <br>Custo da melhor solução: <span style="color: #11926E; font-weight: bold;">{$QueryBestCost}</span>
                {if $QueryBestCost == $QueryTestResult.cost}
                    <p style="display: flex; color: #0069E6;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5067 1.50804C10.6884 1.29895 10.9706 1.20705 11.2406 1.26904C14.8494 2.09755 16.6735 6.05217 16.2445 9.5903C16.0778 10.9657 15.6658 12.0439 15.0592 12.9018C15.0555 12.9071 15.0517 12.9123 15.048 12.9175C15.1858 12.8498 15.3129 12.7767 15.4319 12.6995C16.0238 12.3153 16.4583 11.8083 17.0239 11.1481C17.0923 11.0683 17.1626 10.9863 17.2353 10.902C17.3987 10.7125 17.6459 10.6169 17.8942 10.6473C18.1426 10.6776 18.3595 10.8299 18.4725 11.0531C18.97 12.0363 19.25 13.1479 19.25 14.3226C19.25 18.3267 16.0041 21.5726 12 21.5726C7.99594 21.5726 4.75 18.3267 4.75 14.3226C4.75 11.7856 6.05371 9.5535 8.02431 8.25906L8.09187 8.19098C8.12658 8.15601 8.16464 8.12454 8.20552 8.09703C9.07138 7.5144 9.69312 7.03786 10.1117 6.47743C10.5071 5.94801 10.75 5.3022 10.75 4.32264C10.75 3.59736 10.6161 2.90512 10.3723 2.26809C10.2733 2.00936 10.3249 1.71713 10.5067 1.50804ZM12.1712 3.25081C12.2231 3.60079 12.25 3.95872 12.25 4.32264C12.25 5.59106 11.9223 6.55995 11.3135 7.37505C10.7417 8.14054 9.95028 8.72847 9.10466 9.2999L9.03236 9.37275C8.99362 9.41179 8.95071 9.44644 8.90439 9.4761C7.30648 10.4991 6.25 12.2877 6.25 14.3226C6.25 17.4983 8.82436 20.0726 12 20.0726C15.1756 20.0726 17.75 17.4983 17.75 14.3226C17.75 13.8028 17.6812 13.2997 17.5523 12.8217C17.1721 13.2334 16.7524 13.6307 16.2485 13.9577C15.3253 14.5569 14.1699 14.899 12.5 14.899C12.1577 14.899 11.8589 14.6673 11.7736 14.3358C11.6884 14.0044 11.8383 13.6572 12.1381 13.4921C12.8169 13.1181 13.3923 12.661 13.8345 12.0357C14.2757 11.4118 14.6137 10.5787 14.7555 9.40975C15.0623 6.879 14.0149 4.38107 12.1712 3.25081Z" fill="#0069E6"/>
                        </svg>
                        Parabéns! Sua consulta está entre as melhores do nosso site!
                    </p>
                {elseif $QueryBestCost > $QueryTestResult.cost}
                    <p style="display: flex; color: #0069E6;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5067 1.50804C10.6884 1.29895 10.9706 1.20705 11.2406 1.26904C14.8494 2.09755 16.6735 6.05217 16.2445 9.5903C16.0778 10.9657 15.6658 12.0439 15.0592 12.9018C15.0555 12.9071 15.0517 12.9123 15.048 12.9175C15.1858 12.8498 15.3129 12.7767 15.4319 12.6995C16.0238 12.3153 16.4583 11.8083 17.0239 11.1481C17.0923 11.0683 17.1626 10.9863 17.2353 10.902C17.3987 10.7125 17.6459 10.6169 17.8942 10.6473C18.1426 10.6776 18.3595 10.8299 18.4725 11.0531C18.97 12.0363 19.25 13.1479 19.25 14.3226C19.25 18.3267 16.0041 21.5726 12 21.5726C7.99594 21.5726 4.75 18.3267 4.75 14.3226C4.75 11.7856 6.05371 9.5535 8.02431 8.25906L8.09187 8.19098C8.12658 8.15601 8.16464 8.12454 8.20552 8.09703C9.07138 7.5144 9.69312 7.03786 10.1117 6.47743C10.5071 5.94801 10.75 5.3022 10.75 4.32264C10.75 3.59736 10.6161 2.90512 10.3723 2.26809C10.2733 2.00936 10.3249 1.71713 10.5067 1.50804ZM12.1712 3.25081C12.2231 3.60079 12.25 3.95872 12.25 4.32264C12.25 5.59106 11.9223 6.55995 11.3135 7.37505C10.7417 8.14054 9.95028 8.72847 9.10466 9.2999L9.03236 9.37275C8.99362 9.41179 8.95071 9.44644 8.90439 9.4761C7.30648 10.4991 6.25 12.2877 6.25 14.3226C6.25 17.4983 8.82436 20.0726 12 20.0726C15.1756 20.0726 17.75 17.4983 17.75 14.3226C17.75 13.8028 17.6812 13.2997 17.5523 12.8217C17.1721 13.2334 16.7524 13.6307 16.2485 13.9577C15.3253 14.5569 14.1699 14.899 12.5 14.899C12.1577 14.899 11.8589 14.6673 11.7736 14.3358C11.6884 14.0044 11.8383 13.6572 12.1381 13.4921C12.8169 13.1181 13.3923 12.661 13.8345 12.0357C14.2757 11.4118 14.6137 10.5787 14.7555 9.40975C15.0623 6.879 14.0149 4.38107 12.1712 3.25081Z" fill="#0069E6"/>
                        </svg>
                        Parabéns por melhorar nosso recorde!
                    </p>
                {else}
                    <p style="color: #E60000;">
                        Infelizmente, seu resultado está um pouco abaixo do recorde. Você tem algo para trabalhar! 
                    </p>
                {/if}
            {/if}
            </div>
        {if $User->logged()}
            <div>
                <button class="button green" onClick="showOthersSolutions({$QuestionID})">Mostre-me outras soluções!</button>
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
            <div style="min-width:280px; flex: 2 1; margin-bottom: 9px;">Прежде чем двигаться дальше, пожалуйста оцените сложность этого задания:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Muito fácil" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Muito fácil</label>
                <input type="radio" id="rate2" name="question_rate" value="Simples" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate1">Simples</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate1">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difícil" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate1">Difícil</label>
                <input type="radio" id="rate5" name="question_rate" value="Muito difícil" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate1">Muito difícil</label>
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
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{/if}