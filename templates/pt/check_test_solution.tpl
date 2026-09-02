{if $QueryTestResult.ok}
    {assign var="successPhrases" value=[
        "Consulta excelente!",
        "Muito bem! Esta tarefa foi concluída perfeitamente!",
        "Você está indo muito bem, continue assim!",
        "Ótimo resultado!",
        "Bom trabalho — continue brilhando!"
    ]}
    {assign var="successIndex" value=$successPhrases|@array_rand}
    {assign var="successPhrase" value=$successPhrases[$successIndex]}
    <style>
        .qts-celebration { position: relative; padding: 1.25rem 1.5rem 1rem; border-radius: 1rem; background: radial-gradient(circle at 25% -10%, rgba(255,255,255,.85), rgba(255,255,255,0) 55%), linear-gradient(135deg, var(--text-block-background-color, #fff), var(--block-background-color, #466cbd) 70%); border: 1px solid var(--border-color, #0B4FCC); color: var(--question-text, #33196f); box-shadow: 0 15px 38px rgba(29,7,74,.18); overflow: hidden; margin-bottom: 1rem; }
        .qts-message { font-size: 1.35rem; font-weight: 700; color: inherit; }
        .qts-message-glimmer { display: inline-flex; margin-left: .5rem; animation: qts-glimmer 2.8s ease-in-out infinite; color: var(--achievement-linkedin-fg, #f7b733); }
        .qts-confetti { position: absolute; inset: 0; pointer-events: none; }
        .qts-confetti-piece { position: absolute; top: -20px; width: 8px; height: 18px; border-radius: 3px; background: var(--color, #ffd166); animation: qts-confetti-drop var(--duration, 2.4s) linear infinite; animation-delay: var(--delay, 0s); left: var(--x-start, 10%); }
        @keyframes qts-confetti-drop { 0% { transform: translate3d(0,0,0) rotate(0); opacity: 1; } 100% { transform: translate3d(var(--x-end, 60px),280px,0) rotate(360deg); opacity: 0; } }
        @keyframes qts-glimmer { 0%,100% { opacity: .4; transform: scale(.9); } 50% { opacity: 1; transform: scale(1.1); } }
        .qts-badge { display: inline-flex; margin-top: .5rem; padding: .25rem .75rem; border-radius: 999px; border: 1px solid var(--border-color, #0B4FCC); background: var(--text-block-background-color, rgba(255,255,255,.85)); color: var(--question-text, #4b2d9f); font-size: .85rem; font-weight: 600; }
        .qts-error-card { position: relative; overflow: hidden; margin-bottom: 1rem; padding: 1.25rem 1.5rem; border: 1px solid var(--border-color, #0B4FCC); border-radius: 1rem; background: linear-gradient(200deg, rgba(251,125,125,.3), rgba(173,48,64,.55)); color: var(--regular-text-color, #f0f6fc); box-shadow: 0 18px 42px rgba(77,9,16,.35); }
        .qts-error-body { position: relative; z-index: 1; }
        .qts-error-message { color: var(--accordion-hover-border, #F0F6FC); font-size: 1.3rem; font-weight: 700; }
        .qts-error-hints { margin-top: .8rem; color: var(--question-text, #f0f6fc); line-height: 1.4; }
        .qts-error-hints p { margin: .3rem 0; }
        .qts-error-cta { margin-top: .6rem; color: var(--accordion-active, #006EF5); font-weight: 600; }
        .qts-error-referral { margin-top: .85rem; }
        .qts-error-referral .referral-link { padding: .7rem 1.1rem; border: 1px dashed rgba(255,255,255,.5); border-radius: .75rem; background: rgba(255,255,255,.07); text-align: center; }
    </style>
    <div class="qts-celebration">
        <div class="qts-message">{$successPhrase}<span class="qts-message-glimmer">✨</span></div>
        <div class="qts-badge">Tarefa concluída</div>
        <div class="qts-confetti" aria-hidden="true">
            <span class="qts-confetti-piece" style="--x-start:5%;--x-end:40px;--delay:0s;--color:#ff6262"></span>
            <span class="qts-confetti-piece" style="--x-start:25%;--x-end:-20px;--delay:.25s;--color:#f7b733"></span>
            <span class="qts-confetti-piece" style="--x-start:45%;--x-end:60px;--delay:.45s;--color:#2ecc71"></span>
            <span class="qts-confetti-piece" style="--x-start:65%;--x-end:-50px;--delay:.15s;--color:#3498db"></span>
            <span class="qts-confetti-piece" style="--x-start:85%;--x-end:30px;--delay:.35s;--color:#1abc9c"></span>
        </div>
    </div>
    <div style="display:flex; flex-flow:row; flex-wrap:wrap; line-height:1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex:2 1;">O custo de execução da sua consulta é {$QueryTestResult.cost} <span style="font-size:small;">(quanto menor o custo, mais eficaz é a consulta)</span>
            {if $QueryBestCost}<br>Custo da melhor solução: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Parabéns! Sua consulta está entre as melhores do nosso site!
                {elseif $QueryBestCost > $QueryTestResult.cost} Parabéns por melhorar nosso recorde!
                {else} Infelizmente, o resultado ficou um pouco abaixo do recorde. Há espaço para melhorar! {/if}
            {/if}</div>
        {/if}
        {if array_key_exists('answerResult', $QueryTestResult)}
            <p>A resposta enviada será avaliada pelo júri.</p>
        {/if}
    </div>
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('maxAttemptsReached', $QueryTestResult.hints)}
    {assign var="NextQuestion" value="{$QueryTestResult.nextQuestion}"}
    {translate}maximum_attempts_reached{/translate}{if $QueryTestResult.nextQuestion} {translate}go_to_next_task{/translate}{/if}
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('timeOut', $QueryTestResult.hints)}
    {translate}test_time_out{/translate} {translate}go_to_rate{/translate}
{else}
    {assign var="errorPhrases" value=[
        "Tente novamente — um pequeno ajuste pode trazer uma grande vitória!",
        "Quase lá! Ajuste a consulta e ela ficará perfeita.",
        "Você está perto — tente mais uma vez!",
        "Um pequeno ajuste e você acertará em cheio.",
        "Boa tentativa — faça uma pequena alteração e execute novamente."
    ]}
    {assign var="errorIndex" value=$errorPhrases|@array_rand}
    {assign var="errorPhrase" value=$errorPhrases[$errorIndex]}
    <div class="qts-error-card" role="status" aria-live="polite">
        <div class="qts-error-body">
            <div class="qts-error-message">{$errorPhrase}</div>
            {if array_key_exists('hints', $QueryTestResult)}
                <div class="qts-error-hints">
                    {if array_key_exists('queryError', $QueryTestResult.hints)}<p>Dica: a consulta gera o erro: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>{/if}
                    {if array_key_exists('columnsCount', $QueryTestResult.hints)}<p>Dica: a tabela resultante deve conter {$QueryTestResult.hints.columnsCount} colunas.</p>{/if}
                    {if array_key_exists('columnsList', $QueryTestResult.hints)}<p>Dica: a tabela resultante deve conter as seguintes colunas: {$QueryTestResult.hints.columnsList}.</p>{/if}
                    {if array_key_exists('rowsCount', $QueryTestResult.hints)}<p>Dica: o resultado deve conter {$QueryTestResult.hints.rowsCount} linhas.</p>{/if}
                    {if array_key_exists('rowsData', $QueryTestResult.hints)}<p>Dica: a linha número {$QueryTestResult.hints.rowsData.rowNumber} deve conter os valores: {$QueryTestResult.hints.rowsData.rowTable}</p><p>Seu resultado: {$QueryTestResult.hints.rowsData.resultTable}</p>{/if}
                    {if array_key_exists('emptyQuery', $QueryTestResult.hints)}<p>Dica: sua consulta está vazia.</p>{/if}
                </div>
            {/if}
            <div class="qts-error-cta">Continue — você está quase lá.</div>
            {if isset($ReferralLink)}<div class="qts-error-referral"><a id="referral-link" target="_blank" href="{$ReferralLink.link}"><div class="referral-link">{$ReferralLink.content}</div></a></div>{/if}
        </div>
    </div>
{/if}
