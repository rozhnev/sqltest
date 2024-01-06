<div class="header">
    <div class="top-menu">
        <h1 class="site-name">SQLtest</h1><h3 class="site-promo"> - место, где вы можете бесплатно проверить свои знания SQL</h3>
        <a href="/en/donate/{$QuestionID}" target="_self" class="donate-btn shake" id="donate-btn">Donate</a>
        <span class="lang-swith"><a href="/en/{$DB}/{$QuestionID}" target="_self">EN</a></span>
        {if $Logged}
            <span class="login-button"><a href="/ru/{$DB}/{$QuestionID}/logout" target="_self">Logout</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">Login</span>
        {/if}
    </div>
</div>