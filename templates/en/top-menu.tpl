<div class="header">
    <div class="top-menu">
        <a href="/en/" target="_self"><h1 class="site-name">SQLtest</h1><h3 class="site-promo"> - place where you can test your SQL knowledge for free</h3></a>
        <a href="/en/donate/{$QuestionID}" target="_self" class="donate-btn shake" id="donate-btn">Donate</a>
        <div class="lang-swith"><a href="/ru/question/{$QuestionCategoryID}/{$QuestionID}" target="_self">RU</a></div>
        {if $Logged}
            <span class="login-button"><a href="/en/question/{$QuestionCategoryID}/{$QuestionID}/logout" target="_self">Logout</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">Login</span>
        {/if}
    </div>
</div>