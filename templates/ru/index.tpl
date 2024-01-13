{include file='../header.tpl'}
{include file='top-menu.tpl'}
{include file='../menu.tpl'}
<script>
    var lang = '{$Lang}';
    var db = '{$DB}';
</script>
<div class="splitter">
    <a href="" onClick="return toggleInfoPanel();" title="Toggle panel">
        ⯈
    </a>
    <a href="" class="hidden" onClick="return toggleInfoPanel();" title="Toggle panel">
        ⯇
    </a>
</div>
<div class="main">
    <div class="question-wrapper">
        <div class="question-title">Задание {$Question.number}:
            <span class="question-dates">
                {if $Question.solved_date}
                    Решено: {$Question.solved_date}
                {elseif $Question.last_attempt_date}
                    Последняя попытка: {$Question.last_attempt_date}
                {/if}
            </span>
            <span class="question-navigate">
                {if $PreviousQuestionId}
                    <a href="/{$Lang}/{$DB}/{$PreviousQuestionId}" title="Предыдущее задание"><i class="arrow arrow-left"></i></a>
                {/if}
                {if $NextQuestionId}
                    <a href="/{$Lang}/{$DB}/{$NextQuestionId}" title="Следующее задание"><i class="arrow arrow-right"></i></a>
                {/if}
            </span>
        </div>
        <div class="question">
            {$Question.task}
        </div>
        <p class="question-action">
            Напишите свой запрос в поле ниже и нажмите кнопку "Проверить!" (В случае ошибки вам придется просмотреть рекламный блок)
        </p>
        <p class="question-action">
            Для написания используйте синтаксис MySQL. Описания таблиц приведены в правой панели. 
        </p>
    </div>
    <div class="code-actions">
        <button onClick="copyCode(`Код SQL скопирован в буфер`)">Копировать код</button> <button onClick="clearEditor()">Очистить редактор</button>
    </div>
    <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
    <div class="code-buttons">
        <button class="button" onClick="getHelp('{$Lang}', '{$DB}', {$QuestionID})">Помощь</button>
        <button class="button" onClick="runQuery('{$Lang}', '{$DB}', {$QuestionID})">Выполнить</button>
        <button class="button test" onClick="testQuery('{$Lang}', '{$DB}', {$QuestionID})">Проверить!</button>
        {if $NextQuestionId}
            <a href="/{$Lang}/{$DB}/{$NextQuestionId}" title="Следующее задание" class="button test hidden">Далее</a>
        {/if}
    </div>
    <div class="code-result" id="code-result"></div>
</div>

<div class="right">
    {include file="{$DB}.tpl"}
</div>
{include file='../footer.tpl'}
