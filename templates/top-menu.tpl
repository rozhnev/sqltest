<div class="header">
    <div class="top-menu">
        <a href="/{$Lang}/" target="_self" style="width: 20vw; display: flex;">
            <h1 class="site-name-wrapper">
                <span class="site-name">SQLtest: </span>
                <span class="site-promo">{translate}site_promo{/translate}</span>
            </h1>
        </a>    
        <span  class="site-description">
            {translate}site_description{/translate}
        </span>
        <div style="display: flex; flex-direction: row; justify-content: space-between;">
            {include file='theme-switcher.tpl'}
            <div style="display: flex; justify-content: center; min-width: 120px; padding-top: 12px;">
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