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
        {* <button class="button blue" onclick="location.href = '/{$Lang}/logout';"><span>{translate}top_menu_logout{/translate} ⎆</span></button> *}
        <div style="position: relative;" onclick="toggleAchievements('{$Lang}');">
            {if $User->haveNewAchievement()}
                <svg width="36" height="36" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg" style="cursor: pointer;">
                    <defs>
                        <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" style="stop-color:#FFD700;stop-opacity:1" />
                        <stop offset="100%" style="stop-color:#FF8C00;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <path d="M64 10 L81.87 52.63 L127 52.63 L90.5 80.88 L103.75 123 L64 100.5 L24.25 123 L37.5 80.88 L1 52.63 L46.13 52.63 Z" fill="url(#gradient)" stroke="#D4AF37" stroke-width="3"/>
                    <circle cx="64" cy="72" r="20" fill="white" />
                    <text x="64" y="80" font-size="24" font-weight="bold" text-anchor="middle" fill="#333">✓</text>
                </svg>
            {else}
                <svg width="36" height="36" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">
                    <path d="M64 10 L81.87 52.63 L127 52.63 L90.5 80.88 L103.75 123 L64 100.5 L24.25 123 L37.5 80.88 L1 52.63 L46.13 52.63 Z" fill="#A0A0A0" stroke="#808080" stroke-width="3"/>
                    <circle cx="64" cy="72" r="20" fill="#E0E0E0" />
                    <text x="64" y="80" font-size="24" font-weight="bold" text-anchor="middle" fill="#606060">✓</text>
                </svg>
            {/if}
            <div id="achievements-popup" class="achievements-popup hidden">
            </div>
        </div>
    {else}
        <button id="showLoginWindowBtn" class="button blue" onClick="toggleLoginWindow()">⎆ {translate}top_menu_login{/translate}</button>
    {/if}
</div>
<div class="top-menu-switchers">
    {include file='lang-switcher.tpl'}
    {include file='theme-switcher.tpl'}
</div>