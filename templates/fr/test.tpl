{include file='../header.tpl'}
<body>
<div class="container">
    {include file='popups.tpl'}
    {include file='top-menu.tpl'}
    <div class="menu" id="menu">
        <div id="test-timer" style="padding:5px 15px; border: 1px solid white; margin: 5px;"><span style="font-size:small;">Le temps pour terminer ce test est de</span> <span id="test-timer-time"></span></div>
        <script>
            const showTimer = ()=>{ldelim}
                const time = Math.floor((new Date('{$Question.closed_at}') - new Date())/60000);
                if (time > 0) {
                    document.getElementById('test-timer-time').innerText = time + ' ' + (time>1 ? 'minutes': 'minute');
                } else {
                    document.getElementById('test-timer').innerText = 'Le temps du test est écoulé !'
                }
            {rdelim};
            showTimer();
            setInterval(showTimer,  60000);
        </script>
        <div id="menu-content" class="menu-content">
            {foreach $Questionnire.menu as $categoryId => $panel}
            <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
                {$panel.title}
            </button>
            <div class="panel {if $categoryId eq $QuestionCategoryID}active{/if}">
                <ol>
                {foreach $panel.questions as $question}
                <li>
                    <a class="question-link {if $QuestionID == $question[1]} current-question{/if}{if $question[2]} solved{/if}" href="/{$Lang}/test/{$TestId}/{$question[1]}">
                        {$question[0]}
                    </a>
                </li>
                {/foreach}
                </ol>
            </div>
            {/foreach}
        </div>
        <div style="display: flex;   align-items: center; justify-content: center; margin-top: 1em;">
            <button class="button green" id="doneTest" onClick="doneTest('{$TestId}')">J'ai terminé ! Afficher mon résultat</button>
        </div>
    </div>
    {include file='../splitter.tpl'}
    <div class="main">
        <div class="question-wrapper">
            <div class="question-title-bar" style="display: flex;">
                <div class="question-title">
                    <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Pas encore évalué'}"></div>
                    Tâche&nbsp;{$Question.number} :
                    {if $User->isAdmin()}
                        <a href="/admin/question/{$NextQuestionId}" title="Modifier" style="color:#333">&#9998;</a>
                    {/if}
                    <span class="question-dates">
                        {if $Question.solved_date}
                            Résolu le : {$Question.solved_date}
                        {elseif $Question.last_attempt_date}
                            Date de la dernière tentative : {$Question.last_attempt_date}
                        {/if}
                    </span>
                </div>
                {if $Question.previous_question_id}
                    <div class="question-navigate" style="border-right: 1px solid var(--text-block-border-color);">
                        <a href="/{$Lang}/test/{$TestId}/{$Question.previous_question_id}" title="Tâche précédente"><i class="arrow arrow-left"></i></a>
                    </div>
                {/if}
                {if $Question.next_question_id}
                    <div class="question-navigate">
                        <a href="/{$Lang}/test/{$TestId}/{$Question.next_question_id}" title="Tâche suivante"><i class="arrow arrow-right"></i></a>
                    </div>
                {/if}
            </div>
            <div class="question">
                {$Question.task}
            </div>
            {if isset($Question.answers)}
                <div class="answers" id="answers-list">
                {foreach $Question.answers as $answer}
                    <div class="answer">
                        <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}" {if $answer.id|in_array:$Question.last_query} checked{/if}>
                        <label for="answer-{$answer.id}"> {$answer.answer}</label>
                    </div>
                {/foreach}
                </div>
                <p class="question-action">
                    Cochez TOUTES les bonnes réponses et cliquez sur le bouton "Vérifier !"
                </p>
            {else}
                <p class="question-action">
                    Écrivez votre requête dans le champ ci-dessous et cliquez sur le bouton "Vérifier !".
                </p>
                <p class="question-action">
                    Pour écrire la réponse, utilisez la syntaxe {$Question.dbms}. Les descriptions des tables sont données dans le panneau de droite.
                </p>
            {/if}
        </div>
        {if !isset($Question.answers)}
        <div class="code-actions">
            <button onClick="copyCode(`Code SQL copié dans le presse-papiers`)">Copier le code</button> <button onClick="clearEditor()">Effacer l'éditeur</button>
        </div>
        <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
        {/if}
        <div class="code-buttons">
            {if !isset($Question.answers)}
                <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="CTRL+Entrée">Exécuter la requête</button>
            {/if}
            {if {$Question.possible_attempts} > 0}
                <button class="button green" id="checkSolutionBtn" onClick="checkSolution('/{$Lang}/test/{$TestId}/check/{$QuestionID}')">Vérifier ! ({$Question.possible_attempts})</button>
            {/if}
            {if $Question.next_question_id}
                <a href="/{$Lang}/test/{$TestId}/{$Question.next_question_id}" title="Tâche suivante" class="button green hidden">Suivant</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>

    <div class="right" id="right-panel">
        {include file="{$DB}.tpl"}
    </div> 
    {include file='footer.tpl'}
