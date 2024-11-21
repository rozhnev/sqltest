<div class="header">
    <div class="top-menu">
        <div class="top-menu-left" style="width: 19vw; display: flex; align-items: center;">
            <a href="/{$Lang}/" target="_self" style="width: 20vw; display: flex;">
                <h1 class="site-name-wrapper">
                    <span class="site-name">SQLtest: </span>
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
        </div>
        <div class="top-menu-center" style="width: 55vw; display: flex;">
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
        <div class="top-menu-right" style="width: 25vw; display: flex; justify-content: space-between; padding-right: 18px;">
            {include file='theme-switcher.tpl'}
            <div style="display: flex; min-width: 90px; margin: 12px; align-items: center; justify-content: center;">
                <a href="/{$Lang}/donate" target="_self" class="donate-btn shake" id="donate-btn">{translate}top_menu_donate{/translate}</a>
            </div>
            {include file='lang-switcher.tpl'}
        </div>
    </div>
</div>