{if $QueryTestResult.ok}
    {assign var="successVariants" value=[
        "¡Buen trabajo! ¡Has resuelto la tarea!",
        "¡Felicidades! ¡La tarea se completó con éxito!",
        "¡Excelente! ¡Tu consulta produjo el resultado correcto!",
        "¡Increíble! ¡Has resuelto la tarea correctamente!",
        "¡Bien hecho! ¡Tu solución es correcta!"
    ]}
    {assign var="successIndex" value=$successVariants|@array_rand}
    <div class="query-success-title">
        {$successVariants[$successIndex]}
    </div>
    <div class="query-success-body">
        {if $QueryTestResult.cost > 0}
            <div class="query-cost">
            El costo de ejecutar tu consulta es <span class="query-cost-value{if $QueryBestCost < $QueryTestResult.cost} worse{/if}">{$QueryTestResult.cost}</span> <span class="query-cost-hint">(cuanto menor sea el costo, más efectiva es la consulta)</span>
            {if $QueryBestCost}
                <br>Costo de la mejor solución: <span class="query-cost-value">{$QueryBestCost}</span>
                {if $QueryBestCost == $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        ¡Felicidades! ¡Tu consulta está entre las mejores de nuestro sitio web!
                    </p>
                {elseif $QueryBestCost > $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        ¡Felicidades por mejorar nuestro récord!
                    </p>
                {else}
                    <p class="query-cost-note worse">
                        Tu consulta cuesta más que la mejor solución, así que aún puedes optimizarla.
                    </p>
                {/if}
            {/if}
            </div>
        {/if}
        <div>
            <button class="button green" onClick="showOthersSolutions({$QuestionID})">¡Muéstrame otras soluciones!</button>
        </div>
     </div>
     {if !$User->logged()}
        <p class="question-action">
            Para guardar tu progreso y poder ver otras soluciones, por favor <a href="" onClick="toggleLoginWindow(); return false;">inicia sesión</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div class="question-rate-panel__title">Antes de pasar a la siguiente tarea, por favor califica la dificultad de esta:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Demasiado fácil" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Demasiado fácil</label>
                <input type="radio" id="rate2" name="question_rate" value="Simple" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simple</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difícil" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difícil</label>
                <input type="radio" id="rate5" name="question_rate" value="Muy difícil" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Muy difícil</label>
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
     Desafortunadamente incorrecto.
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>
                El resultado de la consulta es correcto, pero la consulta en sí no cumple con los requisitos de la tarea{if array_key_exists('wrongQueryHints', $QueryTestResult.hints)}:
                    <ul>
                    {foreach from=$QueryTestResult.hints.wrongQueryHints item=wrongQueryHint}
                        <li>{$wrongQueryHint}</li>
                    {/foreach}
                    </ul>
                {else}.
                {/if}
                <span class="text-button blue" onclick="getHelp('{$Lang}', {$QuestionID})">
                    <i class="icon icon-hint" aria-hidden="true"></i>
                    Usa la pista e intenta reescribirla.
                </span>
            </p>
        {/if}
        {if array_key_exists('multipleResults', $QueryTestResult.hints) }
            <p>Pista: Se devolvieron múltiples conjuntos de resultados. Se espera solo un conjunto de resultados.</p>
        {/if}
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>Pista: la consulta devuelve el error: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>Pista: la tabla de resultados debe constar de {$QueryTestResult.hints.columnsCount} columnas.</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>Pista: la tabla resultante debe constar de las siguientes columnas: {$QueryTestResult.hints.columnsList}.</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>Pista: el resultado debe contener {$QueryTestResult.hints.rowsCount} filas.</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>Pista: la fila {$QueryTestResult.hints.rowsData.rowNumber} de tu resultado es distinta de la esperada:</p>
            {include file='row_diff.tpl' RowDiff=$QueryTestResult.hints.rowsData}
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>Pista: tu consulta está vacía.</p>
        {/if}
     {/if}
     <div style="display: flex; flex-direction: column; align-items: flex-start; margin-top: 10px;">
        Intenta de nuevo.<br>
        <p style="display: flex; margin-top: 2em; column-gap: 6px; font-style: italic;">
            ¿Encontraste un error en la tarea?&nbsp;
            <a style="display: flex; column-gap: 6px; justify-content: center; align-items: center;" target="_blank" href="https://telegram.me/sqltest_online" class=""> 
                <span class="tg-icon">
                    <span class=""> </span>
                </span>
                ¡háznoslo saber!
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