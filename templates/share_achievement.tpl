{assign var="PageTitle" value="{translate}share_achievement_page_title{/translate}"}
{assign var="PageDescription" value="{translate}share_achievement_page_description{/translate}"}
{assign var="PageOGTitle" value="{translate}share_achievement_og_title{/translate}"}

{* Make OG description informative + long enough for LinkedIn *}
{assign var="BaseOGDescription" value="{translate}share_achievement_og_description{/translate}"}
{if isset($ShareUserName) && $ShareUserName && isset($AchievementTitle) && $AchievementTitle}
    {assign var="PageOGDescription" value="{$ShareUserName|escape} unlocked “{$AchievementTitle|escape}” on SQLtest.online. {$BaseOGDescription}"}
{elseif isset($AchievementTitle) && $AchievementTitle}
    {assign var="PageOGDescription" value="Achievement unlocked: “{$AchievementTitle|escape}” on SQLtest.online. {$BaseOGDescription}"}
{else}
    {assign var="PageOGDescription" value=$BaseOGDescription}
{/if}

{* Add publication/updated time for LinkedIn cards *}
{if isset($PageOGPublishedTime) && $PageOGPublishedTime}
    <meta property="article:published_time" content="{$PageOGPublishedTime|escape}" />
{/if}

{if isset($ShareImageUrl) && $ShareImageUrl}
    {assign var="PageOGImage" value=$ShareImageUrl}
{else}
    {assign var="PageOGImage" value="https://sqltest.online/favicons/android-chrome-512x512.png"}
{/if}
{assign var="PageOGImageAlt" value="{$AchievementTitle}"}
{assign var="PageOGImageWidth" value="1200"}
{assign var="PageOGImageHeight" value="627"}
{include file='short-header.tpl'}
<style>
    .share-button-icon {
        display: inline-flex;
        width: 1rem;
        height: 1rem;
        align-items: center;
        justify-content: center;
    }

    .share-button-icon svg {
        width: 100%;
        height: 100%;
        fill: currentColor;
        display: block;
    }

    .share-button-label {
        display: inline-flex;
        align-items: center;
        gap: 0.35rem;
    }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/achievement/{$AchievementID}"}
            {else}
                {include file='top-menu.tpl' path="/achievement/{$AchievementID}"}
            {/if}
        </header>
        <main>
            {if $User->logged() && $User->getFullName() === ''}
                <div class="user-solutions-count" style="max-width: 1200px; margin: 16px auto; width: 1200px;">
                    {translate}update_profile_full_name{/translate}
                </div>
            {/if}
            {if isset($ImageUrl) && $ImageUrl}
                <div style="margin: 1rem 0; display: flex; justify-content: center;">
                    <img
                        src="{$ImageUrl|escape}"
                        alt="{$AchievementTitle|escape}"
                        loading="lazy"
                    />
                </div>
            {else}
                <div class="text-block" style="margin: 2rem auto; max-width: 700px;">
                    <h2 style="margin-top: 0;">{translate}share_achievement_heading{/translate}</h2>
                    <p style="margin: 0.5rem 0;">
                        <strong>{$ShareUserName}</strong>
                        {translate}share_achievement_earned{/translate}
                        <strong>{$AchievementTitle}</strong>
                        <span style="opacity: 0.8;">({$EarnedAt})</span>
                    </p>
                </div>
            {/if}
            {if $User->logged() && $AchievementUserID == $User->getId()}
                <div class="user-solutions-count" style="max-width: 1200px; margin: 16px auto; width: 1200px;">
                    {assign var="AchievementShareUrl" value=$SharePageUrl}
                    <div style="padding-top: 12px; border-top: 1px solid var(--text-block-border-color);">
                        <div style="font-weight: 700; margin-bottom: 10px;">{translate}share_your_achievement{/translate}</div>
                        {include file="{$Lang}/achievement_share_buttons.tpl" AchievementShareUrl=$AchievementShareUrl}
                    </div>
                </div>
            {/if}
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
