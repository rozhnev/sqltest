<div class="top-menu-left" style="width: 25vw; display: flex; align-items: center; position: relative;">
    <a href="/{$Lang}/" target="_self"><h1 class="site-name">SQLtest</h1></a>
    <div id="achievements-popup" class="achievements-popup hidden"></div>
</div>
<div class="top-menu-buttons mobile">
    <a href="/{$Lang}/donate" target="_self" id="donate-btn" style="display: block; margin-right: 2.5rem;">
        <button class="button green">
            <div style="width: 100%; padding: 5px;">$</div>
        </button>
    </a>
    {if $User->logged()}
        {* <button class="button blue" onclick="location.href = '/ru/logout';">
            <div style="width: 100%; padding: 5px;">⎆</div>
        </button> *}
        <div style="position: relative;" onclick="toggleAchievements('{$Lang}');">
            {$GradeColors = [''=>null,'Intern'=>'#3F3F3F','Junior'=>'#00FF00','Middle'=>'#0000FF','Senior'=>'#FF0000']}
            {assign var="GradeColor" value="{$GradeColors[$User->grade()]}"|default:'#FFFFFF'}
            <div class="button green" style="padding: 0; display: flex; align-items: center; justify-content: center;">
                <svg width="36" height="36" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="32" cy="22" r="10" fill="#FFFFFF"/>
                    <path d="M32 40C20 40 10 48 10 58H54C54 48 44 40 32 40Z" fill="{$GradeColor}"/>
                </svg>
            </div>
        </div>
    {else}
        <button  style="position: relative;" id="showLoginWindowBtn" class="button blue" onClick="toggleLoginWindow()">
            <div style="width: 100%; padding: 5px;">⎆</div>
            <div id="login-menu" class="login-menu hidden">
                <div>
                    <span class="login-popup-title">{translate}choose_login_method{/translate}:</span>
                </div>
                {include file='login-buttons.tpl'}
                <div style="font-size: x-small; text-align: left;">
                    {translate}login_popup_footer{/translate}
                </div>
            </div>
        </button>
    {/if}
</div>
<div class="top-menu-switchers">
    {include file='lang-switcher.tpl'}
    {include file='theme-switcher.tpl'}
</div>