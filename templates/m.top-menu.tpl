<div class="header">
    <div class="top-menu">
        <a href="/{$Lang}/" target="_self"><h1 class="site-name">SQLtest</h1></a>
        {include file='theme-switcher.tpl'}
        <a href="/{$Lang}/donate" target="_self" class="donate-btn shake" id="donate-btn">{translate}top_menu_donate{/translate}</a>
        {include file='lang-switcher.tpl'}
        {if $Logged}
            <span class="login-button"><a href="/{$Lang}/logout" target="_self">{translate}top_menu_logout{/translate}</a></span>
        {else}
            <span class="login-button" onClick="toggleLoginWindow()">{translate}top_menu_login{/translate}</span>
        {/if}
    </div>
</div>