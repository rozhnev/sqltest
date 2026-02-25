{if !isset($SitePromo)}
    {assign var="SitePromo" value="{translate}site_promo{/translate}"}
{/if}
{if !isset($SiteDescription)}
    {assign var="SiteDescription" value="{translate}site_description{/translate}"}
{/if}
<div class="top-menu-left">
    {* <a href="/{$Lang}/" target="_self" style="display: flex;"> *}
        <h1 class="site-name-wrapper">
            <span class="site-name">SQLtest.online</span>

            {* <span class="site-promo">{$SitePromo}</span> *}
        </h1>
        <h2>
            <a href="/{$Lang}/" target="_self" style="display: flex; align-items: center; gap: 4px; font-size: 0.75em;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="6" cy="6" r="2"></circle>
                    <circle cx="6" cy="12" r="2"></circle>
                    <circle cx="6" cy="18" r="2"></circle>
                    <line x1="6" y1="8" x2="6" y2="10"></line>
                    <line x1="6" y1="14" x2="6" y2="16"></line>
                    <line x1="12" y1="6" x2="20" y2="6"></line>
                    <line x1="12" y1="12" x2="20" y2="12"></line>
                    <line x1="12" y1="18" x2="20" y2="18"></line>
                </svg>
                {translate}practice{/translate}
            </a>
        </h2>
        <h2>
            <a href="/{$Lang}/lesson/getting-started/introduction-to-databases" target="_self" style="display: flex; align-items: center; gap: 4px; font-size: 0.75em;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                    <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                </svg>
                {translate}lessons{/translate}
            </a>
        </h2>
        <h2>
            <a href="/{$Lang}/test/start" target="_self" style="display: flex; align-items: center; gap: 4px; font-size: 0.75em;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="3" width="18" height="18" rx="2"></rect>
                    <polyline points="9 12 11 14 15 10"></polyline>
                </svg>
                {translate}test{/translate}
            </a>
        </h2>
    {* </a> *}
    {* <div class="divider"></div> *}
</div>
{* <div class="top-menu-center">
    <span  class="site-description">{$SiteDescription}</span>
</div> *}
<div class="top-menu-buttons" style="min-width: 16rem;">
    {include file='theme-switcher.tpl'}
    {include file='lang-switcher.tpl'}
    <a href="/{$Lang}/donate" target="_self" id="donate-btn">
        <button class="button green"><span>{translate}top_menu_donate{/translate}</span></button>    
    </a>
    {if $User->logged()}
        <div style="position: relative;" onclick="toggleAchievements('{$Lang}');">
            {$GradeColors = [''=>null,'Intern'=>'#3F3F3F','Junior'=>'#00FF00','Middle'=>'#0000FF','Senior'=>'#FF0000']}
            {assign var="GradeColor" value="{$GradeColors[$User->grade()]}"|default:'#FFFFFF'}
            <div class="button green" style="padding: 0; display: flex; align-items: center; justify-content: center;">
                <svg width="36" height="36" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="32" cy="22" r="10" fill="#FFFFFF"/>
                    <path d="M32 40C20 40 10 48 10 58H54C54 48 44 40 32 40Z" fill="{$GradeColor}"/>
                </svg>
            </div>
            <div id="achievements-popup" class="achievements-popup hidden" style="right: 5px;">
            </div>
        </div>
    {else}
        <button style="position: relative;" id="showLoginWindowBtn" class="button blue" onClick="toggleLoginWindow()">
            ⎆ {translate}top_menu_login{/translate}
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