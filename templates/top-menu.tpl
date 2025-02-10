<div class="header">
    <div class="top-menu">
        <div class="top-menu-left" style="min-width: 12.5vw; display: flex; align-items: center; justify-content: space-between;">
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
        <div class="top-menu-center" style="display: flex;">
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
        <div class="top-menu-right" style="min-width: 15vw; display: flex; justify-content: space-between; align-items: center;">
            <a href="/{$Lang}/donate" target="_self" id="donate-btn">
                <button class="button green" >{translate}top_menu_donate{/translate}</button>    
            </a>
            {if $User->logged()}
                <button class="button blue" onclick="location.href = '/ru/logout';">{translate}top_menu_logout{/translate}</button>
            {else}
                <button class="button blue" onClick="toggleLoginWindow()">{translate}top_menu_login{/translate}</button>
            {/if}
        </div>
        <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; row-gap: 0.7em;">
            {include file='lang-switcher.tpl'}
            {include file='theme-switcher.tpl'}
        </div>
    </div>
</div>