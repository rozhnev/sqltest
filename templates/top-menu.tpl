<div class="top-menu-left">
    <a href="/{$Lang}/" target="_self" style="display: flex;">
        <h1 class="site-name-wrapper">
            <span class="site-name">SQLtest</span>
            <span class="site-promo">
                {if $Action === 'question'}
                    {if isset($Question.answers)}
                        {translate}site_promo_question_quiz{/translate}
                    {else}
                        {translate}site_promo_question_task{/translate}
                    {/if}
                {elseif $Action === 'test'}
                    {translate}site_promo_test{/translate}
                {else}
                    {translate}site_promo{/translate}
                {/if}
            </span>
        </h1>
    </a>
    <div class="divider"></div>
</div>
<div class="top-menu-center">
    <span  class="site-description">
        {if $Action === 'question'}
            {if isset($Question.answers)}
                {translate}site_description_question_quiz{/translate}
            {else}
                {translate}site_description_question_task{/translate}
            {/if}
        {elseif $Action === 'test'}
            {translate}site_description_test{/translate}
        {else}
            {translate}site_description{/translate}
        {/if}
    </span>
</div>
<div class="top-menu-buttons">
    <a href="/{$Lang}/donate" target="_self" id="donate-btn">
        <button class="button green"><span>{translate}top_menu_donate{/translate}</span></button>    
    </a>
    {if $User->logged()}
        <button class="button blue" onclick="location.href = '/ru/logout';"><span>{translate}top_menu_logout{/translate} ⎆</span></button>
    {else}
        <button id="showLoginWindowBtn" class="button blue" onClick="toggleLoginWindow()">⎆ {translate}top_menu_login{/translate}</button>
    {/if}
</div>
<div class="top-menu-switchers">
    {include file='lang-switcher.tpl'}
    {include file='theme-switcher.tpl'}
</div>