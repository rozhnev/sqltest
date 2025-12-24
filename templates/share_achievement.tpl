{assign var="PageTitle" value="{translate}share_achievement_page_title{/translate}"}
{assign var="PageDescription" value="{translate}share_achievement_page_description{/translate}"}
{assign var="PageOGTitle" value="{translate}share_achievement_og_title{/translate}"}
{assign var="PageOGDescription" value="{translate}share_achievement_og_description{/translate}"}
{include file='short-header.tpl'}
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/share/achievement"}
            {else}
                {include file='top-menu.tpl' path="/share/achievement"}
            {/if}
        </header>
        <main>
            <div class="text-block" style="margin: 2rem auto; max-width: 700px;">
                <h2 style="margin-top: 0;">{translate}share_achievement_heading{/translate}</h2>
                <p style="margin: 0.5rem 0;">
                    <strong>{$ShareUserName}</strong>
                    {translate}share_achievement_earned{/translate}
                    <strong>{$AchievementTitle}</strong>
                    <span style="opacity: 0.8;">({$EarnedAt})</span>
                </p>
                <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
                    <a class="button blue" target="_blank" rel="noopener noreferrer" href="{$LinkedinShareUrl}">
                        <span>{translate}share_to_linkedin{/translate}</span>
                    </a>
                    <a class="button" target="_self" href="/{$Lang}/user/profile"><span>{translate}profile_page_title{/translate}</span></a>
                </div>
                <div style="margin-top: 0.75rem; font-size: small; opacity: 0.85;">
                    {translate}share_achievement_note{/translate}
                </div>
            </div>
        </main>
        <footer>
            {if $MobileView}
                {include file='m.footer.tpl'}
            {else}
                {include file='footer.tpl'}
            {/if}
        </footer>
    </div>
</body>
</html>
