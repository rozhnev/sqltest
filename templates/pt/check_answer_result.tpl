{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['Excelente! Completou a tarefa!', 'Para guardar o seu progresso, <a href="" onClick="toggleLoginWindow(); return false;">login</a>.'],
        ['Fantástico! Concluiu a tarefa!', 'Para manter o seu progresso seguro, <a href="" onClick="toggleLoginWindow(); return false;">basta iniciar sessão agora</a>.'],
        ['Conseguiste! Muito bem!', 'Para garantir que o seu trabalho incrível é guardado, <a href="" onClick="toggleLoginWindow(); return false;">basta fazer login</a>.'],
        ['Parabéns por terminar a tarefa!', '<a href="" onClick="toggleLoginWindow(); return false;">Faça login</a> agora para guardar o seu progresso.'],
        ['És demais! Pronto!', 'Não se esqueça de <a href="" onClick="toggleLoginWindow(); return false;">iniciar sessão</a> para manter todo o seu progresso são e salvo. 😎']
    ] }
    <p>{$phrases[$phrase_id][0]}</p>
    {if !$User->logged()}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <div class="question-rate-panel">
            <div style="min-width:280px; flex: 2 1; margin-bottom: 9px 0;">Antes de iniciar o teste seguinte, avalie a dificuldade desta tarefa:</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="Muito fácil" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">Muito fácil</label>
                <input type="radio" id="rate2" name="question_rate" value="Simples" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">Simples</label>
                <input type="radio" id="rate3" name="question_rate" value="Normal" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">Normal</label>
                <input type="radio" id="rate4" name="question_rate" value="Difícil" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">Difícil</label>
                <input type="radio" id="rate5" name="question_rate" value="Muito difícil" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">Muito difícil</label>
            </div>
        </div>
    {/if}
{else}
    {assign var="phrases" value=[
        ['Não é isso, mas continue a pensar! Tente novamente.'],
        ['Não propriamente, mas não desista! Tente novamente.'],
        ['Vamos tentar uma abordagem diferente.'],
        ['Quase, mas não exatamente. Tente novamente!'],
        ['Vamos tentar outra vez. Está quase lá!']
    ]}
    {$phrases[$phrase_id][0]}
    <p>Erro na tarefa? <a target="_blank" href="https://t.me/sqlize">Relatório! Nós vamos arranjar 😊</a></p>
{/if}
{if isset($ReferralLink)}
    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
        <div class="referral-link">
            {$ReferralLink.content}
        </div>
    </a>
{/if}