{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['Super ! Vous avez terminé la tâche !', 'Pour enregistrer vos progrès, veuillez vous <a href="" onClick="toggleLoginWindow(); return false;">connecter</a>.'],
        ['Génial ! Vous avez fini la tâche !', 'Pour conserver vos progrès en sécurité, <a href="" onClick="toggleLoginWindow(); return false;">connectez-vous maintenant</a>.'],
        ['Vous l\'avez fait ! Bravo !', 'Pour être sûr que votre excellent travail soit sauvegardé, <a href="" onClick="toggleLoginWindow(); return false;">connectez-vous simplement</a>.'],
        ['Félicitations pour avoir terminé la tâche !', '<a href="" onClick="toggleLoginWindow(); return false;">Connectez-vous</a> maintenant pour enregistrer vos progrès.'],
        ['Vous assurez ! C\'est fini !', 'N\'oubliez pas de vous <a href="" onClick="toggleLoginWindow(); return false;">connecter</a> pour conserver tous vos progrès sains et saufs. 😎']
    ] }
    <p>{$phrases[$phrase_id][0]}</p>
    {if !$User->logged()}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <div class="question-rate-panel">
        <div style="min-width:280px; flex: 2 1; margin-bottom: 9px 0;">Avant de commencer le test suivant, veuillez évaluer la difficulté de cette tâche :</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Too easy" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Trop facile</label>
                <input type="radio" id="rate2" name="question_rate" value="Simple" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simple</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difficult" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difficile</label>
                <input type="radio" id="rate5" name="question_rate" value="Very hard" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Très difficile</label>
            </div>
        </div>
    {/if}
{else}
    {assign var="phrases" value=[
        ['Ce n\'est pas tout à fait ça, mais continuez à réfléchir ! Réessayez.'],
        ['Pas tout à fait, mais n\'abandonnez pas ! Réessayez.'],
        ['Essayons une approche différente.'],
        ['Presque, mais pas tout à fait. Réessayez !'],
        ['Essayons encore une fois. Vous y êtes presque !']
    ]}
    {$phrases[$phrase_id][0]}
    <p>Erreur dans la tâche ? <a target="_blank" href="https://t.me/sqlize">Signalez-le ! Nous corrigerons cela 😊</a></p>
{/if}
{if isset($ReferralLink)}
    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
        <div class="referral-link">
            {$ReferralLink.content}
        </div>
    </a>
{/if}
