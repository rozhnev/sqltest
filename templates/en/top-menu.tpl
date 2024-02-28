<div class="header">
    <div class="top-menu">
        {include file='site-name.tpl'}
        <a href="/en/donate/{$QuestionID}" target="_self" class="donate-btn shake" id="donate-btn">Donate</a>
        <div class="lang-swith"><a href="/ru/question/{$QuestionCategoryID}/{$QuestionID}" target="_self">RU</a></div>
        {if $Logged}
            <span class="login-button"><a href="/en/logout" target="_self">Logout</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">Login</span>
        {/if}
    </div>
</div>