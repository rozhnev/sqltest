<div class="header">
    <div class="top-menu">
        <a href="/ru/" target="_self"><h1 class="site-name">SQLtest</h1><h3 class="site-promo"> - место, где вы можете бесплатно пройти тест на знание SQL</h3></a>
        <a href="/ru/donate/{$QuestionID}" target="_self" class="donate-btn shake" id="donate-btn">Donate</a>
        <span class="lang-swith"><a href="/en/question/{$QuestionCategoryID}/{$QuestionID}" target="_self">EN</a></span>
        {if $Logged}
            <span class="login-button"><a href="/ru/question/{$QuestionCategoryID}/{$QuestionID}/logout" target="_self">Выход</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">Вход</span>
        {/if}
    </div>
</div>