<div class="header">
    <div class="top-menu">
        {include file='site-name.tpl'}
        {include file='../theme-switcher.tpl'}
        <a href="/ru/donate" target="_self" class="donate-btn shake" id="donate-btn">Donate</a>
        <span class="lang-swith"><a href="/en/question/{$QuestionCategoryID}/{$QuestionID}" target="_self">EN</a></span>
        {if $Logged}
            <span class="login-button"><a href="/ru/logout" target="_self">Выход</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">Вход</span>
        {/if}
    </div>
</div>