{if !isset($SitePromo)}
    {assign var="SitePromo" value="{translate}site_promo{/translate}"}
{/if}
{if !isset($SiteDescription)}
    {assign var="SiteDescription" value="{translate}site_description{/translate}"}
{/if}
<div class="top-menu-left">
    {* <a href="/{$Lang}/" target="_self" style="display: flex;"> *}
        <h1 class="site-name-wrapper">
            <span class="site-name">SQLtest</span>
            <span class="site-promo">{$SitePromo}</span>
        </h1>
    {* </a> *}
    <div class="divider"></div>
</div>
<div class="top-menu-center">
    <span  class="site-description">{$SiteDescription}</span>
</div>
<div class="top-menu-buttons" style="min-width: 16rem;">
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
<div class="top-menu-switchers">
    {include file='lang-switcher.tpl'}
    {include file='theme-switcher.tpl'}
</div>