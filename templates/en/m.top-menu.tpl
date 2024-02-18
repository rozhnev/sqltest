<div class="header">
    <div class="top-menu">
        <a href="/en/" target="_self"><h1 class="site-name">SQLtest</h1></a>
        <a href="/en/donate/{$QuestionID}" target="_self" class="donate-btn shake" id="donate-btn">Donate</a>
        <div class="lang-swith"><a href="/ru/{$DB}/{$QuestionID}" target="_self">RU</a></div>
        {if $Logged}
            <span class="login-button"><a href="/en/{$DB}/{$QuestionID}/logout" target="_self">Logout</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">Login</span>
        {/if}
    </div>
</div>