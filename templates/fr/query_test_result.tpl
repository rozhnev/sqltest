{if $QueryTestResult.ok}
    {assign var="successVariants" value=[
        "Bien joué ! Vous avez résolu la tâche !",
        "Félicitations ! La tâche a été accomplie avec succès !",
        "Excellent ! Votre requête a produit le bon résultat !",
        "Génial ! Vous avez résolu la tâche correctement !",
        "Beau travail ! Votre solution est correcte !"
    ]}
    {assign var="successIndex" value=$successVariants|@array_rand}
    <div style="font-size: larger; margin-bottom: 10px;">
        {$successVariants[$successIndex]}
    </div>
    <div style="display: flex;
    flex-flow: row;
    flex-wrap: wrap;
    line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            Le coût d'exécution de votre requête est de <span style="color: {if $QueryBestCost < $QueryTestResult.cost} #E60000;{else}#11926E;{/if} font-weight: bold;">{$QueryTestResult.cost}</span> <span style="font-size: small;">(plus le coût est bas, plus la requête est efficace)</span>
            {if $QueryBestCost}
                <br>Coût de la meilleure solution : <span style="color: #11926E; font-weight: bold;">{$QueryBestCost}</span>
                {if $QueryBestCost == $QueryTestResult.cost}
                    <p style="display: flex; color: #0069E6;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5067 1.50804C10.6884 1.29895 10.9706 1.20705 11.2406 1.26904C14.8494 2.09755 16.6735 6.05217 16.2445 9.5903C16.0778 10.9657 15.6658 12.0439 15.0592 12.9018C15.0555 12.9071 15.0517 12.9123 15.048 12.9175C15.1858 12.8498 15.3129 12.7767 15.4319 12.6995C16.0238 12.3153 16.4583 11.8083 17.0239 11.1481C17.0923 11.0683 17.1626 10.9863 17.2353 10.902C17.3987 10.7125 17.6459 10.6169 17.8942 10.6473C18.1426 10.6776 18.3595 10.8299 18.4725 11.0531C18.97 12.0363 19.25 13.1479 19.25 14.3226C19.25 18.3267 16.0041 21.5726 12 21.5726C7.99594 21.5726 4.75 18.3267 4.75 14.3226C4.75 11.7856 6.05371 9.5535 8.02431 8.25906L8.09187 8.19098C8.12658 8.15601 8.16464 8.12454 8.20552 8.09703C9.07138 7.5144 9.69312 7.03786 10.1117 6.47743C10.5071 5.94801 10.75 5.3022 10.75 4.32264C10.75 3.59736 10.6161 2.90512 10.3723 2.26809C10.2733 2.00936 10.3249 1.71713 10.5067 1.50804ZM12.1712 3.25081C12.2231 3.60079 12.25 3.95872 12.25 4.32264C12.25 5.59106 11.9223 6.55995 11.3135 7.37505C10.7417 8.14054 9.95028 8.72847 9.10466 9.2999L9.03236 9.37275C8.99362 9.41179 8.95071 9.44644 8.90439 9.4761C7.30648 10.4991 6.25 12.2877 6.25 14.3226C6.25 17.4983 8.82436 20.0726 12 20.0726C15.1756 20.0726 17.75 17.4983 17.75 14.3226C17.75 13.8028 17.6812 13.2997 17.5523 12.8217C17.1721 13.2334 16.7524 13.6307 16.2485 13.9577C15.3253 14.5569 14.1699 14.899 12.5 14.899C12.1577 14.899 11.8589 14.6673 11.7736 14.3358C11.6884 14.0044 11.8383 13.6572 12.1381 13.4921C12.8169 13.1181 13.3923 12.661 13.8345 12.0357C14.2757 11.4118 14.6137 10.5787 14.7555 9.40975C15.0623 6.879 14.0149 4.38107 12.1712 3.25081Z" fill="#0069E6"/>
                        </svg>
                        Félicitations ! Votre requête figure parmi les meilleures de notre site !
                    </p>
                {elseif $QueryBestCost > $QueryTestResult.cost}
                    <p style="display: flex; color: #0069E6;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5067 1.50804C10.6884 1.29895 10.9706 1.20705 11.2406 1.26904C14.8494 2.09755 16.6735 6.05217 16.2445 9.5903C16.0778 10.9657 15.6658 12.0439 15.0592 12.9018C15.0555 12.9071 15.0517 12.9123 15.048 12.9175C15.1858 12.8498 15.3129 12.7767 15.4319 12.6995C16.0238 12.3153 16.4583 11.8083 17.0239 11.1481C17.0923 11.0683 17.1626 10.9863 17.2353 10.902C17.3987 10.7125 17.6459 10.6169 17.8942 10.6473C18.1426 10.6776 18.3595 10.8299 18.4725 11.0531C18.97 12.0363 19.25 13.1479 19.25 14.3226C19.25 18.3267 16.0041 21.5726 12 21.5726C7.99594 21.5726 4.75 18.3267 4.75 14.3226C4.75 11.7856 6.05371 9.5535 8.02431 8.25906L8.09187 8.19098C8.12658 8.15601 8.16464 8.12454 8.20552 8.09703C9.07138 7.5144 9.69312 7.03786 10.1117 6.47743C10.5071 5.94801 10.75 5.3022 10.75 4.32264C10.75 3.59736 10.6161 2.90512 10.3723 2.26809C10.2733 2.00936 10.3249 1.71713 10.5067 1.50804ZM12.1712 3.25081C12.2231 3.60079 12.25 3.95872 12.25 4.32264C12.25 5.59106 11.9223 6.55995 11.3135 7.37505C10.7417 8.14054 9.95028 8.72847 9.10466 9.2999L9.03236 9.37275C8.99362 9.41179 8.95071 9.44644 8.90439 9.4761C7.30648 10.4991 6.25 12.2877 6.25 14.3226C6.25 17.4983 8.82436 20.0726 12 20.0726C15.1756 20.0726 17.75 17.4983 17.75 14.3226C17.75 13.8028 17.6812 13.2997 17.5523 12.8217C17.1721 13.2334 16.7524 13.6307 16.2485 13.9577C15.3253 14.5569 14.1699 14.899 12.5 14.899C12.1577 14.899 11.8589 14.6673 11.7736 14.3358C11.6884 14.0044 11.8383 13.6572 12.1381 13.4921C12.8169 13.1181 13.3923 12.661 13.8345 12.0357C14.2757 11.4118 14.6137 10.5787 14.7555 9.40975C15.0623 6.879 14.0149 4.38107 12.1712 3.25081Z" fill="#0069E6"/>
                        </svg>
                        Félicitations pour avoir amélioré notre record !
                    </p>
                {else}
                    <p style="color: #E60000;">
                        Malheureusement, votre résultat est un peu au-dessus du record. Vous avez encore une marge de progression !
                    </p>
                {/if}
            {/if}
            </div>
        {/if}
        <div>
            <button class="button green" onClick="showOthersSolutions({$QuestionID})">Montrez-moi les autres solutions !</button>
        </div>
     </div>
     {if !$User->logged()}
        <p class="question-action">
            Pour enregistrer vos progrès et pouvoir consulter les autres solutions, veuillez vous <a href="" onClick="toggleLoginWindow(); return false;">connecter</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div style="min-width:280px;">Avant de commencer le test suivant, veuillez évaluer la difficulté de cette tâche :</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Too easy" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Trop facile</label>
                <input type="radio" id="rate2" name="question_rate" value="Simple" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simple</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difficult" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difficile</label>
                <input type="radio" id="rate5" name="question_rate" value="Very hard" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Très difficile</label>
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
     Malheureusement incorrect.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>
                Le résultat de la requête est correct, mais la requête elle-même ne répond pas aux exigences de la tâche{if array_key_exists('wrongQueryHints', $QueryTestResult.hints)} :
                    <ul>
                    {foreach from=$QueryTestResult.hints.wrongQueryHints item=wrongQueryHint}
                        <li>{$wrongQueryHint}</li>
                    {/foreach}
                    </ul>
                {else}.
                {/if}
                <span class="text-button blue" id="getHelpBtn" onclick="getHelp('fr', {$QuestionID})">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M12 3.75C8.52397 3.75 5.75 6.46727 5.75 9.76594C5.75 11.7705 6.57093 13.4993 8.03534 14.576C8.3581 14.8133 8.63421 15.1672 8.73996 15.6162C8.82675 15.9847 8.92608 16.4337 9.02447 16.9095H14.9755C15.0739 16.4337 15.1732 15.9847 15.26 15.6162C15.3658 15.1672 15.6419 14.8133 15.9647 14.576C17.4291 13.4993 18.25 11.7705 18.25 9.76594C18.25 6.46727 15.476 3.75 12 3.75ZM14.6887 18.4095H9.31128C9.42169 19.0471 9.50831 19.6509 9.53454 20.0844C9.56215 20.5408 9.90326 20.9498 10.4062 21.0585L10.6022 21.1009C11.5226 21.2997 12.4774 21.2997 13.3978 21.1009L13.5938 21.0585C14.0967 20.9498 14.4379 20.5408 14.4655 20.0844C14.4917 19.6509 14.5783 19.0471 14.6887 18.4095ZM4.25 9.76594C4.25 5.59116 7.74404 2.25 12 2.25C16.256 2.25 19.75 5.59116 19.75 9.76594C19.75 12.1898 18.7464 14.3926 16.8532 15.7845C16.7668 15.848 16.7307 15.9148 16.7201 15.9601C16.6017 16.4627 16.4575 17.128 16.326 17.8029C16.1432 18.7412 15.9944 19.6512 15.9627 20.175C15.8927 21.3332 15.0406 22.2805 13.9106 22.5247L13.7146 22.567C12.5854 22.811 11.4146 22.811 10.2854 22.567L10.0894 22.5247C8.95941 22.2805 8.10735 21.3332 8.03727 20.175C8.00558 19.6512 7.85678 18.7412 7.67399 17.8029C7.5425 17.128 7.3983 16.4627 7.27991 15.9601C7.26925 15.9148 7.23315 15.848 7.14681 15.7845C5.25357 14.3926 4.25 12.1898 4.25 9.76594Z" fill="#0069E6"></path>
                    </svg>
                    Utilisez l'indice et essayez de la réécrire.
                </span>
            </p>
        {/if}
        {if array_key_exists('multipleResults', $QueryTestResult.hints) }
            <p>Indice : Plusieurs jeux de résultats renvoyés. Un seul jeu de résultats est attendu.</p>
        {/if}
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Indice : la requête renvoie l'erreur : <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>Indice : la table de résultat doit comporter {$QueryTestResult.hints.columnsCount} colonnes.</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>Indice : la table résultante doit comporter les colonnes suivantes : {$QueryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>Indice : le résultat doit contenir {$QueryTestResult.hints.rowsCount} lignes.</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>Indice : la ligne numéro {$QueryTestResult.hints.rowsData.rowNumber} du tableau de résultats doit contenir les valeurs suivantes : 
                {$QueryTestResult.hints.rowsData.rowTable}
            </p>
            <p>votre résultat :
                {$QueryTestResult.hints.rowsData.resultTable}
            </p>
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Indice : votre requête est vide.</p>
        {/if}
     {/if}
     <div style="display: flex; column-gap: 6px; align-items: center;">
        Réessayez. Une erreur trouvée dans la tâche ? 
        <a style="display: flex; column-gap: 6px; justify-content: center; align-items: center;" target="_blank" href="https://t.me/sqltest_online" class=""> 
            <span class="tg-icon">
                <span class=""> </span>
            </span>
            faites-le nous savoir !
        </a>
    </div>
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{/if}
