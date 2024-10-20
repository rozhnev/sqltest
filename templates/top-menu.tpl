<div class="header">
    <div class="top-menu">
        {include file='site-name.tpl'}
        {include file='theme-switcher.tpl'}
        <a href="/{$Lang}/donate" target="_self" class="donate-btn shake" id="donate-btn">{translate}top_menu_donate{/translate}</a>
        {include file='lang-switcher.tpl' path="/question/{$QuestionCategoryID}/{$QuestionID}"}
        {if $Logged}
            <span class="login-button"><a href="/{$Lang}/logout" target="_self">{translate}top_menu_logout{/translate}</a></span>
        {else}
            {* <span class="login-button" onClick="toggleLoginWindow()">Login</span> *}
        {/if}
    </div>
</div>