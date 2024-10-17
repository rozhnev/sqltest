<div class="header">
    <div class="top-menu">
        {include file='site-name.tpl'}
        {include file='theme-switcher.tpl'}
        <a href="/{$Lang}/donate" target="_self" class="donate-btn shake" id="donate-btn">{translate}Donate{/translate}</a>
        <span class="lang-swith">
            {foreach $Languages as $l}
                {if ($l !== $Lang)}
                    <a href="/{$l}/question/{$QuestionCategoryID}/{$QuestionID}" target="_self">{$l|upper}</a>
                {/if}
            {/foreach}
        </span>
        {if $Logged}
            <span class="login-button"><a href="/{$Lang}/logout" target="_self">{translate}Logout{/translate}</a></span>
        {else}
            {* <span class="login-button" onClick="toggleLoginWindow()">Вход</span> *}
        {/if}
    </div>
</div>