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
{if isset($PageOGModifiedTime) && $PageOGModifiedTime}
    <meta property="article:modified_time" content="{$PageOGModifiedTime|escape}" />
    <meta property="og:updated_time" content="{$PageOGModifiedTime|escape}" />
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
                    <a class="button blue" target="_blank" rel="noopener noreferrer" href="{$LinkedinShareUrl}">
                        <span>{translate}share_to_linkedin{/translate}</span>
                    </a>
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
