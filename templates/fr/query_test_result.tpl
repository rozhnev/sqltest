{if $QueryTestResult.ok}
    {assign var="successVariants" value=[
        "Bien joué ! Vous avez résolu la tâche !",
        "Félicitations ! La tâche a été accomplie avec succès !",
        "Excellent ! Votre requête a produit le bon résultat !",
        "Génial ! Vous avez résolu la tâche correctement !",
        "Beau travail ! Votre solution est correcte !"
    ]}
    {assign var="successIndex" value=$successVariants|@array_rand}
    <div class="query-success-title">
        {$successVariants[$successIndex]}
    </div>
    <div class="query-success-body">
        {if $QueryTestResult.cost > 0}
            <div class="query-cost">
            Le coût d'exécution de votre requête est de <span class="query-cost-value{if $QueryBestCost < $QueryTestResult.cost} worse{/if}">{$QueryTestResult.cost}</span> <span class="query-cost-hint">(plus le coût est bas, plus la requête est efficace)</span>
            {if $QueryBestCost}
                <br>Coût de la meilleure solution : <span class="query-cost-value">{$QueryBestCost}</span>
                {if $QueryBestCost == $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        Félicitations ! Votre requête figure parmi les meilleures de notre site !
                    </p>
                {elseif $QueryBestCost > $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        Félicitations pour avoir amélioré notre record !
                    </p>
                {else}
                    <p class="query-cost-note worse">
                        Votre requête coûte plus cher que la meilleure solution : vous pouvez encore l'optimiser !
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
            <div class="question-rate-panel__title">Avant de passer à la tâche suivante, veuillez évaluer la difficulté de celle-ci :</div>
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
                <span class="text-button blue" onclick="getHelp('{$Lang}', {$QuestionID})">
                    <i class="icon icon-hint" aria-hidden="true"></i>
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
            <p>Indice : la ligne {$QueryTestResult.hints.rowsData.rowNumber} de votre résultat diffère de celle attendue :</p>
            {include file='row_diff.tpl' RowDiff=$QueryTestResult.hints.rowsData}
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Indice : votre requête est vide.</p>
        {/if}
     {/if}
    <div style="display: flex; flex-direction: column; align-items: flex-start; margin-top: 10px;">
        Réessayez.<br>
        <p style="display: flex; margin-top: 2em; column-gap: 6px; font-style: italic;">
            Une erreur trouvée dans la tâche ?&nbsp;
            <a style="display: flex; column-gap: 6px; justify-content: center; align-items: center;" target="_blank" href="https://telegram.me/sqltest_online" class="">
                <span class="tg-icon">
                    <span class=""> </span>
                </span>
                faites-le nous savoir !
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
