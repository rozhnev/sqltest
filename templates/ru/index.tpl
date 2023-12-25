{include file='../header.tpl'}
{include file='top-menu.tpl'}
{include file='menu.tpl'}
<script>
    var lang = '{$Lang}';
    var db = '{$DB}';
</script>
<div class="main">
    <div class="question">
        <p>Задание:</p>
        {include file="questions/{$QuestionID}.tpl"}
        <p>
        Напишите свой запрос в поле ниже и нажмите кнопку "Проверить!" (В случае ошибки вам придется просмотреть рекламный блок)
        </p>
    </div>
    <div class="code-wrapper" id="sql-code" name="sql-code"></div>
    <div class="code-buttons">
        <button class="button" onClick="getHelp('{$Lang}', '{$DB}', {$QuestionID})">Помощь</button>
        <button class="button" onClick="runQuery('{$Lang}', '{$DB}', {$QuestionID})">Выполнить</button>
        <button class="button" onClick="testQuery('{$Lang}', '{$DB}', {$QuestionID})">Проверить!</button>
    </div>
    <div class="code-result" id="code-result"></div>
</div>

<div class="right">
    {include file="{$DB}.tpl"}
</div>
{include file='../footer.tpl'}
