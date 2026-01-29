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
                <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center; justify-content: center;">
                    {if isset($LinkedinShareUrl) && $LinkedinShareUrl}
                        <a class="button blue" target="_blank" rel="noopener noreferrer"
                           href="{$LinkedinShareUrl}">
                            <span class="share-button-label">
                                <span class="share-button-icon" aria-hidden="true">
                                    <svg viewBox="0 0 24 24" role="img" aria-label="LinkedIn logo">
                                        <path d="M5.5 7.5h-3V18.5h3V7.5zM4 5.5C3.17 5.5 2.5 6.2 2.5 7c0 .81.67 1.5 1.5 1.5S5.5 7.81 5.5 7c0-.81-.67-1.5-1.5-1.5zM9.5 18.5h3V13c0-.81.06-1.84 1.25-1.84 1.21 0 1.23 1.05 1.23 1.9v5.44h3V12c0-3.07-1.63-4.25-3.26-4.25-1.5 0-2.18.78-2.56 1.33h.04V7.5h-3c.04 1.06 0 11 0 11z" />
                                    </svg>
                                </span>
                                <span>{translate}share_to_linkedin{/translate}</span>
                            </span>
                        </a>
                    {/if}

                    {if isset($FacebookShareUrl) && $FacebookShareUrl}
                        <a class="button" target="_blank" rel="noopener noreferrer"
                           style="background:#1877F2; border-color:#1877F2;"
                           href="{$FacebookShareUrl}">
                            <span class="share-button-label">
                                <span class="share-button-icon" aria-hidden="true">
                                    <svg viewBox="0 0 24 24" role="img" aria-label="Facebook logo">
                                        <path d="M19 2.5H5C3.62 2.5 2.5 3.62 2.5 5v14c0 1.38 1.12 2.5 2.5 2.5h7V14.5h-2v-3h2V9c0-2 1.2-3 3-3 0.86 0 1.14.06 1.34.09v2.52h-1.5c-1.17 0-1.4.56-1.4 1.38v1.78h2.8l-.37 3h-2.43V22h4.77c1.38 0 2.5-1.12 2.5-2.5V5C21.5 3.62 20.38 2.5 19 2.5Z" />
                                    </svg>
                                </span>
                                <span>{translate}share_to_facebook{/translate}</span>
                            </span>
                        </a>
                    {/if}

                    {* {if isset($VKShareUrl) && $VKShareUrl}
                        <a class="button" target="_blank" rel="noopener noreferrer"
                           style="background:#0077FF; border-color:#0077FF;"
                           href="{$VKShareUrl}">
                            <span>{translate}share_to_vk{/translate}</span>
                        </a>
                    {/if} *}
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
