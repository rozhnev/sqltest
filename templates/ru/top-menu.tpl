<div class="header">
    <div class="top-menu">
        <a href="/ru/" target="_self"><h1 class="site-name">SQLtest</h1><h3 class="site-promo"> - задачи по SQL</h3></a>
        <span  class="site-description">тест на знание SQL, написание запросов, подготовка к собеседованиям, практические задания, SQL для начинающих и продвинутых</span>
        <a href="/ru/donate/{$QuestionID}" target="_self" class="donate-btn shake" id="donate-btn">Donate</a>
        <span class="lang-swith"><a href="/en/question/{$QuestionCategoryID}/{$QuestionID}" target="_self">EN</a></span>
        {if $Logged}
            <span class="login-button"><a href="/ru/logout" target="_self">Выход</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">Вход</span>
        {/if}
    </div>
</div>