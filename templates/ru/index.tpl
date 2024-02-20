{include file='../header.tpl'}
<body>
<div class="container">
    {include file='popups.tpl'}
    {include file='top-menu.tpl'}
    {include file='../menu.tpl'}
    {include file='../splitter.tpl'}
    <div class="main">
        <div class="question-wrapper">
            <div class="question-title">
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
                        <a href="/{$Lang}/{$Question.db_template}/{$PreviousQuestionId}" title="Предыдущее задание"><i class="arrow arrow-left"></i></a>
                    {/if}
                    {if $NextQuestionId}
                        <a href="/{$Lang}/{$Question.db_template}/{$NextQuestionId}" title="Следующее задание"><i class="arrow arrow-right"></i></a>
                    {/if}
                </span>
            </div>
            <div class="question">
                {$Question.task}
            </div>
            <p class="question-action">
                Напишите свой запрос в поле ниже и нажмите кнопку "Проверить!"{* (В случае ошибки вам придется просмотреть рекламный блок) *}
            </p>
            <p class="question-action">
                Для написания используйте синтаксис {$Question.dbms}. Описания таблиц приведены в правой панели. 
            </p>
        </div>
        <div class="code-actions">
            <button onClick="copyCode(`Код SQL скопирован в буфер`)">Копировать код</button> <button onClick="clearEditor()">Очистить редактор</button>
        </div>
        <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
        <div class="code-buttons">
            <button class="button" id="getHelpBtn" onClick="getHelp('{$Lang}', '{$DB}', {$QuestionID})">Помощь</button>
            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', '{$DB}', {$QuestionID})" title="CTRL+Enter">Выполнить запрос</button>
            <button class="button test" id="testQueryBtn" onClick="testQuery('{$Lang}', '{$DB}', {$QuestionID})">Проверить!</button>
            {if $NextQuestionId}
                <a href="/{$Lang}/{$DB}/{$NextQuestionId}" title="Следующее задание" class="button test hidden">Далее</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>

    <div class="right">
        {include file="{$DB}.tpl"}
    </div>
    {include file='../footer.tpl'}
