{include file='header.tpl'}
{include file='menu.tpl'}
<div class="main">
    <div class="question">
        {include file='question_1.tpl'}
    </div>
    <div class="code-wrapper" id="sql-code" name="sql-code"></div>
    <div class="code-buttons">
        <button class="button">Get help</button>
        <button class="button">Run query</button>
        <button class="button">Test it!</button>
    </div>
    <div class="code-result"></div>
</div>

<div class="right">
    {include file='sakila.tpl'}
</div>
{include file='footer.tpl'}
