{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['¡Genial! Has completado la tarea!', 'Para guardar tu progreso, por favor <a href="" onClick="toggleLoginWindow(); return false;">inicia sesión</a>.'],
        ['¡Increíble! Has terminado la tarea!', 'Para mantener tu progreso a salvo, <a href="" onClick="toggleLoginWindow(); return false;">simplemente inicia sesión ahora</a>.'],
        ['¡Lo lograste! ¡Bien hecho!', 'Para asegurarte de que tu increíble trabajo esté guardado, <a href="" onClick="toggleLoginWindow(); return false;">simplemente inicia sesión</a>.'],
        ['¡Felicidades por terminar la tarea!', '<a href="" onClick="toggleLoginWindow(); return false;">Inicia sesión</a> ahora para guardar tu progreso.'],
        ['¡Eres genial! ¡Has terminado!', 'No olvides <a href="" onClick="toggleLoginWindow(); return false;">iniciar sesión</a> para mantener todo tu progreso a salvo. 😎']
    ] }
    <p>{$phrases[$phrase_id][0]}</p>
    {if !$User->logged()}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <div class="question-rate-panel">
        <div style="min-width:280px; flex: 2 1; margin-bottom: 9px 0;">Antes de comenzar la siguiente prueba, por favor califica la dificultad de esta tarea:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Demasiado fácil" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Demasiado fácil</label>
                <input type="radio" id="rate2" name="question_rate" value="Simple" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simple</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difícil" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difícil</label>
                <input type="radio" id="rate5" name="question_rate" value="Muy difícil" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Muy difícil</label>
            </div>
        </div>
    {/if}
{else}
    {assign var="phrases" value=[
        ['No es eso, ¡pero sigue pensando! Intenta de nuevo.'],
        ['No del todo, ¡pero no te rindas! Intenta de nuevo.'],
        ['Intentemos un enfoque diferente.'],
        ['Casi, pero no del todo. ¡Intenta de nuevo!'],
        ['Intentemos eso de nuevo. ¡Estás casi allí!']
    ]}
    {$phrases[$phrase_id][0]}
    <p>¿Error en la tarea? <a target="_blank" href="https://telegram.me/sqlize">¡Reporta! Lo solucionaremos 😊</a></p>
{/if}
{if isset($ReferralLink)}
    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
        <div class="referral-link">
            {$ReferralLink.content}
        </div>
    </a>
{/if}