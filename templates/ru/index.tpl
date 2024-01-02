{include file='../header.tpl'}
{include file='top-menu.tpl'}
{include file='../menu.tpl'}
<script>
    var lang = '{$Lang}';
    var db = '{$DB}';
</script>
<div class="main">
    <div class="question-wrapper">
        <div class="question-title">Задание:
            <span class="question-navigate">
                <a href="" title="Предыдущее задание"><i class="arrow arrow-left"></i></a>    
                <a href="" title="Следующее задание"><i class="arrow arrow-right"></i></a>
            </span>
        </div>
        <div class="question">
            {include file="questions/{$QuestionID}.tpl"}
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
    <div class="code-wrapper" id="sql-code" name="sql-code"></div>
    <div class="code-buttons">
        <button class="button" onClick="getHelp('{$Lang}', '{$DB}', {$QuestionID})">Помощь</button>
        <button class="button" onClick="runQuery('{$Lang}', '{$DB}', {$QuestionID})">Выполнить</button>
        <button class="button test" onClick="testQuery('{$Lang}', '{$DB}', {$QuestionID})">Проверить!</button>
        <button class="button test hidden" onClick="testQuery('{$Lang}', '{$DB}', {$QuestionID})">Далее</button>
    </div>
    <div class="code-result" id="code-result"></div>
</div>

<div class="right">
    {include file="{$DB}.tpl"}
</div>
{include file='../footer.tpl'}
