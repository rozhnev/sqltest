{include file='../header.tpl'}
{include file='top-menu.tpl'}
{include file='menu.tpl'}
<div class="main">
    <div class="question-wrapper">
        <div class="question-title">Task:</div>
        <div class="question">
            {include file="questions/{$QuestionID}.tpl"}
        </div>
        <p class="question-action">
        Write your request in the field below and click the "Check it!" button. (If there is an error, you will have to review the ad unit)
        </p>
    </div>
    <div class="code-actions">
        <button onClick="copyCode(`SQL code copied to buffer`)">Copy code</button> <button onClick="clearEditor()">Clear editor</button>
    </div>
    <div class="code-wrapper" id="sql-code" name="sql-code"></div>
    <div class="code-buttons">
        <button class="button" onClick="getHelp('{$Lang}', '{$DB}', {$QuestionID})">Get help</button>
        <button class="button" onClick="runQuery('{$Lang}', '{$DB}', {$QuestionID})">Run query</button>
        <button class="button test" onClick="testQuery('{$Lang}', '{$DB}', {$QuestionID})">Check it!</button>
    </div>
    <div class="code-result" id="code-result"></div>
</div>

<div class="right">
    {include file="{$DB}.tpl"}
</div>
{include file='../footer.tpl'}
