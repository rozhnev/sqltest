<div class="header">
    <div class="top-menu">
        <div class="top-menu-left" style="width: 19vw; display: flex; align-items: center;">
            <a href="/{$Lang}/" target="_self" style="width: 20vw; display: flex;">
                <h1 class="site-name-wrapper">
                    <span class="site-name">SQLtest: </span>
                    <span class="site-promo">{translate}site_promo{/translate}</span>
                </h1>
            </a>
        </div>
        <div class="top-menu-center" style="width: 55vw; display: flex;">
            <span  class="site-description">
                {translate}site_description{/translate}
            </span>
        </div>
        <div class="top-menu-right" style="width: 25vw; display: flex; justify-content: space-between; padding-right: 18px;">
            {include file='theme-switcher.tpl'}
            <div style="display: flex; min-width: 90px; margin: 12px; align-items: center; justify-content: center;">
                <a href="/{$Lang}/donate" target="_self" class="donate-btn shake" id="donate-btn">{translate}top_menu_donate{/translate}</a>
            </div>
            {include file='lang-switcher.tpl'}
            {if $Logged}
                <span class="login-button"><a href="/{$Lang}/logout" target="_self">{translate}top_menu_logout{/translate}</a></span>
            {else}
                {* <span class="login-button" onClick="toggleLoginWindow()">Login</span> *}
            {/if}
        </div>
    </div>
</div>