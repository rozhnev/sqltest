{include file='../header.tpl'}
<body>
<div class="mobile-container">
    {include file='popups.tpl'}
    {include file='m.top-menu.tpl'}
    {include file='../m.menu.tpl'}
    <div class="main">
        <div class="question-wrapper" id="question-wrapper">
            <div class="question-title">
                <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Еще не оценено'}"></div>
                Задание {$Question.number}:
                {if $LoggedAsAdmin}
                    <a href="/admin/question/{$NextQuestionId}" title="Edit" style="color:#333">&#9998;</a>
                {/if}
                <span class="question-dates">
                    {if $Question.solved_date}
                        Решено: {$Question.solved_date}
                    {elseif $Question.last_attempt_date}
                        Последняя попытка: {$Question.last_attempt_date}
                    {/if}
                </span>
                <span class="question-navigate">
                    {if $PreviousQuestionId}
                        <a href="/{$Lang}/question/{$Question.category_sef}/{$PreviousQuestionId}#question-wrapper" title="Предыдущее задание"><i class="arrow arrow-left"></i></a>
                    {/if}
                    {if $NextQuestionId}
                        <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}#question-wrapper" title="Следующее задание"><i class="arrow arrow-right"></i></a>
                    {/if}
                </span>
            </div>
            <div class="question">
                {$Question.task}
            </div>
            {if isset($Question.answers)}
                <div class="question">
                {foreach $Question.answers as $answer}
                    <div class="answer">
                        <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}" {if $answer.id|in_array:$Question.last_query} checked{/if}>
                        <label for="answer-{$answer.id}"> {$answer.answer}</label>
                    </div>
                {/foreach}
                </div>
                <p class="question-action">
                    Отметьте ВСЕ правильные ответы и нажмите кнопку «Проверить!»
                </p>
            {else}
                <p class="question-action">
                    Напишите свой запрос в поле ниже и нажмите кнопку «Проверить!»{* (В случае ошибки вам придется просмотреть рекламный блок) *}
                </p>
                <p class="question-action">
                    Для написания используйте синтаксис {$Question.dbms}.<br>
                    Описания таблиц приведены внизу экрана. 
                </p>
            {/if}
        </div>
        {if !isset($Question.answers)}
            <div class="code-actions">
                <button onClick="copyCode(`Код SQL скопирован в буфер`)">Копировать код</button> <button onClick="clearEditor()">Очистить редактор</button>
            </div>
            <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
        {/if}
        <div class="code-buttons">
            <button class="button" id="getHelpBtn" onClick="getHelp('{$Lang}', {$QuestionID})">Помощь</button>
            {if !isset($Question.answers)}
                <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="CTRL+Enter">Выполнить запрос</button>
                <button class="button green" id="testQueryBtn" onClick="testQuery('{$Lang}', {$QuestionID})">Проверить!</button>
            {else}
                <button class="button green" id="checkAnswersBtn" onClick="checkAnswers('{$Lang}', {$QuestionID})">Проверить!</button>
            {/if}
            {if $NextQuestionId}
                <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="Следующее задание" class="button green hidden">Далее</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>
    <div class="right">
        {include file="{$DB}.tpl"}
    </div>
    {include file='m.footer.tpl'}
