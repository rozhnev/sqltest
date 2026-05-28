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
    .share-page-section {
        max-width: 1200px;
        width: 100%;
        margin: 16px auto;
        padding: 0 12px;
    }

    .share-achievement-media {
        margin: 1rem 0;
        display: flex;
        justify-content: center;
        padding: 0 12px;
    }

    .share-achievement-media img {
        width: auto;
        max-width: min(1200px, 100%);
        height: auto;
        display: block;
        border-radius: 8px;
    }

    .share-achievement-card {
        margin: 2rem auto;
        max-width: 700px;
        padding: 0 12px;
    }

    .share-achievement-card h2 {
        margin-top: 0;
    }

    .share-achievement-card p {
        margin: 0.5rem 0;
        line-height: 1.5;
    }

    .share-achievement-date {
        opacity: 0.8;
    }

    .share-achievement-actions {
        padding-top: 12px;
        border-top: 1px solid var(--text-block-border-color);
    }

    .share-achievement-actions-title {
        font-weight: 700;
        margin-bottom: 10px;
    }

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

    @media (max-width: 768px) {
        .share-page-section {
            margin: 12px auto;
            padding: 0 10px;
        }

        .share-achievement-media {
            margin: 0.75rem 0;
            padding: 0 10px;
        }

        .share-achievement-media img {
            border-radius: 6px;
        }

        .share-achievement-card {
            margin: 1rem auto;
            padding: 0 10px;
        }
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
                <div class="user-solutions-count share-page-section">
                    {translate}update_profile_full_name{/translate}
                </div>
            {/if}
            {if isset($ImageUrl) && $ImageUrl}
                <div class="share-achievement-media">
                    <img
                        src="{$ImageUrl|escape}"
                        alt="{$AchievementTitle|escape}"
                        loading="lazy"
                    />
                </div>
            {else}
                <div class="text-block share-achievement-card">
                    <h2>{translate}share_achievement_heading{/translate}</h2>
                    <p>
                        <strong>{$ShareUserName}</strong>
                        {translate}share_achievement_earned{/translate}
                        <strong>{$AchievementTitle}</strong>
                        <span class="share-achievement-date">({$EarnedAt})</span>
                    </p>
                </div>
            {/if}
            {if $User->logged() && $AchievementUserID == $User->getId()}
                <div class="user-solutions-count share-page-section">
                    {assign var="AchievementShareUrl" value=$SharePageUrl}
                    <div class="share-achievement-actions">
                        <div class="share-achievement-actions-title">{translate}share_your_achievement{/translate}</div>
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
